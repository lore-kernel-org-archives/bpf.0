Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FB33314B7
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786596934; cv=none; b=J/itOfqI78HvS6tRGojZovetPLRHM+l2I2drCq6Bcq4m2qKmeC4hbTDEHid4r5QT349w71kxN8qAFzZ0lJMIsPUHc0NOFd7K9C5MxBwxMV+Ja/5Ko5fGn0ZIv/UA6Mx5/LGV13czaAK+94VcAP79yG1e48B10rG3bZuLi0U5rHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786596934; c=relaxed/simple;
	bh=LcDT13BfJZLygNzuHMSU17EAG+rR9RjyKf+PofnUB8c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=afq6HerOGzG8c9rrmzXBUoLjZzPO8uFqX40YR457qxuVOPFsnMS6f5iOrcRGLKYtRDolUK8gnp0YPIOjEGZc9h/k+LyslkxjLgFxLgW4ASEX/wblNwKNP2LXUBRmiXU14nIKpTvwK6Zg+azVoSoWdR9xRjI2v9LbZfpzLQtJUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZq6HTbU; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZq6HTbU"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso430390f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 21:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786596930; x=1787201730; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LcDT13BfJZLygNzuHMSU17EAG+rR9RjyKf+PofnUB8c=;
        b=pZq6HTbUz5hbRAAAT/wtJx78P7uLz8HaKthLqdu4ywMpPxcbxlzx3+n+XjHOdUlPBT
         SjZ3CzqAUYBpiyL3ZZn91tHc4THi8m6Ahe3LIXnNR/1Moe13g447Yt99lOvQ4MvpIViT
         yqsD0NGrA08W8d6dplsiJQLxHNcrv74B9xGXmcRBiwdhoeAiy4GvHNamvuL389KkJz3J
         iiUc0XIDegnO0I5rYMuBU3UGlcIXGZBUfXzRUaXnENMiLHwMysQEq8BOL8qNZlyDKrYa
         C1EvTA+ONHIH2/naghCGYnFJgY8gyCIv5Ix9/JpOwFtskXrBxhtcCt2o0OtG+EwjfSSc
         Kthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786596930; x=1787201730;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LcDT13BfJZLygNzuHMSU17EAG+rR9RjyKf+PofnUB8c=;
        b=RCO5XyAcmCQ1fLheXCt4EGF6Ik9z2GakHQ53xF+iTDEynPm1LaB/b7EOOymbXRBQqT
         AXlouSgz5SL6tDiOQFtXrzbGXy7i6JWZDvRNkMZF/DYyR5wzNjBwTTLXVfOtojAJ7S6Z
         o02qPizsvq0RU7kT5LcX/18d7ogk2BfKZAMyOydCGluoYsuIizktNi7OyZONG/xyoX0b
         l+Wpk9WyfNgIcSYLpYv/VWqJen2LBXjUrQZdJhIfnRQal1Ul3DwiNqTrzItPjpgJN7CC
         NENBYaTEQYDjXQts+CEM7aQUejdqdSzb171wAchf4Aj/6/IOC7OjgMpJg8HXZf9hBaLD
         wOlA==
X-Forwarded-Encrypted: i=1; AHgh+RpNWtOZwOfGJwIv2Kqr6tQp2KiCCIqX+c9KHQKFUySfdCJVieb0j7gvOtSaHbKT8Eds8Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyQCd3N9lj+ska3atmjakQy7GnnpgZ+kPZ6vcZKEXlq5KtPxF
	IVvKsf9bXllWdasIkLv/nREZNseaYy+hJOvdvucH19SU+knPJhSTcX5+
X-Gm-Gg: AR+sD12eHtklBU/OrQRh3AK7QkouvvEsAa06IboPQXGdhh2HPKhF98N8ejxM//gcSM0
	IOb69jz7PAodwmnMDeIHoJ61Y9sOGZMg6DqNYqqp8UtE0Ej3dWZvB8atN6AJb6t1Fpt0QLhcdRj
	m9wAG/HZVdM2MpLsqK2HzGTai6e+tiTFNZF1ZzgS6rJfWNLHuTRegHIXzRKuxnS4sw20D+HpSIx
	i7GSLC8OiKhifNcSu92t57ovL3t8EWa2sX7Mw6/AZ4PNlZO4vgDP3zUycKapSpLu216D9vDbYtp
	RI3+rw5G6uGg0iHBYbA34EPGUdcbVMNzO4V3AipVyFZsaXTxMEk/CSDBVr39AhPYtfS8sGrJOWu
	jOF3KwU7P90iAJyO055HyooZ+rw8VhrXJ0+oIStKDtVcUBmy95yVz6fxgGvgOBgpFFtoDQjPW9R
	gHzmcmcgPPB6BJawB3+0LrmCsWJcOOjc5P/1WGZuYd/GDG0eTcSE1NDtAJnIe/m+mpfL6GMHIY9
	FxusleFSkxUChog9gx8TnMQY8qpz3lB3GGyJIFNU40w5ytaXgdm5HeJo461c1DvU6FaMzbfkCYv
	r5pwLjWdaJbOygcUp3nyouCbl24=
X-Received: by 2002:a5d:5008:0:b0:47f:826c:7422 with SMTP id ffacd0b85a97d-4815a0225b0mr2873991f8f.17.1786596930203;
        Wed, 12 Aug 2026 21:55:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5af4b2sm2779518f8f.17.2026.08.12.21.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 21:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 06:55:29 +0200
Message-Id: <DKNJR6PWB9H8.1KQ1YNIGKMXTE@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Trim special_kfunc_list in verifier
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260812164843.55601-1-leon.hwang@linux.dev>
In-Reply-To: <20260812164843.55601-1-leon.hwang@linux.dev>

On Wed Aug 12, 2026 at 6:48 PM CEST, Leon Hwang wrote:
> The commit 7619a0ee9340 ("bpf: Mark existing lock-safe kfuncs with KF_SPI=
NLOCK_SAFE")
> dropped some helpers in verifier, which also eliminated the use of the
> following kfuncs from the special_kfunc_list:
>
> * bpf_arena_reserve_pages
> * bpf_stream_vprintk
> * bpf_stream_print_stack
>
> So, drop them from the special_kfunc_list.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

Applied. pw-bot is asleep.
