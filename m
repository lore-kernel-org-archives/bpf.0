Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B4238C23
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771394812; cv=pass; b=Wq9cAq1QK+AP3/p7pALA2iDO1c69GNz10/DjlVtKW+6r/fZnPe/63TNPljPEZxekKxdwuRExITXh3hJHH3KEaV7J4Nk+9ZQFfLRzZtM4KR+SNcUAgTjAyNIeuIM7NrHekXrUgVmoXfnbmTj2lK++smQgqbQpi0ccZYRtG0N4GPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771394812; c=relaxed/simple;
	bh=A+bwLkCnLCUwDa0P8W68NBhf4YBnGFUw0xw++Rw1naA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISs7HZwhlOrf3D0lan2Kj+hK63nTZ6yT2QZ7+qfU1Xg5lD8skhowQJZff1FgL/7bFCzW8YB+S5fSe3dXxuHgXsKNaIDGe7ZawJWlIKqfGHUZIvkTF/fvYinyRXhr0pf8uskVN/rTRQYjGDJ/594bOCJmMMI9+RkgPh29DLPU9fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIGFguPh; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIGFguPh"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-948ba5ccf54so2781819241.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771394810; cv=none;
        d=google.com; s=arc-20240605;
        b=H45BzBTSawZdZv5QgnnDxDIgoEENWoSbqNURtmVdawODDStAnFu28EystpX0e6EGc9
         R9SHdy59v8L8XrhQSfMtugj/hp6RRpbnn9lKr8EHoRau6d58L6Y0CGXizn1PA+HEpCOr
         bBykTOxVtP2FE0gbJez9yZmQe4S0uJPXWYt6d5ikhYKrjE08zyvK64YYA/U8/nCvmK7x
         1v28yEVqXsKJAxC2IHhBBtDPzjvmAzHnUx3MxJDjBn6rNsdECtadFHwxLFxOQJmodST8
         FpNGyUyyQf9AkiZj1z5spYLVg8tKLl/U+9bIJVyNkvmC4KQmbFer0PHmmdzk/uvPoOfK
         xW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7ObbrphFjVg5XfcUk8shmVxjXtRriYQrOO1ZYbMNzM=;
        fh=7BdvuVjblzFWSm+FQrzzvSdJfy/Pp8mwXvrAgAkr0Zg=;
        b=VRbGiIOFen1zePjKshGWGPvmJDgHsqrXCRph4yFrCtqM7KFnYqSbNPY2L4KaCSxUEj
         j88M1zRwv3z6GEINkHdgv+15KEoqNQHYhgoyW1HiM21igD5gor4P3m0536aeTvGi8EbZ
         yuhI0Jqt6VUyYQAOKhfIL8Y+701KcxtMZQ0Amobd1sc9bVS9VRlHbIpqSebTvC+nb3xG
         /VWwEM9NPeVGEE4kBJstX2We18H9cKR6T/9KILR65zgIB6wgM55vLsQP7xQ+OqDLhn2j
         L5K4+iXdv/QIICgOVD9IdrQ/hkDr2BH67jjDcLTThE6HQlcsPKsSikT7fTuIQMkud45+
         oyMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771394810; x=1771999610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7ObbrphFjVg5XfcUk8shmVxjXtRriYQrOO1ZYbMNzM=;
        b=cIGFguPhNETfXLCtK6eXYRoN033Go8IdTPMMqT5SR2Aa87oUTddK1Bx/pZjJgVFCbu
         f/KBCtqyh2dw0YDXFjFR8I9bdjGzggrzWOdEvy4wNKLN788nzpG2ipIoLA5cQHUhOXZe
         18z6cCplrr3m5LjG99MfTEx8uMBhBNWPXZ983kUR98UZpmZURohkeln/lmg7onW+AE/P
         rvX7j76pRdllgAbAP4bLaH09cyt1LoljQfmLK8lYtJ5th8w7K4PRs9s2n7btBNLzRB6y
         jyfS3P0SLoo8ErZT1mSNuTplkhJ1uC4IOGmbMvKsirIoktrAF8Yfrkx6ozBLrdW29+WQ
         Ghlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771394810; x=1771999610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x7ObbrphFjVg5XfcUk8shmVxjXtRriYQrOO1ZYbMNzM=;
        b=DrUDBoefHz04sRo25o6pDEckxRsoJydexj9P/oe+sMUCN90cqkiK+atSqjXlcF/Xy6
         IQjnNwgnqs1UIPLjx1EcLOavWaAwZfwGwF3LK+JKbufK24P0pbTrCDX3NtU6UDyuy0FN
         mc+YRl/WAT9RRmOLxYmH0rIG1gzHTIW4hGIT7VjP+P941cyr2Koi/1KcirbCatrz4wXf
         mldKEkxRqLdkdME/lXKcQtytmgR0rX79MLCTYhh02uvX73Wguk+w8ZTT8nHfxh07TBl+
         +YDUj7yiyzXAF5f6jr03vq9SId5pSzFBjCYuUfXtvA3VFfKp8UOGcKcr42wiIT+kuOyg
         vsxg==
X-Forwarded-Encrypted: i=1; AJvYcCVKzTEMKW4hgqFDwJj4LOid1CqnwBHve81ymCpmmDXxUQPjTfsjHuKjBIACB3OqsrGm84A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNlVopCWrQx15c3DCBa/qcBHf4uX6D+qv9/0AItXXOffgI6Uy
	JyS+HIav2i0p9KuKkJKcIUxGTWNBhmDuIVLJ0/FSBnVR+LwE9x1vDYLyeVCKYQ/SctcB3e3zjVD
	FzyUR6yyWboFYwRm4vZ6ojhPAIDkxNiE=
X-Gm-Gg: AZuq6aJ2sVngd7KtAfjRDDOOVC42GeDlgnVYX7+xLn1tdvIyLWLscJAVQ09ZPiXc6My
	IDLaDc+doGkKkh5V94cit9Ub8/Z/O/5Af6/I3yslb7I2716aT5sQCyS6mILe/6ddXq4qLH7BbJp
	dGzloiMYgMx+7pJuCqLZZG3k/oZGdHDD55TcKh3dwhSp9Qeb9h5+LcRs57PN3x2A5yho5v3Jk2j
	7ubDyY1hy7sxNoGWgEMV6tRD6ArRvc3/tLSOGpexYhVNAXavp9gnW70A2dKwxFslJcZjxHElN6s
	smbh7u5q8E8nCau8i7CEpARpipok13ZoSnSEbpcdWg4bo2/2uojw
X-Received: by 2002:a05:6102:41a3:b0:5fd:f0d2:9ef7 with SMTP id
 ada2fe7eead31-5fe7fd5b009mr408412137.42.1771394809842; Tue, 17 Feb 2026
 22:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771316309.git.paul.chaignon@gmail.com> <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
 <12705b3d58569685048804c33e90755c17667cbf.camel@gmail.com>
In-Reply-To: <12705b3d58569685048804c33e90755c17667cbf.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Wed, 18 Feb 2026 01:06:39 -0500
X-Gm-Features: AaiRm51vbetbvEW2g5uZWCjiWu_IpNlmvEIgwLs_LlAbkHyw5hql0ZZvvjSA6lM
Message-ID: <CAM=Ch06Vg-faG9ukU4DAsF9FRG2PeUtYHh3BkG0dOzYi=WDCyg@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 5:58=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
[...]
> > 1. The u64 range and the tnum only overlap in umin.
> >    u64:  ---[xxxxxx]-----
> >    tnum: --xx----------x-
> I think this hunk should be rewritten as follows:
>
>         tnum_next =3D tnum_step(reg->var_off, reg->umin_value);
>         tnum_max =3D reg->var_off.value | reg->var_off.mask;
>         tnum_min =3D reg->var_off.value;
>         if (tnum_next > reg->umax_value) {
>                 /* The only overlap is umin */
>                 ___mark_reg_known(reg, tnum_min);
>         } else if (tnum_min < reg->umin_value && tnum_next =3D=3D tnum_ma=
x) {
>                 /* The only overlap is tmax */
>                 ___mark_reg_known(reg, tnum_next);
>         } else if (tnum_next <=3D reg->umax_value &&
>                    tnum_step(reg->var_off, tnum_next) > reg->umax_value) =
{
>                 ___mark_reg_known(reg, tnum_next);
>         }
>
> - At-least to me, it easier to understand this way.

We can also use tmin and tmax, like tnum_step from the previous commit does=
,
to keep things consistent.

> - There is no need to gate the condition `tnum_next > reg->umax_value`,
>   if next tnum overshoots the reg->umax_value then only tnum_min is left.

The guard helps avoid the case where u64 and tnum have no intersection:
u64:  ---[xxxxxx]-----
tnum: x------------x-

The entire condition for "only overlap of tnum is with umin" needs to check=
 both
(1) if umin is a member of var_off
(2) if the next member of var_off after umin > umax.

> - Accidentally, it fixes the scx_cosmos regression
>   (probably, because first condition is relaxed).
>
> Wdyt?
