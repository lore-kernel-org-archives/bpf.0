Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4E3164C7
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629019; cv=none; b=Sk6Yx9y/WUBggzO5oRcnqKlhHhZTXqSdRYxcrOY3YujwvGsadXsF5gLaXAXDqLCsvkX+a9vau88eKiqgTs9qOchv1QjBBN9fOfA8vINM1hEKP6em2ny7JcSRMZhTBQJT/6zaGbBiGVPoNFmOpmsSve5F2iXBDe3Ei/kRT1QKDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629019; c=relaxed/simple;
	bh=5rPpjvh99OzyIIcxdbDVB5cRkTa/2GQtyCHBm6CHHt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MihT79Vc9jpscwEDMFiZLuSg2zexjKAsSP9TTSz0IViBLoIbSlTMm2IVRUgmFvfe67LWZFuhEhKNc5zy+VCcWb9pc4H5rxBp+ygZQT+RCixNudSatEJur21t7B+GdcucX87d6I54FwzHKT0hRajHjhwfwkgGTge+VHTtJlp9Vb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK4zts1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK4zts1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEED7C2BCB0;
	Tue, 12 May 2026 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778629019;
	bh=5rPpjvh99OzyIIcxdbDVB5cRkTa/2GQtyCHBm6CHHt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fK4zts1FMpR4Pd9NxnikxM8OLtqUZdlKQ1LYpc39YTY4wBJUnvm0JGqO+hBuxLoY8
	 zI1F9OYLi5deozl9rwbvw39iRJHPF3VnOXovlkMTWtY3cpNj0X5ss5JkXY+Rm3ZiqX
	 vf9bxRzUCFaHgTFivsw33MeG8++hxiLft87M4tf7qWfJqmTpOZGIdFyIVWAtK/2+hE
	 MuL7Q3W8mV4/xgi+5IFrLybTwLaQcO8uzKML2qYdSH0deVcfns1+L1WOUQ+z16I2VG
	 H1hqUp9hMWbwN58PwJA/JXJJx1aoiFvgTg6u3RMvTdDsrPceNjC3a8BTnW9S9r1/pA
	 BkcFu5tyfjQOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 6/8] bpf: Add syscall common attributes
 support for map_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511152817.89191-7-leon.hwang@linux.dev>
References: <20260511152817.89191-7-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 23:36:58 +0000
Message-Id: <20260512233658.CEED7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Calling `close_fd()` on a published file descriptor introduces=
 a critical race condition (File Descriptor Hijacking).
--

commit e059afefe67c83f634eb8a27db293cda839d9654
Author: Leon Hwang <leon.hwang@linux.dev>
bpf: Add syscall common attributes support for map_create

This commit introduces common attributes support and verifier logging to
the map creation process. It refactors the map creation logic to allow
reporting map-creation failure reasons back to userspace.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 2fa05ba8f1619..54b43e16848a9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -1611,6 +1632,31 @@ static int map_create(union bpf_attr *attr, bpfptr=
_t uattr)
>  	return err;
>  }
> =20
> +static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_c=
ommon_attr *attr_common,
> +		      bpfptr_t uattr_common, u32 size_common)
> +{
> +	struct bpf_verifier_log *log;
> +	struct bpf_log_attr attr_log;
> +	int err, ret;
> +
> +	log =3D bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, =
size_common);
> +	if (IS_ERR(log))
> +		return PTR_ERR(log);
> +
> +	err =3D __map_create(attr, uattr, log);
> +
> +	ret =3D bpf_log_attr_finalize(&attr_log, log);
> +	if (ret) {
> +		if (err >=3D 0)
> +			close_fd(err);

Is it safe to call close_fd() here? Since __map_create() uses
bpf_map_new_fd() to allocate and publish the file descriptor via
fd_install(), the file descriptor is already visible to userspace.

Could this introduce a regression where a concurrent thread closes this
file descriptor and opens a new, unrelated file that receives the exact
same fd number? If that happens, it seems this close_fd() might
inadvertently close the unrelated file.

Additionally, since the map is published globally via its ID before fd
installation in bpf_map_alloc_id(), could another thread acquire a
reference to the map before this error path? It looks like the map might
remain alive and accessible even though the syscall returns a failure.

> +		err =3D ret;
> +	}
> +
> +free:
> +	kfree(log);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511152817.8919=
1-1-leon.hwang@linux.dev?part=3D6
