using AnimationInstance.Ecs;
using Unity.Collections;
using Unity.Entities;
using Unity.Rendering;
using Unity.Transforms;

namespace AnimationInstance.Scripts
{
    [UpdateInGroup(typeof(BakingSystemGroup))]
    public partial class AnimationGameConvert : SystemBase
    {
        protected override void OnUpdate()
        {
            UnityEngine.Debug.Log("convert system");
            var DstEntityManager = World.DefaultGameObjectInjectionWorld.EntityManager;
            var query = DstEntityManager.CreateEntityQuery(
                typeof(RenderMesh),
                typeof(Parent));
            var entities = query.ToEntityArray(Allocator.Persistent);
            foreach (var entity in entities)
            {
                var render = DstEntityManager.GetSharedComponentManaged<RenderMesh>(entity);
                //render.receiveShadows = false;
                DstEntityManager.SetSharedComponentManaged(entity, render);

                var parent = DstEntityManager.GetComponentData<Parent>(entity);
                if (DstEntityManager.HasComponent<AnimationTypeComponent>(parent.Value))
                {
                    var animation = DstEntityManager.GetComponentData<AnimationTypeComponent>(parent.Value);
                    var offset = DstEntityManager.GetComponentData<AnimationOffsetComponent>(parent.Value);
                    DstEntityManager.AddComponentData(entity, animation);
                    DstEntityManager.AddComponentData(entity, offset);
                }
            }
            entities.Dispose();
        }
    }
}
