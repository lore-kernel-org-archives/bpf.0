Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA44A4C4F69;
	Wed,  7 Oct 2026 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390363; cv=none; b=B3tIQWCrOcjNcMQJloYdmQD8vzriBIBH9SUh1mx5bqdpYOCQkDT1s6TNy8j6f0YB5rB+7gj82Q5ya9ywfdA+Lv0UfJLWF2NFI+OMn59haAn/Oro6TilwG5UiU/GEq5XOuwIqofULvsTSUreqCAtOQprPDc5eADUfQISPJif3Um4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390363; c=relaxed/simple;
	bh=N5yO0NVKSV8f9ktzlTDqIWflYZHMSCBhoXpoJIf4/nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIjFTKWQTYv6wztGqSYaDdf/A4gBMl8ie2LraQ49VuhugyesGQfp5XBMgSZ+Hyip1xMjKsyM5sITeNPHpKs4qBjEbUZi/x9wDZ/sTUO78qPW+F5POqW5aXYxX4R9yNi0+fpzIzTp9JHUngp4z+kXzaREJrzb0Nyj5mKbfgGSWCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=A6Qibki8; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="A6Qibki8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=/k8zkeVCJyUHGcf6u6rtSipFetO/TAS
	Ya+8odbyek/U=; b=A6Qibki8WxX1/iumbI1mQw+tqFKHCKx8kCsbt6UILxqznGd
	54qT4FK5D/s4lThflUICav3a4jNYMsDPaDa8OPz9mTZt9vJTxfuQTO0m221vBRc0
	/X7GhtF9qzi/0ptPFQpGigli3Aju0jkPugfQfl/fMNVXQlFYQzFk+a4gOvFU=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQA3qzt6csZqskPbAA--.57300S4;
	Thu, 08 Oct 2026 00:25:33 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Wed, 07 Oct 2026 16:25:30 +0000
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Cover trusted BTF ID
 argument provenance
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-a3-arg-trusted-v4-v4-2-253ef3a1a69a@mails.tsinghua.edu.cn>
References: <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
In-Reply-To: <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
 Brahmajit Das <listout@listout.xyz>, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791390334; l=4896;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=N5yO0NVKSV8f9ktzlTDqIWflYZHMSCBhoXpoJIf4/nU=;
 b=rsnNeFZma4jAxSyPz9NSxeWzElsHXmmWrpqg07LO6nPQYt06ZXLILCzxwaVLibwM7L6F1c10X
 6qv3kkAj1YmACeKImOTEQeIWARnfQeMtjf6YObzQGVZI3ygALlf7LCK
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQA3qzt6csZqskPbAA--.57300S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW3tFWfuF18tFWxtFyUAwb_yoW7Wr4fpa
	yxJw1qkFn7K3W3XryxJF4UuF4Skrn3ZryUCF1rG3sxCws7J3W8XF18KF4YqwnYkw4Fgrnx
	Z34vga1fuw18J3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1U
	M28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxV
	AIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv
	8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II
	8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl
	c2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3Ma5UUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Extend verifier_global_ptr_args.c with calls that pass bare and
RCU-protected task pointers to a global __arg_trusted parameter. Both
calls must be rejected because neither pointer is referenced or trusted.

Add paired test-module kfuncs that return and accept a nullable trusted
task pointer. Passing the return value directly must succeed, covering
PTR_TRUSTED | PTR_MAYBE_NULL handling in the common argument checker.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/progs/iters_testmod.c  | 11 +++++++
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 35 ++++++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 11 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |  2 ++
 4 files changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index f65cc9766633e..145750bb64ef8 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -46,6 +46,17 @@ int iter_next_trusted_or_null(const void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success
+int trusted_nullable_kfunc(const void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kfunc_trusted_null_test();
+	bpf_kfunc_trusted_nullable_test(task);
+	return 0;
+}
+
 SEC("raw_tp/sys_enter")
 __success
 int iter_next_rcu(const void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 03507eeae3cb3..4c55b70df0724 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -289,6 +289,41 @@ __weak int subprog_void_untrusted(void *p __arg_untrusted)
 	return *(int *)p;
 }
 
+__weak int subprog_trusted_bare(struct task_struct *task __arg_trusted)
+{
+	return task->pid;
+}
+
+SEC("tp_btf/task_newtask")
+__failure
+__msg("R1 must be referenced or trusted")
+__msg("Caller passes invalid args into func#{{.*}} ('subprog_trusted_bare')")
+int bare_to_trusted(void *ctx)
+{
+	struct task_struct *cur = bpf_get_current_task_btf();
+	struct task_struct *wakee;
+
+	if (!cur)
+		return 0;
+	wakee = cur->last_wakee;
+	if (!wakee)
+		return 0;
+	return subprog_trusted_bare(wakee);
+}
+
+SEC("tp_btf/task_newtask")
+__failure
+__msg("R1 must be referenced or trusted")
+__msg("Caller passes invalid args into func#{{.*}}")
+int memrcu_to_trusted(void *ctx)
+{
+	struct task_struct *cur = bpf_get_current_task_btf();
+
+	if (!cur)
+		return 0;
+	return subprog_trusted_task_nullable(cur->real_parent);
+}
+
 __weak int subprog_char_untrusted(char *p __arg_untrusted)
 {
 	return *(int *)p;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 93847ca6293b4..71d587b140570 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -313,6 +313,15 @@ __bpf_kfunc void bpf_kfunc_trusted_task_test(struct task_struct *ptr)
 {
 }
 
+__bpf_kfunc struct task_struct *bpf_kfunc_trusted_null_test(void)
+{
+	return NULL;
+}
+
+__bpf_kfunc void bpf_kfunc_trusted_nullable_test(struct task_struct *ptr__nullable)
+{
+}
+
 __bpf_kfunc void bpf_kfunc_trusted_num_test(int *ptr)
 {
 }
@@ -907,6 +916,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_release_test, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_null_test, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_nullable_test)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test)
 BTF_ID_FLAGS(func, bpf_kfunc_rcu_task_test, KF_RCU)
 BTF_ID_FLAGS(func, bpf_kfunc_ret_rcu_test, KF_RET_NULL | KF_RCU_PROTECTED)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 67c02a421d133..83abcd8e6200d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -340,6 +340,8 @@ int bpf_kfunc_st_ops_inc10(struct st_ops_args *args) __ksym;
 
 void bpf_kfunc_trusted_vma_test(struct vm_area_struct *ptr) __ksym;
 void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
+struct task_struct *bpf_kfunc_trusted_null_test(void) __ksym;
+void bpf_kfunc_trusted_nullable_test(struct task_struct *ptr__nullable) __ksym;
 void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
 void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
 struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;

-- 
2.43.0

