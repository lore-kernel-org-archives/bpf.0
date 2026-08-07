Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D553CA499
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132821; cv=none; b=KhQ6hf1ujNSgu3M0guukTSKd91eilOnnnECFXqRlVHRgBfrNChr/TeYl7ozIJI0Iz7n16nl1YEsA9J1+tsA9q4GrgjaFVaeTUA39PGFZf3AOa0Ad4iiwvdroIz6zlmsdcjfN/FaLT9lH6lNelhDzPe2UP2h0Mbp0YGO2L6t5u0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132821; c=relaxed/simple;
	bh=xOvW6vxXU805iL7JpTnmKTxZFDOonO67s1caF+WdTsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uAo0NfvGJPitXDPubYPHyBOhBUajALR3BRNgFDnxwJ9TMIVg7Ux+MFCTAiPhQ/jz0Fjj0EHELbSQziyb52XqzmX9TVmgAX4NDmMWvxDOTkY9i87Jj2lmsByiJEo8F/nxHZYMsi97nHv7UawjoEQys3ci/2aEJD6czZ8h4faZoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJQiFoJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJQiFoJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F73C1F000E9;
	Fri,  7 Aug 2026 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786132817;
	bh=puUr3Jm1fMzQyDuRjLSnt6mx9vKRf8s7zjj7VdrhQDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJQiFoJJztXpY1UKlWmuXRf0EQuqzPQOzU7ot7MJLYvU/koQwmXr/YspLq6JJw8wi
	 NCvItjEfuo/eW0rzH/JTtTegFXr5vnxT0GwW5JMnB7+p9Ughxlm8eI0vJDYkMWYW9v
	 ZrGDx6n/oSHLxQp8xooD83N484Ky+QbT4hFXVnv5RdQosRUaT3+Qddb21bM1VEcb+Z
	 YLcJ0qJ+4nJUhwW+45Phu8p6JaOfOAL+eUKlF2fUhqix7CbRUuwl/iHZHm8JsOIRq2
	 yuKtF7Uwf93HF5P0gt8RmjRLIKrKaRnZtB7cvVkQhFw5hlplTysf5RL1iCEojQP/hq
	 scY/Suh04TV/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] block: add BPF kfuncs to read blkcg io.stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: hannes@cmpxchg.org, bpf@vger.kernel.org, mkoutny@suse.com, tj@kernel.org
In-Reply-To: <20260807193732.4073299-2-ziyang.meme@gmail.com>
References: <20260807193732.4073299-1-ziyang.meme@gmail.com>
 <20260807193732.4073299-2-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 20:00:16 +0000
Message-Id: <20260807200017.0F73C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] A Time-Of-Check to Time-Of-Use (TOCTOU) race condition in `bpf_blk=
g_dev` can lead to a NULL pointer dereference when accessing `disk->part0`.

Pre-existing issues:
- [High] Concurrent execution of `blkcg_fill_root_iostats()` lacks mutual e=
xclusion, corrupting the `u64_stats_sync` seqcount and potentially deadlock=
ing readers.
--

--- Patch [1]: [PATCH 1/2] block: add BPF kfuncs to read blkcg io.stat ---
commit 5b3bee962ae05470b0da306e0224ebb6eec2d0ce
Author: Ziyang Men <ziyang.meme@gmail.com>

block: add BPF kfuncs to read blkcg io.stat

This exposes the block I/O controller's per-device statistics to BPF,
mirroring the memory controller kfuncs. It allows BPF programs to read a
cgroup's io.stat counters and flush the stats through new BPF functions.
The patch also modifies blkcg_fill_root_iostats() to be accessible external=
ly.

> diff --git a/block/bpf_blkcg.c b/block/bpf_blkcg.c
> new file mode 100644
> index 0000000000000..48a86f07e198a
> --- /dev/null
> +++ b/block/bpf_blkcg.c
[ ... ]
> @@ -0,0 +1,315 @@
[ ... ]
> +__bpf_kfunc void bpf_blkcg_flush_stats(struct blkcg *blkcg)
> +{
> +	if (!blkcg->css.parent)
> +		blkcg_fill_root_iostats();

[Severity: High]
This is a pre-existing issue, but can this lead to a corrupted sequence
counter and deadlocked readers?=20

Multiple BPF programs can call bpf_blkcg_flush_stats() concurrently, which
calls blkcg_fill_root_iostats(). Inside blkcg_fill_root_iostats(), the
update is performed with:

    flags =3D u64_stats_update_begin_irqsave(&blkg->iostat.sync);
    blkg_iostat_set(&blkg->iostat.cur, &tmp);
    u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);

Since u64_stats_update_begin_irqsave() only protects against local interrup=
ts,
multiple CPUs executing this concurrently lack an external lock to serialize
writers. Does this allow concurrent writers to corrupt the underlying
seqcount (e.g., leaving it permanently odd), causing subsequent readers
to spin infinitely in u64_stats_fetch_retry()?

> +	else
> +		css_rstat_flush(&blkcg->css);
> +}
[ ... ]
> +__bpf_kfunc u64 bpf_blkg_dev(struct blkcg_gq *blkg)
> +{
> +	if (!blkg->q || !blkg->q->disk)
> +		return 0;
> +
> +	return blkg->q->disk->part0->bd_dev;

[Severity: High]
Can the compiler double-fetch blkg->q->disk here and cause a NULL pointer
dereference?

If a BPF program calls bpf_blkg_dev() while the block device is concurrently
being removed, disk_release() can set disk->queue->disk =3D NULL synchronou=
sly.

Without READ_ONCE(), the compiler is permitted to fetch blkg->q->disk for
the NULL check, and then fetch it again for the return statement. If the
second fetch sees the concurrently-written NULL, it will dereference
NULL->part0 and crash the kernel. Is a local variable paired with
READ_ONCE() needed here?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807193732.4073=
299-1-ziyang.meme@gmail.com?part=3D1
