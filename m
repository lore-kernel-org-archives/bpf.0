Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E524AD4C8;
	Mon,  5 Oct 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213207; cv=none; b=MOmc867EoMBJefZJu5qwXRO7HkWImXqym2ipgsuwTBUYiOM3MDexIb5UZjTisojgFg/Z5gRtz8Lzqvi3Cpp6pLnaihJTSZ6+rCepoPN8gHryQPq2dR/DH5xMtoiG5769AzxzxoVqkW4TCJLpYPTdOCLDKW++2b+fUoSDwKo5Pa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213207; c=relaxed/simple;
	bh=KjRnL54FOka6c50pYVZt0J2e1jYOt38SAmJ3tSkAFgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zc4r5UI4XGqody2cwDsFiiUaF5ODFBmQxdKAzOAQ3m3HBdn+FmWOFsKpNt6db//orYp0t1vVzPFdWYgiBRg1trm4BHR0KOEAgvhm7PuVAWvYNB+ir+CQXtHglXTePiefFGklgMJtX8LuAeGe3/ZIKMFRHO63knPOoNBO9w+LYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=fH1N9Y2G; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="fH1N9Y2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=8w2P5ypWrI730AEW3FmtFu32zORWvQq
	84m+nFUW2UQY=; b=fH1N9Y2GdBwwW2YI1a68fJ+gE1xTLy45LOqKr42tliQWvnS
	okQn5RMdstwt+N9JWwAjDZutRd6VH4kmHJh4ON4alGAsc1KA3UgRHZBeeCJBNqYG
	FVFUyFP1QyQGWbKcH4x7F229sxXI00mchz+TpNjcXJ6wVRTiBOlI9AdaE+pk=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQCHSAZ6vsNq8u+4AA--.39659S3;
	Mon, 05 Oct 2026 23:13:05 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Mon, 05 Oct 2026 15:12:57 +0000
Subject: [PATCH bpf 1/2] bpf: Require referenced or trusted pointer for
 __arg_trusted arg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-a3-arg-trusted-v4-v1-1-50ee0268fd39@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791213186; l=2895;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=KjRnL54FOka6c50pYVZt0J2e1jYOt38SAmJ3tSkAFgw=;
 b=xhs/4ZCmTHL/m9jQOzeR1lREqVKpyxe85X07LRhIf4Tm/0Wrn6iexuM1WiuDdit/z9oVmfVbn
 bOr4QbV4K3CCUyyURoMx+G9ZuTHK7XA6Uoav33OXYKzhVWq2iJ81l+j
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:ywQGZQCHSAZ6vsNq8u+4AA--.39659S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWryrCw48Jw47GrykKw17Jrb_yoW5WF43pF
	48GrnIvF4kGr4Iy39ayF4xZrW5urWrZ3y7Crn7Aa4IyFn8WFW7tryYkFs8Ja1Yya95WryY
	qryagrW0qa4UurJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
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
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcDUUDUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

A global subprogram parameter tagged __arg_trusted is documented to
accept only the PTR_TRUSTED flavor of PTR_TO_BTF_ID, but the call-site
check also accepts a bare PTR_TO_BTF_ID and an MEM_RCU one.

check_reg_type() resolves the accepted set from the base argument type
alone and compares only MEM_RDONLY and PTR_MAYBE_NULL, so the PTR_TRUSTED
bit of arg_type is never consulted. The trusted/RCU enforcement in
check_func_arg() is gated on is_kfunc(meta), which is false for a
subprogram call, so that block is skipped for __arg_trusted arguments.

The callee is then validated with PTR_TRUSTED set on the register while
the caller passed a pointer that is neither referenced nor trusted.
bpf_may_fault_on_deref() is false for PTR_TRUSTED, so the dereference
becomes a raw load instead of a BPF_PROBE_MEM probe, is_trusted_reg()
kfuncs accept the pointer, and the callee can pass it on to a kfunc that
would have rejected it at the original call site.

Reject a PTR_TO_BTF_ID that is neither referenced nor trusted when the
argument is marked PTR_TRUSTED. A referenced register is accepted, as in
is_trusted_reg(). PTR_MAYBE_NULL is not counted as an unsafe modifier
when __arg_nullable declares it, so trusted-and-nullable arguments keep
working. The kfunc path is unchanged.

Fixes: e2b3c4ff5d183da6d1863c2321413406a2752e7a ("bpf: add __arg_trusted global func arg tag")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fd3c0206bd67d..fe5edbef85a16 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9597,6 +9597,27 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			}
 		}
 
+		/* A __arg_trusted argument requires a referenced or trusted
+		 * pointer. btf_ptr_types also matches a bare PTR_TO_BTF_ID and
+		 * an MEM_RCU one, but neither is referenced or trusted, so the
+		 * callee would be verified with PTR_TRUSTED while the caller
+		 * passed something that is not. PTR_MAYBE_NULL is not counted
+		 * as unsafe when __arg_nullable declares it, because
+		 * bpf_type_has_unsafe_modifiers() treats that flag as unsafe.
+		 */
+		if ((arg_type & PTR_TRUSTED) && base_type(reg->type) == PTR_TO_BTF_ID &&
+		    !reg_is_referenced(env, reg)) {
+			u32 flags = type_flag(reg->type);
+
+			if (!(flags & BPF_REG_TRUSTED_MODIFIERS) ||
+			    (flags & ~(BPF_REG_TRUSTED_MODIFIERS |
+				       (arg_type & PTR_MAYBE_NULL)))) {
+				verbose(env, "%s must be referenced or trusted\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+		}
+
 		if (is_kfunc(meta) && (!is_trusted_reg(env, reg) ||
 				       bpf_type_has_unsafe_modifiers(reg->type))) {
 			if (!(arg_type & MEM_RCU)) {

-- 
2.43.0

