using AnimationInstance.Scripts;
using Unity.Entities;
using Unity.Rendering;
using UnityEngine;

namespace AnimationInstance.Ecs
{
    [MaterialProperty("_AnimationType")]//, MaterialPropertyFormat.Float)]
    public struct AnimationTypeComponent : IComponentData
    {
        public float Value;
    }

    
    public class AnimationTypeComponentAuthoring : MonoBehaviour
    {
        public float Value;
        
        class Baker : Baker<AnimationTypeComponentAuthoring>
        {
            public override void Bake(AnimationTypeComponentAuthoring authoring)
            {
                AddComponent(new AnimationTypeComponent { Value = authoring.Value });
            }
        }
    }
}
