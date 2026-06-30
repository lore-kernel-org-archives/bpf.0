Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE21334695
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861141; cv=none; b=nt0qmikwi3cJCDPNgtDp2emLRt5fFuHi0Krepc8nVnpnSjY2w3N+ale+Em5cyao8u5Z9a3uiR/Qdxpk31Pr+PyGD9588lBP0rg5nSieEhhBL0bFdtIrFWpShhw96ftH5a8BCMs0gHGA+fiO5BAN3XQpbz0fJsmkReejAUor7GYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861141; c=relaxed/simple;
	bh=PAoXuoIdyau50EoJqidExIfz+T5WjJ8vukmuVnFoA4k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=S3C2Lx37bJdyC0I5rg/PbziMA6fH+GenNW4r/ttdVI/Re7ZQTZJJTUNU43H5h6s3n6+HYtHvFn+HfAfQTh8ffGvce4SSRut9YD3v6Eesaz0XaH5wVdk/NCh00nYnKOnIiY5hhkr2O5w4wDnmm63Iw0yblincgTCp4LQ+G2z6+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnw6yrss; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnw6yrss"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664b3831a20so4403544d50.3
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782861139; x=1783465939; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sTqslHfm7YPAo+61M9/8CgPQQ50R4xnCWN9rINVapQ=;
        b=bnw6yrssh48aipUY67+cfRW3ZnpiELyxkhuQlszCbJ59Cw++mykGQZa2VMORew3jDF
         PCyXf5dCaCW+tWwpyPdhh3TN0TcOXDL7VwvQ7dkFDd+ydIQ8do7x8tyMZCmoR3kuuLaM
         H8pNyBrbc0DgCw47+FuEbgROzXEITM1R1wrYNNaKvZpVA6Vr/lldHiyk4YDFw48h6vQ4
         FZWthQM9+G5nI9J0tc78SrHYw5UYGafis7LD+sVJ0cT6mWaRaBaQ+LZ3bKWo/YdYYLd5
         0FujENFevoV6nu/fEaoqNFvG+dOypIyAbuMQlHagCVd2SWBjoJ5JtulSpeFK1Hzyfrr/
         OPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782861139; x=1783465939;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sTqslHfm7YPAo+61M9/8CgPQQ50R4xnCWN9rINVapQ=;
        b=sKx6/khQg1D0i84V4mu7cVLsF3UiV8Xxov7GUYhi0cFhZ4OAMqnnQ58/pTK1bFTAQN
         bGQbJ/b6eeZTEia1nREFb9/rIWJjRlxQUtXtZR6ToOvabmF7kKZN33IC8teuGuNYsBGz
         qHMhfjfSCPX2vdubRade/QqMTyEQV9KCy1haOq7pWd1lCtg65kUohBrDRM8BxQGVgo3L
         PaHWa0NKAC9cU98KL98FfCRrey1+7yLrMI8jMbvl84MdOG63jWgrMdrOO2vsAV/OVGTd
         gSwUIBw/HrGFxmmKtmayd/qrnPJgIihyMHdw+1+hMhU1Ppe3qXsip19cnaG3qqqz1Pj1
         cSPw==
X-Forwarded-Encrypted: i=1; AHgh+RqpY2nEFY6E4CjFWhzhFFzpPNDOjDZf6zNyVZKpS/pRy0PMU9MSTLJKsHYnoatXTWEtdtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ds7pwqKndVpcuhJW2d8ceqSm64/NX2v/xI6+6BP3iHTUoBF6
	mxhr5Iz9OhT9+FBg6dQx4CxB1CZNGvLXyDDRG5TikJZ/wN6UBwnCwlpJH/zh2w==
X-Gm-Gg: AfdE7clrSqBKtFXcUa0DWSHEoMX0OfFCE4dimCpB2JzP2Uy4jQTa6HQnV2ie3Jwu7jP
	qjHmP+NgMW+OAoaIAKxOs/g/B23np0X62TDCkdI0hOGnYiJ+dG9RabkgAN9eltFTRgdDQgaIA+y
	JLOVFwJjcQXBrt9ba26wLd5eAQI1ySKt+4Y3lTqpgLNJlWo/mWt3iiiFaG+2KCjgCvrVbiOGAm3
	9M9C4SLZDdq9bbaCUHB6f40itnhvFbUH5GdUmwcFne3ikIdY4d/iCVVZ4PWyQ/RUhuD1SQp97Gb
	5rO0UFBumIhRv2O/fpFDNC7wbaMVLy05lZzrjiCu9IaRIWDpgDprKmJoOCHEyKquG1nqQB98lUE
	UOlzrcW3Wivhk2wOxJlfy1B77Hwlgd3SCj9824VhGaAwLyCSuMcKOQgxUD65a/K4m2CAUe5ed7c
	jWxje6AWDhgsrGHA/MAGndSN7zGQz0zWglZbxfA924K4JD3j8wYVkd3g/ry5q6kXVuJQ1S5S/ZG
	7mBZ0I=
X-Received: by 2002:a05:690e:43d3:b0:664:ae6a:e9a4 with SMTP id 956f58d0204a3-664f9aa663cmr3885463d50.74.1782861138496;
        Tue, 30 Jun 2026 16:12:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-665016d577asm1483322d50.21.2026.06.30.16.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 16:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 16:12:16 -0700
Message-Id: <DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Shuah Khan" <shuah@kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH bpf 0/6] bpf: Disallow interpreter fallback for
 interpreter-unsupported insns
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260626154330.33619-1-leon.hwang@linux.dev>
In-Reply-To: <20260626154330.33619-1-leon.hwang@linux.dev>

On Fri Jun 26, 2026 at 8:43 AM PDT, Leon Hwang wrote:
> Sashiko reported two potential issues about interpreter fallback [1]
> [2].
>
> After verifying them by patch #7, I think they are real issues. With
> LLM assistance, the interpreter does not support the internal
> BPF_PROBE_ATOMIC insn and the gotox insn (used for indirect jumps),
> either.
>
> 1) the user BPF_ADDR_SPACE_CAST insn
>    the interpreter just ignores it.
>
> 2) the arena ST/STX/LDX insn
>    the interpreter could hit the BUG_ON() in ___bpf_prog_run().
>
> 3) the BPF_MOV64_PERCPU_REG insn
>    the interpreter could hit page fault, due to loading memory from
>    invalid __percpu pointer.
>
> 4) the internal BPF_PROBE_ATOMIC insn
>    the interpreter could hit the BUG_ON() in ___bpf_prog_run().
>
> 5) the gotox insn used for indirect jumps
>    the interpreter could hit the BUG_ON() in ___bpf_prog_run(), too.
>
> Reject these insns on interpreter fallback path in
> __bpf_prog_select_runtime().
>
> This series is built on
> "bpf: Fix unaligned interpreter panic on JIT fallback path" [3]. The
> patch #7 is also able to verify the issue of un-JITed helper.
>
> However, The patch #7 aims to verify the issues. I think it is not
> proper to be applied to upstream, because it adds a stub
> 'bpf_jit_test_fail_task' to bpf_prog_jit_compile() for the tests.
>
> I'd like to drop the patch #7 in the next revision.
>
> Link:
> [1] https://lore.kernel.org/bpf/20260608151347.2C77D1F00893@smtp.kernel.o=
rg/
> [2] https://lore.kernel.org/bpf/20260622150759.EC9071F000E9@smtp.kernel.o=
rg/
> [3] https://lore.kernel.org/bpf/20260615025316.24429-1-yangtiezhu@loongso=
n.cn/

I don't think we need such fallback in patch [3].

And approach taken by this set also doesn't scale, since it splits
the verifier/JIT logic into core.c which will be hard to keep consistent.
I think we need another bit like jit_requested in prog like 'must_jit'
that the verifier set for addr_space_cast, kfuncs and the rest.

Then the core.c change will be:
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..5126a43c1b81 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2620,7 +2620,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf=
_verifier_env *env, struct
                goto finalize;

        if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-           bpf_prog_has_kfunc_call(fp))
+           fp->must_jit)
                jit_needed =3D true;

