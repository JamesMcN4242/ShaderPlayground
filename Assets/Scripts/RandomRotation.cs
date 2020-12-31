using UnityEngine;

public class RandomRotation : MonoBehaviour
{
    private void Update()
    {
        RandomlyRotate();
    }

    void RandomlyRotate()
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
