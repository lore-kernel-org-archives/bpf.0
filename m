Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3212F5B1
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833969; cv=none; b=AkWQDMWESyROpOnqjYzpNMbWcyCWu6ISxfDL7SdwDYouYUrfchMQKJBH39/F0YTI/E28yS42rmd+hkBb4eAvrn/Lkcmundz4rF9QDcpBB7XUaSKFK5azsxg41rIBtX9pcvgyu7L3lCEEOerOMPcxtJkr5AiOeF1rn0/Gr7plNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833969; c=relaxed/simple;
	bh=1ClZOi8SROF3/2EGEIpOzZLDcZRHrpi89pOQRoUF5g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAah0I7pxUTuyorlqniFp3x/ClBErnW9UXLrQFr6EtQePD/g3wAv7mamdvkUWA2MuHQyOu4san2r8WW/H3eXiP+M7EZBfWclR6Fio8hvlr1ZKJueXzwQ4ulkoOeSq0r5qQX7lmlVFtt0k0eYwpWKiovDwYUXpPhNzpLO75Pp+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzYD6xCK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzYD6xCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541A7C433C7;
	Thu,  7 Mar 2024 17:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833969;
	bh=1ClZOi8SROF3/2EGEIpOzZLDcZRHrpi89pOQRoUF5g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzYD6xCKVPE+12412+X9UQuFFd2RRnMuJGsACJBTb/7CUUUNC1c4k8iFn/CrQBm52
	 hzy813fVf0bRI3lQPg9tARhWCNgS0gHFyuFj8zLB8xDxtNDcqawRrTAYzs0hkn6N4h
	 pGJJ4m5L4Ye5AhBTwB2wXDQokUrTJRr23pZDnbstFv6LaKDMXSjCHwAqxKjzfA52al
	 +0ff8cWY9zAhEgakXJ7/4RbGFG7sdQz0ySN5pK6829mMDeVQceJ/iWw01MOb64c9KF
	 BS9zWftTXKpBG4xr+uq7Kg6TPOymsbEwq3ATZbDfJ8Z9MmLCE0/zgO/MT82hwyircs
	 vSzMJk73Rnr4Q==
Date: Thu, 7 Mar 2024 17:52:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH] drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while
 not supported
Message-ID: <20240307-oat-mule-10441ef7e94a@spud>
References: <20240305155223.1823287-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y0Dtpe87eFaER5Lo"
Content-Disposition: inline
In-Reply-To: <20240305155223.1823287-1-pulehui@huaweicloud.com>


--Y0Dtpe87eFaER5Lo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 03:52:23PM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> RISC-V perf does not yet support branch sampling. Two riscv bpf
> testcases get_branch_snapshot and perf_branches/perf_branches_hw failed
> due to not disabling such sampling.
>=20
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

This seems worthy of a fixes tag. For what commit I do not know, but I
figure it is a problem currently in mainline and a fix should be
backported?

> ---
>  drivers/perf/riscv_pmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index c78a6fd6c57f..bc42cb95a97c 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -313,6 +313,10 @@ static int riscv_pmu_event_init(struct perf_event *e=
vent)
>  	u64 event_config =3D 0;
>  	uint64_t cmask;
> =20
> +	/* does not support taken branch sampling */

Skimming patchwork, I found this comment confusing.
Isolated from the commit message, which it will be once committed, it
was not immediately clear that you were referring to the driver. I think
it is just matter of making this a complete sentence that starts by
mentioning /what/ does not support this feature. Is it the driver? Does
the spec not allow it? etc

Cheers,
Conor.

> +	if (has_branch_stack(event))
> +		return -EOPNOTSUPP;
> +
>  	hwc->flags =3D 0;
>  	mapped_event =3D rvpmu->event_map(event, &event_config);
>  	if (mapped_event < 0) {
> --=20
> 2.34.1
>=20

--Y0Dtpe87eFaER5Lo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZen+7AAKCRB4tDGHoIJi
0uSNAQC0ygLY7d+KZxYs9uH8DbuuQbv5GSbkf16CritRnRiMDgEA3Ev5pVFKqsJJ
mXnvkHf+BdnNDV6obRMrSnx/ayR2fAw=
=vaBk
-----END PGP SIGNATURE-----

--Y0Dtpe87eFaER5Lo--
