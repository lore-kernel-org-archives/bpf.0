Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D23DB63D
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740320; cv=pass; b=qaEQoD3BO/UwaVhfqZOH9nPVBWj0j7NDQIC1cFVJr2mf8AriQWlXkyM2xZpK2CjqWMWGp1v49kTxN9sD1vI6OrKIiBCYelpfXj6rq3dfEuy2PXyrTFmxcpZ6HKIPIa/2kcImaTPiLkXqo/UzrwYv1PSsFegflvpgUudd6BRYkxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740320; c=relaxed/simple;
	bh=/My4sFwnLKoEXFaFAElzLX2/kbg1KLc08ymPugNv5Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9rfyHUtrauPFk5lBTS46mYUPHrGC2dz5Mho26ZQpN++AJ+phXTwJ+Z9M9scBqw1IhStbyiYSKOsgA/2bnrQ9S5OMAWXQ30UJMMlFf37xCPRlqkhiD/ak5c5NIFT8jf2WLpcnak1lxvx/A3Szy/oP+6vgSZZ1vmE+Z3Z9hUJyHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6DVDXDQ; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6DVDXDQ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d53197d8b5so7001415ad.3
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786740318; cv=none;
        d=google.com; s=arc-20260327;
        b=cMzHw1PNEk5h5inR5Ba/SsBaS0jPfdTymnq2guIm4G84w+tfvo+T7RrzKl7REyO1aD
         nbI54A23WvKC4VRx61pjLiod4EyUUM4xb0klqeA4lRsFVG9Eq+HVM4ZXpFGG2/ynMfAO
         gdY7R5cC6AAXQvEO0Y1IUjv5SP3KsPOcMU40hVHerXK8a9AkWmHa7X8IWmew0yR7SyW4
         drWx8s5192jlHVUZ+EiuQK1aXxdmluhWA03lMEHGsgS3ZyNwDivF2rBklgCwdgCxSINj
         6TESgiffwUFZv52WhqvfwlqTP2R7N6SJkF9yGL6ijQ5c0NQaN4wGA+3QRaeEbuHhN5M4
         ZiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/My4sFwnLKoEXFaFAElzLX2/kbg1KLc08ymPugNv5Sw=;
        fh=yh074P3vB3LI66INH982qQ5nvdnNVVhATAtFXNeosV0=;
        b=BHf3VYSSl/YsOzdatZvkuIUNA5NHkOeOX1KcmIRsA0kWRbp0aZxjN0gAekJjZY36PT
         boVVASyW3EqAsh6+dF41VCnxg5TtN5XtoaJ3+yxO9gbxAjrNF8Z17Bw/c2V3pL9XGk6T
         mRA3AlKFaoPzNuuFABwBYYsSJe0FW/howQQWYn7mZNN6GqVVKfyJxSiVNxklYW/IoGCn
         Vq8LQGDG4+R4QiNhoXMEEQVccJpaQtpgYHwXpAZHbXz7inhCN1lxBCmcgEu5OwRX8N5W
         vyVrLJnoCLA/S25iOYcE6n8Dr/sJTXYvCANI3tBpq8IBguapzGsf+vu6C9ywsUQMnJie
         q/BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786740318; x=1787345118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/My4sFwnLKoEXFaFAElzLX2/kbg1KLc08ymPugNv5Sw=;
        b=a6DVDXDQbzDlPxuYH4llM+KODEpiaJWjFa8UoDJyYv6GaZlnHoYY868Tk/fPgmcMbm
         ACccFExXKV4jBX7tjEh7YU41HO4d+lopqkSaHTBMSarlsCuIPPnFL+mfSatqRELthNku
         LqAZ6OGOdWQUXSelI23ZPHI8IOKuZZKqwPfEEHgExqj5lqe5Bb9BOjhCVzNxm+E+fJxP
         mxE0rU3akWZkeJOEtKRNQF1YjQE2FlZ018/IVAsW7UMH4g4Snqkws6m57DZYsiuwCsaX
         w3ps0XbeGaNGoq4sWCVYb/0mRpuOXFyJGfZDWsIurqUuAyvQJjrMMHeygLx+jM9JBXaz
         Df5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740318; x=1787345118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/My4sFwnLKoEXFaFAElzLX2/kbg1KLc08ymPugNv5Sw=;
        b=m6sH53M6XIeG5Kfi4RU9Y692QDsSk6wpwJTlImMjh4ryojPt7N+aaW2wrJVL9l5jt1
         VhBdoCyO1LP1wzS5veMaIi33pdoY4fBJ0AlcMQzkRWIn+Km3nydBxH9qbJvnuopd7Lvq
         8e8aiZXgIC5NuVAUe8OMhWF0nVvTSksyNcvS1N9D5ZOKhf/4K7bsGekalicifhyfQ/ep
         tFcNLoPFFNcvDR4TKSEBVW0SYDoEdDqUqhrcH2hc1QufsQgKNHxL01bj2vIqThPpq7bI
         1pTRJspHujay1knVGcRoZLlnj0DF+EGOBGzBokrlYSPK+zoSIWmztcH8H14XqJrOMe3P
         l2fQ==
X-Forwarded-Encrypted: i=1; AHgh+RoA1+rsOI8bvs9jQdcUWtUUr6+mItS7Sjj7GObT/ZJ9us3w/x96zVkkzILk4eTTi66mqhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ShgwSzrKX/NbeJAwp27bTJ2VEbskCUJrvv4o//xoVMQYmKm3
	8IDj0aIcC92pYrKJIwlRYH24lz88R6TBWb+da4092DAg8EhqKOZrbgtkOF+gvXSGK0hS+Nxhj2n
	7p2IWVXeaTBXhsN83P0PbNguAvfF/9vaAhA==
X-Gm-Gg: AR+sD13aLDwT7EljvLZpjVgNZ3qHK3022byDFs1AbcHc1s/oPTXNKO5uN+AHj6u25AJ
	N153BoEg0PHu2UovUsgChADXfnwlAzZBqfLLwAmfbkyz8XNyY9cvMgdkp9kNVOmGHZOAC7MBDkX
	qD10xaKnEQlF5bsPRA9h2NLdUU8jFOb8PibDL6tOYkAgmRrep7ghwKUgUL+cNmYiQpW+JjFvXPp
	mTyluQYNqOsL0hz6p4MYkI/VRBq3H6flBO3HQkxwpiItlLSjfvkd6MRObP1t/eekcbYXIAfCbqy
	xaryqcvd8D5nNY/yaSjbjcmgxKPMr7WWcPKpGbVpZmS6gdBB4H9eX6UwZc/x8dPCsS/f34933r0
	9ZPwp8f+6YxeQybvuFte7O6EGjCl2ajan9EW6Jt2hZw==
X-Received: by 2002:a05:6a21:7316:b0:3c4:de3:816c with SMTP id
 adf61e73a8af0-3cc71ed56f7mr10412782637.37.1786740318220; Fri, 14 Aug 2026
 13:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728065525.653171-1-imran.f.khan@oracle.com>
 <am6ydQ0kl-KVOf_F@slm.duckdns.org> <53158355-f12f-4efe-a480-1c375f8583ff@oracle.com>
In-Reply-To: <53158355-f12f-4efe-a480-1c375f8583ff@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 13:45:06 -0700
X-Gm-Features: AUfX_mxE7G2kkL_uC6Piq8hq7R99ckIKn4tIkxWwXg4ZBdQAr7HC6lfHoO09Uag
Message-ID: <CAEf4BzZ2gHpUhsmThsrx5o9qmvky4ok6uC2bSyZsPQhe-V=v4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/6] workqueue: introduce BPF iterators for
 workqueues, worker pools and pending work
To: imran.f.khan@oracle.com
Cc: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:49=E2=80=AFAM <imran.f.khan@oracle.com> wrote:
>
> On 2/8/2026 10:59 am, Tejun Heo wrote:
> Hello Tejun,
> Thanks for taking a look into this.
>
> > Hello,
> >
> > On Tue, Jul 28, 2026 at 02:55:19PM +0800, Imran Khan wrote:
> >> Nearly every subsystem defers work to workqueues, and their state can
> >> already be observed on a live system, just not at a granularity that i=
s
> >> convenient to consume. sysrq dumps every workqueue and pool to the ker=
nel
> >> log in a fixed format, with no way to select or aggregate; the WQ_SYSF=
S
> >> interface only covers workqueues that ask for it and exposes attribute=
s
> >> rather than runtime state; and the drgn scripts under tools/workqueue/=
 need
> >> a debuginfo-equipped userspace and read the state from the outside, wi=
thout
> >> the locks that protect it.
> >>
> >> This series adds BPF iterators for workqueues, worker pools and pendin=
g
> >> work items, so that this state can be walked from inside the kernel, u=
nder
> >> the right locking, with filtering and aggregation done in place and on=
ly
> >> the interesting part copied to userspace.
> >
> > I'm not necessarily against it but what are the use cases here? If for
> > debugging, isn't drgn + hooking into tracepoints mostly enough? Can you=
 give
> > concrete examples where bpf iterators are essential?
> >
>
> The main use case is being able to peek at workqueue state right when a p=
roblem
> (where checking workqueue state makes sense) is detected.
> One very common case for us is getting RDS TX timeouts because of the the=
 stuck work items.
> At the moment I don't have a system where I can both use the patched kern=
el and
> reproduce the Tx timeout issue, so I have tried to explain the same using=
 block
> layer and dm-device as affected subsystem.
>

Looking at open-coded iter implementation, it seems like you should be
able to implement this pretty easily with just bpf_for() loop and
bpf_core_cast() primitives. If it's for diagnostics and debugging,
wouldn't that be sufficient?


[...]
