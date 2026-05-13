Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF84CA262
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690144; cv=pass; b=ZyBvCAzLujKq30p5XdDcnYI0ePdj/7ELjwMoflnquLe3M/Y5p6y67eJ8EYQiaiAqix7dAAYsbPyXRBXNyDkna8CUAqQS0gOgdcESeKRIVObgeoBpwBCigsWG9/cpgszIeKtTNGiZht/Xn7hZT/GQ7M8aj395NUEMmwtnAZOhoGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690144; c=relaxed/simple;
	bh=szTmaxP23lVkEVq/RlBkdxcb8V6CMoKd6fObh9S4BLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEcI7k3icD8jyncs2eO8jWyNvhaPOxyLBNrlOXBQI7DeAm1dzn6UdEpZN96ZxKH5XZSPfp1j3KX6lmXiuyv6LkujPR0pwMRu6pu3tPplRZrII2aALrCQehdgfzqHSVhWVdjYysENjnDOiFBdOsX+RHiNxhAcK0c510Ex2NbQwcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mnz0ReYQ; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnz0ReYQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44a74032ff8so5256192f8f.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 09:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690141; cv=none;
        d=google.com; s=arc-20240605;
        b=ZOrycpYrclhzhPoV+bTuDzI7p/omnhKNRYNHs1wlk1+tEj/1B3JGrgM99/Lw9SDAHv
         UHd8bLRLVyEG2oUGRGpIi4n3ya/0gHZzAp6pIpJVUub3lMwAlo/gdZ0EGE86dVpuUgP2
         u3V79zUCu/63ejC3W6joHSWB+nBnxp0tSLYkVyO2eY2PqAl920RmOdC5h6I2/vuTAF/A
         jYL/qOYF1TR9oV/WU6RjYOZiqhumbGSbfD/yFo4W6z6zd/NOB1wcSfl5vtrgRX2GNHc1
         iPatydFkmjPAhDNEjzZEOdkWNVEBBFWo9LdFAoOE7PW44zZ5l+YSAybJtE5X59o9DUIu
         16YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=szTmaxP23lVkEVq/RlBkdxcb8V6CMoKd6fObh9S4BLA=;
        fh=syrw3PIZcTrqHgWTbh0zqF/5mDFHtyQHCX4lrrZYUWc=;
        b=gPTKC8RR+Xnttaolk4N845E1WxQwiPNzW7CIaJ56s1nouRmBs1mLsmUVKHZHkias+w
         nXLIiLo3z/2VJjLqhuJ+/kObBxSgKRWkdvL85z3VkNMOuEUsyDyscgmifveTHsIooAwd
         sJdn/V8MfBqBQvpfSvbnm2lQwiAbAaojo/eXW6Cq/ZBx+FWOsy1vxVdzlJqS1yzpBarS
         tLdk1QOB1vtX/82zcbEfHWOdo83r3driofg2sGfjdAFCNee9ncGRaZyfVZ/vfEYyf+ok
         8Ln3Lsl/qjYU1UtsVNaVMhVcQWnoQfztweKgby8UW8NpjstsFeewquHQz2obH99k1FT/
         +JYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778690141; x=1779294941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szTmaxP23lVkEVq/RlBkdxcb8V6CMoKd6fObh9S4BLA=;
        b=Mnz0ReYQKxqtSGLn3aICTB8GIlcb+ejq6ZwbKM4a3OUMjot/T1uuBurp4GLGybwL67
         Rb/B/qxdy1v4CZx+l1zBz/nHAKRHHRXcbm8hkrDQq8CPcDWrihdqOHFxtoDaC67BKOIX
         JWLpcwoD3iDmIOLYv88btopPuluD3uue5f2qEtZ9khgGAROt4kJtrkrMP5cee5aDt0JH
         /2kdmlm44Mhf3Vk3N8xyb6V0IwxgR8oY5ancyKc4zdLtrK/A9oDCsMNsk86VahGnou0R
         tThTlKSFTv3SnccWMdyF/bARMgNVJOPBD38yLXsae0XT6IFINMdWwyuSJ1TJX0816x/h
         SAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690141; x=1779294941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szTmaxP23lVkEVq/RlBkdxcb8V6CMoKd6fObh9S4BLA=;
        b=mmQZj474offWCoRZ+7IKGuIARCTgPbWSvCV8YfzFEczilBv3HklondsxR4D7I3ZI/c
         Jp33DmhUEl7tFP7C1JHutXj5+tabsZ2gscRhMSWn66nbEBWUBGZqAg++MDx6zU3i1I2T
         ccju0kXhQunEVtV+9SH3Bg7I2efSIzo/NrK3QvRw4F//SVxOf8oYQb4EbN4aH7a+VpxI
         Dyco+teDWEyqLSUJrDpv+DxdJf75YXjd8HSoqrg32QsFymLbUItvQb0Nf1CbYydDkmsN
         SflBAW+8H/u1vS2HzfOD8DInpduguQ3KfvR5uqGbbCkWQRc/KgtFEFPo1fRExyBYsJn+
         VJdQ==
X-Forwarded-Encrypted: i=1; AFNElJ//XDu/FbG/Wb68x/8mVMYG2k5Efa8+j5/m9BrgguP6FeSROGcizs0AgJBS/4KmJbdg3nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW15cQ8qJV7sGoIQlzwhclEJ+hfx62bgOf028zHHSf6RJGOwzn
	aCNhhLI79hj49EPr+bBH4jY+F4E1ACtgD2x30vQT8ujy2gZx/6MnBFOUHN01UdLq6L1aTWwHUF+
	f1QHrOcJk0vek44616lCX2d6bORActnw=
X-Gm-Gg: Acq92OFvX95n6Tz2+CcAUL8SW5E2Q+/LyGZE03S5BeYYf+vHbIvTBHy6T2oYJexnsIZ
	uYqH/fVoL3HQHv72lLh8dhDE968jdCxfgvMIMi7y7hWn5okxj3fLyslx0KHG5d1H7iphu+Bgw6b
	tz9Co3CvGdfHfhTrSNLMjAlM+y8/57UciyEZc67D+b9G8AHN2rccXf0yKoF9QxMy15I5NZ4VPUt
	OTQIH18zNSpGE63NDGBMUO8J5opIian4HMK/n6bwgFah7wLHXYVJuRqSahWbwQpRykLT9nEj82f
	a2HaMgyRbg0SiiE7SY6OiRyqpP58MpHd2vHGlRDYUXhEFedRblmz82BjV1+R0a7aNcnY9MnEM4L
	ezhp2/7Tlz1nyGDPXMyZAWjGzsIzfSdZw0KjB
X-Received: by 2002:a05:6000:40da:b0:441:36b7:725f with SMTP id
 ffacd0b85a97d-45c790b29d5mr5681775f8f.5.1778690140854; Wed, 13 May 2026
 09:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503164700.548164-1-atomlin@atomlin.com> <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
 <20260513111331.7bede512@gandalf.local.home> <CAADnVQL_sWznA+JJLdzP_ZdUgQeO7p-AGnOtx9=fXjH+PnRJBA@mail.gmail.com>
 <20260513112307.53e77312@gandalf.local.home>
In-Reply-To: <20260513112307.53e77312@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 09:35:29 -0700
X-Gm-Features: AVHnY4K_hlbgG6Weelv9JfOoNVR8uOv-dykIa4nZRH_llhP3bTFiLQRGwYl2Ss4
Message-ID: <CAADnVQLw+_NaOVeaKabuf085wNo_-6MAv8w0EDO3fBz3KCQT5g@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 8:23=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 13 May 2026 08:16:07 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > It's impossible to track all modifications.
> > See what sched-ext is doing.
> > What does it modify? Everything.
>
> What about just having a list of what BPF programs are loaded, what they
> may be attached to, and what kfuncs they are calling?

Ohh. These have been available forever.
Just bpftool prog, bpftool link, bpftool prog dump xlated
