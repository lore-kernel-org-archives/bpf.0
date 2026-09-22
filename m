Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00A5218A6
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790114045; cv=none; b=jPEcytwmPExrmjpzK91oX10FEScSh/4iG4Lx/1fi4/OWWnyFUBJ948AP0Ol6ZSJGrsZ+I4AY9sfMgXautyjVWul27bCxVvYasje4Xx1W3xaHe4WAZBwcCt7ItpiHpUqBPdhXPPRt8q5QBTdmleoHv+fV+VPnX8W8W+wxTBQHd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790114045; c=relaxed/simple;
	bh=6agiVoUWwu9xPdoyi7CbfgPwDllSS3vFZeIqwXzSC9A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sT3bhuoN/N3COb9NexRGp+nz4LRI3M+VGMMZEKtRaTCsQhpEERV0LmHF+eBuwESVqMllki4W9elDB+DaUt56V/MjbOQZMRCo9B03ljWJexl2WRPxFBLyeJe1QxA2Dg4TMQsX7+6MvWp8W00bkDXe3iK7QQazbErZ1BXaiBMtnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge1eGmB2; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge1eGmB2"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33b9e805130so197056eec.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790114036; x=1790718836; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=85qfurcOYa6BQRZ0sGXorad9IsOudTmmY4ZJjJsedG0=;
        b=Ge1eGmB2l1TJ9OFuAx3ThuYfpod8cX/MuVz2CpwsWhH69QcZ4p+6Ywb6T9AWK00q8U
         /ueYmtk9Bj1eUEVV1yDHwfZmA6genxje+xHgWZbope+CKPyh3ybqvQ1YUKa4fAPy4Bhz
         AWrHqSBjM/WaoTHsNz9+oNPx8i+qUrQFsv2PRtyRIP70cgq6o0wIk5urLP7fQTctelSF
         vyZduxfp11oL2bw5bX9UI5ve6EKb8WkSEXkflPGAg6l/x8RqHXconByMy2or+ewFAw3v
         XHIjWupTZO0DvXGUv9VzcxGkNohy1w/fPMXiNYalVa3dePkDde4YhVTtjKCOg4Oef2DU
         x/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790114036; x=1790718836;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=85qfurcOYa6BQRZ0sGXorad9IsOudTmmY4ZJjJsedG0=;
        b=QYVeYlUi+FkB2Yf19b6tuMsF5xWiZ9AoB9QgfxEov4GgCghopJG4QqcE+pvDLesIKt
         ink8YggNl8nPQouzFk9VnWHzlkn114WMrQahdcyQJ7EarzwNer0GSa0+K/5hO+VF3Hb9
         qovFZog8Qc9OpoECGsgUrxJ0TYLvrFbRsIzD0o7Kb9OYZQgPxuO1eVyOJs5WzlUrl//+
         IdPgU7rFIBtOP5V57T1BQhU4F1FX9qIpIoxU18dhXIB0fb5mCzUa0LeXmf2BrLq+xr4H
         CHbrZoWo2THl7ODE7mOh6otEjA8eVjHUDyYytNU78L1UdTHLKgOgrmehc3gbJxovzKf8
         gl2A==
X-Forwarded-Encrypted: i=1; AKwUvBzcmb+pozvzehAB9MxozogKbx/N0bZV7pAWf057PYHk6FfA8oOsLicudWPWJZXVULkcWo0=@vger.kernel.org
X-Gm-Message-State: AFuF++kGmLzG6djlgVcGuRKlUkJmhwPi2Dse7GGg0RHzhUkSQ+W4BaUV
	zNTkG8QDOo8ZmylaPuS3bykMPKopm+Lh+38RObqxyNXfvuzOj9APmSf+
X-Gm-Gg: AYBFou1Ragf2GVwvMi5BP995pHESlOAVyu4Te0rTurFnRJaNrkXsLg+t8doEwn5D0wU
	V1As5gtEHZedj/KypIar2AeFz97+29pAAZMsrtp1c+ChCgTwkEuLY216jKDSvn4fgVdH9AvUl+N
	yT4cQoRZpzw44ezKAUtgIv3EcG5j5xruTUi/HZ3/IANdzE/wGCr7zQSKpgvf9BN7V3TimNoEVPS
	VG78fJCAVQlCys0uZ+4D5kXWEwMPkgkHogLeIA/OckIRdHBeroaTdB08txhrz/SH/tNDZulf2NA
	AIplTTWTaWYgIzRUNz8BMumR5FpPTKcQcfLu8Ae/D1LlAzVW5YmllJ33y6IaY3KSyee9zGPQxsr
	Dr3fquF1vZxA8E94IfI2ne54ArkZ9ZrRcwpaEZJLqWQfo7p7sYSEHHpAbID1eiLyuj6hoJQz+pk
	YYVLNR0vB0+EpmMDQCaqBO4Sa7HnPWevHXtr+4Eo2aTDGcdqzP2aqAqO90QZDrUhXuZti3D2LYF
	uZqEzagQGwlZn1HgoJ2ZJkU589pFz1hYFihvNjWt+X+rgJgONUI/D8X904kqXKIdrd4
X-Received: by 2002:a05:7300:da0f:b0:33e:6bd8:8f1a with SMTP id 5a478bee46e88-33e88c2ad8cmr517918eec.0.1790114036439;
        Tue, 22 Sep 2026 14:53:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f4d5:5623:3480:5143? ([2620:10d:c090:500::7:fbb7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96358e2bsm959503eec.16.2026.09.22.14.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:53:56 -0700 (PDT)
Message-ID: <e896db69276278e0053adaff941ae8c78eac1e78.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 08/20] bpf: Walk the exception unwind in the
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 22 Sep 2026 14:53:54 -0700
In-Reply-To: <fb67e32a-6215-4695-8003-7cfcfba2ac50@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <20260921210114.1720196-1-yonghong.song@linux.dev>
	 <DLLJT7NBMC67.1MIBGY9CC99CA@gmail.com>
	 <fb67e32a-6215-4695-8003-7cfcfba2ac50@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 22:25 -0700, Yonghong Song wrote:
>=20
> On 9/21/26 9:08 PM, Alexei Starovoitov wrote:
> > On Mon Sep 21, 2026 at 9:01 PM UTC, Yonghong Song wrote:
> > > --- /dev/null
> > > +++ b/include/linux/bpf_cleanup_abi.h
> > > @@ -0,0 +1,16 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> > > +#ifndef _LINUX_BPF_CLEANUP_ABI_H
> > > +#define _LINUX_BPF_CLEANUP_ABI_H
> > > +
> > > +/*
> > > + * Value arch_bpf_run_cleanup_pad() leaves in r0 on the way into a l=
anding pad.
> > > + * It has to be a constant the verifier knows: LLVM names r0 as both=
 the
> > > + * exception pointer and the exception selector register, so every p=
ad reads it
> > > + * before anything else and is free to store what it read. It gets a=
 header of
> > > + * its own because the two sides that have to agree on it are the ve=
rifier and
> > > + * the arch dispatchers, which are assembly.
> > > + */
> > > +#define BPF_PAD_ENTRY_R0	1
> > > +
> > > +#endif /* _LINUX_BPF_CLEANUP_ABI_H */
> > I'm not going to read the AI reasons in commit log that it came up with
> > to justify new .h.
> > I bet it doesn't need new .h. If it does, please spell it out with huma=
n voice.
> > And, in general, pls tell AI to be terse. and remember it forever.
> >=20
> > I told my clanker to be like me. Terse and to the point.
>=20
> Okay,=C2=A0I added this file to be shared in x86/net/bpf_cleanup_pad.S,
> arm64/net/bpf_cleanup_pad.S and verifier.c.  Yes, we can remove it
> with single line comment in their respective files.
>=20

As far as I understand BPF_PAD_ENTRY_R0 is not needed at all.
As the value is unused the jits can zero out R0 upon landing
pad entry from throw or resume, verifier can initialize R0 as
an unknown scalar: mark_reg_unknown(env, frame->regs, BPF_REG_0).
