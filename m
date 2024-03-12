Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54E2E3E9
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710247950; cv=none; b=iGvY859adlAI2WzUSXgaYU0uatAbz+rZy9oGSsylMWEIOzbllnU2vuEVdUDyPQy/vocveUjdlMAwFOXUKMDcrUawfP5Qby/OySWsHDkKAnjecXF3AqiVxPvhJzn4C5lJFOSgFiQ9iBRZ/rU1V9f5jPm6jLyVAUDtJQQ4L3IN6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710247950; c=relaxed/simple;
	bh=3Lst4rHk190LS/mdF+w4VIXC0m1eA4filNYo57TdeYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUhKX0G47s/7B9yN+51hVSYG9qi2/akFbxI16tjVn1vjpowM2KqnBOyXAqj7+u1Up1t3q2hK2kdG80IYa/V0lgjheXTOzu4XGi+D9eIUHSUJbYiQudt8y2MtteBBbcjk1OT0UTLvyTCkkwntzK3h3XxItEMbjKSNZs3W0VLEopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv4L6KF1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv4L6KF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAEAC433F1;
	Tue, 12 Mar 2024 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710247950;
	bh=3Lst4rHk190LS/mdF+w4VIXC0m1eA4filNYo57TdeYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kv4L6KF15hOjEQgAOW11UYkhY6Ks3gb6yfmXKH/sH4sfq0qI1rKFiAuo72Z81UYJ8
	 Oy6T0FssypXawQC7tLZB+FsXbw/vY4lHlxNUixfSL+77yDV42pdsQa6iq/VcOwk5Tl
	 v2Slk2OXz6p4VYO8ZMB8QRs0uU/EKP8L/vFtkYu+tvVSyDHjUAkvucojCYeSV5m5QO
	 SfORJTUxdXxDkTT9sUvsH2eHVaLxCbiHvE9j/sn4uXfxn6WiYQPg5QD4ymQGOhfUuA
	 n+UyfpqwMqctILz8XyOncZgxExhkeVT75R/Gx8EUsxxhhhRoShD3VrqGz/d7avurRW
	 +S7lQLCoT0xRA==
Date: Tue, 12 Mar 2024 12:52:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH v2] drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_*
 while not supported
Message-ID: <20240312-simply-oval-135dfe40666c@spud>
References: <20240312012053.1178140-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7wIqCZ6CtZGzbmbT"
Content-Disposition: inline
In-Reply-To: <20240312012053.1178140-1-pulehui@huaweicloud.com>


--7wIqCZ6CtZGzbmbT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 01:20:53AM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> RISC-V perf driver does not yet support branch sampling. Although the
> specification is in the works [0], it is best to disable such events
> until support is available, otherwise we will get unexpected results.
> Due to this reason, two riscv bpf testcases get_branch_snapshot and
> perf_branches/perf_branches_hw fail.
>=20
> Link: https://github.com/riscv/riscv-control-transfer-records [0]
> Fixes: f5bfa23f576f ("RISC-V: Add a perf core library for pmu drivers")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7wIqCZ6CtZGzbmbT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfBQCQAKCRB4tDGHoIJi
0j6lAPwM72nK8LHC0w2dR+6JdRc7vB0lSIKmeAIsUvIAtrZiVAEAl88IW/Yh9Ns5
gwAccIoQyB0v0YVeQveHF0ZlBiMhAQ0=
=fLGd
-----END PGP SIGNATURE-----

--7wIqCZ6CtZGzbmbT--
