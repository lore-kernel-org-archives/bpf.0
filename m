Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A139A4AA
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876038; cv=pass; b=dwjB0VGed+oBN1GH2fLYy4JscB44jGvdParNsbQUWsJxhvl5daOaumbAsGLmJoOjMSVI7KFmeFS2Rfii3mki6LMuxcyn/raOFxVKutD/n+KvvREPN8gGx8mvVig+MmNolzWP0uzOZFBRfwVrzuFOIdXFtiuzv2qYNl+lHaRgx64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876038; c=relaxed/simple;
	bh=1qBivE5gHnpwRsnieTy4VVDr8iEogrx6wD8+ggW6J2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2FeWUEoSDIhpelu/cTg6lnW6ucQ/wCxnzzPhOxuNAJIUAAXTAo/INmgKSyHZ24X2kovS21VP/H/R+oPu5tQsqRuNgptMOhu6CIz/m3xAxwZb5m4je+NMc0zoTXMoHRxdTTslJNMILn9OD4K/q+9ul34niUL2spBDT/6BRyqd6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVTfaxV4; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVTfaxV4"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so71728a12.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 23:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784876033; cv=none;
        d=google.com; s=arc-20260327;
        b=PqDJDVE7j/j4eb2K2jGieV2asCyzx0OQ+NVFmqvSw9r3UWdwMn0pq6Q6yE/r/yrAYA
         0Cr37XYPlB7X91CbxNcLOriubVTEA3+9KiseYkc5M1UOQ6B2Wsq+IpNP29rXxCECSdpd
         p52VRdasgglcMrMSKEwP47eCx1eKWvxr8sJursyV5yyH5M6Uv9K0nSszam3k50BV14xx
         WFwdKnaS8dlvY7aubiXLnIbPpa4ygIKauXKbukuBwsj6CxbG6gLDecHzOF01j1DcUuER
         H1aS1f3wCxegkd1+8AUcQ7xOdzrJ6oAPyCQJBMlwray16IxWEqV2VeSuqi56MzWPesC7
         4R4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qBivE5gHnpwRsnieTy4VVDr8iEogrx6wD8+ggW6J2M=;
        fh=FicWmH1SogLT4ffVWiE3nDl3sbJCCIgKwY0CdwrVyPA=;
        b=UDQr5J79mVnn9/HndGi9NHb3zgn0pPMB99cmBMi+djdlC8BSG9nqnwgkNGlpMgPQWc
         CtA6eigX4dMEBikb/YEPB3e4snbsLfyXvS0vnbhkkMfPhAyZ6UWCcpG7pVVuklMbcypM
         2kfi37F+9S21cyVIQ+pX98hjSUfhqottumimPrDjcuV8fiAeK5Xthe4PkSzn5+TzGYk7
         rfdQe5VMN+dgJOCWWBeww3WvOgdpEkNPAN5SfYPrGr2g8xPHAxtiKZyHxZ1qWNtGwtYK
         Zhbl3H4RFWx8ist7zeGzEAfpMSn8pVhA3JVDdGPBYvNLW3iSvoLXOI0k+StEWTV4m2uA
         yzSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784876033; x=1785480833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1qBivE5gHnpwRsnieTy4VVDr8iEogrx6wD8+ggW6J2M=;
        b=LVTfaxV4tmSvA0snLCPFwyFqd0t0895ohC/4lET/FZvS4s6h/fjvEwsUwd39RrE8FY
         3TSeyvhyxVTCPtpIbqeEhVrqXQKaLrM80yADLxdFYIXxtNvElBdduPBrGQcLfAA8/hzG
         +/TUE44+baF03gMXzga5UhPQOgmq9BsKvRtMyvsm2FtV8YBugz6pYUptsqp9HgAcUDGe
         Sra4qzKIzhMT5NG0E22aF//JHCiK22mLEq7lMdpTZhn0rd2TqhmoYPDEsyhlSeZH5bi2
         063EkzwG7xteum3Nj3m7GoLXffQ6ZUC4uKKp9ubrLwK5ipQuJ7/FyyEmPXeYbpSuO4ph
         Bb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784876033; x=1785480833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qBivE5gHnpwRsnieTy4VVDr8iEogrx6wD8+ggW6J2M=;
        b=AufrYcE7msw9KZ097nB2GsF6EYEOZ2ecc62f/4va83J+qbx8pK7xY3t2GtZE/ZnkSR
         Ssj8NvqQyINuUaxvKISzbOS5FQJNHz3eHT6AUXYdxIUXInXOqWeocfOOkzjqW4oi/vjp
         WZCVpZgi2y0hR2uSv/HvoWGn7cL+9qAFliQWTHszOIpyWsNoC7HqI/SuNkFnhTJXk5XJ
         fIcTOrdC4Uib1KDYQ+G+bK0dQfTmEjyrQq+ITRZLQDtB5PwAdnJ2AwHcJDJD87xrDITl
         DmQ1JaBUc938RXd1ssDzynoe/KXki1Y5ozYSrOMNMHolI5zaI2Tf/MdzmQIMiND7hgTh
         13BA==
X-Forwarded-Encrypted: i=1; AHgh+RoMuF/C7c740iz29QUVQSIKFVMEpZ3gjfh+rEan3DddlroaOlLwRcZRbRlZuqO/KFcCfQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVx/Jwjy6EEJdkZiQMsgpLTVFQl/VR36hfsfz1xRMPrsi87Th7
	+kGFifX9ulOATqWWlVrNXl+LiBU+xJJNtRyq3laUsl60UX+3JOB0S0KPrggHw8WzcwfCK/QPkTJ
	PUYe4AgWnfHog3rk7OchWkSWemk7ir5Q=
X-Gm-Gg: AR+sD118P/DXHP1+108wJ8u+1cVN0NwH9ULew00xPyYeqnwLBNPV2dk9GFZo37YbMKY
	9Sh6avjV2CWGsmQVlB1BuFEDBfARKeiaMto9P/Fko7ldqdu60Ge23w95hDVOSSeoFL5TJHt+vbu
	58xWO5ocNpM/XbKgQ5i0q587K8d9ibCcNNqsCD8snj9NsMi8KRL/+B10x2q99yzNttwK+uOhJOl
	FMA+sFHMblnVDOujgL+y1CMsmwOOcro0EdCqNKq8PGMUhSY+zgDSwEw2b1gwxov21EGvFbvSSM=
X-Received: by 2002:a05:6a20:6a1d:b0:398:76d4:c7e9 with SMTP id
 adf61e73a8af0-3c44ccfad68mr6602250637.35.1784876033443; Thu, 23 Jul 2026
 23:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGKGUvm6sC9ay98zsYJS1xwB9+qUwverqAsAAwpVOpmqFpEy5A@mail.gmail.com>
 <2026072436-carload-untaken-585d@gregkh>
In-Reply-To: <2026072436-carload-untaken-585d@gregkh>
From: Min-gyu Kim <gimm78064@gmail.com>
Date: Fri, 24 Jul 2026 15:53:41 +0900
X-Gm-Features: AUfX_my_818fZNEZbBLLr1Xn5hBLUxeeu8JcRW55Az57jmjGZCViGOAZ8x97MLQ
Message-ID: <CAGKGUvk6sOo4kMV0z20Vaq-eAAJn2t79Hgfhuc_sYLoC+rvqTw@mail.gmail.com>
Subject: Re: [REGRESSION][SECURITY] bpf, s390: verifier/JIT mismatch allows
 unprivileged kernel memory access
To: Greg KH <greg@kroah.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, bpf@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg, Eduard,

Thank you.

Eduard has reproduced the issue and is already working on a fix that extend=
s
compute_live_registers() to track upper 32-bit subregister liveness and rem=
oves
the dependency on reg->subreg_def.

Once the patch is posted, I can test it against my reproducer in
the s390x QEMU environment, run the relevant BPF selftests, and report the
results. I can also help prepare or test the regression test if that would =
be
useful.

I can additionally test older kernels to help determine whether the issue i=
s
triggerable before v6.18, as Eduard suggested.

Best regards,
Min-gyu Kim

2026=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:37, G=
reg KH <greg@kroah.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Jul 23, 2026 at 04:55:12PM +0900, Min-gyu Kim wrote:
> > I have not yet tested a patch.
>
> As you have a reproducer, please create a proposed patch that solves the
> issue for you for us to work off of, as our security documentation asks
> for.
>
> Also, as you cc:ed public mailing lists, there's no need to get
> security@kernel.org involved here.
>
> thanks,
>
> greg k-h
