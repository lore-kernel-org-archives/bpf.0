Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACC4035C5
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365147; cv=pass; b=nN8g2AJXToBmpvb1bmm7yv/lSxQ65gGDv408cfRJTfG47cHe4bTDBy6EJcAhVmM042Lyg31ZxN7EONUCVzRZtMeZVf2ehDsT3d77/YgWNwvPSPdgeSMlQk2QJNWc1L3mUeR/BRsA1ZxGlYo9GHsTf013TwWyftixMcYN9M92UWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365147; c=relaxed/simple;
	bh=DkvA0f0R1I6yYwVuzVRz3vdcNRxquFRNpQPJVodbTWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxaBAhoAQ6/O1/Ba29fnitCduC/igOjqzIn0QIyBwla1WzN1JOSOP1QwCsMJeR1DkYf7vZYLvbeA1f0QeJp+v/LirgUzrgfFRO73j2rS+0hFW/TuC5bEfUQZx7lzGCWnjX6d49opMUR5sOW0njcBO7ZLhu2eWkNKCB0sLqAh3AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7rIUCpN; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7rIUCpN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486b9675d36so45279505e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 08:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774365144; cv=none;
        d=google.com; s=arc-20240605;
        b=UQFjSZN50R8hPYGuk06qOwbZ80Mtj2DU5F7ESE9Tp/8zLjnRANPZsGt1jTMkxWwuIM
         569oMzf7wFRquoKPPsC0ZVa6CKKLhraSKtHX5M5m5EaQDLd7/4fwgLGXIaGMxJ7+9H3W
         JxVkOuYCADsnr1hrRwPtWJkPxJKP3hyeGZ54C+BsHX/Frx5hjOI9/FMq63uOeGG/7lru
         ZNEw1yDNoKGvTFGNipfZ+WqT4MLdc6KILt9D7Mk3lqeQTjWyfnjDnrmwNT3Dge+jJPsg
         ByqYnQ0D7jbqMCYL706Ni1Ec6ma/BZaoTz7FEEBvO+jr2iABRPPyzZHHI7HEjaMcowfU
         Ny1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DkvA0f0R1I6yYwVuzVRz3vdcNRxquFRNpQPJVodbTWs=;
        fh=+Ye7PNq5/tUUZoXG/RFo+FtmHRPIBTLHKtU6eKp9jew=;
        b=NY+1TKFK6JHmit1RQKIU8AHD0o16EKvBg0Z+lPYXfQu3UaBQxYDkTaKPx/RB8xRjgO
         K3BO3NVZMui84V474ybQ66OuwWNyE4lVJR4qNDGCAm3PTe7xCVo5bLvWmyOdOkCVmZQ3
         U7DXzTTOqO2umfQvUoVIjL6QtNjMSjzYz/7h4et2hyAqdwZqDD/DjoL0ClXmtWBZRrs2
         vHXnnKsb4nhczOsMYW4w7rxAApS0pTROIgGSTU6DRIGwP17RMzkwGFp4qA9lNJV9oevl
         aDvYcL3wczGHSkVUw8GSg5NKDRi/gUezpXkQSa+vX86r8JdYYeMdNTRm/m9S2uBt0bcu
         tHpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774365144; x=1774969944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkvA0f0R1I6yYwVuzVRz3vdcNRxquFRNpQPJVodbTWs=;
        b=g7rIUCpN58WhowYUjDPPlmNqt+6u6uR+cqQJIMUf56KJgn5f8cuIIPmFBTBWKMTk9o
         H8KFVnOV8gxYeX8cDgg2YgY2k0QGTPFci0+HeL0H7e82neTkmdFSRoAbNixhx4+5+eXa
         QAQguesxRw8k7uueqqu0EE4JtAdpfCv4iW0Suu6JKZrZUSVxzkVyZaEhE+gfpF533mpo
         Xjc9dOz//GKSYX8Az2wVsz5fcy+erS6XfYpukMtwPtka6Ot/iZYFlTMK3363cjFH1XFf
         1+RrJXZyDr18iLZDBMAfjbZDeIUR5ulRj3OCsWLJAZ3RXQf/MHxrHS/ob3ZRlXT0d32t
         E+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365144; x=1774969944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkvA0f0R1I6yYwVuzVRz3vdcNRxquFRNpQPJVodbTWs=;
        b=CtUmAePn9hcTS3ZYPfJiJX1kPxQSHxBOLvtWVN/XHOItsg1D1w7vqYCd2vSjfzYFAz
         tV09u4pEPY4jOZqLk9gf21O+BIltRgqao55pbKFEc9RgQvTeaD25Ygqb8j5iJUFClfnI
         BdPLENcWjXvUOHBMuRshPznt49izo5RAqvs5NdVsjnE46/Hym6osQQTcQVOPtDgnQ+oW
         KdY/R9PMeLnOjRGYFsA7xYfwXF/XM9anh7IOg+A1EUo7vDLTKuduxtpmc+YM7Q5GkAen
         5B7u3ujilYh/1OsVchYZzWUB1YXkrwHv/+yF/Pdtn+PRGrbYpzBhQpMZQSTWIVAO57VT
         RfbA==
X-Forwarded-Encrypted: i=1; AJvYcCUE3+bEBane7kGiuNddjZTWz15tXzDGtqvgyp7BMizMaxvZxGquuwGDNM36A4CSY4RgVDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwlP1mc57P2uSyVHee1KEmCa9NVLkVTOuYG2myT1mwVInTG3G
	xck3avZgjnOWvDzpiKE+zWFIKhEObI7hNTRjpzDTPDWLXg47VBoaL5CCK1T3RaXezwCWXvitybS
	y3/LuOrF5lJXN+d91xttdgVqg579FmJzyIw==
X-Gm-Gg: ATEYQzyS3kqSSQ91YM1yVrDve9U85ulgwfUsF/PjYSSL493pcWfodRe26F/M7vkUU8m
	CWflM2cCK4CIMoBz+Nzqv9BPOdwZ5mJwEXmwGpSqBSY+BLrIVlIJQ9L60MviGPCi30g2UUm2K6O
	3RHVmOJD6ZL2yhASJEMrrdudyWmTfp4oakRVpVEiSI+GzztBCuh29TvbdABVtZYxcJvJh2X8xwV
	UdUuvThN2sEL8fkYXGr+yIAVe+XS64m7N+7tZeSJPUnkLvfxbjemzVaRAaSNu/1x8VYv/3U2q/F
	W2OVzicE92QkEyrfwQvZ0ZKZpPEFDxjOgA3BCtGwbcHdAhkuaMLS/KAfiVycDpxEQZNrtn9EZ1C
	5vfhSfVnMIgWU4b1dXviHHM/dXQ==
X-Received: by 2002:a05:600c:1d02:b0:487:716:2fa2 with SMTP id
 5b1f17b1804b1-48716039accmr1663945e9.16.1774365144110; Tue, 24 Mar 2026
 08:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324062028.2479059-1-suzhidao@xiaomi.com>
In-Reply-To: <20260324062028.2479059-1-suzhidao@xiaomi.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 08:12:12 -0700
X-Gm-Features: AQROBzAeVSzmHwocMIzC_T43SeE5ZYGvZMyy7DiwYCSIR-IJMsc074leAglTCeM
Message-ID: <CAADnVQLbtuD=7mtGZFR25ULhjZ-3ifBpkyRcqu9jPSd2Mt3fBw@mail.gmail.com>
Subject: Re: [PATCH] docs: Document pahole v1.26 requirement for
 KF_IMPLICIT_ARGS kfuncs
To: zhidao su <soolaugust@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, zhidao su <suzhidao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:22=E2=80=AFPM zhidao su <soolaugust@gmail.com> w=
rote:
>
> Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole
> v1.26 or later. Without it, such kfuncs have incorrect BTF prototypes in
> vmlinux, causing BPF programs to fail with 'func_proto incompatible with
> vmlinux' error.
>
> This affects all sched_ext kfuncs (e.g. scx_bpf_create_dsq,
> scx_bpf_dispatch) and other KF_IMPLICIT_ARGS kfuncs across the kernel.
> Ubuntu 24.04 LTS ships pahole v1.25 by default, causing 23/30 sched_ext
> selftests to fail on affected systems.

I don't think that's true.
At least when implicit args were designed the goal was to avoid
pahole dependencies.

Please share exact steps to reproduce.

Updating doc is definitely not an answer.

pw-bot: cr
