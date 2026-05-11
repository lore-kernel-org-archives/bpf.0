Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3E3A5E77
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532295; cv=pass; b=Y/jypUY+yErXpG0S5U/LHTIzXualGKwjUikbfzHRWd7ME22UzmFdAjOE6uLVrFLMUfQyWr54Vtkn7f9vG5gPCNjI5cUdJlTTCOyOmqZO6YPdcaJrMCN4PkirFD6gMtoFdj3twa9tEgs9K6cT1OciG6Qp8H8mAMF5pGonjuffpuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532295; c=relaxed/simple;
	bh=Lsx7HNxS24AkVUOKYhryh8TJ0MlTzkkNg4zqi1eTIJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vz0Z3qsgHVVzlkGX0LcsfUb8FsSTd7cO3atHwDpZOr5+RYOO11dztHLoHh89v0Z/7+VtUe5H7wtMJbSFDYoXNDvhh+2tE/1+rndKi2/nKtM5ydT4/jkTskrzNpHsbRLowaup8JqIKlyvMTiEQFRSLLG+On8JQLrO8KNxud2nXzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzKQ7LAI; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzKQ7LAI"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so53359515e9.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 13:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778532292; cv=none;
        d=google.com; s=arc-20240605;
        b=ayCkla1qZTAMYpKRoxFiYtjQDIJ3f8vqIU3j3jAYkXwV+/6vrAHe+FEtlCNG3Uzomz
         XxuCpWK9ZmYN6ZooTodBG3RUysAPe3yiaJnpanajjlJ0EYnnyy5OqPz0PAfnVbs65jqf
         vxgCf2XL4CPIQ+ZkXW86C0MDbI+IBa596Y0CcdS3Vfq20f80ZpF2WXyflnV2Vw5MSu1w
         x0aVJsPhfVmZ1tioGUQAxbkmofUqIhufOEQqHjlmv7droxfG/1/c6bgN1GumYcJUBCcR
         NqMbnIWbq8gzowzW9+vA2FgwP9PSvB29n0Cp1cgwwizfvldv/CtTDK0g3QPIxxzYy7EF
         7oYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HxXhE1E3zIMNXAZQMW7578XkRyn0VMcl/G/klUEmemo=;
        fh=IXxuFSuX248qG5qUpOkStM63fF5ZOATwwaXRTw+re5A=;
        b=NjSOmIgI38Hvk5g9/5y4zz10clcG5tSY3MR+BjGooHuc9/qcD+96CBRhmA9fX+mGJO
         G9rCr7CaDC9IlFP4kHDRG7uzR3Mi6F+xMEp3+9vWB0r34+Oz5fyAf+0ECrPon+Ao5BJh
         xZJ7cQwsdzA+GYjV29OissPgvR1oOGO78lK6o8P3JPU0MCWods2yUnmiSeLA0NVZJDqQ
         7I2sFDijcjFTfgERoz+c0RpwdLRpNhAGGbVB1Zl62amm9l3GQ9jzIaTeLbQhmdtZFGLA
         KWXh5hx2tKUYXrBfhs4pBk6Nq61LgHbOhoL4xJ2UTRDi9wKbBIUh1KxHOX9TFfMT0EC5
         LQcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778532292; x=1779137092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HxXhE1E3zIMNXAZQMW7578XkRyn0VMcl/G/klUEmemo=;
        b=BzKQ7LAIwJQtT0aeOWNZqHH1f+PCFAzdkmrnO2iHVUsgy+fDoAoSYkJLQZ1QuN+8aV
         9FTD2nOJjmBZgNuRqTK3zOw/q8x/FN1lKCuljNZ1blK4IdNRGvwCGTPm9D039iPQhBdH
         AkXYxkFaFN+x+V4dEwIQHUj9MpU0WraHLbXppY5p9T/UwqSWV9Rl9vOCFVI2tws3zV+r
         6weM0j8rJdUyE45Xa40aX/+evfZ+QOEWikCFYJBt6gQQ45DrW6H3Ac2gGIrICfEOc3QD
         noRTLMVBOBY3W4vodSXyfynk6OTJs59wpxk70Ng/3noQBK88RLA1q4JXQKSSqvEW6p9L
         KVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778532292; x=1779137092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxXhE1E3zIMNXAZQMW7578XkRyn0VMcl/G/klUEmemo=;
        b=MZcBvJccBWoZSm/nslGxM9D6FB6pwhfEAbSLmdt9LMztVbh6sQ7yhRBFQTSeKJxScV
         jzkMaIgpoEhu6s6yrCXWgoOKDwxoSiV9jZzNKlVXq+NzEcMWHfG2xRI853AP43K4UcUo
         qvNgsiI3pwvKTlgOlxwLh+JJ46q9sji+FM4NQgEtitgCKNQX02UT//M2yDbR2kPHHHrg
         mqdt40aHy+HBJZMCV/Iv4ZFxIugNpdBu370/PpbaZnw4UjhapfICWUbz+fPFVvqa8Zfa
         o1Fm7e1RrhzZQ1CeDMF8bVP8WtXbGSpcZ5lgRfkwjgm1vutXkthRDpgN8HGzWElZVhqq
         TZzA==
X-Forwarded-Encrypted: i=1; AFNElJ+kBmZLOmpdZQOARhBYMkN9chCXlHTpfAyIUDnF7e4K6Ccb/56naskDKR62f7rZmrhCtcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW811yPPvBx6mK5jAmdxIq5uqhJPH0viOqhOcJI7qCHvzDO7Uw
	Fuq++m91Q9Lkca8JekXlUhnAWeR12IWBne6tMybC4SXTxDyYiN0/9XQAV0VTM/aLOXts/0FyeGP
	h4XyfV50M7GAU38oYiS7tgX1VQszjqYM=
X-Gm-Gg: Acq92OH8D2Klvv5NilsNLBKQ1DQtLt33HtmCuS/kDmpdwQsQA+o8V0d9E14jBUV7b49
	je0BUwN5Ed3O0Qah7/UtIW0wBuC9yKxsXxu37rkAACSN3acfpFdgoB433BA/rTsgJrVYU+NJ1oY
	LP4bH5FTNJRJE4juMIPEYk1ZfFG5uga5r2nizakqD+VD0QxaHleVD5m4SY7ZOVrnqli0lHC2TpK
	xClrcokv3FtlFJq0/lN9hyDZcL47LA4aphzQkC+UTsBHJeWjXvNBEbhH/LJwqo1cGkOCkZCSC81
	YeHnU6mxQ1tR1CYhrSUma9c8YgOKbbTTxZJiWNvSg/SbwdKOd338/2TuhhNnwvvRvKOUv5wCQGT
	4k52CQkT2S0NfbyZaG3jqXIIitRnGsKOge1EsYlcmYMaU7ZYuaNFqCEetTA==
X-Received: by 2002:a05:600c:34cd:b0:489:1c5f:3a9e with SMTP id
 5b1f17b1804b1-48e706f3688mr182545995e9.13.1778532291754; Mon, 11 May 2026
 13:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174559.659782-1-wusamuel@google.com>
In-Reply-To: <20260511174559.659782-1-wusamuel@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 May 2026 22:44:15 +0200
X-Gm-Features: AVHnY4LE3o2vqBaZVgI10g6eDtVh6QEf9MBs5iW-S47AwW-UDvT4urkZRxmTfSI
Message-ID: <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Support BPF traversal of wakeup sources
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 19:50, Samuel Wu <wusamuel@google.com> wrote:
>
> This patchset adds requisite kfuncs for BPF programs to safely traverse
> wakeup_sources, and puts a config flag around the sysfs interface.
>
> Currently, a traversal of wakeup sources require going through
> /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> wakeup source also having multiple attributes. debugfs is unstable and
> insecure.
>
> Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
> traverse the wakeup sources list, and a kfunc to get head of wakeup
> sources list is needed to start traversing the list.
>
> On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> speedup (sampled 75 times in table below). For a device under load, the
> speedup is greater.
> +-------+----+----------+----------+
> |       | n  | AVG (ms) | STD (ms) |
> +-------+----+----------+----------+
> | sysfs | 75 | 44.9     | 12.6     |
> +-------+----+----------+----------+
> | BPF   | 75 | 1.3      | 0.7      |
> +-------+----+----------+----------+
>
> The initial attempts for BPF traversal of wakeup_sources was with BPF
> iterators [1]. However, BPF already allows for traversing of a simple list
> with bpf_for(), and this current patchset has the added benefit of being
> ~2-3x more performant than BPF iterators.

This looks good to me, you can add for the set:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>
> [...]
