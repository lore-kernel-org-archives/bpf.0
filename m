Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947438B12D
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299454; cv=pass; b=b56/ag8XzyDdu0oCGMDqLvNITKE0NFW+1VcHPrCfJt8cc/49yra0OywBTNG/oI0qmvdolPuywa/91eToK2kd8RfK75KtjrTuIxrmTGMQkK6RxrJlYbF+26X9oHjB063tpsTPQYl/EtXjstuU1/UN4EPzG0hh16GOSNfMmymwrQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299454; c=relaxed/simple;
	bh=cn78rUTPXx1BC6BSDdWKsg1KZF77OTmfapeyMhEBPqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqCcsbQlqHeLQB/rnReVQk8v7QY8eLZ3i6A61QQO9IdniaH4IRwMMITTZsKBetXvVFZIOrwXl3O1bgUz8VmSzk8AbA3/vmfsMgjpkjFdo6aSE9X20uiUzNuSHjuhq1WTfImGgy3jLz175xZHfuCgFE5JYbN4rgz/B04XR4Nw/AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=z1mvs3UC; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="z1mvs3UC"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so1523703e87.3
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 14:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781299452; cv=none;
        d=google.com; s=arc-20240605;
        b=XDydeZMaLR5KS3d3lAAnticgv5nvKyWthJJLUz2DX7H/G9q5vLoEsP1rXKOFXkwerB
         ERG8iLz+N02o7IS/pyid8TK59vOZFMtXUkLurYsqLxKp14d61ckStL5y9PlM1fX4s/6O
         jMGjNRv8E2uQMeH4eKdTXlB7q7I1CZqkT9GvW0rn4sZgpKPow1uIDVutmPZc76RemTlq
         Kb3xRLW0wpaXWkcuWdMvI4Hj0QUPq1wq36jeaL/fLVkm3sTQsrTvtLTcPee6ZZeiIoby
         JBROVfQkg4ckINMa5+AIBOtfdsGoUyG6i/XA1lHUDAM1eitoPL85W9oigAw5d1Pm6pFo
         ubfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RDrvS5c8Xd94AF19HIRED6Jxb04kNSOwRy6kCXlBy+c=;
        fh=hpKkHh5ruz9UEj1ojptJfwhSZVWt7yPLyxaG/lRcVcY=;
        b=Pysr8JlMgaEm+y/mDvx9v9iCFF7mr+gJER+rURRG1xtQ+mDXGYMJtqsve4Kj1qZFLX
         Fw/1dIFQPHhKzlYwT7IjY3j0PooQJ740UCIinu2y1AR6tsmwXgRlfHFZbAh28UJFI7e6
         iFzMOA9cNVc2j2+LHafnLC+6CYzN0N5F1yGSpoCuoWxyCOKT+dvqhSawJl06Kc+Rjh6/
         EjAjL4NLrHNOtY5y9ce89OOR0Vn0MqJPyjsXawGHf+Bipq9e+RihF3BHVlZCE52GUm8v
         4DGs22HY2THjLJnoBNYxYyqX+IEA7XekM/RNa+IPSIgdKsninFPnyUU8E0eKS4ncwbaF
         7fVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1781299452; x=1781904252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDrvS5c8Xd94AF19HIRED6Jxb04kNSOwRy6kCXlBy+c=;
        b=z1mvs3UCVqIHVLExE4e3uSQZh3LfXVYjMqGTkE85Qfwdg+20Dz9SYPDD7cntnpuGrb
         nyzSuAonNINlDvOZPYzQCbNll/Le9QoDjZNdkBRAqYhL+v6e39XnO3OnJamGjvQiR9pP
         XJD7xXCAXz+nxKob7XvurU8gFo8Vj3ag2poffDvMLHDZ83GYfxxtj2arcP2Qh2Bo/0I1
         abvDXxvtsENirdht3qGC6FyvRbGW4jbH0n445VIXthQ8jX7Z8iB0KjEnsQhkCU85Iizi
         7d9lcRUrqyJE8GUMQKFUvE0ZSoKWjpfpv/bH1/AeyYfRTo/C/8KA1ORmwGZ4xBEQp62a
         5iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781299452; x=1781904252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RDrvS5c8Xd94AF19HIRED6Jxb04kNSOwRy6kCXlBy+c=;
        b=ExIzhUu+udnCYKFknYz4jk5DmsAUd7Ihflv+qeKRfkrcpUv8skOvkEdWlliFxTdb9Z
         YIIkVs9nk4GTBnXOhPlRgAvFYdaLSmCCKCmo5NwKQxeOsatcfmKGlCFn/RArnNTA3vro
         xFktJWu9TKlRIAkgxU/FWDW4rCd49GGVSZb3PAgNqOHbliDIRn1imQj+dRrCg4MXylHM
         P+L9gUtImWurM/aIKik3p03Q94xAsRquhXg/RzDpe+e952AFOqbuVXBAnam0HohFC0Le
         B89NS/HiNM/VSCtpYn4ov0UpvgEB2DqVNaICVvUxCplZRKMR9SPntxj39C9EWSK2jrBF
         Z3Xg==
X-Forwarded-Encrypted: i=1; AFNElJ9sh/Lai55SW5qH7KXdeVG7+sfxELQYR2DxSBdsDKa+SylbefCl4bM1Bi832p8fuOE9Z00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaXGFH20B5Ztl53Ecf+abRy7PtEeIHPXoZt84YpHRYGt7U8yqq
	QwpAxq/yYVkLrw3Q1dQWXshkjq/3FpuW93rNv/R7pifVRxT1qN8ErUc5QPvEZT0ZavOtjLOO9oH
	YAoWLcjhW+vfoDlmnbFjwCQb/uLZnDODXCCtMJ1hgqWfsGiOHmNA=
X-Gm-Gg: Acq92OFq2c/7SyaIV2eUSERRvgKA8hL2TD+ORQwxteL4YY/jJEyv/VgzSR3nhowFC9I
	DXaXhY5VUnXQnMtJGlexBvoapHDyn4uvVYNgfMtydq1cKCZOj8yl+XFDn4SuB0x8Xh/YgzstLGR
	DoAVccuvI3qA86KgQytNZmU03PMUsO089hCscmMb5KfYXj56xojJe+dMLJ2B3807Vl/qKqgBJHk
	ngPhdBUcij1d9badxnE6vYi+Gra2BYdkSghBxERYCI9O6MD4h/eMyDy5BdhCZe43QyojvtxBBv0
	dCEA
X-Received: by 2002:ac2:4215:0:b0:5a8:886f:c03d with SMTP id
 2adb3069b0e04-5ad2db2a4a4mr934656e87.19.1781299451886; Fri, 12 Jun 2026
 14:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
 <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk> <CAAFS_9HpxOgHn+qfzSpLjV4Mj_CURiwxFOaK9GO0DdBg8xgNYw@mail.gmail.com>
In-Reply-To: <CAAFS_9HpxOgHn+qfzSpLjV4Mj_CURiwxFOaK9GO0DdBg8xgNYw@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 12 Jun 2026 14:24:00 -0700
X-Gm-Features: AVVi8CfltwWlaIYn2cGClEbbpFjcBiIsNRfdTQO7boUoo7s5oV28C8CqBlmjRYc
Message-ID: <CALCETrUArQBzUS2mAhYxDS-unze_gnQ7efv1qeBke-ux=2KdkQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
To: Will Drewry <wad@chromium.org>
Cc: Jamie Hill-Daniel <clubby789@gmail.com>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 12:25=E2=80=AFPM Will Drewry <wad@chromium.org> wro=
te:
>
> On Tue, May 26, 2026 at 10:42=E2=80=AFAM Jamie Hill-Daniel <clubby789@gma=
il.com> wrote:
> >
> > It is currently impossible to enable `SECCOMP_MODE_STRICT` if
> > `SECCOMP_MODE_FILTER` is enabled, and vice-versa. This makes using
> > seccomp difficult in environments such as Docker, which installs a
> > seccomp filter by default.
>
> Some quick thoughts on your resend -- the original reasons for
> this approach:
> (a) filter policy !=3D strict policy
> (b) filter can implement strict, if layering is desired
> (c) minimize checks in the syscall entry/return path
>
> I'd expected folks to simply create the ~80 byte strict filter and instal=
l
> it if they needed STRICT policy.

I wonder if It would be reasonable to have the kernel do this on
behalf of the user program that's asking for STRICT.  The
implementation would probably be trivial.

--Andy
