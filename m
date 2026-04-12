Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B207082D
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776035429; cv=pass; b=gHsj318o2VG4uWDRNNk7FdsbPnm+eyduNgdQJ4IVOzgaRak/flUQu73uhDY3AUystBzD7/JL1942dAY+yzOxSCtPVQD2bULPtNHKSjBCdcVTV1nmXcDBaIgrho+59a4fSlr2ljN19rQDKMLNYF5aSn1PT/5cm0/nzrIlPXrnmSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776035429; c=relaxed/simple;
	bh=8rz6Tx1iGyWQsFeXWN9Y5oPml9Qlubxcs7Vs5P0IQZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5Wzj/0XQU78oQ+ZPXEp/uGq3LtJID875rWQY1LtADsiDOU6mT+bXyn4PJPha4INce+hrkukh867r0E0eIC4D8GPJml8F43ARTQihuE9blchX60TWZd3cLKspnXV5X8fyE4BJ9c/D6ddB5AxYOFeTRZS3ots98hBSkr8ZnO7A/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcjjpfnD; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcjjpfnD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso34402325e9.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776035426; cv=none;
        d=google.com; s=arc-20240605;
        b=ep4fMyqrtZSlQQfS8X0U2PJAKKaGJSevoME/NE+cjTULQAOKQqAXki3VIEYGwcf9dd
         P0jpoPwWt1dIE/YZCd8i+QPdHD6vNzL+gUMXB8c3EmXRwe/J0elpLhd9ImyCaOwu06PA
         x5OU4sDPE/LuOEPWelYlgkvUBxhGm/DzedMCN6bDgkjpkuHTV53rC1ewaOWlhZHMyHTg
         SsRSBX9yr4+I6DZgGeMGFEu2SAFChsns/k/w/qz2rmOx7k9epmkIFFADepPBrv9qyThY
         bnctinMK0vwcI8iN8keWLYvI7XQiByNIsuv13W7RP5LB0ZRlnICzSggiavATQogqI7uR
         leNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WXntvhb6lS83YIFgsd4ADNGkjiZFylG+adHR5IPtKDs=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=aRHAXxvszKpXR6Dqw5i32kh7AZgOOWyPS+iQAwLr1VKVfnN0R9e2+Gh4DFeimOLHNd
         pa2MTUBVB54GPzzKgOGMt4lh8vLjzEyCrNWACbR9oXJ319Q90/4arBzYOnxEyEpfkDSH
         bbblmzHtEaRwjgA7aUMu53+TMfOGqD1aDvo9na+xoEiOieDMN3VjFrqsQ7XhqVCv/KON
         gxck1syd8BK5RptlzcCn+PdKLyh87bxP1/roGMwI5n+7c77ZEKZEEp6i9aUXkQCEuDlS
         96cxwBMPZqM1VZCBFing1Qy7a6ETtcoT9W/Y4kVIBZlNXFCQ7G8NIYEK+ABuGXfpXWfk
         FY2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776035426; x=1776640226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXntvhb6lS83YIFgsd4ADNGkjiZFylG+adHR5IPtKDs=;
        b=hcjjpfnDOLxgNj+cTrCZKTLfyuEgNEIqFpHs6U2XcD74S4OjTgcETU1GCP7tCoNSKa
         rw0IM2o/InpqYLUBa6lqHIgjmbWhRmfevOHA8O4Dzsf7fs4MnUPp7EUA9WeDpLMeo4JA
         e5eZSpbjml3vwKYIYUsDEAbvBsTF2PsMpz/hLQi+YLLi5T1QM7S8o44KShnzqB2VW9i9
         GJjMT23Kcwi/AhEr/OlGwAbAM4YSUH2/zG9IViKV1JIt20y5oHrP23i3SAS6AX9VKNcT
         XrDh+ieBQo6MdtG5tVMaTTKP5wWdWqyJ32kOeI9SxlbL6qDrs2rxioaq6sA0n5GTASxX
         8g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776035426; x=1776640226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WXntvhb6lS83YIFgsd4ADNGkjiZFylG+adHR5IPtKDs=;
        b=tBlNQ6f7Vv0z/dnF8fRjozrJn65OjgxSpECAyuAU+7UfwGv3pRnerODgF1iCYmAKNI
         WE2nZie6NHcJuWhlytkm2072oquCNK7fL8kykziC0kNgLkL+ckQT+AFctTjLrtVms6eU
         x5Gfv8ymEFMmY+4MoWf4FVLKN65Dy6Et01fKHH43JG8qaA38Wv+eHb+LxETMCsDS6obn
         NRjqtDrDMq0burNgj/nzkvpzNq+GiKvxdTGgelnHkQeLv69hZXshnhSEz0B0qY3bYOJL
         tkkx8XxEW1Fu4fbKbUwZ8RWjYD0gH6hSubSV+ryF0XejloNxsdY4X/GwVByi1NSk7K/5
         dOvA==
X-Gm-Message-State: AOJu0Yzb6A4LBYeQb5T93FWF1/i6uAfVxJYCBmQQQsqJ9bCBMYHE97Jj
	RXQ7DIbzVT8qM6B8hpzI5Q5h5QxG2aV0nHATciwOCd0G3K7EF0tXGqPuoNP9Us1fvFIagjvpE1R
	RYEArhMvNAbKPXJNcuu0UPA/hWlznnEo=
X-Gm-Gg: AeBDieuMNqTIBwanADUWnziU7nQ5u8VujERLpxSgs74flHbcZbaBbZhLkGCF2fBiilo
	/hkfCH4K1/37b7DE7krm+NN7ImUIr+gP79X3Dp4UrygA3BaYG3g1CR3wOXByE9g4GO3LzUoHKS7
	DFgsisPloPL50RNcx8BdLixchU4ZFz6PJX2dK0F3WIYnLRGlAjQ+yZD+XRvl4szJkCshP3SDuWJ
	mZht2feASg6d4Ul/Mm39PxkPGMBz4W1FdnD9mH3/JLIsk0IzHSnJgnLNsTeBIKC2frn6NnOaWG0
	qR7NF8rX/JuUb8RwpvL7i3U5kGt/2gYvJ6WkYRPcJOzDJTO83jZcBSDjT2qCPZwJejteONNgq32
	0QyT63bjMoBnhcM/zpZrzKLrOHQ==
X-Received: by 2002:a05:600c:a109:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-488d6839866mr104866155e9.16.1776035426257; Sun, 12 Apr 2026
 16:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:10:14 -0700
X-Gm-Features: AQROBzALTf-JhWwwsVGuPsEGqVLAXqGpz2n2MhsawKYjyZJySBWLbB8qtURkrbk
Message-ID: <CAADnVQJ-rW+MkrrtaAoVvExNYX9rEc+=zSw+phzCgv9QtaAX8w@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 03/18] bpf: Implement lookup, delete,
 update for resizable hashtab
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:10=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
> +static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
> +{
> +       struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, m=
ap);
> +       /* Using constant zeroed params to force rhashtable use inlined h=
ashfunc */
> +       static const struct rhashtable_params params =3D { 0 };
> +
> +       return rhashtable_lookup_likely(&rhtab->ht, key, params);

How does the asm look like?
Please share 'perf report' or 'perf annotate' for lookup.
Maybe worth it to include in commit log.

> +}
> +
>  static void *rhtab_map_lookup_elem(struct bpf_map *map, void *key) __mus=
t_hold(RCU)
>  {
> -       return NULL;

imo there is no point in such a step by step introduction.
Patches 1,2,3 can be squashed.
