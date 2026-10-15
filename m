Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28EA4F30C0
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107696; cv=none; b=Gy/dfKBxzbAWFROovVE87l++KmKPV5ZQDMSxEPUXmkvh8u46Cth/TfF/zho9nRZbb8sglSyQhl3/1ecuiMEEnuU6aSY52CpDiBe3Qsb/Tu5lkCO/H61/RQQpLLYgIo6bWOD5fFNjCn6GcP5ceMlb03xToGaRSQi0oYjbVoglehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107696; c=relaxed/simple;
	bh=Oue9ytwhhyeNlHsDYP3e6SmOuqxsfR13FuzQ1r2jpq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghblRKciVJYp/eUKvyTkuJo3Hv6e1gXEYRjYdDp444loclwLwfziGzCFVlGkGoFfH3cYFJycy0D7HYEqfiQ1Kcao3jmcsw6wiCAwjQ8YPKN+MUG1k9PRK9ZZuIMxcl6wStgZLDrphGD4DwjrcAZ/AbKChsRQw6HNd3oyUDd+SeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMW6tPFj; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMW6tPFj"
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-6f6c5f7bb23so1020632eaf.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107693; x=1792712493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXNQLWswl0CI6Q5eA990/VGcvrNcAZnBUckOZaUxd+c=;
        b=tMW6tPFjunhLFxig+Hg9DqQOiaQFUsWjeIbKG2omQjX6vJDT6bqq7S0ReMH957Qh7W
         ALMk4uGiqnS6pT9DJrsbJPd4n0lApZUgMBt0/YUQl9+3bcGoBXNtVtLRgvrlpqsUOGle
         YeKS60QXVfHqfE1uzDb7M+dBXWVPoMea7mJssaRL7OYFs7UlWH/zaBQ1cqY2sauvDVX4
         gWq7IfXe/+d8zM/AGHbOMWF1fcNbRSbTIWjaZnLIQ5z7rKRwIP+I4ncU69m41fryIPba
         8E4PjmpLg3wWq0iECBL+4zv07JJYYz+LIwVZB51Nmw0+6Li4VS8vSH1T6bH90yRQi4uD
         IkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107693; x=1792712493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lXNQLWswl0CI6Q5eA990/VGcvrNcAZnBUckOZaUxd+c=;
        b=p7hwKEsJH7eM0mTys40JsX8G/THrQs3/WXQuDeoA7wnlIJ2FjmZa9tSS2yLbciGr29
         t2xBbsJtY79d668l+WiCsPtauE82rBG7RJ5Yvxn/YzuaIa6dJ0UaUdxjLm4xu6WtAzsR
         KH/G8k4GSjNdiNiZ00jkYRGnin6tlbRyRxR0XVtZ9cq84MIJLMmXWueLMm2b3MnYTIzL
         S0Xdy5iq/xTWt+hKcU2mEUQkfwVf7JkdurS7kR9B6JacrWVM3CIKssG+CMvSGoE1j2Uy
         8iuByT/vjQk/jB9oIL2ju7PGczV/5Qr/lxie4tZ8DTgd7rvdiEwTWX1W0ft0APR9A/ol
         PRpw==
X-Gm-Message-State: AFq9FYLp99klBexaxzITxR/SEBvwRM0k77v6laFqPJKAZ3JE5aHqTB1M
	SEkAchQxWnfwyquty/EV4Vi8WWAJYAqZxiSDlgQi2XfEWBTf6u/lpT3LrQIyCcTzSL8=
X-Gm-Gg: AYBFou2hN8SVgfyFdiOqYyWR0LxORpAgLkVh18C/oO0yD7Yg+aklOyZZLG/QceW1cJV
	k8sEOdcZ3y3MJb1xPva/Wv/8MBd343YuOmRQpTQAC9mR+Uu0j8wyX2fqqxu6L3zjr4YEABzzDf9
	VSW4qDGcgmBiP7Ua1dNd4+6/DgpX7rJAPPYTBC0+CIiQEVP3+Ay9NkJ0gz9omal3AvK7VemJ4P/
	eksedCpgY7V2CC2ubLBPjvkcff0+yQaE1fCYxY29qrz+tLsE+eIg2NfunIlcBuHBImBRqx1HVG7
	KbSmQLKG0DpUGaFYGrnjg5by39ZLucO6L/fwKrwmogbW/Y7RCCOqACKvEVkh7STh93lZ7usjUPQ
	dyssA+FbIz27w8EYyQJq6Kr2xRx2BrTZ7E83HxtW+0hpM8QGadrjHdrNY69OtTh1FIwcAkrLx9u
	S5Aflb7F3/g/EsFykuAJ8KmBsRqv4O8rSU2jxghcYCHc2DdR2qCMGxewdTbc0jRATyjCfS6wT1r
	92s+G/RI+Ipao7+C04iV4Y8O8ofLNCv0i2ZClKzWBArFtGlplXB9YYm6o7sSZXsvXnpluR3C6NT
	DjlxbmWZmzO5Sttp
X-Received: by 2002:a05:6820:4dc9:b0:6dd:4a4b:1843 with SMTP id 006d021491bc7-6ef0eec8926mr17060742eaf.14.1792107693522;
        Thu, 15 Oct 2026 16:41:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a6358dfdsm414646a34.20.2026.10.15.16.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:32 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/15] bpf: Compute the program digest before resolving the fd_array
Date: Fri, 16 Oct 2026 01:41:07 +0200
Message-ID: <20261015234125.3152346-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; h=from:subject; bh=Oue9ytwhhyeNlHsDYP3e6SmOuqxsfR13FuzQ1r2jpq0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3Ku/lc0J7wIj/T4ZLG7N+p543sFcdMfrVfpefRFsfn92 JK7tKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEReVDP8rzBr8X6dtSMqTb3Z1dTq9K o7l26/Zua6p3RQZt2cLd+UeRj+1339HpTzmvsb75cAJ1cH29ev9KeXBr3Vdgt6+yXW+rQPOwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

An exclusive map is bound to the digest of its program, which
check_map_prog_compatibility() compares against prog->digest when the
map is added to the program. For a map an insn refers to that happens
from check_and_resolve_insns(), which computed the digest first. For a
map bound through a continuous fd_array it happens in
process_fd_array(), which runs earlier, so for an unsigned program the
comparison saw a zeroed digest and the load failed with -EACCES,
"program's hash doesn't match map's excl_prog_hash", for the very
program the map is exclusive to. A signed program computed the digest
before process_fd_array() already, as the signature is verified over
the insns and the maps the array binds.

Compute the digest there for every program and drop the later call. The
digest, and the tag derived from it, then cover the insns as submitted
for every program, before the CO-RE relocations the kernel applies, as
they did for a signed program and as the hash libbpf computes for an
exclusive map does.

Fixes: baefdbdf6812 ("bpf: Implement exclusive map creation")
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec136cf377c1..f143b1b18b5c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21041,10 +21041,6 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 	int insn_cnt = env->prog->len;
 	int i, err;
 
-	err = bpf_prog_calc_tag(env->prog);
-	if (err)
-		return err;
-
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		if (insn->dst_reg >= MAX_BPF_REG &&
 		    !is_stack_arg_st(insn) && !is_stack_arg_stx(insn)) {
@@ -23307,11 +23303,15 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		ret = -EINVAL;
 		goto err_prep;
 	}
-	if (env->signature) {
-		ret = bpf_prog_calc_tag(env->prog);
-		if (ret < 0)
-			goto err_prep;
-	}
+	/*
+	 * The digest covers the insns as submitted and is needed before the
+	 * fd_array is resolved: an exclusive map bound through it is checked
+	 * against the digest of the program, and a signature is verified over
+	 * the insns and the maps the array binds.
+	 */
+	ret = bpf_prog_calc_tag(env->prog);
+	if (ret < 0)
+		goto err_prep;
 
 	ret = process_fd_array(env, attr, uattr);
 	if (ret)
-- 
2.53.0-Meta

