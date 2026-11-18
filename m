Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795012918;
	b=bbBena2cGk2GtiocmhiwhiSuhz0+YsDrHEFbFMZ1fs4IG713BNspWPYuwOUCRINuGIzB
	 LbNhg1j9mDRlp1xgzwCLu7nMbpTGCHmA4SqlAftkz4NeI1hJxktZJMs53N5UffE986CgX
	 Zk20ZPwdCkiqddfOnKUnvbtTVB/BGiJhYihtxbkrg44v9us/ZhPM7wxy5Pqezc5BUjXLN
	 5BzzDBl//au306ALhLkhvbaKeyPYAxfbHFwC+W6FDp+hi5O2+kXupB7jZx3YPiRokqsFn
	 WRxn3FaOCHR7QZSNqZ19OGOKxmaiwHcl86hJ0CnrUi8wVi6fsg5fUPHwKdCX2jXg7Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=WRSAwcPpVvVL9pia2YQzeThyWzOEL1AWKpkFwsSYKqY=;
	b=oQvHSnolD7l7rUG1ooQQa8XnS155bT7kE77EFZKXaBJiboZ56Sjqprj284S0GnBNh/Ro
	 93sSp1oaYebWGDEFGC7ohr41qNrxT/Nmh4D0Z3STN9ZxMSTPeDasExz5FXYcU1ZFybWO2
	 AoYGpG0X5UsGYaOwpF9Ujrr1d5mye8RpN7QvpbSU9Pw9bMYmDp84VssU5w0m8yamQSdB4
	 69BjYgVlpPDSIPuRYP0VSXGoDTWMKB3b/c19kf9Kk+ActwYGfCIw54Q0KGhyz8fW4B0ej
	 kOXn33Lxf8OyLTg5rjszR/o5biJjuaSZo3q8qeMSrgnE2az3dx3f8T/WNPE3DjLdjlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7+eyrcC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.67
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A074606A338
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A074606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7+eyrcC
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so989783e87.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 06:41:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795012916; cv=none;
        d=google.com; s=arc-20260327;
        b=eex/mIZRB2yILdbGQazg6ERk+i6+qL4/2kEGl2cuq3BCNfv1o+uZZ8pBxL7vRkBdeE
         IauCz9RQELPcEa+sy3d7l/jHCa3jGiYvYa+VdbG0ZIHrOAPxCNRorPpQarmDoMkJ3CXZ
         CLhkI0TvTrNn8PJCJgUyMd43unMnwTQ4KRG1Zy2nnRiN7VPq3JH34WLlvKswEF6Ercsa
         6tPF6ecdkqXPgt5nA/trSSOyYmlGZrHKesQ7oUtqnG8h2QlDX1xiQ3SNizOnZcYogvQX
         /x6OA/98TlcSL7YyYqI4hr5Y0C/TpNlZMmJdlXQfUMLW3vmqS5ug8MJwaLdgtGMUyv9D
         EiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WRSAwcPpVvVL9pia2YQzeThyWzOEL1AWKpkFwsSYKqY=;
        fh=rpprWDXgiOO6TlCZVomi1Otx+vFQp2vp6uJmDRhY+mc=;
        b=IxVaNJvIjyrOdq6tJOzH7SprgojjkmemiAwfkQj3Qj6zWNCFQESqyHPv3FsRumS0Bq
         7fF9+uCQjRLyr7WKvX6Mv0g/yiMswq0TxZsF1LEjGk/tIgvLyK/qhfqJeOGZr/8Zb5Qc
         chmJkgY+d4IIrq1oE/Pjj/cthlX7uz03QZN0YDvXZwwgM867yZHbi6NCP9fRXN5k7x+g
         B7qsd4EKPM94gLPiS1pFfZszVfOjqHwvhnHdslG2c1d2YPIhTHkioL1+BVedehP1SrB7
         iF6tJNF6zqt+uaA+koud0ewa2uW9BR8OMI5tB1EZaS/s/BrrZwyGq82Zr5yREEes5m8B
         BVlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012916; x=1795617716; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRSAwcPpVvVL9pia2YQzeThyWzOEL1AWKpkFwsSYKqY=;
        b=c7+eyrcCPVtSUQWEPiyBFza2kV+CTuG0CYzia9HuYEnrbJRjBecC0oApUOiMMJ0de/
         j1dJIEnJZAugQKEkMsU7yWgAlmSeQD2c10BBNSqGW3fbUN6UTLMXTMwzm/HOKc2NLXLW
         GXQ2yY4B2N/6r/wgaadoxPCl7J7+W7X53tkGx3LKH4ocNo4gPcQHPKkiDYAUOF6EYB+L
         RWavboIDzIw7hLEBczoWznRRf0OOBDJHCYkXup3S+s+oj7i3tP8niyqqtaAGSMFfVdTn
         F5bG0c5yNVvrMV3Y7RKnHjwSvJI4tSXlmleAfN4EeDrGbXmiYylBFOU9VXoUQDk8/SxW
         wIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012916; x=1795617716;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WRSAwcPpVvVL9pia2YQzeThyWzOEL1AWKpkFwsSYKqY=;
        b=vEOxM3RgORbXoHxEmUZ56odjihautYcAgfBD08XGMQR09KH920Cpjt91+8Wa2Ekp68
         BcHSXElHIEmeUeFrCnYfitaUB3nssFSFobF1tEx6RSus8Nledc7BBYxMq4H8uyDT7ENc
         duUzk6TSYP4HA1j+WGYV3ohRFNocJ8YDChtL/LycfK37sRcJLOe2V/JtWVJCZ7+b90zw
         eYwDNb4P51874lwHYY10j8jAI/o3m3nsXtgyDDw2oqmfytsFqNL5mCdwFeKpyMy1Evlq
         Kt+Q2tPs+qkq2/PDSfGDOMX02BIol4Ui4fUD+Gz7LF+rYXBBsErjOg80x0AOb0HSkVvU
         XRfw==
X-Gm-Message-State: APuU4Z/kvk3eWqwT/yeHRzobDeGd/lC0VV5D6bbT1yvlr+HhRtTDNMjk
	f2hO6mCeLdXvey1v6QJlqHm4Y46eEmeHJA+Ku0yFXv/f4SVWRAaa+C7SFtjAgYKbIIcClSjpnW0
	6rnhf7gCo1upCBhYpq1H2oetihmz0SVM=
X-Gm-Gg: AYBFou1akyD8nC5pUBAV9zfJugGuRiAbu03H1h02QY01I1qqJ94An7MvcKfXVrQsOCZ
	WSY51wQB0FRO7JSwN9vimEKN0Fw5MJJ2sJM7DV5vsdUfjUxNVAUOrqTnKq3kLtus1FXGCC0ZwwI
	N7/JtnUTqOauAhScPyPCp32FJXt3aYSEY0RKlIcBta9utH2MxCyRYFuFmz/I2xUT/EhHWHoFnbK
	iUTzXN277wVF3QDUc+9VUUMD27dpX8XGRqA1+e8t+e7JG/nbKF2w8LsVYEUrxwy/Qu/egj0qM2u
	7cB6E4X5Cv7QaX3kUP0+L/viPN61VVwAl628nUX84W0K/lbhiBJPTcWiyj6sFeJomB/wGsm8ZLC
	QT70FZr+dAzw7xsFgKS/Y5FfPnAmWWjNslxdxUQ==
X-Received: by 2002:a05:6512:3f28:b0:5bf:a34f:14ce with SMTP id
 2adb3069b0e04-5c1a0ef79e6mr1989965e87.11.1795012915416; Wed, 18 Nov 2026
 06:41:55 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112134942.288831-1-shlomojune6@gmail.com> <DMTHXFS504S9.2BU4PDLEWG3PX@gmail.com>
In-Reply-To: <DMTHXFS504S9.2BU4PDLEWG3PX@gmail.com>
From: J4f J4f <shlomojune6@gmail.com>
Date: Wed, 18 Nov 2026 22:41:43 +0800
X-Gm-Features: AclHuK9QDHo1yz09H2q8rKyDe22fgjuz0dzQ2yBYPTf4oQjXMD1IbeM927twSjI
Message-ID: <CAE_LbwmtogEFvk5jDUcYhjSaX7_5bsHy-OWxCKPxmiBVDcjj_w@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix cgroup link update after a failed effective
 array rebuild
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tadeusz Struk <tadeusz.struk@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 03:57, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Nov 12, 2026 at 1:49 PM UTC, Shihuang Liu wrote:
> > replace_effective_prog() uses the position of a cgroup program list
> > entry as a physical index into the effective program array.  When an
> > OOM detach falls back to purge_effective_progs(), the detached entry is
> > replaced by a dummy but the other entries keep their position, so the
> > list position no longer matches the array index.  A later link update
> > then writes the new program into the wrong slot, leaving the old
> > program pointer in the array.  The array does not hold a reference, so
> > the old program can be freed while it is still published.
>
> I doubt you managed to reproduce such scenario.
> So wont-fix until there is one.
>
> pw-bot: cr

I reproduced it on f66469d9905b39 (7.4.0-rc1).

[    4.307527] BUG: KASAN: vmalloc-out-of-bounds in
cgroup_bpf_prog_query+0xdf1/0x10a0
[    4.307589] Read of size 8 at addr ffffc90000073050 by task exp/74
[    4.307593]
[    4.307597] CPU: 0 UID: 0 PID: 74 Comm: exp Not tainted
7.4.0-rc1-00536-gf66469d9905b #3 PREEMPT(lazy)
[    4.307602] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    4.307605] Call Trace:
[    4.307610]  <TASK>
[    4.307613]  dump_stack_lvl+0x53/0x70
[    4.307622]  print_report+0xd0/0x630
[    4.307628]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    4.307633]  ? cgroup_bpf_prog_query+0xdf1/0x10a0
[    4.307637]  kasan_report+0xce/0x100
[    4.307641]  ? cgroup_bpf_prog_query+0xdf1/0x10a0
[    4.307645]  cgroup_bpf_prog_query+0xdf1/0x10a0
