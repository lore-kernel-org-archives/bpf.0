Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E439B941;
	Mon,  2 Mar 2026 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445721; cv=none; b=iEEkoSMBrxra3prO9EGvaiFSBmw+ooKqY6XkQRB6vdgN7dJr+4a4tSN/CfI3+VrNo/yYkS/qBL+/0sav4Dlu4EnEHT7GEpSQgHYIZmMhDQVxI+oHjMTSy9w9fPuj5ACmEt79kzdreGC03ihfZ6nAaXw4EFxLcptPz0JAa+NRUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445721; c=relaxed/simple;
	bh=O8mf0BZAIVrL//k8N+6T8ul4BgBk79ZWk1FzjydjvQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDKIVIA999QTWhF2gPaDTP5YzaYe9sVVTCENrncxfo4lmlPf/oUOzzJc0OTMGYDyNfJgENMMnBA97tNLO7e7xvR72M+tKBVEsqUJ0ZU9BGXYo0JC2SrMHxwR668rVMF+ZdrU+6zD0lO0wo+F2n33D1CpZ0oQSa9tb9s99t8m7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fPZGL5SqWzKHMPq;
	Mon,  2 Mar 2026 18:01:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6396140575;
	Mon,  2 Mar 2026 18:01:49 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCXQvMKYKVpfu0vJQ--.22492S3;
	Mon, 02 Mar 2026 18:01:49 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v5 1/5] bpf: Move JIT for single-subprog programs to verifier
Date: Mon,  2 Mar 2026 18:27:22 +0800
Message-ID: <20260302102726.1126019-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXQvMKYKVpfu0vJQ--.22492S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1xAF1rWr47Xr1kur1fCrg_yoW7XF1UpF
	Z3X34UCr4UKwsrAwnrAF17A345Xa10gw13Ga93tryF9r4jqr4kWF1UWFsYqFWY9ryUtr1S
	va109rZrZ345ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU0xsqJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

JIT for single-subprog programs is done after the verification stage. This
prevents the JIT stage from accessing the verifier's internal datas, like
env->insn_aux_data. So move it to the verifier. After the movement, all bpf
progs loaded with bpf_prog_load() are JITed in the verifier. The JIT in
bpf_prog_select_runtime() is preserved for bpf_migrate_filter() and test
cases.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/filter.h |  2 ++
 kernel/bpf/core.c      | 51 +++++++++++++++++++++++++++---------------
 kernel/bpf/syscall.c   |  2 +-
 kernel/bpf/verifier.c  |  7 +++++-
 4 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 44d7ae95ddbc..632c03e126d9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1108,6 +1108,8 @@ static inline int sk_filter_reason(struct sock *sk, struct sk_buff *skb,
 	return sk_filter_trim_cap(sk, skb, 1, reason);
 }
 
+struct bpf_prog *bpf_prog_select_jit(struct bpf_prog *fp, int *err);
+struct bpf_prog *__bpf_prog_select_runtime(struct bpf_prog *fp, bool jit_attempted, int *err);
 struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err);
 void bpf_prog_free(struct bpf_prog *fp);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 229c74f3d6ae..00be578a438d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2505,18 +2505,18 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 	return select_interpreter;
 }
 
-/**
- *	bpf_prog_select_runtime - select exec runtime for BPF program
- *	@fp: bpf_prog populated with BPF program
- *	@err: pointer to error variable
- *
- * Try to JIT eBPF program, if JIT is not available, use interpreter.
- * The BPF program will be executed via bpf_prog_run() function.
- *
- * Return: the &fp argument along with &err set to 0 for success or
- * a negative errno code on failure
- */
-struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
+struct bpf_prog *bpf_prog_select_jit(struct bpf_prog *fp, int *err)
+{
+	*err = bpf_prog_alloc_jited_linfo(fp);
+	if (*err)
+		return fp;
+
+	fp = bpf_int_jit_compile(fp);
+	bpf_prog_jit_attempt_done(fp);
+	return fp;
+}
+
+struct bpf_prog *__bpf_prog_select_runtime(struct bpf_prog *fp, bool jit_attempted, int *err)
 {
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
@@ -2540,12 +2540,11 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	 * be JITed, but falls back to the interpreter.
 	 */
 	if (!bpf_prog_is_offloaded(fp->aux)) {
-		*err = bpf_prog_alloc_jited_linfo(fp);
-		if (*err)
-			return fp;
-
-		fp = bpf_int_jit_compile(fp);
-		bpf_prog_jit_attempt_done(fp);
+		if (!jit_attempted) {
+			fp = bpf_prog_select_jit(fp, err);
+			if (*err)
+				return fp;
+		}
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
 			return fp;
@@ -2570,6 +2569,22 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 
 	return fp;
 }
+
+/**
+ *	bpf_prog_select_runtime - select exec runtime for BPF program
+ *	@fp: bpf_prog populated with BPF program
+ *	@err: pointer to error variable
+ *
+ * Try to JIT eBPF program, if JIT is not available, use interpreter.
+ * The BPF program will be executed via bpf_prog_run() function.
+ *
+ * Return: the &fp argument along with &err set to 0 for success or
+ * a negative errno code on failure
+ */
+struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
+{
+	return __bpf_prog_select_runtime(fp, false, err);
+}
 EXPORT_SYMBOL_GPL(bpf_prog_select_runtime);
 
 static unsigned int __bpf_prog_ret1(const void *ctx,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..d6982107ba80 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3090,7 +3090,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_used_maps;
 
-	prog = bpf_prog_select_runtime(prog, &err);
+	prog = __bpf_prog_select_runtime(prog, true, &err);
 	if (err < 0)
 		goto free_used_maps;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc4ccd1de569..ab2bc0850770 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -26086,6 +26086,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		convert_pseudo_ld_imm64(env);
 	}
 
+	/* constants blinding in the JIT may increase prog->len */
+	len = env->prog->len;
+	if (env->subprog_cnt == 1)
+		env->prog = bpf_prog_select_jit(env->prog, &ret);
+
 	adjust_btf_func(env);
 
 err_release_maps:
@@ -26111,7 +26116,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-	clear_insn_aux_data(env, 0, env->prog->len);
+	clear_insn_aux_data(env, 0, len);
 	vfree(env->insn_aux_data);
 err_free_env:
 	bpf_stack_liveness_free(env);
-- 
2.47.3

