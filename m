Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EA3AEB2D
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137135; cv=none; b=BUyERbpDaXedgt+lvotzkdarUpNgMTyyjsuxzIbjQHXkb8FqOucvzHznLhLcRjeLwOFKFEqymvDQIA/iKY+y9ef+Lsy/fkWX+IHZ06gnLTVJBJf95asxV9+n4BEcCAc7dnpuDdAaIQprJYyiVlcgG04NWmd4e1v2z6nUZ0A/vi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137135; c=relaxed/simple;
	bh=ZixzLe6UWMsqAvehv1EHJmSvzXHfjIY/fLOi1ZV0Lpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IFYHpmmEiai2+OOzwZE5o2io1iPV16gCPWq8Etc5Q+jBse/B6SeBGB2oES3VyDt4MpMQW9X9P4u7Mojl3g/wHcHLhqz7N+BcqmQsBR21IYE6+SP8HgAhHoc9OphxCQvPBZfSoAUKyF+9bAjHI6Xi/jroXHLb/FiKwuEGaWhCTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP8Jw4Ex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP8Jw4Ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886C81F00A3D;
	Wed, 15 Jul 2026 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784137133;
	bh=SuSIfszJ9n+UF4U2fd/MzwIjw2cihZQI1g52ZYzlDJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cP8Jw4Ex3az/0J9MdrHqhalpnMIS374naRXPz8K3Vu1lzJeBq7TeXXRHEWVYgW1qE
	 K9E29QYtQghdepa4E+g0EVk/fu9gh/oqHjjPJazMzisZKwH17s98xMq7Zwk0O7xdwj
	 3gRP76TRe5CAXb177QZsk21wyZnpFSSTWY5ILr79f0CT+FCgJlnaE2g0AbXghO4wQG
	 u49j5Or0k1e8mpbflYWiflZar0MjxKmoLxvzqX9tdqoKBGdRluP/Cw93HFSyJrurrs
	 xN9g+5nQh3z1F6KxMIZIXhdxY6YcYSuJrLienZAYvP8SfBdf3s0rGK03nWNmPY625i
	 typRNscAj4NEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Zero kfunc arg meta before error
 paths can read it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715172127.2416388-3-ameryhung@gmail.com>
References: <20260715172127.2416388-1-ameryhung@gmail.com>
 <20260715172127.2416388-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 17:38:53 +0000
Message-Id: <20260715173853.886C81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BPF kfuncs bpf_mem_cgroup_memory_events and bpf_mem_cgroup_vm_even=
ts do not handle negative enum values, bypassing bounds checks and allowing=
 out-of-bounds array reads.
--

--- Patch [2]: [PATCH bpf-next v1 2/2] bpf: Zero kfunc arg meta before erro=
r paths can read it ---
commit 53f60dae3990fbb436a03cb878e7564339ccd1e9
Author: Amery Hung <ameryhung@gmail.com>

bpf: Zero kfunc arg meta before error paths can read it

check_kfunc_call() reads meta.func_name when bpf_fetch_kfunc_arg_meta()
returns -EACCES, but that error can come from fetch_kfunc_meta() (e.g.
fd_array_get_btf() rejecting BTF binding for a signed program) before
meta is memset(), leaving it uninitialized and risking a garbage deref
in verbose().

Move the memset() to the start of bpf_fetch_kfunc_arg_meta() so meta is
zeroed on every error return. The intended "not allowed" -EACCES path
still sets func_name first, so its message is unchanged.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c87e5fec5a857..ddfa4f57016b7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but this is a pre-existing issue.
Do the bounds checks in bpf_mem_cgroup_memory_events() and
bpf_mem_cgroup_vm_events() properly handle negative values?

Since enums evaluate to signed integers in C, and the BPF verifier does
not enforce enum ranges, a BPF program could pass a negative value to
bpf_mem_cgroup_memory_events() in mm/bpf_memcontrol.c:

	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);

For a negative value, the bounds check above evaluates to false, which
allows an out-of-bounds read on the memory_events array.

Can a similar out-of-bounds read happen in bpf_mem_cgroup_vm_events()?

	if (unlikely(!memcg_vm_event_item_valid(event)))
		return (unsigned long)-1;

	return memcg_events(memcg, event);

The validation routine in mm/memcontrol.c uses the same signed comparison:

bool memcg_vm_event_item_valid(enum vm_event_item idx)
{
	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;

	return !BAD_STAT_IDX(memcg_events_index(idx));
}

This allows negative index values to reach memcg_events_index():

static inline int memcg_events_index(enum vm_event_item idx)
{
	return mem_cgroup_events_index[idx];
}

Could this allow a BPF program to read arbitrary out-of-bounds kernel memor=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715172127.2416=
388-1-ameryhung@gmail.com?part=3D2
