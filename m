Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524629;
	b=PE+N4iOwmlvZTlCPqIfFwiWvyRjJZOiD0XSMpXfWQnouzxpIg58t31TgwO4Sg3d4ItB6
	 7dJ9nYaZ/8n/hZMQ1/dUTz0k41+fjp7ekkHFTRsFV/6yb3uRIY5dXJ7kDRIoslb3+brJv
	 OWqvhdhKQaMpNN8N6TJDiIabu/X6efi6uLOE0gSDgAK3CRSADxeuvJKF/4GDsrg5iHIMl
	 UOtfG/n+EoNKdYwrWr+zAcDTyqBi9OJF7Gyk93d0r0vEWaZhN0u6AFSl/kP64tNvygQLd
	 6Pr2v66GaqQ2Hty3ZYxwSsNIaQ/hgx5k85J/K57WaZnJlwH6hUAW0C43Ia+5tWtqh+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524629;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pkfYyUGAGP9LAnh0Vy+Vk5Lxb/y1tgcrwmawuqvziu4=;
	b=M1wOnnBUJIiEcIlMPHFn4fGhwIVGUf2zbyO2Dz4DB7unmR3tYX0urLOaNrm5gIxdeAF6
	 v1yc/EsKcPHQnRakF7fuvY4n8XwdC6jJAyUTXljcSZoQDvNqzhpssn0jVbkYSyIhhlG+Z
	 oyl4FHrjwPYxXpPZ/Gs+FXCEgl6NQGWHGWrtfXKDRigQC6TMIWXI5pU/V39ENSfTJ2Nda
	 nHzymGuNRTP/sAiTuSmsu8wNO1vAdZVA/edoi2rlwPrce0nu4xD1T8ljVsjTu7eUykSm2
	 1EhhwK3DJxuAfFf8yawtkSRKFcV4EIMNK/jk7HJ0ZhLCJXFoJf84OyOxjCfLaaePhvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJandJUF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C3606A33C;
	Tue, 20 Oct 2026 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJandJUF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4794E1F000CE;
	Tue, 20 Oct 2026 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524628;
	bh=pkfYyUGAGP9LAnh0Vy+Vk5Lxb/y1tgcrwmawuqvziu4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iJandJUFcwnk+ikpiPj91olcPJA82Qm+0jtWsq4AqxdKplyaaojFahwLZnSfnr6oP
	 3FUyGRv/YEHSVuEkNBKe0gW/xQ8vgvFJ8TKt3hmCB+s57oLD+2jrcbWUZxtjcRoIlS
	 LjhmWN5Yc55K7oDN1K6BXMhA8Zt+ELdUan7vo80LugO4jwEK96wf80ow9izWTHrfZ1
	 s+RXT1bRiR66rUWa0zvpUGnb4uO+tWeD3fun+zjpeHznQz/Uwp8LU0863nQ2/Dltyr
	 5TxrJRgvvcslGVg6zwVGGSyZgmmjlY0xQQnxFGZZNXVHo0Be3VH222sy/k7mrE8Sz5
	 iBsrfUI+G9VlQ==
Subject: Re: [PATCH v4 net-next 11/15] selftests: xsk: send UDP over IPv4 or
 IPv6 between the interface MACs
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:27 +0000
Message-ID: <179252462780.3135.9133783864572379009@kernel.org>
In-Reply-To: <20261016174338.787135-12-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-12-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new XDP filter makes the INVALID_DESC tests less able to
  catch a kernel that transmits a descriptor it should reject.
- [Medium] (Baseline: not a defect, handled later in the series.) The
  concern: on a multi-queue physical NIC, nothing steers the new UDP…
- [Low] This feature commit, which changes the wire format, the XDP
  programs and the CLI, also carries three fixes for bugs that predate…
- [Low] (Baseline: intentional design, the launchers validate.) The
  concern: parse_command_line() stores `strtoul(optarg, NULL, 10)` in…

--

selftests: xsk: send UDP over IPv4 or IPv6 between the interface MACs

This patch changes the xskxceiver test traffic from loopback-ethertype
frames between made-up MACs to UDP over IPv4 or IPv6 between the real
interface MACs. The XDP programs now redirect only UDP to the test port
and pass everything else to the stack. The patch also fixes several
helpers in test_xsk.c that could overrun buffers.

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> index ce88218fef00b..9c401a43da435 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c

[ ... ]

> @@ -238,10 +364,10 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  			else
>  				xsk->pkt_stream = test->rx_pkt_stream_default;
>  
> -			memcpy(xsk->src_mac, g_mac, ETH_ALEN);
> -			memcpy(xsk->dst_mac, g_mac, ETH_ALEN);
> -			xsk->src_mac[5] += ((j * 2) + 0);
> -			xsk->dst_mac[5] += ((j * 2) + 1);
> +			memcpy(xsk->src_mac, ifobj->caps.mac, ETH_ALEN);
> +			memcpy(xsk->dst_mac, peer->caps.mac, ETH_ALEN);
> +			/* xsk_xdp_shared_umem() picks the socket by it. */
> +			xsk->src_port = udp_port + j;
>  		}

[Severity: Medium]
On a multi-queue physical NIC, what steers this flow to the queue the
AF_XDP socket is bound to?

If RSS hashes L4 ports, the flow could land on another queue, and
xsk_rcv_check() would reject the redirect there. With XDP_SHARED_UMEM,
socket 1 sends from udp_port + 1. Its flow could therefore hash to a
different queue even when socket 0's flow lands on the right one.

At this patch the only in-tree runner is veth, so nothing breaks yet. Two
later patches in the series cover this:

"selftests: drv-net: test AF_XDP zero-copy with an SKB peer" adds
drivers/net/hw/xsk.py. Its _reserve_queue() takes the bound queue out of
RSS with "ethtool -X <if> equal <queue>". Its _steer_udp() installs a
dst-port ntuple rule, which matches both sockets' flows.

"selftests: xsk: document generic and hardware endpoint runs" documents
the ntuple and RSS requirement in README.rst.

This commit message is aimed at physical links. Should it, or the header
comment in xskxceiver.c, mention the steering requirement too?

[ ... ]

> @@ -792,31 +933,12 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
>  	return true;
>  }
>  
> -static int is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx, bool *supported)
> +static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
>  {
> -	struct bpf_map *data_map;
> -	int adjust_value = 0;
> -	int key = 0;
> -	int ret;
> -
> -	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
> -	if (!data_map || !bpf_map__is_internal(data_map)) {
> -		ksft_print_msg("Error: could not find bss section of XDP program\n");
> -		return -EINVAL;
> -	}
> -
> -	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
> -	if (ret) {
> -		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
> -		return ret;
> -	}
> -
>  	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program if the adjust_tail
>  	 * helper is not supported. Skip the adjust_tail test case in this scenario.
>  	 */
> -	*supported = adjust_value != -EOPNOTSUPP;
> -
> -	return 0;
> +	return skel_rx->bss->adjust_value != -EOPNOTSUPP;
>  }

[Severity: Low]
This isn't a bug, but this feature patch also carries three fixes for bugs
that existed before the series:

1) is_adjust_tail_supported() used bpf_map_lookup_elem() to copy the whole
xsk_xdp_.bss map into one stack int. At the baseline, .bss held idx,
adjust_value, count and drop_idx, 16 bytes in all. That overwrote 12
bytes of stack past adjust_value, and the int got the first word of .bss,
which is not necessarily adjust_value.

2) is_frag_valid() did len -= PKT_HDR_SIZE on a first fragment shorter
than the header. len wrapped, and the later reads went out of bounds.

3) is_pkt_valid() passed the total packet length to pkt_dump(). On a
multi-buffer packet, pkt_dump() read past the end of the first fragment.

The commit message describes all three. But because they ship with the
wire format, XDP program and CLI changes, they can't be backported or
reverted on their own. Older trees still have the original code in
tools/testing/selftests/bpf/prog_tests/test_xsk.c.

Could these go into a separate patch at the start of the series, with
Fixes: tags?

[ ... ]

> diff --git a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> index 023d8befd4cab..2b55dbaf13b24 100644
> --- a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c

[ ... ]

> @@ -15,12 +23,64 @@ struct {

[ ... ]

> +	} else {
> +		return NULL;
> +	}
> +
> +	if ((void *)(udp + 1) > data_end || udp->dest != bpf_htons(test_port))
> +		return NULL;
> +	*hdr_len += sizeof(*udp) + PKT_HDR_PAD;
> +	return udp;
> +}

[ ... ]

>  SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
>  {
> +	if (!is_test_packet(xdp))
> +		return XDP_PASS;
>  	return bpf_redirect_map(&xsk, 0, XDP_DROP);
>  }

[Severity: Medium]
Could this filter hide a kernel that wrongly transmits a descriptor that
the INVALID_DESC cases expect it to reject?

Before this patch, xsk_def_prog() redirected every frame to the XSKMAP.
An unexpected frame on RX then failed is_frag_valid() on the pkt_nb or
seqnum check. Now any frame that test_udp_hdr() does not see as UDP to
test_port gets XDP_PASS and never reaches __receive_pkts().

__send_pkts() writes a header only for valid entries:

    if (pkt->valid)
        pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, total_len,
                     pkt->pkt_nb, bytes_written);

pkt_get_addr() also gives invalid entries their raw pkt->offset. So the
bytes behind a negative descriptor are usually not a test header. For
example, this entry in testapp_invalid_desc():

    /* Straddle a 4K boundary */
    {0x1000 - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},

starts in the zero-filled tail of UMEM frame 0, so h_proto is 0.

The "Straddle the end of umem" entry starts inside the payload of the
packet at umem_sz - MIN_PKT_SIZE. The invalid-options and chunk-crossing
entries in testapp_invalid_desc_mb() look the same, for example:

    {0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},

If the kernel transmitted any of these, the RX program would pass them to
the stack, and the case would still pass.

The TX side would not catch it either. __send_pkts() adds every frag to
outstanding_tx (valid_frags += nb_frags), and these cases don't check the
tx_invalid_descs statistic.

Could these cases check tx_invalid_descs? Alternatively, could the RX
program redirect or count non-test frames while they run?

[ ... ]

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index fbfff586e0e5e..9704702f60fc9 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c

[ ... ]

> @@ -293,6 +314,20 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj

[ ... ]

> +		case OPT_UDP_PORT:
> +			opt_udp_port = strtoul(optarg, NULL, 10);
> +			break;

[Severity: Low]
Should this check errno, the end pointer and the range? The strtoul()
result goes straight into a u16, so:

    65536 becomes 0, which is rejected
    70000 becomes 4464
    "-1" becomes 65535
    "123junk" becomes 123

Only values that truncate to 0 are rejected, here by !opt_udp_port and
in xsk_set_flow().

With --udp-port 65535, socket 1's source port in __test_spec_init() wraps
to 0:

    xsk->src_port = udp_port + j;

Both endpoints truncate the same way, so the flow stays consistent.
xsk_xdp_shared_umem() still gets idx 1 for source port 0 through the
__u16 wrap-around.

Later commit messages in the series say the launchers own the range
checks. drivers/net/hw/xsk.py calls _check_opt("--udp-port",
cfg.udp_port, 1, 0xffff), and test_xsk.py takes the port from
rand_port(). Within xskxceiver, only --max-frags is range-checked, since
it sizes an array. A hand-run xskxceiver could still quietly use a
different port than the one requested.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
