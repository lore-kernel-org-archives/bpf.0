Received: from mta1.migadu.com (out-220.mta1.migadu.com [95.215.58.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2F35C188
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039061; cv=none; b=JnNBvlVvkp2/ugYsS5yD2tWPsc/PPzITiMjTHznJQN8TKSSiwhuEurMSMj0y6A+XkQ42f1Z932U2bEmhVvs7U1hBjBAgE3eqCEn4F+6lDtD14q2pz4hzlWuy6BFCe9Ow7AQDpS3on0Hq1XWZMYTVusfeQVyJ0A39pPc2Uk5CXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039061; c=relaxed/simple;
	bh=B4IgAJFaBDe7+AnJdyCtufdv++YTnIeHzExnz5tpDk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1ZQPxZLjox8PeVfS6Kax6lJE74bUdm+BGdgtdf7CyZMHkXOvV/LLppS5HM0IN/inKF4bVm7/DqL6rIVdsl142xhwl39RK4vmfDdBj2doOLxWoEEERdDnGyX2SV7UUa59XFV5lmM3uJk9oRXR0NVIp+87u2006TwIt9KSMoqFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e82zZil2; arc=none smtp.client-ip=95.215.58.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e82zZil2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B4IgAJFaBDe7+AnJdyCtufdv++YTnIeHzExnz5tpDk0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790039057; v=1; x=1790643857;
 b=e82zZil2PDhMKHEUK6gQWojxup4iHvokOTFuHyzaFSVjYNeoDq5CHUyxgr7EhsLM8KKEYt8s
 PO+aNg/92GWAXW74SrqtqN/CB4Hh3bnfrrSgg+9iTQqWg63GiOY0CKTGq2tHNwsI6SSuuOB33kr
 W7hACsRE+kX/LtwbvK+J9x/8=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id fb8fc81bfb4299fe;
	Tue, 22 Sep 2026 01:04:17 +0000
X-Mizu-Trace-ID: fb8fc81bfb4299fe
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 5/6] bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
Date: Mon, 21 Sep 2026 18:03:32 -0700
Message-ID: <20260922010333.1226537-6-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_for_each_array_elem() passes the callback the address of a u32 held
in its own stack frame:

	u32 i, key, num_elems = 0;
	...
		key = i;
		ret = callback_fn((u64)(long)map, (u64)(long)&key, ...);

The callback can store that PTR_TO_MAP_KEY into callback_ctx and the
program can dereference it after the iteration finishes. Loads through
PTR_TO_MAP_KEY are not fault-protected and array key_size is fixed at 4,
so it is a four-byte read-only leak of kernel stack.

Declare the key frame-scoped for the array map ops rather than in the
shared map_set_for_each_callback_args(): of the map_for_each_callback
implementations, only array and percpu-array pass a key from their own
frame. The hash family passes elem->key, which stays valid for as long
as the program runs.

map_key_from_value() does the same for array maps, for the timer, wq and
task_work callbacks. Those are left alone: their signature is
(map, key, value) with R4 and R5 uninitialised, so there is no
callback_ctx to park a typed pointer in, and a pointer written into map
memory loses its type.

The element value is unaffected in every case: it lives until map
teardown.

The frame-owned reference consumes an id, so leak_prog and nested_cb now
report id 5 rather than id 4; update the expected messages.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/arraymap.c                          | 18 ++++++++++++++++--
 .../testing/selftests/bpf/prog_tests/cb_refs.c |  4 ++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0ce26b538075..44bd229873ca 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -855,6 +855,20 @@ static u64 array_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
+static int array_map_set_for_each_callback_args(struct bpf_verifier_env *env,
+						struct bpf_func_state *caller,
+						struct bpf_func_state *callee)
+{
+	int err;
+
+	err = map_set_for_each_callback_args(env, caller, callee);
+	if (err)
+		return err;
+
+	mark_frame_scoped_arg(callee, BPF_REG_2);
+	return 0;
+}
+
 BTF_ID_LIST_SINGLE(array_map_btf_ids, struct, bpf_array)
 const struct bpf_map_ops array_map_ops = {
 	.map_meta_equal = array_map_meta_equal,
@@ -875,7 +889,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
 	.map_update_batch = generic_map_update_batch,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_set_for_each_callback_args = array_map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
@@ -900,7 +914,7 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
 	.map_update_batch = generic_map_update_batch,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_set_for_each_callback_args = array_map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
index c32c6dab49bc..645f065c21f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -12,8 +12,8 @@ struct {
 	const char *err_msg;
 } cb_refs_tests[] = {
 	{ "underflow_prog", "R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_" },
-	{ "leak_prog", "Unreleased reference id=4 alloc_insn=3" }, /* alloc_insn=3{2,3} */
-	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
+	{ "leak_prog", "Unreleased reference id=5 alloc_insn=3" }, /* alloc_insn=3{2,3} */
+	{ "nested_cb", "Unreleased reference id=5 alloc_insn=2" }, /* alloc_insn=2{4,5} */
 	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
 };
 
-- 
2.55.0

