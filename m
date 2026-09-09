Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59123A9618
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983703; cv=none; b=AIhI+ao7iu+M9k/8+1dguLQEtRCNMDubrw+6B3El6g4Fc+9JJQ5fBH26roLwIDvwAybnY2fn8oU50chAnT5L3RKRN29MJ18VBxynBnvP3mqMTug7OcLgiW3bJIKufz5zIQ3oMN/+c2RTQHT0Ot0nrvMj8nnDpctehF4RnpXsueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983703; c=relaxed/simple;
	bh=uSZ0FBZk3LQs9krTXHDKnWIpec/2MEqOowFll7na234=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPr/GulWjYhQzrPO/1gB5xh6C7MO1VUHYJu9q4MXAzeWVBACUCHWconApPWIIcKaFNIK/wHaWVh7keKlUmIfyFwenyUqh9JfyEyz+5qHPsEZTHDQtqtofTZjWthT+kNIBc1u2M5uA/ZXEgSY6YQCZ+1kczVBzn7Cg350IWgYerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C16SVzB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C16SVzB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3E31F000FF;
	Wed,  9 Sep 2026 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788983701;
	bh=19KsyvfsEEWUUSnDvTrT+D2Kot4AncI8b4TVvrSf10E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C16SVzB3rMP+gQQugGNmFsLU46yHUIr3AyD5bZppO2Y7usvtJ2N25cj1ZFDCVp+os
	 X7rkZS8xGlpaqM/RF0yRce1vrdeTQ8l9QKPasDoT58vhvvwKABkldhYjuuULgkLNY1
	 5yanJz2R0gzp5kWEXY0Z/lOkevYvoeXYPi3hkeB0EO02FaqcyGiLFB1Yf8vSXaWugL
	 Ci35G/0lOTuxc02de1+gc8ZpqmvTKfOKTb52RsN79UgwgYa0AWp3fIoSu5bR4CM+B5
	 sxkcycUPgDwRdUSegU0zdUGxgmhzRQP0VNZB6lR3UXVW99/4SlAg99KFb0DOJmCX5G
	 oNyUj6XuYOmdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 07/15] lsm: Add the
 bpf_lsm_policy_apply_bprm kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909193719.518517-8-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-8-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 19:55:00 +0000
Message-Id: <20260909195500.DA3E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The attach-point authorization boundary for `bpf_lsm_policy_apply_=
bprm` can be bypassed using BPF tail calls.
--

commit 7b53e20161b20c35fb85beb1fba538fe85514074
Author: Justin Suess <utilityemal77@gmail.com>
Date:   Wed Sep 9 19:37:10 2026 +0000

    lsm: Add the bpf_lsm_policy_apply_bprm kfunc
   =20
This commit introduces the bpf_lsm_policy_apply_bprm kfunc, allowing sleepa=
ble
LSM BPF programs to restrict credentials prepared in a linux_binprm. It
restricts this kfunc to specific execution hooks (bprm_creds_for_exec and
bprm_creds_from_file) to prevent policies from being applied at unsafe poin=
ts.

> diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
> index 43a4bf57fd31e..857e9a316d1cc 100644
> --- a/security/bpf_lsm_kfuncs.c
> +++ b/security/bpf_lsm_kfuncs.c

[ ... ]

> @@ -141,11 +202,18 @@ static int bpf_lsm_policy_kfunc_filter(const struct=
 bpf_prog *prog,
> =20
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_SYSCALL:
> +		if (kfunc_id =3D=3D bpf_lsm_policy_apply_bprm_ids[0])
> +			return -EACCES;
>  		return 0;
>  	case BPF_PROG_TYPE_LSM:
>  		if (kfunc_id =3D=3D bpf_lsm_policy_from_fd_ids[0])
>  			return -EACCES;
> =20
> +		if (kfunc_id =3D=3D bpf_lsm_policy_apply_bprm_ids[0] &&
> +		    !btf_id_set_contains(&bpf_lsm_policy_bprm_hooks,
> +					 prog->aux->attach_btf_id))
> +			return -EACCES;

[Severity: High]
Can the attach-point authorization boundary be bypassed using BPF tail call=
s?

This verification-time check inspects the initial program's attach point,
but does it account for runtime context switches via tail calls?

For example, if a privileged user loads Program A attached to
bprm_creds_for_exec that calls bpf_lsm_policy_apply_bprm(), it passes this
filter and can be inserted into a PROG_ARRAY map.

If they then load Program B attached to bprm_check_security and perform a
bpf_tail_call() into Program A, the tail call is permitted because both
hooks share identical BTF function prototypes (int (struct linux_binprm *)).

Does this allow bpf_lsm_policy_apply_bprm() to be executed at
bprm_check_security, creating a TOCTOU vulnerability since the execution
can still be rewritten by an interpreter?

> +
>  		return 0;
>  	default:
>  		return -EACCES;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909193719.5185=
17-1-utilityemal77@gmail.com?part=3D7
