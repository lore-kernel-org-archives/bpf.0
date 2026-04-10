Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32936D4E1
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850291; cv=pass; b=BNSdIqicoUcOiloXSUilOgnFMQpt+V7VLYJgsvrLlbOSH9KUxrrDoQnXtBrPEcZe8JoD1p1wUchz6jB6dfeqqu3HpkaxFdUKwFaiJXD9VS5b5OSOpiGjoqvcFyGXv0ac0uN4VGz0jfbWvj/xmZ2JdHlVsMMRvWIJ2yExBYrre5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850291; c=relaxed/simple;
	bh=mCyaBgWImKig0ab+rw1eE4t1dfXRtKeHZudLfFs5/Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9YZrk7tT1vt1J+XwMRrfKa3F8axj1Q7vxcHOWeV7LdLZb961tEzBK7zAwKoRkH9yDh5jojZXG3KmyYeBAlKpG+Jwzc/ZI/GHQi5umH83bFIPmSGedpA/GGhzh425qxS+TkdG1kH6dEEnN3r84Hhvx/wHGY7FLHIocaUKDFfyRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOAaPT0m; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOAaPT0m"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43cfd832155so1551869f8f.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 12:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775850285; cv=none;
        d=google.com; s=arc-20240605;
        b=UPygFQLduAmhdlro6cC/DTrHEJh/7VN4oCM+pzDW7N0to9jEaYD2Wg0h3nUZUJNv0p
         rQtFogIpDgjS4lH91XO4sGP0E+o96kLxesldbNIYOgBNw5Z3XHeXugiRJyTJ0ApRPV0Z
         QU2kuMNwuNM2YLyH5ZtmhBjMVntnWVvJYz8saks3ydShi4rKwSX3Oo2NEzUEN6s0Eb1D
         fBQCUN6Ic9Xc5bifRhXwhl/mE4e5zQZJWPfi0JM0WiBmf9uTn+3bOrcB9+Vfzlnc7TGU
         6a4FQ/27BgFZnqR7NMFu7TLH+QXfp/HHZHIHF1LFeWoO+6D2F7zBtHEQINvFIueiSOJN
         dgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCyaBgWImKig0ab+rw1eE4t1dfXRtKeHZudLfFs5/Ek=;
        fh=nzXMEYubg0kgWmWL5MRdceJyTzv8idmjru2A2mWAHdQ=;
        b=DN46+x+c/SjVsRI7YOKn0XOtoBXDz0iuMSgwk3WSNRl2ebylULwrS7rzcCW4XD9Gz5
         SVgrs+he+69UMMac5ACqmPPerjIdZ0Gq5UsSEz7V/wcNq7jxBXOwcg9CnfSbBYrjjkjV
         hBES4aqx3thNmneMT1OhkHpsD+SB7pMoXknZ4JN6vAq2GtWARKafSZZhDXX20cF/8ixV
         0K1qsvTjhmmTy99oK/zYfbpE17jeDyQ5ofHcKDQoVymKFuKvmFwiiYu9gqO81SYOQaAp
         SgDnsqBlj1QXznkELVZoqHyywpnbHwHNxeGddcMQv0B8flHq7b53OHALRL5yl7/5YpkI
         hWYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775850285; x=1776455085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCyaBgWImKig0ab+rw1eE4t1dfXRtKeHZudLfFs5/Ek=;
        b=OOAaPT0mb++86GZ1YHt/4Iom53FMEYHEpMngleOFIc5HlUXmhZIy5lBOI9FJtny2ra
         iTmJkL2hqBnOMegliHBMSDlScf3l7/AYft9bubh9bFEgAzomkTxU8CAx8z39ULyqv7T1
         zW1vBJINKK7hPxK1PDYZ6dOgqpONOA8sLugbE+jYMxyAf/GrKNSkYuxdlmOYnhTbk+iK
         lDSDMfJg4iF0bIRYGC/DjTwRf7HI4yYjj1GQIlElToUg8WJeYlcb4bISqlJIL+aS+AOv
         87u2KVMDDnMT54JdQ63fTxDNp8KRdhn8ZGCTMWMBdunoyMRuPwvy3oFxV2qY1gcjs9pL
         S7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850285; x=1776455085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCyaBgWImKig0ab+rw1eE4t1dfXRtKeHZudLfFs5/Ek=;
        b=IQirNBabeWnr2o3nyC0oRn6db8PkdkQashtF2uLaYCCRiTAXJLucf7bEOQTY8L6WIA
         YGs6yTACXf3R0EanE5ppE0QTc69zPQqjRif+8cbJoNAJLCueJNNEjbMuUIVTO3BiNE/v
         bs0ErtilVlqlI598kqieA7MCI/4hpA+wNR/y0GfzZbfFMhAKPBMPo4aWO+Qr9tazUXGs
         1hgmrgVa6x4tKTI9zSxAqKZPTT8lrxm9cL2u+TkQBhegQYCdy3A6LZrJNL2mvyEv7Oye
         Qru1hgHIyAaQoov7k8ATA/48PSP/XzdRLP1k3xqkAetqNLiM5+ru867AgJT5QSBemAzp
         8O2g==
X-Forwarded-Encrypted: i=1; AJvYcCUsR4Noj+FnmaCinRxK6jAiH6fsIdGgQcLHvdXmIuSyuQwiWokdd689echMuntHgdExzDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSCCTmfll8q5qyV3GZEWZ1FkwtcqKUiGCcS/FBy2L+kG7084l
	0Q2ApgZ3/nVZBupcv+PS9QwCPCaKOiBezNr1j2FVwpi73iXVi4YWlrQiieON32RV3xjKNCJkurL
	pr3oLpZouB2Iga9whcMaU0KdiPRvhmvY=
X-Gm-Gg: AeBDieskEJ7+DtPdhkkUECSl6yDSAaNjjCbTPCOH+6sVHhDlO0OK8K38AfqTQ8jWCJJ
	KnO7qJTpW3dnBwQz+xfFh2L7E9Q8N/NVIbAaMz2c9txvA0HEMQ45mMB3wmk1gH+D9pVYhxdVOk+
	/D9WpWqbkyukyFuncYt5Brfkx3U0POs0hdaK8XSzzlpJEKiF0qPXOaTTex1WTV+lmFJd/4m7/D5
	a5epu+U4cP8+PosOKQqM7zPL8OD0Zm1ZZhVIaEQnQczipFS7Ikb2sWNPhwDdABS+NjUxywSXIdd
	8qgTw7TGWtA4Vuc17D32wvCKkcZrr9OuUuZHOnXuNAq4qsfbOyYq1fEuzolIRO2meOwX1K1j
X-Received: by 2002:a05:6000:40cb:b0:43d:1c39:593c with SMTP id
 ffacd0b85a97d-43d642b6a52mr6478524f8f.30.1775850285381; Fri, 10 Apr 2026
 12:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410163041.8063-1-emil@etsalapatis.com> <20260410163041.8063-6-emil@etsalapatis.com>
 <CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com>
In-Reply-To: <CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 10 Apr 2026 21:44:08 +0200
X-Gm-Features: AQROBzDrMiyGC9omvF2TmKcYuA_zxiK1tTLMLioivY5JeDCdQz13Y6heSuYo0Wc
Message-ID: <CAP01T76gQXua1e+-zQxHcO2W9XHVe23t+QCCT3bWR_UyRWL27Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/9] selftests/bpf: Add basic libarena scaffolding
To: Song Liu <song@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Apr 2026 at 20:39, Song Liu <song@kernel.org> wrote:
>
> On Fri, Apr 10, 2026 at 9:31=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
> [...]
> > diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/to=
ols/testing/selftests/bpf/libarena/include/common.h
> > new file mode 100644
> > index 000000000000..5acf9b994943
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/libarena/include/common.h
> > @@ -0,0 +1,67 @@
> > +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> > +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> > +#pragma once
> > +
> > +#ifdef __BPF__
> > +
> > +#include <vmlinux.h>
> > +
> > +#include "bpf_experimental.h"
>
> bpf_experimental.h is not needed here.
>
> > +#include "bpf_arena_common.h"
> > +#include "bpf_arena_spin_lock.h"
>
> These two headers are indeed needed. However, what's the plan
> with them? They are not part of libarena at the moment. How should
> we include them in the future?

I would propose making them part of libarena, and adding libarena's
header directory to -I for all progs in selftest to simplify
inclusion.

>
> Thanks,
> Song
>
> > +#include <asm-generic/errno.h>
> > +
> > +#ifndef __BPF_FEATURE_ADDR_SPACE_CAST
> > +#error "Arena allocators require bpf_addr_space_cast feature"
> > +#endif
> > +
> [...]
