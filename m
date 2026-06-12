Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5D3793D0
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292324; cv=pass; b=Zmu/dEiIi1tZXmQ3H7AslyWHC+v0cgLhwd0K1A8lutW4pE9sgoalKlaNb5w/X9q0AleU37PI/HzdMyKDLDVjD/XhzpQLhmW6lc+WDpWtG99FCohCgM7syE8QHQyLs+cATOPbAFOy+ojU8POnLWR/eBuegTsZkdER7SGyVvAoiUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292324; c=relaxed/simple;
	bh=wtdSAI/WhKGBjuABTv5R/kXIRbC/rjQy6jOp30gmmV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kapz/6NXXPrcQV2aTDS5JCUPceGtzQg2Vweh22XpLs7zZHyULDdu27j8wrHkYFhX0atOtioBSUgoFQ+Q7mG/wU4Fn6HfMvkZY4tyi49PyGqcRPRDnwhMcgb8hrt7B8ByQgL8/YtzdTB14V5V71eRfmQKscCjOcx07MVDDhrr5Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DgF8gDjd; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgF8gDjd"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so1800738e87.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 12:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781292320; cv=none;
        d=google.com; s=arc-20240605;
        b=kqXcETVSYviutSoOVA7pSk53jfIExCO3vM4dBGMprlko/B35IUh2bJDl7+1LF5ehtU
         +W/TlOU91kxLJDr1jqP5AinuzGut2N9mfnW7flxUXgLm7P8YSncEBWvWdk4d14hO6Qcc
         K6qrgTd+WbLSqF+E0iy/LsgMP8gXB3A8iBCAH857vXPFaW2DzjL9faudyPxFakqzjGij
         vJ6NPKP/7wwcs6E4NaNSn3pXVvmUCywxmuzZg9vd/iLB2BdGu0U1lq2JPZqoomaH/8Bd
         jId5B67Ue+eLApzzo/8RiPeMWyMhBnN/03BYJDakSSwyvRaqG4FLF1dp+p4UHsWcPovW
         NeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JzbhYOVx15zdNgTlmqivEDbnFdm8e7TKoj1i3uih1i8=;
        fh=FoN+rL7dCRthnuOcyLqQZqrTZnhRAcIUpXF0ph9x/Cw=;
        b=ai6os0CQY5YxyYXpTk2RR7TAUGufd+uT8HmbJ7TredgGaKtGx1eb1/cRHwia9KrvU9
         DPrGG9YRMrzJdDXNVMcxBCbQ3x5My6mhzAqvdPfJme8LpefbuoT4RgE5WkPRnqScCJPI
         M8sOr31Gz1Zgv3YIlt3gaLY50G5ruOe6Vn/FIiCCyHNbCiGMvrYKGEF0a69avWD+CN78
         daTNpBRk1uzXjZhNcvXIKiDnTJpnbuslljF4U4rSFPfKbNL/BZrFiNJPJ5xkxnJft0Ob
         uyikwG/advWGId5l15zT3ztgM3bWX76OarWwx3PB+PCdkINYB4hVB8O9VNV/Zk4v4bOd
         S/bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781292320; x=1781897120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzbhYOVx15zdNgTlmqivEDbnFdm8e7TKoj1i3uih1i8=;
        b=DgF8gDjdoPbi+WpN19e2HKMcEIJNpsRgG6t0J3ouGRuudtJMGdY/fnnNPidXbkFatF
         M/yI372egOH3EOroPtM2WdecxJojBzPApVemjhnc5QWBgXo4VCSkWmFNZXup6jl+DPRa
         dimn87G92CKfrIQBovIao5xy9HjLv8f9ykmeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292320; x=1781897120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JzbhYOVx15zdNgTlmqivEDbnFdm8e7TKoj1i3uih1i8=;
        b=aimJjGFb6g05LxBqIp6mMKZGlp+tpF6Rnl8RChj95ihJoCJ/v7doW9ZFl8PmaF1sxI
         Is/pB7N7o92BzkotW5+Cn5LBRdMOYBmAwk6e14b187/h+W5PPvWuAHwY2M+6nj10GBS/
         BCECzelZq93CuPRsoGHj9BIwmE9pKM0tZEifI6Fg3ulmAvYRiJn+c0xepq7f3cOtCeaD
         +xB3PibHu0IpVSby6hb4ivkl7nLRu8QN2vqojJ1LEkDlwGCvBDXID3vylRh76b4VbMpX
         Fjmgru+cSi1I7rtejkDSRn7vci6ORAxh35q8A+xRfAvRYe7bDccr8ms0RMQTpn3w7Zij
         u+Lw==
X-Forwarded-Encrypted: i=1; AFNElJ9eOzdq5TOGd75Q/mMZsvi4LUPS0AeFHh+o46xJ3gFtcMrJ1h50aSFyhLiq3BFnAUBMbXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ns4qoXgP0UdGW01K440OwnF1IzJVaD7Iyi3E5/xek76VqUYK
	c5dhAC0tTzG4+9Q9ZM/qKTFcbUjqjUbnjDMb7Oeyk+0gpGeDC08SvMNRpqh1MYHk3JpFtpWLtnH
	ZJkp+IUAOb0lyVD28Ob4fN0/eGsgqNrczLdMGwNIL
X-Gm-Gg: Acq92OH07WlCLQufhNpyfMzD2hWKUuyb71MOrb3UD7p8Il8E167EdkIg9muUC4CQRb8
	pCDEhVtnYTUpiHA9gmz1j9duF5daoWdTPtW2tPPPXHkMZ0Y4yoSKFO/cwAM9cWJjNLk8+OLb60S
	/kfM0Zb/ALc8XAdwgGifCyxE+tgTLVEoxp6Wezi1RUwBWbRDekVPKqILxCyhxe0gieNEZKLXM1U
	Jo1160g8IjU2OV0sMJhndnnmn6eQLn7ZI/s2gJaaTzhudEI8qU+PGqz7X0QFurCAtUlE21SZjui
	iPIeOjc859ysf0JydLhlJXGmin6zHVi+OSI6WilcaoIzhx1L
X-Received: by 2002:a05:6512:3b0a:b0:5aa:854c:61e0 with SMTP id
 2adb3069b0e04-5ad2db452d1mr1311594e87.20.1781292319447; Fri, 12 Jun 2026
 12:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk> <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk>
In-Reply-To: <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk>
From: Will Drewry <wad@chromium.org>
Date: Fri, 12 Jun 2026 14:25:03 -0500
X-Gm-Features: AVVi8CdO18l0E0vkUdggPdi_e7VaCUHGrQ-SUpY-fJfFGaS3PLmAAujQ6BHqK08
Message-ID: <CAAFS_9HpxOgHn+qfzSpLjV4Mj_CURiwxFOaK9GO0DdBg8xgNYw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
To: Jamie Hill-Daniel <clubby789@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 10:42=E2=80=AFAM Jamie Hill-Daniel <clubby789@gmail=
.com> wrote:
>
> It is currently impossible to enable `SECCOMP_MODE_STRICT` if
> `SECCOMP_MODE_FILTER` is enabled, and vice-versa. This makes using
> seccomp difficult in environments such as Docker, which installs a
> seccomp filter by default.

Some quick thoughts on your resend -- the original reasons for
this approach:
(a) filter policy !=3D strict policy
(b) filter can implement strict, if layering is desired
(c) minimize checks in the syscall entry/return path

I'd expected folks to simply create the ~80 byte strict filter and install
it if they needed STRICT policy. More discussion below.

> Introduce a new internal `SECCOMP_MODE_COMBINED`
> that runs `strict` checks, followed by any installed filters.
>
> Link: https://github.com/moby/moby/issues/42082
> Signed-off-by: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
> ---
>  kernel/seccomp.c | 46 ++++++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 25f62867a16d..8201a050d358 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -33,6 +33,8 @@
>
>  /* Not exposed in headers: strictly internal use only. */
>  #define SECCOMP_MODE_DEAD      (SECCOMP_MODE_FILTER + 1)
> +/* Run SECCOMP_MODE_STRICT checks, followed by SECCOMP_MODE_FILTER  */
> +#define SECCOMP_MODE_COMBINED (SECCOMP_MODE_DEAD + 1)

I'm not sure if DEAD is meant to be fixed at the end of all modes or
not -- given that it's internal.

>
>  #ifdef CONFIG_SECCOMP_FILTER
>  #include <linux/file.h>
> @@ -432,14 +434,21 @@ static u32 seccomp_run_filters(const struct seccomp=
_data *sd,
>  }
>  #endif /* CONFIG_SECCOMP_FILTER */
>
> -static inline bool seccomp_may_assign_mode(unsigned long seccomp_mode)
> +/**
> + * seccomp_needs_combined: internal function for checking if requested m=
ode
> + * needs to be upgraded to `SECCOMP_MODE_COMBINED`.
> + *
> + */
> +static inline bool seccomp_needs_combined(unsigned long seccomp_mode)

It is easier to reason about if you keep the access checks separate from th=
e
behavior-change decision. Setting seccomp modes isn't on a particularly
performance-critical path, so we can be more verbose and explicit.

>  {
>         assert_spin_locked(&current->sighand->siglock);
>
> -       if (current->seccomp.mode && current->seccomp.mode !=3D seccomp_m=
ode)
> -               return false;
> +       if ((current->seccomp.mode =3D=3D SECCOMP_MODE_STRICT ||
> +            current->seccomp.mode =3D=3D SECCOMP_MODE_FILTER) &&
> +           current->seccomp.mode !=3D seccomp_mode)
> +               return true;

AFAICT, the only valid "combined" case is current->seccomp.mode=3D=3DFILTER
and seccomp_mode=3D=3DSTRICT.   There are other allowed transitions, but
not allowed for transitioning from FILTER->STRICT via COMBINED.

If this wasn't subsuming the update access check, then the single allowed
transition could be checked in set_mode_strict() (or a helper).

>
> -       return true;
> +       return false;
>  }
>
>  void __weak arch_seccomp_spec_mitigate(struct task_struct *task) { }
> @@ -1407,6 +1416,9 @@ int __secure_computing(void)
>                 WARN_ON_ONCE(1);
>                 do_exit(SIGKILL);
>                 return -1;
> +       case SECCOMP_MODE_COMBINED:
> +               __secure_computing_strict(this_syscall);
> +               return __seccomp_filter(this_syscall, false);
>         default:
>                 BUG();
>         }
> @@ -1421,30 +1433,23 @@ long prctl_get_seccomp(void)
>  /**
>   * seccomp_set_mode_strict: internal function for setting strict seccomp
>   *
> - * Once current->seccomp.mode is non-zero, it may not be changed.
> + * Once current->seccomp.mode is non-zero, it may only be changed to `CO=
MBINED` or `DEAD`.
>   *
> - * Returns 0 on success or -EINVAL on failure.
>   */
> -static long seccomp_set_mode_strict(void)
> +static void seccomp_set_mode_strict(void)
>  {
> -       const unsigned long seccomp_mode =3D SECCOMP_MODE_STRICT;
> -       long ret =3D -EINVAL;
> +       unsigned long seccomp_mode =3D SECCOMP_MODE_STRICT;
>
>         spin_lock_irq(&current->sighand->siglock);
>
> -       if (!seccomp_may_assign_mode(seccomp_mode))
> -               goto out;
> +       if (seccomp_needs_combined(seccomp_mode))
> +               seccomp_mode =3D SECCOMP_MODE_COMBINED;
>
>  #ifdef TIF_NOTSC
>         disable_TSC();
>  #endif
>         seccomp_assign_mode(current, seccomp_mode, 0);
> -       ret =3D 0;
> -
> -out:
>         spin_unlock_irq(&current->sighand->siglock);
> -
> -       return ret;

Is this reachable when mode is DEAD? In its current form, it would fail
out on may_assign_mode(), but now you have to consider if a race
could silently clobber the DEAD value (let's say).

>  }
>
>  #ifdef CONFIG_SECCOMP_FILTER
> @@ -1956,7 +1961,7 @@ static bool has_duplicate_listener(struct seccomp_f=
ilter *new_child)
>  static long seccomp_set_mode_filter(unsigned int flags,
>                                     const char __user *filter)
>  {
> -       const unsigned long seccomp_mode =3D SECCOMP_MODE_FILTER;
> +       long seccomp_mode =3D SECCOMP_MODE_FILTER;
>         struct seccomp_filter *prepared =3D NULL;
>         long ret =3D -EINVAL;
>         int listener =3D -1;
> @@ -2016,8 +2021,8 @@ static long seccomp_set_mode_filter(unsigned int fl=
ags,
>
>         spin_lock_irq(&current->sighand->siglock);
>
> -       if (!seccomp_may_assign_mode(seccomp_mode))
> -               goto out;
> +       if (seccomp_needs_combined(seccomp_mode))
> +               seccomp_mode =3D SECCOMP_MODE_COMBINED;

So I have two concerns here --

1. By layering, STRICT becomes subject to FILTER RET behaviors.
2. If we did want to layer them, it would be ideal to separate the 'upgrade=
'
    decision from the access checks and make the layering path explicit.

If you are running a legacy binary that uses STRICT in Docker, then I
understand the goal, but there are userspace options.

I think it's hard to want to open the door on changing STRICT without
a good reason to work through all the implications that come with it:
cross-checking every SECCOMP_MODE_FILTER reference, sorting
out thread sync interactions, ...

That said, this change could be streamlined and look for ways
to minimize any potential implications.

Am I missing something or overstating it?

Thanks!
will

>
>         if (has_duplicate_listener(prepared)) {
>                 ret =3D -EBUSY;
> @@ -2105,7 +2110,8 @@ static long do_seccomp(unsigned int op, unsigned in=
t flags,
>         case SECCOMP_SET_MODE_STRICT:
>                 if (flags !=3D 0 || uargs !=3D NULL)
>                         return -EINVAL;
> -               return seccomp_set_mode_strict();
> +               seccomp_set_mode_strict();
> +               return 0;
>         case SECCOMP_SET_MODE_FILTER:
>                 return seccomp_set_mode_filter(flags, uargs);
>         case SECCOMP_GET_ACTION_AVAIL:
>
> --
> 2.54.0
>
