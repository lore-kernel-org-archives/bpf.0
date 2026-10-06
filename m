Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644232FDC20;
	Tue,  6 Oct 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302815; cv=none; b=mZ8rUjuvXAUNGv/Dzf0ZtfgTKzOUtsK7mY/PJfsArEQivAA1DsuM3gOnpVkn83vKJyGGaDj9b6Af87z71IxT7mHc96wieYEvOUTUxiPY7iNNqPHfUVqyczNjXYAwTAba9yJ4tP3sZpCO0sqz71hR587zNNryArjJ/CQjlTpijUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302815; c=relaxed/simple;
	bh=NR25tzNBFUsS4sHTJX/HGWKYzRmLFi0hhgogY3M4RJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itD9gTNG9wS8Sj+8dvyN1bCg2a+mVX16inSPRFp0zyxX9K7LUTrH4BT6RAWIs6njSiT6YU9T8oK2LLaieo92WVCWe3Cj7cQk3XvhDRBQbWvsbL0ih0b8e7KDZ2Sac87qhx5reZVuf3WhCL8V2Oe4OSa9F/9GJEnpwtGBuURnpks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=UUVfk7a8; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="UUVfk7a8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=HQfOSQTCSqSJYyQOfBkQ35vPMlyk0FJ
	vhkkhaDgrqQY=; b=UUVfk7a8m8sLMEGaP2eBgjbw1rzyeBhAHZiLemHWKuCHUsG
	qNfHjRRsuczfh9W1C/XVk25IiQ+8LMczVY5IRxbxUPfO5PquhB2PQgLpTow3CQS1
	uxiKEEcVhME6utjdgQ0casCCMSZF/0ZUKzqwr3OhoSswsOG3XSCdVUFwGF04=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQBXhGiBHMVqrZhzAA--.54037S4;
	Wed, 07 Oct 2026 00:06:32 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Tue, 06 Oct 2026 16:06:26 +0000
Subject: [PATCH bpf v3 2/2] selftests/bpf: Cover bare and RCU __arg_trusted
 arguments
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-a3-arg-trusted-v4-v3-2-4619daf30e1c@mails.tsinghua.edu.cn>
References: <20261006-a3-arg-trusted-v4-v3-0-4619daf30e1c@mails.tsinghua.edu.cn>
In-Reply-To: <20261006-a3-arg-trusted-v4-v3-0-4619daf30e1c@mails.tsinghua.edu.cn>
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
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791302794; l=2290;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=NR25tzNBFUsS4sHTJX/HGWKYzRmLFi0hhgogY3M4RJU=;
 b=H0RVA1v1lHDaVIegnNPNgBgftQ6z38VtiTDKZ2nvXfEIfcRH9pfXVFAZJu3H3n9yyFUrFTz4y
 SCDzfD92QN0BKZC/0sZl4IXPdEq4qPSbR/uUEjegeUNUErMn+OCSiEz
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yQQGZQBXhGiBHMVqrZhzAA--.54037S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tr18trWkXFWrGr4fKF1kAFb_yoW8KF48pa
	1kAw13WrWxtanFq34xJr4UCF4SgFn5Z345CF1rX34fuFs8JF1kXr18KF4Yqr15Crn0gFna
	vrWqg39I9rnrGaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0x
	vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
	GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
	CS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkI
	ecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnwZcUUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

verifier_global_ptr_args.c already covers passing an untrusted pointer to
a __arg_trusted argument, which is rejected by the register type match.
It does not cover the bare PTR_TO_BTF_ID flavor that the type match also
accepts.

Add a rejection case that walks task_struct->last_wakee out of a trusted
current task and passes the result to a __arg_trusted subprogram parameter.
The field has no __rcu tag and is not in
BTF_TYPE_SAFE_RCU(task_struct), so the load yields a bare PTR_TO_BTF_ID.

Also pass task_struct->real_parent to a trusted-and-nullable subprogram
as a positive test. The field is __rcu and on
BTF_TYPE_SAFE_RCU(task_struct), so it yields PTR_TO_BTF_ID | MEM_RCU and
must remain accepted.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index dcc2dd46751a4..6176b2223a0fb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -289,6 +289,40 @@ __weak int subprog_void_untrusted(void *p __arg_untrusted)
 	return *(int *)p;
 }
 
+__weak int subprog_trusted_bare(struct task_struct *task __arg_trusted)
+{
+	return task->pid;
+}
+
+SEC("tp_btf/task_newtask")
+__failure
+__msg("R1 must be referenced, trusted, or RCU protected")
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
+/* real_parent yields an RCU-protected pointer, which is a valid argument. */
+SEC("tp_btf/task_newtask")
+__success
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

