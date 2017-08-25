using UnityEngine;

public class Waves : MonoBehaviour {

    private MeshFilter meshFilter;
    private Vector3[] wavedVertices;
    private MeshCollider collider;

    [SerializeField(), Range(0f, 1f)]
    public float waveHeight;

    [SerializeField(), Range(0f, 5f)]
    public float waveSpeed;

    public void Start ()
    {
        meshFilter = GetComponent<MeshFilter>();
        collider = GetComponent<MeshCollider>();
		wavedVertices = meshFilter.mesh.vertices;
	}

    public void Update ()
    {
		for (int i = 0; i < wavedVertices.Length; i++)
		{
			wavedVertices[i] = new Vector3(
                meshFilter.mesh.vertices[i].x,
                meshFilter.mesh.vertices[i].y + Mathf.Sin((i + Time.time) * waveSpeed) * waveHeight - meshFilter.mesh.vertices[i].y,
				meshFilter.mesh.vertices[i].z
			);
		}
		meshFilter.mesh.vertices = wavedVertices;
		meshFilter.mesh.RecalculateBounds();
		meshFilter.mesh.RecalculateNormals();
		collider.sharedMesh = meshFilter.mesh;
	}
}
