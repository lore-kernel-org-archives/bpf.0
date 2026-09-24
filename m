Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C503F5BF5
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291940; cv=pass; b=E4L7PGJHJ/ajSM2nYJe/LbhoGRqdQyVNmPnTZVCuCls2Daa5ZUkibwsBRM2uYM65WJMPGNuk4o2XSyAihjijZ3G8dXK1y5Ab+qfGMJQ3QkjPe2lwvF/9nxF0Z+l2DarVbHnBxJ3X9kt488FNUXDsTM3SZiYwadTUqn2wYobaPSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291940; c=relaxed/simple;
	bh=9RCyGcLni0Zuv2ak8AuReZF9rUKaDYEjUqAvYnDu7oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4uG1yzv9upM8T0dx/G/Rb2B/5PCZXclanDE/xUzBiMouu29fvvV5sVwZFH3PcZ/UPpHjkRMpEs8i8BLuF4ZWM2hJjB7W2G8k8tNm6ud5hEB51uTRhsCAVO9adu09KmDFuMuzKgeSsyNJYqYMpN+M9m1XAFS++4YFg6f9kT4SpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEzuQiKX; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEzuQiKX"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fbef5018so1718865ad.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790291938; cv=none;
        d=google.com; s=arc-20260327;
        b=Tud4mfc7nFwYVs7EZDsskuAyqerR1ijGb51j8VDK1uc28epS3PiVN9rNcxyn17cZ3K
         nFnUu02IM3H1T6Z6S4zWlkuMhgFAKe6RUGdqoFU7QkvenMrv3XNnNK7tFOmHQ3RTkAPF
         t2UFBH2UQmnmkdxJaUWf2dqGBk07Mc+F4WTjk21Ar2J5JcIJZ7DCCecdfUOVQmty4i/B
         RAgxWqwdkd8kwMKlR8xlWwsy25/2M4XFUBRD2C4Z47892kyxrUn86PS5vlnkMRv7Ithz
         LZzJntwe/JmyeWvFf/bHShx6mIhSFcAmP3iUNgm86BiJiKnc3C+yJDeoxJElQewhVnQ/
         5KJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H5dgkk4suGs8IXiDbXD32tdMk0EaoFjsyScSnsoqHmo=;
        fh=FLd6JgKJC78bvz9uUBQxoN4rjy641h97g+CnETlClq4=;
        b=BagM92J3SbY6KMbP20u/Q2+rBgU8KV2iwC+GLoWDcAmp3y1GG4f6zyQJKwqB7IW3s8
         ZU+bOcmkYGHWa7VsyJGeU9L+lvwt1E1jTDkPM9VuhfreZrfPzZ7irTb8ujwJlnCI0nno
         sVH7XZx8u6VVuA+/a1NliphQRjukIDfcDPsH0fyVzt7nakJhaQjIX3FQZOrShMRW95wX
         NXtq0xSB/bSpUAyjXylqbJiy0yiAXYjuTdn02RxqbPhcZqvR9TbpdEcFvB9Ms8j0pMYc
         SdYQ9JBGCum82u1zHbNpuD/wYKyx8eJncgfaiaJx6JT5KC97s00L8HQtXY39x0mgvL7w
         m67g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790291938; x=1790896738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H5dgkk4suGs8IXiDbXD32tdMk0EaoFjsyScSnsoqHmo=;
        b=KEzuQiKXPCWiTShBugZ/3L/+I8c8xTRLfShN1HtO002BMN/6kzAmCOuNhHJl22bGlS
         IGZqyR1l7rYPHUj8FRvZuOojGsGuo/gPGF58cWU4XXezFTTlyh/i7R+AvmXkO3xWo/rv
         fOO+hofeRyVZ+S1deOSr5RqVCjikWtByt6bxEKkGkgUlSXjl2T5PKUIWs1Fqm4g7DIhb
         EmZMcFwOe4LqkSw17krBoAC3MUdiGmu1eay2uYqnxgf7I+UVcjGRzdEsr/lmwOCbwU9g
         Dj9EpQ9VKF1y3xtwi8VweZB6UZKlxFAUtpON85w4aiTrSWZSrQkpx7R77KN9Z5Qc2Htv
         oygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790291938; x=1790896738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H5dgkk4suGs8IXiDbXD32tdMk0EaoFjsyScSnsoqHmo=;
        b=RTIAvo7c+5pxw6xu0TlV/Oj/T6lYVLgsnOjVlWFSyP+0/fa0+3ROLBSt7Ch58K1hOE
         1iu2ZxW0FK02cZlykT6msQ70IHa8gfWlXyKjKg+PaLUnvJZJNbJS75uHfULfB6KMGppe
         39N5pOuhIADlMwFSOimUVOcdt6tnyZf6UumWC1zm1QFWJngbJkScTC3LSEd1nhpIXw8X
         +omRsGnlGXMPVm3gaUhWL3QZQ837r9ugdEUMgvT3My0lXAr3X/1CtXvxf+Y5ab325J/d
         Cz5fgEwpdZ0HfUHzlGYycP16vpILaNYrYLm1H8OIV+GJ1Eg3E7e8x/0YVKR2hkqUXwKn
         1pBQ==
X-Gm-Message-State: AFuF++mCWu1LEp/c2jh7iWFrKl3hTN2m+q+6okqZ1es2TzynlV7NXXRO
	1UQUDqCokueHlvPS+uyIrx/NX1E3q4QE20X2DoPe8qQd0N69lLNwAWEmQyLimY85e3gyjru1X95
	+7QCR4D/JYFjpRNKuADYFcA4xYcaoG0KhHQ==
X-Gm-Gg: AYBFou3zHKhEg8O/gqhC4nA7GgU7runo5fpywlktOEayEciBoeTui/NMAf0goHWhqC6
	9uqB9DprZjRF+ZSd+2h6KhKg+sETSoXfTb++IE0Rm7NSlm/allpyzIOYNMHpyOyS58I5CwPAyVV
	cbgk4KjipcQ2gWhUR6rUz3GMGI1zOSJOwbVDrso3zuylbAq3zkb/D0kkB+2POBe0ksREd42IyjV
	e7R++0jxDRBDGktc3wcBqdRCyQ20k4bas2q+DlGA9yQ+NPR/fAW7AWpWS2r7IY3db375S/4Dz4/
	GtkDaCe+rsy5jIcVy6crdnm/VXqpy6Y7ucya5T1kVR9Cj2Ix8sZWciYil4VU2ds3eOvfXRq15Ki
	FwoUsNQgVw4wRPgYC3NAFFiIcAOKk2wlA6y52
X-Received: by 2002:a17:903:2c5:b0:2dd:68a4:170c with SMTP id
 d9443c01a7336-2df7dd77c8emr38341825ad.11.1790291938206; Thu, 24 Sep 2026
 16:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com> <20260923232939.1886328-4-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260923232939.1886328-4-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Sep 2026 16:18:43 -0700
X-Gm-Features: AclHuK_N4U3RYaxmMblglOqENpo2TH24b9t-7s4fD7RkFOTbprNMAO7cH4Wtubk
Message-ID: <CAEf4Bzag4AsTq-8EgExqi9jhU9ZOM8q5MiTYhT0ynBsszre8pQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/8] libbpf: Support declarative manual load
 via SEC("!...") prefix
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com, 
	linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:29=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> Add a SEC("!...") section-name prefix, letting a program declare
> itself manually-loaded in its source instead of requiring an
> imperative bpf_program__set_load_strategy() call, following the exact
> convention already used for SEC("?...").
>
> The prefix is recognized and stripped in bpf_object__init_prog(),
> before find_sec_def() ever runs, directly setting load_strategy to
> MANUAL and initializing autoattach/saved_autoattach - the same place
> and same style '?' already uses, and before BTF or sec_def exist.
>
> Assisted-by: Claude:claude-sonnet-5
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 939f0d6378e3..d815e53e8295 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -889,19 +889,29 @@ bpf_object__init_prog(struct bpf_object *obj, struc=
t bpf_program *prog,
>         prog->fd =3D -1;
>         prog->exception_cb_idx =3D -1;
>
> -       /* libbpf's convention for SEC("?abc...") is that it's just like
> +       /*
> +        * libbpf's convention for SEC("?abc...") is that it's just like
>          * SEC("abc...") but the corresponding bpf_program starts out wit=
h
>          * autoload set to false.
> +        *
> +        * Similarly, SEC("!abc...") marks the program for manual loading=
:
> +        * it is skipped by the bulk auto-load pass and must be explicitl=
y
> +        * loaded later via bpf_program__load().
>          */
>         if (sec_name[0] =3D=3D '?') {
>                 prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_DISABLED;
>                 /* from now on forget there was ? in section name */
>                 sec_name++;
> +       } else if (sec_name[0] =3D=3D '!') {
> +               prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_MANUAL;
> +               /* from now on forget there was ! in section name */
> +               sec_name++;
>         } else {
>                 prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_AUTO;
>         }
>
> -       prog->autoattach =3D true;
> +       prog->saved_autoattach =3D true;
> +       prog->autoattach =3D prog->load_strategy !=3D BPF_PROG_LOAD_STRAT=
EGY_MANUAL;
>
>         /* inherit object's log_level */
>         prog->log_level =3D obj->log_level;
> @@ -15469,7 +15479,7 @@ int bpf_program__set_load_strategy(struct bpf_pro=
gram *prog, enum bpf_prog_load_
>                  * A gen_loader implementation is being called for autolo=
aded
>                  * programs and defines its own model for loading BPF pro=
grams.
>                  * To pass a BPF program to gen_loader, set the program's=
 load strategy
> -                * to LD_AUTOLOAD.
> +                * to BPF_PROG_LOAD_STRATEGY_AUTO.

you want other humans to review your AI slop, but you didn't care to
even skim the diff yourself, nice


>                  */
>                 if (obj->gen_loader)
>                         return libbpf_err(-EOPNOTSUPP);
> --
> 2.34.1
>
