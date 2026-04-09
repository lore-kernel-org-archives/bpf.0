Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE4364E9E
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701298; cv=pass; b=bJtezvYGdWJK0oYQ+qNOdY7Sp2QnUI+5N7z8bJfGVR2jtrGRk14xL90HRJmLJwRqhoelVHWxn9gy0hr3PQRPFUpdiIWj7nNJiZ7tNdMnqUkck3K+8yp9AG8k94ann+RiALrWaNVsvwqOk+dTSBw2JV/99u386xd9l6fnvdFngFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701298; c=relaxed/simple;
	bh=beL9NqS5Q6p/GRMlCv5HKOQu/6sGbyOzNgAKzyBuSYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LL5Kfm0nxcr4z/3tiXtEb7md1MAUbX8OohuR284RxzSi7NYEQAtVB/9f6Z0dfVEjFzzDV1svurFf22PG6EptP0DvIOc/WlDdENxoBjK6Qts/dSbPuTbR34jbDUSbXMaffxgD7I1DFbghLEK2VIhz1TaZl4tE01h9N+9NWeevpi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVt3tVYj; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVt3tVYj"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf5d14d6eso189800f8f.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 19:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775701295; cv=none;
        d=google.com; s=arc-20240605;
        b=INbu+KfGrNF0s43okiIqNU0DiAPM+2swY8tx/KfoiP89+cEWm+e3M8NnjDGUOiSofX
         uuR6oY3KaFs4SS/k9GGay/GyjPJOnxTx33r/W61SzHmqio8oGpaGeBl+R0OyffHWQTQY
         PTD+KRnbM0Lhs+vTDCdtB2XUBZDLGguynK8XH6j1dT56xOQ2TIA0Y8fUSBqX4L0zp5L1
         YhIrgfPmS+3JpHfja6KM1GpGh1GgFMRlD2jAz6ZIs9Vha3p15KIOJhJiHjssPq+wiRmr
         C0Jab6aGnxJQQQbmxZk2Tab5bNLELfXXqtYuDpNaMqx+EcKBT/wQKekDK5xk+g3plYtj
         CRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l6JJiyFjJbnOGZ8rZXZJp5A2imKxEasjra2KlZFCRuY=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=hK/yYp0PbKDVXU06v+mKG6Y5OygVnBBAGSDDybsgQ10HDeXBS69hnQVDsEUY/5dLUe
         qwfnIIQxdr1amUP3KehKakRgpwYr1DwjpEOshm9mPQH0PQXzY2/Ehhm7glUWCS6Pk+1f
         cQT0SxWyu3bfGJzdzhcnjUhTz32TCjeGQs05x8NXQB2LRJqF06EuJw725TpoLGuHBMqC
         dF8JuERLLz/FfP0cXgfgrWuWbveqOeKQliufMWstM3n+CIRyxw5sElh0DzXYrKtrUKrj
         X7pCykp7rdPShnx2R5Z017MAgJ+sT7FhE/WaIPfcwoIJiRVH0yj80JcBz7QjJBVUMRvS
         gPPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775701295; x=1776306095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6JJiyFjJbnOGZ8rZXZJp5A2imKxEasjra2KlZFCRuY=;
        b=IVt3tVYjPXasalzs4UR1TG5OnQiDpkiOuPfr/CJgN5xbxmF5HcsxKIAXnqShXmnR5J
         Q5N3VqQrMFhfah4vJJKlaXMxshxE1VQYg463mUyr/ZBX2GXuAGix+Q7luKYILzXfa8n5
         f6xZTs4AAtzK0v1cSy4MhEYJye12aLJtJtZhxX8OfBlDhy874Nap2lcGKkvxhTX3E/qG
         T2JkU2x6C93kyzQUobxywKu7UMWQksCH1pnW7N04CrprmuIx/7bgjOi8Bqapi5ejFAL4
         40u9ow8pZqLBgoWgNuuTYwTYMP2LZopVOTU3xts8WoTb9LUkL0Csw+7/ZL6O1cm3MfKc
         gqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775701295; x=1776306095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6JJiyFjJbnOGZ8rZXZJp5A2imKxEasjra2KlZFCRuY=;
        b=nSyoiaYLw/RAuIF7OYU4IxGajVfXsQb4rRA7BZdWO84wAFr/kTH8C3TC00YK9FM1Be
         ZHf4G9uXG0LRY9whxr1jcDTR047UAnPh5dsxX+33eiRn7UYlDtLDSEi77zf4NZJNbqnN
         7+8PylXut6opQog/m0LXcSNcRYpZD4/dCUKgi11AYAjWLeXzVoWqlF/8RSym0qz1vHnf
         qwRkRL2/hqqmEWciGKvfFfzqGFlJmC4C55YiV9jvlryz7/KOlmReQKSKxF/xK/4TgipC
         ex9gcFBOyVLNzkD2QBl4VzqZOV5nsvCuSzYqXwU2OGCUnV+0kt2IZUFa7hyEumsSwP0b
         fN/Q==
X-Gm-Message-State: AOJu0YwhjbdSFoxBblrcw0/ug4uwLFeCXeV74jBu8ZG6SKGmwNlFg54N
	pvNIYzLpMGaGUZLtE3LALP4EXqiEVsECtCFHaI/J8hrRQL+IkFeB7CBtxa5efHExCZBEHbheSsC
	MIjKRBcsPgFaIC8I32l18LzONZGpS7E8=
X-Gm-Gg: AeBDieuT1HHL5OPs5tpz/N9Cm4FtzISeMxNExXwEEh4hrzg+YV9MLbmY9W69CrOT12X
	WJQp+b/CQfIY4oPaolgkLppQl+00z6giBqRJeQ5aZbcUROY9OOjPYlFx/sEcTnnZ9ogXNut5rlw
	Yjgs4cSy2jfndhSkCv9tMgFvnVhfGEhePwHExEhWxrd/w1lBxBu8im16kJEGF6MWlhmr88W8O+P
	GEjB81QcVWwfYTq//gwYbjt3MpLCG+tkRWUobZdIn6xpVUKUrHjrFv8m4yxuQ5/5ZKX2nAsg3xh
	RU8L20JAOrCC9DjzvW33mnoNt2C45XpxZGNk4tBTHrD0bbbgx76ggY6QDx/0eRZD0x+Fg4KQaui
	1uL6pJvLbyw1Vu2pmhtZqTv0ikw==
X-Received: by 2002:adf:fd89:0:b0:43d:30ea:bade with SMTP id
 ffacd0b85a97d-43d30eabb1cmr20326493f8f.3.1775701295384; Wed, 08 Apr 2026
 19:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-6-emil@etsalapatis.com>
 <CAADnVQLCyP+NzO9-332JO+dBe=EDEOr+ax+-ZrvAqJ9yTNYyEA@mail.gmail.com> <DHO6YBPIPV5A.ZIBDPIXBG1NT@etsalapatis.com>
In-Reply-To: <DHO6YBPIPV5A.ZIBDPIXBG1NT@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Apr 2026 19:21:22 -0700
X-Gm-Features: AQROBzAXvQX3dSz53Bn-25C-DPij6gqYwmyaUHTg_1nvXGdP45SQ43jLVwuLCCQ
Message-ID: <CAADnVQL6fQWdMibEfKk8DJ9cD=oSsUNKbpHJ_MFjx+VTYSSAAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/9] selftests/bpf: Add basic libarena scaffolding
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 5:18=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> >> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.h
> >> @@ -0,0 +1,12 @@
> >> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> >> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> >> +#pragma once
> >> +
> >> +#define ALLOC_SELFTEST(func, ...)              \
> >> +       do {                            \
> >> +               int ret =3D func(__VA_ARGS__);    \
> >> +               if (ret) {              \
> >> +                       arena_stderr("SELFTEST %s FAIL: %d", #func, re=
t);       \
> >> +                       return ret;     \
> >> +               }                       \
> >> +       } while (0)
> >
> > I'm not excited about yet another special macro that hides control flow=
.
> > Pls stick to ASSERT*() family.
>
> Reusing test_progs.h would require us to other include the header in
> libarena or complicate exporting it. Since as it is right now it's not
> immediately exportable, I can everything to ASSERT and we can either
> factor them out of test_progs.h later if necessary.

I think testing of libarena doesn't need to be standalone.
For testing it can include test_progs.h and everything else as-is
assuming their exact location and relationship between dirs.
But libarena itself, its main core code with allocator, spinlock
needs to be designed with automatic sync to github in mind.
Just like the source of truth for libbpf is in the kernel tree,
but it's released and used from github.
So libarena will be tested routinely by bpf CI,
then synced to github and submodule-d into scx and other projects.
