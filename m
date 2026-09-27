Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F82EEE92
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790550880; cv=none; b=nkF17x1nry1UugEbtCZvoo1KYEsse+8L8NbMHIr3cOiwa2X+c/wOIVLszD6kGaWrPES8YIZL3k10ps2TP2yyOUWn3UVZJgoVvwVxbSoz6Ia2dzZYGk4axvP9nggDWhkFU4w1uLl0VeJkSXQtUnxbUVSgHQrS6bWVOGp7s/fp0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790550880; c=relaxed/simple;
	bh=vPhvbw+0aBtm9mthMklrVYHZ3rDNKcI7RmUIzcz+m2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DLTRH5cwoleWwm5sNQ/CLuXt0Vc+kDEmiXbS1paGE/q5cF4uhlN0VWyWnIvouQIUaQPWRNBnSJQUW4pk/GEQdPDyFjT4GAYvhJT8f8oIhYV7MAJNhUABw4LQA9TW3ClrxhQO+1gea5ZosbAC+OlFMvZ/X12h9Fuxnx79MMPd1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyHvcRbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyHvcRbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549B01F000FF;
	Sun, 27 Sep 2026 23:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790550878;
	bh=LaGYMoYrxgabuwS8iI93khA7ZTNuOnWNgCOHmv2lI5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VyHvcRbzisjVvnoPPfFUMpM2qXqoy7vAW9JDdZ7dG5avR5eS7Amz47M7slJICHtMD
	 p3pzIIqwMCB3+PfB5WNNYY9STHj3m5cystSUiDWQxvYKgWXyEFUr3W0fb9SgyO1K3Z
	 fFzWPGG8avVgDgMT0cfGGowjhZU85crRUPykEwFx5apb4S8Cs5T+ZokJ9dUo35tmIQ
	 P5XAEzt/IbPf5fZafj7vbW++Pr3yM4JDJ7/eG44B2dmDpoDuCILC/2gP0h9v94P9qa
	 aE9jLy0Lc8zfxR1J0GgusHlc+vlu7q4jmE9nEzC7gFU6yAv0kmJ3UWNwro6OXj2MPU
	 35VgT/NDwNb6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Skip redundant
 destroy_if_dynptr_stack_slot calls in check_stack_write_var_off
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w5ZtZXIgTWV0ZSBLYXlh?= <omermetekaya0@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260927230511.417420-1-omermetekaya0@gmail.com>
References: <20260927230511.417420-1-omermetekaya0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 23:14:37 +0000
Message-Id: <20260927231438.549B01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in check_stack_write_var_of=
f()
--

commit 2ecbd1f84931126c23d8e648f52879b6e724f3c6
Author: =C3=96mer Mete Kaya <omermetekaya0@gmail.com>

bpf: Skip redundant destroy_if_dynptr_stack_slot calls in check_stack_write=
_var_off

This commit optimizes check_stack_write_var_off() by skipping redundant cal=
ls
to destroy_if_dynptr_stack_slot(). Since bpf_get_spi() maps 8 consecutive b=
yte
offsets to the same slot index, it avoids repeatedly processing the same sl=
ot
when iterating over a variable-offset stack write range.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03dbc0e003986..ba029d8c34f89 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -3824,9 +3824,13 @@ static int check_stack_write_var_off(struct bpf_ve=
rifier_env *env,
>  		writing_zero =3D true;
> =20
>  	for (i =3D min_off; i < max_off; i++) {
> -		int spi;
> +		int spi =3D bpf_get_spi(i);
> =20
> -		spi =3D bpf_get_spi(i);
> +		/* bpf_get_spi() maps 8 consecutive byte offsets to the same
> +		 * slot index; skip redundant calls for the same slot.
> +		 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style?=20

The BPF subsystem explicitly requires multi-line comments to have the openi=
ng
'/*' on its own line, with the text starting on the subsequent line.

> +		if (i !=3D min_off && spi =3D=3D bpf_get_spi(i - 1))
> +			continue;
>  		err =3D destroy_if_dynptr_stack_slot(env, state, spi);
>  		if (err)
>  			return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927230511.4174=
20-1-omermetekaya0@gmail.com?part=3D1
