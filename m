Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E5389116
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278422; cv=pass; b=Jd3qfidZUfpdteVrwrEOCOolZ1u1bVoGxh666/uIUqu2fmoBs434Jy+AKfJN8IkUzRlwk9TKvZQDQ4Y8PkmYN4YinB0/504aq9NKCUmyz9YQJcfopjKpXMwlZ1tOtNKRuETffn9kJAWuY9OG6/SINiXjirS57tlNwVC4vSqZztM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278422; c=relaxed/simple;
	bh=DQmgnfcnRr6713xlyyH+//k6KmRLZaPYa60KA1lLt7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQI4V0WYUR2QHyMXwxS5yqSdNcnmIApE2PpnXQYc1h6F+A4t9ygoNvx0ylNIQVnJHKgyVrYXdR+slhf+DPoQtesfBErKVwPtGLBgMq/DVIbVlZ05FfnGf49sRZ/kaZ+MGMKaSSkYDKxmHNryb1LUAlcC8qGClMLoroDtA4U5gJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzyd+0O2; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzyd+0O2"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c8ccc7755so3918398c88.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 15:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778278410; cv=none;
        d=google.com; s=arc-20240605;
        b=VrRI9jPi0ThALxXoSnLnDjFlZ2i6ccHY9YFMTDGxil358KmobM3OyyNE/YY2vlzdKJ
         YaGa6b9de5Vt5jnFYHCzQ4eWQ4ajeP1YDi7GMQIHgUd8VXl2dNI5x8A2PdDF+bRwge3e
         6JnQQGHc8wVLfeEHCHttyVB10e2Cu9oOAC1OedM0R9cVxpAw8ywPKfV5P2fpV5eocQDf
         zdqNJEgivx3qKAPGj5URMXCfqHIFFhM7LN/v6nVSuPF+FRG9csves0H1R5fny2AB9db0
         TsDxcETHsb7E+RaiTtBgrgO/VtQd/LgvFSHKLkkBmgMzadXpy1ga+sp/vyqiH20+d6Ph
         +BNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsvMB0ViayQVeQbXLRMaEKqgrrABVFKldkXlrfhVTQY=;
        fh=08LRkf5NSL/Y2QRTfOWLqEwm2dq96kcONSsILQgUA/0=;
        b=d3vq1gJjP81SyVgm3ThmHCbpP2zz2TV8BTgVAmO0M3VQcArq955H53Dnysx2RTMLYZ
         qHamrRsFPtkM8TnjYudYciObQUER8URmEYw3dWleK4iOPPWk/wiiu46KnxtaD57hQJNm
         O+nTkuR+a62diqEsrL+JGO8+nm64sgJwlWIdlu0HIAeltC0wavoqbAMnVTGEYoVJODkO
         D0k8CyJrByZfg2Q2mnWCDaLXg42EZr0J3uvmtdZnrEXzjVNKHmzn67H9U3MIRnfgXguT
         LY+izGHj1OlvZ1vcZRj6pqyULO/W7A6Sgpghq3mBlYnhbPcREc4ft5+DXHpCfZiwuPcg
         jUGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778278410; x=1778883210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsvMB0ViayQVeQbXLRMaEKqgrrABVFKldkXlrfhVTQY=;
        b=pzyd+0O2qN+6WnfOyUD2tKRiFWusnRg+Si+mJ7GsGG7VuqW0PsTVrVd9gnZfILmXVD
         U//zSkGFTcbUOmLS4kGphasYLMD7iH71c+t8cgQJgSmvYdvlLZNc6lbzr5nQZXoB+e0M
         f1cwW0DXvYeGXt9WYvAefK+XIbVdUAR7MfTEL9viPogpuCt6LcFMNBM2BUnB1J5ZiZFT
         yxdmyFW5JBjBtr083wuVVAs2wpC5PRl6jA9me/lS7u7ZxCzVvzPEDTwaBsa1iykQ58s2
         Lkh1JgGX3HLk+OlyQzvDF037aj6IZ4SK7dojvu4LmU1sFH/bAzAcqtuQ/h0rGekRY+xJ
         01Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778278410; x=1778883210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rsvMB0ViayQVeQbXLRMaEKqgrrABVFKldkXlrfhVTQY=;
        b=dS947jPdcZQF6TwXBrG573U/8JFVQdcp52Q7DR177DclGsX+rOu9fwmQXqGDPR7myr
         e06h3zlJif/gLGxFNVgVfXfRKyItw5KxWEd/rdpyD9kcCR+GhEDZkoKav6CfG3ArpHDv
         I2mazCUC7e1VEiwPPFdlUi/ZfOa6hcQWUtXjqn3phJJQDbMgEcZni3yJpkxDg6FnhOcQ
         CrWgshDJHhcBRam641DC8YZQaf8dw6zlO3VThYzTz2tWgjD4VINoC3Qymlpybe+2z1Rg
         fCFQqpRSGy0dtYPU4HXlAsc1nc/I3jSXLit+gHvMAun+EwSzoDiPeJz27wfOlw1TgAB/
         5SPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YHRD5gqSVxV5Sy/nFfUW/kw6ywB9WIVu4T3TqmCloZmn6VvSDjNwHq7f9Q9jIu8dcui0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWvPfEmOmMjHhShe1w8TEIi5Vmo5peJfnvpY4id7DZPqMCTW/5
	esLVKbexls350eQvDd0/oR9d/UkNwrCkbMZDYAX6ht8EEVul58LJ8qKeGVGSEiDmUot2eXKXvWQ
	IqlkRZVbIcGhPInnMH8M8DwR38+f9BAJG1zOmRtTf
X-Gm-Gg: AeBDievpo1+fSNrrSKpsiu2birDFkiWJDxm7VggufHvZYuV1kFSaZBoMFpVBxFUfmPl
	2rr822M0ookSQjlqAEJkB7kfxnfNO89/1+2iscRVb/8K1cDHweA6RQJe6irK7utP3f3S8w2BQTt
	U6AzaDAFHfzaH3jmDAAaqKXj/cDpYhqpnYAs9dMwXLdUf6z5EN125DIRgAtwOsNB37ZfxjV8wUB
	ziqu9iJgyIQh6yZDjdrA/sdL0mZmN72ShiRCdxiKDALXtVzjrm4wuv7MfDLU3K7ljU490mpE7Eu
	1eOz5UWLzVvrGP6TL2/ruMOozITroKBijaLNLSWw0YcBPIcbwXsD+9H9GGuzBnpYswIv7PuVfiH
	0bb5eShgyIMkw7mJ70ONjyMKjWHderXM=
X-Received: by 2002:a05:7022:222:b0:132:1e79:9c55 with SMTP id
 a92af1059eb24-132a84f8b05mr101966c88.31.1778278409825; Fri, 08 May 2026
 15:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426012647.3233119-1-kuniyu@google.com> <20265820377.lHsx.martin.lau@linux.dev>
In-Reply-To: <20265820377.lHsx.martin.lau@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 15:13:18 -0700
X-Gm-Features: AVHnY4JtknxiTmGENEzK09cXcPW9GZY-vVSlIaZcmjsXBnCCd7g7z9k70NZAobc
Message-ID: <CAAVpQUAHXWbbdn4v0xmn5MjAra8AKT8BZ3OYCTqhfZT9YmQHJg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: Free reuseport cBPF prog after RCU grace period.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Eulgyu Kim <eulgyukim@snu.ac.kr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 1:42=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Sun, Apr 26, 2026 at 01:26:43AM +0000, Kuniyuki Iwashima wrote:
> > +static void sk_reuseport_prog_free_rcu(struct rcu_head *rcu)
> > +{
> > +     struct bpf_prog_aux *aux =3D container_of(rcu, struct bpf_prog_au=
x, rcu);
> > +     struct bpf_prog *prog =3D aux->prog;
> > +
> > +     bpf_release_orig_filter(prog);
> > +     bpf_prog_free(prog);
>
> afaict, __bpf_prog_release() is the canonical way to free a classic prog.
> How about __bpf_prog_release(aux->prog)?
>
> If it makes sense to you, I can make the change before applying.

Looks like it's applied as is, I will follow up on bpf-next.

Thanks
