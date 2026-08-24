Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95931331EBB
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610498; cv=none; b=WpMNM/CKDGoW1RDoaZXEdkXtTt4JUhIb/nWtwaR7ddBI1UkzXlKoSzAJv79jPspfwCFxmzse1VEd0ysqZglkpwKFEGzDy/efXT6v8PLaz8pIxjrAqUTudrwhEkbAulqpA6UYnS0UEScDqYhf6tlGbi8qaFLkNffb6WAZt2n2n4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610498; c=relaxed/simple;
	bh=8VzJMvnSTKNk21pifztw+psFE+uVHSzCn5s1TW6KEZw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CyLkVnHqFjcXACJavK10SsCrJDLR1ghHXhS2GaFZET5L/DhJhEq0DevV022UVj1egm32IkKu+VMQve1xV0ytKpkzmB/hCDJU/Elpu/Aum763R9rWviSgQqc/pZ/wQe48IkMfNU6jR3xWtuWgdLuM9Mp8VGloWeWlqJi0+XO+Ndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps/zmP6l; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps/zmP6l"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-382ef647e20so4362444a91.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787610497; x=1788215297; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8VzJMvnSTKNk21pifztw+psFE+uVHSzCn5s1TW6KEZw=;
        b=Ps/zmP6lE9Kl/EMgmtJ48fgpObAATtVROfwdm3pThKpLGqCO13qR6zI7l5mi/e1OaV
         m10QsperICpooFg5CBMNsm8BeQJIjTXdUdLBjPJPoBYnEvndBYwTgyR2DLcltI4PXmzc
         drowKuGgHlTtDRyOoH9UG6H9cr226hiafyMpnVCZ/H90IXK1NtLPWWU3pxSuwM+MhCqj
         joZN6aKvSG1FoArWhrr2KW5hOlGh3LUUDzrzAAl5RjwWIIxauCdFE1A8u6Ku7+UfnXV4
         /k6QF/c843H5PiOnACfbxxSe1ig97oHaDDqVrMTHaz+Jld/kYleQ7plypp6kgxvRj1Qe
         SJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787610497; x=1788215297;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8VzJMvnSTKNk21pifztw+psFE+uVHSzCn5s1TW6KEZw=;
        b=aENMEGZ7NGuttsj3MGyrdgorNfcTVG+83YZdWM/XXvXUV9B1m67YuFpHOH8FwKQMpa
         9O9AaLzUy1sy+LvrDOSr7tR1dHdmjy6PnQCvD1QMNu34Iku2uAMf/YbJ+rcwB8RMmfmE
         xcaIjMYSZaoiMDOaeLQlkgUPdEkJwbrfjOPa5LyWOZf/BBKGCOmJbqC0iYaZqWhdXs/X
         BCVEzYiSqWIqvzyTI8Cs5FoP68Bk0xDNFMSrGx8GV5i0i5iPKv3hbmMK7hmYj0EQpOBo
         hmy02A9KkbXsrx9edYW1TccHJYXRzHahNfX326ou8KFloyWyD/4zLPf1VlKAwHV1/1OP
         3tHA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+fZv4rYvyKgXknL1r3+xf8b7EBoe1Tf1nz4KPF4E0N2CzifcMbqyHvuhTdFyx1hWYVe0=@vger.kernel.org
X-Gm-Message-State: AFuF++kor7+lTazzDS69GHyIeHwIjdQD22+1rAH8JolFiVh458+4dpO8
	rkVaTk+soOLWAJz7tSKIW1+S5dwfwts3QvQAqLAr2NKp8ilzft5N6MJJ3WPeEw6C37M=
X-Gm-Gg: AR+sD13shg2v8/oxCcvrgFnIlK89kiehbkmMpo4AmneRvifNGSXOw91XDTjU9rVFYCP
	F8aZ/d3sDD8CPGQO66SJreaw2NnCXGJdrQCm2YZsk+zE/SAGqd+xkXmrS3JhBKWy4zbD9j2L0D9
	b3vCqFEW136hcVv59zZ7PuwZCj/1Row7l1HtmfYJFDKBm0D22/TaMY+GGI0S1vmbJCMOWfIjxOz
	tHjRoCwPLPjUOz6OK6arS7pqigKH5a+3aKPUjhhX8uxatyr1lburq2oR6O+sjN5LeeLx6ggdFKU
	bQv3ree2GqN6SeVDTCVzy3HzKkLfTYx7KWETnXSf5Fyj/TU1hkbNH0/9yN5wFAC+Eamly1n27qN
	e/ittlsY7U4l12doxFciFWbrJCv/exs7mDEIuZf1jqcF2SFbvqSK50KAr9A+dJglOuFkCayTBZo
	zK2+LB7j4Why0/Oxd06P7vDN02cfjaIfFoh4tGZlXb6/6vanm9Qgeaim+huyaq2ZQ6YvG2OIC09
	v+gyWbAWVqcvjtOyioeKmiJJkRvg04QEqIrtqr15t4hoA==
X-Received: by 2002:a17:90a:d605:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-395df5e8fefmr40933183a91.16.1787610496790;
        Mon, 24 Aug 2026 15:28:16 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm43996113c88.12.2026.08.24.15.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:28:16 -0700 (PDT)
Message-ID: <f48031ff6aa8c6f2f7e98e4111912050dc9c3fd6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/14] bpf: Split arena kfunc and struct_ops
 JIT capabilities
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Date: Mon, 24 Aug 2026 15:28:14 -0700
In-Reply-To: <20260821233516.3426127-2-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
	 <20260821233516.3426127-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-22 at 01:34 +0200, Kumar Kartikeya Dwivedi wrote:
> Arena pointer kfunc calls and struct_ops callbacks need different JIT
> support. The former rebases BPF arena offsets before a kfunc call, while
> the latter converts kernel pointers when an indirect trampoline builds a
> callback context.
>=20
> A single bpf_jit_supports_arena_args() hook forces an architecture to
> implement both paths at once. That ties bpf_arena_alloc_pages()
> conversion to struct_ops trampoline support and prevents the paths from
> being enabled and reviewed independently.
>=20
> Replace it with separate kfunc and struct_ops capability hooks. Make the
> verifier query the hook for the path it is checking, and have x86-64 and
> arm64 advertise both capabilities to preserve their current behavior.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

I see no particular reason for this split.
Don't see any guards in the generic or powerpc related code preventing
struct_ops programs from loading. Hence, I presume these are supported
by the arch. Why excluding the arch, given that all changes are
vibe-coded?
