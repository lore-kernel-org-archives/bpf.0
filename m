Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E133921DD
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280752; cv=none; b=M7B2hWSwDpBCL1BXNxdmx5WCyhu2uu1N55UhWCcLN/tETvQ9WzBB6o7l87V1oi+KokBm2kRV9BXfjic8TLvcPlBzEnwEaL/JYKDhSBhBfSMH0QfH8A1XDKlaw9NhRJgtLsVmha5MMYnqyz7B+jOujCtA7pbjOkDFqpat97WGwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280752; c=relaxed/simple;
	bh=eE1uYz2bui8rZZo0lWbvVAcQhxanlMXujdIGGLz3ytM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jpu0wvJXv9M5+lrJw6jWHHcllnlrDFzvVK07DUa6YAOy5PA009GzVLQudCpfhexoXSZ9/z2h8NZ0tzmyHw642cQf4ZmnWXtKrwCFh7ZtMkWeYQf0cRxhi1UoEmI2CEDJvEbmE/pBGILE2zksqcBjZldrwsfeUu3EbSJ2mhOlJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMgymxXt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMgymxXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93952C2BCB0;
	Fri,  8 May 2026 22:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280752;
	bh=eE1uYz2bui8rZZo0lWbvVAcQhxanlMXujdIGGLz3ytM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eMgymxXtgivp90QgQ3AIHhiKRWQsi119Su9PTRp4Wx3bEKi2eASx4u5ZpR2Rg2Qqk
	 mYRjR5g9VwwMWcWn4N0Aus0RpRNPIRzynn+XWazVLn6ffF0P7dEug0IG0HufDtqKcc
	 gYx5FGAjF86g5rSWM1RC3fj5AUXQToBTKLPIvDbSnLv48Hq5QZjbBk9TpieeRNkN/B
	 OUxqRR3fcvEMcSjG5Nud3y16YPiN0sbfdltR4z8ZhWGKltyARh6jJVBW2p27fb7gJJ
	 yOBvuX3c34pQZ6T8j7RSSYfkbD3ihE3+15ZZpnzBLKY41xCmRmyxf35N+5vwl1DnpP
	 /rod1Ape0JEUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] samples: bpf: add mthp_ext
Reply-To: sashiko@lists.linux.dev
To: "Vernon Yang" <vernon2gm@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508150055.680136-5-vernon2gm@gmail.com>
References: <20260508150055.680136-5-vernon2gm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 22:52:32 +0000
Message-Id: <20260508225232.93952C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Small memory processes bypass the 4KB fallback rule due to a fault=
y condition that excludes zero memory usage.
- [High] The cgroup memory check is indefinitely bypassed for cgroups that =
do not experience memory pressure because a stall value of `0` is treated a=
s uninitialized.
- [Medium] The BPF program submits uninitialized memory to the ring buffer =
if reading the cgroup name fails, which can crash the userspace handler.
- [Medium] The global `exiting` flag is accessed locklessly without the `vo=
latile sig_atomic_t` qualifier, potentially leading to an infinite loop.
--

commit d747c2eece6f13195b37f744a5f3e9fd6d9a2c95
Author: Vernon Yang <yanglincheng@kylinos.cn>

samples: bpf: add mthp_ext

Design mthp_ext case to address real workload issues by adjusting mTHP size
via a cgroup BPF program.

> diff --git a/samples/bpf/mthp_ext.bpf.c b/samples/bpf/mthp_ext.bpf.c
> new file mode 100644
> --- /dev/null
> +++ b/samples/bpf/mthp_ext.bpf.c
[ ... ]
> +SEC("iter.s/cgroup")
> +int cgroup_scan(struct bpf_iter__cgroup *ctx)
> +{
[ ... ]
> +	bpf_cgroup_flush_stats(cgrp);
> +	curr_stall =3D bpf_cgroup_stall(cgrp, PSI_MEM_FULL);
> +	if (!info->stall) {

Does this logic unintentionally bypass the memory check for cgroups without
memory pressure?

bpf_cgroup_stall() can return exactly 0 for cgroups that have not experienc=
ed
any memory pressure. If curr_stall is 0, info->stall will be set to 0.

On subsequent scans, !info->stall will evaluate to true again, continuously
resetting the order to PMD_ORDER and skipping the memory size evaluation
below.

> +		info->order =3D configs.init_order;
> +		goto UPDATE;
> +	}
> +	delta =3D curr_stall - info->stall;
> +	bpf_mem_cgroup_flush_stats(memcg);
> +	curr_mem =3D bpf_mem_cgroup_page_state(memcg, NR_ANON_MAPPED) +
> +		   bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
> +	if ((curr_mem && curr_mem < FROM_MB(configs.min_mem)) ||

Could this condition allow new processes to bypass the 4KB fallback rule?

When a process starts and has not faulted in any anonymous or shmem memory,
its memory usage is 0. The curr_mem && check causes this to evaluate to fal=
se,
falling through to the else branch and assigning PMD_ORDER.

This seems to allow small or starting processes to allocate 2MB huge pages
for their first allocations instead of falling back to 4KB.

> +	     delta >=3D configs.threshold)
> +		info->order =3D 0;
> +	else
> +		info->order =3D PMD_ORDER;
> +
> +	if (configs.debug) {
> +		e =3D bpf_ringbuf_reserve(&events, sizeof(*e), 0);
> +		if (e) {
> +			e->prev_stall =3D info->stall;
> +			e->curr_stall =3D curr_stall;
> +			e->delta =3D delta;
> +			e->mem =3D curr_mem;
> +			e->order =3D info->order;
> +			bpf_probe_read_kernel_str(e->name, sizeof(e->name),
> +						  cgrp->kn->name);

Is it possible for e->name to contain uninitialized garbage if
bpf_probe_read_kernel_str() fails?

bpf_ringbuf_reserve() does not zero-initialize the memory. If the string
read fails, e->name might lack a null terminator. This could cause a
segmentation fault in the userspace daemon when it processes the event using
printf.

> +			bpf_ringbuf_submit(e, 0);
> +		}
> +	}
[ ... ]
> diff --git a/samples/bpf/mthp_ext.c b/samples/bpf/mthp_ext.c
> new file mode 100644
> --- /dev/null
> +++ b/samples/bpf/mthp_ext.c
[ ... ]
> +static bool exiting;

Should this be declared as volatile sig_atomic_t?

Since exiting is modified asynchronously in the signal handler and read in =
the
while (!exiting) loops, an optimizing compiler might hoist the read out of
the loop. This could potentially cause the program to hang indefinitely
instead of exiting on a signal.

> +
> +static void usage(const char *name)
> +{
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508150055.6801=
36-1-vernon2gm@gmail.com?part=3D4
