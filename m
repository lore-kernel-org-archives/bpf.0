Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524628;
	b=Gm8av0JUHRBNUicu52fP80I8riKZU8ujzjgMGe/XOv24L5b76S58ag54QLfsLedeKF9I
	 W8H41QtbFzjR4bwTavyWm+/gkEUC9Whd35pSRdwzwiLnvEp2XMJMuu8vZYd0niERyIJF8
	 iSwN816ugm2gkuRoODoGjpX+PZkZXGDvK8FEFWoWYY+UlQGuk4XDxVJhczc2YJLRd8KXl
	 SOIECmxDTMaN07Xqeqld9duCxxjCOJYpRWjv+gbg7kXe+RteX+1aSRJk/UAWEB9V6KF59
	 kVPmZET8jhfS+RhPpdZV1PcVFuXTnhSQTt+2nUmm4V8VlcNuC+7idIHwq+/3H05lnnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524628;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nr7n0KV3XaoCzzLIl04hIKAJBlF9TKM+nh434rYZHAo=;
	b=MvBsSMzQBr35lU6BCi1gHxob/euW9VGRAv45vc5StmtKeUW6IXKAwTwjt3dVsYOHBcze
	 WaSnar0Dl5QcMQVF/ymDHc6w3WZj57cp4JzPCsc7OF/Sfj/xlznG9/cfjPsCB8EWAHIph
	 QXRLSBjQrHQSFRRjaEEdgHbYQJfAxXNonGxbQW2WjRF74Qw8ukmmpN8h9hKxfIL4p2FAP
	 QSRNwTAJv7iFGsiFMljxvqwj7VLcKu3D255p8p15E4vjGQ8TBagLLyZV0tdhJiQpM8/Pc
	 O7fRiEv/cAKvC0OWcy2K+ZX2ssqDFWpaWG3VMN4NGRefNG5Bu4w/vsupMBWig80DwOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCllyH4O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5FC606A326;
	Tue, 20 Oct 2026 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCllyH4O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7D31F000C9;
	Tue, 20 Oct 2026 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524627;
	bh=nr7n0KV3XaoCzzLIl04hIKAJBlF9TKM+nh434rYZHAo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fCllyH4OxyRGMO35nMP9/7CBKsN07PETmPprLNK5JlL4jTAjP2FywmEWFGbG6rZpI
	 II2V+G7TdkdzoE8QsTaaY8rkXuW9mazrpqj3siLKohQ4S3ufyFdFDDaHS35aw43JJ6
	 VvXpoSbLjU0OapWF+OLlfOxy6ZK58vye9u8N8lHCwxZaqwtGjD2ZNikOeoTTG6ZFfv
	 WgDrrzkxGYDy45fi3ozXRop7sZAZqbXvKfAvlWEuOE3lELnFQ3N8F7mHMmjH7qZxTq
	 UayUr/2TE/cSrBLY/R2y2T7BcBrH0sbk0HhzBt9p1EfYSPHQeFY6lWhgxFhDv+iyOK
	 H9KSZVKJOSi5A==
Subject: Re: [PATCH v4 net-next 10/15] selftests: xsk: run the RX and TX
 endpoints in separate processes
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:26 +0000
Message-ID: <179252462658.3135.12143911663224541762@kernel.org>
In-Reply-To: <20261016174338.787135-11-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-11-maciej.fijalkowski@intel.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Skip handling in the launcher and the endpoints don't match.

--

selftests: xsk: run the RX and TX endpoints in separate processes

This commit splits xskxceiver into separate RX and TX processes. The two
processes stay in step over a TCP control channel that carries READY,
PROGRESS and ABORT messages. test_xsk.py starts TX as the listener on
127.0.0.1, starts RX once TX listens, and builds the verdict from both
exit codes.

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index b4f9cd3715037..fbfff586e0e5e 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c

[ ... ]

> @@ -409,12 +474,26 @@ int main(int argc, char **argv)

[ ... ]

>  	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
>  	test.rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
>  	if (!test.tx_pkt_stream_default || !test.rx_pkt_stream_default)
>  		goto out;
>  
> -	caps = detect_mode_caps(ifobj_tx);
> +	if (setup_peer(local_ifobj, shadow_ifobj, &peer))
> +		goto out;
>  
>  	if (!mode_supported(opt_mode, caps)) {
>  		if (opt_mode == TEST_MODE_DRV)

[Severity: Low]

Suppose this endpoint skips here because of its local caps. It then goes
to out: and closes the control socket without telling the peer. The
control protocol in xsk_peer.c has only these message types:

enum xsk_peer_msg_type {
	XSK_PEER_READY = 1,
	XSK_PEER_PROGRESS,
	XSK_PEER_ABORT,
};

Would a peer that is still waiting in xsk_peer_ready() get -EPIPE and
fail in sync_endpoints(), instead of skipping?

In test_xsk.py, _test() reports a skip only when neither endpoint fails:

    if SKIP_CODE in rets and rets <= {0, SKIP_CODE}:

That means the exit codes would be {4, 1}, and the case would be reported
as a failure. Other local skips work the same way, for example the
multi-buffer check in __testapp_validate_traffic() and the unaligned
check in testapp_validate_traffic().

This doesn't look reachable in this commit. With the veth runner both ends
have the same caps, so these early skips happen on both sides and give
{4, 4}. The problem would only show up with endpoints on two hosts.

The later commit "selftests: xsk: prepare xskxceiver for endpoints on two
hosts" seems to close this gap. It adds XSK_PEER_SKIP, xsk_peer_skip()
(called from main() when ret == TEST_SKIP) and xsk_peer_skipped() checks
in sync_endpoints() and __send_pkts().

Could the skip message move into this patch? Or could the commit message
say that, until then, skips are expected to happen on both endpoints?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
