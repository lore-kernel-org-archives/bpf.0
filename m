Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9F39BFF8
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624300; cv=none; b=ESKsWCAViR8IpSBN99fLpO+WhcljN9uN0aN5uhBBZJU99LpGHtPwvqys+8v95oerbsKb1ITHLWLmCbqCXXyBzxcrbrebSak+/VuPCSSklyoMbMy2pKOEr0C12V0Xvpd60y7Zw8jtyxYYFiAH6Ex/HE2Q+ffkeS5I/iLqIc0jp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624300; c=relaxed/simple;
	bh=fpilsVP/zXtLvh1VFXKSb4ejfbDdrGld8Lhfj9lNnFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nRCwLpS4HxQYQnOxfUu/fKZkjoqNXwn6sCiwWn4SNNO/Sq/CTPv2Fa4SjL0vdkP26fk9wlc+0HlM4pjvIZO+Qlt0sAO9cXYI2nxgVGYv7fUZKxZxU3e4qNoh/MmESb0PWtTU+B00ciNJO5qBzyCJcG6K1WSnPIAntLl0dg8VYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNfxLYTR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNfxLYTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA2FC2BCB0;
	Tue, 12 May 2026 22:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778624299;
	bh=fpilsVP/zXtLvh1VFXKSb4ejfbDdrGld8Lhfj9lNnFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fNfxLYTRQXNf3C7pG0lUwzhpxUCcmfFYZRL1t7XnU4HzWWHPvgmHyRXLv5W3M+1wE
	 PNr8hyPgLCs+9YA20Xa8OSbz5Ut7gqs7euLbmAFIwtFh2iHJBsHN6Wrl6His+sIQ8b
	 80eJSnlBQP47QmlUTJ4/L7P4B9rPiwCsnzesszH9X/5r4QTHyQ+P+tug+TYTExgQ1R
	 T+pvVqyK7PJCQ+GkgSNTp2So59Ql2F9J7P02j0lmMUNHkrbp++7tXJwqP1nromzUJG
	 8soGY6ak4lnyzEZOoJX+9uUZLlakcvQquJIXkrFRnlf4ucr96qJBGKQOGBB0r+TOwa
	 Ex9lzilbEWKjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 4/8] bpf: Add syscall common attributes
 support for prog_load
Reply-To: sashiko@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511152817.89191-5-leon.hwang@linux.dev>
References: <20260511152817.89191-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 22:18:19 +0000
Message-Id: <20260512221819.7EA2FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The log parameters merge logic incorrectly equates the presence of=
 log parameters with non-NULL log buffers, silently ignoring valid `log_lev=
el` configurations and bypassing conflict checks.
- [Medium] When both specific and common attributes provide identical log p=
arameters, `log_true_size` writeback may be lost if the specific `attr` is =
undersized.
--

commit b3df7b18c0d52179a3ed4e0c0f6906e0cee721ff
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attributes support for prog_load

BPF_PROG_LOAD can now take log parameters from both union bpf_attr and
struct bpf_common_attr. The merge rules are: match, use one, or return
-EINVAL.

> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 1b1efe75398b7..fd12ad5a0338d 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
[ ... ]
> @@ -827,16 +827,36 @@ void print_insn_state(struct bpf_verifier_env *env,=
 const struct bpf_verifier_st
>  }
> =20
>  int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_siz=
e, u32 log_level,
> -		      u32 offsetof_log_true_size, bpfptr_t uattr)
> +		      u32 offsetof_log_true_size, bpfptr_t uattr, struct bpf_common_at=
tr *common,
> +		      bpfptr_t uattr_common, u32 size_common)
>  {
> +	char __user *ubuf_common =3D u64_to_user_ptr(common->log_buf);
>  	char __user *ubuf =3D u64_to_user_ptr(log_buf);
> =20
> +	if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, common=
->log_size) ||
> +	    !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
> +		return -EINVAL;
> +
> +	if (ubuf && ubuf_common && (ubuf !=3D ubuf_common || log_size !=3D comm=
on->log_size ||
> +				    log_level !=3D common->log_level))
> +		return -EINVAL;

If a user specifies log_level !=3D 0 but leaves log_buf =3D=3D NULL to prob=
e for
log_true_size, will these checks bypass conflicts?

If one side provides a complete tuple and the other provides only log_level,
or if both provide mismatched log_levels without buffers, it appears the
conflict checks are skipped and no -EINVAL is returned.

> +
>  	memset(log, 0, sizeof(*log));
>  	log->ubuf =3D ubuf;
>  	log->size =3D log_size;
>  	log->level =3D log_level;
>  	log->offsetof_true_size =3D offsetof_log_true_size;
>  	log->uattr =3D uattr;
> +
> +	if (!ubuf && ubuf_common) {

Does this condition silently ignore valid common->log_level configurations?

If the user provides only common->log_level via bpf_common_attr for a log
size dry-run, ubuf_common evaluates to NULL. The condition here would
evaluate to false, and common->log_level would be ignored instead of
applied.

Also, if both specific and common attributes provide identical log
parameters, the code appears to unconditionally use uattr for the
log_true_size writeback since ubuf is not NULL.

If the original uattr uses an older layout without space for log_true_size,
log->offsetof_true_size will be set to 0. Does this mean log_true_size
writeback will be lost even if the user provided a modern attr_common
struct with sufficient space to receive it?

> +		log->ubuf =3D ubuf_common;
> +		log->size =3D common->log_size;
> +		log->level =3D common->log_level;
> +		log->uattr =3D uattr_common;
> +		log->offsetof_true_size =3D 0;
> +		if (size_common >=3D offsetofend(struct bpf_common_attr, log_true_size=
))
> +			log->offsetof_true_size =3D offsetof(struct bpf_common_attr, log_true=
_size);
> +	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511152817.8919=
1-1-leon.hwang@linux.dev?part=3D4
