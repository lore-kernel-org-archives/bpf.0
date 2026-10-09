Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EF501F45
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577738; cv=none; b=P1/8UD6Gzg0ue6rHq2RW6gvl/0UpG83h7eavdFY4IY5j85vUDQesoZmBhOupKkF7EAarUeyxQf2Vu4LwuiQMhsxzu2tppPS8U3tQC6uUv3K4cuV0PyAsbMoHRBpnwW/THnr9DLVmwpd3ygJOMX4JaEZTUyWfNpqrIfenp8hiehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577738; c=relaxed/simple;
	bh=1yL3Z2OLKbyYnjZa62IL5GKkqDdD1ltLx9OpUVvOYQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAy8s8cpHphWrrikif5h6zNUzJcmDQVdNX45kTrkd4Kl+vSPi0Tk8GZaP00gnXoMZXe/AFhnRUNgG/9BMWghKGVWMolYLBSSyjuLZtxzh+DHx/yoG/Oeb+NLR0KFIQNwQJfx2Ki2o/XAdZB/t0a7EpNY/F2Vt9FTJsK8koUL5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e/VOB+5l; arc=none smtp.client-ip=95.215.58.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e/VOB+5l"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1yL3Z2OLKbyYnjZa62IL5GKkqDdD1ltLx9OpUVvOYQ8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577734; v=1; x=1792182534;
 b=e/VOB+5l/bRBUSMjeDMF8I70LdW41IJXggMN4OVbKEgCvdYGNgmn+j77pr6YXFR+Oe64lFm/
 YZrO1HdUkZ2M4MmN47LI21xcO47JtdOv/ZTgVwTKN2l9WGj3JQG449nelTKUc67PkOj9xKOffCk
 FjxRDFP4j1/RArVf4IyZUKZY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d2d9d0e243bb2c79;
	Fri, 09 Oct 2026 20:28:54 +0000
X-Mizu-Trace-ID: d2d9d0e243bb2c79
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
Subject: [PATCH bpf-next v2 10/11] bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
Date: Fri,  9 Oct 2026 13:27:57 -0700
Message-ID: <20261009202759.50520-11-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009202759.50520-1-ihor.solodrai@linux.dev>
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_for_each_map_elem() passes array and per-CPU array callbacks the
address of a key on the helper's stack.

A callback can save that pointer in its context and dereference it
after the helper returns. Loads through PTR_TO_MAP_KEY are not
fault-protected, allowing a four-byte read-only leak of reused kernel
stack.

The verifier tracks the pointer's type and key size, but does not tie
its lifetime to the callback invocation.

Anchor R2 to a frame reference in the array map callback setup so the
key and its copies are invalidated on callback return. Leave hash keys
and map values unchanged, since their storage is not callback-local.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/arraymap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0fe9afd4a591..5e8669e311b6 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -855,6 +855,20 @@ static u64 array_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
+static int array_map_set_for_each_callback_args(struct bpf_verifier_env *env,
+						struct bpf_verifier_state *state,
+						struct bpf_func_state *caller,
+						struct bpf_func_state *callee)
+{
+	int err;
+
+	err = map_set_for_each_callback_args(env, state, caller, callee);
+	if (err)
+		return err;
+
+	return mark_frame_scoped_arg(env, state, callee, BPF_REG_2);
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
-- 
2.56.0

