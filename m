Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CD30C63A
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587256; cv=none; b=XiMe5u+4z8Xpz5Wq+tL+xwl5tWdev+oQCs8xabiAyRpStd70GPWISSf7wzSF7nV29j+grBZcISsYqhcl7eIh5sg/6/4SQ39sSKzQFJjXlkRUL5NOX0NsqrvSuj6kU4ydIADZSEzQFG6kaKQkriNC5o3F/0PP2D01G3BPU+NCeyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587256; c=relaxed/simple;
	bh=KRHHFM71NX0cFaWasYoCw8sCqyqDd4GOSzlPG/t2ySA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N7lfLQMendIJ6qHc5Hz3gObI5++OCobOcwdmN3VpDzrt56CtYd6V5axqP/UME5IH4eoHji1ejPAjqNxsAT2xhNqS6+ZiTwU/7jXNTKMaXODW8GB01sZZiOAMUEQGz0j2w1uBE6O0mQZMTQ1YUqz0lCWFzJF1dKF9ZEcALf9+fgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCglsimO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCglsimO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BF01F00893;
	Thu,  4 Jun 2026 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587254;
	bh=OR3U3MVtIJoS60+aIA0hjPixm0gYhz9P4UHtSj3f6pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QCglsimOPhP0lrlLdRQB+X1bNK5AW9PN/GQm9C3wqsYo5GfFzaLjGXLmimWvVgqKv
	 mAAfMS0+BkTzZ4YW4lMMoOPpq3XFHHqckB28HNX8nxR5S1Ti0sfi0erAU149FStgxr
	 Q08qSp0Y+X36bgmeXw2Bb7KOyHq7X2jaWUXiutJ39hdRt8l2bLkIxKKGkvGwZzL9g6
	 s/8p7TkhQKWbj5By/jDc4xlfltu+nnaIjWYm0/jFLh4F4xz8N7IqCMmqrBE8Y9+jsl
	 S6hLXAxSxvQFot4b4qK0uOtoVFYpGjvGfTJ1FjsYKgBa6W99+R4zCf5/EK6MS/o0cV
	 rEIdT2gaVpXWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Check tail zero of bpf_prog_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604150505.99129-3-leon.hwang@linux.dev>
References: <20260604150505.99129-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:34:13 +0000
Message-Id: <20260604153414.17BF01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] ABI Breakage / UAPI Regression: Enforcing a zero-check on prev=
iously unchecked UAPI struct padding actively breaks backwards compatibilit=
y for existing userspace applications.
--

commit 5d5895c0d685510901c044426a4ec3d4faf9bea8
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Check tail zero of bpf_prog_info

This commit changes the size passed to bpf_check_uarg_tail_zero() from
sizeof(info) to offsetofend() to validate the padding bytes of struct
bpf_prog_info.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1007fb7c87e91..0c86a70d31c17 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5115,10 +5115,11 @@ static int bpf_prog_get_info_by_fd(struct file *f=
ile,
>  	u32 info_len =3D attr->info.info_len;
>  	struct bpf_prog_kstats stats;
>  	char __user *uinsns;
> -	u32 ulen;
> +	u32 ulen, len;
>  	int err;
> =20
> -	err =3D bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info=
_len);
> +	len =3D offsetofend(struct bpf_prog_info, attach_btf_id);
> +	err =3D bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);

[Severity: Critical]
Will this cause a regression for existing userspace programs?

Since struct bpf_prog_info has trailing padding due to alignment rules,
existing userspace programs allocating this struct on the stack might pass =
the
full sizeof(info) via info_len without explicitly zero-initializing the
trailing padding.

Previously, because expected_size was sizeof(info), the padding bytes were =
not
checked. With this change, bpf_check_uarg_tail_zero() will now check those
uninitialized padding bytes against zero.

If they contain stack garbage, the syscall will unexpectedly fail with -E2B=
IG.
Does this actively reject previously functioning userspace code?

>  	if (err)
>  		return err;
>  	info_len =3D min_t(u32, sizeof(info), info_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150505.9912=
9-1-leon.hwang@linux.dev?part=3D2
