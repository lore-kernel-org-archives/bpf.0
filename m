Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE543ABD8D
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876741; cv=none; b=mz/lBfsmroSLmAEKyXQyO54S8JG83MbM4OFNRc23nUaAxkBYRqzkJxgpDX6O/BUuOhDV56xPZgYK8AKSbpHMnQqKxYuN34IZ9lGCDCzX67CiOoO9cLka3ULFIRfR+tJqhGtJ/QDTYfIA7OnMeUg5O+IdxBiRGL6B3XoQAy1MrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876741; c=relaxed/simple;
	bh=pB/2wR4iFMHFYu+7zqBTWCPOMOdzrvzbuAiHJzGCiZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ItvydhaSpunmLXwQOJST/dqb3kPAkCLhz6OaXhf6oigtN3Bms09hKevIrno+pZmJGZf42V42VvJ2oGxNeb+H1e5HgrFoDSNIJbF8okBujv10prOVKo+1Cs7A4wf2p69NmR/7G1yx0jFiCJW7snvGxs8PtBHn0UcsNdNsRIhfjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQx3nmg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQx3nmg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44AC1F000E9;
	Tue,  4 Aug 2026 20:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785876740;
	bh=WGAx2kA/aCQtyZMj5MmrKk3OTyyUPwTvjPrzmYNjCo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQx3nmg9nzKrY04eaghGTfrBSSZ9KnLTnHnp5or3E1u6HCI6qLaaWthJ7tWM/2JNk
	 1RbrLE6tpitQDywKog12DHRsgMXb5wh46Td2oRwTolsE5oLooVkTcaRDMXbjGzoBLq
	 h+uqXOa2OoSvmOOXPgonS/ezLe1zq0EaAjQW3H9I2BD1jm9V8bIgoxPpWWW6jy3peM
	 gBPWjzwnYXz2cY9qo+1vSbngOf01p0O8MI9vBJM6a+wMzDqNLc1hn5VKOwpLKyWzN/
	 YbnCyJ4HLb8bxOjn7aLIVCcBUNNSfVDcBXVQ8mB2WfqFwqju+jZTUXWewrOVnZEeVq
	 858l0y9O1oFdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 07/13] bpf: Add verifier support for 16-byte
 returns in R0:R2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804203558.1873903-1-yonghong.song@linux.dev>
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
 <20260804203558.1873903-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:52:19 +0000
Message-Id: <20260804205219.D44AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Kfuncs returning 9-15 byte structs leak uninitialized kernel mem=
ory via R2 because the verifier bypasses zero-extension.
--

--- Patch [7]: [PATCH bpf-next v2 07/13] bpf: Add verifier support for 16-b=
yte returns in R0:R2 ---
commit 5c235db7cbd600a1b91b24fbad96652d702b6b3a
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Add verifier support for 16-byte returns in R0:R2

This commit adds verifier support for returning values in two registers
(R0 and R2) for structures between 9 and 16 bytes or __int128. It adds
handling for subprogram and kfunc returns to map the second return
register to BPF_REG_2.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5584178a0e1c7..60b9e587e0947 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10859,6 +10901,22 @@ static void mark_btf_func_reg_size(struct bpf_ve=
rifier_env *env, u32 regno,
>  	return __mark_btf_func_reg_size(env, cur_regs(env), regno, reg_size);
>  }
> =20
> +/* Mark the register(s) holding a @size byte kfunc return value as unkno=
wn
> + * scalars. All of them are processed the same way, only the size differ=
s:
> + * a single register may hold a sub-register sized value, while both hal=
ves
> + * of a register pair are treated as 64-bit wide.
> + */
> +static void mark_kfunc_ret_regs(struct bpf_verifier_env *env,
> +				struct bpf_reg_state *regs, u32 size)
> +{
> +	u32 i, nregs =3D ret_regs_cnt(size);
> +
> +	for (i =3D 0; i < nregs; i++) {
> +		mark_reg_unknown(env, regs, ret_regs[i]);
> +		mark_ret_reg_size(env, regs, ret_regs[i], nregs =3D=3D 1 ? size : size=
of(u64));

[Severity: Medium]
For kfuncs returning a struct between 9 and 15 bytes in size, does
forcing sizeof(u64) for both return registers bypass zero-extension for R2?

If the native compiler only populates the lower bytes of the second return
register (e.g. RDX on x86_64) for a <16 byte struct, the upper bits will be
left uninitialized. However, setting the size to sizeof(u64) here sets
subreg_def to DEF_NOT_SUBREG for R2, which treats R2 as a fully initialized
64-bit scalar.

Since the verifier's zero-extension logic only supports zero-extending the
destination register (R0 for calls), couldn't a BPF program performing a
64-bit read of R2 leak up to 7 bytes of uninitialized kernel register state?

> +	}
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804203522.1869=
244-1-yonghong.song@linux.dev?part=3D7
