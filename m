Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA843F1AB9
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296661; cv=none; b=qmpka+1NujSMZXgdMvmZnYJ9IRyXmpgBA89LN4TQyOTO/YkWXx+KnpMRQdIzTdaUA5T/MFNgrKgiWSjZQoS5flomHh0DzCwY4+0Y9hgziBT7/xBbPviMQKMQXTfv4OPYT1p2SV0BKZImFLnbVn2JQOVRCS/egKZVNX8FYr3TG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296661; c=relaxed/simple;
	bh=YhNhdxba4Z5KsbUeqERlh1tY9KtsNni9r9yU/XhlSW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JL9N9Ah72YLrMekiSC/uu3H8egDzEPpPrJ0c5coKLlJ4wXNGqJUg8fvgnbiyK0Xipk8ndl3nhNlF6jf3HqVGNXYiKVUaL+0Ay59A1FT2wKlEve9Rwd4guYNgO8+q5Po5KkqZhncdgTeLodiyxTEaFNwEyJJqf0I6kkUbueGiUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKJ30FQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKJ30FQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335441F00894;
	Wed, 20 May 2026 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779296660;
	bh=EPhGgkUPdVrFnQG4sbRK3iNsnShnvnOg2i/AIS1Usb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKJ30FQf4BXnMmIpfJbRjy01LnwFQdF/8lUkHv8oYQlKDmICcGd73nQyxn7SB81EZ
	 3tJ7NPhjZQVJMOsbmH4PfOpNn2klTEaDAcng3qLlJo0WPdExO1CIUfw5/YQYrKxJU7
	 TuJXlbejW5xSsMFBYQR0lsqILHmJr7Txa3qylaUS0PEkLhy2v32O3fVXZr+CQgpqth
	 bgxHiZL+M0wCmsKYQpqqNLeMYfnQTxuV7+JThcZS2biZuN/5d6HFejpc68XZx/od6F
	 xNoXkWhLFOw6shuAJYbp7DOFYzP+IwALIsv6tb6cbQf55tK22uuAg1xmVjqaVluQsK
	 ExKfOoFPNk0gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 16/20] unwind_user/sframe: Add support for SFrame V3
 flexible FDEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-17-jremus@linux.ibm.com>
References: <20260520154004.3845823-17-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 17:04:18 +0000
Message-Id: <20260520170420.335441F00894@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The patch references undefined macros `SFRAME_REG_SP` and `SFRAME_R=
EG_FP` and includes a nonexistent architecture-specific header `<asm/unwind=
_user_sframe.h>`, resulting in a build failure.
- [Low] The variable `ret` is used outside of its declared scope in `__find=
_fre()`, resulting in a compilation error.
--

commit 725751526853387385ad4dffd9fdbe24d42e98d3
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/sframe: Add support for SFrame V3 flexible FDEs

SFrame V3 introduces flexible FDEs in addition to the regular FDEs.
The key difference is that flexible FDEs encode the CFA, RA, and FP
tracking information using two FRE data words, a control word and an
offset, or a single padding data word of zero.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 6187379750db5..48709f0bafc78 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -12,6 +12,7 @@
>  #include <linux/mm.h>
>  #include <linux/string_helpers.h>
>  #include <linux/sframe.h>
> +#include <asm/unwind_user_sframe.h>

[Severity: Low]
Does this new architecture-specific header exist in the tree at this point?

It appears this include, along with macros like SFRAME_REG_SP and
SFRAME_REG_FP used later in the patch, causes a build failure because they
aren't introduced until a later commit (bfea14fc9b480 "unwind_user/sframe/x=
86:
Enable sframe unwinding on x86").

Each patch in a series should be self-contained and compile successfully on
its own.

[ ... ]

> @@ -356,9 +528,15 @@ static __always_inline int __find_fre(struct sframe_=
section *sec,
>  		return -EINVAL;
>  	fre =3D prev_fre;
> =20
> -	sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off);
> -	sframe_init_rule_data(&frame->ra, fre->ra_off);
> -	sframe_init_rule_data(&frame->fp, fre->fp_off);
> +	ret =3D sframe_init_cfa_rule_data(&frame->cfa, fre->cfa_ctl, fre->cfa_o=
ff);
        ^^^

[Severity: Low]
Is the variable ret in scope here?

It looks like int ret is declared inside the for loop in __find_fre(), so
accessing it outside the loop results in a compilation error.

This is fixed in a later commit (9c045164b82cb "unwind_user/sframe: Separate
reading of FRE from reading of FRE data words") which moves the declaration=
 to
the function scope, but it breaks the build on this commit.

> +	if (ret)
> +		return ret;
> +	ret =3D sframe_init_rule_data(&frame->ra, fre->ra_ctl, fre->ra_off);
> +	if (ret)
> +		return ret;
> +	ret =3D sframe_init_rule_data(&frame->fp, fre->fp_ctl, fre->fp_off);
> +	if (ret)
> +		return ret;
>  	frame->outermost =3D SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D16
