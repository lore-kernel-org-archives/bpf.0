Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8FC3890F0
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785603170; cv=none; b=PNM4ho52APHTyrua49pAGa2Q4oUHT7H8PyZaNW3z8mhz+DCRpamZRSf5IDSWQatcLzT/p4qvSY0LWtFV7C52ZVrSQAYnE5MKwdVtz+sewAe7MAXi8wNO5fBGCpUTG4G4xUyQLSUtZGm6d7EaOd8K24xY1HIECv/rKr+koNtUeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785603170; c=relaxed/simple;
	bh=KgdOOMyZqtF9at8+Chv5TnjOOT3t+C5+wsxUxONLNNI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IjQwBkG6kuAaocpuwMMZlsk7DGaz5g0odKRg4V/+Kk/qxJe6p5Lk0IR9yZNdJltVdSLg8YcGxuPVEiDk2JqnejEU6HqNtnI4oKhRTqnPW7VgVxEmsvJ3+F0hB7hjNb0u6FqGf8DmiPGdidUNpX9LRgjgTE59efZb03Nsy6wgDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW8mZCcu; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW8mZCcu"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso4164495e9.1
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785603166; x=1786207966; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wIeansZilxyffldQc11/VX8an2oLgIWn7z7CoIfg0tI=;
        b=kW8mZCcuJkv5kOqCwhFSmru0R6wA0mH5LZTWEBDQafnO+bMZ4udYRdC2N902z/0bto
         WMTOgdZq7UHijeqc9PjTQryAi+UiHIgbTDwfDFFttMpbc7vsh9gGMaiEz0Sn92lLW4ad
         S7w2m+ggMgs8mN1QC3VbZvyhSr2zJdqI0QuFQoXWFS+YYZceA230zBiGqTODDJINI+Go
         CjazApNM+7L0Is+mPdU30TB0ImbnaBucVANoq+bCQ/kYscu/CYXipbDuUK/5rRIzrwEI
         dcRvts40qfYHFnjF6EuBcDZIafsM8jUovFfWSy4NiBpeFHeK3j1OGpzfIPrgwAkcIlv/
         XLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785603166; x=1786207966;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIeansZilxyffldQc11/VX8an2oLgIWn7z7CoIfg0tI=;
        b=rMyOOKaYvDJ8uwjO1dCM7CHvrrVY6Xr66BEVmtIhDTImwsGXY19OOxPOGI8YYNHbOj
         T/t1IN0ulB6T0IavQ+Xrp7r6UWFm3S79ITrrev+rxHmcegM011XzeapaDvoo4T8Fm9+/
         umuHMpfLjdHhZ6Hmr2QyE6SO5sCN5C90UQ7Cpn4DKgJIj56/jXDZMp2drWK6IUBIhDp/
         FsFRB0HJ32P//XZ87JfOVIbwqbeYAxtNVa2t9u8bXBuIVX1DQm9IaCYdqciT0AyPzTs2
         fumHw25ZB6yxDrmajpNEYEsn7ylpzZGOmj6ePPOmJt5UYZ/gswdh4kObFYq/9HNsdudO
         ZtmQ==
X-Gm-Message-State: AOJu0YwVo+f2VoIlC9L9/GCVvF5dywmUHLMIAITdRjHuX6v9mlU0shVh
	Ir2KBC4hKobvToByHl2xdr/4U4xjxJsyS9RjgnzTQ3F0jehfVM1c2Ci0
X-Gm-Gg: AR+sD10fIaY3vXwTDyAwhqiQC85q9GakkMZJ+T11I1W+aoTLh+AIRFIpEFx+Ie5sNlQ
	K6thx33anA1rBaWM4lKVgoqN8OdZ6vr9CpatcUj/c5BtOaX4cU3jT1NpWo7lYtFjiAFLFbMKXpY
	4nIvpxcNqZSrcfShmQ8n4hy0kUKA/Q0oeh4jdXlbw+igNu9eIDUy87Ulg0+y4xjyFUhvRg9BsIE
	HSSBVTXqgUlq26tBNK4oVgHFQC26inZfrPZAO34xDreVTA8hYK/VPR//9pfKy40J90voM7sT5Kb
	a0idxWgjD0t0loWYtdn4T458yHz7Bg61KyN15AaO5zJdDgzJ5G+MX95G7ehxlgrqoRXdrEV4de0
	Cd9XsmlWmTucFxvJ6A21Oag2gMbvE2hKjL/I1V7s7dLqulxVU9pZkNZeLozoYI3pfNq38Wkp5C3
	6NKVME/vMm7fBtI188bADAglFgScT+hpd3NnqDZxSZN4nPBklCENv1meX4Wk2nVYuHGhTTtJKl5
	N/eTU5adjFTqEMxR7ezfsW4I4lBp2lX7lnG/pSkoXnnDWuSlqQ74PFDNW+axaGLkv36wT1RVOVY
	N2x/G7rr7UV2FEnqDUyZIvzeDEM=
X-Received: by 2002:a05:600c:8b17:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4980c66c926mr70298535e9.3.1785603166215;
        Sat, 01 Aug 2026 09:52:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808191ef9sm78066875e9.1.2026.08.01.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 09:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 18:52:45 +0200
Message-Id: <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Jiri Olsa" <jolsa@kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr
 assumptions
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>, <fsverity@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260731003925.2728977-1-ebiggers@kernel.org>
In-Reply-To: <20260731003925.2728977-1-ebiggers@kernel.org>

On Fri Jul 31, 2026 at 2:39 AM CEST, Eric Biggers wrote:
> The BPF verifier and the dynptr abstraction ensure that the memory space
> referenced by a dynptr remains valid.  They do not, however, provide any
> guarantee that the contents of the memory are stable.  kfuncs are
> expected to remain memory-safe even if concurrent modifications occur.
>
> bpf_get_fsverity_digest() didn't follow that: it could crash if
> arg->digest_size was concurrently modified.
>
> Fix that by using the known-good value hash_alg->digest_size instead.
>

This makes sense.

> Also correctly handle sizes over INT_MAX, which previously caused an
> integer overflow and crash.  __bpf_dynptr_size() returns a u64.
>

I guess this occurs when using file dynptrs? Otherwise the size is capped t=
o
DYNPTR_SIZE_MASK.

> Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
