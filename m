Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A453BFE47
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006086; cv=none; b=C0vO62YMPEKXvgA5ob7xUOi17RkI3+FgrvhXCSRyTWd//1VGc9Tb+1di1Zj+Iktd57JG4vq/mMI6yes2G2e74nsFPrYXG1Hw2AFAmbzjyJGgrUC3HwspU5zDDbWHnIIj0ImA1Gixd6bCLDn6OGuhhjCoh7r1CulQM4p4S3XjUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006086; c=relaxed/simple;
	bh=34d2WU/e47rGdBYHcvyYYeiMhmNoV2RcMGN9k9RW/UM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lvIGzPwgvc+rFyCFjeyRC5a86uxjGJkk1fJ2xSpU2EWtsQ5rY9xS+079JO4PbDfgTM/5eADeSV1RSBHggq9mEX+O56rXjHnKgoHLYMWDn1SGSYLxJu1Bk01FXO3PX1cPBvsGYQJ9JaB9KIJOFLqeCRW4AQmI34bgta5oQfQ9pO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv9z2QZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv9z2QZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074E3C2BCB4;
	Tue,  5 May 2026 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778006086;
	bh=34d2WU/e47rGdBYHcvyYYeiMhmNoV2RcMGN9k9RW/UM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Mv9z2QZPUn5sDTRkUW+kYcF5O1ailcLYseLWV8oCH76mHAdl3YT6swLIpV1XnamRB
	 cnuyTcCTdLmMbtMhNMxRCkos4RcBdlng2/XDtV3LFGiK9UojAfi6Gk3iUlYAQ2IQQe
	 7SPRu3/bRQy3Ed3cVBwVBpTHLWnXMT0PmnWkRiKsJm4caSicoxy8OtoQg1GRHYhz6u
	 4NyGG+DMt/vc90QzTjZ7PdSSNi7VoVsaSFmQtqo4Ow9ocfKpWcjX40NTkxhRJCc1kF
	 Rj+PoOlPOByVdtXTWX91yxlnT344cqA0bAUjQyiDrloLSMSm2V5hZuyStWySQGDuYd
	 uksM/eZc42o/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 14/19] unwind_user: Flexible FP/RA recovery rules
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-15-jremus@linux.ibm.com>
References: <20260505121718.3572346-15-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:34:45 +0000
Message-Id: <20260505183446.074E3C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unprivileged users can trigger a kernel warning (and panic if pani=
c_on_warn is set) by providing crafted SFrame data that forces the use of u=
nimplemented register recovery rules.
--

commit 32f67c3538981cd61e598218f28891cb4051e567
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user: Flexible FP/RA recovery rules

This commit adds support for flexible frame pointer and return address=20
recovery rules to the user unwinder. It introduces rules to retain values
or read them from registers.

> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
> index bc2edae399556..92cdf38c8aded 100644
> --- a/include/linux/unwind_user.h
> +++ b/include/linux/unwind_user.h
> @@ -32,6 +32,15 @@ static inline int unwind_user_get_ra_reg(unsigned long=
 *val)
>  #define unwind_user_get_ra_reg unwind_user_get_ra_reg
>  #endif
> =20
> +#ifndef unwind_user_get_reg
> +static inline int unwind_user_get_reg(unsigned long *val, unsigned int r=
egnum)
> +{
> +	WARN_ON_ONCE(1);
> +	return -EINVAL;
> +}
> +#define unwind_user_get_reg unwind_user_get_reg
> +#endif

Could an unprivileged user trigger these WARN_ON_ONCE macros by providing
crafted SFrame data during profiling?

If an architecture does not implement unwind_user_get_reg or
unwind_user_get_ra_reg, falling back to these stubs will execute a kernel
warning. On systems with panic_on_warn enabled, this could lead to a
kernel panic.

[ ... ]

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 9ceef9b2b8db0..89aecfbe3e849 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -61,22 +61,61 @@ static int unwind_user_next_common(struct unwind_user=
_state *state,
[ ... ]
> +	switch (frame->ra.rule) {
> +	case UNWIND_USER_RULE_RETAIN:
>  		if (!state->topmost || unwind_user_get_ra_reg(&ra))
>  			return -EINVAL;
> +		break;
[ ... ]
> +	default:
> +		WARN_ON_ONCE(1);
> +		return -EINVAL;
>  	}

A similar issue seems to exist in the default case here, as well as the
default case for frame->fp.rule below it.

Since sframe_init_rule_data() sets the rule based on untrusted user memory
(for example, setting UNWIND_USER_RULE_RETAIN when ra_off is 0), can a
crafted binary intentionally hit these paths?

Would it be safer to silently fail and return -EINVAL when an unsupported
or unimplemented rule is encountered, rather than warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D14
