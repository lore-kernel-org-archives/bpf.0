Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254344AB9E
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696139; cv=none; b=gtVYBt4jV0TKRCfalCmtC8IqMke/oMXtofCF9Kcccm8zLEWIM7FbpW+lqvKeIqM3z8+ZUI7v6SB14EVjb9JXuQHxl64kftDoRpZcnShX93INjpCHAzQK2XW9D+MiBpvswOaW6TU/fC2EP9CF6JG1PRrQ3/9FdLsb/iTYCTxDNJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696139; c=relaxed/simple;
	bh=n5cSz85X9W09OOu+hMXPRVS+Xq03mr92YXN1ADMCpgo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qDvpW4BB3vLL9/m8OnG7rtfdpMvcqKZ+QXQvJAQQT2njhS7Z2WX9zGBeOFNS0UYmgrG6uS01ScXsXGnWfcI/B3jrvVhCl3oX40XvtC2STKGiL51SZRBTm8t9sXsJuXJhwWVl2iJcFM4hFsbfUciU+8iPj3W9wuX0WMYOrZzynUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgWyM8gL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgWyM8gL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2DA1F000E9;
	Fri, 14 Aug 2026 08:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786696129;
	bh=HVzhEzBMqv9niiKkix4893nSShjmt/9usxI2bv0D94Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KgWyM8gLWj5Nn4BovKhj9UIFxq6uWDlnv20kDSnWHYncz6R+yXvou5F+vWEmzM6Ap
	 PZY0XnpbWahJjAhhq9MI2geBhLthfqRueXnzs37rz6t7jt9paXO2aB6lhaBMX2bFhj
	 qM3ITHYUqMKDv0GFg3MiHXyW8RUL3q9nMMywizXqfUM6tf2O6e5R29hfwBZVUzx3bx
	 ssTjgoponsi5tMEmTkpxH0dCUfnDcWQJT4qvSrh4niC7D5MpfgezjK6eEfdipIcCge
	 npSF0EpS1GI0l79C06ed0ZdmK92dyL0WT92rsrlNGGM+pdeW8TZC+SmUOFiSo7TI1Z
	 Xnd/jIQVqDu8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813082754.1165329-1-rkannoth@marvell.com>
References: <20260813082754.1165329-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 08:28:49 +0000
Message-Id: <20260814082849.9B2DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] A failed `tc qdisc replace` operation destructively modifies the s=
oftware rate cache and hardware shapers without rolling back, leaving the s=
ystem in a corrupted, mismatched state.
- [High] Reusing the TL4[0] scheduler queue for MQPRIO after an HTB teardow=
n inherits a stale topology configuration, permanently starving some TX que=
ues.
- [High] The driver attempts to modify hardware queues that have already be=
en freed when deleting the MQPRIO qdisc while the interface is down.
- [Medium] If clearing hardware shapers fails during MQPRIO teardown, the d=
river unconditionally clears its software state while the hardware silently=
 retains the stale shapers.
- [Medium] A flawed allocation check silently skips clearing hardware shape=
rs for single-queue configurations if HW index 0 is used.
--

--- Patch [1]: [PATCH v8 net-next] octeontx2-pf: add mqprio bandwidth offlo=
ad for NIX TX schedulers ---
commit c00a385aa5cbe69512654ab461dd033c6039b7b7
Author: Ratheesh Kannoth <rkannoth@marvell.com>
Subject: octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This patch adds TC_SETUP_QDISC_MQPRIO handling to offload per-queue MDQ
CIR/PIR shaping for mqprio channel mode. It manages the setup and teardown
by restarting the netdev to rebuild the TX scheduler hierarchy. Various
checks and limits are also introduced.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index ca73a94db7943..b6d8ee7e2d4c2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c

[ ... ]

> @@ -650,7 +786,20 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lv=
l, int prio, bool txschq_for
>  						(u64)hw->smq_link_type);
>  		req->num_regs++;
>  		/* MDQ config */
> -		parent =3D schq_list[NIX_TXSCH_LVL_TL4][prio];
> +		if (pfvf->mqprio.rate_limit) {
> +			/* TODO: Program NIX_AF_TL4X_TOPOLOGY on TL4[0]. MQPRIO
> +			 * parents every MDQ under the same TL4 with schedule
> +			 * priority 0, so sibling arbitration depends on the TL4
> +			 * topology register. Only the HTB path programs this
> +			 * today and the AF does not reset it on schq realloc,
> +			 * so a TL4 reused after HTB teardown can retain stale
> +			 * RR_PRIO/PRIO_ANCHOR and starve some TX queues.
> +			 */
> +			parent =3D schq_list[NIX_TXSCH_LVL_TL4][0];
> +		} else {
> +			parent =3D schq_list[NIX_TXSCH_LVL_TL4][prio];
> +		}
> +
>  		req->reg[1] =3D NIX_AF_MDQX_PARENT(schq);
>  		req->regval[1] =3D parent << 16;
>  		req->num_regs++;

[Severity: High]
Does reusing the TL4[0] scheduler queue for MQPRIO after an HTB teardown
inherit a stale topology configuration? By parenting all MDQs to TL4[0]
without explicitly reprogramming NIX_AF_TL4X_TOPOLOGY, this might permanent=
ly
starve some TX queues.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..fc9677e340658 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> +static bool otx2_txschq_is_allocated(struct otx2_nic *pfvf)
> +{
> +	int lvl, idx;
> +
> +	for (lvl =3D 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
> +		for (idx =3D 0; idx < pfvf->hw.txschq_cnt[lvl]; idx++) {
> +			if (pfvf->hw.txschq_list[lvl][idx])
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}

[Severity: Medium]
Can this check silently skip clearing hardware shapers for single-queue
configurations? If the hardware assigned index 0 (which is a valid queue ID=
),
evaluating the queue ID as a boolean returns false, causing the single TX
queue to retain its stale PIR/CIR limits.

[Severity: High]
When deleting the MQPRIO qdisc while the interface is down, will this attem=
pt
to modify hardware queues that have already been freed? The hardware
resources are freed on interface down, but hw.txschq_cnt and txschq_list
remain intact. This could cause the function to return true and trigger a
use-after-free of the hardware scheduler queues via mailbox commands.

[ ... ]

> +int otx2_mqprio_down(struct otx2_nic *pfvf)
> +{
> +	struct net_device *netdev =3D pfvf->netdev;
> +	int err =3D 0;
> +
> +	if (!pfvf->mqprio.rate_limit)
> +		return 0;
> +
> +	if (otx2_txschq_is_allocated(pfvf))
> +		err =3D otx2_nix_tm_clear_queue_shaper(pfvf);
> +
> +	/* TODO: mqprio_down() clears mqprio_rate_limit, netdev TC mappings,
> +	 * and the rate cache even when otx2_nix_tm_clear_queue_shaper() fails
> +	 * partway through the MDQ batch. Software then reports offload as
> +	 * inactive while some queues may retain programmed CIR/PIR, so a later
> +	 * mqprio_up() or re-setup can shape with the wrong effective rates.
> +	 */
> +	pfvf->mqprio.rate_limit =3D false;
> +	pfvf->mqprio_replace_pending =3D false;
> +	pfvf->mqprio_skip_teardown =3D false;
> +	netdev_set_num_tc(netdev, 0);
> +	otx2_mqprio_free_cache(pfvf);
> +
> +	return err;
> +}

[Severity: Medium]
If clearing the hardware shapers fails during MQPRIO teardown (for example,
due to a mailbox communication error in otx2_nix_tm_clear_queue_shaper),
does this unconditionally clear the software state? The hardware would
silently retain the stale shapers and continue to enforce bandwidth limits,
resulting in invisible throttling that is out of sync with the software
tracking flags.

[ ... ]

> +cleanup:
> +	/* Clear hardware offload on this rejected request so a failed replace
> +	 * does not leave tc reporting offload for driver state that was torn
> +	 * down while the previous mqprio remains grafted.
> +	 */
> +	qopt->hw =3D 0;
> +	if (replacing) {
> +		otx2_mqprio_replace_failed_msg(netdev, extack);
> +		pfvf->mqprio_replace_pending =3D false;
> +		return err ? err : -EIO;
> +	}

[Severity: High]
If a tc qdisc replace operation fails (for instance, out of memory in
otx2_mqprio_alloc_cache or a mailbox timeout), does the cleanup path
abandon the destructively modified rate cache and partially applied
hardware shapers?=20

Since the software rate cache is wiped early in otx2_mqprio_alloc_cache,
returning the error here without rolling back the netdev TC mappings could
leave the active qdisc and driver state permanently mismatched.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813082754.1165=
329-1-rkannoth@marvell.com?part=3D1
