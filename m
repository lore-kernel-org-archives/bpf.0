Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2132363C41
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775197029; cv=pass; b=L8gNpkB0oqNEMLhqjRVHBJT26R5OvLsEVBhhJSyRvF9aZqSbQppmb2Khy7bY9dgBsPr9OU0JwdTLusgBRy7mFLWPc0YwndaXVigUCZZj3w0ko5F51ogTmvkBTsrBpzl5K2OgrG97SGgfn6hxT2QljXnmRodVjAZ2UH2WHY5/1kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775197029; c=relaxed/simple;
	bh=As7MT0MXw0ZOZK2UiXFz75ar5i5jDU2ADYSEygzj7Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNQ+ZXWcTV5FrYKGmi+2wjgeD5mwXzHAFk7089ldMVJFrXXciG8agv8RQkB6Ir64O8PsjfDNVArE+rL8jaN/EPh9QT9t4dy4W53TkbC1KBANP1toFgHuuzwAb7zsFcYL39sKf66vIi/xuKHLfpqb13wrdwjY7yhgogK1nzq6W5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK5iK2fS; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK5iK2fS"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7982c3b7da9so14873057b3.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 23:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775197016; cv=none;
        d=google.com; s=arc-20240605;
        b=OzChnWrW5IMlKdfSqB42xcSxS4z9wApfL1qw1xdu6Oe/zE5unoVqKefQh/xwKDp3wq
         RCltHJjjqJ7PNR5XYZz3r10qlP1zyVNTcIkZSRmRQS6JtixRzKU6NunRYUR2sNYa6vkd
         7ShJbr7VXmG/p4IQqp65RTF1wxt0Lk59zm6wIXXaNJhmzWfF7RWO8Wuy9eScq8nlx56A
         IZmBw/fWJllnhWN8COkMz8hWU/GoxRV7zUc88YrQZwLt8jtpY7dKnTdUrZ9ZAbOmqLZc
         ELVbU3vVEW7VrZDyV8n6+YDFZEi2efM+GDm1LlhSK04kyHhZ4vaNfgjaI/xtDEpTwitt
         CQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=As7MT0MXw0ZOZK2UiXFz75ar5i5jDU2ADYSEygzj7Js=;
        fh=OTURxmxghqmJjGMVYmb2sOVW9EunI56TAvfXu6vR49Y=;
        b=XKiji0Ztko/7FzhITgDimaV4OFCIsod4g21DmT02YW02EKxhO98gKJebVkddYE4R2/
         Yd+AWz7s3sQRpYTrmDL207tT+CjzjPjRV/AojLHJfI1EHDPsQKNLngy2f/g0Gg/Lvr0Z
         NDQluD+CHG5o9RLb1r/errVAXeBahgNRKuhcj5ZARf617MV5KboYMWz0C8B5Ybsw2Ye8
         LzFiZkEYlNhhoF76VgTkGZL3cA+BzSejbOQ/Nk9d58niqscYtLdr1troN3DDAnjOTcWR
         7THfO5xtIs/XhJ40SQgd8h8hDJ6Ey+1mBlq2X9e+Z4OD07cx18gfskataOzT1iV/MXm9
         3Zpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775197016; x=1775801816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As7MT0MXw0ZOZK2UiXFz75ar5i5jDU2ADYSEygzj7Js=;
        b=DK5iK2fSV4RykmcRcQv2Pf4mlbw7GyVxAOUr/jJaf1ccRa8pDSsuGD2vCNCZdDtjAW
         2EPNCHyd+FeDn7M1XGcHPbJqg91edgb0MZTkJpS440aL37pOYD6x2hOWGxrZFCnUndKi
         mpulxnah4BZVwQm6Jwj2753NfvG5L05FgNbtCfV3xSn2xpsV2aDbJ1aAfukAndGmTMW5
         1BHq7l0vAIGb1FEy5EqgO4L4HhNniUN0LgloTErC6ZPFOlV3JK7oF5g5hysO2gTD/QXn
         UnL3+LDdB0VQIJI6CAslnENVX2g7c/+rbt/TwqP7t3+PMcwO1w4aj2LxdulNnR1kolT/
         LnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775197016; x=1775801816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=As7MT0MXw0ZOZK2UiXFz75ar5i5jDU2ADYSEygzj7Js=;
        b=d08i1ogaJHLDpHG8uZ7bNyiix0LnseFNOK+YQ71ZhrGrfen1t2T2VEJ2lnebrBI5/6
         UeZTpLSqQ2/PTW2u1O7qiFta3DUi44IRvl79RKSyB25U94Nc00AvM6rUP7jJDgmyD5XE
         4HI4og8s3M4L8JhnDzp31wpCCyF9PexCR5Ggd/sSnWAMyMl9GgbYzUmfNRzRw0G90anc
         W7dZbzdvUDzjA8tsvduAYyJQx73QQsAUZYqslZBhvmU0zNfkSyuW/H2kIKYLoftS5MQF
         6i4NL1L34Z/vwJTyksbezREFbvK9Yno056EWf05XQXHDwhLR5djPUtyrmsdOR9ioqSlM
         LZIg==
X-Forwarded-Encrypted: i=1; AJvYcCX46xoj4yR5PGSoQF2OtA6XJd4klSkzNl7z/KXtxdzJjlBgXfQLYQEwFXEyowYYEgrnD6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/JQvcWm7pCU4OcXfV1K12IGatxi+th+lVQ3yg02IAIE0WOkF
	DWyQDgXTkMGNtOl74dbgJE6qp2/sunSYTWReEW6Q5XUSaJ7IH6XH2hhVGI0LdpBDKlL8e+wqxHk
	hu2u93cAt7hJOZwautEEk7hiL/pnfigI=
X-Gm-Gg: AeBDietkPTGeGdUfgRLivMnKkUWKOLsiAZQcFoCUanc1N5QDCoF/GUhwv10+u6evF0E
	zUFi58ehV3sqIR6DLHRW42XCGLaOOWEeFpcxm1lj6jwzDSToUWcOQtyACxAOCYnFRfKjH5/ZpqT
	NTHkm10p7LHHccFD8o+BcLjL8SjWYDcJo1hWYh6Ct1vL5Pf7FQ6PvhHhbbYdfwF2C1UMCV0pm3y
	zAJU1cygYOYQvU0G/SCt5iDLv0W1u5lm3CGKYo98id7QIwn4yLFxjgCI+Sj53KTqU5Qw6TAzTDn
	VIm2vJc=
X-Received: by 2002:a05:690c:c0d6:b0:79a:c98d:2ba7 with SMTP id
 00721157ae682-7a4d68302c8mr17001167b3.58.1775197016426; Thu, 02 Apr 2026
 23:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403033828.18529-1-tpluszz77@gmail.com> <20260403033828.18529-2-tpluszz77@gmail.com>
In-Reply-To: <20260403033828.18529-2-tpluszz77@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 2 Apr 2026 23:16:44 -0700
X-Gm-Features: AQROBzCTrmptyfsV_v3ikBXRdVjkaCBoKlwVMmC8toHkx7GK_P0VsdwCkPPJnns
Message-ID: <CAMB2axMan4JTB8jqor6JsHOHmb1tsNnBRe9ZFbw43bdvSVkU5g@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: reject direct access to nullable
 PTR_TO_BUF pointers
To: Qi Tang <tpluszz77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 8:38=E2=80=AFPM Qi Tang <tpluszz77@gmail.com> wrote:
>
> check_mem_access() matches PTR_TO_BUF via base_type() which strips
> PTR_MAYBE_NULL, allowing direct dereference without a null check.
>
> Map iterator ctx->key and ctx->value are PTR_TO_BUF | PTR_MAYBE_NULL.
> On stop callbacks these are NULL, causing a kernel NULL dereference.
>
> Add a type_may_be_null() guard to the PTR_TO_BUF branch, matching the
> existing PTR_TO_BTF_ID pattern.
>
> Fixes: 20b2aff4bc15 ("bpf: Introduce MEM_RDONLY flag")
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
