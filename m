Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A2352016
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295683; cv=none; b=bMah9KblIF1uq5phdMgWiVOPFgZ9vW/fX5MSlxsHL5c75FP7YmcAEtySUzNsvslKCAqRsj1cMD+qpHcmGdfCKCx2H32i+uuPN8sUYfN/xLJUnagb3X2oFsBvZPuh8SoXAgyUHIezvekGC+WCHFsPAnlWe8Is8rUQ3tDq9HLoUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295683; c=relaxed/simple;
	bh=32pVRbyiEd3/R9KQTVcPzzVm1pXR2GMD02yo8TRky5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WjYCn1JpJuML650ml+cPfxO5pCzFRVji5t07BtqZh71/Fv7YNqKrqXu+EHDrLDUWO9Ml6699s+4Z3mA9/KRc+GIyzhY/sJ+XYb7O2IUeivuIiCJk7Rp68c9pu6N8BJ6c4pboVYhVK2tMxOyg2Vywk1HwLi7IOIWfWvSikLQRMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUjPBhmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUjPBhmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA361F00893;
	Wed, 20 May 2026 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779295682;
	bh=SEQaibynUeVPoHo/5tHgF/b2OywqW/qQXDLPqXWMt8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FUjPBhmmikLdWWtYKkK5FYwI6LbaUT00CT76uyyoMRCQjxbfoLFliFpYS03ubZTAQ
	 iUq7B6RmQphGniA8O4aIPcCSTqHLEAx4dF+4TLSdEj+a7updmlZPbfWn36X3S5Z0Sy
	 eyGPIDxTX8aK9+YqPzIuKngGh8GAV4i2THhkXxQu0T+E5qHcJAlE1KzB4U1p9Gbukg
	 20YaPD3zHeUb6c/cE0cYKYFnrm0kLCzSZmNz7QGSGZ8+6Nhkx4xc+qkHttieo2q9Eb
	 BnHWhMzKegewR2A+XEGiCD9S20eRJIPpObyuPx4Q2xDwNHM1eIBn78nH0ItYUogdJP
	 jY4N1wEx+WIew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 17/20] unwind_user/sframe: Separate reading of FRE
 from reading of FRE data words
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-18-jremus@linux.ibm.com>
References: <20260520154004.3845823-18-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:48:01 +0000
Message-Id: <20260520164802.0AA361F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `sframe_mt` maple tree is initialized without `MT_FLAGS_US=
E_RCU`. As a result, maple tree nodes are freed synchronously via `kmem_cac=
he_free()` instead of being deferred by RCU. Lockless concurrent readers us=
ing `mtree_load()` (or `mt_for_each()`) can encounter a Use-After-Free if a=
nother thread concurrently executes `sframe_remove_section()`.
--

commit 9c045164b82cb49d5d976dfee059454643b1da0a
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/sframe: Separate reading of FRE from reading of FRE data words

__find_fre() performs linear search for a matching SFrame FRE for a given I=
P.
For that purpose it uses __read_fre(), which reads the whole FRE.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 48709f0bafc78..ec8318977a2ef 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -39,6 +39,9 @@ struct sframe_fre_internal {
>  	u32		fp_ctl;
>  	s32		fp_off;
>  	u8		info;
> +	unsigned long	dw_addr;
> +	unsigned char	dw_count;
> +	unsigned char	dw_size;
>  };
> =20
>  DEFINE_STATIC_SRCU(sframe_srcu);

[Severity: Critical]
This is a pre-existing issue, but I noticed that mm->sframe_mt is initializ=
ed
via the INIT_MM_SFRAME macro using MTREE_INIT(sframe_mt, 0), which explicit=
ly
leaves out the MT_FLAGS_USE_RCU flag.

Since sframe_find() and sframe_remove_section() execute under the shared
sframe_srcu read lock here, there is no mutual exclusion between a concurre=
nt
reader and writer.

Because MT_FLAGS_USE_RCU is absent, maple tree node deletions triggered by
mtree_erase() in __sframe_remove_section() synchronously free the nodes
via kmem_cache_free() without waiting for an RCU grace period.

Could this lead to a use-after-free if a lockless concurrent reader using
mtree_load() accesses internal tree nodes while a writer is concurrently
removing a section?

If a multithreaded userspace program triggers a stack unwind in one thread
while another concurrently removes a section via prctl, could this cause
memory corruption or kernel panics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D17
