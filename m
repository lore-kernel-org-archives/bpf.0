Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714635AC20
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394304; cv=none; b=ANy5YPSLJVGg5sQrHEkdBtlC5KNpUgLkSx2bpe5AcvHVTNSwvIV5WzyBLtGXcsynUeqeEvRS8yJRv6FcGMYOaXemHWi5b3M8bAlgzulrADHdwzNBoKWDo+53W88YLT3rSFHJAHD/svZ+6YbViYFTVJ5S5/lZ3GbWrRUIQNtrppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394304; c=relaxed/simple;
	bh=hU0PNDV6StLho6FPlhjyViHIWCvhpp3d/psG1P/wdwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdwnDC0Totzejmya1NnL+SGFFuboquKhp8RO2ZhB2oy0tg6w4KepDEG7e37m878pplsuv3wRD7nEF1lgaKlpjmnp7517JXBLedqhONpdx45vIWUgMtx+WxR1DQ0r1QJ4IiCubWUBqNlTRnvjRHknAiDJPC7C+/q/ctbAfTefBmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGVseJQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGVseJQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9A21F00898;
	Tue,  2 Jun 2026 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780394302;
	bh=O2BCxCP7cuCALjUZQcvpZDyEK6+PNhSnstDeOiCYyR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGVseJQZs+McxqBU9j+TCJNv7CQ44HsVK6krPFfF7ZmKmruhn6tpY6Br40Owg0FIl
	 lQ8+vYaqetBhnXNQdjWiGERxwsV7QpgPkGns0aat76plMegSqr93mUNUkSvLviXDSQ
	 GgNLdufoTndf/IjZnKHa4uDqg6zVkzqcgu+1SQiNOmvXLLnc5NlhkTZzm20OuplEJ/
	 MB+Ng+31VgHPJbEwJ1r+BmQTRwwY9fgHL8EvCTchUmHR1qGYfSlJ55UIdP0Vuhb2Vw
	 PiBq70lmAAxTmRDKzcJND/HlhwJAMfFwQkC0rd0T8DpMYP8YwLFvWtq6E1tq+rVkRQ
	 ekrUaQ+FG9s/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602093836.2632714-2-chenyuan_fl@163.com>
References: <20260602093836.2632714-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 09:58:22 +0000
Message-Id: <20260602095822.8C9A21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces undeclared identifiers `argno` and `reg_arg_na=
me`, resulting in a fatal compilation error.
--

commit af92ff0b79cc212b53a40ea48cae9a7de79d1a76
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointe=
r deref

This commit fixes a verifier issue where unrecognized implicit kfunc argume=
nts
caused a silent fallthrough instead of being rejected. It updates the checks
in check_kfunc_args() to explicitly return -EFAULT for unrecognized implicit
arguments, preventing a potential invalid pointer dereference or information
disclosure.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..57e5fdf9f7e06 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12082,9 +12082,22 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
> =20
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]))
>  			continue;
> =20
> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/* list_push / rbtree_add kfuncs have implicit args
> +			 * (e.g. 'off' parameter) handled during verification
> +			 * in bpf_fixup_kfunc_call().  Don't flag them.
> +			 */
> +			if (is_bpf_list_push_kfunc(meta->func_id) ||
> +			    is_bpf_rbtree_add_kfunc(meta->func_id))
> +				continue;
> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatc=
h\n",
> +				reg_arg_name(env, argno));

[Severity: Low]
Will this compile cleanly? In check_kfunc_args(), it looks like argno is=20
undeclared in this scope, as the local loop index appears to be i.

Also, does reg_arg_name() exist? I am unable to locate a definition for it =
in
the tree. Could this result in an implicit function declaration error during
the build?

> +			return -EFAULT;
> +		}
> +
>  		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602093836.2632=
714-1-chenyuan_fl@163.com?part=3D1
