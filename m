Received: from mta1.migadu.com (out-112.mta1.migadu.com [95.215.58.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74A5013D9
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577716; cv=none; b=adOxY2fc5oBT7ZfUi+A2Cl9Tq5NXLzJR0UfHq0zKA7c/p+F+6/oixA0YW1vCZJPzn6kr357ncb2Oz+S5hy+W6jN7yJdfoQRLVkTRnaNnDZ05DxeBQdYn5lJcGB6yn/VygFWSt5HhrHOiy2ClZRZSQv5S2rOIyQWdrM/6+edFu84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577716; c=relaxed/simple;
	bh=Z/pnQxaO0ZsDQbWqF4dfR/oPgnGmum+cqmjOqjzJDc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sq72cRE//1F5b/Fr4kgggkOF7HCAm8RZ3RJYvpR7xDlpH5MERV1LBMwOMfWT3t4qXhbAqaR2qeQ9LZcZ8mn0PPzbIlLhel7FVb/YB4W3P0CxeFsBWxEpui99uHb9d0vwvXGy8ugYWijYpEU6TYaH+fSVyBA9jvPSgKcCqssqbe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qvUd8ZIn; arc=none smtp.client-ip=95.215.58.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qvUd8ZIn"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z/pnQxaO0ZsDQbWqF4dfR/oPgnGmum+cqmjOqjzJDc0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577710; v=1; x=1792182510;
 b=qvUd8ZInFipgIX5umrsV2EEtWgyj476uh5/8kvmTOCx0BX/hsHoDLkupXZ9DLMEeY39y2DCK
 zVShJRs6+ht6Ia2y7yptt01UhKhkx0PUIe6k7+wgJci1BN8L9VsESqIuQEe9uUTyEnMVAF3FsYH
 qUmSyc/BDb+ZszIP7q9SwaRo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fd81eeedee0a48e4;
	Fri, 09 Oct 2026 20:28:30 +0000
X-Mizu-Trace-ID: fd81eeedee0a48e4
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
Subject: [PATCH bpf-next v2 04/11] bpf: Separate reference removal from descendant invalidation
Date: Fri,  9 Oct 2026 13:27:51 -0700
Message-ID: <20261009202759.50520-5-ihor.solodrai@linux.dev>
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

Reference release removes a program-owned reference and invalidates all
values derived from it in one operation.

Frame-owned values will need the same descendant walk without object
release semantics. Separate the walk from reference removal and pass its
diagnostic reason explicitly. Keep object-reference removal and the
existing release reason in release_reference().

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 62b991f3c39a..88b86f658e4a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10668,8 +10668,9 @@ static int idstack_pop(struct bpf_idmap *idmap)
 	return idmap->map[--idmap->cnt].old;
 }
 
-/* Release id and objects derived from it iteratively in a DFS manner */
-static int release_reference(struct bpf_verifier_env *env, int id)
+/* Invalidate id and values derived from it iteratively in a DFS manner. */
+static int invalidate_reference(struct bpf_verifier_env *env, int id,
+				enum bpf_diag_mod_reason reason)
 {
 	u32 mask = (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
 	struct bpf_verifier_state *vstate = env->cur_state;
@@ -10684,11 +10685,6 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	if (err)
 		return err;
 
-	if (find_reference_state(vstate, id)) {
-		err = release_reference_nomark(env, id);
-		WARN_ON_ONCE(err);
-	}
-
 	while ((id = idstack_pop(idstack))) {
 		/*
 		 * Child references are inaccessible after parent is released,
@@ -10724,14 +10720,12 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 
 				if (reg->dynptr.first_slot)
 					dyn_stack--;
-				bpf_diag_record_scrub(env, &dyn_stack[0].spilled_ptr,
-						      BPF_DIAG_MOD_REF_RELEASE);
-				bpf_diag_record_scrub(env, &dyn_stack[1].spilled_ptr,
-						      BPF_DIAG_MOD_REF_RELEASE);
+				bpf_diag_record_scrub(env, &dyn_stack[0].spilled_ptr, reason);
+				bpf_diag_record_scrub(env, &dyn_stack[1].spilled_ptr, reason);
 				invalidate_dynptr(env, dyn_stack);
 				continue;
 			}
-			bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_REF_RELEASE);
+			bpf_diag_record_scrub(env, reg, reason);
 			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL)
 				mark_reg_invalid(env, reg);
 		}));
@@ -10740,6 +10734,17 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	return 0;
 }
 
+static int release_reference(struct bpf_verifier_env *env, int id)
+{
+	int err;
+
+	if (find_reference_state(env->cur_state, id)) {
+		err = release_reference_nomark(env, id);
+		WARN_ON_ONCE(err);
+	}
+	return invalidate_reference(env, id, BPF_DIAG_MOD_REF_RELEASE);
+}
+
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *unused;
-- 
2.56.0

