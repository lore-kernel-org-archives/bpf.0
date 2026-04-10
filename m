Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CE3A63EF
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860398; cv=pass; b=cwM4qxsRinYauVUHSpgQykdPzBDiIQg6iu4LfKRO+IjcUzdfn12+JP8/AZvw0DJjvXslqphLTGYuBN4DWAhwddySIZLIEWtuAnbz4EqZqA1/p4h8KnlkQmeZZP6ZNFmWbIzzTBqRgqk4EmwWazvVAIbLnxJBC27eZzWsQ5UiGPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860398; c=relaxed/simple;
	bh=Zx8PPkDLH8U3YxXD/P2FRMAcS9pqWIfGXURE8vjzEFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYKqjugnsRE3S6p1UpBaFFRPlYl09m9uaD5SEj2BKlMLcss4UdAPV16YNJW5aJi7F7Ec7wah/H7p3+e29kNI8pYsrIRRK+N0OtCV8zGTRZLjcIcfAcHbzzQIlBWzBUOrTz7tkYB/ny//2Y35fYFYCsdUmGC0iz7UgfCYl/eUYk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUWQgO6X; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUWQgO6X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so33225125e9.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 15:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775860395; cv=none;
        d=google.com; s=arc-20240605;
        b=BEl5QRbIotWe5jetjveUMcw3X+XrLMcesTuXJdDQmGKVEQNpQV9Fy1fw2hFNtvtNhQ
         8Ea7jqSE9X3trHAHPN8C0j1/rAljenc5GfE4zjgNJIdbHeqwAcRP0XDZ+awkkAMQvOgy
         Wv+K6kOT1OnVMw/UIJsf1MQo1ADoNgFqoX3Qj3i7VhayOsrflPWJM9kOzi2c9yJsmsYJ
         SdYAxACT8mhD/UzZ2qMUMoy2S06zgbzqB05elCwivgVJH0HJvemW508GuATb0dn9m3Jh
         ffZT1tIOqNVnDgUm7+aF8U9Bm4AQx5ERjSViXXnKZiJhyrbvSbHCO2LjBAQA+Na883RF
         8hdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BwH6AJ9IX/rgIdfr/0Xd6aIovbq7862fNYjp4kub+M4=;
        fh=R1mfRt3D4xL92+9aezeeW9Ut19CAw8L1igJW0qgKkms=;
        b=T5kND46SecCMe57oQbK/li5SdTDtbB/wiW1HczNjvLmHuveqiDFKs2giTz9fBoCyR8
         dly0EBvByztn+u7WHjTbQiL6CmTp2DJbvYdoTkdvyuOnENxf+og40YNUmKGkA2KOIrie
         vqewQ5iArotBV83z/uMZ+UB9+xAL9YYRlz+vguj1ZM1NbmSHZRotSwS1DrdyfhaD19JL
         MOsaAN6M8tlORhimyYRdg3a8oeptyJHNssNFweWR8RoDf/svFkq8xut5txBHBHcXssCl
         865R/klHUkxF4JgiHl4ET02Z8WPqFjgRLMbvdah5QviUQ0ktXUo0VzD8qw0DxxE/J3vu
         +BKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775860395; x=1776465195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwH6AJ9IX/rgIdfr/0Xd6aIovbq7862fNYjp4kub+M4=;
        b=LUWQgO6XE/qQS2XAlf7YCsdjtIm8s0SO2zxEXMbqxSX6zgjPzm4upcv3Nr/z9woEoT
         Tir1nD3GLVZQ3bBsOdMYYT8+fOsQnSiSAeTeE/o0eCfwSBe+bZWewWOEAq5buErLlD2S
         6c38/qzp+QRk2AtGa0B2NUKxQCNwXyALpdXJmjMsUUve9tOZg/Cq5U7al0t718sA8QHn
         W9M0Kiv7iQ6D/p15Ho4idh4K5UNliO7FMYru3Bmve5vRPd/gWPwCBq4xhei7hfiUuzSG
         lm7ZZjUvnhMnmGQhxXsBsW+xybdSsIma27JVkHSoYpsN5ooWO0dRcSTuqjPGxhKcuGJf
         SDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860395; x=1776465195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BwH6AJ9IX/rgIdfr/0Xd6aIovbq7862fNYjp4kub+M4=;
        b=dM2Ymvl7Qxdav+2jekxkhXVWHtpoQMPMjveHH7AB6hYVgUJGKGO/isLG15Yx7W7c7Z
         s0vpOoEjNIh1qtBOCkaSpTRftJh3tehYGMDn7f6r0D7Y5ECSwyb1346saAnxhwneCFof
         7todmGgBoW1c/PYVDW5THDCukzGxrzqCoqKAQFBJxp/CbL0PbiAThwg8H6I5MXXdlee4
         zhcHi57SRvvgQpGPzq8ocO2EyPT079Y7ryTBFG9gKUJ7itDESkvQ2POaN9IMqgpfUgU5
         mztpM40/7/SHh54ghhgfgyaY6yrsefpdVIeq5XqCfQ3zkGK5ZNe8u881Dl/hWV9QZwOr
         fRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLPCUARb5cJ4wGrQ8Bpt8OxgspK36s/eRrHmmwYI602v8+wjhruEmrXWyDIiZdl/k17Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJeR8bVPAc6zx2bSPJ0jC+4VFuIcZFgtA63E8kBDurWY34pNQ0
	/yLQT5alt5FQeWAx/LhDROi3bbQRmfy3XN5E3CL+l214Ew+KYoEluR5dogV9lhnEfwpaPYAIq+f
	KYJIkl0td6QjkV7zm5YshS1OqMnVPAOY=
X-Gm-Gg: AeBDieuiXJoFKryzNXazBwSQWUm/qOITn+shx2aRG4Oz4VvKrKDc/4aA7aVNO2oD2RA
	yVKLGQwfZvN/K8NGQ2Dm9dV1/79/eAsLqvhiouVQHeHxmytdkXEwffuw56xB4sy2fqF2B9w4qqR
	IKOyi3TvOXDUYeFiqwei+YH4/jS19rWhaSOCO9WRneNl9hI0zsWfwNVcQhZ+7OOj3NIVtLns2WE
	+DMLgcAUVillU2SVXj7DP3lMKUOf6DP3kYaz5DuWFn+d6gOMchDcMSv7d7MOjoTW9p6XgUq8Zo9
	t99Xcfzd0WdjLG5autuO/qOMZhWWex5riX2rBykdUWGy2wN0h4wddtdm4qI32LE5U2RZm9/rGgn
	Spmu4fQLPqKMUb86IYtA/Lb0eZA==
X-Received: by 2002:a05:600c:5249:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-488d67fcf67mr56575995e9.12.1775860395057; Fri, 10 Apr 2026
 15:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-patch-set-v4-9-5d4eecb343db@gmail.com> <9421f5915a5ccbbc40eb6efe298476e5de06de5f86393b54c6ac769e34996366@mail.kernel.org>
In-Reply-To: <9421f5915a5ccbbc40eb6efe298476e5de06de5f86393b54c6ac769e34996366@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 15:33:03 -0700
X-Gm-Features: AQROBzDGYwFMEOprBJoS83A1raFelB-s1qV2b0wV1VFrd_JEl37kSKlrVY3jZCw
Message-ID: <CAADnVQJwuQAVTA4J-D0zn5znb8bV8ZCMQCky9=xzP7jk3g9Wzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 09/14] bpf: simplify liveness to use
 (callsite, depth) keyed func_instances
To: bot+bpf-ci@kernel.org
Cc: Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 2:44=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index 2729ed965f62..1c8477069a43 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
>
> [ ... ]
>
> > @@ -85,158 +71,111 @@
> >  * - A hash table mapping call chains to function instances.
> >  */
>
> The file header comment block still describes the old
> callchain-based architecture, but this commit removes
> struct callchain and replaces it with (callsite, depth) keying.

Not only that. Most of that comment is no longer valid.
It needs to be completely rewritten,
so I deleted the whole thing while applying.

tbh I wouldn't follow up with a doc just yet.
We might keep changing it.
