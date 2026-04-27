Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A08119644B
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777251416; cv=none; b=UA7gkQlNGt6hwCUlfPk/TbMIPwrxfCWHL/ovYvhZLPJDxlAEqnmsWJhSqU+y0s62KhQujr7GXh/AyAEaD2SS9jc0aQ1Tl56vovzmakjRDt0qJ8shjj2K6g0HjzA12EAKXYxMCh+e/Y3V/Hw6WVP6rRr7oBHmxTSARIvDfGk084Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777251416; c=relaxed/simple;
	bh=u9Dj5PwPbPo1HzLPjczikUiPLNhjYUOhpPSlI5fjnQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bbt3ukggPLptjyFUzxifmpYR/gJU+L570uV+bAwoW4jCae8sZWLAafnghuXW1LiAZpLDwhz64GJLb/gOfQjl3yrQeXfC2MPISTgj42zBkNE8tszLtsAaQEVoV5Q1IGL2H1gRHIoHhV0D30ASZnL5DWVvLItBAVfhN5V4Nl9Qpek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O47RYL2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O47RYL2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B96CC2BCAF;
	Mon, 27 Apr 2026 00:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777251415;
	bh=u9Dj5PwPbPo1HzLPjczikUiPLNhjYUOhpPSlI5fjnQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O47RYL2um9hoj2XQr+ASRkc+HhyE00KsGMOtGxFk/6a8k3dH2CZoygBUQLxo/zDBl
	 XTXVsSbWgFDn2rbS+MmiwpQOqALfMplk9eG/C4QiDptCWYIUAWAxRue901MenfLKLd
	 TWMMelT6psXhoR4eqBCx2KhlwRiHJnYvbqXa7ocDS3/bpdJqX2LBfdKwmgKwSDRZAH
	 UqlozUTlsLLvkhvUKBpnsX0nzMgoOnM0HH9HCyoTIbOohaRbdC3A8HDc+/oafb7i6u
	 dO7vl76EppWq8Zt3LNNrkmx08tfu/68N2tl6Z7KFjKust5ziFd9L+RBkDgMEoLlRt0
	 GV3MtJONfG9Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Reply-To: sashiko@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427001602.38353-2-dwindsor@gmail.com>
References: <20260427001602.38353-2-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 00:56:55 +0000
Message-Id: <20260427005655.9B96CC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] BPF programs can trigger a heap buffer overflow by calling bpf=
_init_inode_xattr multiple times.
- [Critical] Context spoofing via backward jump leads to arbitrary kernel m=
emory read/write.
- [High] Storing name__str directly into the xattr array leads to a Use-Aft=
er-Free during filesystem operations.
- [High] Missing prefix validation on the xattr name allows BPF programs to=
 spoof standard security xattrs.
--

commit 40ce6a42efab6a64fca9ea5bd1aec81b4faa93f2
Author: David Windsor <dwindsor@gmail.com>

bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling

Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
xattrs via inode_init_security hook using lsm_get_xattr_slot().

Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-Octo=
ber/034878.html [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D6bcdfd2cac55 [2]

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
[ ... ]
> @@ -353,6 +354,68 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup =
*cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
> =20
> +/* Called from the verifier fixup of bpf_init_inode_xattr(). */
> +__bpf_kfunc int bpf_init_inode_xattr_impl(struct xattr *xattrs, int *xat=
tr_count,
> +					  const char *name__str,
> +					  const struct bpf_dynptr *value_p)
> +{
[ ... ]
> +	name_len =3D strlen(name__str);
> +	if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> +		return -EINVAL;

Does this code need to validate the xattr prefix? Other BPF xattr kfuncs
enforce a prefix like "security.bpf." to prevent interfering with other
security modules.=20

Without this validation, could a BPF program pass a name like "selinux" and
inadvertently spoof standard security xattrs?

[ ... ]
> +	xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
> +	if (!xattr) {
> +		kfree(xattr_value);
> +		return -ENOSPC;
> +	}
> +
> +	xattr->name =3D name__str;

Can this result in a use-after-free of the name string? The name__str
argument typically resides in a BPF map.=20

Since the filesystem's initxattrs callback can perform disk I/O and sleep
after the BPF hook completes, what happens if the BPF program is unloaded
and its maps are freed concurrently?=20

The name pointer might then point to freed memory when the filesystem
attempts to write the xattr.

> +	xattr->value =3D xattr_value;
> +	xattr->value_len =3D value_len;
> +
> +	return 0;
> +}
[ ... ]
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -725,6 +725,26 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env=
 *env)
>  		}
>  	}
> =20
> +	if (env->needs_ctx_spill) {
> +		if (epilogue_cnt) {
> +			/* gen_epilogue already saved ctx to the stack */
> +			env->ctx_stack_off =3D -(s16)subprogs[0].stack_depth;
> +		} else {
> +			cnt =3D 0;
> +			subprogs[0].stack_depth +=3D 8;
> +			env->ctx_stack_off =3D -(s16)subprogs[0].stack_depth;
> +			insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_FP,
> +						      BPF_REG_1,
> +						      env->ctx_stack_off);
> +			insn_buf[cnt++] =3D env->prog->insnsi[0];

Is it safe to prepend the context spill instruction at the beginning of the
program? Because the original BPF program does not use R1, the verifier's
liveness analysis will mark R1 as dead at the start of the program.

If a BPF program writes a user-controlled pointer into R1 and creates a
bounded loop jumping back to the start of the program, could it trick the
verifier into accepting the jump and saving a fake context to the stack slo=
t?=20

This could allow the kfunc fixup to extract xattrs and xattr_count from an
attacker-controlled pointer, potentially leading to arbitrary kernel memory
reads or writes.

> +			new_prog =3D bpf_patch_insn_data(env, 0, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
[ ... ]
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
[ ... ]
> @@ -28,8 +28,11 @@ static int __init bpf_lsm_init(void)
>  	return 0;
>  }
> =20
> +#define BPF_LSM_INODE_INIT_XATTRS 1
> +
>  struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init =3D {
>  	.lbs_inode =3D sizeof(struct bpf_storage_blob),
> +	.lbs_xattr_count =3D BPF_LSM_INODE_INIT_XATTRS,
>  };

Because lbs_xattr_count is set to 1, security_inode_init_security() will
allocate exactly 1 xattr slot for BPF LSMs.

Since a BPF program could call bpf_init_inode_xattr() multiple times, and
lsm_get_xattr_slot() increments the slot index without bounds checking,
could multiple calls write past the end of the new_xattrs heap array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427001602.3835=
3-1-dwindsor@gmail.com?part=3D1
