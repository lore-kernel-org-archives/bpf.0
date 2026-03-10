Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114283EAC82
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178130; cv=pass; b=HtCg+2h6lg1fNtLELKB4YMjkli2HR2Uyuxh4PINJzrxPuZmVDdhTpV9iKz7tzmVe/7ewa4riMOEKUoEPzMto5e5Tcs7l+sumKoBFjTcnxOrCVEPawZJZI/D0my7jiBv+bBugsMY1H2SfimW6Xik8PnrUW6y3pjX5hDC2rUgaIqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178130; c=relaxed/simple;
	bh=Bcu42IpU9LeHv30bZj0xvoUAV257BiREeFod9hqNOp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbJdGqpkI06Ch4UvvLRHCVLuN2i/hH259IVuRZRgurBEP/SHdSMrwF7WHuNBP5ijXO9iFqhfC7XdbNJ3bBjTpsyDkyMWoJwzgRwAoF4bHaKOpMZniOkBmffF+IBvJ8mPqNHbMmRxbEadsGOoBtdjlw1tBjbVM/kvZPABZ6rbheY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMXdH4+s; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMXdH4+s"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986e538decso130874397b3.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 14:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773178128; cv=none;
        d=google.com; s=arc-20240605;
        b=YWI1mb/7D9X4Xaq4mS7nETVXJam1JiJMxMGnynmp9KaN2r5xW7Yu8BtznUo5VGrvr+
         iy1iEkFQ4qyekpI9yCcKo98sNL9RGm3mkRXXGu2BmcFOcje7aFko3GGumY1EDjIEgbLE
         g6zpc6DfLwQnd8H20g88YsllSVixsF1gj94UdYHNgcO5IhYej883bjx6u7569gLvMDtL
         EFK4ERvTC0aF6PnViVoelcXrxjrjBHdX5DyUF7vDOjsGgUf1Wo/1drgFoBj2KAfyE560
         6YH9Zqr+p3+zRA08XkJzDLn8wunnw5N7IW/PrqFNzXQreyFF3xnwheL5QjEKHAbIbmvf
         X8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=66aRBVBbi4NkhhBmjNES8wN8TfBDY65T859SJlCfrbI=;
        fh=6mzBUIqY/8sgjA9Q3etLroAMdIZQQbTP6IP/1ObD1Go=;
        b=cg5GDfij326ZKJoh/t4ze2ccnjlIhKHEKIRIYCgLqRTIIMxody/J3Ghj7bjqY2sP9W
         Ynohi/W5g3bRHrmXGKnbEnmyySppluqwYMsQyO5saRLxmI7vM4Nh/Jb4FD21w0GEm6O2
         eL34/9Q9GlwnUmbtJXvuB/dNE1T7stknacGNoE6+NSKXGPCnmU8Sy2oE+KRyLGptNTp9
         cCzRxb6WWLFa478bcDD9qT74JKNvKgY+ZiOBuflsk1K7CyqvIOvrJXk2YXTFl5LNmLGH
         Ehk5wwJ3jUtnjWDv545fdhl906iyZEDLZJLtaPOg1gVH7bBzr8sPlRxu1IhFsTIUlQMx
         QIOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178128; x=1773782928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66aRBVBbi4NkhhBmjNES8wN8TfBDY65T859SJlCfrbI=;
        b=IMXdH4+sLWh8HOy1ZOF+0yLZGh6paXi3fyqYEKj1E/24/J5nZler9cNAgkkH0nYb/q
         zCN1FM1zXePJKcmhVTJdCS2z7Pwngpf90qRedZYVaalPAfAF4W3+XymuBZhDWjAfHPpW
         ibwOEqk2ieX/3HiT0d5G/H1V0GVC3GTIb8SdPgh+byBJDOJF3/g/Yg/OKinHN82R4bHn
         /zxNN5400esCo5OiFT505wa2uAIdYnCcSbX0PrHtEZ0Yg7FGrwKVhFLlAO0MW7ExytLl
         AwQoLrRfk8kxLp7GvMj6PmorVVRYhs2woNAiEkfPFAMcI3U7wdCTRgojyYByDJd335DM
         B+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178128; x=1773782928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66aRBVBbi4NkhhBmjNES8wN8TfBDY65T859SJlCfrbI=;
        b=TcsXyzkNJsZ54RQR2cA4dHIuX0wAcFwUCVJzh7D4PFZaRRGvjaCL5FPVPllk166IxK
         Ms416CQU5qX9DomShxS0XRT7PwR7Hbck/zdkfEIOzJlq31paz2ZmKD1DX7ieGgkAe2Ke
         dolLLxFF9ucdLCr/F1nuJpIAx2HiAuQU+9G/KYjLHdcqFwACuaLtfLguLh3W2uzEFZda
         4MuPLl4uveayOZH8KuQuemMZCIqZpLLcZpY/mAS9hC9VopUNCXletrLg2kFQW0ch0EqY
         f9jI4vlskP8ot/LTREielkED/tvsMjLGcvVrkQdvJ9+YrXlqNlnvMiBMnX/MWmTSI1Wd
         JLDw==
X-Gm-Message-State: AOJu0YzJbo9C9PFlHZj2Z8SNM4z0Ppyt/xkDRdRJEjeY2L8eOn455p+j
	LwvcHcGLIScaDEBMV4d6aVBcKt3ldo4xvw0zaQCsiMI2iWY1ZVz//EnpzCLWfdCsfzD8Zd9a84q
	H56YYZXwZ5RmWoChQZyHU0HjTy85Q9Go=
X-Gm-Gg: ATEYQzwKdt8/Qm7c0QyH9pAIESJvIuoRleJnHeIYkmE0NoJtzfBOnZNif8f/iYVQ+QA
	geqYBWCHNxEi9+iSfNJlu9vAh/8fAuqlFUI2+cmOoUoBCn3VE/Np44SMBAx3w7onIlAyglEeD5K
	XDc0jNa9VUJYTbVPwbZ4kr2GNhUPKtEX3bwVj3uf1cH4iJPzVGUSL11VycWo4OcW7kWBmBWz8kz
	XuXgl0k8bToo6AiTwmFtFnY+sfH1wcx5DkaVBXaMVT1hJYQ7sL5R1ky5i6+XVy4KPtMOolfdY7/
	i+L0/D4dolRr7hot94VHXBk=
X-Received: by 2002:a05:690c:38b:b0:798:1e2:cd3f with SMTP id
 00721157ae682-7991800fe7dmr1706787b3.59.1773178127859; Tue, 10 Mar 2026
 14:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310133504.94871-1-danjwade95@gmail.com>
In-Reply-To: <20260310133504.94871-1-danjwade95@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 10 Mar 2026 14:28:37 -0700
X-Gm-Features: AaiRm52tUdLmN2y3BS1nhP8ieIo3EASZy5NDgK-rZ7jw221VfCNTT0YQTdh8vlg
Message-ID: <CAMB2axMNzeyNwiYUbTnAY2jpPXoahT36u1qt3u7cCpTryGqgPg@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] bpf: Fix unsound scalar forking for BPF_OR
To: Daniel Wade <danjwade95@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 7:43=E2=80=AFAM Daniel Wade <danjwade95@gmail.com> =
wrote:
>
> maybe_fork_scalars() unconditionally sets the pushed path dst register
> to 0 for both BPF_AND and BPF_OR.  For AND this is correct (0 & K =3D=3D =
0),
> but for OR it is wrong (0 | K =3D=3D K, not 0).  This causes the verifier=
 to
> track an incorrect value on the pushed path, leading to a verifier/runtim=
e
> divergence that allows out-of-bounds map value access.
>
> Patch 1 fixes the bug by passing the opcode into maybe_fork_scalars() so
> it sets the pushed value to K for BPF_OR, and 0 for BPF_AND.
>
> Patch 2 adds three selftests to verifier_bounds.c exercising the fix.
>
> Daniel Wade (2):
>   bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
>   selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling
>

The fix and selftest make sense to me. To observe it, I also
vibe-coded a poc to lookup an array map element and OOB write to
another element and confirm the issue.

May be missing a fix tag though:
commit bffacdb80b93 ("bpf: Recognize special arithmetic shift in the verifi=
er")

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>  kernel/bpf/verifier.c                         |  15 ++-
>  .../selftests/bpf/progs/verifier_bounds.c     | 102 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 5 deletions(-)
>
> --
> 2.43.0
>
>
