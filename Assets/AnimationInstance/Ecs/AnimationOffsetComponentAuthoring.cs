using Unity.Entities;
using Unity.Rendering;
using UnityEngine;

namespace AnimationInstance.Ecs
{
    [MaterialProperty("_AnimOffset")]//, MaterialPropertyFormat.Float)]
    public struct AnimationOffsetComponent : IComponentData
    {
        public float Value;
    }

    public class AnimationOffsetComponentAuthoring : UnityEngine.MonoBehaviour
    {
        public float Value;
        
        class Baker : Baker<AnimationOffsetComponentAuthoring>
        {
            public override void Bake(AnimationOffsetComponentAuthoring authoring)
            {
                AddComponent(new AnimationOffsetComponent { Value = authoring.Value });
            }
        }
    }
}
