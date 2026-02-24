Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698423EAA0
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954785; cv=pass; b=UZNQH/OYK4HUQPi4gLr+8h+Buc+BGCfmT92sCMACiiD+auWGRd8yWUHart9OtJTRHwRD63jb73ercYlPIorK424h+pRyK4LWrP0q3NNuu/qyFY33cKsHLDNc5p8zP5xb0HliFGDa9UE9Elotkw0ngwFcxI8zQ51uMvEQXLO34no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954785; c=relaxed/simple;
	bh=aHMcPD2L++WXOtqOGhotBPhE9juRCqM8Eq4eR5jnedI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGUzZsNZ18fVZhqPZhMVykoeN0qb+2BPE07gc6fYEvvTVh7u3zO4HhqbdMtUTpdbRJ4W8ONPRGA+6LI0qf2iTOic5UzPhf1zOUrPAwPO1SnfpqsoQOMIzwJzsKYAEdKEmkkhvvrGkvvxuF/6f8rVBpwkDdcU8JwH3delLzSQrcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcZGGNxc; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcZGGNxc"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43945763558so3656363f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 09:39:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771954782; cv=none;
        d=google.com; s=arc-20240605;
        b=jZBv5grvoLxFRpbMCCQgZ6PkJ56DxEpVLWwl+Pa6cnDLCPCv/0ygJdRz9xCJvYIhFL
         C74Y4nungsXRCFHGDIJ4LE0arqeakP2VioQdd9J8RrGX+0TW7wFcrQpb5O9F3yRjS6Z4
         DJHOEeaPaX4lJgFjLK0ZgZJsceKb9Z2MCD5O014nus9VCkvuxo1o9nHbQ0Sb/BhAc8kR
         45DT84Gs7jcfBa7bYmCsAnCNhwLC2oT32kgLkYBnT2nXj3xxpe+VsGKTplw73Eg/Ov67
         GZbsWHKG9nfb4FxrSsjT9/j/kZusTWo1Gk24CavuDe1XCDyq7zQ6uLV0KiWwDrMJi3Mf
         437Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aHMcPD2L++WXOtqOGhotBPhE9juRCqM8Eq4eR5jnedI=;
        fh=7RA6a9+QxVTt4qcKLStjpcHD+jklpY8GB0xUSF85y5M=;
        b=MFYFIJX8czL35w8FaBV/hV2EiVacx0Q8h2pl+gqv+5OzYB/boCtLJU7r+zUKu5ePF3
         Q907fVE/gGpIMu3Ti7DhOSmMGGxuUequjTwOif0bUnj5DBOI9F/Cl9ZTXRSzRHJBRzVk
         CZpttO26FxAycwnM/CpXJ5v0tydrgiHEPbw2e4LGSBDy4LtQ8loYlEUv4VCnXB38RqvU
         MQrnVBjFYBRYj+1ROHrL7UAIrEIj4mqs3ictYNQyQl9JMUC4vJ5/1U0Nu1M/IcKxLRf/
         44DwJtMZpa4aVCpiW+kW4azHaOj910Y1vFXEJuSPjshAy3Y1Iy4NM1bWNfTsxfzdBvmT
         jUzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771954782; x=1772559582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHMcPD2L++WXOtqOGhotBPhE9juRCqM8Eq4eR5jnedI=;
        b=bcZGGNxc3yedyBmeRSOSd+BKs1lBEaIxde9NArHwXJuvsc2eQxGtSG0WfY+SWWwd45
         o/N776bN9m5Zf8UPP3Hu7U9VRHyijNcCr/1YJGHWaqKPigKCjaHYpLx/FuzrIVyBaKnL
         M0T5qLi0wI+POOMo26AOwBwUIYhY/hST1krrnsIn0FmNiDSEu0pgcEaPezeuCkwY40AZ
         uwopgoR425l6Z2+K3mFo12S2lBuZtcw+xxKOsIX95b8B7yopxuPVNhebaqw3r2tuV69y
         8YYgwfmJWP1U5p5RyQBtTaTh7Imsxxf9fJl5j+5j08WqdMUzpSuqNf6Xb740gdXeSUFH
         Davg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771954782; x=1772559582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHMcPD2L++WXOtqOGhotBPhE9juRCqM8Eq4eR5jnedI=;
        b=a8CGjNp/By+KYUZl2BYGPcpccV3wHj5EaIlTKdpFC+eVVwVpB2eKXmy4zY96UD4pGT
         EXXeeDc5txq71XOMx7VMq4jgfSrgrApiEITGiDPa4YNJLAuI05tlzVchcJHIkeJpeqmX
         A+ljvjBfbfpaufKy4QSLDC5hYKWexdS/MjGHv5FyqeU5YdiDiBpsIAelIxcfA/pvnK6s
         A8JPu7GbKMPWw6boslJ3rM0jPGCH6qREEQNiz3R98pzC4w5xM7MJ2i8D4zMgXye2eapC
         epWGm+upIQTQVysHn8rkJk/lZbuPuHsskhw0v5RWYCNnqGPCEXtV4du6UJDfIeFWZfaE
         9FMw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Yz4vMUrpYXwnD1CSbcmUEvuuliDHeOX/S5bGEGITLCNZxMy7ez30q9m2hURVJHE2jbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+JJSiTxe5kthGwEj1LPlfOSYdBxpSPJ3v/R2RzktxO+FFZ8a
	7j6bkpUoOSey3OndCThtxBr3Is3RtJIGbAnWaRslWRxdjLY0QVQUjCDQ5KbSYZHCiFXmkBTQdxL
	BR4KkYEtknoS66KJ0y7nhOFDhv/Wg+ow=
X-Gm-Gg: ATEYQzzEtmjhSdhgvIFaYHCO5NJ7Go1WvlfbOoaa7rSQ8G9Sr6xVIGx32DOuWtKTjZq
	/omnv2GKQz2BlCycK3OwNyLsbm8/3vBlHJooGsrrf7216lFMvxwcond2CJ9apu1Mhr2RYddhrAF
	H0SsYLt6Q/RRRHZAiZV64v+qYQneQO7LlByIBvQTUOkH3d+0B/oFWNWzQrkNcH+JXAYWN6uSBeL
	oBI4qUWgBNOXhtI3qNUsyW95NAMKYg2syJ9b6HOZmMFLzFvwraX69PT286C92dfV5pBLNWi0uHL
	NjHDvPFE0VGo5zdDHYc77rqkzTUGaU0tCTiYqT9uUh9ewYhEp3mk4g1iPKU9FDXHtAf+BuwVGRe
	c4f5rPzig
X-Received: by 2002:a5d:5e01:0:b0:439:8d96:55d1 with SMTP id
 ffacd0b85a97d-4398d96563cmr1225873f8f.8.1771954782167; Tue, 24 Feb 2026
 09:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <de152bf4-a168-4017-98bc-d5f64b0a01e6@linux.dev>
 <CAADnVQJwJwnwU0uOVqrdfj=n40YBNVt5HpERGw8Lqa3NtvGFdA@mail.gmail.com> <a6e20fe7-54be-4c49-a953-c013a4b88a05@oracle.com>
In-Reply-To: <a6e20fe7-54be-4c49-a953-c013a4b88a05@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 09:39:30 -0800
X-Gm-Features: AaiRm51y9PUYnyRqK4nowgQBPW50_7HfcQj-_GLMjx6KQpIoopB_WYpG31lw4WY
Message-ID: <CAADnVQLD0e_4Kmp8K_MDO_XzGRPAQkq=iKCK=ysp6fkH1hOnoQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Recover true signatures in pahole
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 10:38=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 20/02/2026 18:01, Alexei Starovoitov wrote:
> > On Fri, Feb 20, 2026 at 8:10=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >> People often trace kernel functions in order to get some insight in ke=
rnel
> >> from corresponding bpf progs. But if the kernel function signature
> >> has changed due to compiler optimization, users may be confused about
> >> why their prog won't work.
> >
> > This is all good, but what is the status of recording
> > inlined and partially inlined in BTF ?
> > I think it's a higher priority.
> > I'm talking about this patch set:
> > https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle=
.com/
> > I think it should be finished first.
>
> Right; that's the aim. That series however depends on the BTF kind layout
> work since we are introducing new kinds to support inline info; I'm hopin=
g to get
> the next revision of the kind layout series out this week, I'm working on=
 it now.
> That would clear the way for the inline work; I think we're reasonably ag=
reed on
> the rough shape of the inline stuff so hopefully won't take too long to w=
ork through.

Sounds good. Let's land it asap.

> By the way, I was wondering if there's a way to get AI review bot feedbac=
k from
> a pre-submission to the kernel patches CI? Would be helpful in catching i=
ssues
> prior to submission, but maybe it's not feasible?

I suggest installing Chris's prompts and do claude; /kreview on patches
while you're still working on them.
It's more convenient and faster, since you get instant feedback.
Sometimes I do it in parallel with a build/test run, since the bot
is at your fingertips. make and /kreview are equivalent.
