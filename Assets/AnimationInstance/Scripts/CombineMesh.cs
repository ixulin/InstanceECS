using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class CombineMesh
{
    //[MenuItem("Assets/Combine SubMesh")]
    //static void Combine()
    //{
    //    var mesh = Selection.activeObject as Mesh;
    //    if (mesh != null)
    //    {
    //        CombineInstance[] combines = new CombineInstance[mesh.subMeshCount];
    //        for (int i = 0; i < mesh.subMeshCount; i++)
    //        {
    //            combines[i].mesh = mesh.GetSubMesh(i).;
    //            combines[i].transform = Quaternion.identity;
    //            combines[i].subMeshIndex = i;
    //        }


    //        var cbMesh = new Mesh();

    //        cbMesh.CombineMeshes(combines, true);

    //        AssetDatabase.CreateAsset(cbMesh, "Assets/GenMesh/");
    //    }
    //}
}
