Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7A1D7E5C;
	Sun, 11 Oct 2026 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791752607; cv=none; b=hDPfJodnvqwcPFjF+3qaDfC4u6bMpnTB2v9HnbVJwSK2sde9SVeJcWO6spCroKTH16aSYFjxf0x+XWhEMAT+5Zwa1ddZRTF2nMkpoS2NfOOSVSTRgVIPerf6LVyqeFr7/8M7QKVSmKC3Dyx5a3HaRZgf5mrp6Z1pzxbAZunHjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791752607; c=relaxed/simple;
	bh=GhKJjIGBlQ+xriRaMdt0gQZR749eJpDExQDPyS+ioTU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbBBLs4u0d9GdThq9C4Iw0gw5IaWQ4wM8+/25SzVSX4dNNy4o0S8pwrtRvpEkqT17x2h3mBTX2exmE2FevprBN8f9PesweW7a71rNzkPNzpB7utET5jsHh0M8OhNJ1WHBmhn8PeAJpcJPFaLvsXDqfjnXgqAp8lMguRhIfGBlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwoJj6sV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwoJj6sV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBC41F0089B;
	Sun, 11 Oct 2026 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791752606;
	bh=rK+nEQT/QGerG4mmgBlrcxXx4WeqJgHAEWx4oLgTmso=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hwoJj6sVHZPHOEmcbn6mtgbS27K5fFbWbnB8ZBU5TVMhfXvFLQxkTk5r+V+UYEfKm
	 Gg/UGKXmuteUP1XPlIbaZ5ilzpGJ8ESrds/h1e4KtqKw8m71Yc00y7rYmPJX19Ht6T
	 a30FxYst+WElqz0sZNYGl4OpctwbYMEa5mLlr7OUZf0onNGYqoj1G9w5AKlBUR5IhG
	 xjoZ3R7skXIykAdswm42uQAaokaB7gOHg+WaoPHrjD0jLa9xSq5Kj6DneX3JgVxsYV
	 goymG6wxRtZ6Ac7tZEHdBdGdGGA9EfipZXC8bDwgi30DAE3VX0zD3QMGtbM0ztw9Lf
	 DtHCSqvk/lrbw==
Subject: Re: [PATCH net v2 1/3] netdevsim: reject cls_bpf programs bound to
 another device
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, bpf@vger.kernel.org, victor@mojatatu.com
Date: Sun, 11 Oct 2026 21:03:24 +0000
Message-ID: <179175260495.434549.13119281916864696711@kernel.org>
In-Reply-To: <QDISC-PYC7.v2.20261010165947-2@mojatatu.com>
References: <QDISC-PYC7.v2.20261010165947-2@mojatatu.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] On the tree this patch applies to, the bug described in the
  commit message cannot happen.

Pre-existing issues:
- [Medium] Offload accounting imbalance when a shared-block late-join
  replay is rolled back.

--

netdevsim: reject cls_bpf programs bound to another device

This adds a check to nsim_bpf_setup_tc_block_cb(). The check rejects a
device-bound cls_bpf program whose offload device does not match the
target netdev, and returns -EINVAL with an extack message. The commit
message says this closes a shared-block late-join replay path through
cls_bpf_reoffload().

Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/
Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatatu.com/

> diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
> index 16aa882783984..e6799947db834 100644
> --- a/drivers/net/netdevsim/bpf.c
> +++ b/drivers/net/netdevsim/bpf.c
> @@ -144,6 +144,18 @@ int nsim_bpf_setup_tc_block_cb(enum tc_setup_type type,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/*
> +	 * A dev-bound program can be replayed here when a netdev joins a
> +	 * shared block, after the core attach-time check has run; enforce
> +	 * the device match as nfp does.
> +	 */

[Severity: Low]

Can this replay path be reached on the tree this patch applies to? The
commit message says:

  The core cls_bpf attach path rejects a mismatching program, but a
  netdev that joins a shared block later is replayed the stored filter by
  cls_bpf_reoffload() before it is inserted into block->ports, so the
  attach-time check cannot see it.

In net/sched/cls_bpf.c, cls_bpf_prog_from_efd() does this attach check:

	dev = block->q ? qdisc_dev(block->q) : NULL;
	if (!dev || !bpf_offload_dev_match(fp, dev)) {
		NL_SET_ERR_MSG(extack,
			       "Program is bound to a different device");

In net/sched/cls_api.c, tcf_block_create() never sets block->q for a
shared block:

	/* Don't store q pointer for blocks which are shared */
	if (!tcf_block_shared(block))
		block->q = q;

So it looks like every dev-bound program on a shared block is rejected
at attach time. Wouldn't step 3 of the reproducer ("install the program
on a shared block owned by B") fail with "Program is bound to a
different device"?

If so, cls_bpf_reoffload() never holds a dev-bound filter on a shared
block that it could replay to a joining device. A non-shared block has
only one netdev, and that netdev already passed the attach check.

The late-join path seems to open only with the companion patch
"net/sched: cls_bpf: accept dev-bound programs on shared blocks". That
patch replaces the block->q check with the every-member predicate
mentioned in the v1 -> v2 notes. This comment only becomes accurate once
that patch is applied.

Could the commit message and this comment say that the cls_bpf patch
opens the replay path? Or could they describe the path that the Fixes:
and Cc: stable tags actually cover on older trees, which is direct
attach before 120977e2c096? The code change itself looks fine.

> +	if (prog && bpf_prog_is_dev_bound(prog->aux) &&
> +	    !bpf_offload_dev_match(prog, ns->netdev)) {
> +		NSIM_EA(cls_bpf->common.extack,
> +			"program bound to a different device");
> +		return -EINVAL;
> +	}

[Severity: Medium]

This is a pre-existing issue that this patch did not introduce, but the
new -EINVAL return adds another way to reach it. The companion cls_bpf
patch lets a dev-bound program sit on a shared block. After that, what
happens to the offload counters when this rejection triggers a rollback?

Say device B holds a skip_sw cls_bpf filter with a B-bound program on a
shared block. So in_hw_count == 1, TCA_CLS_FLAGS_IN_HW is set, and
block->offloadcnt == 1. Then netdevsim device C, which has a different
bpf_offload_dev, binds the block:

tcf_block_bind()
  tcf_block_playback_offloads(add=true)
    cls_bpf_reoffload()
      tc_setup_cb_reoffload()
        nsim_bpf_setup_tc_block_cb()   <- returns -EINVAL here

The filter is skip_sw, so the error propagates and
tcf_block_playback_offloads() jumps to err_playback_remove. That replays
add=false over every filter, including the one whose add just failed.

With prog == NULL the new guard is skipped. ns->bpf_offloaded is NULL,
so it is != oldprog, and C's callback takes this path:

	if (ns->bpf_offloaded != oldprog) {
		oldprog = NULL;
		if (!cls_bpf->prog)
			return 0;

tc_setup_cb_reoffload() treats that 0 as a successful removal and calls
tc_cls_offload_cnt_update(..., 1, false):

	*cnt -= diff;
	if (!*cnt)
		tcf_block_offload_dec(block, flags);

Wouldn't in_hw_count then drop from 1 to 0, clearing IN_HW and
decrementing block->offloadcnt, while B still has the program offloaded?
Each later failed join would decrement the u32 in_hw_count again and
wrap it.

Once block->offloadcnt reads 0, tcf_block_offload_in_use() returns
false. Could a device without ndo_setup_tc then bind a block that still
carries a skip_sw filter?

The same imbalance looks reachable on the baseline through netdevsim's
existing rejections, which only apply to adds. One case is an unbound
skip_sw program that B accepts (bpf_tc_non_bound_accept=1) but a joining
C rejects with the default bpf_tc_non_bound_accept=0. Another is the
-EBUSY "driver and netdev offload states mismatch" path.

The root cause seems to have two parts. The core rolls back without
tracking which callbacks accepted the add. Also, netdevsim returns 0 when
asked to remove a program it does not hold.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-PYC7.v2.20261010165947%40mojatatu.com
