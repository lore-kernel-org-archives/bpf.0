Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58A289367
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516760; cv=none; b=qUgJt4RQpi4Q1xVzPEdRFhohraoQ/DFPiKsRykVvS1FN1KH8gDjknSBY2w9J3cFLo+/YK56gEWdoiF5i5F9xBccifhvoMCbA3/Wtfz5BpOMQeLvR6+/5j/lnNMNPywqJYhpoY1BhPr08IBeHdFORu6/2GTPmTzOQ6k/Nw/XBnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516760; c=relaxed/simple;
	bh=9ucH+ku4WCfHzAekKUX8jTMbLAXN9wYf2y4NAxewHrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cofhHWw0d+b8o5bH/O0RnPIvWCCKiFNJSIwpQOgneBh3DSO6Tts4gibe1Q4mn4lNbT4KZcEens1h2r8dUtmcfjzpikyvN1ZtgToyFNj3fGVigbZGw0hT0AnhlU+WvSmBjfgpKkRXqamGGu4CLD11A3y3Raz6UgiOW9LT0347MpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEMEF8MT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEMEF8MT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7691F000E9;
	Wed,  8 Jul 2026 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783516759;
	bh=XMp8o4UVPLJImlI46fzNFZBEgHclKqVFAyZ6/JeOABA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEMEF8MTyRxTa2O0zAor6e0o3WgCmqlTBg5eJosQhZP56upAZZuH3/9A+RqMFDzrw
	 0Gr3QutZeBRTnPKAo7+RfJejnq3UAI7d0D0vcFRwGTYR2v0Osuq/fGYzHDoqhhi441
	 WbLlYF2JzdNT7Ph+xLLEMKqeMuV7Chn7pqGVWJFfAVjWoaCbbm/jsOYw8KKF7sYWo0
	 fogY3i4YFBYmrvhBd4QDBihdPdOTuyx42PAH8SGcf5hAWZxk1HFfhsqjhgB4zV9LlG
	 7zRvR0IkPZswsRgjh90XKsu5VoIyI/oI70brkoklWR/Xjufix4/fwyKGfd6u5NtjDm
	 XlIAfKet6oPeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/1] selftests: drv-net: add XDP RX checksum
 metadata tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <6c7a059057d309e999b706b5b547be9c620ce544.1783514455.git.deliran@verdict.gg>
References: <akZ7QPfn83OUx5Vm@lore-desk>
 <cover.1783514455.git.deliran@verdict.gg>
 <6c7a059057d309e999b706b5b547be9c620ce544.1783514455.git.deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 13:19:18 +0000
Message-Id: <20260708131919.0C7691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The BPF program overwrites checksum metadata on every packet, wh=
ich may cause TCP tests to spuriously fail if trailing control packets lack=
 checksum offload.
- [Low] Multi-line comments do not follow the mandatory BPF subsystem comme=
nt style (opening `/*` must be on its own line).
--

--- Patch [1]: [PATCH bpf-next 1/1] selftests: drv-net: add XDP RX checksum=
 metadata tests ---
commit d0f16a1bf595df9c0de880826075e44c316407e0
Author: Vladimir Vdovin <deliran@verdict.gg>

selftests: drv-net: add XDP RX checksum metadata tests

Extend the xdp_metadata driver tests with coverage for
bpf_xdp_metadata_rx_checksum(). Adds a BPF program to read and store
the verdict, and Python tests to validate both valid and invalid RX
checksums.

> diff --git a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py b/too=
ls/testing/selftests/drivers/net/hw/xdp_metadata.py
> index 33a1985356d90..687c43a1797a4 100644
> --- a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
> +++ b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
[ ... ]
> @@ -130,6 +146,91 @@ def test_xdp_rss_hash(cfg, proto):
>              f"RSS hash type should include L4 for {proto.upper()} traffi=
c")
> =20
> =20
> +def _require_rx_csum_meta(cfg):
[ ... ]
> +@ksft_variants([
> +    KsftNamedVariant("tcp", "tcp"),
> +    KsftNamedVariant("udp", "udp"),
> +])
> +def test_xdp_rx_csum_valid(cfg, proto):
[ ... ]
> +    csum =3D bpf_map_dump(csum_map_id)
> +
> +    pkt_cnt =3D csum.get(_CSUM_KEY_PKT_CNT, 0)
> +    err_cnt =3D csum.get(_CSUM_KEY_ERR_CNT, 0)
> +    ip_summed =3D csum.get(_CSUM_KEY_IP_SUMMED, 0)
> +
> +    ksft_ge(pkt_cnt, 1, comment=3D"should have received at least one pac=
ket")
> +    ksft_eq(err_cnt, 0, comment=3Df"RX checksum error count: {err_cnt}")
> +
> +    ksft_pr(f"  ip_summed: {ip_summed:#x} cksum: "
> +            f"{csum.get(_CSUM_KEY_CKSUM, 0):#010x} "
> +            f"level: {csum.get(_CSUM_KEY_LEVEL, 0)}")
> +    ksft_ne(ip_summed & (XDP_CHECKSUM_UNNECESSARY | XDP_CHECKSUM_COMPLET=
E), 0,
> +            "device should report a checksum verdict for a valid packet")

[Severity: Medium]
Will this test sporadically fail for TCP traffic? Since multiple packets mi=
ght
be exchanged, the final state of ip_summed could be from a trailing control
packet (like FIN or RST) that lacks checksum offload, leading to a failure
here.

> +
> +
> +def test_xdp_rx_csum_invalid(cfg):
[ ... ]
> diff --git a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c b/tools/t=
esting/selftests/net/lib/xdp_metadata.bpf.c
> index f71f59215239f..70decae0a6637 100644
> --- a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
> +++ b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
[ ... ]
> @@ -40,6 +41,24 @@ struct {
>  	__uint(max_entries, 4);
>  } map_rss SEC(".maps");
> =20
> +/* RX checksum results: key 0 =3D ip_summed bitmask, key 1 =3D hw cksum =
value,
> + * key 2 =3D cksum level, key 3 =3D packet count, key 4 =3D error count.
> + */

[Severity: Low]
This isn't a bug, but the BPF subsystem prefers multi-line comments to have
the opening /* on its own line. Could this be adjusted?

> +enum {
> +	CSUM_KEY_IP_SUMMED =3D 0,
[ ... ]
> @@ -55,8 +74,20 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_L4_ICMP =3D 1U << 8,
>  };
> =20
> +/* Mirror of enum xdp_checksum from include/net/xdp.h.
> + * Needed because the enum is not part of UAPI headers.
> + */

[Severity: Low]
This isn't a bug, but could the opening /* be placed on its own line
to match BPF comment style?

> +enum xdp_checksum {
> +	XDP_CHECKSUM_NONE =3D 1U << 0,
[ ... ]
> @@ -78,41 +109,39 @@ static __always_inline __u16 get_dest_port(void *l4,=
 void *data_end,
>  	return 0;
>  }
> =20
> -SEC("xdp")
> -int xdp_rss_hash(struct xdp_md *ctx)
> +/* Return true when the packet matches the L4 protocol and destination
> + * port configured in map_xdp_setup (zero/unset filters match anything).
> + */

[Severity: Low]
This isn't a bug, but could the opening /* be placed on its own line
to match BPF comment style?

> +static __always_inline bool xdp_match_setup(struct xdp_md *ctx)
>  {
[ ... ]
> @@ -160,4 +204,46 @@ int xdp_rss_hash(struct xdp_md *ctx)
>  	return XDP_PASS;
>  }
> =20
> +SEC("xdp")
> +int xdp_rx_csum(struct xdp_md *ctx)
> +{
[ ... ]
> +	ret =3D bpf_xdp_metadata_rx_checksum(ctx, &ip_summed, &cksum,
> +					   &cksum_level);
> +	if (ret < 0) {
> +		key =3D CSUM_KEY_ERR_CNT;
> +		cnt =3D bpf_map_lookup_elem(&map_csum, &key);
> +		if (cnt)
> +			__sync_fetch_and_add(cnt, 1);
> +		return XDP_PASS;
> +	}
> +
> +	key =3D CSUM_KEY_IP_SUMMED;
> +	val =3D (__u32)ip_summed;
> +	bpf_map_update_elem(&map_csum, &key, &val, BPF_ANY);

[Severity: Medium]
Does this update overwrite the checksum metadata on every packet? If so, the
map will only contain the verdict of the last processed packet, which could
be an empty control packet without checksum offload, leading to incorrect t=
est
failures. Can we accumulate the results or only update if the packet carrie=
s a
payload?

> +
> +	key =3D CSUM_KEY_CKSUM;
> +	bpf_map_update_elem(&map_csum, &key, &cksum, BPF_ANY);
> +
> +	key =3D CSUM_KEY_LEVEL;
> +	val =3D cksum_level;
> +	bpf_map_update_elem(&map_csum, &key, &val, BPF_ANY);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6c7a059057d309e999b=
706b5b547be9c620ce544.1783514455.git.deliran@verdict.gg?part=3D1
