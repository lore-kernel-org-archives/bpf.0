Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A761127B77
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420364; cv=none; b=itzvkryUw2EeiQDas0X4QWw3h1UlJ0ZW8KwDD9K/WDvcK/8xJHRwUapvyNvZPp5ydayKayhOfN+Al2Jzy7bv1slN/FvBhCUOj2R+pI1DkJMxmfG+cwRv83XI7UV+Sk9Q8ngHPPtBfhaJZGDzDowXDxwDq2fWUQApHgNFxbL+aaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420364; c=relaxed/simple;
	bh=BuOccfsZ0R6CXydB0y+8RYwFEIuNrgRhCAaNqONrHn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRVnmLdTUp2pb0e+EbaHlfu2mDo28WKX6bbFEQ/hQLLG7FfAnNJaL29xBpkYgwg2ZDrw+R1o/xp8gKSRdaC5D+VDEGVbg1saI976vgTLuflvdQ5bbb6OTESc03eGN2L0DJoM+e3XlGR0xI2VVvABacn6bEwSgxu0MLxBFULmVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSWOUOr8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSWOUOr8"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33eee0258abso2255801f8f.3
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711420361; x=1712025161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfcNvHFHdMV7S4kDFcWHuq/ne5Rx5q6Jbyv3KaQmnMY=;
        b=WSWOUOr8kZkgf0PwO7gz8hzJy3hot27lmP4c+cEQl14j4r9H4sa0wOJWJ23xToBDiM
         PffbY4awHh54cn8Tgklccbhj4gvW/r5NLOnHUM6Xk2yVOwK0ZPmx/lwEdowcyeZJkHi5
         mDsQo3LPFcNlTyw31PBtAlEtEtUdUGEDPy5W8A44f/E9gffLXB3o6XTETM6JeKbI5Ic/
         VbgGhokvEcMQL8YxFeqDktbc26+8gSfZDhfvKogkfzr8Ak2zz3vWACPRLMfWP/WQI2qZ
         gJ7b4mgGSaoCyShfxOFd+QuVT3KRGztfCrMl0UNcPSUrZriPN3FHqEtbbfycnzrk1PN0
         rzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711420361; x=1712025161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfcNvHFHdMV7S4kDFcWHuq/ne5Rx5q6Jbyv3KaQmnMY=;
        b=Socw3LD+wpq0wAGnywykOuk0cQVXJ0pWibehSsOzsXJPffjxjso+rVeGxF9OEOh/Tr
         Kdp74Yc0DpHbkKEjHTGJd2uPsY1BNL4br1CCxOuGOi+tJwQvC03iEiOPpuI4wuYegdD1
         l1S34R4vPNMuScgtycELM6Qe47iu4LVHfJXtoa95Zl3EwjnL0MsTGQHMKHmt/gY3jc2F
         gSmKuPlvuYsGzWBCT8odnyqSixE9zONG6+SJUiAui+U0/E+UU/Nruyhawg9zUJXzoC2/
         VUYFko12Iee83IWBJUVITbWOWhGYMCd05Fr6EmsXvED56OKtBy9EKCf063CUDG/YTaL0
         4pQw==
X-Forwarded-Encrypted: i=1; AJvYcCX0j63GyS22D9xmcmgAbgHTR7D5bRtdJSLUiZEnf4RlU0A/otH/EBPxu3uKbwsEduZoUfV99yVQm42qr76LtbY03EZN
X-Gm-Message-State: AOJu0YyVpYO2wNot5IBj0SD4U+OP6RhY0jcG++cNIb2s+LK0njcre9F1
	hLqyfDpy9JHwvuWtuw5J0e+46oUPqXCeAacolY8MuS/CPShCRl2sAHpwGFeGsoSewr+EEXEXeDK
	RbzDdEl1CIv6e/QIAlwPh13zuTqE=
X-Google-Smtp-Source: AGHT+IHJHa2q/36YgfVz2Gj8HQ8/W/PsjwHOYqZCGJ2zfU5vC5z/pndzSlXJ5o3gc05RRYSh+uVczZk8rLdaijmwczQ=
X-Received: by 2002:a5d:64ab:0:b0:33d:a185:17ec with SMTP id
 m11-20020a5d64ab000000b0033da18517ecmr7813726wrp.4.1711420360662; Mon, 25 Mar
 2024 19:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000041.2919948-1-andrii@kernel.org> <20240322000041.2919948-6-andrii@kernel.org>
 <CAADnVQ+SWwJMtdXj1s1RtzXJfjXU4Y41eNg+xzFXe2-DNUR8Ag@mail.gmail.com>
 <CAEf4BzbNRhjALGK7LpHmHsnSHEfmrzserOy07RDyP3aSbF5HcQ@mail.gmail.com> <CAEf4Bzbu_4OZwgXREAbxY4fjwG2zFhox8nXpRgd_p6aUENCufg@mail.gmail.com>
In-Reply-To: <CAEf4Bzbu_4OZwgXREAbxY4fjwG2zFhox8nXpRgd_p6aUENCufg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Mar 2024 19:32:29 -0700
Message-ID: <CAADnVQKRW7mMFfRTG17RyNk_te=bcBKAaXaTLgoaGOTjNndkEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: add bpf_test_tp() kfunc triggering tp
 and allowing error injection
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:43=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> So I currently have these changes. I moved tp into bpf_test_run.h

...

> +__bpf_kfunc int bpf_modify_return_test_tp(int nonce)
> +{
> +       trace_bpf_trigger_tp(nonce);
> +
> +       return nonce;
> +}

Looks good to me.
