Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB914C590
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558012; cv=none; b=jqEZGvNv6645vpiIeHtMuALgghU0ahNF2G0NXbkNQA3FxiQpqL+REdg9r4Whc++DSIcSpgRtZWdGzAuRpY4lSD6bm+BGEOkgvbNscjanCIRc/YrMM23jMgVJ6sF+4CWhkKGT24dCCsyTHfnPYx/peoxE09o35mdP7N+Xc7GQGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558012; c=relaxed/simple;
	bh=E+Eeob5bLyI8d0c+4vva+XeEpCjicsDVxMWC95+hWPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+LES4RBPzI7ygt/71/05/Fi/uB5GzA/eYbnfSo8//jg0Z58KDwWWWO26a48LwifdlkmCY/QXMu5xjjO2zJCHkyHeTuOO0VtndY0+SteUIVil4UgjwkScTOjWJzoqRzJJOzULsKIqan+z2KwIq/yAgah9f4MWP9ji0EJsEW1F5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhAX48P+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhAX48P+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29f9af2e0b7so52742a91.1
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711558010; x=1712162810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPt6/u4bCqQl19pXYG3cMYcercDFaeFZElKv43MsSlE=;
        b=RhAX48P+/AFXrjWU3ZLkmcjlsfCuFkSKWylO4rbh5SIRsrLm6XjFiLbVznNSdSsrrT
         pftsytGbhfkyf3lpYh9DrG+gvBFbHLetFf1uRdR6YyCgBWn+aaokxjhSTGq8jeXk49cZ
         rlM3D3Se7/EHT0CeQVo1HFFbDJ6qFUG1A8VZZOl2Q36deMvDL6CyqQWP0ngV3jydV+df
         7ppjOsWkcm9+OFSO4FcjgKxCS3aCZwK98A84whh1XMM+VSVwYVfMjROmwnLyXa0cpdjE
         NEw6WI0N/g4ZAyNOPUAoPWsQ2SaTElYWRTdzo9H58lqvUMg3EX8m2f2qLOqtr0L7lUul
         WK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558010; x=1712162810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPt6/u4bCqQl19pXYG3cMYcercDFaeFZElKv43MsSlE=;
        b=wil5crSQSAzQ3CiE9DWb1o0HZPduMhwk1DVRTHyKfifxDzxr+9bqiQ9rMOgRXQsYKT
         BCG9TZhLa2/ajRy1ayK8mVvnXzRWQfWU9n407OigiGJijuQ4Gk/hbSvmAOLtJwTIT617
         RKRoLfmkrW3O602XR2Sp3y0kDzB2KUZQ8jBJ//ttjh+yMgCofbH/9w/sWzNbkmLxXiIr
         qoc5m59vH3rAjd3W+imX6PrwIg4hp5W4asaZTTN2IQlVSXJCNQ7aijqb+1sLvyWtzqlu
         9dgmperdKtajG6y+NtNzlgBR+GTSNtRbuu2uP7kiH6V1QCzSJ1OL0PuqgQmb96DJITzy
         Xe7g==
X-Gm-Message-State: AOJu0Yxgffw+i+T1wD1t9Bbhs4bXQWqrCad2Oe6T4sWnwWav80m02jZJ
	OrIgGDKF91ol79tGBudBnJ6fniim1+dWJVGqOu1PlCXQq0h+cdj+cZpfeyOp+7Ccihb7RHhlwOt
	2vDRPsECI0rr6yazqi9i+G40DD7o=
X-Google-Smtp-Source: AGHT+IFZiMSluSrb9+nWCWeg+FxH/hJIRdBf5Gw/SFtxbIyNxSzknr8qu+EPG1OOB+fxP5YqXo5E7zDD3Hy1rO+daWg=
X-Received: by 2002:a17:90b:14a:b0:2a0:7815:dd25 with SMTP id
 em10-20020a17090b014a00b002a07815dd25mr217024pjb.20.1711558010028; Wed, 27
 Mar 2024 09:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327024245.318299-1-andreimatei1@gmail.com> <20240327024245.318299-3-andreimatei1@gmail.com>
In-Reply-To: <20240327024245.318299-3-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Mar 2024 09:46:37 -0700
Message-ID: <CAEf4BzYmdNAuqQ_pz=xVQ4a8COqzDCR6-A-_suW+OgpM-fh02w@mail.gmail.com>
Subject: Re: [PATCH V2 bpf 2/2] bpf: Protect against int overflow for stack
 access size
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, 
	syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com, 
	syzbot+aafd0513053a1cbf52ef@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:43=E2=80=AFPM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> This patch re-introduces protection against the size of access to stack
> memory being negative; the access size can appear negative as a result
> of overflowing its signed int representation. This should not actually
> happen, as there are other protections along the way, but we should
> protect against it anyway. One code path was missing such protections
> (fixed in the previous patch in the series), causing out-of-bounds array
> accesses in check_stack_range_initialized(). This patch causes the
> verification of a program with such a non-sensical access size to fail.
>
> This check used to exist in a more indirect way, but was inadvertendly
> removed in a833a17aeac7.
>
> Fixes: a833a17aeac7 ("bpf: Fix verification of indirect var-off stack acc=
ess")
> Reported-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
> Reported-by: syzbot+aafd0513053a1cbf52ef@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyv=
BSgjN1T31K+gOw@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0bfc0050db28..353985b2b6a2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6701,6 +6701,11 @@ static int check_stack_access_within_bounds(
>         err =3D check_stack_slot_within_bounds(env, min_off, state, type)=
;
>         if (!err && max_off > 0)
>                 err =3D -EINVAL; /* out of stack access into non-negative=
 offsets */
> +       if (!err && access_size < 0)
> +               /* access_size should not be negative (or overflow an int=
); others checks
> +                * along the way should have prevented such an access.
> +                */
> +               err =3D -EFAULT; /* invalid negative access size; integer=
 overflow? */
>
>         if (err) {
>                 if (tnum_is_const(reg->var_off)) {
> --
> 2.40.1
>
>
