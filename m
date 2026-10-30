Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361214;
	b=cESRfJeYECgqTuUBkbRroBQWhuitAKWaZVoUSAoQ/Ak3hZl/BTzOnyxNyCIOJlZ3GLSN
	 GUaw/buXDFO5qV8Jh3iGhqTrxaw0Z7UQ5NeEC4RF8pan+OAaE1nxJfWnIJZAwUIpO3ZdE
	 4Pl7WdLxT29k7rHu+iUf3Md+r/ipgPG4SUGeIkCezp7pxnfL9v33/2MOr9J+KD9HMYHgJ
	 VYESJStciLxQkQ90bPU+xDo1pJue6bIDxx5de/1tUku6fkwN6fJYH6DF0t2Fcv5q9j0fu
	 DD8ugFK+eLDELPIQT1gz5E5vYeRTxLI4VZOwCqGK4XNmJkgGTKvEf/G0MwEuJnJeJPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=UoxK9/1cELFnYp6P6sTQoajbgJH7VOzsaFPRmpU26Ms=;
	b=UTpAHSt+LCLBmzmReC3jEo8PqIfz1E99Phf83vIePnWwq/398FUOXiF3EWDdY0H67hfU
	 yQVRe6tGngDZOblXb8BfLv3BhUbKqN/9I7r+6/xFJfjECRyuSigjUojU3oP1NLTIb7LSa
	 AfCidkARjolwfG4cJl4sLV44FSqUMoG+/COor5W9qcukYC/JVB2JHePZyss3GPeUmp7hf
	 Sphngezq3jy4SlcgFIJ47W9WpgzIb5L8GsmMj+wmVJMzZljtWa6bPenXXL1hNXpkyAbPK
	 zM79U5HyWZxF6xWi+7zkykcHvrSLDyIG2Xm+XNso+4dVsrNW74kgxYWqHf/WbYGTFyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kv4pJV71;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496060A2612
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2496060A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kv4pJV71
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a8cc11ac42so493813c88.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361213; x=1793966013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UoxK9/1cELFnYp6P6sTQoajbgJH7VOzsaFPRmpU26Ms=;
        b=kv4pJV71P9w8huHCPikTg6D2/Y5g7GIosa6wvzL6nFCWp7rfHA5ZKfYnj1dJGWRWIy
         xq3oHZA+xBaWO3zh17klv1eaoRi34y1CwgH2v4uLDAhz0Xp/OJZRpNSOGx+6DIwuO9mn
         eg8ZjMEFHgQl+OWOgfUTIk0K7L95SjRq/Rydb5E2uZAtuGip0Ig+5xU4eKGeyVZWLVWC
         cC0jafJ9YCzKuULrjzxgIEVAvjZGMyng/6crdS5xV9vQia/3a5tUGOjJq4BWER0xp9eY
         /CLtbxeZZ9bUfvh6yAPkwPICo+Cvv+tYLr1OSzCyZmtXtcNTOEPzUVXbCnEqiM5eMtX9
         GW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361213; x=1793966013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoxK9/1cELFnYp6P6sTQoajbgJH7VOzsaFPRmpU26Ms=;
        b=clMVT4SG5yn8XRLj5G3sVd8JawPZosZ02pxyYotAABM5SqRuMKfYgwAyq3b50L77qj
         /XHNoHHTWuSUwOSKP1r2KnvH5DpkOsWtmGgXaBHSai5fSZ4wit6DcpSUxlP/GfmAvKbk
         PVWUCeQzF0jF8BwXHWS3H2ZZM0dDm8FP9R6OgoNXQjtDoUgHZY+4i7onhN6HuYA+SKl2
         OQJeKmZmMudCqbpt8uCoAe3Aj45CHZcO3iOPD1h4e+m579lIhpNPgqO/26zV1zHyhqVz
         IbkO0TP2srelc49NKpe0oj+74Cgk33WUpVYPgAmLVFLl8sCDywJqjJuUzMzsoUeAXzIF
         GonA==
X-Gm-Message-State: AFq9FYKekiI0a8QVuVJLZqGm1IYg4bEynjUTx+6jNmoes9/iu0g54VYA
	E78+4aG9fEoIUaAbARpPWcs/wPgiEHSRT+OoQzL5TM2UT1WwLLJQ8sCO
X-Gm-Gg: AYBFou1J0ureg2/y06F4+uZoVBhCxJx0ZS+zQBeNisb1k4uJAlZA9Oj/zPcYpcF+iHh
	VGoEnrJFUvWD5zAWNQN91orl2862O8QeNW6V/UFj7/9lXCBKgjX/1fxf8EaQW3Ez4Gm2oV8YTAN
	Kc3F/1azdO/HyCkxE4Jm0cuBMxVIrE2f2rP/a0VBjdgsAZMnHl88E+B32nsp1fY6iXu/bz8XHAs
	OSHWRjC74jRlkmxLfyqjBC2n3J+Gd/S0eiatcrTeQgZabec2ZAzz81q6+isY8oqeVqNOlw2nYLx
	ZGeZO3UJ55XOaHaqmt/o2UK9nrpRHrm1dQCjwQCQgj8SeFQP3OR9KRlmy5ckyD9J9qS3/i9w7re
	9xnHr3n2Ps+zuMgvHT+yOwxpOzZVFE/HVQRcwog7Hu0S9S1I5kwo/iK3KdsX1TSvE1gEWMrZYVA
	7QrfxUnTlPIHdXiZevivDh+vp1iGfwxgITcX16hjWJttqRpvNv3geqEmMta3mHvMgpDXjJQAk7O
	Xjiav8IS8SXQlI5cG4M7uOlNr0XwKK6ubQpnzf9kGV+hl85sSrFAbtwGLTr2AxA46J238De8LHx
	1+I/GbFFpBxA4lslY8+MQeIv
X-Received: by 2002:a05:701b:4187:10b0:16c:ff3a:d72e with SMTP id a92af1059eb24-1ac5e322fb7mr3093981c88.20.1793361213355;
        Fri, 30 Oct 2026 04:53:33 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:53:32 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:52:01 -0400
Subject: [PATCH bpf-next v2 16/22] bpf: Append the hidden subprog through
 the patch list
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-16-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
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
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

add_hidden_subprog() appends the subprog for the exception callback by
patching the last instruction of the program with itself followed by
the new instructions.

It does that with bpf_patch_insn_data(), which is going away once all
passes use the patch list.

Queue that patch with bpf_patch_list_add() and commit it right away.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/fixups.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index f55ac904b4e78..84aaaa4632aa3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1865,7 +1865,8 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
 {
 	struct bpf_subprog_info *info = env->subprog_info;
-	int cnt = env->subprog_cnt;
+	int err, cnt = env->subprog_cnt;
+	struct bpf_insn *last;
 	struct bpf_prog *prog;
 
 	/* We only reserve one slot for hidden subprogs in subprog_info. */
@@ -1874,13 +1875,15 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 		return -EFAULT;
 	}
 	/* We're not patching any existing instruction, just appending the new
-	 * ones for the hidden subprog. Hence all of the adjustment operations
-	 * in bpf_patch_insn_data are no-ops.
+	 * ones for the hidden subprog.
 	 */
-	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
-	if (!prog)
-		return -ENOMEM;
-	env->prog = prog;
+	last = bpf_patch_list_add(env, env->prog->len - 1, patch, len);
+	if (IS_ERR(last))
+		return PTR_ERR(last);
+	err = bpf_patch_list_commit(env);
+	if (err)
+		return err;
+	prog = env->prog;
 	info[cnt + 1].start = info[cnt].start;
 	info[cnt].start = prog->len - len + 1;
 	/* The patch ends with the exit. */

-- 
2.43.0

