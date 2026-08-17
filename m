Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCDE3EB10C
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004514; cv=none; b=Ne5ZHi7YmDRSLsMYztLj7SS4lHpXyYJv/Iju/uq1+ibOjL9M+7pluaPUu1XgaAurPEPLRV0teD6YEKWsc8Y/z1LI7gX8RgFtericzzoH+PLkQkgsjyFYGQbtAdJt3CJ+RSdqrl4UbqEmEI/tgtDXLZqaJ9wqhs7FvB4EwRPQOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004514; c=relaxed/simple;
	bh=SI2Ft76Muc0A1s9eFQ/hAIg/YLVpp/DQAidKzTQ/t94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l9C2lFdBX83yEcv3uOYsdLGuYO7Ru8cmYs09XFQBUbPEVyZMPXk+Rk8PSCZfmkdLPVjMPSbRnjLfVtp6sdet1H8a0aoD+w9LgxY7/HWfzxoA220yPB8AJQhTXx9HvCOv0AF2K5xnlR0ptptno+0gCVckLbZwrdYbkYRocnbr6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZZJiann; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZZJiann"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389671F00A3A;
	Mon, 17 Aug 2026 22:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787004510;
	bh=IG6osnVUSD01RKPAKVkHa4x0DoGS/ydZ9Rta0YRLqH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZZJiannjW146iRaAi60wHEoTqdrsci5MAooVch9jS8tGrowO/JedJon39l0Vtr9R
	 B0EaSXiznmalmsoH1xN2Gj/yKFCriefti/qsZbkJnG1MY0IBj8ZN9HgYgLfIQQEz2u
	 WAxOhdVKyccjUPZ3SCnGX1kxK7JNDFHmG9jPjOMApBx3+EIBJIwAZiXsYhi+2z8sxd
	 aSV1GD1ddheUIFc8dgWC2jjWW637TWEy3qZuVhXxrxgF5gpp0lg+F/OnYF9EkALmMd
	 33IwYKp9ARdlAuKFfvIul/rfM2XH8VUd2ZBJDlYQjztbr+LcmppHACcJZvzzCAoSiw
	 n4KQ/oTbtD51w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] block: add BPF kfuncs to read blkcg io.stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com, bpf@vger.kernel.org
In-Reply-To: <20260817214205.723267-2-ziyang.meme@gmail.com>
References: <20260817214205.723267-1-ziyang.meme@gmail.com>
 <20260817214205.723267-2-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 22:08:29 +0000
Message-Id: <20260817220830.389671F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of `blkcg_fill_root_iostats()` corrupts the `=
u64_stats_sync` sequence counter, leading to reader deadlocks.
--

--- Patch [1]: [PATCH v2 1/2] block: add BPF kfuncs to read blkcg io.stat -=
--
commit bdaf96b752ce960b924c3be337708d377f83207c
Author: Ziyang Men <ziyang.meme@gmail.com>

block: add BPF kfuncs to read blkcg io.stat

This commit introduces BPF kfuncs to allow reading per-device block I/O
controller statistics. It exposes blkcg_fill_root_iostats and provides
bpf_blkcg_flush_stats and iterator functions for blkg.

> diff --git a/block/bpf_blkcg.c b/block/bpf_blkcg.c
> new file mode 100644
> index 0000000000000..25c809f5091c2
> --- /dev/null
> +++ b/block/bpf_blkcg.c
[ ... ]
> +__bpf_kfunc void bpf_blkcg_flush_stats(struct cgroup *cgrp)
> +{
> +	struct cgroup_subsys_state *css;
> +
> +	/* Pin the css for the sleepable flush. */
> +	rcu_read_lock();
> +	css =3D cgroup_css(cgrp, &io_cgrp_subsys);
> +	if (css && !css_tryget(css))
> +		css =3D NULL;
> +	rcu_read_unlock();
> +
> +	if (!css)
> +		return;
> +
> +	if (!css->parent)
> +		blkcg_fill_root_iostats();

[Severity: High]
This isn't a bug introduced by this patch, but can concurrent executions
here lead to sequence counter corruption and reader deadlocks on 32-bit
systems?

In block/blk-cgroup.c, blkcg_fill_root_iostats() loops over block devices
and updates statistics without an overarching writer lock:

blkcg_fill_root_iostats() {
    ...
    flags =3D u64_stats_update_begin_irqsave(&blkg->iostat.sync);
    blkg_iostat_set(&blkg->iostat.cur, &tmp);
    u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
    ...
}

On 32-bit architectures, u64_stats_update_begin_irqsave() maps to
write_seqcount_begin(), which requires external mutual exclusion to prevent
concurrent writers from corrupting the sequence counter. If the counter
becomes permanently odd, readers using read_seqcount_begin() will spin
infinitely.

While this bug existed previously via concurrent reads of the root cgroup's
io.stat sysfs file, exposing blkcg_fill_root_iostats() via this sleepable
BPF kfunc allows BPF programs to easily and repeatedly trigger this lockless
code path simultaneously across multiple CPUs.

> +	else
> +		css_rstat_flush(css);
> +
> +	css_put(css);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817214205.7232=
67-1-ziyang.meme@gmail.com?part=3D1
