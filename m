Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EFF23BF91;
	Sun, 11 Oct 2026 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791752608; cv=none; b=Qa/afQ5kcGKFZyOvVq/v/MIKERy7+Smc3S79cjrJOm9bCe3FPquHpa+pu+A2UUK6ONMwGYC0QkoI2DIfoV4NbAkkeWfPq1iD4nUlBL1S8HkDH+UXoCntu/5yz7o90v5LpqfIPWVtFULHjpdb6NX3t+jzQYCJ3+kTGHtY3u6VB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791752608; c=relaxed/simple;
	bh=bswT0S63YlePvBFM2lMlO+52qZriGmzpbAk4EbJEGA0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsOa4J4afrmxodxyIs65x284gN1wEulVn3HXO2aPUAHD8i3H9I//o7Er2lcwXExkyWVZQWCfqWW1NCuRdXZ5pYvhW5jjQgaVbMDHD4KsAY/7/KG7T8cUf06SpiM6xEzzIOgq/3W40IshCN0ezVfmtIncHQLcGs1IDgGgaBvW+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXxJdXgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXxJdXgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03611F0089C;
	Sun, 11 Oct 2026 21:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791752607;
	bh=8A+M96fdlI8d50+SALX2cmt9CUoylt217eigY0FGaqo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AXxJdXgJH9cBoFzhxYY5dfPmLZNkL5tMvbOiPt9RRzCZzWNNssgwj4GMtLrEznUR9
	 b6iWmzzKHvBUdokCAFoQ3KMniimO7W5o7mBORd0kV6+Nqpwpb3W+UTUYfWOimdkA0P
	 jD36QWx+aTCNebqpdS8fl0l7R+4aq6TnRvBbvZM3KUFImlybFMu9XhJtY1zL4nnlxH
	 OZ7Now8yiUsbunqhTlYDmFJTO3N+tgXBBpeQcRul3A4Rl/LiTvSE4y1qgIlL/1I/Qk
	 y2Ggys5Dsg2gEkkluLWojcIsCsMR3ndwWo8h4ibCRrFaTNRLksgZbYUV20jPsyLG/i
	 uljds5ay9jG6g==
Subject: Re: [PATCH net v2 2/3] net/sched: cls_bpf: accept dev-bound programs
 on shared blocks
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, bpf@vger.kernel.org, victor@mojatatu.com
Date: Sun, 11 Oct 2026 21:03:26 +0000
Message-ID: <179175260626.434549.15434445852177291195@kernel.org>
In-Reply-To: <QDISC-PYC7.v2.20261010165947-3@mojatatu.com>
References: <QDISC-PYC7.v2.20261010165947-3@mojatatu.com>
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

- [Low] The v1->v2 notes say: "Style (gemini + nipa Low) -- FIXED: the
  shared-block comment opens with /* on its own line." The diff does not…
- [Low] The commit message ("matches every netdev bound to the block"),
  the code comment ("require a match with every member") and the extack…
- [Low] The stable metadata does not express the patch's known
  dependencies.

--

net/sched: cls_bpf: accept dev-bound programs on shared blocks

This patch follows up commit 120977e2c096, which took the target device
from block->q and so rejected every dev-bound cls_bpf program attached
through a shared block. On shared blocks, cls_bpf_prog_from_efd() now
walks block->ports and accepts the attach only when
bpf_offload_dev_match() succeeds for every entry. It rejects an empty
block.

Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/
Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatatu.com/

> Fixes: 120977e2c096 ("net/sched: cls_bpf: reject dev-bound programs bound to a different device")
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> [ ... ]
> Cc: stable@vger.kernel.org

[Severity: Low]
Do these tags give stable tooling enough to backport this safely?

Commit 120977e2c096 carries "Fixes: 2b3486bc2d23" ("bpf: Introduce
device-bound XDP programs", v6.3). Stable trees from v6.3 onward, such
as 6.6.y, can therefore pick it up and inherit the shared-block
rejection.

This follow-up iterates block->ports in cls_bpf_prog_from_efd(). That
field was added by 913b47d3424e ("net/sched: Introduce tc block netdev
tracking infra", v6.8-rc1), so the patch will not build on those older
trees. They would keep rejecting every dev-bound attach on a shared
block.

The ordering against the netdevsim patch ("patch 1 must be applied
first, including in stable") is only stated in prose. Would a version
bound on the Cc: stable line, or a prerequisite annotation, express
both dependencies in a form the tooling can use?

> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 188cf0f949dd4..07ad9556889d4 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -392,11 +392,31 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
>  	if (bpf_prog_is_dev_bound(fp->aux)) {
>  		struct tcf_block *block = tp->chain->block;
>  		struct net_device *dev;
> +		unsigned long ifindex;
> +		bool match = false;
> +
> +		/* A shared block has no qdisc of its own, but it may bind
> +		 * several netdevs and the program is offloaded to all of them;
> +		 * require a match with every member.
> +		 */

[Severity: Low]
This isn't a bug, but the v1 -> v2 notes say:

  Style (gemini + nipa Low) -- FIXED: the shared-block comment opens
  with /* on its own line.

This comment in cls_bpf_prog_from_efd() still has text on the opening
line. The only new comment in the series with /* on its own line is in
nsim_bpf_setup_tc_block_cb(), in the netdevsim patch.

Was the style fix lost when v2 was split into three patches?

> +		if (!tcf_block_shared(block)) {
> +			dev = qdisc_dev(tcf_block_q(block));
> +			match = bpf_offload_dev_match(fp, dev);
> +			if (!match)
> +				NL_SET_ERR_MSG(extack,
> +					       "Program is bound to a different device");
> +		} else {
> +			xa_for_each(&block->ports, ifindex, dev) {
> +				match = bpf_offload_dev_match(fp, dev);
> +				if (!match)
> +					break;
> +			}

[Severity: Low]
Does block->ports really hold every netdev bound to the shared block?
The commit message ("matches every netdev bound to the block"), the
comment above and the extack text all assume it does.

In tcf_block_get_ext(), the offload callback is bound for every binder
type, but the device only goes into ports when tcf_block_tracks_dev()
is true:

net/sched/cls_api.c:tcf_block_get_ext() {
    ...
	err = tcf_block_offload_bind(block, q, ei, extack);
	if (err)
		goto err_block_offload_bind;

	if (tcf_block_tracks_dev(block, ei)) {
		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
    ...
}

tcf_block_tracks_dev() only accepts FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS
and FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS.

sch_red binds shared blocks through tcf_qevent_init() using
FLOW_BLOCK_BINDER_TYPE_RED_EARLY_DROP and FLOW_BLOCK_BINDER_TYPE_RED_MARK.
Those netdevs own the block and receive the cls_bpf offload broadcast,
but this loop never visits them.

That leads to two cases:

- If a block's only binders are RED qevents, ports is empty. A dev-bound
  attach then fails with "Program is not bound to every device in the
  block", which is misleading. The old code also returned -EINVAL here,
  so the return value has not changed.

- On a mixed clsact plus qevent block, the check passes without looking
  at the qevent member.

The mixed case is safe in-tree today only because of other checks. nfp
and netdevsim register their callbacks ingress-only, so a qevent bind
raises nooffloaddevcnt, and tc_setup_cb_add() rejects skip_sw:

	/* Make sure all netdevs sharing this block are offload-capable. */
	if (block->nooffloaddevcnt && err_stop) {
		ok_count = -EOPNOTSUPP;
		goto err_unlock;
	}

Both drivers also re-check bpf_offload_dev_match() in their callbacks.

Should the commit message, comment and extack say that this check only
covers clsact-tracked members? The rest of the protection comes from
nooffloaddevcnt and the driver callbacks.

> +			if (!match)
> +				NL_SET_ERR_MSG(extack,
> +					       "Program is not bound to every device in the block");
> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-PYC7.v2.20261010165947%40mojatatu.com
