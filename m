Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB346EF73
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518208; cv=none; b=mo+TziWN+77+en4S7/YbMBn3S1e+nlyxa2HRrL85H+3EvrTptFr5ZXB0Djik81NGoNtpOn8LmvreDKH4RLHMGv3kD/VIHtGdg0i5GRUZNLB3SowZWfZh0NfSLAHyQBMSdgBI36mifOXd1b3AUgglPwZh6sQ1zQOMnkbARoNhza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518208; c=relaxed/simple;
	bh=xWWCXfeVUkRq+FP91OFE35aQUxmIItVcTHsmPcCn78c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ObJ0zlhiYR6hn2PK1J6L4erFfSB9K3F5yo8IVYovz/S+Hn2rrdC5M2Bknm2z4Kucg1sjlxfPj8Ig3dkmVnPyA3hoY2/SFrSxof5y197q7ZhnGPMNu60kv4WGXcNzNrVnqpNp9OJ+YUD1NwxQ1bGwGt/A4y4ekcopejkeKE8FaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hde4zZji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hde4zZji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AD41F00A3E;
	Fri,  4 Sep 2026 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518205;
	bh=tzL7yGZEni4U22ZGTi2LAkm3XsG1ctxklVAH0IlvxhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hde4zZjiRsu/LkbjJbxVULm2B4ROijgawJR3KE6MY5WhGRabsP/EW5sxjXE6UGdEI
	 MMoEgvkOgz7FZdZY+1fDn6vmEFHV3TlOPStgzCOqrKD2mXdN4eHNEer2hiMB0zv4dB
	 gSoZhSDc/3kuT9uoROq7f5ATjP85Gy8EI/aE62eT3IfseAxfeY28b7U5n82oU9AStR
	 Zob2JN/5XL06GsTSmbs9GpXE0e551pqS5NTKFt8dfmv2sBKF3stxeW1zKH8r4MCRD9
	 SqMixDFTM3Y9kMnUs51dBe+RoxtjgDvrQGYDxj6iDmHU8CLcjVjcSSh89uLbhZsGov
	 R1kMiue2xrYAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <7d8b77dc99ffe99a7bef874a257472fdaaf07e1c.1788516769.git.zhuhui@kylinos.cn>
References: <cover.1788516769.git.zhuhui@kylinos.cn>
 <7d8b77dc99ffe99a7bef874a257472fdaaf07e1c.1788516769.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:36:45 +0000
Message-Id: <20260904103645.B4AD41F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The kfuncs `bpf_mem_cgroup_memory_events` and `bpf_mem_cgroup_vm_e=
vents` perform out-of-bounds array reads when negative enum values are prov=
ided.
--

commit d1e15e132a96633de13a710a4e0aff1aa016fbaa
Author: Hui Zhu <zhuhui@kylinos.cn>

mm/bpf: Add bpf_proactive_reclaim kfunc

Add bpf_proactive_reclaim(), a sleepable kfunc which performs one
proactive reclaim pass on a given memory cgroup, similar to a write
to memory.reclaim but without retrying until the target is reached.
The kfunc is restricted to BPF_PROG_TYPE_SYSCALL to ensure it runs
in a clean process context.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..92f35ba66309e 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
[ ... ]
> @@ -171,22 +240,44 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events)

[Severity: High]
This is a pre-existing issue, but do the implementations of
bpf_mem_cgroup_memory_events() and bpf_mem_cgroup_vm_events() handle negati=
ve
enum values correctly?

The bounds check in bpf_mem_cgroup_memory_events() does not cast to unsigne=
d,
so a negative index bypasses the check:

mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events() {
	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);
}

Because the BPF verifier does not validate that scalar arguments fall within
valid enum ranges, a negative value passed from a BPF program can bypass
this check and cause an out-of-bounds read on the memory_events array.
This can overlap with the vmstats pointer in struct mem_cgroup, potentially
leaking a kernel heap pointer to the BPF program.

Similarly, bpf_mem_cgroup_vm_events() also appears to be affected, where
the upper-bounds check fails to filter out negative values before calling
memcg_events_index():

mm/memcontrol.c:memcg_vm_event_item_valid() {
	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;

	return !BAD_STAT_IDX(memcg_events_index(idx));
}

Which leads to an out-of-bounds array access using the negative index:

mm/memcontrol.c:memcg_events_index() {
	return mem_cgroup_events_index[idx];
}

Could we add proper lower bound checks or cast the index to unsigned before
comparing against the array size in these functions?

>  BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788516769.gi=
t.zhuhui@kylinos.cn?part=3D1
