Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78651309070
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711328887; cv=none; b=EuZ/nimvJBFkCq5ljCqhP1E8nn4ql68IfIc7jqsmuWbH3qoAkyAz7qGZw8TsziaUu284AY4Xkp/H41AgO00MxCc5ZssrqITeUrIvFV3yxBuGIzuMBbRTR9cWBf0IFk5FwJyMyU/Ac1+wMG7oAHo7Hwm6emcz1Mk7Fo3F7sQPDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711328887; c=relaxed/simple;
	bh=GCXTh24A7mofjoJ4pd1AesdPVvS2J6v2XCBbPRVAI5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvqe3OkvWiXC2ybdPbcI3LS28mDkUAKkPyDhxLrHjLhSj0Yw4EEZpwiJ7K185B54cjzgyPmQ/gngZ4n0oBPXG9cElQA53dnrmhycNXSRD5I/6dS1A8+WW2oROJxlf8NQMPT3TZhgu6RcOgtz9taCtFK1VJXOUOcg/nJhTX5dKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD/sW5g/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD/sW5g/"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ed7ef0ae8so2715957f8f.0
        for <bpf@vger.kernel.org>; Sun, 24 Mar 2024 18:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711328884; x=1711933684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/0yxVXT6MWMay5c7aPc/hZ2Mpz8OuhYhzUDk2xetZs=;
        b=JD/sW5g/TR7gL1Q1K9+yaF8sE+L19BTmbZMf+ZbUCvZB2iHiGlQjkoH/4oguXpLYQ9
         Pgtkp76j1cT5CMgD+24KTD1/uvl4ay6d62Be+GfZiXg2dkzLgBoqMdDHRcEF5JhHhbIX
         0MTzSqJ7BINiGq5PHrO7Pe2ss4Dgoy+cvIGrARVt9JQtjv6EE6uoJiNfu6aAN0YTSgCn
         FA1GYGo1g3lUilohEupfT/kP+yCBX90G1uEPrOuyOjmzNt3sBHhytj8iN0+4ncL9fs7p
         LHo3RwqJOzSazQIfdZYiN2S+/xWiof75n+DK3Dd6/ojtNQbScNc5sbGHZqQsqJOI2f4O
         7OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711328884; x=1711933684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/0yxVXT6MWMay5c7aPc/hZ2Mpz8OuhYhzUDk2xetZs=;
        b=oXhBcjgbJRbeyewEW83T61pE7jLA0j4PFBgC5WAj8RZN5FR1HqgGujiBcTaPiElL+0
         wsuC3iqP9uP2W0TGUitb9nSMh/m+burMzRr194sf0q4b8c35q+CbSr0sxpADWMC2FeZh
         Jm0tesu0e9WJS+GN7CR6qCy6/31NQ6TceGcyp2ayMykXcQy07bx6mf1gvNPO0Bc1cmfT
         K0uE0PE0vh243xqkXlowNrHwqtlTR+fRTyoajskfgJ+y5iMt6r4zVwkfrm8uLiMYp/eh
         lTQv1XQYMCYEj1G6bZSq7N0Yv5i2gYx8CKAqro94z0nraaPNMMe15boq2poHClSg3uQB
         0R+A==
X-Gm-Message-State: AOJu0YxdcVbTlyt/y1Lxlk+59wENPtA3XbeAEV1Uf43RbncyI0DJyqhv
	pgU2avxx6SeIq8A7SPnrPehUcfgiHX9xXxMJyAjOua5l5QJzrIhw8CBpHZBVP69k0jk4v2TaIqb
	mdzyLlRAbfXvJJPS8NkbjVfn5SmE=
X-Google-Smtp-Source: AGHT+IEliY8HobaK74GtuJev3L3Ndpt6YcyQyuLglrvBXjhHdgR9CMxRlfEWwEtd3qFI5WkTiWAbmvwwdts61GHiMSI=
X-Received: by 2002:adf:e052:0:b0:33d:6c9f:39d6 with SMTP id
 w18-20020adfe052000000b0033d6c9f39d6mr4134584wrh.40.1711328883566; Sun, 24
 Mar 2024 18:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324230323.1097685-1-andreimatei1@gmail.com>
In-Reply-To: <20240324230323.1097685-1-andreimatei1@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 18:07:52 -0700
Message-ID: <CAADnVQLouo7SwAsgbA_ELaZ_qsdD3RzhFvLH5xwifBFNyotURg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Protect against int overflow for stack access size
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
	syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 4:04=E2=80=AFPM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> This patch re-introduces protection against the size of access to stack
> memory being negative; the access size can appear negative as a result
> of overflowing its signed int representation (the respective function
> arguments is sometimes converted from a u32 and u64 without any overflow
> checking), and causes out-of-bounds array accesses in
> check_stack_range_initialized(). This patch causes the verification of a
> program with such a non-sensical access size to fail.
>
> This check used to exist in a more indirect way, but was inadvertendly
> removed in a833a17a.
>
> This omission was found by syzkaller. I have failed to actually create a
> program that triggers the issue (different other protections kick in for
> different code paths). The syzkaller program is opaque and I failed to
> fully decipher it; from what I gather, it declares a map with a huge
> value type (0x80000001 bytes, which is INT_MAX + 2),

Is that a bloomfilter map?
Looks like it doesn't have a check for max value_size.
Pls send a patch to limit it to KMALLOC_MAX_SIZE like
we do for other maps.
Hashing over bigger values are pretty hard to do from the bpf side.

> and somehow calls a
> helper (bpf_map_peek_elem), and manages to pass to it a pointer to the
> stack while, at the same time, the size of values in this map is being
> used as the "access size".
>
> Fixes: a833a17a ("bpf: Fix verification of indirect var-off stack access"=
)

The sha is too short. Pls use 12 chars.
See Documentation/process/submitting-patches.rst.

> Reported-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyv=
BSgjN1T31K+gOw@mail.gmail.com/
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0bfc0050db28..2019d6177969 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6701,6 +6701,8 @@ static int check_stack_access_within_bounds(
>         err =3D check_stack_slot_within_bounds(env, min_off, state, type)=
;
>         if (!err && max_off > 0)
>                 err =3D -EINVAL; /* out of stack access into non-negative=
 offsets */
> +       if (!err && access_size < 0)
> +               err =3D -EINVAL; /* invalid negative access size; integer=
 overflow? */

This feels like a good place for such a check.
But it's not an overflow.
In few other places we have the check against
#define BPF_MAX_VAR_OFF (1 << 29)
but this path into check_stack_access_within_bounds()
didn't hit it.

Since map value_size is negative it is causing all sorts of issues
and probably not only here.
Once bloomfilter is fixed this check will not be hit anytime soon,
but let's add it anyway.
I would return -EFAULT here and add a comment that this is a bug.
No need for WARN though.

pw-bot: cr
