Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DBC370AD8;
	Mon,  5 Oct 2026 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213209; cv=none; b=GLVwhYQyZvWZFFVvBM4Q0T3MXr5ts94fxUOI09cLrcJpGEknfoqaAcg/7G48VRZLNtaBDUqzFe9TSS4Gbw1eAQJxiAXuWbHD5w0YGlWxQ1aBnbTy6HBKuNUrNisw/nfOlYU2GwhmPPGdRyqpNNbyhqLvKPLcme1ACEG4VD7Jvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213209; c=relaxed/simple;
	bh=Y3Nu09ZHMGbGJXPbtNN0t/+/YbRwdIDFwo7MBmC1/yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yr5zVi9Mp1oqL1189eg03Kewu8TpAE2ykNYASKV+eBhJn+AOoBvkUh3Ne3ju4ef3UP9pe5Qsx7TVYSqW1PHFY/q7ySOR+AqWnYemu2qZaBI8X4uLccJzRcSOlqEyYaZnBTOjj/4ShIK0MQeOMqkLwtcoHHe5eTG/cE3dDXjP8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=LbLDM5am; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="LbLDM5am"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=2lr4J8FXIydsshTW66YmOtsanqGpQUO
	HIRWnQvIdKoM=; b=LbLDM5amb7z2quZNDRCvfMlDvwXNukhzwWNClqtWA0RtzW+
	/ba37cQHXnvV2+oi37LzSzqaVKN9tUgN/P+yZo45TrQ6gThJN0feAIPqSpR8ajnp
	+RwiWr94N9QB3hCqSfLj92irw0HltDSKtnSZ8U2NCE7zqYyEYqjQyRygYhfo=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQCHSAZ6vsNq8u+4AA--.39659S4;
	Mon, 05 Oct 2026 23:13:05 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Mon, 05 Oct 2026 15:12:58 +0000
Subject: [PATCH bpf 2/2] selftests/bpf: Cover non-trusted pointer to
 __arg_trusted subprog arg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-a3-arg-trusted-v4-v1-2-50ee0268fd39@mails.tsinghua.edu.cn>
References: <20261005-a3-arg-trusted-v4-v1-0-50ee0268fd39@mails.tsinghua.edu.cn>
In-Reply-To: <20261005-a3-arg-trusted-v4-v1-0-50ee0268fd39@mails.tsinghua.edu.cn>
To: Eduard Zingerman <eddyz87@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
 Song Liu <song@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791213186; l=2552;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=Y3Nu09ZHMGbGJXPbtNN0t/+/YbRwdIDFwo7MBmC1/yg=;
 b=AMJFWvbYM37yyDpBfjgxz2lecowQhqs2Hu83eXifpKZ0uKeoPdyUKAiq1pR0Z2GBpaKzbj+2d
 rq404w0FwKRCsThZbpK8SEqVq5hsy6/Aoy9uclsyuV8FmaQ+mlhfx6x
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:ywQGZQCHSAZ6vsNq8u+4AA--.39659S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4UJFyrCw4Utr4Utr1DWrg_yoW5GFW5pF
	4kAwnxXayxtanFq34fJr47ur4SgF1rZ34rGr1fX34fuFs8JF1xGry8KF4YqrW5Crn8KFna
	vrWqgrZI9rnrKaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a
	6rW5MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc8u4DUUUU
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
index 03507eeae3cb3..ec042f91bcf20 100644
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

