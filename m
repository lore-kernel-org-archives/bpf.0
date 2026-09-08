Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42D4E66A9
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862428; cv=none; b=LAQMmoK1/UyLU2ESTPWqnq5Qh6KmJbrJsqkcrNHZn3v02itcCgi7JYfDQe+7OeRn4AHXBoL/Fp9ZxlMch0X9OFprvxBwLkvN8q9XELTFvniVVbj84m9sQoKZLd0jnS8n9X/EBfv/QTg/REnENc6s3mB8fDwdumxg/ttbsgDyvYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862428; c=relaxed/simple;
	bh=4Cd5y8hvApr4UN5EZ5j1MvSau8AXeLrPDQXWHfUTLnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qgECELQikzCefSCRlEa3Gl1rncjkUBuzqlT+gZz+jHDLF/x8njBsh8+MQoJryDIRi7fr2sQo1QM3/qeonzBbfkaDFc89y8vEfENiFdU5Lg1PXlTRln7VfscjxuODeg5c6t6b2CkIxSbIF4K4VEyflYR6XdwP2yIiCczy1wglo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3TriR6m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3TriR6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60E01F00A3A;
	Tue,  8 Sep 2026 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788862427;
	bh=oO9sE7pPSY6TS8LefKRkUCrHBHqdiUWOyu7EptyWRVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F3TriR6meG92rKwjNFUp2cEMt3PzddrbSWu1TM5sntpJ5y4jj1OQVOyZeuvEa8Ibx
	 om5bUqMAJM0MMVi/BtRPnirSRuU39yaRZjAJc+BuP0giHMyARNU4qOGebLRxgfsbsa
	 w6rraLx6InZaLca6V7eFRQMQbHhB1gFk2CxB6BUjT065Hy7cqtKLM/7f0AtoRom2n0
	 INwwVFWOs8ur0G3HiuROpVEWBbsPT36JDIrF7FqKcmt3pQ23jPwKy89MZuLXpzE0fV
	 C3IB2r/eS4Rvrfvq68JaSMiJJgAqzErOSma0L935wK08agBYwc1vEt7lLn5wg+c15m
	 mY1dlprMFTkig==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/8] blk-iocost: define iocost_model_ops cost model
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com, bpf@vger.kernel.org
In-Reply-To: <20260908100143.47598-3-cui.tao@linux.dev>
References: <20260908100143.47598-1-cui.tao@linux.dev>
 <20260908100143.47598-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:13:46 +0000
Message-Id: <20260908101346.B60E01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `iocost_model_ops` interface uses recycled cgroup IDs (`iocg_i=
d`) without a lifecycle callback (e.g., `release`), making safe per-cgroup =
state management impossible.
- [Low] Incorrect header reference in BPF struct_ops documentation.
--

commit 64a8ffdba67eaf906639412faa34e6125d2960c1
Author: Tao Cui <cuitao@kylinos.cn>

blk-iocost: define iocost_model_ops cost model interface

This commit defines the interface for pluggable cost models via a struct_ops
with a single calc_cost callback. It passes iocg_id to allow models to keep
per-cgroup state. The model is called from the IO submission path under RCU.

> diff --git a/include/linux/blk-iocost.h b/include/linux/blk-iocost.h
> new file mode 100644
> index 0000000000000..7111b5c03dc36
> --- /dev/null
> +++ b/include/linux/blk-iocost.h
> @@ -0,0 +1,56 @@

[ ... ]

> +struct iocost_model_ops {
> +	/*
> +	 * @op:		REQ_OP_* value (uapi blk_opf.h)

[Severity: Low]
Is this the correct header reference?

The file blk_opf.h does not exist in uapi. Should this point to
include/linux/blk_types.h instead?

> +	 * @nbytes:	IO size in bytes
> +	 * @sector:	starting sector
> +	 * @cursor:	iocg cursor sector, 0 if none (sequentiality hint)
> +	 * @iocg_id:	css id of the issuing cgroup
> +	 * @flags:	IOCOST_COST_F_*
> +	 */
> +	u64 (*calc_cost)(u64 op, u64 nbytes, u64 sector, u64 cursor,
> +			 u64 iocg_id, u64 flags);
> +};

[Severity: High]
Does this struct_ops interface need a release or offline callback for cgroup
state cleanup?

When a cgroup is deleted and its CSS ID is recycled, the new cgroup inherits
the historical IO state of the deleted cgroup if the BPF model tracks it.=20
There is no reliable way for the BPF program to garbage collect entries,
which can eventually exhaust map space.

Could unprivileged users with cgroup delegation create and destroy cgroups,
triggering map exhaustion and causing a denial of service for the cost model
(which falls back to failure or builtin behavior once max_entries is reache=
d)?

The commit message notes that the need for a release(iocg_id) callback is
an open question. Since BPF struct_ops signatures are frozen once merged,=20
is it safe to omit it from the initial interface? This appears to be
confirmed in a follow-up patch where map entries have no deletion logic
and will leak in a production environment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908100143.4759=
8-1-cui.tao@linux.dev?part=3D2
