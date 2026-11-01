Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559993;
	b=26UKBtDN1T4cqVDgGVSRbNmMjgID4d9/rW25D6OjPlDCpau5h+wJgRZECOtQ62qrCeeW
	 v7bW0oVrYUglHgoc76AwTP3tAPSw+x7lyrpu4OH3YkqNRDw1519SMW48r7kyfgQuteqDE
	 QL7TfnVO/dv1I2sYNhojeLLTR7tRWy0avzANn/8rl1/1Jwm2wJgJAjebU179FGQl2ghYl
	 AxqJoPCxeGio0LwV+Nwtj2SnScXXtA1i2lJfoU3qdy/TFoTQiWosbAsu3BHy4gTLNJgox
	 01ovS+MQjh7WPI9RXDoxFAWLRiu0m4zHAsqCmdcel9dn3/z+430HuXjxHzUg3+U+s5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/j5NKGrL+SffqVVvzist4S4FwCKb9cxuYmbaWGqRFGI=;
	b=AFd/EhpSLBGlLGTBxEYvjbNpdnWT++ABb3JH8iqWLKpe401V6F2s49q9AExudrH2plHr
	 LcYxCSXWLYUT0leiyR/UTGM5NJPa3J1niYlTuq4Kf99EaPG3SpRdZD3OTf2kpE1hk0hye
	 bePmMf4g0NJllXIEpW1trRrd0Z21WqjJN6Cj4IXCQfiEAK4DSEWP9VkYqogJXTExVbJJk
	 mw2c1UgybzysApX4o4u8ZODc1CiA7XVGxUWxfZwb+fZs1ZGtZvN8KKjgDv44W4vKUCm2a
	 /6pp08Eymxlcms0WUcx65NQ90U7wDEv5wOzbyOgpeAbRjwApj0HM3LDjut1vrp5l/NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NsxynuN4;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F88606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15F88606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NsxynuN4
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1204327a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559992; x=1794164792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/j5NKGrL+SffqVVvzist4S4FwCKb9cxuYmbaWGqRFGI=;
        b=NsxynuN40lnHS4mrsV7mWmSPEXZeWzHiBIUAQr9U3CH56TTUn8iKE91EqbuqNf3goC
         pGTJNR0adCXpzjFXfiLvMNoKMORdxsA1Rd3sAFhKKrmXoCL97EgeOtbkZ+uk+JZ5e/cE
         w0VDjhSarbtJ1Xkhd9LPtFftSxZOZ36zI6xWTKIJw+d9G+sZtRdV0QxQK2SxlNafbSqb
         Fb+yyShubiK/hzmQqCIAd1I8Jz8+oAxOvXbSzRuMjYQy+TFbZjZWThi6BKKCtndnlDkD
         ijGKDUD5Z6fXD5DTIbnVlr7PRcFcs0pAmztdZlnaM0kZ1IXEypxUgCIdQXiLndR6DalD
         Nf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559992; x=1794164792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/j5NKGrL+SffqVVvzist4S4FwCKb9cxuYmbaWGqRFGI=;
        b=NiZYiA138p2ejxnuBaMjtqaKwetSgQwskkoU8hwf/4/RxGI2dEZj1FhR/ShQ4Pxt4E
         wPSk3YVWFZqOVKxxrTe0KghO9VmAOhd8cZ7Jm+ETVBk8hVGW7hSx5J6khnSZeEEGqzbQ
         K3294MTDoZxu/YRBCTDatzXLgyml/k2ZAPxWeRIUYOBhUwm8dZwgDtdBC1rPhpyecnTA
         vo2nIuIDKvfnCs9j8NP3/NztCLTQsOE8lR0xTPvZ1AiVyPFdqH3zsuBwB/QEWPk+YN94
         LNAsH2owbmBW2+Yuux/nJYajFezQIBg2aun/xqyJc9EvSGs2XaA2BxU5B3TDSrU9Pqoj
         Ig5Q==
X-Gm-Message-State: APuU4Z+MxBy2cMdr9I9XwSYBq6Mwb/X9IABIffY+HdExDcZwxK3s2lJY
	K/P2jMAM5UAJYsjn/jHDXP7G8Ap6G/0i/s5qOX/w743xoX+7dYc7YC+AJX5XRw==
X-Gm-Gg: AYBFou0ca8wGWfK1JnMcsWwufLNoglgmq8mnTUgYsuOExPdoYlVElydVpcQEFhjOO4Y
	34UiW19B/PCEPa3RWaJjKKkTqRidIfBM72gK2+cun0qQ71YFFkePQus6xInhlIKhy1tMSnkSv/K
	wDKdH+8iJKf12f9CZMT6U68SFpSHWAnNUUR5EpPbQqY8dNDy5Jy5UH4j68v8sKfZqYxJZYRM59B
	PCczJzPRvvylDM12dI1oiJzsdpUXvlo/iaR+Rq6mfkbqKmUCrW9nFZyVG8A/Eg1B9+8GdrNpBKO
	r+1WDTjCShN/EmSvIKoVJm/bDz6QBakUryDXd3VZ5/Qrx0wp76GCex5yAyJEDUnR1Z9EjGlqbHX
	dC+05F5Cr8PMfhowThYD4fObzY4E/S3R0nsBeYNHsxWnJ3ahGon5fIfLNlUu0DBrsnOjvew4O26
	Jvk8EiZaitEoitaWTHtpOT4xWqjlpk7i4R4e6YgRCa/EflAIPOhdNw66jxq6F2Y92YxCfOmnsrY
	Imp6pQiTW2cbOXVzIRvSJp0yyKqJS1dI/jqqxFp9rvFxpuqwhQN/hhhCEcET7VDOMy8JkdK7MB2
	qUMgafv8IQMtfb6OlOPYxwlJ7YsgNgRtt1ZjNj9UFLbukqf3jqtgfLGvKMHaLlo5Ul639k4hiOu
	Wm2/bGt11O6EIWtZK3ljSZT/gp69odCZ/qjXHi1mCId4oAraGxfBAqT1S/bDVp1y5imhRvlEYYS
	Y=
X-Received: by 2002:a17:90b:3d8e:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3ae8979a140mr5844718a91.40.1793559992173;
        Sun, 01 Nov 2026 11:06:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9bc6f7sm14837968a91.16.2026.11.01.11.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 09/27] bpf: Don't turn struct arguments of KF_ACQUIRE kfuncs into memory
Date: Sun,  1 Nov 2026 19:05:17 +0000
Message-ID: <20261101190535.1454146-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When a kfunc takes a pointer to a struct that has only scalar members, the
verifier also accepts memory of the prog. Then resolve_func_arg_type()
changes ARG_PTR_TO_BTF_ID to ARG_PTR_TO_MEM. This is correct for a struct
of parameters. But struct bpf_cpumask also has only scalar members, and the
kernel allocates and frees it. Thus bpf_cpumask_acquire() returns memory of
the prog as a referenced object, and bpf_cpumask_release() can free it.

The verifier does not change the argument that a kfunc releases. KF_ACQUIRE
does not say which argument is the object. Thus do not change any argument
of a KF_ACQUIRE kfunc. Then the verifier rejects memory there. No other
KF_ACQUIRE kfunc takes memory in an ARG_PTR_TO_BTF_ID argument. Add to
kfuncs.rst that a KF_ACQUIRE kfunc must pair a struct of parameters with a
__sz argument.

The first commit below added the bug. Later the struct had pointers in an
rcu_head, so the verifier rejected memory. The second commit removed them.

Fixes: 516f4d3397c9 ("bpf: Enable cpumasks to be queried and used as kptrs")
Fixes: 8e07bb9ebcd9 ("bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 7 +++++++
 kernel/bpf/verifier.c        | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 73578a4c3b1f..329d1510b02a 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -407,6 +407,13 @@ referenced kptr (by invoking bpf_kptr_xchg). If not, the verifier fails the
 loading of the BPF program until no lingering references remain in all possible
 explored states of the program.
 
+A pointer to a struct in the arguments of a KF_ACQUIRE kfunc accepts only an
+object of that type. The same applies to the argument that a KF_RELEASE kfunc
+releases. For other arguments a kfunc also accepts memory of the program, if the
+struct has only scalar members. struct __sk_buff and struct xdp_md never accept
+memory. A KF_ACQUIRE kfunc which wants such memory has to pair the pointer with
+a __sz argument.
+
 2.5.2 KF_RET_NULL flag
 ----------------------
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53272f50226a..cc2ba4dc9da3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13574,7 +13574,12 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 	if (base_type(*arg_type) != ARG_PTR_TO_BTF_ID)
 		return 0;
 
+	/*
+	 * A kfunc that releases an object, or that takes a reference to one,
+	 * needs the object itself: memory of the program cannot stand in for it.
+	 */
 	if (!is_kfunc(meta) || arg_type_is_release(*arg_type) ||
+	    is_kfunc_acquire(meta) ||
 	    base_type(reg->type) == PTR_TO_BTF_ID ||
 	    reg2btf_ids[base_type(reg->type)])
 		return 0;
-- 
2.55.0

