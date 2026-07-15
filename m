Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766033B4E87
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152733; cv=none; b=vFb//l4YoTM+J+ADA0nVaLM97y2UPp/iCn8m9vl9tNlbKiMi1NUCJBrCLAzjqweZgKMeHY9OOyMEVjsUE4r/It8cwZXwtAet+438C9iJo1rY9gPHIbwFzKwmu5I9qXkQ7puwrS6LckGLiM+DUorNH9eOUV3R9POhZhHLXltEz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152733; c=relaxed/simple;
	bh=Cm+y/SANMKdDPDobSVk7/gvf4tp1uQQSzfTS5eQL4yE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B/fxT1DRQf//q69sLrGcaXY4cFREiPDEsuJ3xWpsofXmlJmHeQwA3/CQeN+zIuqJC28IuJpXmjicj9bu67f6Vx2NOAeXA7l4ibNN6HY4RARylBld5Bsuhll+NCWYtd37Qr5f4K/a2QNg4wLyjya9KNuW/xnyvMuxpvgT/ft/PE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5Ju4QQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5Ju4QQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5992A1F000E9;
	Wed, 15 Jul 2026 21:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784152732;
	bh=YxjsnA3uGp0AQsISEpZZRjOCU8DRs5fwjfZR0quyFp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5Ju4QQfhuXFJ1UPVSnSz6bQe94Oye3RW7ICEH9TiXFntMSIFtSwc/UYtDNHg49ih
	 7Ts+aGsqVGNczFs7YXOSGq4KpDlC2T1NnYEhmYJa7QKapCKnnBTLt9JCGLFvfA360U
	 J4tF2zrWiwyRW28V69CjGwMVXIxX/uGGvxO15ZF5FinG76qDQaHWn9f6LBUJ77tWKu
	 9uNlKPvpWKqr4w3HN15pjPjY74QAFQipkWs8LELfRkAK75AAM79F2dtpGJGEv2QFcR
	 GLCqI2KgRk9lQvccwpEwyQJDvx6MUxeEKJcNk+9vbEZSkZ90NhK/8sr7fWJuA2UF52
	 mmtuGm/HOQWyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 8/8] selftests: net: add test for XDP_PASS
 skb checksum invalidation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:58:50 +0000
Message-Id: <20260715215851.5992A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `tc_check_csum` BPF program strictly requires IPv6 traffic, =
but the python test probe can send IPv4 traffic depending on the environmen=
t configuration, causing the test to falsely fail.
- [Medium] The test leaks a `tc filter` and its associated BPF program if t=
he interface already had a `clsact` qdisc.
--

--- Patch [8]: [PATCH bpf-next v5 8/8] selftests: net: add test for XDP_PAS=
S skb checksum invalidation ---
commit 2b96bd0af0eb846efe81e2f0246ecebcc855acd6
Author: Lorenzo Bianconi <lorenzo@kernel.org>

selftests: net: add test for XDP_PASS skb checksum invalidation

This commit adds a selftest to verify that a device running in XDP mode
correctly invalidates the hardware RX checksum when an attached XDP program
returns XDP_PASS. It checks this by attaching an XDP program and a TC
ingress program to inspect the resulting skb via the bpf_skb_rx_checksum()
kfunc.

> diff --git a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py b/too=
ls/testing/selftests/drivers/net/hw/xdp_metadata.py
> index 33a1985356d90..8ccd34b776b4d 100755
> --- a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
> +++ b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
[ ... ]
> @@ -130,6 +131,57 @@ def test_xdp_rss_hash(cfg, proto):
>              f"RSS hash type should include L4 for {proto.upper()} traffi=
c")
> =20
> =20
> +def test_xdp_pass_rx_csum(cfg):
> +    """Test xdp_pass sets CHECKSUM_NONE on the resulting skb.
> +
> +    Attaches an XDP program that returns XDP_PASS and a TC ingress
> +    program that checks skb->ip_summed via bpf_skb_rx_checksum().
> +    Verifies the value is CHECKSUM_NONE.
> +    """
> +
> +    bpf_obj =3D cfg.net_lib_dir / "skb_metadata_csum.bpf.o"
> +    xdp_obj =3D cfg.net_lib_dir / "xdp_dummy.bpf.o"
> +
> +    # GRO may overwrite skb->ip_summed after the driver sets it,
> +    # so disable it to preserve the checksum set by the driver.
> +    ethtool(f"-K {cfg.ifname} gro off")
> +    defer(ethtool, f"-K {cfg.ifname} gro on")
> +    ip(f"link set dev {cfg.ifname} xdp obj {xdp_obj} sec xdp")
> +    defer(ip, f"link set dev {cfg.ifname} xdp off")
> +
> +    qdiscs =3D json.loads(cmd(f"tc -j qdisc show dev {cfg.ifname}").stdo=
ut)
> +    if not any(q['kind'] =3D=3D 'clsact' for q in qdiscs):
> +        cmd(f"tc qdisc add dev {cfg.ifname} clsact")
> +        defer(cmd, f"tc qdisc del dev {cfg.ifname} clsact")
> +    cmd(f"tc filter add dev {cfg.ifname} ingress bpf da obj {bpf_obj} se=
c tc")

[Severity: Medium]
Does this leak the tc filter and BPF program if the interface already had a
clsact qdisc?

Since the filter deletion is not explicitly deferred here, it appears the
filter will remain active if the test bypassed the qdisc creation and
deletion. This could cause subsequent test runs to falsely fail if they
discover and query the leaked BPF program instead of the newly attached one.

> +
> +    progs =3D bpftool("prog list", json=3DTrue)
> +    tc_prog_id =3D None
> +    for p in progs:
> +        if p.get("name") =3D=3D "tc_check_csum":
> +            tc_prog_id =3D p["id"]
> +            break
> +
> +    if tc_prog_id is None:
> +        raise KsftSkipEx("Could not find tc_check_csum BPF program")
> +
> +    maps =3D bpf_prog_map_ids(tc_prog_id)
> +    csum_map_id =3D maps.get("map_csum_result")
> +    if csum_map_id is None:
> +        raise KsftSkipEx("Could not find map_csum_result map")
> +
> +    for _ in range(10):
> +        _send_probe(cfg, 12345, proto=3D"udp")

[Severity: Medium]
Will this cause spurious test failures if the test environment defaults
to IPv4?

The _send_probe() method will send IPv4 traffic if the environment's
cfg.addr_ipver defaults to 4. However, the BPF program tc_check_csum
explicitly ignores non-IPv6 traffic. If IPv4 packets are sent, the counters
will remain at zero and the test will fail.

> +
> +    result =3D bpf_map_dump(csum_map_id)
[ ... ]
> diff --git a/tools/testing/selftests/net/lib/skb_metadata_csum.bpf.c b/to=
ols/testing/selftests/net/lib/skb_metadata_csum.bpf.c
> new file mode 100644
> index 0000000000000..6a953c4acfe78
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/skb_metadata_csum.bpf.c
[ ... ]
> @@ -0,0 +1,73 @@
[ ... ]
> +SEC("tc")
> +int tc_check_csum(struct __sk_buff *skb)
> +{
> +	void *data_end =3D (void *)(long)skb->data_end;
> +	void *data =3D (void *)(long)skb->data;
> +	__u32 ip_summed, csum_meta;
> +	struct ethhdr *eth =3D data;
> +	struct ipv6hdr *ip6;
> +	struct udphdr *udp;
> +
> +	if ((void *)(eth + 1) > data_end)
> +		return TC_ACT_OK;
> +
> +	if (eth->h_proto !=3D bpf_htons(ETH_P_IPV6))
> +		return TC_ACT_OK;

[Severity: Medium]
Can this strict IPv6 check cause a mismatch with the python script?

As noted above, the python script calling _send_probe() might send IPv4 UDP
packets depending on the environment configuration, which would be silently
dropped here, bypassing the counter updates entirely.

> +
> +	ip6 =3D (void *)(eth + 1);
> +	if ((void *)(ip6 + 1) > data_end)
> +		return TC_ACT_OK;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-bpf-xdp-me=
ta-rxcksum-v5-0-623d5c0d0ab7@kernel.org?part=3D8
