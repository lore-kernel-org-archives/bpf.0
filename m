Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A686C31960B;
	Mon,  5 Oct 2026 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225228; cv=none; b=LlJN7OGKXELGardGi2epBf8nZa1X+IZo3kfuSdupBb2KO7zty5JoJ3d37XIjmn/vN7BNyIEsFE4HQR7enw444sSXclV+mpoxmAJ3m7NBc9epxeekwoRZZ9ygzeXjiWMK2e15fDIhSkAXsl4hmnBlpQWfTuXuKAUjX/AIOOZI5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225228; c=relaxed/simple;
	bh=/kzPT1+poq/sUGSmv8AzaqnmVyAkAAKRKLivrIVKTMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzuElukTutW6+34/rxYyxs9LWFRHACcnem2Gn/bzI6hrMdKO7KL5QTZP3yuoiPoK+FQhb1UcP1cnzlUzA5tfDR1iqzQb8Pm2088O+1JW+Gm4Rp4S1wb6BJnjGGw0naepJMiIWa+efnfs9KnCQvRCNJv48GGx3naYjiUwVZjJRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=herzKC5e; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="herzKC5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=1vIDkWMi7DXt/7//zjiKb+tOc71RPAz
	+I9aYShphtns=; b=herzKC5es3aS2U+SlVJhFwk66a6W35EOvE/mO0DoX1NgnYP
	n5aetK5j38/UsgThxyvBmsp7pmk0ZDeHDkTFJIHK5fpBhcI2czTtyWUfPYBFtjFj
	nYEJMPTtxsCTRE5vec+p86W4ingVv7ZOeIneV4bwv7WW42+IeXUXFyKDXDzI=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQAXjj5z7cNqfPTAAA--.64526S3;
	Tue, 06 Oct 2026 02:33:27 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Mon, 05 Oct 2026 18:33:23 +0000
Subject: [PATCH bpf v2 1/2] bpf: Require referenced or trusted pointer for
 __arg_trusted arg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-a3-arg-trusted-v4-v2-1-319ce2936949@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791225207; l=3262;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=/kzPT1+poq/sUGSmv8AzaqnmVyAkAAKRKLivrIVKTMk=;
 b=iA+tIUQSSmVvZ9gF4t8SOY34YKm8DR1Fim7WU1c5QxcrsA9QtftZYtGzC9iA/BVC+gwTXNqEe
 Xddlqanc3U+DBwgYuYE9G0w/yPseLPye1qWPmQPQqhJHEZRRiGmEBDU
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQAXjj5z7cNqfPTAAA--.64526S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW7ur4ktrWDWry7Aw4xWFg_yoW5ZF15pF
	48Krn8ZF4kGr4xA39ayF4xuryYyrW5Z3y3CF1xGFyIyFZ8WFyDtryFkFsxXa4YyFs5G34Y
	qFyagrWjq3WUurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62
	xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK
	67AK6ryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IUbnmRUUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

A global subprogram parameter tagged __arg_trusted is specified to
accept only the PTR_TRUSTED flavor of PTR_TO_BTF_ID, but the call-site
check in btf_check_func_arg_match() also accepts a bare PTR_TO_BTF_ID
and an MEM_RCU one.

check_reg_type() resolves the accepted set from the base argument type
alone and compares only MEM_RDONLY and PTR_MAYBE_NULL, so the
PTR_TRUSTED bit of arg_type is never consulted. btf_ptr_types lists
bare PTR_TO_BTF_ID and PTR_TO_BTF_ID | MEM_RCU alongside the trusted
flavor, and nothing else on the subprogram call path requires the
register to be referenced or trusted.

The callee is then validated with PTR_TRUSTED set on the register
while the caller passed a pointer that is neither referenced nor
trusted. bpf_may_fault_on_deref() is false for PTR_TRUSTED, so the
dereference becomes a raw load instead of a BPF_PROBE_MEM probe,
is_trusted_reg() kfuncs accept the pointer, and the callee can pass it
on to a kfunc that would have rejected it at the original call site.

Reject a PTR_TO_BTF_ID that is neither referenced nor trusted when the
argument is marked PTR_TRUSTED. A referenced register is accepted, as
in is_trusted_reg(). PTR_MAYBE_NULL is not counted as an unsafe
modifier when __arg_nullable declares it, so trusted-and-nullable
arguments keep working.

The check runs after check_reg_type() and check_func_arg_reg_off()
succeed so that type and offset diagnostics keep their current wording.
The kfunc path is unchanged.

Fixes: e2b3c4ff5d183da6d1863c2321413406a2752e7a ("bpf: add __arg_trusted global func arg tag")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f874979b8d75..c781e013c25cb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9806,6 +9806,30 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			err = err ?: check_func_arg_reg_off(env, reg, argno, arg->arg_type);
 			if (err)
 				return err;
+
+			/* A __arg_trusted argument requires a referenced or trusted
+			 * pointer. btf_ptr_types also matches a bare PTR_TO_BTF_ID and
+			 * an MEM_RCU one, but neither is referenced or trusted, so the
+			 * callee would be verified with PTR_TRUSTED while the caller
+			 * passed something that is not. PTR_MAYBE_NULL is not counted
+			 * as unsafe when __arg_nullable declares it, because
+			 * bpf_type_has_unsafe_modifiers() treats that flag as unsafe.
+			 *
+			 * Checked after the type/offset match so that type and offset
+			 * diagnostics keep their current wording.
+			 */
+			if (arg->arg_type & PTR_TRUSTED) {
+				u32 flags = type_flag(reg->type);
+
+				if (!reg_is_referenced(env, reg) &&
+				    (!(flags & BPF_REG_TRUSTED_MODIFIERS) ||
+				     (flags & ~(BPF_REG_TRUSTED_MODIFIERS |
+						(arg->arg_type & PTR_MAYBE_NULL))))) {
+					bpf_log(log, "%s must be referenced or trusted\n",
+						reg_arg_name(env, argno));
+					return -EINVAL;
+				}
+			}
 		} else {
 			verifier_bug(env, "unrecognized %s type %d",
 				     reg_arg_name(env, argno), arg->arg_type);

-- 
2.43.0

