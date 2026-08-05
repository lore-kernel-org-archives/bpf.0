Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73B21767D
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890462; cv=none; b=Zk0R1mS7L663HJb6Mog4TmV52hgmOsqPEA8QtAr8vZcGKgZv2BXH7Sd56KLCTIrlHVuwq8H+JDedThCJk2KlRFWfeNpOe/dJqfnhQk9uptNXhkzy7NgqsJftBGH0LoOTnRnOChzDSgys3CsW0MxOKGMOEmtTzi3W1sW3Jb7h8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890462; c=relaxed/simple;
	bh=3I0GZsmtmoZCxr2yVdC7wuLowqidv9uFhtVND1IZEeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZQbyhfs2/d+plXfCoTPHyECttKP378nNKoOVDIEovrsotkDklWABhvBF+9X0y4bX25TZX7WE4Aq7Yj5l3M5wPTKUV82y+3O6GmvyN6blNDpXs5/goKnt3a6gGptdIbBG2wNfwlB5o83aCZ/flIInCn4dQZ8IpQ4YfQQWVUGCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVKdU7uC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVKdU7uC"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38759bcd877so402656a91.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 17:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785890460; x=1786495260; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3I0GZsmtmoZCxr2yVdC7wuLowqidv9uFhtVND1IZEeU=;
        b=JVKdU7uCWNDw1AvhxglvZVfuKey/ScTH683Mtq5X74nYFZAcpa8hDJM6Dy2gQKBetp
         xscf+r7R0hpH8Ua9A6dCPaD8xRKSkX5JZU6k15iGJYxP90kigO6Kc2ied8AzP2T2jHW6
         Oy+ls4Cl10mofdbwwFJZ7eAnFBpjMwR7Nnh/KJCQmrJbdSYSTWWbV4QIZ8mBujwVqdTa
         vkTCkCLRrtQw/nOafoSxuPFgtE+hBpMGvDhCIcdk28JvaQcf/yTXgM9oIwbR2ee5kw7n
         3mXzBUDhD/YIpEMKPkF/X3LnyrUvQ+GR1M3/cl7iIp42I/qdQ4iQF84PPE100dEUAMnT
         /Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785890460; x=1786495260;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3I0GZsmtmoZCxr2yVdC7wuLowqidv9uFhtVND1IZEeU=;
        b=SFGEtI5Fap/9m28zQr+VxwhsHuqJwheOUVZPFy7O+gg3xr8M+vu33jCV9n7b1MDb9M
         0NZTC71YWO5/vwDRVNsp/pi5OcGW+1GY+/oWAYMNfhstMfZcfPFazxofiVKmgp9clAHu
         OGYJKytuuwoUOY8ac/l68hCqnERtKZ3/X0bVeVI6neL2hwKy04eNmJJe1549HOcsnQUE
         O5t/cMyoOK/ln35NN1US/lOaYbUuQtFodvmeHAibMgUDSx0oha93SIqu/X0ISdZvpTTO
         h2vpHrEydheHZWWcJ2AvRme6bEZ6hPZ5WJGBp7I3bx8/IFCvIC+rhOSNo4RujbzdH+KC
         kLPw==
X-Forwarded-Encrypted: i=1; AHgh+RoTfGh8L3imhp6nra9NTC+tPVM9mSGf3F5Eg5aIgfWtEOVewyX9EX5fcpr3bvVnvwcw5j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2NkUl5/I/VrLFC6VGWNkdatdLnn0z2DUeV9I7hBLL83LHVjC
	PtGzYnmWGp/+b+sSoCFy0fb64pT8GBZmQaB2QGUw45mvhkFp4l/ciGpu
X-Gm-Gg: AR+sD11cdLb8vudpS+2bnMqx2EtbznLHPUjASznaB0eQpHfTPr/wnBZVGEqoXr/bYdZ
	jkuMDJNqKhfR8aaLAYz8cMspdac8VTN/HMWZA0r/Dto8Zh8gnCAF6j54Gj5g0bsD9YdyaI1AjQP
	3V9OosQ20Kb+XLnkz7M4wqIFIWcnOgNhzB04V0uYCqJYjSi2spcs35uB3ux8AFmNjHy7jlXbeTS
	kyl4wl55OU18Pr1ZNAgovAyMopfOcMIcBTmgg0gObonFp2vARvbJxi9c6zFLymfya9r7Xc0JwYV
	Eu72CapS0OHIDouNgYBuB1NdMP9oI2Wwt8mDUb83YA1/ymOAzlmW8nVs+tkhCVBH6UXStxVjnA2
	0via6z8BnOHg56YhMLuU7nOKKWROg8ddhUH7IbVItCuAd+UYw1BsOAUfl0AD3KsAoRLBaYY4+dg
	gDniEVmDMrvqXzr0reE+LPovbZRnF53LBbZ+PR4AIM9vxVTyExrqUlzQCWxPjSpU//xY9HWJh5t
	3zqhCxp0aHHJq6l
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-3903c58bdd2mr2711096a91.11.1785890460273;
        Tue, 04 Aug 2026 17:41:00 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febe308dbsm2500876a91.0.2026.08.04.17.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 17:40:59 -0700 (PDT)
Message-ID: <12f6a14bf0302d8b50a13a4130d42fadd1ead0f7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] bpf, x86: JIT __arena kfunc argument
 rebasing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 17:40:56 -0700
In-Reply-To: <20260803125115.2264733-4-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
	 <20260803125115.2264733-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> Implement arena argument rebasing for kfunc calls on x86. R12 already
> holds kern_vm_start whenever the prog has an arena, so each tagged
> argument costs two instructions emitted right before the call:
>=20
> =C2=A0 movl %eN, %eN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* t=
runcate, clear the upper 32 bits */
> =C2=A0 addq %r12, %rN
>=20
> A nullable argument tests the truncated value and jumps over the add:
>=20
> =C2=A0 movl=C2=A0 %eN, %eN
> =C2=A0 testl %eN, %eN
> =C2=A0 jz=C2=A0=C2=A0=C2=A0 1f
> =C2=A0 addq=C2=A0 %r12, %rN
> 1:
>=20
> addq carries a REX prefix for every argument register and is always
> three bytes, so the jz displacement is constant. The sequence is native
> code generated after constant blinding has run on the BPF instruction
> stream, so blinding never sees the rebase and needs no special handling.
>=20
> bpf_jit_supports_arena_args() is not flipped yet; that happens when the
> struct_ops trampoline side is in place as well.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
