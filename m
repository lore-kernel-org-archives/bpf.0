Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B018DB1A;
	Mon, 12 Oct 2026 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795030; cv=none; b=uB7HPIChITh5m52zmOwrrvqkXUVU8eVpQTKYdPYtIWw9uPgTrXThGlreqwl9vC0YPnN7Jgt0BV8JGIU/q2myKULhY7Q2kgPlYMNjsUQmwnwXSDswivJy3ljU/li+SjEkyr6nUVFuI0Mw1QPwSRnFS/Q7sUzoOGLUsJIZF2Td88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795030; c=relaxed/simple;
	bh=4f115j/XdIW3UUE0cCA6Dr939C3lcaSzLyxNKBpbtns=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5nhbpfeka2SETVrCW9d85/HA/BU6JQYRbICfLZMqW68rh0O/cdIjgdu70MlMnnZHJFDPP+z3STq0JdYjA4H426VFWlN3n7txjSzPDf4TJUCkBgwuEYjAGfyWLfq9YaEzQFXyKa8SfcX3Dq5L8tx20UzzTEUny9JxEM2mBEV6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEHwi1WF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEHwi1WF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FC11F0089D;
	Mon, 12 Oct 2026 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795028;
	bh=RLfpCfKqkY7oIlyBSdDkyGLTHLv+4pge7hMcr5ZY4nQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZEHwi1WFEtBtxnTjy9GpEO6a6D2VFeBYJxCkCEEo2v3tqp4eyvbRE9FuxzGRveFEG
	 URij5IXHjAmawppQjW+bb0cIrSDBLOSBSHpPcxAdVT1Q5CBGALzJCyUiedWEppDKCe
	 bV7uq793JqmEAbccnHJoskCnf8ziIW1EN1AE3wAlcDsG9f4teviCNu+ZIBwLjAQs6n
	 jviVmFYs3JQsMK3pxcKU3yARtkis9w8FVTbBiEstJdZo5z+ULLReJpNh0O2YD0Q19e
	 PWEn7/l1wq0K/qODuq671XT1gapyerMbVCdlEhmiq+nfrU8BDqE7mOIPTTqVKjBb0+
	 NpmDtIp+qkbPw==
Subject: Re: [PATCH v2 net-next 10/14] selftests: xsk: add a hardware mode to
 xskxceiver
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Mon, 12 Oct 2026 08:50:26 +0000
Message-ID: <179179502693.434549.1644239970750622984@kernel.org>
In-Reply-To: <20261008114909.734364-11-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-11-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In --hw mode, the code compares two different MTU units, so
  the NIC MTU is changed on almost every case.
- [Medium] The commit message says is_frag_valid() now rejects fragments
  that are too short 'instead of reading past the end of the buffer'.
- [Medium] When a hardware endpoint changes its MTU (on standard 1500-MTU
  hosts that happens every case, see the MTU-unit finding), nothing…
- [Low] The commit message says 'a hardware endpoint prints no KTAP
  output of its own'.
- [Low] The XDP_ADJUST_TAIL_GROW header-size mismatch is real in the
  code: userspace uses pkt_hdr_size = 44 (eth + IPv4 + UDP + 2), while…
- [Low] Mode-dependent test gating differs between the ZC DUT and the SKB
  peer.
- [Low] With --hw, detect_mode_caps() never sets XSK_CAP_DRV unless the
  mode is ZC and ZC is advertised.
- [Low] bind_iface() now loads the device's current MTU into ifobj->mtu
  before detect_mode_caps() runs.
- [Low] The new ip_checksum() reads a struct iphdr through a 'const u16
  *'.

--

selftests: xsk: add a hardware mode to xskxceiver

This adds a --hw mode to xskxceiver. A later drivers/net/hw/xsk.py runner
uses it to drive a zero-copy DUT and an SKB-mode remote endpoint over a
physical link, sending UDP/IPv4 test packets between the real interface
MACs. It also adds --queue, --listen and --max-frags, longer timeouts for
hardware cases, MTU restore in cleanup_iface(), and length guards in
is_frag_valid() for the variable header size.

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> index 8d30c39c94c84..542c0579062a4 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c

[ ... ]

> @@ -84,11 +97,70 @@ static void write_payload(void *dest, u32 pkt_nb, u32 start, u32 size)
>  		ptr[i] = htonl(pkt_nb << 16 | (i + start));
>  }
>  
> -static void gen_eth_hdr(struct xsk_socket_info *xsk, struct ethhdr *eth_hdr)
> +int xsk_set_udp_packet_format(const char *src_ip, const char *dst_ip, u16 port)
>  {
> +	if (inet_pton(AF_INET, src_ip, &udp_src_ip) != 1 ||
> +	    inet_pton(AF_INET, dst_ip, &udp_dst_ip) != 1 || !port)
> +		return -EINVAL;
> +	udp_packets = true;
> +	udp_port = port;
> +	pkt_hdr_size = UDP_PKT_HDR_SIZE;

[Severity: Low]
The xsk.py runner later in the series can't reach this, but should
xsk_xdp_adjust_tail() in xsk_xdp_progs.bpf.c use this header size as well?

With --hw, userspace now uses a 44 byte header. The BPF side still computes
the grown tail seqnum with the fixed 16 byte header:

    len = curr_buff_len - PKT_HDR_ALIGN;

test_xsk_case_defs.h gives XDP_ADJUST_TAIL_GROW and
XDP_ADJUST_TAIL_GROW_MULTI_BUFF hardware direction 0, and the SKB peer skips
these cases anyway. So this would only show up if someone started two --hw
endpoints in ZC mode by hand.

> +	return 0;
> +}
> +
> +void xsk_set_max_frags(u32 max_frags)
> +{
> +	max_frags_override = max_frags;
> +}
> +
> +static u16 ip_checksum(const void *buf, size_t len)
> +{
> +	const u16 *word = buf;
> +	u32 sum = 0;
> +
> +	while (len > 1) {
> +		sum += *word++;
> +		len -= sizeof(*word);
> +	}

[Severity: Low]
This doesn't affect the test results as far as I can tell, but
ip_checksum() reads the local struct iphdr through a const u16 pointer.
That includes the __be32 saddr and daddr fields that gen_pkt_hdr() has just
stored.

xskxceiver is now built from tools/testing/selftests/net/lib with -O2 and
without -fno-strict-aliasing:

    CFLAGS += -Wall -Wl,--no-as-needed -O2 -g

Under strict aliasing, could the compiler move these u16 loads ahead of the
u32 stores and produce a wrong IPv4 checksum? Copying the bytes with
memcpy() or using a union would avoid the type punning.

> +	while (sum >> 16)
> +		sum = (sum & 0xffff) + (sum >> 16);
> +	return ~sum;
> +}

[ ... ]

> @@ -347,14 +430,25 @@ static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *x
>  	test->xskmap_tx = xskmap_tx;
>  }
>  
> -static int test_spec_set_mtu_ifobj(struct ifobject *ifobj, int mtu)
> +/* An MTU change can reset a NIC. A hardware SKB-mode endpoint runs a case at
> + * any larger MTU, as generic XDP does not limit it, so only raise its MTU.
> + */
> +static bool mtu_change_needed(struct ifobject *ifobj, enum test_mode mode, int mtu)
> +{
> +	if (hw_test && mode == TEST_MODE_SKB)
> +		return ifobj->dev_mtu < mtu;
> +	return ifobj->dev_mtu != mtu;
> +}

[Severity: Medium]
Are dev_mtu and the mtu argument in the same units here?

bind_iface() fills dev_mtu and orig_mtu from SIOCGIFMTU, which is the L3
MTU (normally 1500). The default test->mtu set in __test_spec_init() is a
frame size:

    test->mtu = MAX_ETH_PKT_SIZE;

That 1518 value then reaches xsk_set_mtu() as IFLA_MTU.

On a host with the standard 1500 MTU, mtu_change_needed() returns true for
the ZC DUT (1500 != 1518) and for the SKB peer (1500 < 1518). Every case
then sets the NIC to 1518 first, and cleanup_iface() puts it back to 1500
afterwards:

    if (ifobj->dev_mtu != ifobj->orig_mtu) {
        err = xsk_set_mtu(ifobj->ifindex, ifobj->orig_mtu);

That is two NIC reconfigurations per case on both hosts, which this comment
and the commit message aim to avoid. On ixgbe, for example, ndo_change_mtu
goes through ixgbe_reinit_locked(), and ixgbe_down() turns off the TX
laser.

A peer whose max_mtu is ETH_DATA_LEN would also reject 1518 in
dev_validate_mtu(). __testapp_validate_traffic() would then fail every
hardware case with "could not set mtu", even though the default cases only
send 64 byte frames.

> +
> +static int test_spec_set_mtu_ifobj(struct ifobject *ifobj, enum test_mode mode, int mtu)
>  {
>  	int err;
>  
> -	if (ifobj_is_local(ifobj) && ifobj->mtu != mtu) {
> +	if (ifobj_is_local(ifobj) && mtu_change_needed(ifobj, mode, mtu)) {
>  		err = xsk_set_mtu(ifobj->ifindex, mtu);
>  		if (err)
>  			return err;
> +		ifobj->dev_mtu = mtu;
>  	}

[Severity: Medium]
After xsk_set_mtu() succeeds on a hardware endpoint, does anything wait for
the physical link to come back before traffic starts?

__testapp_validate_traffic() goes from test_spec_set_mtu() straight to
xsk_attach_xdp_progs(), socket setup and the READY exchange. The READY
exchange uses the separate control connection:

    err = test_spec_set_mtu(test, test->mtu);
    ...
    err = xsk_attach_xdp_progs(test, ifobj1, ifobj2);

On a driver like ixgbe, ixgbe_change_mtu() calls ixgbe_reinit_locked() and
carrier drops on both ends. While carrier is down, generic AF_XDP TX on the
SKB-mode peer goes through __dev_direct_xmit(), which drops and completes
the frames.

AF_XDP never retransmits. Can the RX endpoint then time out and report a
false failure? The longer HW_THREAD_TMOUT would not bring back frames that
were already dropped.

Combined with the MTU unit question above, this would happen on every case
on hosts with the standard 1500 MTU.

>  
>  	ifobj->mtu = mtu;

[ ... ]

> @@ -867,11 +974,15 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
>  
>  	pkt_data = data;
>  	if (!bytes_processed) {
> -		pkt_data += PKT_HDR_SIZE / sizeof(*pkt_data);
> -		len -= PKT_HDR_SIZE;
> +		if (len < pkt_hdr_size + sizeof(*pkt_data))
> +			return false;
> +		pkt_data += pkt_hdr_size / sizeof(*pkt_data);
> +		len -= pkt_hdr_size;
>  	} else {
> -		bytes_processed -= PKT_HDR_SIZE;
> +		bytes_processed -= pkt_hdr_size;
>  	}
> +	if (len < sizeof(*pkt_data))
> +		return false;

[Severity: Medium]
The commit message says these guards reject short fragments "instead of
reading past the end of the buffer". Can the error path still read past
the fragment through pkt_dump()?

In UDP mode pkt_hdr_size is 44, so this guard accepts a 48 byte first
fragment. If pkt_nb or seqnum then mismatches, is_frag_valid() reaches:

    error:
        pkt_dump(data, len, !bytes_processed);

pkt_dump() then does:

    data = pkt + pkt_hdr_size;
    ...
    pkt_print_data(data, PKT_DUMP_NB_TO_PRINT);

That reads 16 words (64 bytes) starting at offset 44, so it reaches byte
108 of a 48 byte fragment.

is_pkt_valid() also calls pkt_dump() with the first fragment's address and
the full packet length:

    pkt_dump(xsk_umem__get_data(buffer, addr), len, true);

So the tail dump at data + len / sizeof(u32) - PKT_DUMP_NB_TO_PRINT always
ends pkt_hdr_size bytes past the packet (44 now, 16 before). For a
multi-fragment packet it ends well past the first frame.

If the first fragment is in one of the last UMEM frames, could this run past
the mmap and crash the RX endpoint with SIGSEGV instead of reporting a
failure? With --hw, the received lengths come from the physical link and
the driver under test.

>  
>  	expected_seqnum = bytes_processed / sizeof(*pkt_data);
>  	seqnum = ntohl(*pkt_data) & 0xffff;

[ ... ]

> @@ -2230,6 +2346,10 @@ int testapp_xdp_shared_umem(struct test_spec *test)
>  	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
>  	int ret;
>  
> +	/* The XDP program picks the socket from the synthetic destination MAC. */
> +	if (hw_test)
> +		return TEST_SKIP;
> +

[Severity: Low]
The runner added later in the series doesn't hit this, but several cases
skip based on test->mode, and the two --hw endpoints run in different
modes. STAT_RX_DROPPED and TX_QUEUE_CONSUMER skip in ZC mode. For example,
testapp_stats_rx_dropped() has:

    if (test->mode == TEST_MODE_ZC) {
        ksft_print_msg("Can not run RX_DROPPED test for ZC mode\n");
        return TEST_SKIP;

ADJUST_TAIL_GROW and ADJUST_TAIL_GROW_MB skip in SKB mode instead. So one
endpoint could skip while its peer runs the case.

Later in the series, test_xsk_case_defs.h gives these cases hardware
direction 0, and xsk.py's _case_result() treats a skip from either endpoint
as a case skip. Only manual runs are affected. Would it make sense to
handle these cases with hw_test, as done for XDP_SHARED_UMEM here, so both
endpoints agree?

>  	test->total_steps = 1;
>  	test->nb_sockets = 2;

[ ... ]

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index e66625810a9d8..8b94dc3709ea8 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c

[ ... ]

> @@ -220,6 +260,12 @@ static void bind_iface(struct ifobject *ifobj, const char *ifname, char **argv)
>  		ksft_print_msg("Error: cannot initialize interface %s\n", ifobj->ifname);
>  		ksft_exit_fail();
>  	}
> +	if (xsk_get_mtu(ifobj->ifname, &ifobj->mtu)) {
> +		ksft_print_msg("Error: cannot read MTU of interface %s\n", ifobj->ifname);
> +		ksft_exit_fail();
> +	}
> +	ifobj->dev_mtu = ifobj->mtu;
> +	ifobj->orig_mtu = ifobj->mtu;
>  }

[Severity: Low]
Does reading the device MTU into ifobj->mtu here change the zero-copy probe
for runs without --hw?

bind_iface() runs before detect_mode_caps(). ifobj_zc_avail() binds through
xsk_configure_socket(), which does:

    if (ifobject->mtu > MAX_ETH_PKT_SIZE)
        cfg.bind_flags |= XDP_USE_SG;

Before this patch, ifobj->mtu was 0 when the probe ran, so the probe was
always a single-buffer bind. xp_assign_dev() rejects an XDP_USE_SG bind
with -EOPNOTSUPP when the driver's xdp_zc_max_segs is 1.

Take such a driver with a device MTU between 1519 and roughly 3814. Would
XSK_CAP_ZC now stay unset, so a manual ZC run without --hw skips where it
used to run? Larger MTUs already failed the probe before this patch.

[ ... ]

> @@ -363,7 +455,11 @@ static bool is_xdp_supported(int ifindex)
>  
>  static u32 detect_mode_caps(struct ifobject *ifobj)
>  {
> -	if (is_xdp_supported(ifobj->ifindex)) {
> +	if (opt_hw && opt_mode == TEST_MODE_ZC &&
> +	    ifobj_has_cap(ifobj, XSK_CAP_ZC_ADVERTISED)) {
> +		/* Trust the advertised flag; an XDP_ZEROCOPY bind never falls back to copy. */
> +		ifobj_set_cap(ifobj, XSK_CAP_DRV | XSK_CAP_ZC);
> +	} else if (!opt_hw && is_xdp_supported(ifobj->ifindex)) {

[Severity: Low]
With --hw, is XSK_CAP_DRV ever set other than in the advertised ZC case?

The is_xdp_supported() probe now only runs when !opt_hw. As a result,
"xskxceiver --hw -m drv" always ends up in main() at:

    ksft_print_msg("XDP_DRV mode not supported.\n");

This happens even on NICs with native XDP. xsk.py only uses zc and skb, so
only manual runs are affected. However, the skip reason is misleading, and
the commit message only mentions the zero-copy detection change.

>  		ifobj_set_cap(ifobj, XSK_CAP_DRV);
>  		if (ifobj_zc_avail(ifobj))
>  			ifobj_set_cap(ifobj, XSK_CAP_ZC);

[ ... ]

> @@ -501,27 +619,32 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* Line-buffer stdout so verdicts reach a capturing launcher live. */
> -	ksft_print_header();
> -	ksft_set_plan(1);
> +	if (!opt_hw) {
> +		ksft_print_header();
> +		ksft_set_plan(1);
> +	}

[ ... ]

> -	if (ret == TEST_SKIP && ksft_test_num()) {
> +	if (ret == TEST_SKIP && !opt_hw && ksft_test_num()) {
>  		ksft_print_cnts();
>  		return KSFT_SKIP;
>  	}
>  	if (ret == TEST_SKIP)
> -		ksft_exit_skip("mode not supported\n");
> +		ksft_exit_skip("mode or test not supported\n");
>  	if (ret)
>  		ksft_exit_fail();
>  	else

[Severity: Low]
The commit message says "a hardware endpoint prints no KTAP output of its
own and reports through its exit code". Is that accurate?

With --hw, ksft_print_header() and ksft_set_plan() are skipped. A skip
still goes through ksft_exit_skip(), which prints the KTAP plan line when
no plan was set:

    1..0 # SKIP mode or test not supported

ksft_exit_pass() and ksft_exit_fail() call ksft_print_cnts(), which prints
the "# Totals: ..." line.

xsk.py prefixes each forwarded line with "#" through ksft_pr(), so the
runner's TAP stream is unaffected. Still, the commit message doesn't match
what the code does.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008114909.734364-1-maciej.fijalkowski%40intel.com
