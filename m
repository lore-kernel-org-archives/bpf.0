Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E73033CB
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573423; cv=none; b=oWK0Tlpp8gobpvPN4D9c15X0975hnsXR+NcRhtRb0VemLhNRV5UqL8rAL82vyeI4Feg5ysCOFA3FVtfW3nWDza9R12qfiMUXCLcectd0WY54aDfUK1xlN3fSoVkb8m2Cg8GXkBq9TMYG8sVDjbU+/ebuDPXWsUCQbocdOjwbnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573423; c=relaxed/simple;
	bh=4l9Yd1J4VNpALFE41MXDKgnDV/o6JJAJddNMPFqE0wI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O0EiuMcPiCZnwtMUVFiyp7MeDsGAUidPEGqGzJ1ndiim2KIXN7phZHz2Vp9gSfvomMPl2OCd5aBaDkNLWB0LhdV5fYMN9spMhUKlXIVzc/TaEqn3m/1oGyT42t52sjFnHLnd9H6senEYR4QT8jb2Gc34ffoLNumzipuGuUtMC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIeqdK2V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIeqdK2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED241F00A3D;
	Sat,  5 Sep 2026 01:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573422;
	bh=iLmQhno0TZJUiMUU4eLIV6082vPvUA1P05H8vinUX84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bIeqdK2VuR3QIf/Axl4TU+xqcXNvFWNccoQkBGPuFdRSfzA/CZwhtHJv2o/2CGE8i
	 uW3CdxSnJ2EK4AYhvC8BgBJ5rpUUqqyPrLeoFDdlS2WO2mlmt0IhUj68khoj+TtAeX
	 UZeelBc4a6/Hdw/ZKUZTdBfzAynRK/DNzfHSV1VCdD0VIiSduD8K7EwJsDZ/8EIP7o
	 dluJh2qBCOS2YBBB17rKYPMl9IDhDeVWxo1WDqErR9b6xqCqNl4G7lEs8cWpFuQmrT
	 NcZ3tYu+cL/mBgj+yq1cobQWfwxWkIhH1hAgbp55QEQWoJMpH0Gh6I1xWvoY2oVaXx
	 /3xM9GzVtHjRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 1/2] bpf: Reject non-scalar bpf_loop iteration
 counts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260905014735.1452988-2-memxor@gmail.com>
References: <20260905014735.1452988-1-memxor@gmail.com>
 <20260905014735.1452988-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:57:01 +0000
Message-Id: <20260905015702.5ED241F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing negative bounds checks for enum array indices in memcg BPF=
 kfuncs (bpf_mem_cgroup_memory_events and bpf_mem_cgroup_vm_events).
--

commit 3f8d69cede626ae022617ccb30f54b8f41f90edd
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Reject non-scalar bpf_loop iteration counts

This commit fixes a verifier warning and subsequent panic triggered when
pointer values are passed to the bpf_loop() nr_loops argument. It
introduces ARG_SCALAR to ensure generic helper argument validation
rejects pointers before loop inlining and precision processing.

Link: https://lore.kernel.org/bpf/6a9ad24c.b5d4176b.238c3e.0001.GAE@google.=
com/

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3a7eb2185c354..591dfab3e706c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -894,6 +894,7 @@ enum bpf_arg_type {
> =20
>  	ARG_PTR_TO_CTX,		/* pointer to context */
>  	ARG_ANYTHING,		/* any (initialized) argument is ok */
> +	ARG_SCALAR,		/* scalar argument */

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the addition
of ARG_SCALAR and how the verifier handles scalar arguments, a pre-existing
missing bounds check was noticed in the memory cgroup kfuncs.

Could negative enum values passed by untrusted BPF programs cause an
out-of-bounds read in the memcg BPF kfuncs?

Looking at mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events():

	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);

And similarly in mm/bpf_memcontrol.c:bpf_mem_cgroup_vm_events(), which
exposes validation logic from mm/memcontrol.c:memcg_vm_event_item_valid():

	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;

	return !BAD_STAT_IDX(memcg_events_index(idx));

Because the BPF verifier enforces scalar types but does not validate enum
ranges, a BPF program can pass a negative integer as the event parameter.
The bounds checks use signed comparisons without a lower bound (< 0) check,
so negative values will bypass the validation (e.g., -1 >=3D 4 evaluates to
false).

Can this lead to an out-of-bounds array access on kernel memory when the
negative value is used as an index into memcg->memory_events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905014735.1452=
988-1-memxor@gmail.com?part=3D1
