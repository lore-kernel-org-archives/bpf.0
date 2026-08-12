Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6913EF66B
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577377; cv=none; b=eZZV4s+IlFqK1JQrhwfsMnqC/8hw2/dLv4tUMMQeEuRHW2Xbcp7MAAifSRnxd15ALtsrzerK4XkGcZ1Dk7SUFcBdGKG5EXk1K/80U1qeyEG7KNr2sgdVegV5L8tOfsRrqybAq0Jn/nxUsA1xpTLoPNyd0GZ4hvmyqRRkPA4gYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577377; c=relaxed/simple;
	bh=5QZDWvec+slYrauD/6Ap4XIvgtTsswQZhnnHXg4dlI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ssZKhn6G3ZfuUnf5yr3+5AaCsHmJRnXRdySG+7zVsdyymkbuQCAqYyxRTOx/uZgO91sTXWMvwvyE0IS683lbNiF0f8VlEAdhrMmUxDSe9dveostbI6qfA9KWCpH1vNeWUbqWXKrybezEwWEXQv9TEypIfrBNG8TcmTYIQrC97h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J37a4txq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J37a4txq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B301F000E9;
	Wed, 12 Aug 2026 23:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786577376;
	bh=d+kqK98lsFE1/khz7oGzkCez8XPzanlhR+XIPbiDteE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J37a4txqJYOWmANHl8CnVsxruwgsukjXvbxxGekzp1cPphdko2NKavZrPfd8T2lQz
	 GItg5mqreGG4SRgT0oCwm9jCaKoBKMkntp7Kz2syj3YWPuMpYjqAEucKrkExeqXVQw
	 J/W/+L/Jcv2a6Eh77zHzrGjynw+kMSfigrbR7P4inMkd6kM+a4JH/TNZ82cu2kgbMR
	 bPpnZcHv4rWStMSLnE9fLDM+2VJqTuHlqFROPT+v81NBuH1ZUKc/jO3kSoYuh0oO4e
	 D5dmae7ywma9QeH8sZDfpJOql9EqEsJDCv7WPCv+2y7MN4SnyoAKpRItWKCSrcBKkz
	 22d0NZLMH1bqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1] bpf: Fix func_info_aux desync after dead
 code elimination
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812231506.3558128-1-memxor@gmail.com>
References: <20260812231506.3558128-1-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:29:35 +0000
Message-Id: <20260812232936.56B301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to update `env->exception_callback_subprog` during dead co=
de elimination leads to an out-of-bounds array read and potential crash dur=
ing JIT.
--

--- Patch [1]: [PATCH bpf-next v1] bpf: Fix func_info_aux desync after dead=
 code elimination ---
commit f1d27d196a7979de10f6e09614e6262cf8069cae
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Fix func_info_aux desync after dead code elimination

The commit shifts func_info_aux together with func_info so the three parall=
el
arrays stay aligned after subprogram removal during dead code elimination.

Link: https://lore.kernel.org/bpf/20260808064523.DE3E71F000E9@smtp.kernel.o=
rg

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index c4bd70befbb5c..37ea85e974f14 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -401,13 +401,17 @@ static int adjust_subprog_starts_after_remove(struc=
t bpf_verifier_env *env,
>  			sizeof(*env->subprog_info) * move);
>  		env->subprog_cnt -=3D j - i;

[Severity: High]
This isn't a bug introduced by this patch, but should we also be adjusting
env->exception_callback_subprog here?

When dead code elimination removes an unused static function that comes bef=
ore
an exception callback, env->subprog_cnt is decremented and subprograms are
shifted down. However, env->exception_callback_subprog is left unadjusted.

Later, in jit_subprogs(), the func array is allocated with the new, smaller
env->subprog_cnt. Accessing it using the outdated
env->exception_callback_subprog index could result in an out-of-bounds array
read and a potential kernel panic:

kernel/bpf/fixups.c:jit_subprogs() {
    ...
    prog->aux->bpf_exception_cb =3D (void *)func[env->exception_callback_su=
bprog]->bpf_func;
    ...
}

Does env->exception_callback_subprog need to be updated to reflect the shift
when subprograms are removed?

> =20
> -		/* remove func_info */
> +		/* remove func_info and its aux */
>  		if (aux->func_info) {
>  			move =3D aux->func_info_cnt - j;
> =20
>  			memmove(aux->func_info + i,
>  				aux->func_info + j,
>  				sizeof(*aux->func_info) * move);
> +			if (aux->func_info_aux)
> +				memmove(aux->func_info_aux + i,
> +					aux->func_info_aux + j,
> +					sizeof(*aux->func_info_aux) * move);
>  			aux->func_info_cnt -=3D j - i;
>  			/* func_info->insn_off is set after all code rewrites,
>  			 * in adjust_btf_func() - no need to adjust

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812231506.3558=
128-1-memxor@gmail.com?part=3D1
