Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CB32E6A2
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758527; cv=none; b=O7g52bU1WdHUuJfcvPjuB8MpmmIjcMraBNG29gV3zf4F+Xen4bGjQ5fhfFebRnnq8+I7xXBSnDLdJ6/Qwtc0WEvQqTTwHnxYfLBuMOI8jFFwlXaRRGamReKj79HhivJ50SdEPscv+04KrxXQPJt9EkXg2qw63vJrgazyRUdK+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758527; c=relaxed/simple;
	bh=SZZyyFOo4ipSn+s/JnxYiRFx8kVcIC+Dy+zK3yvV4XA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFXFD/5BED/7kAhQ4nOrwwjTCDxaYQXae1MeXnWXd5aBhY+3mwsGVQlnEzMEK1flLoIVvvXyST8ZqhAHWhAvNjBGRW1Myy1wwaHtH98TTsVEtD/M03+z1A6y8PZrf4DwDblu2fCt99XVF1HYPBxPTJdN1RZYJoglob8HKBVm9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1FIdCLa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1FIdCLa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so11532415e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770758524; x=1771363324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFMnbyIMFWqCOPwVX2vRxrTvT44BLLb27MqwwaXgklk=;
        b=i1FIdCLaiJqbKgdp8C+FaDV65JhfcwzKbWEJiI0YwBHsKNSjo7D1mI2lpxHXPWU9cN
         U9sKlBxfy8+pcv+WoxhVER8JwCoTe21lxgliNESDPf4TrJPN+TJgJxOcUkqpQznopRsk
         rDVkzq+Jyb+zSuFswWvZgpdB/vpVyp/WYWQ3SkC6vel5hvkzjs3rpvN6mq7jvn6z87zz
         HGPwQQGDkDDpPmXP2/307rUqofgYmpctKXWEPPyyoHJH3M+/cRYQ5+Nt27ExkliVX7Bg
         4TMrdkibi4dJONnlHq+t26TKwe0Uim0kfbcq4igvXjSaU/95meIe55Pq/1gRegl3pPQF
         TQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770758524; x=1771363324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFMnbyIMFWqCOPwVX2vRxrTvT44BLLb27MqwwaXgklk=;
        b=OqdZk8MO371BdIloaSenxkmAQ88jWzLv9xcOyWjuHLrCilyjtlLC93AuWMpJoGP6V5
         NIMOYOfNmh1TECPZa7rsfjy1jMscD3csE33ImiykCWRAI49vWzIfuw3pNecbKg+PJtNa
         Y/ZnJXQc8vveeaxfFXq16TEYUFlYXfUe/pKlHmd+mEs54P/MEcLI/OfoY/ifUftAdSrq
         yH1zALDEgZBR3HR4MVWGf8sKwL6wsN5wTJxfqIMguCNszEBkDNjHeSl4l9XgShZPiY6H
         aWYtuM1lCGNCuC506lUwp8sP2yvj2yv46Fp0bCWnM/mhq++QyZzPDS6n379YplA20UhS
         GDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ohOuTG5whAPwcKxK9fh4dZgWAiZaFyyVS5NXE9MtgGOjozMOvXq0uNNLFyzZ5Jke6qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJWUJ5TC9fmGxtJ3x6TH57WwLBnMSwQoLVHqE62fBBF2PRM0F
	GNCqM9qQ7xeeV4ZJTVlJJhyYfDEDAXhepYePZzOm35pv2bK0Zeo5bVzu
X-Gm-Gg: AZuq6aIhS76jC4VZrcHpMWUHqfT2TOl1f7jmeMuXSrTFVKVC6ZlmKFZrevHNT2CzfIS
	Gf1JcehkCRuv6L5zUneohsZGB9sMcBU4bRPyGcijCP3Ic2Dc2NDfjYaVI0Cbu8HnzErqGKJLWGy
	UpfxZzjhAJShIgNUHQzJYt8iU039gOBqVgX9T6/TZdf7HeC4hfjklsWi+da8sCDsfmmy1wQxkmH
	lWy3OWvScZeqCf1DrRhlwUDOtU/xhhM+5miLEFfi6GuMZGhSOnNQK71Ikn5DOQPE8ohx4YD1JDM
	DrLXFGwZHaMNrNWPCsFd5XyGYUobxbuZWzUPqDQtBhAwqIT/G62ymloFQDPRg2oVtyhAwp1WhTJ
	l+3D0Q/NmqsqQAI1CHSkheW2TwaDl9Fq4gB5pbDv6g6k8joRGVfCoHj68xFEH4PTDMRAusEn613
	x6bBJY3MukVpM=
X-Received: by 2002:a05:600c:3b23:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-48320225ef9mr241947475e9.27.1770758524058;
        Tue, 10 Feb 2026 13:22:04 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7d53c3sm91014225e9.7.2026.02.10.13.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 13:22:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Feb 2026 22:22:01 +0100
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 4/5] selftests/bpf: Add test for checking
 correct nop of optimized usdt
Message-ID: <aYuheTlS8QtYbi4b@krava>
References: <20260210133649.524292-5-jolsa@kernel.org>
 <189eab8445c1c9fa3b7e4c6dde23b4a30dc7f63ed2d3df62a1f8c889280f5927@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189eab8445c1c9fa3b7e4c6dde23b4a30dc7f63ed2d3df62a1f8c889280f5927@mail.kernel.org>

On Tue, Feb 10, 2026 at 02:12:09PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> 
> [ ... ]
> 
> > +#ifdef __x86_64
>           ^^^^^^^^
> Should this be __x86_64__ (with trailing underscores) to match the standard
> GCC predefined macro? The call site in test_usdt() uses __x86_64__:
> 
> > @@ -516,6 +599,8 @@ void test_usdt(void)
> > #ifdef __x86_64__
> > 	if (test__start_subtest("basic_optimized"))
> > 		subtest_basic_usdt(true);
> > +	if (test__start_subtest("optimized_attach"))
> > +		subtest_optimized_attach();
> > #endif
> 
> Without the trailing underscores, the function definition will not be
> compiled on x86_64 while the call will be, leading to a linker error.

it actually compiles, interestingly enough __x86_64 is allowed as well,
but it's a typo.. will fix, thnx

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21867569087
> 
> AI-authorship-score: low
> AI-authorship-explanation: The commit follows standard kernel selftest patterns with a natural coding style and contains a typo characteristic of human error rather than AI generation.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: The mismatched preprocessor macro will cause a linker error on x86_64 builds, preventing the test from compiling.

