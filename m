Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406374;
	b=k91wUcZ/ba0gCDKvx3Knozo89c9agrYFHkkkZomwEQTmfCgYHMmZfGHEr2g9ISffSfLg
	 goSW+/6m726cVyEUQL8zbo8ONBDroSKBD6yfl7HHvjs+1LInIR/nvNHms75SUY1/txSfI
	 evYeFaDEupEZQ4NU7pT/2pZYlJmbJuz24skl+MqSjBO3z/AVEhD1bzk11Gb6Z78If6iQD
	 MxfZ2MwYCr2Je6KaKKT3TTwpf22G/nR4EVqz67uycb21E1d9Q2G7HtnVdnvCJh+LzIZxp
	 7WtBIl8mwhXtAFUXnIXVsdMe4VOUHQm8blqGs1b4kJlqF2yvMBw2i5+nK/BpRzN/5ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406374;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TLNeYzMTFS5ZNlIeCfy/ozLmrHSL3J7TLfyS9DGwmQo=;
	b=5YEmTneEjtOsDpku3iy6b7CWWeiCTuCX6DHBipK/vz1WtLXrDHVwARLg1SmaKGgc5SjF
	 +cLCuf9FM40hHfO8xzbnsw2KWTHqhWl1TRUJmsnLLiTQvTTWhxG3Xc+N4/cCmSu+BOcp7
	 hxsVlicLaBZMLLfw/wGqZpxo4R/JTaiSyq8RTGCgODVjeErYH4KezZelJTuMD84LbTxU6
	 Pynyfsmr6X1YvTGqRSw4finz4EqPiv6Z3MpL4VOySB3kaSg8o9UewTOxNd8+oQi/tboTg
	 AH1dRcp17wOkGQ2l8qHHHZgbJwjIbWUfzgTVsKChHDv0BQljqXeFG7GbAhlb6nUhicA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzMe3U0u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866E606A320;
	Mon, 23 Nov 2026 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzMe3U0u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB9E1F000D2;
	Mon, 23 Nov 2026 03:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795406373;
	bh=TLNeYzMTFS5ZNlIeCfy/ozLmrHSL3J7TLfyS9DGwmQo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NzMe3U0uXuC6dlBq8ybVW7eKe0CC2vQIF2UEOcfkUizYMxfKYcKZTrzpwc5TurIAj
	 FLxY26mWzQp5qIDgUS35s7nqFfEfFEM0retZNPR5IkmEfZ7DWr5af/+qLIuEuhdCp0
	 fkbfrpkEMxH0tAwgqY5YC3lUQXIqCCRAuHgfS5D7tkUfemmWFf80U/AASUsRBYGtam
	 ypBO6rGzdxijszeJ0ocvRYfeD4fWyO1mhTUeYSC1kb8O8Ukqd4mXvIgmvAsp71Om3h
	 TQA8nmvxEUARHgyIMpT3PZhITPvC/CB+iU2spu6E6Wsw4Pfv5Kaknfhd1m+5SguY/6
	 sIyta505Y0toA==
Subject: Re: [PATCH net-next v2 11/11] selftests: net: tx_extra_headroom: test
 the veth attribute
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
Date: Mon, 23 Nov 2026 03:59:30 +0000
Message-ID: <179540637021.3135.10262265795396660128@kernel.org>
In-Reply-To: <20261119013830.36935-12-tianyi@cloudflare.com>
References: <20261119013830.36935-12-tianyi@cloudflare.com>
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

- [Low] In tools/testing/selftests/net/tx_extra_headroom.py,
  test_veth_info() never checks the value that…

--

selftests: net: tx_extra_headroom: test the veth attribute

This adds a test that uses YNL to create a veth pair with
VETH_INFO_TX_EXTRA_HEADROOM set to 64, and moves the peer to another
netns. It checks that both ends report 64 over netlink, and that the
sending end's tx_extra_headroom is 64, or 64 + 256 with XDP on the peer.
A second test checks that a value above 512 is rejected with ERANGE.

> diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
> index 122a1a1b5ca94..a4e4195179fab 100755
> --- a/tools/testing/selftests/net/tx_extra_headroom.py
> +++ b/tools/testing/selftests/net/tx_extra_headroom.py

[ ... ]

> @@ -353,6 +380,30 @@ def test_tag_max() -> None:
>      ksft_eq(bss["tx_extra_headroom"], TX_EXTRA_HEADROOM_MAX)
>
>
> +def test_veth_info() -> None:
> +    """Check that VETH_INFO_TX_EXTRA_HEADROOM adds to tx_extra_headroom."""
> +    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
> +        _setup_veth(peer_ns, tx_extra_headroom=64)
> +        ksft_eq(_veth_tx_extra_headroom("veth0"), 64)
> +        with NetNSEnter(str(peer_ns)):
> +            ksft_eq(_veth_tx_extra_headroom("veth1"), 64)
> +        map_id = _load_progs()
> +        _attach_tcx("veth0", "egress", "record")
> +        _send_udp4()
> +        ksft_eq(_read_bss(map_id)["tx_extra_headroom"], 64)

[Severity: Low]
Does this check cover the value that veth_newlink() sets on the device
when it is created?

The record program at tcx egress of veth0 reads
kskb->dev->tx_extra_headroom. Attaching it goes through
tcx_prog_attach(), and for egress that recomputes the value for veth0
and its peer:

kernel/bpf/tcx.c:tcx_prog_attach() {
    ...
		bpf_mprog_commit(entry);
		if (!ingress)
			netdev_update_tx_extra_headroom(dev);
    ...
}

The value is not recalculated anywhere between creation and this attach.
Moving veth1 to another netns, adding addresses, bringing the links up
and _load_progs() all leave it alone. So this ksft_eq() would still pass
if the creation-time call in veth_newlink() were removed or broken:

drivers/net/veth.c:veth_newlink() {
    ...
	netdev_update_tx_extra_headroom(dev);
    ...
}

The two _veth_tx_extra_headroom() checks only read
priv->tx_extra_headroom through veth_fill_info(), not
dev->tx_extra_headroom. The peer's dev->tx_extra_headroom is never
checked.

The use case in "veth: add VETH_INFO_TX_EXTRA_HEADROOM" is a CNI plugin
that sets the headroom at creation, with no tcx egress program on the
veth. That use case relies only on the creation-time path.

Only egress attach recalculates the value. Could a record program at
tcx ingress of veth1 be used to read the creation-time value? If not,
could the commit message mention this limitation?

> +        _attach_xdp(peer_ns)
> +        _send_udp4()
> +        ksft_eq(_read_bss(map_id)["tx_extra_headroom"],
> +                64 + XDP_PACKET_HEADROOM)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119013830.36935-1-tianyi%40cloudflare.com
