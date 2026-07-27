Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE99245020
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193594; cv=none; b=FmlFycxKWWu3o707fAFKbpHkXulYLu6g/q0aAoSbMfRz8MsA5Ramb0W1DSC0kK8vTXPbBB0aHld+gMLwb4LTfgGmtSo3aE9yhcEyCNrIvw5Gke8mYYgp8ExefxwIQ8U0k5yUY4Bwv4ZLHb/QoI1/0dRWPfxmTiw3sk1klmf2g2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193594; c=relaxed/simple;
	bh=gzUQIxfwqjSvLKJUfI/UqUSw2Py72ZzfgKJ1HvIyFyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QKAtp+8SDEsWaluMqzqvmeVzctq6LPXK88VwhLY8Qn08ibwifRXwDfGIixM5lD5uW8/jzRaRh+9xEyr1JTHyruFdLcBVxTppnPZLftlPxW7D1CqBTyVz/U72YwnMw071Nv2d8uIiXeynhmsC6uGA3eqSmdo0jz/7Wn6VzJVnYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2bZViSW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2bZViSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531791F000E9;
	Mon, 27 Jul 2026 23:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785193592;
	bh=Tz5RX2mIQmVJ3PEKnx9CB5RENZWwJ6LjrMshMJI0WuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O2bZViSWq4ToA6CJH/2ej1HE0HA/leG49Dc1NDUZ5LmuplBDLC0/cIg6sYdnNKcpI
	 CUTmD2K2pbufOAlVPg9gCAaJUQnSRskqrPlrSTV6pYD06Sj/fdcS+r+g4ZmCgOOacE
	 5qSWV+ApHzWfl9lWUatsEPjbw+Pha5o+81OSS31BM1WfTzd84Dwhyf0YySFMh4uOTQ
	 XIUvDdqC5MZdnqTiUmxwe+uj/hRBs6MayvQSpE5D4qBRXgI10QKQmAz2RU71s7ZGUs
	 XYbY4S+YviJt8mdUXL14C+2b2p9XQbjc9DZw+vzU08s3gQHHXMrjTZsctmiO7OmDCn
	 9n81iOCc3a2jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 1/6] bpf: Support for hardening against JIT
 spraying
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-1-eb80dcf1eb6e@linux.intel.com>
References: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com>
 <20260727-cbpf-jit-spray-hardening-6-1-y-v1-1-eb80dcf1eb6e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 23:06:31 +0000
Message-Id: <20260727230632.531791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bypass of Branch Target Injection (BTI) mitigation for large privi=
leged BPF programs.
--

--- Patch [1]: [PATCH 6.1.y 1/6] bpf: Support for hardening against JIT spr=
aying ---
commit fb6a9b4dae84aa5261afa7957906d80fe46316c4
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Support for hardening against JIT spraying

This commit introduces a mitigation against JIT spraying by flushing the=20
indirect branch predictors before reusing JIT memory. It adds=20
bpf_arch_pred_flush to flush predictors when allocating space from=20
reused packs. For allocations larger than a pack, the flush is skipped.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 77044d4a80cc1..4643554c6e3a9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -905,6 +915,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hol=
e_t bpf_fill_ill_insns)
> =20
>  	mutex_lock(&pack_mutex);
>  	if (size > BPF_PROG_PACK_SIZE) {
> +		/*
> +		 * Allocations larger than a pack get their own pages, and
> +		 * predictors are not flushed for such allocation. This is only
> +		 * safe because cBPF programs (the unprivileged attack surface)
> +		 * are bounded well below a pack size.
> +		 */
> +		if (static_branch_unlikely(&bpf_pred_flush_enabled))
> +			pr_warn_once("BPF: Predictors not flushed for allocations greater tha=
n BPF_PROG_PACK_SIZE\n");
>  		size =3D round_up(size, PAGE_SIZE);
>  		ptr =3D module_alloc(size);
>  		if (ptr) {

[Severity: High]
Does skipping the flush here leave large privileged eBPF programs vulnerable
to Branch Target Injection (BTI) if they reuse memory previously occupied by
an attacker's smaller cBPF programs?

If an unprivileged attacker loads many small cBPF programs, they can cause
the allocator to allocate a new pack via module_alloc(). The attacker can
then train the CPU branch predictor at the virtual addresses within this pa=
ck.

When the attacker unloads the programs, the pack is emptied and returned to
the vmalloc pool.

If a privileged user then loads a large eBPF program (> BPF_PROG_PACK_SIZE),
bpf_prog_pack_alloc() will call module_alloc() directly. The vmalloc
allocator could return the exact same virtual address range previously
poisoned by the attacker.

Because the new allocation size is > BPF_PROG_PACK_SIZE, this code skips
calling bpf_arch_pred_flush(). Does this mean the safety of skipping the
flush depends on the size of the *new* program rather than the size of the
*old* program that previously occupied the memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-cbpf-jit-s=
pray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com?part=3D1
