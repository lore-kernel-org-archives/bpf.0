Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2E209F43;
	Sat, 11 Jul 2026 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747483; cv=none; b=DFRo0B6f6Eicx6iEFspmZ87cbotpZVyQJvS1KL5ID4fhf50wSsuRFBJe2HwE9khz5v4hRoikL824ipI2UUOaoZS2xF+/ygZNmDCjne+NagZWupl+2EFWBp54VoyLdVjJvDQDnYQ2boJnHUWx33n1RmPBTQdZCtV6jTS6fZ+dMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747483; c=relaxed/simple;
	bh=cfv46CjdLZIW2w16XmE9uZr663U1grMRQ6XojQ6IbtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPtVe7SararyT0Ae0YGC1iD414Xjwua7VC1hqAPSqTUHJHj1yeaPmPsSWbmlc2toJFHz86BtdMpeiwE7BksQEBOzZzSPqIPbaz43wtp4uDoF+9ZnUezo3ZKDQkLiK91bLBU4tRxHRU28oOv2UxG5adI7vEhywJwCYVFxnO4Kl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gxxvZ34VnzKHMJl;
	Sat, 11 Jul 2026 13:24:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BF71E4056D;
	Sat, 11 Jul 2026 13:24:35 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBndnKS01FqF1tCAw--.37295S3;
	Sat, 11 Jul 2026 13:24:35 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Eliminate dup/restore of insn_aux_data
Date: Sat, 11 Jul 2026 13:23:11 +0000
Message-ID: <c5b9d3af5a828e6c0e46e0bee058bca73b2c69e7.1783775928.git.xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783775928.git.xukuohai@huaweicloud.com>
References: <cover.1783775928.git.xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBndnKS01FqF1tCAw--.37295S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWUGF15Gr1rur4kuFW7urg_yoWfWFWfpF
	93Xwn7AF4kJws0gwnrAFWUArnxtr4jgw4DGFykZ3y8XF1jgrn5XFyj9ay0vasYyrW0kw1S
	vr4j9rW7Ww17WrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1U
	M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU0l4iUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The dup/restore of insn_aux_data was introduced to resolve the
inconsistency between insnsi and insn_aux_data arrays, which occurs
on the failure path where insnsi was rolled back to the original
state before constants blinding, while insn_aux_data was not.

After JIT failure, there is only one user, bpf_clear_insn_aux_data(),
that requires insnsi and insn_aux_data to be synchronized. It accesses
both insnsi and insn_aux_data using the same array size and index.

However, the access to insnsi in bpf_clear_insn_aux_data() is not
necessary. It is checked to skip the second slot of an ldimm64 instruction,
whose jt is never set and can be absorbed into the jt check itself.

So remove the access to insnsi from bpf_clear_insn_aux_data(), and add a
specific length field for insn_aux_data to allow it to have a different
length from the insnsi array. Then remove dup/restore of insn_aux_data.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf_verifier.h |  1 +
 include/linux/filter.h       | 13 -------------
 kernel/bpf/core.c            | 16 ----------------
 kernel/bpf/fixups.c          | 36 ++----------------------------------
 kernel/bpf/verifier.c        |  4 ++--
 5 files changed, 5 insertions(+), 65 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 317e99b9acc0..c98ec9de5ba6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -948,6 +948,7 @@ struct bpf_verifier_env {
 	bool seen_direct_write;
 	bool seen_exception;
 	bool signature;
+	u32 insn_aux_data_len;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 14acb2455746..25148865f9c7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1211,25 +1211,12 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 #ifdef CONFIG_BPF_SYSCALL
 struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				     const struct bpf_insn *patch, u32 len);
-struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env *env);
-void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
-			       struct bpf_insn_aux_data *orig_insn_aux);
 #else
 static inline struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 						   const struct bpf_insn *patch, u32 len)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-
-static inline struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env *env)
-{
-	return NULL;
-}
-
-static inline void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
-					     struct bpf_insn_aux_data *orig_insn_aux)
-{
-}
 #endif /* CONFIG_BPF_SYSCALL */
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 47fe047ad30b..b7f17f89d992 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2622,22 +2622,10 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 {
 #ifdef CONFIG_BPF_JIT
 	struct bpf_prog *orig_prog;
-	struct bpf_insn_aux_data *orig_insn_aux;
 
 	if (!bpf_prog_need_blind(prog))
 		return bpf_int_jit_compile(env, prog);
 
-	if (env) {
-		/*
-		 * If env is not NULL, we are called from the end of bpf_check(), at this
-		 * point, only insn_aux_data is used after failure, so it should be restored
-		 * on failure.
-		 */
-		orig_insn_aux = bpf_dup_insn_aux_data(env);
-		if (!orig_insn_aux)
-			return prog;
-	}
-
 	orig_prog = prog;
 	prog = bpf_jit_blind_constants(env, prog);
 	/*
@@ -2650,8 +2638,6 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 	prog = bpf_int_jit_compile(env, prog);
 	if (prog->jited) {
 		bpf_jit_prog_release_other(prog, orig_prog);
-		if (env)
-			vfree(orig_insn_aux);
 		return prog;
 	}
 
@@ -2659,8 +2645,6 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 
 out_restore:
 	prog = orig_prog;
-	if (env)
-		bpf_restore_insn_aux_data(env, orig_insn_aux);
 #endif
 	return prog;
 }
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d3be972714b2..37f22eb41854 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -174,6 +174,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	if (cnt == 1)
 		return;
 	prog_len = new_prog->len;
+	env->insn_aux_data_len = prog_len;
 
 	memmove(data + off + cnt - 1, data + off,
 		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
@@ -440,7 +441,6 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 {
 	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	struct bpf_insn *insns = env->prog->insnsi;
 	int end = start + len;
 	int i;
 
@@ -449,9 +449,6 @@ void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 			kvfree(aux_data[i].jt);
 			aux_data[i].jt = NULL;
 		}
-
-		if (bpf_is_ldimm64(&insns[i]))
-			i++;
 	}
 }
 
@@ -464,7 +461,6 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		bpf_prog_offload_remove_insns(env, off, cnt);
 
-	/* Should be called before bpf_remove_insns, as it uses prog->insnsi */
 	bpf_clear_insn_aux_data(env, off, cnt);
 
 	err = bpf_remove_insns(env->prog, off, cnt);
@@ -483,6 +479,7 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
+	env->insn_aux_data_len -= cnt;
 
 	return 0;
 }
@@ -1005,26 +1002,6 @@ static void bpf_restore_subprog_starts(struct bpf_verifier_env *env, u32 *orig_s
 	env->subprog_info[env->subprog_cnt].start = env->prog->len;
 }
 
-struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env *env)
-{
-	size_t size;
-	void *new_aux;
-
-	size = array_size(sizeof(struct bpf_insn_aux_data), env->prog->len);
-	new_aux = __vmalloc(size, GFP_KERNEL_ACCOUNT);
-	if (new_aux)
-		memcpy(new_aux, env->insn_aux_data, size);
-	return new_aux;
-}
-
-void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
-			       struct bpf_insn_aux_data *orig_insn_aux)
-{
-	/* the expanded elements are zero-filled, so no special handling is required */
-	vfree(env->insn_aux_data);
-	env->insn_aux_data = orig_insn_aux;
-}
-
 static int jit_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog, **func, *tmp;
@@ -1299,7 +1276,6 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 	bool blinded = false;
 	struct bpf_insn *insn;
 	struct bpf_prog *prog, *orig_prog;
-	struct bpf_insn_aux_data *orig_insn_aux;
 	u32 *orig_subprog_starts;
 
 	if (env->subprog_cnt <= 1)
@@ -1307,14 +1283,8 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 
 	prog = orig_prog = env->prog;
 	if (bpf_prog_need_blind(prog)) {
-		orig_insn_aux = bpf_dup_insn_aux_data(env);
-		if (!orig_insn_aux) {
-			err = -ENOMEM;
-			goto out_cleanup;
-		}
 		orig_subprog_starts = bpf_dup_subprog_starts(env);
 		if (!orig_subprog_starts) {
-			vfree(orig_insn_aux);
 			err = -ENOMEM;
 			goto out_cleanup;
 		}
@@ -1334,7 +1304,6 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 	if (blinded) {
 		bpf_jit_prog_release_other(prog, orig_prog);
 		kvfree(orig_subprog_starts);
-		vfree(orig_insn_aux);
 	}
 
 	return 0;
@@ -1364,7 +1333,6 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 
 out_restore:
 	bpf_restore_subprog_starts(env, orig_subprog_starts);
-	bpf_restore_insn_aux_data(env, orig_insn_aux);
 	kvfree(orig_subprog_starts);
 out_cleanup:
 	/* cleanup main prog to be interpreted */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03e2202cca13..85b05529f107 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20108,7 +20108,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (!is_priv)
 		mutex_lock(&bpf_verifier_lock);
 
-	len = env->prog->len;
+	len = env->insn_aux_data_len = env->prog->len;
 	env->insn_aux_data =
 		__vmalloc(array_size(sizeof(struct bpf_insn_aux_data), len),
 			  GFP_KERNEL_ACCOUNT | __GFP_ZERO);
@@ -20354,7 +20354,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	release_btfs(env);
 err_free_env:
 	if (env->insn_aux_data)
-		bpf_clear_insn_aux_data(env, 0, env->prog->len);
+		bpf_clear_insn_aux_data(env, 0, env->insn_aux_data_len);
 	vfree(env->insn_aux_data);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);
-- 
2.43.0

