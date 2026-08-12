Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00453392C27;
	Wed, 12 Aug 2026 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515904; cv=none; b=r3cxLJih17gHQhSZR6Tn8FhJdvDsXLR+1G2AKA7auOmdVO7QyokoY4i99aq2xH/CsSXf4MDIo3La7xhWBchd7voF3Gm5uNiXIuBsPShh6TIx8Zv6gt+enQmtXyCgvBvq1cHt41eSYqdB3CXY4QqWzNptlWGRbgVKlIAEJJjBZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515904; c=relaxed/simple;
	bh=GcgOzyvq+rgW0Zel1dmFqyIjGKgWRa+jwmV30bcOcpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=da6hl006C6oK6bCbo/llIcZZbNwePJsX+L/slha0yklQXHVgC/g6/UhxcA9qGer8F6J0SjtuL3GFddtNq4GvjiLpm0UCcKIioa+cJRyw8CO3KYH1d6b56/UzdJ2t0YqYYwIrxPCAqHj7ErC+00aDaVss+G1BbXPVHeOlyjz8Iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ5PSVXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ5PSVXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3411E1F000E9;
	Wed, 12 Aug 2026 06:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786515899;
	bh=DQ/BTrQU4EqQQ8+h94Z+NBR8sj5syN4BZZhG22m1K64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQ5PSVXC6TaKCJRqgBNJIr+TOdu+VXULM1Q2XS8bzFFD3F7LGh8HxXjVnAl9u13yH
	 wnSYy7dLjFioSoGoxAc66lCEJ0Z2DEJNxpFozvFhM8CCiszTUa+CZnaiH+q4aLEOYV
	 FBv7SBSEbasZwx6lS/MwiGKZz8CCrJpR/NIRVAQEyVMy7d0+2VgIhSPFMSleGAtt+l
	 AuGVe5PAHHNtrRFVBqH9LOcReCfFh2g90J2+tCXZwSrm0C78B65w88bidSUp6gRWmv
	 DMNLCa5zwf9EP26MIunV/uRs41PLlYzgPHtVtda+LCn43ddaYZJjTznCtYgeXPoVyK
	 kG1CYa6qpp0zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Gate cid kfuncs behind the SCX struct_ops
 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiurong Fang" <fangqiurong@kylinos.cn>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260812061116.2691443-1-fangqiurong@kylinos.cn>
References: <20260812061116.2691443-1-fangqiurong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:24:58 +0000
Message-Id: <20260812062459.3411E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing negative bounds checks in memory cgroup kfuncs (`bpf_mem_c=
group_memory_events` and `bpf_mem_cgroup_vm_events`) allow out-of-bounds ar=
ray access.
--

--- Patch [1]: [PATCH] sched_ext: Gate cid kfuncs behind the SCX struct_ops=
 check ---
commit 44e99221673a68d8565292bb70385d8d0629f96c
Author: fangqiurong <fangqiurong@kylinos.cn>
sched_ext: Gate cid kfuncs behind the SCX struct_ops check

This commit updates scx_kfunc_context_filter() to recognize scx_kfunc_ids_c=
id.
It ensures that cid kfuncs are properly restricted and cannot be called from
arbitrary struct_ops programs.

[ ... ]

While reviewing this, I noticed a pre-existing issue in the BPF memory
cgroup kfuncs.

In mm/bpf_memcontrol.c:

> __bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup =
*memcg,
> 						       enum memcg_memory_event event)
> {
> 	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
> 		return (unsigned long)-1;
>=20
> 	return atomic_long_read(&memcg->memory_events[event]);
> }

[Severity: High]
This is a pre-existing issue, but can a negative enum value bypass this bou=
nds
check?

If a BPF program passes a negative integer for the event argument, the BPF
verifier does not enforce enum ranges, allowing the negative value to reach
the kfunc.

Because the check event >=3D MEMCG_NR_MEMORY_EVENTS performs a signed compa=
rison,
would it evaluate to false for negative values and lead to an out-of-bounds
read of memcg->memory_events[event]?

In mm/memcontrol.c:

> bool memcg_vm_event_item_valid(enum vm_event_item idx)
> {
> 	if (idx >=3D NR_VM_EVENT_ITEMS)
> 		return false;
>=20
> 	return !BAD_STAT_IDX(memcg_events_index(idx));
> }

And in mm/bpf_memcontrol.c:

> __bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *mem=
cg,
> 						   enum vm_event_item event)
> {
> 	if (unlikely(!memcg_vm_event_item_valid(event)))
> 		return (unsigned long)-1;
>=20
> 	return memcg_events(memcg, event);
> }

[Severity: High]
This isn't a bug introduced by this patch, but does memcg_vm_event_item_val=
id()
also miss negative enum values?

Since the bounds check uses a signed comparison, a negative idx evaluates to
false for idx >=3D NR_VM_EVENT_ITEMS.

When bpf_mem_cgroup_vm_events() passes an unfiltered enum to this helper, c=
ould
this result in an out-of-bounds read in memcg_events_index(idx) or
memcg_events()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812061116.2691=
443-1-fangqiurong@kylinos.cn?part=3D1
