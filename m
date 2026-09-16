Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE313470458
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582969; cv=none; b=Mbbv5M2/61ht/iDUb4qkZnaPrrwBkxUPz6TaID4T96mM5wuGRtBKnoVIEuF71zLClymxeGVWAwSqC2vX9PeyMLCIyWXjhT3+gmOKE9oINoZcLXdi412ObN1ptY93VI6GyfRrkIVV2ZxWZwetWUqfJqaPA5lSuneIZthLBFd7TC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582969; c=relaxed/simple;
	bh=CJl4/tYnVCG1tSYm7J1eyOURkKkuYqP71o2CB21fRdE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=KwFpaD9I1dlQqMpdcJBfm0XQSJm6YFCQbRfHu1LPhu81JDhEwWD3zyO3/fyQQO+IcvOztPhxY2P25WTirbBoVZLxGj7v9D9d6AEmmCT2cwuCocgK81P0D4qB+JS8R1HvGD7/8P6zrAozB9R915uyuWEds7avzCusarQgDtFnm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWHKl+Z9; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWHKl+Z9"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b46dc430fso101495e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789582945; x=1790187745; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJl4/tYnVCG1tSYm7J1eyOURkKkuYqP71o2CB21fRdE=;
        b=IWHKl+Z9SX2abO8AIMFjVHw8JPzh6Ucqll+Y2M4UHmBe+Gm43m5lvHqjBdgUUJMd8T
         8nW+/bUGaBstzb6+4IaimSBERBu7EQIUH9jeRD+39KLk3WyLtdfJknusLiDRlJt43hVA
         ZRFzHuuAFKKUK9ZZnycaX6wIacokcVjuIBgHNGihECXjWgMjBgIAJ2x/ndHT2vXiRZGt
         vyuoJaJvjETVer7XWG5MzW6xrHqSBGpq8zXTZKlEc209qB/CLNFHPnO8PjLP3/KQlRdd
         bM1zMejRubhBtOfyhoHeBadqvCW4dQz75lIhL7zkr7MPKdrR7oLjami235ghbSYOKSK3
         WIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789582945; x=1790187745;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJl4/tYnVCG1tSYm7J1eyOURkKkuYqP71o2CB21fRdE=;
        b=m9El2kGnJI0AjfStZvHWtAKJ44WQbz2G8HmOk9mBZtcmcfec/emsUDrmj/nIa36ZiS
         su6M0F4KKENyhMMu7ZJ6H1lrJ5fWebx/yH1ccSO+Zl+lBfoPAOxNr3VAiCbiLXkPnCWi
         fj0c4DVyb8QZ/c4qxIalUCqYPUcqLrPIGh9egipjFbmWGDxCM/WqgiqI/lJ57i2nlwnZ
         wURF1e9Rqt0Jr0NzOlGiHMYuPt5k75CSNSlGzCSBKcmClvVPTJXdGQz2J+NLcTo07X1y
         g74QgdyizBkR/AkZJge3nMqo/g7PipPZPwqJ7kVgJga+/jhdGHTs3FY4l5IIh+Pc/pJZ
         0vtg==
X-Forwarded-Encrypted: i=1; AKwUvBwqykSdzM6xr8zg8sD5eZSNDV1KlH2rjRQkQg8ngaiNzPcAeNKs2D2m+MRnPgy5QxxM7iE=@vger.kernel.org
X-Gm-Message-State: AFuF++n9/KnaCdpqHzZhdsIJ8iPmEDE98NNXZMwwdBoTweTiAFBqp6Ku
	OcQ2slbTWomZ5NGZWp6MYV/d7nReRIA774yqLsJ2Y7BkH/6sWU5yeD/B
X-Gm-Gg: AYBFou32sKRAHALUa1+2f5MiM51mauuYeAGBiZfvNOAayQGAFzSPuZOun+WUq6PeVXn
	CkTA/8/LoxIpveSDFDLiobbs1MYg5vv9Zps4eDgNQNu74NCA/ebxgoTskOf5bG6eGSglD8Iz/H6
	8etti9Sv2I37AoIlv0y1FTZyjZQsEoLUs3oVaDxPzCS66FA9ac2VuSCfNTsfsI2qsp+Hz6/bJEw
	eMybPROPkEDtLjvISt7jRbyiBbHL677HTnOYZ9RqpQFjKJWRTFAKsxEFMd+xXXrdo1XpLSJDMWR
	Ox2uD4ilNnWc65ajgKAdFkwyplyBLjjV+KeWLo7fMvkOZKptSlB7J5zJpGRvfqDhOdbJ4tZiJub
	Y5Xt+dP9oIcDQFdYt8aY7ZHI6lORn5AC9c9hzDTqnbhQC6CuJqzOiH2NHUdr1pZvDieUPCx1w3M
	xNc7lIpm8Y8l9o+cRk71Yzu2Ad6CDUqbHYRAmuQs4P+TyShGNj400yNk1GUgkQxd8EoY+LI8ibV
	KaiRmE1Z8sTyT98zUo5GcM2+hWOFb7qyXD4JYxkP6lOIqryEljKJs6lHV3KGkAW2ftOkOaBXOP2
	KNo9dJiI9lzTQZnseAhQ3PJBgchAyA8AjbcsxQ==
X-Received: by 2002:a05:600c:630a:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49eb7325340mr43310555e9.17.1789582945148;
        Wed, 16 Sep 2026 11:22:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf3494dsm8424311f8f.28.2026.09.16.11.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 11:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 20:22:22 +0200
Message-Id: <DLGY7IFP8MOG.YFISSWRDGKR3@gmail.com>
Subject: Re: [PATCH] bpf: local_storage: avoid redundant IRQ save on bucket
 locks
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Usama Arif" <usama.arif@linux.dev>, <ast@kernel.org>,
 <andrii@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <jolsa@kernel.org>, <justinstitt@google.com>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
 <martin.lau@linux.dev>, <morbo@google.com>, <nathan@kernel.org>,
 <ndesaulniers@google.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <yatsenko@meta.com>, <kernel-team@meta.com>, "Amery Hung"
 <ameryhung@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260916181001.201787-1-usama.arif@linux.dev>
In-Reply-To: <20260916181001.201787-1-usama.arif@linux.dev>

+Cc Amery

On Wed Sep 16, 2026 at 8:10 PM CEST, Usama Arif wrote:
> bpf_local_storage_update() takes the map bucket lock while holding
> local_storage->lock. bpf_selem_unlink_map() does the same; its only
> caller holds local_storage->lock. The outer lock is acquired with
> raw_res_spin_lock_irqsave(), so interrupts are already disabled at both
> sites.
>
> Using raw_res_spin_lock_irqsave() for the nested lock saves the already
> disabled IRQ state and issues another IRQ disable. The matching unlock
> tests that saved state before leaving interrupts disabled. On x86-64,
> this adds a pushfq/popq/cli sequence and a test/branch around an
> unreachable sti to each acquisition.
>
> Use raw_res_spin_lock() and raw_res_spin_unlock() instead. They retain
> preemption nesting, memory ordering and resilient-lock bookkeeping. The
> outer unlock remains responsible for restoring the caller's IRQ state.
>
> In the tested clang x86-64 build, this removes five executed instructions
> from each uncontended nested acquisition. It also shrinks
> bpf_local_storage_update() from 1732 to 1702 bytes and bpf_selem_unlink()
> from 1030 to 992 bytes. The affected paths are updates that add or replac=
e
> an element in existing owner storage and successful unlinks.
>
> Document the owner-lock requirement of bpf_selem_unlink_map() and assert
> that interrupts are disabled.
>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---

Makes sense. But did you observe any measurable improvement with this chang=
e?

> [...]
