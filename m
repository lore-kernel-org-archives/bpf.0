Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765901A3165
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326081; cv=none; b=Txp0WUursVGy4M0LarX3uOqRRHnWTRlmZLyrFm7aDq8Akt9BJewX0kAgFwYNrCnkTRkpfm7naI0vT6kh0cUUYOe/Ri2k3WhX9DOdp2ULzpngts+BQAHDohG0Hx1LBCn0P1a3kZSfC1GeoLgwX5KIi1ti366xcMhecaLxBOxDeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326081; c=relaxed/simple;
	bh=cs9DUwYgF6jMuXggtpQa0iDOqKCEXF9LVCzrTTiV0Jc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O69kfKU/1uQRiUjH4sZjhfgff0bY0tBb+cqMLrBXIO5u3DwnEdF/cdXz2PERdNn7gf4OGOIjfITzGNNbV/ikILD/HDe2WMde0nyqbYmk+urzeKx2efv9Jd9oi6gsU4OWHi4/ZtwCTafbzBSDwqPtoeT/Kf0cyixiIWICIjjmgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPaABYKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPaABYKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32C91F000E9;
	Wed, 24 Jun 2026 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782326080;
	bh=tKxqq9w6GuZ+6UdY2fwgdcTTtHOm2sfLx1DAB/y4f4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPaABYKsnqwt9xyfdhAadmNW7jPiwq8pQX8BZJX9db7KjWSPlwyduR68UAL8j+Gyc
	 EfehGF38QaJwT/EQ2CkftAB609sh1niSSX/66tUmBaBpCDt5+IQE4hbAZ8KozJo2wQ
	 YNRFAKk6NO0awNCdSZ9jWa9r7pkqttByM4CnmrTbrOw9F/9J/jl6Ctc7RKBmBJRSMu
	 +R0J/TSinzsVykUkqWxX5B/hdlxf5Em1FM56UqYN+HoQ+Yt1PtIgchnYS4UNPjNa0M
	 bznJb6VApDnBwcfzOl5u69A89EouzIxEOKXMPoJY9X5NP8FCspoFaWvsQMWEDmfVgM
	 lNRaoqu/LBWBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf: allow BPF_LOG_KERNEL from kernel space
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624-bpf-lskel-fixes-v2-1-e8ac5974a72c@google.com>
References: <20260624-bpf-lskel-fixes-v2-1-e8ac5974a72c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 18:34:39 +0000
Message-Id: <20260624183439.E32C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] BPF_LOG_KERNEL is silently ignored or overwritten when specified=
 via BPF_COMMON_ATTRS due to flawed null-buffer checks in bpf_log_attr_init.
--

commit efd637812e314de99108496755489e9a7983fe49
Author: Siddharth Nayyar <sidnayyar@google.com>

bpf: allow BPF_LOG_KERNEL from kernel space

This commit allows kernel space loaders to output BPF verifier logs directly
to dmesg by setting the log_level to BPF_LOG_KERNEL. It modifies
bpf_verifier_log_attr_valid() to accept this level unconditionally and adds
strict privilege checks at the syscall boundary points to prevent userspace
from spamming the kernel log.

> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index b740fa73ee26d..25a9f83409807 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c

[ ... ]

> @@ -831,6 +840,11 @@ int bpf_log_attr_init(struct bpf_log_attr *log, u64 =
log_buf, u32 log_size, u32 l
>  	char __user *ubuf_common =3D u64_to_user_ptr(common->log_buf);
>  	char __user *ubuf =3D u64_to_user_ptr(log_buf);
> =20
> +	if (common->log_level =3D=3D BPF_LOG_KERNEL && !uattr_common.is_kernel)
> +		return -EINVAL;
> +	if (log_level =3D=3D BPF_LOG_KERNEL && !uattr.is_kernel)
> +		return -EINVAL;
> +
>  	if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, common=
->log_size) ||
>  	    !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
>  		return -EINVAL;

[Severity: Medium]
Does this code handle BPF_LOG_KERNEL correctly when it is specified via
BPF_COMMON_ATTRS?

Since BPF_LOG_KERNEL outputs directly to dmesg, the user buffer is 0,
meaning ubuf and ubuf_common will be NULL.

Slightly further down in bpf_log_attr_init(), the mismatch checks and
inheritance logic rely on these buffers being non-NULL:

    if (ubuf && ubuf_common && (ubuf !=3D ubuf_common || ...))
        return -EINVAL;

    ...

    if (!ubuf && ubuf_common) {
        log->ubuf =3D ubuf_common;
        log->level =3D common->log_level;
        ...
    }

If a caller passes BPF_LOG_KERNEL via common attributes=20
(ubuf_common =3D=3D NULL), it seems the inheritance condition=20
(!ubuf && ubuf_common) will be false, and the common logging level will=20
be silently ignored.

Additionally, if a caller specifies BPF_LOG_KERNEL alongside a standard
common log level (ubuf =3D=3D NULL, ubuf_common !=3D NULL), the mismatch ch=
eck
is bypassed, and the specific BPF_LOG_KERNEL is silently overwritten by
the common attributes instead of returning -EINVAL.

Could the null-buffer checks be updated to properly support inheriting=20
and validating BPF_LOG_KERNEL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-bpf-lskel-=
fixes-v2-1-e8ac5974a72c@google.com?part=3D1
