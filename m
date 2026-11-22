Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366992;
	b=yvrWWNui4ptb10uj2ZAynl68m7JNJlt3p4pMclKDuLERE1Ghfl+YQTMNBbPl34BxeMk3
	 g/DO1eRq2xV4C9I9OWa53FqgkjxCW7Vpbct3wuqv7g1GW08zrUrt/Qo+W7WIP6GPoRxvb
	 opNd6/vRAaFGSEv4PtmFiyCdEgudokl0JeJVQ8jYd9LRMPHwGdLMvRD3VxqpJUy0swuD4
	 X/vIzqLug0QTfwMHXGQogTmLxILija0iJpld+zxIANZh++v/F6KJdv7yQMnkMoxz83I+e
	 e1duzHcz5hzEE4/4uFqnBgQiwbNHIC2sCfVLypA2GNFJrHxZDTS7w70WRHBop1q2atQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366992;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gMafmWOv8TBm4c4ZfyWe/8aXJfH25fVK6a/gc7SwN9k=;
	b=5UQWj6EJvFp4nyNDTcqMWsFqkkHcQKsHEyBnwmya1x9KU2coJpk4M8+WBF3R1g0u8Tsb
	 yQXcZrg25NJoPo2smJZ3Ne1YUXzwNRb6Gfk85ibtaTiVyAw97dK7TOmDGExJqEr82whWS
	 8IfG11An7BzDmMMk5znmTWbPkslSjCmkSjP9yq7AdkurNL/gkavlLJ0u3cSlEkQksa8d2
	 XBWksWzD6ITnB2i+uwBhFQKh/vbfi8e+oB3VSsi7rf41xW1ONlWC4tiSHOoJil52WmPEi
	 9UMLjmya0Y4yyaqXOM6LEztchi8BQPZulG7ezc4XArm7YrA0AFe1s/PUny7kN+buJwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e/RQ1fY6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F127D606A32C;
	Sun, 22 Nov 2026 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/RQ1fY6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACF41F000D2;
	Sun, 22 Nov 2026 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366991;
	bh=gMafmWOv8TBm4c4ZfyWe/8aXJfH25fVK6a/gc7SwN9k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e/RQ1fY6BIYSH55Asf/BChFs2qCcohDUR4wdgq3Oa7+1t5DBQjvnnL8s7JfR8coPe
	 pqY8SuRWS4GG27uaF+nRjMcVhI5PQnNJJbxp3UzVRB5F57bkSIZZvb2BXCNG9JU5BN
	 ckbOubnEmhF/YMbhgxBSJAAG5FfSLjhjfDZj8xihQtRg/Gs++jURC+ySUYyjBp3mVP
	 /dfZXxUV5OAv/st5uKSTgp+XnOAM8m7Q9RRcjyrow18vj9Js0c3hEiddbVAXtZNXql
	 rzh3APoaiVUWZABXyclTa3zQBx5j3biqoGce9CMenotpwTbad4v+zlFMqHtSBRA+Te
	 94zDfrNDAr+0A==
Subject:
 Re: [PATCH net-next 7/8] eth: qede: drop the now-dead HW-GRO vs XDP handling
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org
Date: Sun, 22 Nov 2026 17:03:09 +0000
Message-ID: <179536698993.3135.14058741842243697942@kernel.org>
In-Reply-To: <20261118232315.3593731-8-kuba@kernel.org>
References: <20261118232315.3593731-8-kuba@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says the `edev->ndev->features &=
  ~NETIF_F_GRO_HW` line in the XDP branch of qede_alloc_mem_rxq() is…

--

eth: qede: drop the now-dead HW-GRO vs XDP handling

This commit removes the qede driver's own handling of the HW-GRO vs XDP
interaction. It relies on the core to clear NETIF_F_GRO_HW before
ndo_bpf runs and to keep it off while a program is attached. It drops
the xdp_prog check in qede_fix_features(), the reload skip in
qede_set_features(), and the direct dev->features write in
qede_alloc_mem_rxq().

> diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
> index 7ed17faced542..b24baf0e808e1 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_main.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
> @@ -1571,7 +1571,6 @@ static int qede_alloc_mem_rxq(struct qede_dev *edev, struct qede_rx_queue *rxq)
>  		rxq->rx_buf_seg_size = roundup_pow_of_two(size);
>  	} else {
>  		rxq->rx_buf_seg_size = PAGE_SIZE;
> -		edev->ndev->features &= ~NETIF_F_GRO_HW;
>  	}

[Severity: High]

Is this line really dead? The commit message says:

  the feature is already off by the time the reload for the program
  allocates the rings;

That is true for the ndo_bpf path. The firmware error recovery path,
though, seems to reach this else branch with GRO_HW set in dev->features
while edev->xdp_prog is still attached:

qede_sp_task()
  qede_recovery_handler()
    qede_unload(edev, QEDE_UNLOAD_RECOVERY, true)
    __qede_remove(edev->pdev, QEDE_REMOVE_RECOVERY)
    __qede_probe(..., QEDE_PROBE_RECOVERY)
      qede_init_ndev()
    qede_load(edev, QEDE_LOAD_RECOVERY, true)
      ...
        qede_alloc_mem_rxq()

In recovery mode, edev and edev->xdp_prog are kept. However,
qede_init_ndev() writes dev->features directly:

	hw_features = NETIF_F_GRO | NETIF_F_GRO_HW | NETIF_F_SG |
	...
	ndev->features = hw_features | NETIF_F_RXHASH | NETIF_F_RXCSUM |

Nothing on this path calls netdev_update_features(), so the core never
gets a chance to strip GRO_HW again.

With the clear gone, the end of qede_alloc_mem_rxq() then computes:

	edev->gro_disable = !(edev->ndev->features & NETIF_F_GRO_HW);
	if (!edev->gro_disable)
		qede_set_tpa_param(rxq);

qede_start_queues() then sets start.gro_enable = !edev->gro_disable,
so TPA is enabled in firmware while XDP is attached.

In qede_rx_process_cqe(), TPA CQEs return before the XDP hook runs:

	/* Handle TPA cqes */
	if (cqe_type != ETH_RX_CQE_TYPE_REGULAR)
		return qede_rx_process_tpa_cqe(edev, fp, rxq, cqe, cqe_type);
	...
	/* Run eBPF program if one is attached */
	if (xdp_prog)

After a recovery with XDP attached and the interface up, would
aggregated TCP traffic skip the attached program, so its XDP_DROP or
XDP_REDIRECT decisions are never applied? dev->features would also show
HW-GRO as on. This would last until something unrelated calls
netdev_update_features().

Would it be better to keep an XDP-aware check when computing
gro_disable, for example edev->xdp_prog || !(features & NETIF_F_GRO_HW)?
Other options would be to stop qede_init_ndev() from overwriting
dev->features on the recovery probe, or to call netdev_update_features()
once recovery completes.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118232315.3593731-1-kuba%40kernel.org
