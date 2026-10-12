Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD541CB5E;
	Mon, 12 Oct 2026 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795032; cv=none; b=rdLla16/7ZmDGD6HNH+sSXG7sLvEEetfLz1FXQxMRTe0FzSll4JIY86CcawE28ayOIQcl11X/hh/zwI5aeBE4mH942MfGWjaoRWPW9Nhxn6l5IhlSxUf/e/DQfxHksl+zmx/x+oUl1QhlbgsG0eSTvbQoeeT4HPjZljLHqrFbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795032; c=relaxed/simple;
	bh=yNy4mOgrNXt2OyPJ7L544fb2iUezscWWPV+5/+Lfgj0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cp4HnbQTZZLpAyQ+fS2lPUtdYr8JF48M0pWRMObYJN9a4DkLdWqjCLfRra7qpsknvad2eCLUMh3HOcF1ZYpw19gwt4906SwheXn/Tmb5KcK0FfzmvtSN0pT2jHIKvVdVR3RNeaNd5O8UBZgeMK2JXcTcGsaXD4GmValaX5NNmI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa3JIpS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa3JIpS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7D51F0089B;
	Mon, 12 Oct 2026 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795029;
	bh=4PL++02OuB075LAl16+ZQe8NJ5v9WzXC+18PpJOnm9s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xa3JIpS7kV65qBNslByF6JMhan5IcolFMbULFxDxXlZgCKY50JXf2y0fGn4oGiuqH
	 n7mV2ZiES98+xH5cy54/sDQYsP0q+nsQWvNLFy8RnHFIJBOBKVU0a0Jc7U4lJLOqe9
	 AWD9VUzTJnP2MS2Za25Qh5111rfU3tWNQyGcJT0IHGYBF01GUFGRGhlkFzBQBfE5Wi
	 NOxjK6LZpY0/dCJTf0+VfETe8d9mNp7tXF3T9f5B4I3Kal9cTlzCxL2GDXgT62vCE4
	 wUWANq9vhxFnUyjZEvMN53GLYeTVTFDIqp83cG9m3KOcoztSv414+9WllewyUdCVA+
	 7SgQ5Gjv12YnA==
Subject: Re: [PATCH v2 net-next 11/14] selftests: xsk: pass non-test traffic
 to the stack in hardware mode
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Mon, 12 Oct 2026 08:50:28 +0000
Message-ID: <179179502823.434549.9700326245084721655@kernel.org>
In-Reply-To: <20261008114909.734364-12-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-12-maciej.fijalkowski@intel.com>
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

- [Low] The comment this patch adds in xsk_load_xdp_programs() ("The
  shadow's copy too, swapped directions attach its programs.") is…
- [Low] In hardware (UDP) mode, xsk_xdp_adjust_tail() in
  xsk_xdp_progs.bpf.c writes the wrong sequence number at the end of a…
- [Low] is_test_packet() in xsk_xdp_progs.bpf.c does not check
  ip->frag_off before reading the bytes after the IPv4 header as a…

Pre-existing issues:
- [Medium] is_adjust_tail_supported() in
  tools/testing/selftests/net/lib/xsk/test_xsk.c overflows a stack…

--

selftests: xsk: pass non-test traffic to the stack in hardware mode

In hardware mode, this commit makes the xskxceiver XDP programs redirect
only UDP/IPv4 packets sent to the test port (--udp-port). Everything else
is passed to the stack. A new hw_port .bss variable is set from
xsk_load_xdp_programs(), and an is_test_packet() helper gates each
program. When hw_port is 0, every packet is still redirected.

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> index 542c0579062a4..1033a5430697a 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> @@ -2454,6 +2454,8 @@ int xsk_load_xdp_programs(struct ifobject *ifobj)
>  	if (libbpf_get_error(ifobj->xdp_progs))
>  		return libbpf_get_error(ifobj->xdp_progs);
>  
> +	/* The shadow's copy too, swapped directions attach its programs. */
> +	ifobj->xdp_progs->bss->hw_port = udp_port;

[Severity: Low]
This comment looks right, but it contradicts the comment in setup_peer()
in xskxceiver.c, which was added earlier in this series:

tools/testing/selftests/net/lib/xsk/xskxceiver.c:setup_peer() {
	/* Unattached skeleton copy; the engine only attaches the local side. */
	if (xsk_load_xdp_programs(shadow))
		return TEST_FAILURE;
    ...
}

test_spec_reset() binds test->xdp_prog_tx and test->xskmap_tx to
ifobj_tx->xdp_progs. That is the shadow when the local endpoint is RX.

swap_directions() only swaps the ifobject pointers. After the swap,
xsk_attach_xdp_progs() does:

	if (xdp_prog_changed_tx(test))
		err = xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);

This attaches the shadow's program and XSKMAP to the real NIC, for
example in testapp_bidirectional().

Should the setup_peer() comment be updated too? A reader who trusts it
could drop the hw_port write for the shadow. That would bring back the
redirect-everything behaviour after a direction swap.

>  	return 0;
>  }
>  
> diff --git a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> index 023d8befd4cab..716360d023a77 100644
> --- a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c

[ ... ]

> @@ -18,9 +22,34 @@ struct {
>  static unsigned int idx;
>  int adjust_value = 0;
>  int count = 0;
> +/* UDP port of the hardware test flow, 0 redirects every packet */
> +__u16 hw_port;

[Severity: Medium]
This is a pre-existing issue, but adding hw_port to .bss makes it
somewhat worse. is_adjust_tail_supported() in test_xsk.c reads the whole
.bss map value into a 4-byte local:

tools/testing/selftests/net/lib/xsk/test_xsk.c:is_adjust_tail_supported() {
	int adjust_value = 0;
	...
	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
	...
}

bpf_map_lookup_elem() copies value_size bytes, which here is the full
.bss section. Before this patch, .bss already held idx, adjust_value,
count and drop_idx, so about 16 bytes were written into a 4-byte int.
With hw_port added, it is now about 18-20 bytes.

Can this overwrite other stack variables, or trip the stack protector?
This happens when testapp_validate_rx_endpoint() calls
is_adjust_tail_supported() after an adjust_tail test fails.

This patch already sets hw_port through the skeleton. Could
is_adjust_tail_supported() read skel_rx->bss->adjust_value the same way?

> +
> +static __always_inline bool is_test_packet(struct xdp_md *xdp)
> +{
> +	void *data_end = (void *)(long)xdp->data_end;
> +	void *data = (void *)(long)xdp->data;
> +	struct ethhdr *eth = data;
> +	struct udphdr *udp;
> +	struct iphdr *ip;
> +
> +	if (!hw_port)
> +		return true;
> +	if ((void *)(eth + 1) > data_end ||
> +	    eth->h_proto != bpf_htons(ETH_P_IP))
> +		return false;
> +	ip = (void *)(eth + 1);
> +	if ((void *)(ip + 1) > data_end || ip->ihl != 5 ||
> +	    ip->protocol != IPPROTO_UDP)
> +		return false;
> +	udp = (void *)(ip + 1);
> +	return (void *)(udp + 1) <= data_end && udp->dest == bpf_htons(hw_port);
> +}

[Severity: Low]
Should is_test_packet() also check ip->frag_off? A non-initial IPv4
fragment has no UDP header after the IP header. If it has ihl == 5 and
protocol == IPPROTO_UDP, its payload bytes 2-3 are read here as
udp->dest.

If those bytes happen to equal htons(hw_port), is_test_packet() returns
true. xsk_def_prog() and the other programs then redirect, drop or
modify an unrelated fragment instead of returning XDP_PASS.

That datagram can then not be reassembled. The test socket may also
receive a frame that fails validation.

The commit message says only UDP/IPv4 packets sent to the test port are
redirected. Other parsers in the tree, such as xdp_flowtable.c and
xdp_synproxy_kern.c, reject fragments by checking
frag_off & bpf_htons(IP_MF | IP_OFFSET).

[ ... ]

> @@ -80,6 +116,9 @@ SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
>  	__u32 buff_len, curr_buff_len;
>  	int ret;
>  
> +	if (!is_test_packet(xdp))
> +		return XDP_PASS;
> +
>  	buff_len = bpf_xdp_get_buff_len(xdp);
>  	if (buff_len == 0)
>  		return XDP_DROP;

[Severity: Low]
This patch gates xsk_xdp_adjust_tail() for hardware mode. Does its grow
path still write the wrong end sequence number for UDP frames?

tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c:xsk_xdp_adjust_tail() {
	...
	if (curr_buff_len > buff_len) {
		...
		len = curr_buff_len - PKT_HDR_ALIGN;
		words_to_end = len / sizeof(*pkt_data) - 1;
		...
}

PKT_HDR_ALIGN is sizeof(struct ethhdr) + 2, which is 16. In hardware
mode, xsk_set_udp_packet_format() sets pkt_hdr_size to UDP_PKT_HDR_SIZE
(44), and is_frag_valid() uses that value:

	pkt_data += pkt_hdr_size / sizeof(*pkt_data);

Take a 132-byte grown frame. The program stores (132 - 16) / 4 - 1 = 28,
but is_frag_valid() expects (132 - 44) / 4 - 1 = 21. The check then
prints "expected seqnum at end [21], got seqnum [28]". The multi-buffer
variant is off by the same 7 words.

testapp_adjust_tail_grow() and testapp_adjust_tail_grow_mb() only skip
TEST_MODE_SKB. testapp_xdp_shared_umem(), by contrast, returns TEST_SKIP
under hw_test.

xsk.py does not schedule these cases on hardware, because their hardware
directions are 0 in test_xsk_case_defs.h. Running xskxceiver --hw
directly with these cases would fail rather than skip.

The mismatch comes from the earlier patch "selftests: xsk: add a hardware
mode to xskxceiver", and this patch leaves it in place. Should these
cases skip under hw_test, or should the program use the UDP header size
in hardware mode?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008114909.734364-1-maciej.fijalkowski%40intel.com
