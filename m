Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AB352022
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294108; cv=none; b=MnYUJ1UzFK581GhpIf4r16cv9bKCeIUR0F+O+8EO1s5rNaCAoWCxs5gDAgiLW8k5a244XMe22s+gIwBrH5ZHw1fpRVGqaic3/XdofQws5EoA9hwVXG6evaqNCnmzWpl7SBsxZ2XSJEYAhrPGaUQ6wOdz44d1NsK1oU+AQtVSdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294108; c=relaxed/simple;
	bh=ele0Erir9bg46kU9P5BQZQbbtVcHRSMwkSF4F/9AxH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UCZsjR1RkDp0lWc+T8MoKk7RE4FJRSmFyqGs65g/9VRFyVSxmp6UcH0c2JtR1sRz13lVGYgrTQkOaaNG2WrmpRhGNSAcfx8FlL0FU9z3Q5jET1IYmrQex86uimuAMcJpJdFe/Pt/woeQb0IKKrKg+3TfmthwT7eJp1nDxkciMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5ekrtJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5ekrtJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195FA1F000E9;
	Wed, 20 May 2026 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294107;
	bh=PS84uHqChHRlPMtjxlJv7OBdy8zHqsxYemvSs5wZxho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E5ekrtJEDLGv91R+j8t0pVQaK/0Vn2bgeG75J6u/clbmtwza9yK+TRlXG9rf9msrq
	 vRxqBuhJ1BnOGY5OF+0Nj+OWz237nuIfA15HK3QW42gXBzNETx2UWMlle0dB1ASU34
	 wDM7G0pZF1Ks1vnKez69Pa5OgIO/kYqI6MA0KzG0ehPe5jSyUdHCV8Ir+qMi75B+pv
	 glrxU1HSvTLWr6KwVymOqKkEX6pL//Vnwy52/mrzmmmTYgEwjfIVazcJjm44/U5loR
	 xYTcdceDYNciHln7tWntZmd8vPKw7gAhxPQhsjH+1q5+LLGzn1HsYOD+JEZ5hQj2mE
	 zTotO1I0jeyFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 13/20] unwind_user: Enable archs that pass RA in a
 register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-14-jremus@linux.ibm.com>
References: <20260520154004.3845823-14-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:21:46 +0000
Message-Id: <20260520162147.195FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The header file `<linux/unwind_user.h>` uses `pr_debug_once` and `c=
urrent` without including the necessary headers.

Pre-existing issues:
- [High] The SFrame FRE size calculation computes an incorrect length becau=
se `dataword_count` is consumed before it is used in the size formula.
--

commit 842bbe46528fb50996a02de1f8b7f5df1d8b1026
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user: Enable archs that pass RA in a register

This commit updates the user-space unwinder to support architectures that do
not mandate saving the return address (RA) on the stack, such as s390 and
arm64. It treats an RA offset of zero as an indication that the RA is in the
link register for the topmost frame, and allows the stack pointer to remain
unchanged in the topmost frame.

> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
> index 64618618febde..7bf58f23aa64a 100644
> --- a/include/linux/unwind_user.h
> +++ b/include/linux/unwind_user.h
> @@ -23,6 +23,16 @@ static inline bool unwind_user_at_function_start(struc=
t pt_regs *regs)
>  #define unwind_user_at_function_start unwind_user_at_function_start
>  #endif
> =20
> +#ifndef unwind_user_get_ra_reg
> +static inline int unwind_user_get_ra_reg(unsigned long *val)
> +{
> +	pr_debug_once("%s (%d): unwind_user_get_ra_reg() not implemented\n",
> +		      current->comm, current->pid);

[Severity: Low]
Does this require including <linux/printk.h> and <linux/sched.h> or
<asm/current.h>?

Using pr_debug_once and current without these headers might cause compilati=
on
failures for files that include <linux/unwind_user.h> without prior inclusi=
on
of these dependencies.

> +	return -EINVAL;
> +}
> +#define unwind_user_get_ra_reg unwind_user_get_ra_reg
> +#endif

[ ... ]

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index b5f984fb2df21..4af533e9f9804 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -255,10 +255,8 @@ static __always_inline int __read_fre(struct sframe_=
section *sec,
>  	dataword_count--;
> =20
>  	ra_off =3D sec->ra_off;
> -	if (!ra_off) {
> -		if (!dataword_count--)
> -			return -EINVAL;
> -
> +	if (!ra_off && dataword_count) {
> +		dataword_count--;

[Severity: High]
This isn't a bug introduced by this patch, but does the SFrame FRE size
calculation compute an incorrect length here?

Because dataword_count is decremented as each offset is read from user spac=
e,
by the time it reaches the size calculation at the end of __read_fre():

    if (dataword_count)
        return -EINVAL;

done:
    fre->size =3D addr_size + 1 + (dataword_count * dataword_size);

dataword_count is guaranteed to be 0.

This completely omits the size of the parsed datawords, causing fre_addr to
advance by an incorrectly small amount during iteration and breaking SFrame
unwinding for functions with multiple FREs.

This issue was introduced earlier in the series by commit "unwind_user/sfra=
me:
Add support for reading .sframe contents", and appears to be fixed later in
the series in commit "unwind_user/sframe: Add support for SFrame V3 flexible
FDEs", where the size assignment is moved before the decrements.

>  		UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D13
