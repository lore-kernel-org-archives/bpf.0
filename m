Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4E1E86E
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776035930; cv=pass; b=HzJ4JgsCpaIzxl/TMcvG18SLU59BxbwDBzGvvCqIfteVSrDqeKnciO3oTDEYvpcrHU2YUOliLq/Qqep7XyqEoN1pEe1inGOcVoiY77Mektd473Y3d40jS5uvfUUmKcnFpUukeiKJPPl+/C/lKo6u9LoK3k2399MwHGLbPcwrp1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776035930; c=relaxed/simple;
	bh=2KP2ZMzw23UQBAQnJYTBDjg/W22o+nUYWHKDY1LhwGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzfJ4WIl1n625h0gfmTQv/UxtEHs0Y0FcsKAnGOEedOsCqDPqSLLmw/x4mnfr5BpkY4MPVudR5SwMmy7mZQtFuHk9s2KRLMZloYv/3I7XzFt7IwsfrfWZ9Od2hJK13E9a+lSqrNuQlyKn+5At7aCroZQJaOltSDL6K0B3EW0xu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXZ7ocIw; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXZ7ocIw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso59464725e9.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776035927; cv=none;
        d=google.com; s=arc-20240605;
        b=L2J6PxdU6Qq/uxBx/jpFN3T+N59tgECxqcm6nnvjg6e6iRM1Q23VE6Fl2TklniroZK
         0gEWtpg34H5pN7KiBXmOiYvmtwd9uMth4bq0CB+S7F+2EzfWOGZNTej3qBskPlwnASpH
         S7imlZrdIVPtJfs82KsWM9gbEiNxG093Adpi8zpLgaUBK9IVa8z4816N+hsm12AH03K6
         tjd7geIR4hkUohSj+RwY8DRtrZmaLxjIJ6Qe4U98JU4P0kBWkyWocOtpPxbTfQk1Fvfz
         2zncnGthR7d/dTWY6yzJppX7+SOLiMEyQw5GqxUpINljk3j46SFojHidYLAATrmeoW+g
         rc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iBhkvsL25JaDpl2dYKRW/DqQJSr5mC8NwjEBRdoQ0R0=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=T1RiQjSO9xWJ82gwi0dGZ6Ca2i/EkoAh7TdjAA2SoPK9F6GqPxp6LXddJi4o55QWyZ
         Ex/fP9jXb9GvMTEOQDoJYpo3F8w4FEpK/9ajAf41fHYT/pblpB90ykFQbMj40ejb7vjN
         mmfNJJVhomK7d4fx3tAsRHHeqG2zaEv6Q0wMD8Az8qzQZfRmeoJtb++rOgfZbUb19CKC
         1dfvLWkX1N5RKHX+5bMmVAfkzzsKYPiFMHOeqDU3uZx9aluDKw4YE4ypkivV94r/h8YM
         fu2hGxlNN+AbjN3Ny2yxZCjtB+46QJPwp/8rYX5+0OSaqb1OERpS7I6zbAdC6TJFSXRZ
         9icQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776035927; x=1776640727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBhkvsL25JaDpl2dYKRW/DqQJSr5mC8NwjEBRdoQ0R0=;
        b=AXZ7ocIwGERQI876mAR/99AW2VETwzPyat9kWXtFKbL3xFeXK/2ML1+hDF7RfoH0GS
         /9ruGaurtKJr58ozrLWcldly7Egz7AcBNfEGIaD5vwS3Pej2YM9oHZ3qqFUqOFQCh84A
         7rIzfz/pezlK01pXomHylGV1asQRPZJ/Wp0mrRFn/f8jU/aMqguOqewZejbZOg0WFhLf
         ZR+HP67imnUL0UiJW2EbDTppk9j3nNn/VEQIVmaTm5yMNMvTeHa9ggwsiQAW5fs7APNP
         Rj7xsME9VHoJmU752TOeb/TsUqy5o7Kz1YctuBlVDAmDRW4f/aoO1hSmAKoG9tJ2jb98
         ZSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776035927; x=1776640727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBhkvsL25JaDpl2dYKRW/DqQJSr5mC8NwjEBRdoQ0R0=;
        b=TH//Y7TSAKK78IlJQ2c3U4PJFE/WT6UXjdwAz2dkXf/QHOolLKNEJk6qiLG/zmQLDu
         B5KtfYHwrFg6KKti1TJ4qjzQqQkA9w1jFjzwbtqqXIYhoRvW4w/i1fk3rGDBY3XCxQj6
         v/zDjvmohXA0C/Yvp+Jf5/TgUr2eK/PJcoLfG4zaI2OqCJgHfyqV2fLL5TvvKnssZejD
         wPmb3BVCVpmTUN9fKNKwtiCG6Wxd8nnCyvan99o8dOE1wPrXqqrM5kZRVSIe5/Mx/Uws
         bGAcKeSJX6nlZBUm/NLNfZoNj/tg06OGMwYbiUi81yedhhCHiQnLPjiigYzz2XvrqAz3
         0ywg==
X-Gm-Message-State: AOJu0YykxeJVIJzKMNzFOriWf65XVllls3MdyALHBrIUbX/ubh1j1qXs
	hkFoSuNsxRc3l+Wj+8Lk4PD2HzEFCznwQhI3vw9J7uMFwqvMxvxv2HXSKb51+R+lkXTE9YhCXK/
	Qfc/cLUDAfqGu01K3gp65J4wXN0qmbuc=
X-Gm-Gg: AeBDievfdlyAIlew/3Qm+9IrE3MDznnwZjIMb2Gk0C9IIRN7ELc9n2ekr5nRC8eiSgN
	FYtxW6QqCuIhr0KFPFIA/drV4j61BmE0NjN5dcpbIwr1Ai5TXGLZjHCW3RXhWFxUBpylRIgbCyn
	d6v7jaqnR5HK0t3QDndbPykJEElETjvHBPk2jYnjAmG7JbYf3Kgf/cFQtKSv3ALplnzUYJIEdv0
	mmihlcShXnU2vi4EhAOr+/2HJs/l7JfM7AdKeYATRmveKjkSpEatHWcsEkJ/aoa3o0FXUYFBw4G
	B3EbVvRzt+/8kHGP5olKukBEEGI8sduGQEXr3m1f8ZbGZJd4vRPXTLVBXnOiKdlVLkuBId1TIX5
	ZeFlxP0bIVbnzz6/1ASu+y9v0vQ==
X-Received: by 2002:a05:600c:a109:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-488d6843245mr102757635e9.16.1776035927226; Sun, 12 Apr 2026
 16:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-14-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-14-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:18:35 -0700
X-Gm-Features: AQROBzDyWbzUC_O5Bhn0LRnzo_7sMqap3uzrMyS--4BMSx3K2Zy313grar8d1P8
Message-ID: <CAADnVQKN-_i1PEwHobLYZ=o=ow9q3YQ=TDLHJqrwRCXZZJO7Vw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 14/18] selftests/bpf: Resizable hashtab
 BPF_F_LOCK tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:11=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add tests validating resizable hash map handles BPF_F_LOCK flag as
> expected.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/rhash.c | 99 ++++++++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/rhash.c      | 35 +++++++++
>  2 files changed, 134 insertions(+)

drop this patch completely. Yes, we know spinlock works.
