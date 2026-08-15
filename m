Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293DE3F54DF
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786777199; cv=none; b=mA9HTVgYk+Sck70jf1CsLuQLptV72907yz7Cp+lkZkv2NMhekqsVrttT7O9JaBaaEGw7jkgae+9eMTyalqb/4ZrpAqRj4SU22ZvplXbXp4GqSYqlyXvem48WRya99MVkZ8zPazsDHOVntqLJH5jADsy8vx+bGuVQPzckzd6qhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786777199; c=relaxed/simple;
	bh=aSqfcgAYwLOQEp1PvRqANBYyPLp6SxBS09oyq107Ukg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2NLo/BoUCsRLrYL0pdC4sVwTOOZiuf+O8mIUFt8ihtsMw0Gkivcy6fJyJoHbKQiIyyalE0QJMFUPO2YtlHwZ41JXh2sskOrW+xbWZOlBvrMjmDm+yOFJIv5u9c41HMNyeLQnUs4WvQivJeBvoAnnRLiDrqQDN4gJqUB5I17Klw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3/Fw2Sj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3/Fw2Sj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D2B1F000E9;
	Sat, 15 Aug 2026 06:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786777196;
	bh=hixlxX+uT8jrUYytWSMWRR1cmKBIGU4UXyI9dzik550=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C3/Fw2Sjl0afwkR+Al0pB1EKo/eva1mDYMqhNfPmKPkY+YN3lV4xyHnjaYxRAjQGL
	 Qp/wroz5l/J9/bxxGTrLFDh13KpjxG27uYPFSZ2vc82U7s8KSoiyP9W7zj3wMcs/BA
	 MVyDbTei8eQjXbu1g9ZYFXF7s1qi/VawUoj4gw80Lo+g/Sn4yBPJpoQaTRJAEiWKj8
	 bvoB+gCBcU4IxYe6Vc9wRBLvRKw1w67y3hVuVYLEyfOPnftakz4/dYXoDm+LLu5ZzL
	 QBg7uioW8H9blvmOm6MqtutF3bmIv44/ZGwJ5uKkB+tZasg1WIo4IPMiV5tC+mzk5y
	 Q6x5N6BuaPB0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 09/14] bpf: Report Memory Safety bounds
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260815064612.378577-10-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
 <20260815064612.378577-10-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 06:59:55 +0000
Message-Id: <20260815065956.49D2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf_diag_stack_read_uninit incorrectly diagnoses reads of specia=
l stack slots (e.g., STACK_DYNPTR) as uninitialized memory.
- [Medium] bpf_diag_memory incorrectly attributes variable stack access fai=
lures from atomic instructions to a 'helper function'.
--

--- Patch [9]: [PATCH bpf-next v5 09/14] bpf: Report Memory Safety bounds e=
rrors ---
commit 787129fefde67f039a1ddb3b85e61af60e79f8f2
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Memory Safety bounds errors

Augment selected memory-range verifier failures with Memory Safety reports
while preserving the existing terse verifier messages for compatibility.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3851,6 +3875,8 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
>  					} else {
>  						verbose(env, "invalid read from stack off %d+%d size %d\n",
>  							off, i, size);
> +						bpf_diag_stack_read_uninit(env, off, i,
> +									   size);
>  					}
>  					return -EACCES;
>  				}

[Severity: Medium]
Will this else branch also catch special stack slots like STACK_DYNPTR or
STACK_ITER?

If a BPF program directly reads a special stack slot, the verifier rejects
it because it contains opaque internal state. Does calling
bpf_diag_stack_read_uninit() here incorrectly diagnose these special slots
as uninitialized memory? This might lead users to incorrectly try using
CAP_PERFMON or initializing the memory, which would corrupt the underlying
object.

[ ... ]

> @@ -3909,6 +3935,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
>  			} else {
>  				verbose(env, "invalid read from stack off %d+%d size %d\n",
>  					off, i, size);
> +				bpf_diag_stack_read_uninit(env, off, i, size);
>  			}
>  			return -EACCES;
>  		}

[Severity: Medium]
Similar to the above, does this second else branch for non-spilled slots
also misdiagnose special slot reads as uninitialized memory?

[ ... ]

> @@ -4001,11 +4028,19 @@ static int check_stack_read(struct bpf_verifier_e=
nv *env,
>  	 * check_stack_read_fixed_off).
>  	 */
>  	if (dst_regno < 0 && var_off) {
> +		const char *reason;
>  		char tn_buf[48];
> =20
>  		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
>  		verbose(env, "variable offset stack pointer cannot be passed into help=
er function; var_off=3D%s off=3D%d size=3D%d\n",
>  			tn_buf, off, size);
> +		reason =3D bpf_diag_fmt(env,
> +				      "The helper would access the stack through variable offset %s =
plus fixed offset %d and size %d. "
> +			"Helper stack memory arguments require a constant stack offset and a =
precise initialized range.",
> +			tn_buf, off, size);
> +		bpf_diag_memory(
> +			env, env->insn_idx, "variable stack access", reason,
> +			"Use a fixed stack offset for helper memory arguments, or copy the ne=
eded bytes into a fixed stack slot first.");
>  		return -EACCES;
>  	}

[Severity: Medium]
Are we sure this condition is triggered by helper functions?

In check_stack_read(), a destination register less than 0 is triggered
exclusively by atomic instructions, not by helper functions which
instead use check_helper_mem_access().

Could this new diagnostic text falsely attribute atomic instruction failures
to helper functions and incorrectly suggest changes for helper memory
arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815064612.3785=
77-1-memxor@gmail.com?part=3D9
