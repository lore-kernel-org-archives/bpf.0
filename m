Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3A137646E;
	Tue, 22 Sep 2026 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040670; cv=none; b=eV7EwwYhgaDjDrg18XpG0smGik5a7IMXlupMdGxx5xntvmgwV0EjMjqd977qPDdXqA/wI2jZpcPrygWCpW81/8P5Ljr8sUmS/czdrBBx3iHWuF7uesumNzTvuhjcTpBg3Bj+g20jf8YGF37xNEkulIIon4EClU5zKwximzDwhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040670; c=relaxed/simple;
	bh=Z8PfvQlmBXOdFLEzqyO06gaJ6sORa6rgehL/zGzxvOc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bMpxJf2UcrPMPXISUGJtDu+i4C8wOJ67W96rNrd0NLsriB2xtMoAasT8nYJQZNmhkiP94S3bLEBK9w6p7wz5tAZBdy68GLNEN1TLnRVdQkNeX0Lssx6pDpAGhNJ5CunQPDPQqa+9gfbdP09pyXEGLrjxVAJH9Zn5o40vkt73Dtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0K5qEw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0K5qEw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F04B1F0089D;
	Tue, 22 Sep 2026 01:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040668;
	bh=eZeEmW+uTU31jMnOzaYBitH3PnSJX14zjvkqMO8aw2U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P0K5qEw1uh6ny3nFqoX23T48JRZe+NEqojOQdm9URdv0EGw1NHPvjywPRs+lG+H7c
	 3kvAcppVUPLyFwwS9gB66Qgkh/EEr1pNKknOT66+EC0mTv2PHGnx+uTs0HOutkcIh4
	 tcZskSk7LcHsP+d/OVPHrJeqbIKiQxa/fsSY+he8psk/G/xdig1EZ36hAFxUIf2m/W
	 Zl9NYc9BX1Xa6nMCyrbUjcj/VQExsHjbSxUV0igfHlAaxB2qmLHDI4WQFWxoWXxYEl
	 JVzkdl5g79ZSIDg5TfIGfrcjh3Xp+dFRNfRBy7RzwOHhruD6waRAABALsHIM9IkeBL
	 jtfMezIL+PyJg==
Subject:
 Re: [PATCH net 2/8] i40e: avoid null ptr dereference in i40e_ptp_stop()
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 maciej.fijalkowski@intel.com, zhaochenguang@kylinos.cn,
 magnus.karlsson@intel.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, horms@kernel.org,
 kerneljasonxing@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 bpf@vger.kernel.org, sunithax.d.mekala@intel.com
Date: Tue, 22 Sep 2026 01:31:06 +0000
Message-ID: <179004066689.2160803.12484884497586238643@kernel.org>
In-Reply-To: <20260918212458.550425-3-anthony.l.nguyen@intel.com>
References: <20260918212458.550425-3-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Symptom-only fix: when `i40e_rebuild()` aborts because the
  main VSI could not be re-created, the PTP subsystem is left in an…

--

i40e: avoid null ptr dereference in i40e_ptp_stop()

If the main VSI cannot be re-created during a reset, i40e_rebuild() aborts
after i40e_vsi_clear() has freed the main VSI, so a later i40e_remove()
calls i40e_ptp_stop() with pf->vsi[pf->lan_vsi] == NULL.  The patch adds a
main_vsi NULL check around the dev_info() that dereferences
main_vsi->netdev->name.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index ff62b5f2c815..ca93df4d6785 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -1556,8 +1556,9 @@ void i40e_ptp_stop(struct i40e_pf *pf)
>  	if (pf->ptp_clock) {
>  		ptp_clock_unregister(pf->ptp_clock);
>  		pf->ptp_clock = NULL;
> -		dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
> -			 main_vsi->netdev->name);
> +		if (main_vsi)
> +			dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
> +				 main_vsi->netdev->name);
>  	}

[Severity: Medium]

Is guarding the log message here enough, or does it just make the window
between the failed rebuild and the eventual remove survivable?

In that window nothing appears to touch PTP at all.  i40e_ptp_stop() has
only two callers, i40e_probe() (error path) and i40e_remove(), and none of
the abort paths in i40e_rebuild() (end_unlock / end_core_reset /
clear_recovery) call i40e_ptp_init() or i40e_ptp_stop():

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_setup_pf_switch() {
	...
		if (!main_vsi) {
			dev_info(&pf->pdev->dev, "setup of MAIN VSI failed\n");
			i40e_cloud_filter_exit(pf);
			i40e_fdir_teardown(pf);
			return -EAGAIN;
		}
	...
}

Across the reset, the only PTP action is i40e_prep_for_reset() calling
i40e_ptp_save_hw_time(), which is a pure read.

So after the abort, pf->ptp_clock stays registered and I40E_FLAG_PTP_ENA,
pf->ptp_tx, pf->ptp_rx and pf->tstamp_config stay set, even though the main
VSI and its netdev were freed, and the register programming that
i40e_ptp_init() normally redoes after a reset never runs:

drivers/net/ethernet/intel/i40e/i40e_ptp.c:i40e_ptp_init() {
	...
		regval = rd32(hw, I40E_PRTTSYN_CTL0);
		regval |= I40E_PRTTSYN_CTL0_TSYNENA_MASK;
		wr32(hw, I40E_PRTTSYN_CTL0, regval);
	...
}

i40e_ptp_set_increment(), i40e_ptp_set_timestamp_mode(),
i40e_ptp_restore_hw_time() and i40e_ptp_set_1pps_signal_hw() are skipped in
the same way, and i40e_ptp_init()'s own kerneldoc describes it as
reconfiguring the device after a reset.

Does that leave userspace with an openable /dev/ptpN whose gettime/settime/
adjfine operate on a timesync block the reset left disabled, and PF flags
still advertising timestamping that hardware will not deliver?  A Tx
timestamp request in that state would set __I40E_PTP_TX_IN_PROGRESS for a
timestamp that never arrives, recovered only by the watchdog.

Would it be better to quiesce PTP on the rebuild-failure path, for example
unregistering the PHC or at least clearing I40E_FLAG_PTP_ENA, rather than
adding a NULL check per consumer?  As written, every future user of the main
VSI or of the PTP state in this window needs its own check.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
