Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D6B672
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293587; cv=none; b=YYPxEhoScyqLiyT0MaK+BUiiRP1mOFVEiqTCwc07rzVuMKUpBqcjdgDQDPUg98OhmtTL2mLYjtYb4o6FcOOpuMFi3D2l7RTGJ6QvX4GlNDK2lgeSFWpTKW8BqzcX+UEOJN6mUR8eIE0fn7UdPX3FUsLwfb+cg4Jy4e9Gxx4kXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293587; c=relaxed/simple;
	bh=v5ZiX4Wa0NQ2seGZ7SYH/er7EbvtBgsOyT5Z+fGVwBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ineRq8Ekbyht22Z6icVcqx4ceH+xBGrad+WRdDDyo7SbhWt+WKGKN8Saigqv8lVQy/+ybD0KqxoqQT2ih5ZVLXQJlefsrWzg4jfftXCQvowQO6FmB3XwIWcIValeCsaxAS/5kNN2BrLpxxClcxEU2FYPi8D+GnGqGhUpPZbzayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjNm8pPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjNm8pPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E6C1F000E9;
	Wed, 20 May 2026 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779293585;
	bh=Gzo8MWtZayIbYXrKtl8Bl1EClmz1acrSkMyluDROIUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CjNm8pPxxV86E1fPZ0FUPCB8L0A9Ur9jt9lAe//Prs5s3DV9GqRuvL5ougICJvOGt
	 W2AYhTxAew+9U7WsXWtnRpXEmuq9JVS4ajmy8WTvwukY3xblw5/FqV3uhQ7LGLDIzK
	 vCz+akhDKAarhUvsvUss8SKeZ9ctWHxB+LQyahFX7wWgGeC1mIi2JNe+Qhjay0ODd7
	 Dj3QMpWAohqna3EwMLPx0C8qymuF/JPzZq0i+KMTIKWMvtjZ9n/DOtENl29KUV4Ktz
	 9XyiAIw6SsT7xus9iG0iKri5zTsY240D6YNzOzIORqfYwvzyp2qojxHdg+ra8uxKby
	 RpjHczPha2wUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 04/20] x86/uaccess: Add unsafe_copy_from_user()
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-5-jremus@linux.ibm.com>
References: <20260520154004.3845823-5-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:13:05 +0000
Message-Id: <20260520161305.A5E6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The macros `unsafe_copy_to_user` and `unsafe_copy_from_user` use=
 generic local variable names (`__dst`, `__src`, `__len`), creating a varia=
ble shadowing vulnerability.
--

commit 32beb94b1b6090052c09ccb07d8ccb9ac95181a6
Author: Josh Poimboeuf <jpoimboe@kernel.org>

x86/uaccess: Add unsafe_copy_from_user() implementation

This commit adds an x86 implementation for unsafe_copy_from_user() that
matches the existing unsafe_copy_to_user() design, and refactors both=20
macros to use shared looping logic.

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h

[ ... ]

> -#define unsafe_copy_to_user(_dst,_src,_len,label)			\
> -do {									\
> -	char __user *__ucu_dst =3D (_dst);				\
> -	const char *__ucu_src =3D (_src);					\
> -	size_t __ucu_len =3D (_len);					\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> +#define unsafe_copy_to_user(_dst, _src, _len, label)				\
> +do {										\
> +	void __user *__dst =3D (_dst);						\
> +	const void *__src =3D (_src);						\
> +	size_t __len =3D (_len);							\

[Severity: Medium]
Could these generic local variable names (__dst, __src, __len) cause a=20
variable shadowing regression?=20

If a caller passes an argument with one of these exact names (such as __len=
),
the macro's local declaration would initialize itself with its own uninitia=
lized
stack value rather than the caller's value.=20

The previous implementation avoided this trap by using uniquely prefixed=20
variables like __ucu_len. Is it possible to use similar prefixed variable=20
names for the new macros?

> +	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);		\
> +} while (0)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D4
