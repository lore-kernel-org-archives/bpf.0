Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78A314A90
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786941742; cv=none; b=eqdKX5mOCxp03CkxO/N6xIXBh3dmkE2kOPHwcZswXU0sMpl4XwxpYiSgTNwqo/8Mkf5ey4fCgH8bTZJEEr9HAL3zxi2ofOJetS+es2BW8S1raqpezxdQ2k+9HhM4wpk6sixkRJiwxuwrFOTOVJJzDhvqhQiMhbqUzhbe9I0tZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786941742; c=relaxed/simple;
	bh=KfBOFcsR5C0wyl2xTsdbHvFliILBtdqmUArr4ky29B0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f7324DOAngf1rVrzoPAY7UXrLC2LTdgfRSffG+MHXN0N02+1kzMTEnXg8BtGkArW5ccYKSAjmJnMIaIpl5dnIKkXKG9tXZdOsHn1ekedwjPVDEdwf0J93+LvryZ1czNZmNtnIjBmxgRWrmla1STlySB0F3WKVvOMOWGjVCt3o/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXDPFcP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXDPFcP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F201F000E9;
	Mon, 17 Aug 2026 04:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786941740;
	bh=XRh98l79XCZXGX4A4E3VtOb6EesnGGqHDA/iW1HeQgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SXDPFcP64eaQjdJ7Pa/she/rMiPfa8sUgotzyb+6ijuXLlPsA2g3Gq3F8oCWR/8Sk
	 YSlanRPUI/4h+dup8BNuj3R4R2X2GLwT5ce3LhenkU1hHjUzcmXZ4AQOsJtQSroGXh
	 3bC2R0E3yfgE0UQ4+R/q1ll33GxWElXNtV4ttd5krTE/1fnBp8YPtCQCYc9+ydniFi
	 WyQZiSHztAVodTbwxiTclOBTNBHcErAN+SfnsJdc9eGPFvkxluIpaBkqKYAgIb7k8X
	 jZbgn81Oemg5NLH9035SZuNugL/oZXNyZ2SRCumISZeJDen/deGYGfbXpzAB8W24zl
	 9B1PqWajTCIzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 06/10] bpf: Add verifier support for 16-byte
 returns in R0:R2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817042212.2291498-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042212.2291498-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 04:42:19 +0000
Message-Id: <20260817044220.46F201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added support for kfuncs returning structs by value is=
 mathematically unreachable.
--

--- Patch [6]: [PATCH bpf-next v6 06/10] bpf: Add verifier support for 16-b=
yte returns in R0:R2 ---
commit 438f13b526c411cf77d7536a3436a0cc4625dbe4
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Add verifier support for 16-byte returns in R0:R2

This patch adds BPF verifier support for handling 16-byte returns in the
R0:R2 register pair, utilizing LLVM 23 capabilities. It models this
register pair at calls to global/static subprograms and kfuncs, allowing
kfuncs to return structs composed of scalars.

Link: https://github.com/llvm/llvm-project/pull/190894
Link: https://github.com/llvm/llvm-project/pull/206876

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13967,10 +13997,25 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>  	}
> =20
>  	if (btf_type_is_scalar(t)) {
> -		mark_reg_unknown(env, regs, BPF_REG_0);
> +		mark_kfunc_ret_regs(env, regs, t->size);
>  		if (meta.btf =3D=3D btf_vmlinux && (meta.func_id =3D=3D special_kfunc_=
list[KF_bpf_res_spin_lock] ||
>  		    meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsav=
e]))
>  			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
> +	} else if (btf_type_is_struct(t)) {

[Severity: Medium]
Is this newly added code for kfunc struct returns actually reachable
during program load?

Looking at how kfuncs are processed earlier in the verifier,
bpf_add_kfunc_call() calls btf_distill_func_proto(), which appears to
still explicitly reject struct return types:

kernel/bpf/btf.c:btf_distill_func_proto() {
    ...
    if (ret < 0 || btf_type_is_struct(t)) {
        bpf_log(log,
            "The function %s return type %s is unsupported.\n",
            tname, btf_type_str(t));
        return -EINVAL;
    }
    ...
}

Since btf_distill_func_proto() is called during program load before
check_kfunc_call() is ever reached, won't any BPF program calling a
struct-returning kfunc be unconditionally rejected, making this new
branch dead code?

> +		/*
> +		 * The returned struct comes back as raw register bits modeled
> +		 * as an unknown scalar, so it must contain only scalars:
> +		 * otherwise a pointer field would be laundered into a scalar
> +		 * and escape provenance and reference tracking.
> +		 */
> +		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
> +			verbose(env,
> +				"kernel function %s returns %s %s that is not composed of scalars\n",
> +				func_name, btf_type_str(t),
> +				btf_name_by_offset(desc_btf, t->name_off));
> +			return -EINVAL;
> +		}
> +		mark_kfunc_ret_regs(env, regs, t->size);
>  	} else if (btf_type_is_ptr(t)) {
>  		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817042141.2286=
086-1-yonghong.song@linux.dev?part=3D6
