Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3DF476CF1;
	Tue, 13 Oct 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912799; cv=none; b=HBVMZpfpOCmTNkKCC9FXM3UEPJaf3elZjJthL2BBnan5f7U+sOCynHli53wjYdAKvKIZgNsKmyEL5tKne0gviAa3icUYn69XspFyFwuGCHM9ypSEWpDHQQCcEKYomiEbBPL3df7ZItM2cgcdVG/yOfAm4wUOU0nmKr0Bf1iOzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912799; c=relaxed/simple;
	bh=uSopyzT5gw9alo2WFk3BLl62zeM5ESWwLUUXgdOCXTo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HYu1kbYNnQeZMbqQRti4lENiiyuKKkASFoz9uyl2LytVCQAzysh29ocWcbwcCqbE1Kd94ANJi4S48MClKN5X/D+Oo1BRgOW7m5qRcwav1YgoKpuj68RhEMnPyTADgurxTH/gHZxDS9k9gjESITvQDCHmmloANrrWmdmhQ7wHQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mvd5oJeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvd5oJeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFA81F000FF;
	Tue, 13 Oct 2026 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912798;
	bh=EHvNM9ipJklrkpLTY6Oc29cm4UHyMczj/tdT+1/AJpY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Mvd5oJeSm6zY2LpzUnsxYwtjaWkPPRyPrTiFJ1qmVC6zbnobpkokLFaeaCgD3rF/S
	 rRBzKcyVB5JwAMb1kYF8znUsgMzZ2wyO7znqRTDMEsz2an8Hj9FvM94mGZqcn0Rx8r
	 CK9URNHP8VBAkEHIncreZ/1Z7lVQshO6aQBKyqvroZy5CrBEI1tqVncnlFAsYmoneA
	 179A2v1I037RitWcYF0MIKwTryx9sdnev9hP2LhwuRlfKaP8wXY2lyftVSYlXf9LIM
	 OOZzjUefhB3Qrd5dE+goz8NIvJseqtRQ0lI3Tsot7UsEovKlsWarGqYftggdM1ZoBf
	 q4VbVLWK7K58A==
Subject: Re: [PATCH net-next v6 2/4] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
Date: Tue, 13 Oct 2026 17:33:16 +0000
Message-ID: <179191279658.434549.18208801431852161087@kernel.org>
In-Reply-To: <20261012-stmmac-rx-mb-v6-2-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-2-2225050915c1@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete on cores that use normal or enhanced RX
  descriptors (dwmac100 and dwmac1000/GMAC 3.x).
- [Low] On GMAC4/XGMAC, stmmac_rx_zc() now counts a multi-descriptor
  frame with a hardware error in rx_dropped instead of rx_errors.
- [Low] The commit message presents the patched code as the existing
  buggy code.

Pre-existing issues:
- [Low] Each RX NAPI poll, in stmmac_rx_zc() (stmmac_main.c:5789-5790)
  and stmmac_rx() (6091-6092), merges its local counts into the device-…

--

net: stmmac: drop split frames on AF_XDP zero-copy RX

This patch changes stmmac_rx_zc() so that, in AF_XDP zero-copy mode, a
frame spanning more than one RX descriptor sets error on its first
descriptor. The remaining descriptors, including the last one, are then
freed instead of being processed as a new frame. It also moves the buffer
free into the common error block and adjusts the rx_dropped and count
accounting.

> stmmac_rx_zc() assumes a 1:1 mapping between a received frame and an
> XSK pool buffer and drops any frame that spans more than one RX
> descriptor:
>
>         /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
>         if (likely(status & rx_not_ls)) {
>                 xsk_buff_free(buf->xdp);
>                 buf->xdp = NULL;
>                 rx_dropped++;
>                 error = 1;
>                 dirty++;
>                 goto read_again;
>         }
>
> The non-last descriptors are freed and dropped, but the frame is not
> marked as errored.

[Severity: Low]
Is this snippet the post-patch version rather than the existing code? It
contains rx_dropped++ and error = 1 and has no count++. Those are the
exact lines this patch adds and removes. The pre-patch branch was:

        if (likely(status & rx_not_ls)) {
                xsk_buff_free(buf->xdp);
                buf->xdp = NULL;
                dirty++;
                count++;
                goto read_again;
        }

The next sentence says the frame is not marked as errored. That
contradicts the error = 1 in the quoted snippet.

Could the snippet be replaced with the original code?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f66b796f7725b..426bb68c9bbce 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5701,18 +5701,21 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats,
>  						  rx_q->dma_erx + entry);
> -		if (unlikely(status == discard_frame)) {
> -			xsk_buff_free(buf->xdp);
> -			buf->xdp = NULL;
> -			dirty++;
> +
> +		if (unlikely(status == discard_frame) && !error) {
>  			error = 1;
>  			if (!priv->hwts_rx_en)
>  				rx_errors++;
>  		}

[Severity: Low]
On GMAC4/XGMAC, does this change how split frames with a hardware error
are counted?

The first descriptor of a multi-descriptor frame returns rx_not_ls from
dwmac4_wrback_get_rx_status(). It takes the 1:1 path further down, which
now does rx_dropped++ and error = 1.

The last descriptor may then return discard_frame because ES is set (CRC,
overflow, watchdog, giant). In that case the && !error guard here is
false, so rx_errors++ is skipped.

Before the patch, the 1:1 path did not set error. The last descriptor's
discard_frame incremented rx_errors, and rx_dropped was not touched.

The per-cause xstats counters are still incremented. However, ip -s link
now reports the frame as dropped rather than errored. Is that intended?
The commit message only says the frame is counted once in rx_dropped.

>  
> -		if (unlikely(error && (status & rx_not_ls)))
> -			goto read_again;
>  		if (unlikely(error)) {
> +			xsk_buff_free(buf->xdp);
> +			buf->xdp = NULL;
> +			dirty++;
> +
> +			if (status & rx_not_ls)
> +				goto read_again;
> +
>  			count++;
>  			continue;
>  		}

[Severity: High]
Does this fix also cover cores that use normal or enhanced RX descriptors
(dwmac100 and dwmac1000)? The continuation logic here relies on non-last
descriptors reporting rx_not_ls. Only dwmac4_wrback_get_rx_status() and
the dwxgmac2 callback do that.

enh_desc_get_rx_status() and ndesc_get_rx_status() report a non-last
descriptor like this:

drivers/net/ethernet/stmicro/stmmac/enh_desc.c:enh_desc_get_rx_status() {
    ...
	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
		x->rx_length++;
		return discard_frame;
	}
    ...
}

With that encoding, a frame split across two descriptors goes through
stmmac_rx_zc() like this:

first descriptor:
    in_progress = status & rx_not_ls;          /* 0 */
    status == discard_frame && !error  ->  error = 1
    error block frees buf->xdp, dirty++
    (status & rx_not_ls) is 0  ->  count++; continue;

next loop iteration:
    if (!in_progress) { error = 0; len = 0; }

last descriptor:
    good status, so it skips the error block and the 1:1 rx_not_ls check

The tail is then processed as a complete new frame. With len == 0,
stmmac_rx_buf1_len() returns:

	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);

That value is dma_buf_sz, but the DMA only wrote the tail remainder into
that XSK buffer. The tail starts mid-payload and goes to the XDP program,
to XDP_TX, or to stmmac_dispatch_skb_zc() on XDP_PASS.

Isn't that the same symptom the commit message says this patch removes?

This path looks reachable:

- __stmmac_dvr_probe() advertises NETDEV_XDP_ACT_XSK_ZEROCOPY for every
  core.
- stmmac_xdp_enable_pool() only checks the queue indices and the frame
  size. It does not check the core or the descriptor format.
- dwmac1000 and dwmac100 have no .set_bfsize op. The buffer size
  programmed by stmmac_clear_rx_descriptors() is therefore dma_buf_sz,
  which is 1536 at MTU 1500.

dwmac1000_core_init() only enables the larger frame modes above
MTU 1500:

	if (mtu > 1500)
		value |= GMAC_CONTROL_2K;
	if (mtu > 2000)
		value |= GMAC_CONTROL_JE;

XDP limits the MTU to 1500, so neither bit is set. It appears an on-link
peer could still send a frame between 1536 bytes and the 2048-byte
watchdog limit, and the hardware would split it across two descriptors.

Would it work better to track continuation from the hardware LD/FD bits?
Other options are to have the enh/norm callbacks report rx_not_ls for
non-last descriptors, or to refuse XSK zero-copy on these descriptor
formats.

> @@ -5721,8 +5724,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (likely(status & rx_not_ls)) {
>  			xsk_buff_free(buf->xdp);
>  			buf->xdp = NULL;
> +			rx_dropped++;
> +			error = 1;
>  			dirty++;
> -			count++;
>  			goto read_again;
>  		}

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
new rx_dropped++ feeds into this accumulator at the end of
stmmac_rx_zc():

	priv->xstats.rx_dropped += rx_dropped;
	priv->xstats.rx_errors += rx_errors;

stmmac_rx() does the same thing. Each channel has its own NAPI instance.
RX queues polling on different CPUs can therefore do these non-atomic
read-modify-writes on the device-wide unsigned long fields at the same
time. stmmac_get_stats64() also reads them without any synchronization.

Can increments to rx_dropped and rx_errors be lost when two queues finish
their polls at the same time?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-stmmac-rx-mb-v6-0-2225050915c1%40oss.qualcomm.com
