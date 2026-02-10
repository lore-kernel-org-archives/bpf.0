Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3362FE07D
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759526; cv=pass; b=RIeNR2v86+E6bPbydSLCO6Eid3j0LS4fJquKDP5I4CDaJEurcy54IoupdzEZ87w3gMUOJJX9dLNlKSGCcyOHBlZS9t0Ts/NRDhlLO7dQHVR0ku2/9paPNddVSpplf3ZWdh/m6oTBLIdCZK76ekHflHMhunWDk/aiv20wkswMpzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759526; c=relaxed/simple;
	bh=tR2ChMHSQYG9eiKqn995QhGy6+Jcq6dQubiTn+G1TVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ti80f6ueKcqMqTMbAZlN6Ye19K0raYDOqseTEWWIdq2TncXz5YLwAqTiFrp9LIK5VeQWIH9uRIm4mAl/v9RhY0ovzFqvv5l9PDtQuIsaREJtw4x9AIp3eJewsTsxe7YNdEsyqRwvSkOKd36uSCvkLE2IP6n55rWpl0pTigzrRFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjrj/cvf; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjrj/cvf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a929245b6aso40477715ad.0
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 13:38:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770759525; cv=none;
        d=google.com; s=arc-20240605;
        b=FAe/q/oDNJrIji3Xyr+sudz278+mUXtePJeSvzfO2Sj4+m41VJu+bqgzUZf7DtQAMK
         bvsB5X18DbXex6yhYu2y+Xqd1jqZJ8DWV8/oIxoibsiCoX1BNBGFKWnce9gsd6tUeyxE
         3f1WA3sL3m+DX+SM1TkMBg08lzYl2p502gosa+1Gci8bNGQoMn2OTHjjWvfE8Hmkh/W5
         qmiOhsuMOJywWCY7VFsDd7lQLofHRZmEiDB9tRlw50904qYzUvXJFpWFREGrvP/UB4j3
         qF6fSs+Ua30TvbXROuyYiW0I/2t0vhnodQZ0FqQRR8d7F7gu11miaky6DYuZVB9zoL/F
         IQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tR2ChMHSQYG9eiKqn995QhGy6+Jcq6dQubiTn+G1TVc=;
        fh=ElyvGaPOVarO3QQkt8VrPwL8ztaPnF0Tvyq+kv7nZDg=;
        b=GmGtVr5YBl/pFlrPMWb+pz8doRdTK13n7Np0OYjuJUaa7AytqLr/vrvORw91lw5B7F
         Ws3v5XoClJwhvKK9nCe+KiRhrho+iyOZ44q3XsF2N3B99dDGIoLBJWTzSDOgoKKlH5bA
         w1bWMt4AbRlQDENEaVDI5aJ9lAkTm8OVMVFkuiy9Zf9obvajHqFCkNJbnuAt2d5RHk92
         d6HTP+Kg0hKIn6lw+nGgUuSLTQG9+L/DHlL2L6WXzW5skhiAdnZ4n9OEDQhe0tsoIZSu
         cApjb9+SrnLM9P74Gl15OhWVOIAoHmjSLzFZcOrbMUu7wQpDeNJWu2iE9fryrbWhBOjh
         Kw6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770759525; x=1771364325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR2ChMHSQYG9eiKqn995QhGy6+Jcq6dQubiTn+G1TVc=;
        b=gjrj/cvf3qgqX6pPT82FXWiHCqjrEc/PrB4lYOZmSizoz/w56fO8KUWBgajZq6yTsi
         FP5EtrpVPauXhjYaSdSB0xtyG2dXqY7aAxh5Yv+IzSWBABo0yMCQZBeYSVpoCWL3aaLT
         jxUmzRaCGKsqBFjxj+Wkk7uGMZuTJq7hQ73fl7km4n+2/M6pJD8YXKXQiJ0yV/dVAd3L
         XAXnAhT3+/xwXvHMJ0Ct7jMLpjujzMDL7ewGg8cQ3uJ9a9OyFB8s/1gbmddt5BrMG6L6
         oOPhSzcjSTypvsQ28cKp1rlo/gnqmKHfZe8qO/Dh88YfR4dKmnk0cqmP+d0egU+3jm1G
         SPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770759525; x=1771364325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tR2ChMHSQYG9eiKqn995QhGy6+Jcq6dQubiTn+G1TVc=;
        b=E1jtPnOD9NGW5E4wsVtqG6YO4cYyzSYH5FnqMt1XHP1EcL3GS0n0lkDT0A17nR4PrY
         3kkABHA8Ub3WALH1e10HVVz50kRK1cEjBzCA/BoxsNlyscwcttq+4rJo4Gi7SwEbJkKt
         2I2OxGddgHPtOYxIacLlWYoL8x0Nc/zDT9p+zm+yxAeF+9UZVCLsXm3X7//akmV/ZT3L
         vhrKQVk1iDa1xsBz6gPUVvvZcV+2CrefF/Zw3121mRxnCUhrowpdoNytPvZbkAqppmtU
         VyswJ8S/W+ohCT2aCmlLkNaU5o8EvmXwu8EmCWKyOK6g9UgIx+HKnTPuX4Jq0gdAs6Pf
         Kdeg==
X-Forwarded-Encrypted: i=1; AJvYcCVtFn13mJ7JlA8RkteFtYu8dWqh+ywkjM7d8+wzfJ3yMlh6pjDW9yBG3/kS/cSYu2PWEM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7pzwtj8MwyXOgA2qSsxNakLApLJUEN9TledPBx/yCj4uCLkwR
	QrDt2XddkvwmFGvD+SBsNJb87L7QY6XMSGbamLQfi3fjExWk/fU2mARmXwKv8UfEVoCiZjM7qUO
	AD6l48APbXHnua2B0d8QPeoln2ytfdaw=
X-Gm-Gg: AZuq6aJ5XAxkaoa0Y5eyyriomkAAHgwZJ1CX8iv7Ssac6eY1Eas7l9e9O13FHe+bjiM
	0nM4BrMzBRpPVIzaJy19fdkxVGdZUZ1Q33AinwBS3bgjch3EIC9pZpVdKFlnfvq0KlV2LO+9hCX
	GTnGvVmd9znLqZQkpCn+cykmQBe9a4F5x/xtBLlQAw7DNjQdZ/lzfwp4ZrGnbMBZhQwfXUNfzde
	XvSamiWMgFUtA0RL+IvZKj44VqMQqMirNGVmfer2lFfeH04Px66wqA5QkWV/w+YILnl55avdNKC
	Gy33LYAZZnHrJl6i/57lF64=
X-Received: by 2002:a17:903:1aef:b0:2aa:ecec:a447 with SMTP id
 d9443c01a7336-2ab27f5ccffmr6284285ad.36.1770759524804; Tue, 10 Feb 2026
 13:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210192738.3041609-1-andrii@kernel.org> <aYui6BgekgRplVka@linux.dev>
In-Reply-To: <aYui6BgekgRplVka@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Feb 2026 13:38:31 -0800
X-Gm-Features: AZwV_QhA0DEhtZ-EkZ_Xu_JjyHDVYb_bRHTKSR6CTiprFcTcAmgBUrZ-O5pJohI
Message-ID: <CAEf4BzZnwhGW1VPtQ9svSYUp-+c8=9rxyupF=Xf+WG3sV14oUg@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-stable] procfs: fix possible double mmput() in do_procmap_query()
To: Shakeel Butt <shakeel.butt@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com, 
	Ruikai Peng <ruikai@pwno.io>, Thomas Gleixner <tglx@kernel.org>, 
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 1:30=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Feb 10, 2026 at 11:27:38AM -0800, Andrii Nakryiko wrote:
> > When user provides incorrectly sized buffer for build ID for PROCMAP_QU=
ERY we
> > return with -ENAMETOOLONG error. After recent changes this condition ha=
ppens
> > later, after we unlocked mmap_lock/per-VMA lock and did mmput(), so ori=
ginal
> > goto out is now wrong and will double-mmput() mm_struct. Fix by jumping
> > further to clean up only vm_file and name_buf.
> >
> > Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA=
 lock")
>
> Why didn't the BPF AI review bot didn't trigger for b5cbacd7f86f?
>

I was wondering the same, tbh. I think it's because I marked the patch
for mm-stable tree with [PATCH mm-stable], and our BPF CI
infrastructure just ignored this patch (even though bpf mailing list
was cc'ed).

> > Reported-by: Ruikai Peng <ruikai@pwno.io>
> > Reported-by: Thomas Gleixner <tglx@kernel.org>
> > Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
