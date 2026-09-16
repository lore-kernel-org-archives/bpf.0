Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8F48FF60
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576727; cv=pass; b=Rv9Y/S9aNUxrrRyIIrcUC1giX8pXaAG/ZP42iEXXKa132yPdkxQI/FBlWQf04ccHveRymML/w2OfXrqSxkzHYWu3VboU0MDgkXPQYbDcJb53Qu2Kcug8oZMPGLjcQm2b5dLrlyCLv2bNl9P0IoTes/b2eHI2Fbzq6dKd2YTOPuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576727; c=relaxed/simple;
	bh=hBtR0lYoj3yuAHUJjn0EsU3G6wA/3HkdbSGpeReLLVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY1OUN49aFfZmScmkVPsDOzdempeya5aWcv8+HvPvOHyJcErMF9p0gWAyEhaDGww/2vQumaiLbpg8KI/NrLh0v5G+dZOSa1R/DFmjFfuJFgxdXocrdPK0vVZ9qIEJDSYiQ8IxSjdsMKLoe4rrzikWqoYt0bmos5VUNTRAoXw4TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiwh0mFS; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiwh0mFS"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c4923c9429so762433b6e.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789576725; cv=none;
        d=google.com; s=arc-20260327;
        b=f3ZRJhqTmwQyL+zI2ntL0zUV5oFKWA06P5dgaxahRjxjcSAmKlr+Xn6/iErNtRjOOt
         lVLXyOGfV9gWIUdS2aZP+DYf0XruD7P09ZUnt0q8VtHBzjKe8eM0GCsepo0Fr5J0pxGw
         +FhRf9UUr3mppflQQWvhTtscZ5L/TZuUPS6b9U0qlYBS1ffEQbRkNxtTJ9pMaT7/iUl9
         zpUdkzJ+9k3eC94nVt+cq79nL0f7uRdZ//WG7fnPOQO6WPuNZawksFsnhnslwIx3aiaF
         J3B8cgw7SWcs86KX45w11mIp+Xl0CZ0bhfTd81aiCXHLKA3J8Vzibw3rHbBhqwXtsSKB
         rTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Vz7/JRlsWulHLIc80A/EIodPWcmPZNwKjzejFySWTlw=;
        fh=7K2qWJ3mUiPSelnihIFryY3l1DriTibHaNVcRL5iMOk=;
        b=NGbvQkXpzsSsaze/jwEnRTyVxMLzpvTMeqdc7oVSDHKooH9NoZ3hrrbSv4sDz6t0Az
         Q4E65te9vPysSDeraIBPRSnUrTtHt8w5YpIV8sfTwt5r7oiaG+MvGFW5IwUKqHJPdLzo
         iqWrGqqPhu4W5WHAPlVcsk/l1/Vmo440wFatWfEfyHLUEYRpWjq8zAl+m3+H/IeIFwFy
         c+p+3ovaBVLn+H/2ddX11hs3EnrM16ZxwAYWHccsnW/Le5lBOA+sOo70FW45/LcmHaX1
         71gbVIrGikMvsBGTY2odICJ8tZT258UIusea0Qjo95vElDDgW1bqedr90ZY4wdI2tWiB
         TXIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789576725; x=1790181525; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vz7/JRlsWulHLIc80A/EIodPWcmPZNwKjzejFySWTlw=;
        b=kiwh0mFS5XASJSrrxmCFoQ/bIpL6emD2VGYVEUGJwWl4o4bYLe16xNdISczUqGjD1W
         kU4dhT4fERHM520YRGv7FndEg0UtltqG7lrYxZ507VbL/yPgyCb7Iuipi1Fc37xLmPeX
         1W8vXu8M/vQbtCSZl84K5qgl8+kddC/QwhpJ6Q24QNsodhxSfeHX5XeqRG2uNEhYdzHv
         /I2m8ipNVwlmLU0WtovEQIoWhqxNWYydoh20mSJJpRL61qEXtRUeG+chLinWJBmjNoQQ
         sxasfL3+CeGQsYhxPRlNJPBB28ZZhMUCC63pCarIbA1P2/J7H19cbVi5HJVZvrNTkNXa
         NGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789576725; x=1790181525;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vz7/JRlsWulHLIc80A/EIodPWcmPZNwKjzejFySWTlw=;
        b=rJUMTBS+y19kA4CsNSouw8ZCh3OZaKJ6VsdjEpkF4k/h1kLOunTBx1f3KE56GB4URy
         doxvbhJ554sfdIsDM+GAMS7SUgQo6MS04asbBo+2osSZBjcQosG4K7NeF6p8nU8FCf75
         DzPrbzI8Yc3EmgPBiKDaegs3+0yNoyN/sfYoRcKoNwFKkXMp3Yd4qT01nMzuQp502/4+
         c58F2Zp7ekuiJv2ZKmmRAwxP3gTpPeQjYp5Wdhp16PZUSAN6mNYJDvRTsw3dA5pB7Wsw
         K5vlFp16kZFuK5mzwM/TGZZqsNNvNMrl4hHhETpNSFG1KtDR4tufCfS/mLhsOHy7SEAd
         1gMg==
X-Gm-Message-State: AFuF++lgtodoUsmVv8XvjF3ucVRfHR/RxVKvMEIjdcnvM+nhKGNoTV3H
	OPa4FyKDkTZWUxV5q6TY5yUzoQQ/YuBWoS4HbFTQOo/8ltxY2y9p8wVpsWU0Zi+gfkw7kRgNRmh
	M96vXYi69H67s8zaXuQ8rac4hvknMvos=
X-Gm-Gg: AYBFou3PBwf0N+SoR9GFNSQj+s3KoBm21zuXDYOWbdWAIIymB8Tp7BCGsGSRK1McuBK
	lScADxiqdUUUs38VC6LvG7MhwyQplf0u2JctgFRprSaSM1EXPLT6npxIYv0dBL4nrLLzDvPlmeI
	bUMX/5TQjRJK13AaHPVULBkSDi0MmE2RBWeu+Q9ev5TULR6WjcHXlDV5f87FKI1hDORXR62/Hy1
	l4DYrLH74Qo/jzktLBsdX8NV9KPcgx5fXLakhuuP91i5xveoL4jUwKbqnHcLubcHHJrdKRcV6/U
	OUxLsoIlYJs3n9hVQP6PfPDYEMmzYMVTtnWKizykeSkOwK2kkclkvfE=
X-Received: by 2002:a05:6808:c2ac:b0:4b9:e65b:8c2c with SMTP id
 5614622812f47-4ca4c285f7amr4114624b6e.26.1789576724904; Wed, 16 Sep 2026
 09:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916160821.3157543-1-memxor@gmail.com> <20260916160821.3157543-3-memxor@gmail.com>
In-Reply-To: <20260916160821.3157543-3-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 16 Sep 2026 09:38:33 -0700
X-Gm-Features: AcwNN1Vm-fwD_68MYnPv6JpbRwPOufLZRq8rnNDxOuCJnRF0mxBi1vuDE5WTm5k
Message-ID: <CAMB2axOE3uhK=_bfkGr3QT76AiJzLaupnSk47M_BHB=mAqxWGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Fix generic __uninit kfunc output buffers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 prev_slot,
>                           struct bpf_call_arg_meta *meta,
>                           int insn_idx)
> @@ -9176,15 +9187,21 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
>                 enum bpf_access_type access_type;
>                 bool known_memory;
>
> +               if (meta->btf && (arg_type & MEM_UNINIT)) {
> +                       if (meta->arg_raw_mem.regno) {
> +                               verbose(env, "multiple __uninit buffers are not supported\n");
> +                               return -EINVAL;
> +                       }
> +                       meta->arg_raw_mem.regno = slot + 1;
> +               }
> +

Lets resue helper proto validation for arg_raw_mem,
check_raw_mode_ok(). For kfunc, the validation should happen after we
finish generating the proto, i.e., at the end of
gen_kfunc_arg_proto(). There is already one example:
check_arg_prog_aux().

>                 /* The access to this pointer is only checked when we hit the
>                  * next is_mem_size argument below.
>                  */
>                 if (!(arg_type & MEM_FIXED_SIZE))
>                         break;
