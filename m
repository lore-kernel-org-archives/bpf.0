Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87A27F4F5
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777829120; cv=none; b=S/ev7YLhwREVFx3vY5r8r2fJQUn5vk2HqqH0YCfGe+suvPzVWYKZ9emogqq7E4TVwMwnIBtcmYQYf7PHXeUVGVSVOeoTRmhinvErc7vAsbsu3/iK86RfCkJE+4loe5XeogQBGmAXqhXHG43NE1Yk09q73inAa5eTHh/U/i/qUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777829120; c=relaxed/simple;
	bh=hQ3hCAXJpY6cLbIx0im6n8Zbo4chUV1RAVc/tQAWWsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DXIMeI5BE8FIJSshvs5wG/HvN0y+5zUvs7KF4ZKin06VLu7OJ3s60vz7Ullb9w51UlQHiJF015qQp0YOBLQfpiDSkM36u7dRvZ2p9jyq7NZLrV2dIZDVj1epbZyi5Eb0lYYd6ugJLhtFuPGKfn5kYH56368BiqjzLr2UdspB/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeQrTiwR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeQrTiwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376AAC2BCB4;
	Sun,  3 May 2026 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777829120;
	bh=hQ3hCAXJpY6cLbIx0im6n8Zbo4chUV1RAVc/tQAWWsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TeQrTiwRgB2SNTx5hjYrjjGyKyb8DqJGgSrdeLCb7D+ILPeECsDsR5vaPNR6lTJrg
	 PW+2JV8NgndRBCZBABXXxRxs2NxWVbHp85DDmqffXvZRF4rbs8l/niGVFsyWmigV/w
	 Q0SIhyoErLs5RpX6y4ATleAm9BTH6EfG664jDIAuY047/0fCdl+tlOeMEYtSA6eWII
	 41hM06df9H5nFURgjFMYqSClKCYAw5t78eWhVbDWac2930U43n6hP/Q2jFaz9onJ5S
	 ZHUmlURd5Ywj/aUOLx9YQRhJk7gunbP9xMVjkwpLcvAg95FCg8exi3o/kKFcmfpLMo
	 AOPuZfREuttIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] bpf: add bpf_cgroup_{flush_stats,stall} function
Reply-To: sashiko@lists.linux.dev
To: "Vernon Yang" <vernon2gm@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503165024.1526680-3-vernon2gm@gmail.com>
References: <20260503165024.1526680-3-vernon2gm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 17:25:19 +0000
Message-Id: <20260503172520.376AAC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing bounds check on the `states` enum parameter in `bpf_cgroup=
_stall` allows out-of-bounds memory access.
- [High] Both `bpf_cgroup_stall` and `bpf_cgroup_flush_stats` unconditional=
ly dereference the pointer returned by `cgroup_psi()`, which can be NULL.
- [High] Compilation fails when `CONFIG_CGROUPS=3Dy` but `CONFIG_PSI=3Dn`.
- [Medium] The `bpf_cgroup_stall` function truncates its 64-bit return valu=
e on 32-bit architectures.
--

commit 11e75919a882d61e2b11423881cab05305d77c18
Author: Vernon Yang <yanglincheng@kylinos.cn>

bpf: add bpf_cgroup_{flush_stats,stall} function

Add bpf_cgroup_{flush_stats,stall} function to prepare for the
subsequent mthp_ext ebpf program.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c266..87f3072adce3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2819,6 +2820,32 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 =
cgid)
>  	return cgrp;
>  }
> =20
> +/**
> + * bpf_cgroup_stall - acquire the total stall time of cgroup
> + * @cgrp: cgroup struct
> + * @states: psi states
> + *
> + * Return the total stall time.
> + */
> +__bpf_kfunc unsigned long bpf_cgroup_stall(struct cgroup *cgrp,
> +					   enum psi_states states)

Is it possible that div_u64() returns a 64-bit value that gets truncated
here on 32-bit architectures? Since unsigned long is 32 bits on those
systems, would changing the return type to u64 prevent the stall time
from wrapping around?

One more thing regarding the build, what happens when CONFIG_CGROUPS is
enabled but CONFIG_PSI is disabled? Since struct psi_group might be defined
as an empty struct without a total field in include/linux/psi_types.h, and
cgroup_psi() wouldn't be declared, would it be better to wrap these kfuncs
and their BTF_ID_FLAGS in an #ifdef CONFIG_PSI block?

> +{
> +	struct psi_group *group =3D cgroup_psi(cgrp);
> +
> +	return div_u64(group->total[PSI_AVGS][states], NSEC_PER_MSEC);

Could states be out of bounds here? Since the BPF verifier treats enum
parameters as unconstrained scalars, a BPF program might pass an arbitrary
or negative integer. Does this need a runtime bounds check like
states < 0 || states >=3D NR_PSI_STATES - 1 ?

Also, is it possible for group to be NULL? If cgroup PSI tracking is
disabled at runtime via the cgroup_disable=3Dpressure boot parameter,
cgroup_psi(cgrp) can return NULL for non-root cgroups. Does this dereference
of group->total need a NULL check first?

> +}
> +
> +/**
> + * bpf_cgroup_flush_stats - Flush cgroup's statistics
> + * @cgrp: cgroup struct
> + */
> +__bpf_kfunc void bpf_cgroup_flush_stats(struct cgroup *cgrp)
> +{
> +	struct psi_group *group =3D cgroup_psi(cgrp);
> +
> +	psi_group_flush_stats(group);

Similar to bpf_cgroup_stall(), if PSI tracking is disabled, group could
be NULL here. Since psi_group_flush_stats() might unconditionally acquire
a mutex, does this code need a NULL check on group to prevent a panic?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503165024.1526=
680-1-vernon2gm@gmail.com?part=3D2
