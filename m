Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B85B49D583;
	Tue,  6 Oct 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302815; cv=none; b=p6GF+EgXadQG4s2f7GK2BNNIchUo9Dm4tHW2S8/PY9yl4ApHUFKLA06wNaUUt97EUiFGHWWxmDgpBE8m10ChM7XqvokY2W8ws9qIkYEfEz/gg0gcBhTWyMICLQIIFXcQNyb1aNXSjBl2joivvdbu6oNKMmWsY0lcCegAefP7Wo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302815; c=relaxed/simple;
	bh=BijghkOD8KBfbykt7I1kr/gfiL7Yq0YO4UXfaqi7jV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTCPYb88kuJvbZPXUPow+bAYDlhOsgubOApG0rW/bVavKLowx9T5DQFk9adfVc/DR3rTC2uLbahnIZp/FlRNJxClhqNG3/++aQVpg0D2DZ7pfkWwJaKmlk7Z3AgLyZORRTSV2oC9Gz2vQRHJOJlkUhdC+Vul/vkHbQ/ObuKj6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ky8RspzK; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ky8RspzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=VpdeiX0w1Ntv+1YhY3nFslsVMF8cIDJ
	2QMDPjsqiEFY=; b=ky8RspzKdiL/gF1w/OWtRPmOa8c4rHA8yd9IrBvXX2Sh1j7
	cGXqAKot8iM2tpBbq5Im4nP7oGe4PkNGCpgRJjK7wDjOrCVKdDOIwK4sUUI2gCR6
	rsUTfx3VAov6JR81WtH7rx8ZDkvG5lCAsGteqnXW192M2+9TVpXfHMDCCSgQ=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQBXhGiBHMVqrZhzAA--.54037S3;
	Wed, 07 Oct 2026 00:06:32 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Tue, 06 Oct 2026 16:06:25 +0000
Subject: [PATCH bpf v3 1/2] bpf: Reject bare pointer for __arg_trusted arg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-a3-arg-trusted-v4-v3-1-4619daf30e1c@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791302794; l=2852;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=BijghkOD8KBfbykt7I1kr/gfiL7Yq0YO4UXfaqi7jV0=;
 b=s390sZUYVad6Z1sRc8ar1rgLiqDp7TLHXqIJhubTht9/GMm5HURxOupslJ9hyjyzMxGcL3ATr
 Z+w5fdyTKgZClujfHRVs2k0p9yC5DUVKm5vLLwdLitK1oXm/dsaKi7V
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yQQGZQBXhGiBHMVqrZhzAA--.54037S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurW5Kr1kCFyUWrW8uFWrAFb_yoW5Wr13pF
	48WFnxZr4kKr47Z3ySyF4xury5ZrWrZ3y7CFy8WFWIyFs8WF1qqrySkF47Wa4YyrsYk34a
	qF1agrZ0qa4UCrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6r1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjylkDUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

A global subprogram parameter tagged __arg_trusted is specified to accept
only lifetime-protected PTR_TO_BTF_ID registers, but the call-site check in
btf_check_func_arg_match() also accepts a bare PTR_TO_BTF_ID.

check_reg_type() resolves the accepted set from the base argument type
alone and compares only MEM_RDONLY and PTR_MAYBE_NULL, so the PTR_TRUSTED
bit of arg_type is never consulted. btf_ptr_types includes bare
PTR_TO_BTF_ID, and nothing else on the subprogram call path rejects it.

The callee is then validated with PTR_TRUSTED set on the register while
the caller passed a pointer without lifetime protection.
bpf_may_fault_on_deref() is false for PTR_TRUSTED, so the dereference
becomes a raw load instead of a BPF_PROBE_MEM probe and the callee can
pass the pointer on as trusted.

Reject a bare PTR_TO_BTF_ID when the argument is marked PTR_TRUSTED. Keep
accepting referenced, trusted, and RCU-protected registers.
PTR_MAYBE_NULL is allowed when __arg_nullable declares it.

The check runs after check_reg_type() and check_func_arg_reg_off()
succeed so that type and offset diagnostics keep their current wording.
The kfunc path is unchanged.

Fixes: e2b3c4ff5d183da6d1863c2321413406a2752e7a ("bpf: add __arg_trusted global func arg tag")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f874979b8d75..7ea181f3e8c15 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9806,6 +9806,30 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			err = err ?: check_func_arg_reg_off(env, reg, argno, arg->arg_type);
 			if (err)
 				return err;
+
+			/*
+			 * A __arg_trusted argument requires a referenced, trusted, or
+			 * RCU-protected pointer. btf_ptr_types also matches a bare
+			 * PTR_TO_BTF_ID, but that has no lifetime protection even
+			 * though the callee is verified with PTR_TRUSTED.
+			 * PTR_MAYBE_NULL is allowed when __arg_nullable declares it.
+			 *
+			 * Checked after the type/offset match so that type and offset
+			 * diagnostics keep their current wording.
+			 */
+			if (arg->arg_type & PTR_TRUSTED) {
+				u32 flags = type_flag(reg->type);
+
+				if (!reg_is_referenced(env, reg) &&
+				    (!(flags & (BPF_REG_TRUSTED_MODIFIERS | MEM_RCU)) ||
+				     (flags & ~(BPF_REG_TRUSTED_MODIFIERS | MEM_RCU |
+						(arg->arg_type & PTR_MAYBE_NULL))))) {
+					bpf_log(log,
+						"%s must be referenced, trusted, or RCU protected\n",
+						reg_arg_name(env, argno));
+					return -EINVAL;
+				}
+			}
 		} else {
 			verifier_bug(env, "unrecognized %s type %d",
 				     reg_arg_name(env, argno), arg->arg_type);

-- 
2.43.0

