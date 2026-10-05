Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F330AAD8;
	Mon,  5 Oct 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225227; cv=none; b=JWZ+TW1PGkg4vd0WKeOMadvdtewvwL394ZESpnIKwsP027fep8QvfyyJ8xfLlz1zIRmvbhS0vm8RffZxF0j2s8y7GKMxDhZVRCLn4Likc4Jp34YAE5NopjT1vZ2c8sOKm1boIl0DPm7aL51ptoy1K2ZoDc3kHFTu/ZGU+XfTRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225227; c=relaxed/simple;
	bh=Fun/YY4Lj4ooQUInoo5MERLda9ccTkcQOBVDuFQC9sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oAgB3HbD42N/8VwdOkXakZz703J+IVmB1oM0wIZa/OOG5/EIWs/MTH/SarkXTsXWdh/gFXUGhXdLyPKSzqjlAz5HfIXaI5zBS4xFNhMaoiL6U60X4acMqZeQ6KdFzxdIyzHGzUPC52envRibk2haOOLvCRwSI7QO1BFKU8dL5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=RZYRNy7X; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="RZYRNy7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=BvfWz4wUp+IErnw5zVN/AdzZtRqcY8f
	SnEXQExAZlUw=; b=RZYRNy7XKptZ48e02DwAJMnDXQb8LREf5r/v41iUPIddymB
	Mkn3wOkMvGfnUp4L2kO2VZD4+pMvxVeP0WP1MLSOtuAJG/VuJomL4odyGPljygvz
	nionbTFog1/kDbI1pClCpcUsEFTVvlsMPCQDEam559fzxa1/N3H3SwIzwbl0=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQAXjj5z7cNqfPTAAA--.64526S4;
	Tue, 06 Oct 2026 02:33:27 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Mon, 05 Oct 2026 18:33:24 +0000
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover non-trusted pointer to
 __arg_trusted subprog arg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-a3-arg-trusted-v4-v2-2-319ce2936949@mails.tsinghua.edu.cn>
References: <20261005-a3-arg-trusted-v4-v2-0-319ce2936949@mails.tsinghua.edu.cn>
In-Reply-To: <20261005-a3-arg-trusted-v4-v2-0-319ce2936949@mails.tsinghua.edu.cn>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
 Song Liu <song@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791225207; l=2552;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=Fun/YY4Lj4ooQUInoo5MERLda9ccTkcQOBVDuFQC9sw=;
 b=9QHGlKc4z6GEWfqpCoaswPIomnvqBtkpo2OkU0CVgAtoOtb4qlHf3Ijc34M3Zz5Xgj/082foc
 qKyAqwwGKXRAdU17H5/ZEkXdwwFjrYlfRQpCOjOMrbESwvGWMY4VCaU
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQAXjj5z7cNqfPTAAA--.64526S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4UJFyrCw4Utr4Utr1DWrg_yoW5GFW5pF
	4kAwnxXayxtan2q34fJr47ur4SgF1rZ34rGr1fX34fuFs8JFn7Gry8KF4YqrW5Crn5KFna
	vrWqgrZI9rnrKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFV
	AIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E74AGY7Cv6cx26r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxE
	wVAFwVW5MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07Uh2-5UUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

verifier_global_ptr_args.c already covers passing an untrusted pointer
to a __arg_trusted argument, which is rejected by the register type
match. It does not cover the bare PTR_TO_BTF_ID or MEM_RCU flavors, both
of which the type match accepts.

Add two cases. The first walks task_struct->last_wakee out of a trusted
current task and passes the result to a __arg_trusted subprogram
parameter; the field has no __rcu tag and is not in
BTF_TYPE_SAFE_RCU(task_struct), so the load yields a bare PTR_TO_BTF_ID.
The second passes task_struct->real_parent, which is __rcu and on
BTF_TYPE_SAFE_RCU(task_struct), so the load yields
PTR_TO_BTF_ID | MEM_RCU. Both calls are expected to be rejected with
"must be referenced or trusted".

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index dcc2dd46751a4..6765fd4b4a239 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -289,6 +289,46 @@ __weak int subprog_void_untrusted(void *p __arg_untrusted)
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
+/*
+ * real_parent is __rcu and on BTF_TYPE_SAFE_RCU(task_struct), so the load
+ * yields PTR_TO_BTF_ID | MEM_RCU. That is neither referenced nor trusted and
+ * must not satisfy __arg_trusted.
+ */
+SEC("tp_btf/task_newtask")
+__failure
+__msg("R1 must be referenced or trusted")
+__msg("Caller passes invalid args into func#{{.*}} ('subprog_trusted_task_nullable')")
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

-- 
2.43.0

