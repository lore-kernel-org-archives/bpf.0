Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824D1F936
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769916429; cv=pass; b=bYJ+z73nESJPPaXGQ1F5CJAiutYdA7qtIWDB3lhdvbUAQpUd5arH3k0hh1DjJ5NfkOmgrIWkPYt1mSkwKTH5Lx2b8lXqq/Gqf2SorlGmRqXI2jjy8PeBZiHaagLLRXUzQI2wCmAB51Zndshb9jtucK43tQpiFxK4fJokUDgIncA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769916429; c=relaxed/simple;
	bh=6MtxlXZIjI+msxax8JlvKH1fQyNpxoFiM9GoKRHif2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEx+6mH45RDSMZgT7zpkewze1MhdLlGfco7cdUjeGucYbLV4FIGfkFO8riT5MHyHeja3yeyK2r4CGjiZDUiKB/TIo3yGNgcLnrOEUw8vJmoD7gkcbJPRnkNRvz4UxnuP/b9z0/HatQnyqZVNzdO8uwe9kWjZLZNlOlYg1d5r+BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id2FHQ9S; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id2FHQ9S"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2152324f8f.2
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 19:27:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769916426; cv=none;
        d=google.com; s=arc-20240605;
        b=Z42wfWmeZXhPqLy+AITmw/Q06eUMSWoPuLB2NDviFDFBIZVirqspS+4U2iB3E1/FUO
         ahiHUdjn2GjE65WfF0Tj5DHEH4vAYhknPnh4jhkKqgD6IbKNPqjqOd4I/nP86cwwPlup
         mpLXUlgVopgyu8PuexP73Lsuur/X4FI3g8ZG50mORrZ+LTRwzk4gVJaX/N2Efl0pBfxZ
         yCQq5mpBj6Gb6palI/NhK83NqL/kRD/ETcUqmR6zn/v2k8nSKteUp5WnO2Cu8z5Z5rKh
         wwlNL3cmHmQxGp1VlboKaB0cpLvvgxKnvG1WY1KKLcWWSHcnI5alO3zJLRAMFrDOKQLV
         7NIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EUU+Ich5MQ8RzUcrbmbj+XaNJUA7CRHSu6DFTvTvYtg=;
        fh=i21IKzPtxwb8lfnOVtPZ6o/yXaPtwXf3azfZ7+ZAZpQ=;
        b=IOHaxk+oII156dF992eeXP/ZRU4VtWjDV4vfRVctgdyy8G9X/ig8swn159vkBLxrkI
         TX/1KVW8cPjWz8EKlbM9UIDG7IKb5aPmU5rmigeWToQOjkFLMAS1fiZV5VKsY5vcaK9A
         112+Xu9uPLG4E1vc6L9Wt++zLfdQm34RNlyZ7AN6lcJzgWoLtsJojJlb3odcUd5zj8rI
         jfQocQ9TY8+at5M3Ui5txNSE4Yx+HXTyUWY9WHrKQPRVszLbJ6ZuOONFnCm9ckapenop
         GBcfjw75F5S1Kap0PIJY4CljNmbYyiVKC8BjVOpD7D/PnLpGopQg1kJOf04kUfU6BJuz
         NfnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769916426; x=1770521226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUU+Ich5MQ8RzUcrbmbj+XaNJUA7CRHSu6DFTvTvYtg=;
        b=id2FHQ9StyJ2thtbpNDx3edVKIV+WMD6YguALFT1u5cmuIXVjY8OHEYaOvv9JDSdYg
         KfB3pU10YY4y5N0d/0aTEH8aU6grNnJFbLJLRFVj48dPxVdKXVTfBzOLO/i/PRYAS7T6
         FOO348hi2kIuAorzQMwVdKfFZB46GyMsi99Pa2Ui+AvmQ6hjTEJ0zjNWu/7JxeO5U4KP
         FKZqjDxzsoJcBNBvHuVuWnvLwnM3wnsVTNYDqHI6V4iYrPXi8XZKekXhHTvsFx7exn4I
         ObroclrvKwglVs4ymisJkJ1R7jRmbo/LVX0asrteZ4D6l7cneIVm8SFR+nI9xKdYJWDc
         286w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769916426; x=1770521226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUU+Ich5MQ8RzUcrbmbj+XaNJUA7CRHSu6DFTvTvYtg=;
        b=SZeDGQ3Wx9iEidu0pXTuf/usgEtAuiOL/mlBmW0E5XDppFPYqGN9UFc6poX17wLQAQ
         B3n6QQplVmcyuak9G0vD3iiSB4rDQ3v629UzoVPpkWLCF8hU6MKZxKLTlUWHePCzV4KG
         iq2B9s3czQ/B+EEPJNcQzXE9C6adpaFPZkTVR+eJaDlwjeL4kUhHpAJhvA7GVoMVNYrt
         selC5Ny7/tbDYp1iBkbyP2An2tXBrqpgGStbA3+rIMJ4VFvM6YjYspF/1Z28at8ZgqVp
         wliJJ2rvNhOtALSTxWbNnFfkfjaAP/1eXFN2yHzyZOLo2csuZ8RxE+llr/UdJ6OWxlwh
         1u3A==
X-Forwarded-Encrypted: i=1; AJvYcCUBeW/s3as/b/SduG20CPhUas1Ze4wEsSxK9U3VoAs7HAapZxU6RrIkPC2c4cEf2hrZ0/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwt8DwWIUwxgRPwC6Lq+IgWDnXNKGXX9a0nn+77COlJYW1TCFT
	3juYX3R/WmQJiyDePYSAFlozWsMcBg5vQKUUo9/u2UgCACRqQPXUr1IIc3K07l7MCegR2VoAgyI
	aaRbkPDnqbuh02Vi5AlSgNpAdP1iA4sY=
X-Gm-Gg: AZuq6aI/e8ldjEjzwQ8043mBoZiU/sJjZRN7Qu345sLIJojaJczqBbSUUsZTO2pI+ms
	TC1nYMMsRjtLR9qGWjZbjNqIv9F/ccgGvetCeXefZRSsIKhnebzEdbw3l4hxNxm9QRP/UhojsJd
	jYcngIgZxpsIyEfuCzTnQXIASu5gR0/Qt3shaf65ilgi0lOV6WHOEn25tm0/H/jkkq4y+zmoTje
	kAZ/c3PNsArSjXot4oTP5lNtbT1+Gde73ag/MXQcwL6dVLVQBeAlPnSEsMT2ek22Xca7j5reqvP
	EXiNfoOmqARRuVqu7a4ppAR2Q3wfMj6qrOJZkGXCXV8j9qyZ03pSO2TGDjgxZ17MMOIGW21dTlb
	yP7dfADyh7QfAFzDrMWCYbxil
X-Received: by 2002:adf:fdcc:0:b0:435:faa5:c15e with SMTP id
 ffacd0b85a97d-435faa5c20fmr4739973f8f.30.1769916425484; Sat, 31 Jan 2026
 19:27:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ca43be24-6f54-4689-aa8e-23573e83ca5b@h-partners.com>
 <CAADnVQJCYsA6b_DSZEZMRMyt4cADEvX90KkJf6h2fBpep4z8Vg@mail.gmail.com> <f7b0a9ae-d53d-4bb3-89c9-2a0b56a99170@h-partners.com>
In-Reply-To: <f7b0a9ae-d53d-4bb3-89c9-2a0b56a99170@h-partners.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 31 Jan 2026 19:26:54 -0800
X-Gm-Features: AZwV_QgbpdDsRLJJ9bYJulS9nCFVKB4DTROt3kf4FpIMI54oJ3JCksGnJEoXui4
Message-ID: <CAADnVQK=j45QiJTRN2Z43tztkjqGcO+ZwEidrWcfv-d7xoJJKw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Userspace JIT for eBPF
To: Gladyshev Ilya <gladyshev.ilya1@h-partners.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 11:33=E2=80=AFPM Gladyshev Ilya
<gladyshev.ilya1@h-partners.com> wrote:
>
> >>
> >> But reinventing yet another sophisticated compiler inside the kernel
> >> doesn=E2=80=99t make sense.
> >
> > That's actually what was happening for years now.
>
> Right now in-kernel compiler is sophisticated only in terms of code
> complexity...
>
> To replicate LLVM, you would need to perform very complex control-flow
> analysis, and right now, the only existing intermediate representation
> is non-SSA bytecode with a very limited instruction set. I doubt that
> even implementing something as simple as common subexpression
> optimization would be reasonably possible in the eBPF verifier... For
> something like cmov, you would end up reinventing the same optimization
> in each architecture-specific JIT.

See https://github.com/OrderLab/ePass
It converts bpf insns into SSA, does some passes, then register allocator
and lowers back to bpf ISA.
All of that is done in the kernel.

>
> The main problem is that eBPF is already compiled to a passable degree,
> so any remaining optimizations that could boost its performance are not
> that easy (and often heuristic).
>
> Implementing modern compiler isn't something simple. Look at Go compiler
> and their codegen after all these years :).  Additionally, many bugs
> would likely appear during the process, and I doubt that there would be
> large enough userbase to debug miscompilations / poor codegen...
>
> >> Instead, I propose an optional userspace JIT engine
> >> with a fallback to the existing in-kernel translators.
> >
> > There are several issues with external JIT.
> > 1. It's hard to extend the trust into user space.
> > Currently there is no mechanism at all.
> > There were proposals to send proof-check into the kernel, but that's
> > not trivial either and not compatible with JITing.
>
> That's why this feature is proposed as _optional_. We can relax trust
> model a little bit, and if someone isn't OK with it -- they will just
> use existing in-kernel JIT.
>
> For similar security model see Rex extensions [1]

Right. It was discussed at LPC. If the compiler is trusted there is no
need for BPF. So BPF-JIT-in-user-space is in the same category.
If you trust userspace go with Rex approach or just
load normal rust kernel modules.

> > Would be great if you can contribute these optimizations to the kernel.
>
> There is no infrastructure for them right now and there won't be in the
> foreseeable future.

Ok. let's move on then.
