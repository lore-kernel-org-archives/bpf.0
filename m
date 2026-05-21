Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9BD36920F
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377825; cv=none; b=Gp91sp+vkYuVpWK5Cfyx2ZJmaAK/YUC6cRVv3sIwn7RbZx5Y0aUnPXKm9IjzW/dCN7Auir5ASHBs/h3nTMHq60RM/3Ujm0nF60yqmtwe/hvgNdgZfPjCzAR5HREnNmVKbzIFFD0nUCT6ZaL4cIIVaMcii39RMtR/FjWpgkgUUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377825; c=relaxed/simple;
	bh=fR3XdXcHsdRbeY1C7lahAmITmKRnxghqIa5ok/ggsYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QjPAGIblU/qhr6dtCC09yeq6tUZqspHVXsL/lxTqUfkA9v3UtHrdtdd5NvVQfzlgaWvjAqgXaTGQo1nOnWO1YhLwU+QkTs/6Gl+sT7wsHMwd4xO1/Gm71zMdcYww1bv75znBkfl1PpSHzJNC/ocDT+CPnksq0QzXTBWu48Yt+ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc2F3Yng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc2F3Yng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457091F0155A;
	Thu, 21 May 2026 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377824;
	bh=Nac0m+wwbCJsQvTZ8aBB/72T9c4o0mlSCwNP3f3DOLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nc2F3YngCl42YVu12OrOaqUJRPOa2WXo62izFjjCr3V8KYJowg22HtpVFFQsfXVtw
	 aH/Ted967tQUNxFcSzP4uJzrzOOOijcLYaNz8N7XJ/IcecFddMFeuZlwcCf50pmpVV
	 xKUSQbtnx/6mvaO3nrEDPAExAxcWXGbUkQCGFU37JSzPYs0jKjPGf/rNAmsGDu5w24
	 73SmuvxeMhHQne3jpHlMJCt9n928AUiDipz1nobBdFIHJmfWAeboDdYu0cOSNz9Pzm
	 FmkDMZCBurdd3CpWpaP0k7BMO/BjoNfM+k6IRvMMtrO23bLbQG5y7ezoYf8yfd4JG/
	 G9nDcRj9zjiDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 18/20] unwind_user/sframe: Duplicate registered
 .sframe section data on clone/fork
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-19-jremus@linux.ibm.com>
References: <20260521142546.3908498-19-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:37:03 +0000
Message-Id: <20260521153704.457091F0155A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Use-After-Free of maple tree nodes due to lockless traversal w=
ithout RCU protection.
- [Medium] Mixing goto-based error handling with guard() in the same functi=
on.

Pre-existing issues:
- [High] Spinlock deadlock due to calling `mtree_erase` from NMI/interrupt =
context.
--

commit dd76a8e2b70424efa3c49c5cac126edfd3a77425
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/sframe: Duplicate registered .sframe section data on clone/fork
   =20
When duplicating a process' virtual memory mappings also duplicate all
of its registered .sframe sections stored in the per-mm maple tree to
enable stacktracing using sframe of the child process.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 7f439600b0f0a..db88d993dff1f 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -875,6 +875,54 @@ int sframe_remove_section(unsigned long sframe_start)
> +int sframe_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
> +{
> +	struct sframe_section *sec, *oldsec;
> +	unsigned long index =3D 0;
> +	int ret;
> +
> +	guard(srcu)(&sframe_srcu);
> +
> +	mt_for_each(&oldmm->sframe_mt, oldsec, index, ULONG_MAX) {

[Severity: Critical]
Does this lockless iteration risk a use-after-free on maple tree nodes?

The maple tree is initialized via INIT_MM_SFRAME as MTREE_INIT(sframe_mt,
0), which omits the MT_FLAGS_USE_RCU flag. Without this flag, tree
modifications free internal tree nodes synchronously via kfree() instead
of call_rcu().

If sframe_remove_section() modifies the tree concurrently, could this
lockless mt_for_each() access freed maple tree nodes?

[Severity: High]
This isn't a bug introduced by this patch, but looking at how the maple
tree is used here and in sframe_remove_section(), is there a deadlock
risk if sframe_remove_section() is called from NMI/interrupt context?

Since stack unwinding can occur asynchronously in NMI or hardirq context
(e.g., via perf_callchain_user), if it detects a corrupted section and
triggers sframe_remove_section() which ultimately calls mtree_erase(),
that will take a non-IRQ-safe spin_lock via mtree_lock(mt).

If an NMI interrupts a thread that is already holding the mtree_lock
(for instance, during sframe_add_section), could this instantly
hard-deadlock?

> +		sec =3D kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
> +		if (!sec)
> +			return -ENOMEM;
> +
> +		__sframe_dup_section(sec, oldsec);
> +
> +		ret =3D mtree_insert_range(&mm->sframe_mt,
> +					 sec->text_start,
> +					 sec->text_end - 1,
> +					 sec, GFP_KERNEL_ACCOUNT);
> +		if (ret)
> +			goto err_free;
> +	}
> +
> +	return 0;
> +
> +err_free:

[Severity: Medium]
Are we mixing goto-based error handling and scope-based cleanups in the
same function?

This function declares guard(srcu)(&sframe_srcu) at the top, but then
uses a goto-based cleanup label here. According to the cleanup subsystem
guidelines in include/linux/cleanup.h, mixing goto and scope-based
cleanup helpers in the same function creates confusing ownership
semantics.

Should this function either convert all resources to scope-based cleanup,
or convert none of them?

> +	free_section(sec);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D18
