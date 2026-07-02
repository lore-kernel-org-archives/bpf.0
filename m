Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664A31A07F
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009308; cv=pass; b=ry2B4aFfhy6j5lpx5wnPoKSfFPQqjVHICL9L4I5MOvoTmwfr+9yasp/sC9steqG6zmnPm6G6ALOYP5xPZfXYKHdKnThyQJR6SC1bom6z+HmHy3lxbTxwSgKw9tcx/k54IhKkvb5U48jROrEu7nwFrzt5PjQgUAGA0W2WIsm45QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009308; c=relaxed/simple;
	bh=q+o/yNzSXuyt0613ZPmcuoVubhew05a0sSUdyDx4tSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBdokNuYHzEnmwPyZHDxajbeygIi8A/GtoRZztgS3O9Hl9Pg+k7jcNx+cr6ihk13Nz8RmiR1vUOganTv0nVJPpkLGT8p6ff+0ljW5PpFvLXNkjQdwLAz7xVe0Vxullcu+i7r+8xPa+OCa4aSS7oZQMWn0wGkrORIjCl1k7EGUgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2TEdBBO; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2TEdBBO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c7c61b5292so23832635ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 09:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783009306; cv=none;
        d=google.com; s=arc-20260327;
        b=VwuK9FtomSWzHckE0Z2s+XXl+KWc5tc79yXE6BQHsxc1Ljej/1jkquoQbEv/otpGOw
         rdEDtTNqYC5qHbwsdCi6GuSXugrQCJj0BsEsEA+tifkB6iGZ6eR7J2gWN/24P4iDgq22
         Hno7hb/q2W92MNYbFZlgnUG/8CuBtHeb68K3mpNV/0eWD9OLzBnkgYBHP9MDvRXHMjM9
         9i1kS5vAvaIXDpVl0A+kmCczaFinn3969lV6w+KAxUuuKCa6TBQraB4GkV5MEXF6X83z
         uPp1QEWaqUMcOuiWxPMEwmsokiM4ioD3QKd96Y22NCO70ZDaSw2BCe+kVN/9PmH8pArz
         KZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dNqy+sY/bvwDtNrT9SQaApzsG/1uW4k7ziD0ks8Gk1Q=;
        fh=FZJ76Ql0B1ZSj0oCGiK9/LDA+CBhkFaOec4z3jwifqQ=;
        b=X3AI08vb1lNVza2I0R7jI2JY0E7tMfwxD+FTg6t2wN+SsiFjrJtssu3Xld5p7+VARU
         gdNa5P1NR0jlcLpMjulp6aitLJTuXbg0J+OY8qbaXFggJiTa+bsyzx2vnkG7yYaL3Kpn
         BtgRcd0FXJa+V9/gTEFdxLfyN7ay0mo5YDZvL5G9Lj/c0KN5jb6J20dVv9pt1B5KEc8S
         Qw8JEbLpFWmhC/BM5orD1fXGSHpsQee+NOegqXtpYPrsvYw0Al2qswUmG2EL/7qctklO
         DcuPDxDoPtc/y1IvVfuFvh6NqPB3KoQuLdMmGY7h4FC+Gg1JnKDIlBk7dH2Z5WQAJT61
         nfAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783009306; x=1783614106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dNqy+sY/bvwDtNrT9SQaApzsG/1uW4k7ziD0ks8Gk1Q=;
        b=j2TEdBBOHSksoGqMukuI9m6CWd7fB8Azb8ujgpZOJrQKad0RCpkm6bORK4zsByaXKB
         drzWY8yTH3G2RakwTkuMNT0t5/bEzpQOG0ONUZdaRT5dQ+KBjmFmXsZpDb9xp2AW+CRZ
         U9JMlS/V11IQXvRxftv6C7E/sxxBN+DoqCw+xAfGafS7amPjF2esA3N+FylFzySWF4Yn
         Jh4SstReTD8V59WHSNvu/9mXqG/p+AsJIpgdj27t40dl1msMjoFM0IQdRmy/2Wi1vL69
         eZAwhNTUsipcuzJijiFq9pEPNphOU1T+YU+Nb0zEx5J8zWSIDUU81vUMtYTzY95ORwPm
         7rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783009306; x=1783614106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNqy+sY/bvwDtNrT9SQaApzsG/1uW4k7ziD0ks8Gk1Q=;
        b=HNXLqOUX95gQ2bWt2w/4Yc2DWSsBFwy8BmO8ll+7UCLU/cHiPpMEXowIj5l6Q6Zcuv
         OlsP4XrN3maFDxotBOUD57m5dflCCJcuOQkpiMf1kLR9uPCnMjTXM2Ty9R54dYfhDKvA
         kbjciTiZrVyD1+s7v6atQUCmX4oH6ndEwdg62SZwcaRsaCAHAj3phGu9K5ZBPjWNET3O
         LHyTuTzgFkbQINogwFwZs2W63VV79CCOKriktomRoxyjRwKzlvDwbblKxa0Wg5mAsGzc
         1F5gBq8947PSExLPAsw+GvKfIqbCR6CzIZOiclb/hYUzT8TjT6bdTJQ1fpvJ49+bF7vT
         PteA==
X-Forwarded-Encrypted: i=1; AHgh+RrqSpPhZSlUTcGh8lIkb73CPCXQ+Sqe4uU5Yfj62QQdtJ5u4e/nUwPz4dEcmi1uEQlbEVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjRdQgtMhVWBuZnfRfUcHPxfCH36SjJ52p72cSuVjDEv6cazs
	zqpnUP9sJNW7X598uRDinmNzT78eN23goULpTEfeFrM8igVcMkctKKWLsY73ItoMKpQUOisKtAZ
	tULjBPPuAj2XozzhsXAmMDMmKPASkXpI=
X-Gm-Gg: AfdE7ckV3rQfV/1LfZSNUsP/tqB6FoVuYbFyv/5YzTYOnDXVAtSkyeEZ6muL8xcssMS
	VhxXQOH3WRRBmtl7c0owYzTZwnID2XmLkfjPp9m5nCZiHFOqukHvlsscGX7b6tJ2oRodyyxnLGl
	gFc2NFthKOq3MwCeZFcgAvgqZg4MgDqXeqO+7y5nyCVnkZPe+E3LNdC1S5WjTtts8iOYbPINOdM
	WNWNd/HaGICTDWmNgUQEu+uOjotw/6nclAe4S5jLSAyVphLhKCITzG0jPwdwCY4fmOCsjZsp4CU
	hUp8JO4mXWeZnb1l16ORiwkilCzfHkJju9p9fZa1DSEc/TI6dZ4U80q0wiqzAVjdrLvWxjzaZb7
	j974U
X-Received: by 2002:a17:903:ac4:b0:2c9:d55d:2d1 with SMTP id
 d9443c01a7336-2ca9120069emr63395015ad.33.1783009306459; Thu, 02 Jul 2026
 09:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630205418.3483969-1-andrii@kernel.org> <77ea35c8-2a06-41f0-b808-9743dbd3ea51@kernel.org>
 <CAEf4BzaDjuLTsoTFXpPMp33KbKHvXkDv0Gwf2T=JVQBqGgZ+5A@mail.gmail.com> <6a8fbf80-5672-4691-aa60-8f8b3b75aa96@kernel.org>
In-Reply-To: <6a8fbf80-5672-4691-aa60-8f8b3b75aa96@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Jul 2026 09:21:33 -0700
X-Gm-Features: AVVi8CepZ9Ra4LM7mE2naC730lnxt3OxGM_aDcCcyzar3_zxZvhUBfsMO_l6Vhs
Message-ID: <CAEf4BzabKBK+NjNkVEUay9WhbMW7s00f9-=SQ1e2740ugXCHOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Strip all -Wformat* flags from
 bootstrap libbpf build
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 7:57=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2026-07-01 11:15 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Wed, Jul 1, 2026 at 5:54=E2=80=AFAM Quentin Monnet <qmo@kernel.org> =
wrote:
> >>
> >> 2026-06-30 13:54 UTC-0700 ~ Andrii Nakryiko <andrii@kernel.org>
> >>> Commit 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
> >>> started building the bootstrap libbpf with HOST_CFLAGS, stripping the
> >>> warning options that are unsuitable for that build by filtering out
> >>> -W -Wall -Wextra -Wformat -Wformat-signedness.
> >>>
> >>> HOST_CFLAGS inherits EXTRA_WARNINGS, which includes -Wformat-security
> >>> and -Wformat-y2k. The filter drops -Wall and -Wformat (the latter bei=
ng
> >>> what actually enables -Wformat), but leaves those two -Wformat-* chil=
dren
> >>> in LIBBPF_BOOTSTRAP_CFLAGS. Building the bootstrap libbpf with it the=
n
> >>> warns:
> >>>
> >>>   cc1: warning: '-Wformat-y2k' ignored without '-Wformat'
> >>>   cc1: warning: '-Wformat-security' ignored without '-Wformat'
> >>>
> >>> The warning is easy to miss in an in-tree build: tools/lib/bpf/Makefi=
le
> >>> re-adds -Wall via "override CFLAGS +=3D -Wall", which re-enables -Wfo=
rmat
> >>> for the libbpf objects, so only libbpf's feature-detection probe (whi=
ch
> >>> uses the passed CFLAGS verbatim) leaks the two warnings. The standalo=
ne
> >>> libbpf Makefile (github.com/libbpf/libbpf, used by the bpftool mirror=
)
> >>> instead uses "CFLAGS ?=3D ... -Wall", which the passed-in CFLAGS over=
rides,
> >>> so -Wall is never re-added and every bootstrap object warns.
> >>>
> >>> Use a -Wformat% wildcard in the filter-out so the orphaned children a=
re
> >>> removed together with the parent.
> >>>
> >>> Fixes: 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
> >>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>
> >>
> >> Looks good, thank you.
> >>
> >> Acked-by: Quentin Monnet <qmo@kernel.org>
> >
> > thanks, applied to bpf-next, please do another bpftool sync when you
> > get a chance
>
>
> Done now, it should be all sorted in the GitHub mirror. Thanks!
>

Nice, finally warning-free wprof build :) Thanks!

> Quentin
