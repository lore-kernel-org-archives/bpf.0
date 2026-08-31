Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA53BCD05
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215797; cv=none; b=pPi73t9hwy27QeOf3GzR5a75wMm5KMvyF7DHKhgUiBVSQ+OWrrgxose4gdqq7FVImtAR1IQabNmzxQTVkt5ayrffwls3C6Ocd9voY36+6x1HYKeVfpdndkCbmWupd/jnnUalcgl9tE9et7GGYQ6SI6mzwOhv3ScuzivhpWRAXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215797; c=relaxed/simple;
	bh=6O8OuCBeivyB6CFTWozwRXPNIL4JE7QQre1b4cWNfvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ffQr/oRkZ13bPUT9pQhI2BYTa33cNCClcyy6LVJVnWffrpx9FzoeFv4Bmi0z8KtMvVYlZZeWvRDn5CcD7txZFa+rCUplhyfetB099C8/miS12DQt8qjAe7Zl28WSI9Tv3lp54GuTXjaKTKvx8FLVA4YXt+x8fUkwjhwkWlxrS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLa5CFn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLa5CFn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37D31F000E9;
	Mon, 31 Aug 2026 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215795;
	bh=L3LV5enZ40fi1DFZxZGwpDF2gFfSFvYJEnHxQTFw5/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLa5CFn9FSmie1UTkf0UxXd/vqj9nv6bo7qzVskDjA3vpkCNL8HuVp5OO3rX7zOft
	 XZibyHdKLueasMozc6YSBYNTLRHGORjmXgazG06kUQzM/UqFi9taGQASS9FoTwvy8I
	 6j4dxrinmHBPFy0/gtAfTuT0CH3n277e000POSe71OIZp3wj4gWVt8fJyVSzA4MYEt
	 sa8E6lKoiKcxPKkC3PJ8LXlXaTcsIT3TzNbxp1+g95Hmbft6c/dQd/d2FeAEIA+E8T
	 QAaswG9mfelzOu3cm7XXIuTl/IyTJfm5xSFwb2ft/TEQflgvWaklttC8CkAlWdpLlg
	 9OcxFhGybtdtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 06/16] asm-generic: barrier: Add
 smp_cond_load_acquire_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831202251.305046-7-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-7-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:36:35 +0000
Message-Id: <20260831223635.B37D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Multiple evaluation of the `ptr` macro argument in `smp_cond_loa=
d_acquire_timeout` on the timeout path.
--

commit c0f6b64c6c325f3292df62f7c1aed5d22469c935
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_acquire_timeout()

Add the acquire variant of smp_cond_load_relaxed_timeout().

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 8c37de1929443..8b166acfba123 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h

[ ... ]

> +#ifndef smp_cond_load_acquire_timeout
> +#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	VAL =3D smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
> +					     time_expr_ns,		\
> +					     timeout_ns);		\

[ ... ]

> +	if (cond_expr)							\
> +		smp_acquire__after_ctrl_dep();				\
> +	else								\
> +		VAL =3D smp_load_acquire(ptr);				\

[Severity: Medium]
Could this result in multiple evaluations of the ptr macro argument if the =
wait
condition times out?

If a caller passes an expression with side effects, such as *ptr++, the side
effect would execute when passed to smp_cond_load_relaxed_timeout, and then=
 a
second time on the timeout path when passed to smp_load_acquire(ptr). This
could potentially lead to incorrect state.

Other macros like smp_cond_load_relaxed explicitly cache ptr in a local __P=
TR
variable to prevent this issue. Would it be safer to cache ptr here as well?

> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831202251.3050=
46-1-ankur.a.arora@oracle.com?part=3D6
