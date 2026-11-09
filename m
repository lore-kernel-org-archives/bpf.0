Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234147;
	b=B3lHUMf6quJmXrQ6yu1bgiJsZqW1uzM+bEhNVmPwulQo9X+eP8NY3mdnMPaTvWTNbNLY
	 cWQZx7Fkb0y6v9ANY1oQXoi24RkibhKTHvNZR0jdLx0lkOAcZCmWgWcNXqjP2sT1VxkA1
	 Njt6/lTQqABDySOkKWph+PgTdTt00FKPQ9/1a1kxBgecVJeejID03YPRT9cNiFVAMR1t4
	 NdtGVCA8zfrUL7wYlf1O64m3fv6BDOJaPQE6mbrEo7Vl0iAIUFPkFXw4aM/ceqRfTp2S2
	 Be0F/YIZcED9FUOi7ilwNW58L8VV0XVLgil+e62UUvoEZAIBIxQ+e5r7zMAf7jGMHEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234147;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZpFcxE3SRo4HBqoLlnPxpLk5Hfx0UkedyFhExIgeZPg=;
	b=tKgZyTHMNpi9FDXi/wda//pXTL72Ny3FBnRBJR7ZU9dUMo7I7v5rpkWXiWuI6Wuj3M/v
	 aQrznGT5lip8EpDHtslgxE7BJHwBoNa2ue58k6BGynVY0nxrYHqgbtCxU0n2v7zRTRhA2
	 YmOv/qLccF/TqsTGCCqGtWJZvBARs7AWKSHnfNip5JAmkbuMq1x9VMvSuk/XQR1WIl6k9
	 swwbOe4sU51GnRKy7XQPBlZqqN8wYiOUSqt5hE21wyFVRJX7kDqGdZanVfJnceX2J7gmB
	 pzd2lRidVkxwKJGYEPaJYX+J7vmt8i9tzfQtKIW/G9pj8q5cghyk3dACxuXQJoNZ/pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy7xgU3v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807BF606D80D;
	Mon,  9 Nov 2026 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy7xgU3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98E91F0089F;
	Mon,  9 Nov 2026 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234147;
	bh=ZpFcxE3SRo4HBqoLlnPxpLk5Hfx0UkedyFhExIgeZPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vy7xgU3vtXwPJAhw4MkKmASq0bNWFf08E9nxxsqe2nkzlOMKiWIT2V3FGkFOFtVoG
	 u3M1aD7L/uzUC77IcOrqdr7UrZAcvXLOzjCIma7W7kKB6UitRcSuXlmnglq7eC0v3c
	 p4Cuwgd+Dy+2mFR2UR6BVz92sYGMb4CsLs3o9yXvkbXP5h4ILVZUb9XZhng4jYF0bs
	 A6NCOOFeEOj4diyIWE6QFli2OL8X+lmXnuUUb+jI0L7Lrghw/HniYAJNvliMo8YdfF
	 UthdarmWehSvqc/au5cm/TzGEcN2pebkilkQsAlmWnFrU31WKfJH5DTOqLpEyjo/WF
	 kKvqvopuQtAjA==
Message-ID: <sashiko-outbox-205082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/9] bpf: Add log support for iter link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261109140816.5196-4-leon.hwang@linux.dev>
References: <20261109140816.5196-1-leon.hwang@linux.dev>
 <20261109140816.5196-4-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:22:26 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: misattributed iter_info error log messages in
  bpf_iter_link_attach()
--

commit d8f64c129a2738b81f1bf280ca7bbad040d70081
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add log support for iter link_create

This commit passes the verifier log to bpf_iter_link_attach() and logs
diagnostic messages when BPF_LINK_CREATE fails for iterator programs.

> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index f0b29a1709357..dfefa5579e033 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
[ ... ]
> @@ -538,24 +539,36 @@ int bpf_iter_link_attach(const union bpf_attr *attr=
, bpfptr_t uattr,
[ ... ]
>  	if (!bpfptr_is_null(ulinfo)) {
>  		err =3D bpf_check_uarg_tail_zero(ulinfo, sizeof(linfo),
>  					       linfo_len);
> -		if (err)
> +		if (err) {
> +			bpf_log(log, "Invalid iter_info.\n");
>  			return err;
> +		}
>  		linfo_len =3D min_t(u32, linfo_len, sizeof(linfo));
> -		if (copy_from_bpfptr(&linfo, ulinfo, linfo_len))
> +		if (copy_from_bpfptr(&linfo, ulinfo, linfo_len)) {
> +			bpf_log(log, "Invalid iter_info_len.\n");
>  			return -EFAULT;
> +		}
>  	}

[Severity: Low]
Are the log messages for iter_info and iter_info_len swapped or
misattributed here?

By the time copy_from_bpfptr() runs, linfo_len has already been clamped to
sizeof(linfo), so copy_from_bpfptr() only fails when reading from the
ulinfo pointer (attr->link_create.iter_info) faults, yet it logs "Invalid
iter_info_len.".  Conversely, bpf_check_uarg_tail_zero() rejects linfo_len
values larger than PAGE_SIZE with -E2BIG without touching ulinfo, which
logs "Invalid iter_info.".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109140816.5196=
-1-leon.hwang@linux.dev?part=3D3
