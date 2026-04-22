Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB23603E8
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874430; cv=pass; b=JK3T/Y6n1IVNlnoqHSJeak05sMozc3FKaQQVDCnZBWuLqHngdKclAEsHSrwFmGuTxwupQpenFMfCM7jm9VkAekRS6S9/lVfu73q5dGp4mEWVUdNtZSMYqJUk/xO9vAaYTmgUzNQE7v460sSUHfI68rmSep35yQH5guJ0zg/qZa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874430; c=relaxed/simple;
	bh=LORmgdAReT+mokbuE0gTxYvSml7bURpH6zpOr7+ORsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRkfnBFUSRWTVAB9FyZVgefbgthtn6tXZV1Zh1xQBGIEfYCzgxi5yjUd5RlU/ohIMCUjl49iIoetqoweJ3wlOMRaECArFeHlwKhLVZXoWWLhj9bYL/FglfLC3thUYcSgAB6IjTGnCYBl3rS5/NyvGGf/l52OQCj361j2A0ZYIR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLXk8PVH; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLXk8PVH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d77f60944so4591759f8f.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 09:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776874426; cv=none;
        d=google.com; s=arc-20240605;
        b=JCaGAwY/IQ95K7+2c7mFMCYtYrGXikUoAACTT2G8FboFC0RnIUyCtDGeWBjSiAJgzZ
         b3CSSA7kl5LMWt4oY35ni5yO4hB8QDTPBz7yGRy5R3aXS3SmGEqZbyLozg/y9RPacca0
         u6dew9zAzZQknd6ab/Awgt0MVJQF/vM6H2MqDOTgRdeCviiiEDMxMjn2Y7qCFl2KXKxT
         DxZJyHAEs/NrCEgl2KCKQ0fWyXs020DEr4jo4yNZZTNyIJ7+VpA+r+BxLZx2HhAeuqrO
         i8GyCDDzYZA6Mad8ZUfTuRIauSfvcSq/5ZRk3lDxk25W4d85ves49mUvOg2NjcwufRf4
         ARsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2I6BWuaAak/FYLuqDiE5JKYm165VwFYWS8iIDoHpVKg=;
        fh=Jvk0Tabz7GR6yXw/8iX+Ef9oAyhmE8EGYCLDlRFBSmg=;
        b=LG+qsfeeebI/kAw9rywA1r1csWPEbJTW3rYG/f28lp6x7i5jYL6xryRj+nWrp6revC
         XaeJziV2psX8Rc2KQCxYl/MJwd4Mm9jIfergS7hAHBbpC5qUyIgldr0yz20DkKWRXCnY
         7yB4sw5xxIVZHRSMfm29U4/f0szrQTi+tVOcY+Pq5IL8Z4oBs+CTUxBzcEcHpsxlQrpi
         hCMMSR9y+wF0Dgm9VQkchUWD6Nqd0Tv4XxPBtwJGs0Jxyeo3ruSLCekxOFIKrZrhXXPE
         bLeHmKZ9vNTqD2THPiBDqa/JigJ49gjp6Oa6Vo8wN97zHiqKKU1b7EysjyNf68I/LHOI
         4RXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776874426; x=1777479226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I6BWuaAak/FYLuqDiE5JKYm165VwFYWS8iIDoHpVKg=;
        b=pLXk8PVHJPqmx+ZPg+ff4nYhbLNecrUEQahUEFCID+LeWKlLKe+RqbDknQLdSW1we3
         zgnT9GYkq0mehMpP1y7MV8QSuvrjEXaxrr0Q9Q78fTI07KQWdFaDDyTxZkEhdzlFzoYU
         rJkXZYYirwt5B7/J+nxB/ilcM1jf+2GX6eiv373lr+YmYYYhaJVKGWkyHbX+OafMJssX
         fKDNLW7/hBOhvHywJj78k2iJjFjGokBZRnNr+T/gPnTkBhfCaBxOwZgAuFadqsyK4RFe
         8JRiWfMj11DDD2IDHB9pDE46Tc4uLzYNiSlS7EiwwxCsWxsoaKuk4Ip609U4pGHqGb9L
         YyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874426; x=1777479226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2I6BWuaAak/FYLuqDiE5JKYm165VwFYWS8iIDoHpVKg=;
        b=bDQ45ozDl7wHKf5+cmFWNYtFdcDneHd8CioUXNIB1InwgJJLJcSuikoz3A7ZxbDVnX
         Jr4F1uaFSmIG745U9T9UZTlOkiODYTd15mJ18rLnXZHmxSal0JWHVpIe5aVwc/CCe1cZ
         cskQOpPt1E31Ogx519qo/oBDJEWa5bLZ4Oh4C6tZSZe3enMEGMYFRKhMFfEmTF8WgRHC
         oigOvosddDpqQZBWOWjj2elfEZJTrIbkcVvbwD/QjVIeEm1KDXcipvWZPa6hsIJiBxNs
         rWZpBw4Zvhd2D2aY0gGzLZxOsZPQ2eOXtNPwW3D4KVMEeqyfXQAEsCgxPFGObLEpWV1K
         52FQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OgbIELq6/z5B7BvsRHvTFwtm7GT+JWK2uB9jogEWZHMRrnj4/H39qZJMoNwkm5aZymLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGf8ETNF4geucBGdF8fg9RrnwYYPLEVyWdyHuGPmAYJFmBzml
	CubRETlducQpQrcYO93Z0JGZhyc+nr5pSb1nBhIqWkzAlk6BFFM+wy2F+o0/rOuNcQHF9RkcTRL
	xTdAyWTBZF+lAb7BSHtj5+dth9W+eOCo=
X-Gm-Gg: AeBDies7YjV3ysozPaZFrKJ9Qt1re3pijjFcQOxxE8CqSHGONtXzrPmqjDE8pcODojV
	UpVEM1hu5z/fN5sYIVB//7UFSFbwiiBEryVgiYEYVfv/Nz2/eIPXpEZjTFA5kivC+k0rVB8XLgZ
	Hqaf2SQy2p4a3Z6fDbuCUlfFrSxhZ78Z7XPrt5yUa0wvj3mTsUVj70qvrEqa4I4bPzvPCa/FPlt
	yS4YRlkJw+lr0Ri5rXmagpm9xF/XKnFwyR7CWkE54jPOK6YSCPHs+4mhgxvYM8/QFbuVHii8Uxb
	tUipxAcoevzdne1p/V1ah0G5MAppnIql3jA44ziPOEXKfHIy1a0BteHGo9K9n4W4S2gPAB4+GmL
	JrvleJYwN32uMKgx1ojWvmxPDFqtP5fAcIbO8
X-Received: by 2002:a05:6000:1869:b0:43b:6a16:17e with SMTP id
 ffacd0b85a97d-43fe3dd4f06mr36807354f8f.11.1776874425756; Wed, 22 Apr 2026
 09:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
 <9d47111a-61c8-491b-8750-63fb79968125@zju.edu.cn> <DHZRWV9NZOPX.1PD401F76IUT9@gmail.com>
 <7a7f3455-3cb2-42a8-a1a1-47ba40ee1a2f@zju.edu.cn>
In-Reply-To: <7a7f3455-3cb2-42a8-a1a1-47ba40ee1a2f@zju.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Apr 2026 09:13:32 -0700
X-Gm-Features: AQROBzDwBXJJcJboYgIa6etFv-gN_fgusDT7-utwYzZc5m6NzNITOTRYKj6-n1E
Message-ID: <CAADnVQ+2O2zgdy11+vxE6dOp+3Br4zZBysHF-Hne7cP+eeucnQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with struct cnum{32,64}
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Shenghao Yuan <shenghaoyuan0928@163.com>, Tianci Cao <ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 8:32=E2=80=AFAM Yazhou Tang <tangyazhou@zju.edu.cn>=
 wrote:
>
> Hi Alexei,
>
> Thanks for the quick response!
>
> On 4/22/26 11:03 PM, Alexei Starovoitov wrote:
> > On Wed Apr 22, 2026 at 7:50 AM PDT, Yazhou Tang wrote:
> >> This was built for potential integration into Solana BPF and is
> >
> > we were thinking about adding these insns as well
> >
> > uhmul64_imm   dst =3D ((u128)dst * (u128)imm)>>64       0x77    BPF_PQR=
 BPF_UHMUL | BPF_K       v2
> > uhmul64_reg   dst =3D ((u128)dst * (u128)src)>>64       0x7f    BPF_PQR=
 BPF_UHMUL | BPF_X       v2
> > shmul64_imm   dst =3D ((i128)dst * (i128)imm)>>64       0x87    BPF_PQR=
 BPF_SHMUL | BPF_K       v2
> > shmul64_reg   dst =3D ((i128)dst * (i128)src)>>64       0x8f    BPF_PQR=
 BPF_SHMUL | BPF_X       v2
> >
> > if you have kernel patches for that please share.
>
> We haven't implemented the interpreter and JIT backends for these
> new uhmul64 and shmul64 instructions yet. However, we are actually
> very familiar with these specific high-half multiplication
> instructions, as they are already implemented in Solana BPF
> (which we work closely with).
>
> We would absolutely love to take this on for the Linux kernel.
> We can prepare the implementation across several RFC patchsets,
> which will include:
>
> 1. Verifier: The value analysis for these new uhmul/shmul instructions
>     using tnum and the upcoming cnum, backed by our formal proofs.
> 2. Interpreter: The core implementation in kernel/bpf/core.c for
>     these 4 instructions.
> 3. JIT support starting with x86_64 (and subsequently arm64, etc.).
>
> (Note: We assume the LLVM frontend/backend support for emitting
> these instructions might be handled separately, but we are happy
> to provide the kernel-side implementation first).
>
> For the initial RFC, we plan to focus on the first two parts
> (the Interpreter and Verifier semantics) to establish the groundwork.

We need to see end-to-end first. Which means LLVM + x86 JIT.
You can skip the interpreter completely.
The verifier needs to check safety of the operations,
but updates to cnum/tnum should be conservative. Just mark as unbounded.
No need for formal proofs or cnum work.
