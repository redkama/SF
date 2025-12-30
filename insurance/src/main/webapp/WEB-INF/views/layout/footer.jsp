</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // 삭제 confirm 공용
  function confirmDelete(formId) {
    if (confirm("정말 삭제하시겠습니까?")) {
      document.getElementById(formId).submit();
    }
  }
</script>
</body>
</html>
