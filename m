Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F073A875E
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499646; cv=none; b=fXiBXlAHzXoZ99RKPCfJzJ5kqbeCe9RJWlP7RDhjbzFdOYi9fH/fsFRPi/N8bBc9gIRhCUvwERytQW+ivI1HARFN+fxjm6XLIUFFkJiZAcXruVm0gj7ousBzKwXe7ZGMW9xhIjVsOYXpjTYDzrOkSJpQKJqmeHevKSrZE6q0hGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499646; c=relaxed/simple;
	bh=EslAPJn5En+VB6FPDoMYH0vpKH+lPYaCoYMbm3XuzgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k/A6EBA16ycBt4zG/EQ87R1UYYHWp0kMWsoIbV9ZMcQVhhEeDFr/YbT1gHCxx6jlMwuL8Vv22was53qcgAmC9fC00zz0b5BoYWHSR9eIDxC14XfS59iiS4OSYeKJOfxzDR3ASclWJXxLH9jy0DTyE41YTSJkHXXclNP/O+/FmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9i+gpJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9i+gpJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB111F00893;
	Wed,  3 Jun 2026 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499645;
	bh=GdHU0f/YWuLcv2i1Ct+iD2KjW5nF8rJzLN7XbMd/k48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9i+gpJtTCcLFQ817AyAxv42EBus6jSofXzG/qtD2ZhI127efFPLmSHovekGktnQd
	 ExrNy4AvoKgo8Lm2czICGCCZKrCSLjHlckwstRD+CA6hwq58gbbrH5jwOMaPiOrMB3
	 2YVl0uJy5WFyIvQh0QarAUJ6CiYWVn0PGodPWaJOgWd93Lc8boB6fSyXszgAnx1lwf
	 LR2Pxi4wZzz6N3D4soQyxORiuUleyqTAuIKU4LzdjCFY7ishBFZtRmGtgm3uiesjgP
	 sUDsdpxJKUM3Tww0IZIspIIW0sYgsiQ8FWGu0J0fBB53XP6a/zoKkyUCdOLoLA/3uD
	 m87U4UuEn5GPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: Check tail zero of bpf_prog_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603144518.67065-3-leon.hwang@linux.dev>
References: <20260603144518.67065-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:14:05 +0000
Message-Id: <20260603151405.6DB111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] UAPI regression and fundamentally flawed forward-compatibility=
 logic due to strict zero-checks on previously ignored struct padding.
--

commit 7758939eea6a099c4db0364bf334e0034c2864fc
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Check tail zero of bpf_prog_info

This commit changes the size passed to bpf_check_uarg_tail_zero() to exclude
the trailing padding of struct bpf_prog_info. The goal is to prevent older
userspace programs from passing uninitialized stack garbage into a future
4-byte field.

Link: https://lore.kernel.org/bpf/20260513224823.6494FC19425@smtp.kernel.or=
g/

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
Does this change break the ABI for existing deployed binaries?

Previously, expected_size was 232 (sizeof(info)). If an existing binary
passes info_len =3D 232 with uninitialized stack garbage in the 4-byte
padding, bpf_check_uarg_tail_zero() would see actual_size <=3D expected_size
(232 <=3D 232) and immediately return 0.

By reducing expected_size to 228, actual_size > expected_size (232 > 228),
so bpf_check_uarg_tail_zero() will actively check the 4 padding bytes and
return -E2BIG if they contain garbage. This rejects previously working
applications.

Additionally, does this actually protect against the stated future issue?

If a future kernel adds a new 4-byte field, the struct size stays 232, and
the new kernel's expected_size will be 232. At that point, those old buggy
binaries passing info_len =3D 232 will once again hit the fast path
(actual_size <=3D expected_size), skipping the check and allowing the
uninitialized padding to be consumed as the new field.

>  	if (err)
>  		return err;
>  	info_len =3D min_t(u32, sizeof(info), info_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603144518.6706=
5-1-leon.hwang@linux.dev?part=3D2
