using UnityEngine;

[RequireComponent(typeof(Renderer))]
public class OnHoverOutlineAndRotation : MonoBehaviour
{
    [SerializeField] private Material m_border = null;
    private Material m_defaultMaterial = null;
    private Renderer m_objectRenderer = null;

    // Start is called before the first frame update
    void Start()
    {
        m_objectRenderer = GetComponent<Renderer>();
        m_defaultMaterial = m_objectRenderer.material;
    }
    
    private void OnMouseEnter()
    {
        m_objectRenderer.material = m_border;
    }

    private void OnMouseExit()
    {
        m_objectRenderer.material = m_defaultMaterial;
    }

    private void OnMouseOver()
    {
        float dt = Time.deltaTime;
        transform.Rotate
        (
            dt * Random.Range(0.5f, 15.0f),
            dt * Random.Range(0.5f, 15.0f),
            dt * Random.Range(0.5f, 15.0f),
            Space.Self
        );
    }
}
