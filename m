Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414230;
	b=hxoQmypT95DvYklyL2pqOo4q7obmTDHUbVCyzS9UlS80Y+JCDt3ot63dtX9FCLr9fRDf
	 fLodiQAYiCnE7GQd5yQYQLWr0+ssIjUhw3rRgQzDSUHHn15h9N77O2o4w06ExFkClOaad
	 87/Yt+RdxGbJzUL33mBJuiwSOep/TZwq7pC2wxnvKSBrUiS71G8uP8D/jDYtMdjLoHpu5
	 OhNtG7riEETm8ugRBpkv4bG45RVC4QXYHXId7kbdjPHHK9tbrMpd9u8X6sOU/Aq4+pS2b
	 llatK9N/6cJa9rI2HYysPXoGrco6GVl/blj+JagEtAAj1/jc2NSWAFOR89tvCS23Iag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414230;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gqi0NeIYvCX+ZJ6ERNNEXSyyJorg2i/VJylrBS3UYkU=;
	b=snBKRJ4Kf09QVEeYL32NvyWhnJc+w6lZKsWwKsWrGu2LJqNvQ/pTqYfysBsErtvBz0NK
	 4IgBkgi5C7Lf4AftpX0hpRT8X+C/m62lt9wnoEQcPyD926WYN0oyzlFY6xyUwcuQTTz/W
	 2PBTzhdr1YxO2Jww4mfnMciFehgAW/KcHitRiHAfuaQ6+TZh2VgQ8fIDgmUz/wg/gsmtI
	 E+VVrP/gMsedXZqSVoZN9/waMy0Fh3ZlQYkMfgqJAT5eCF6088cbEVZZ8+3nZ7GZck8K1
	 2FOVJf6DL79jHM/OXxXx7Dp154m1X44ICk0+hhhsMSIAv1vedDvPqI4vyEgylmQx6vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsCTmwPm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F7606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsCTmwPm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F6F1F000C0;
	Mon, 23 Nov 2026 06:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795414229;
	bh=gqi0NeIYvCX+ZJ6ERNNEXSyyJorg2i/VJylrBS3UYkU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OsCTmwPmsAGTkAz9ufsMByJhediVux0l8AjUzGFDqbu/xDa3oSy0lF7jB7fD6KVhE
	 14D2goSMjlzQBtoLm/JfYJdSV1cFJoENci43tz+/KdoixUgtqZMBCJ3eb2LkhprL1H
	 xP/cFKI2XprJK0D8oJdCkaE3dwikJGHQE35QjYFFTNmEpXay58a4AWrK9kKX72eNJ6
	 1FpyjFJ4ZlkhMvxieSCkWmL0v538WWttnmQYKPUJlyn3PEq/239Oz+GYpZOoK8qqAE
	 q5olsFSKiY9FfWDnB7Db4YoRZEs/HF8+E2l1l8PgsDY7rw+ol8ItGvR2f+j67G4vzS
	 83Tsp7BgEc/nw==
Message-ID: <sashiko-outbox-228755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: strengthen
 bpf_kfunc_implicit_arg to verify aux injection
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com, bpf@vger.kernel.org
In-Reply-To: <20261123055708.684107-3-chenyuan_fl@163.com>
References: <20261123055708.684107-1-chenyuan_fl@163.com>
 <20261123055708.684107-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 06:10:29 +0000
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
- [Medium] selftests/bpf: unsafe dereference of stale aux in
  bpf_kfunc_implicit_arg()
--

commit e250ac53eb106d5e314d3c6e696fc288a2644a2c
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: strengthen bpf_kfunc_implicit_arg to verify aux injection

This commit updates bpf_kfunc_implicit_arg() in bpf_testmod to verify that
aux->prog->aux points back to the implicit aux argument rather than only
checking for a non-NULL pointer.

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 1fbc0061cc240..b97fcbcf249a7 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -2529,7 +2529,13 @@ int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_=
ops_args *args, struct bpf_pro
> =20
>  int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
>  {
> -	if (aux && a > 0)
> +	/*
> +	 * Verify that the verifier injected a real bpf_prog_aux instead
> +	 * of leaving a stale register value.
> +	 */
> +	if (!aux || aux->prog->aux !=3D aux)
> +		return -EINVAL;
> +	if (a > 0)
>  		return a;
>  	return -EINVAL;
>  }

[Severity: Medium]
Can dereferencing aux->prog->aux crash the kernel when aux holds a stale
non-NULL register value?

If the verifier fails to inject aux (for instance, in
implicit_arg_after_may_goto where timed may_goto expansion leaves a
per-CPU struct bpf_timed_may_goto pointer in R2, or when R2 holds a stale
scalar), directly reading aux->prog and aux->prog->aux will fault or read
out of bounds instead of returning -EINVAL.  Using
copy_from_kernel_nofault() for both pointer reads would safely reject
arbitrary stale values.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123055708.6841=
07-1-chenyuan_fl@163.com?part=3D2
