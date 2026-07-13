Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822A3164D8;
	Mon, 13 Jul 2026 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911501; cv=none; b=iLE7TIKwDmnCqWhUvP4UABFIToLFw5vqL1c+jBhblEoM+GaQGt/Wwlvi9Suzk1fAjvsJbu/gt+fZZ66ZsxqHaXZPETXPOeIx0zueKS1B4dqze9hw8GxonvuAtSnsWpxx2zWAYrGb7tCtfwbAo+JHJ+UYFijG0KFilITu4M3Yryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911501; c=relaxed/simple;
	bh=1qnQwtrnZ3iuhLpQOci/811WEm+7zlzEYwAEB+PqJeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lCrfL6ZixWUg2TxoTq2VXgdItdpiSnVgN7Iq7hVc6ft+OV3KR6jcTmHVtN4WgT+p7xRpK1tObEw7K6ffC8I8498YB4tu1U2iVwOt0aGUdCF39Gv8XRDgXHEXoZBf6JMhkkeg6RJt3p06lKWtQ8Q7G8YABLVgZ10e1YMZ5wppo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqezkPBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqezkPBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A302C1F000E9;
	Mon, 13 Jul 2026 02:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783911499;
	bh=gUliRMgy08p0JS/yD8cg3tmpQyN+I3IMYF8QggJAZbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqezkPBluODLRr8vDACBqPqHEU7v3x0VpYMAd9wpbuaU9uOa0YMOFOpCk1/QF7sQx
	 +Pr3Bb7iYu5LxAExrFPf5lTcCJYLGJz9J0izvV98SGgz8FThzSa/F11P616laU8nzn
	 /CLIrZnoa7Fe1+QzsYFTvJzL9g8D2MCLHWX4c1CEXc4uaZOu4ftFYXrTbxZCP8M23x
	 iJPYL9c3z3b10RLjwePnVKNDYU7KfYhSmMOl8vJELh2Ou8DcEOTHei3GMCY94BA1cc
	 CGH9isVsBrCWYcJbPriRJZbQOh3GE8tpRvPvCaOQO6VeCHUGP9hbNWjeUJf7ifBRAa
	 xvJlFBPf30XKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHSET SLOP RFC 1/6] bpf: Support __arena suffix for kfunc
 arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260713024414.3759854-2-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
 <20260713024414.3759854-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 02:58:19 +0000
Message-Id: <20260713025819.A302C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The verifier skips size and bounds checks for `__arena` kfunc argu=
ments, relying entirely on a 32KB hardware guard region. This allows a mali=
cious BPF program to overshoot the guard region and cause a kernel oops by =
passing an offset that results in reading or writing a large struct or buff=
er.
--

--- Patch [1]: [PATCHSET SLOP RFC 1/6] bpf: Support __arena suffix for kfun=
c arguments ---
commit 228de70b9e4499793706318f5047bb9d51313346
Author: Tejun Heo <tj@kernel.org>

bpf: Support __arena suffix for kfunc arguments
   =20
This patch adds the __arena suffix for kfunc arguments, allowing BPF
programs to pass arena pointers directly to kfuncs. The verifier rebases
the register at the call site, avoiding the need for open-coded translation
in every kfunc.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6515d4d3c0032..71d1459c8f2a0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11975,6 +11980,32 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
> =20
> +		if (is_kfunc_arg_arena(btf, &args[i])) {
> +			t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> +			if (verifier_bug_if(!btf_type_is_ptr(t), env,
> +					    "kfunc %s arg#%d has __arena tag on non-pointer",
> +					    func_name, i))
> +				return -EFAULT;

[ ... ]

> +			if (reg->type !=3D PTR_TO_ARENA && reg->type !=3D SCALAR_VALUE) {
> +				verbose(env, "%s is not a pointer to arena or scalar\n",
> +					reg_arg_name(env, argno));
> +				return -EINVAL;
> +			}
> +			cur_aux(env)->arg_arena_regs |=3D BIT(regno - BPF_REG_1);
> +			continue;
> +		}

[Severity: High]
Does skipping the rest of the checks here bypass BTF memory size and buffer
bounds tracking for __arena arguments?

Because this relies entirely on the hardware guard region to catch out-of-b=
ounds
accesses, could a BPF program pass an offset close to the 4GB arena limit=20
(like 4GB - 1) to a kfunc that takes a large struct or buffer size paramete=
r?

The fault handler strictly limits recovery to the 4GB limit plus a 32KB
guard region:

kernel/bpf/arena.c:bpf_arena_handle_page_fault() {
    ...
    if (page_addr < kbase || page_addr >=3D kbase + SZ_4G + GUARD_SZ / 2)
        return false;
    ...
}

If a kfunc access extends beyond this guard region, it seems like it would
bypass the fault handler and cause a kernel oops or memory corruption.

Should there be size validation for __arena arguments similar to other memo=
ry
pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713024414.3759=
854-1-tj@kernel.org?part=3D1
