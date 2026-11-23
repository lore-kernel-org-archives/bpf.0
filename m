Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406361;
	b=1NtLbOtOtDkA0Y2jtjBlb9S1N6YAYyut9ZsN0w5VpRWH6AulNqZL89ysq8yiAhyX5CnG
	 Dz09FOCJE16IqvXlp3aW08kvRvWmF0XCs+zXFYHz5HL7x1CutMiSO9eV7nP+zDlrRJjqK
	 EFfXC1rHSyWw8x4kCR0nEJSZ4/w32jZNhqRjPLe4Ez+Trn+EEM9OgpiT/f0hgbBlJSldH
	 X0sBRrlWiYmwKHeYXhYdC+iNVSYFWBoc3J+9dOdwmjlRTmzLzR773TqrB+iwuOzbpFN3I
	 fxy2xi43dGYgoz8cSGjyxRQmsjXF+Ru1QDJXlHOgCkpnvM5bvcQbgytRdoLAItrB/Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406361;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fOP8nRp1gVognLhoyXN7uljuF7XtV6U+cOJMjKtUatg=;
	b=AsZIREZaHGd6eSan9kbrqUj9gaxCTDQ5twX7ZoWN+MbEbyUctNzdS1Dj3smZns6UCqSn
	 UhvLXxGvaMH46d1R3TSUgAWACzNpGMMFqhmJDe5Kn0lPIyBKJRf6/jQw5ea0rGR/V+lk8
	 PJQJbmJpU7nH7VFp1KRdZyR4T++S+OFc2nm7x5/8ZqmZJVky1MmiVzxrleXhoxWp55kfo
	 iGblIQqIamlUv4PuiccFS6i/OrfkVD+XorI0tezIvERlBo1df4YuHVoTUGCrEzbn9v7na
	 sAxel2rDsHY92MB0/oP9HvLZycNKnIdabeGF/CLdvWjE3QeHJ3jJTZmjic61e5KHGZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6xO8olv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E74606A31A;
	Mon, 23 Nov 2026 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6xO8olv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358D41F000C4;
	Mon, 23 Nov 2026 03:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795406361;
	bh=fOP8nRp1gVognLhoyXN7uljuF7XtV6U+cOJMjKtUatg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H6xO8olv7wO0Y7SZfipmqHPmX4GpSJODUsPhn0Fmv/AZLqcBj+54u7Ox7IaQ55/ra
	 92d+n+DYd7Q+bd7hsh3i7aqJmKK8FzQJMQAaCr99Pv52b7nENPm7ROjgrWOm1sGxFX
	 WH14cUpgWstVLLRRL3NPoxBKAui83tgcRhvsZ2TzzPQfevsQS/y/KvbkHyvFkUY8L8
	 ltauS/g164SQjv3qFSIdugY82QwOXXZLKaCqBXpgrlPdNzk/LdUBu8N92SXk+EsorM
	 yIy5NGlb+qqsH4I/+aUPndoErSYAcjeFnLEr6G0/AO70bTZIavEcbx50eRv8bkqXtD
	 IXvGluJaPEh6g==
Subject:
 Re: [PATCH net-next v2 05/11] selftests: net: add tx_extra_headroom test
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, horms@kernel.org, dkeogh@amazon.com,
 hawk@kernel.org, daniel@iogearbox.net, dwmw2@infradead.org,
 dtatulea@nvidia.com, noren@nvidia.com, alasdair@mcwilliam.dev,
 willemdebruijn.kernel@gmail.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, magnus.karlsson@intel.com, dsahern@kernel.org,
 idosch@nvidia.com, ast@kernel.org, john.fastabend@gmail.com,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, corbet@lwn.net,
 skhan@linuxfoundation.org, shuah@kernel.org, rdunlap@infradead.org,
 leitao@debian.org, ast@fiberby.net, danieller@nvidia.com, kuniyu@google.com,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
 nh-open-source@amazon.com, stephen@networkplumber.org, gustavoars@kernel.org,
 one-d-wide@protonmail.com, ameryhung@gmail.com, andrii@kernel.org,
 aroulin@nvidia.com, anilkaushikwireless@gmail.com, demosthenes.ra@gmail.com,
 eddyz87@gmail.com, emil@etsalapatis.com, hangbin.liu@linux.dev,
 ihor.solodrai@linux.dev, jiayuan.chen@linux.dev, jolsa@kernel.org,
 joe@dama.to, memxor@gmail.com, lirongqing@baidu.com, louis.scalbert@6wind.com,
 mkl@pengutronix.de, martin.lau@linux.dev, mkarsten@uwaterloo.ca,
 mattbobrowski@google.com, michael.bommarito@gmail.com, razor@blackwall.org,
 runyu.xiao@seu.edu.cn, song@kernel.org, linux@leemhuis.info,
 wang.zhan@smartx.com, yonghong.song@linux.dev, n0ps1edzz@gmail.com,
 tianyi.gao@linux.dev
Date: Mon, 23 Nov 2026 03:59:17 +0000
Message-ID: <179540635779.3135.2960766007017620920@kernel.org>
In-Reply-To: <20261119013830.36935-6-tianyi@cloudflare.com>
References: <20261119013830.36935-6-tianyi@cloudflare.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Two test cases assert tx_extra_headroom == XDP_PACKET_HEADROOM
  under native veth XDP, and neither checks whether the copy is actually…

--

selftests: net: add tx_extra_headroom test

This adds a Python selftest and a TC BPF program. They check that generic
XDP on a veth or netkit peer stops copying locally generated skbs once the
kernel sets tx_extra_headroom on the other end. The test also checks the
tx_extra_headroom value on attach and detach for native and generic XDP,
for XDP propagated through a bond, and for a bridge with a vxlan port.

> diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
> new file mode 100755
> index 0000000000000..4058d0e64fc5a
> --- /dev/null
> +++ b/tools/testing/selftests/net/tx_extra_headroom.py

[ ... ]

> +@ksft_variants([
> +    KsftNamedVariant("generic", "xdpgeneric"),
> +    KsftNamedVariant("native", "xdpdrv"),
> +])
> +def test_detach(mode) -> None:
> +    """Check that XDP on the veth peer sets tx_extra_headroom until detach."""
> +    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
> +        _setup_veth(peer_ns)
> +        map_id = _load_progs()
> +        _attach_tcx("veth0", "egress", "record")
> +        _attach_xdp(peer_ns, mode)
> +        _send_udp4()
> +        ksft_eq(_read_bss(map_id)["tx_extra_headroom"], XDP_PACKET_HEADROOM)

[Severity: Medium]
In the native variant, do the 256 reserved bytes actually prevent a copy?

With native XDP on veth1, the skb goes through veth_xmit() ->
veth_xdp_rcv_skb() -> veth_convert_skb_to_xdp_buff(). That function copies
whenever skb_head_is_locked() is true, whatever the headroom:

drivers/net/veth.c:veth_convert_skb_to_xdp_buff() {
    ...
	if (skb_shared(skb) || skb_head_is_locked(skb) ||
	    skb_is_nonlinear(skb) ||
	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
			goto drop;
    ...
}

include/linux/skbuff.h:
static inline bool skb_head_is_locked(const struct sk_buff *skb)
{
	return !skb->head_frag || skb_cloned(skb);
}

The UDP, raw, AF_PACKET and AF_XDP copy-mode senders all allocate through
__alloc_skb()/kmalloc_reserve(), and those paths leave head_frag at 0.

With xdpdrv on the peer, does each of these skbs then get the extra 256
bytes of headroom, a larger truesize and a bigger sk_wmem charge, and still
get copied by skb_pp_cow_data()?

Generic XDP is different. netif_receive_generic_xdp() checks only for
cloned, nonlinear and headroom, so test_peer_xdp checks a real benefit.

test_bond() has the same problem. There, native XDP on bond0 is propagated
to veth1 through netif_xdp_propagate(), and the test also asserts
tx_extra_headroom == XDP_PACKET_HEADROOM.

The prerequisite patch "net: set tx_extra_headroom of the peer on XDP
attach" says it removes the copy for native XDP on veth in
veth_convert_skb_to_xdp_buff(). However, __netdev_update_tx_extra_headroom()
sets the reservation whenever dev_xdp_prog_count(peer) is non-zero, and that
includes XDP_MODE_DRV:

net/core/dev.c:__netdev_update_tx_extra_headroom() {
    ...
	if (peer && dev_xdp_prog_count(peer) &&
	    needed_headroom < XDP_PACKET_HEADROOM)
		tx_extra_headroom = XDP_PACKET_HEADROOM - needed_headroom;
    ...
}

Should the native and bond cases expect the reservation at all? A
native-mode variant of test_peer_xdp would likely see pp_recycle == True,
which would expose this.

No later patch in the series changes veth_convert_skb_to_xdp_buff() or
limits the reservation to generic mode.

> +        ip(f"link set dev veth1 {mode} off", ns=peer_ns)
> +        _send_udp4()
> +        ksft_eq(_read_bss(map_id)["tx_extra_headroom"], 0)
> +
> +
> +def test_bond() -> None:
> +    """Check that XDP that a bond propagates to the veth peer counts."""

[ ... ]

> +        _attach_xdp(peer_ns, "xdpdrv", "bond0")
> +        _send_udp4()
> +        ksft_eq(_read_bss(map_id)["tx_extra_headroom"], XDP_PACKET_HEADROOM)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119013830.36935-1-tianyi%40cloudflare.com
