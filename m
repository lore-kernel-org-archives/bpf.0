Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8A3B1031;
	Sat, 17 Oct 2026 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206366; cv=none; b=uGvUJMyxyGPBLmTYPSIeM3RvB8U7IDQKZPAotTEtq+rWs2oynuW7tYc7bRn7gfahwO2CFl6sBLPEcRc5NQ2SkPemLjK+GnOWHkQsj61QDqSU1iB+wX6lRf0Ihn+z3pKLS003KVtxZRzztAc2T4hK3fzTZPnDThLhmO95sYpdhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206366; c=relaxed/simple;
	bh=k/puwnAmtqKwwrMShtfogE1faF0/dMxv9JkaSQwrdrQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1+dJgA1iqv0Bn+q/JZnQaIO5mZgHFf2SDWlm+AjdeiWdHgsLwXvUUmAxrksZnLiV3MlXQGSicLZ2V9VI5B/GNG9fI+YjK/qYzhM4ukh26LVEqB1Wrte1PhE0Y6Y0TcSeTIAV+AO4aUz/xiXKl7qojAVdSEqyx0AORdBCT0yxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwrchEVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwrchEVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6191F000C4;
	Sat, 17 Oct 2026 03:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206364;
	bh=HT1f83y0Ex2+cmXeAgKuiIjyX6eBMtAEaBDH0huDTuU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lwrchEVElWKIA0yKYbDNf9Gct+TaVLEt+vjvkRGAOL8UvCAsfLqFaOQX4o8SvDcZL
	 tJDexzMaPL/qPcgkP6LPWVwGN9X6mz6BfSMnF2iMxIsYpipii+Ey6nK3AC6v6RXy9L
	 Hp9aiBGd5sz3Zyvh2hG20pulbeRmNduC3+4eHQC1BADh1GqxD7mkw0Qf0wrTgx2KZB
	 JsM8v1UO21Bfii3pYqOPszWMr5JlT8Pn+TwLQ9r/fx6j5LfvfqSry09vFUR4jpjLbb
	 h5DZjvT0yXXMvAMZVvGZgKitgHfOeGhAV1L5fR1gbZuaiMZpofjGHoBMhE9ZuRfbu2
	 MddTQ1fupZrzA==
Subject: Re: [PATCH v3 net-next 02/15] selftests: xsk: size the TX UMEM in
 HW_SW_MAX_RING_SIZE
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Sat, 17 Oct 2026 03:06:03 +0000
Message-ID: <179220636394.434549.14546514468412075500@kernel.org>
In-Reply-To: <20261014184539.774708-3-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-3-maciej.fijalkowski@intel.com>
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

- [Medium] In testapp_hw_sw_max_ring_size()
  (tools/testing/selftests/bpf/prog_tests/test_xsk.c), the patch gives…

--

selftests: xsk: size the TX UMEM in HW_SW_MAX_RING_SIZE

In testapp_hw_sw_max_ring_size(), this patch gives the TX UMEM the same
8k frames, fill ring and completion ring as the RX UMEM. In two-interface
mode the TX UMEM has only 1k frames, so the 2k batch stalls in
__send_pkts(). The patch prepares for removing the single-interface mode
in the next patch.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 2a13628740924..16fe32e5afc06 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -2513,6 +2513,9 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  	test->ifobj_rx->xsk->umem->num_frames = max_descs;
>  	test->ifobj_rx->xsk->umem->fill_size = max_descs;
>  	test->ifobj_rx->xsk->umem->comp_size = max_descs;
> +	test->ifobj_tx->xsk->umem->num_frames = max_descs;
> +	test->ifobj_tx->xsk->umem->fill_size = max_descs;
> +	test->ifobj_tx->xsk->umem->comp_size = max_descs;

[Severity: Medium]
Does the second step still stall on NICs that report a tx_max_pending of
8200 or more?

max_descs is fixed at 4 * XSK_RING_PROD__DEFAULT_NUM_DESCS, which is 8192.
The step-2 batch later in testapp_hw_sw_max_ring_size() still comes from
the maximum the driver reports:

	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;

Here is the in-flight limit check in __send_pkts():

	if (pkts_in_flight >= (int)((umem_size(umem) - xsk->batch_size * buffer_len) /
	    buffer_len) && !test_timeout) {

With batch_size == 8192 the limit is 0. With batch_size > 8192 the u64
subtraction wraps, and the truncated int is 8192 - batch_size, which is
negative. In both cases TX only kicks and returns TEST_CONTINUE.

Even if that check passed, xsk_ring_prod__reserve(&xsk->tx, batch_size,
...) can never reserve more than the 8192 slots of the TX ring. This is
because xsk_configure_socket() sets cfg.tx_size = umem->comp_size.

Some hardware that supports AF_XDP reports larger maximums:

- octeontx2: otx2_get_ringparam() reports tx_max_pending =
  Q_COUNT(Q_SIZE_MAX), which is 1048576. The batch is 1048568 and the
  limit is -1040376.
- hns3: reports HNS3_RING_MAX_PENDING, which is 32760. The batch is 32752
  and the limit is -24560.

ice (8160) and mlx5 (8192) fit within the limit.

On the larger NICs, TX never sends and RX times out. That seems to be the
same failure the commit message describes:

  "the in-flight limit in __send_pkts() turns negative for a 2k batch,
  so TX never sends and RX times out, and the second batch would not fit
  in the TX ring anyway."

At the end of the series, tools/testing/selftests/net/lib/xsk/test_xsk.c
still uses the fixed 8192 and xsk_get_cap(test, tx_max_pending) - 8. Once
the single-interface mode is gone, two-interface mode is the only one
left, so this case would keep failing on those NICs.

A 1M-frame UMEM would need 4 GiB. Could the step-2 batch be clamped to
the software ring instead, for example min(tx_max_pending, max_descs) - 8?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
