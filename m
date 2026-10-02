Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D347FB00
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932471; cv=none; b=HBxHA6GO8C+0HShII7G7bZDFqsR59SP1gOjE3FPA+PNGy3sH54B4huPECJ06EeTpThjxfMnKCrBrViwnyQgedS/iyXzi4Mhd9qjgxH3vubw8x4GGfVOWpfuH2nis3enq18/Qpf73Xhu0XfnGol7PelRQviEPHpuw4+quIl505GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932471; c=relaxed/simple;
	bh=uNaUvuTQVjakqIp0uy9hGywaIb/uvsdWwLf7E09uVW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OnRXqm8dKPU/bcJl883F4ufosWII32PjUoTMPqymvCYV5dAFdb+VZIx3w6LiH9n/+TcdJFXoLkx3VlCzPLAtqXXwpFgeseQANDoR74hZTl61tw7u45HkhuyHip/ssgn4HjkYVg0NDwR8pvHrdL6oGqdC9EqtrYUslGkN29XOsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNzubw1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNzubw1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A241F0089D;
	Fri,  2 Oct 2026 09:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932469;
	bh=ZokgSEOvXrl3R+nONGx1QC0kmrLEzDc/MSaVI5Zy0Bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fNzubw1d1bt3AAyal3Mg5GGF5LJL9dAUOfaI149yZvYC099bAzbPWcPuFVFLiNY/P
	 X/wFRgRn+q6PzURiJIVa7Laq2v+LhQ06fC0Lfdszv3Q1k5W4EO/kuvtaZ+JxzaXLUB
	 yvduiT83vana7j15oM6NqwfkYd4LqRxqopyEMAjLtW3xF35KssAeD9n7KK9SyFLXx8
	 5fIF0vglFqbVpu6dLl9i1BJQOvPqawx7uMeAR2pUKPYnEcYHAtrNG8uo8WGCqlWj0W
	 wt/AuldHHSftIQe5DpIpo4J4nTVlyGLcy9YraOpnxv0iMe3l5Ib/KK2A8kBQxzYJVA
	 DY8CMT6RKGttA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] selftests/bpf: add XDP test for per-flow
 LRU_HASH window updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002053837.3494918-1-anilkaushikwireless@gmail.com>
References: <20261002053837.3494918-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:29 +0000
Message-Id: <20261002091429.A4A241F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comments violate subsystem style
--

commit 3357ebe262845fd222dfb8c2602be7eaa9237aad
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

selftests/bpf: add XDP test for per-flow LRU_HASH window updates

This commit adds an XDP program and a test_progs case to verify per-flow key
isolation in a BPF_MAP_TYPE_LRU_HASH map. It stresses the verifier's bounds
checking of a value-internal array when indexed by a runtime value.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c b/to=
ols/testing/selftests/bpf/prog_tests/xdp_lru_window.c
> new file mode 100644
> index 0000000000000..5e353fb1425eb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c

[ ... ]

> +/* Like inject(), but sends frames of a chosen on-wire length (>=3D the
> + * TCP/IPv4 headers) so the recorded pkt_len differs from the default.
> + */
> +static int inject_len(int n, __u16 dport, __u32 len)

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
style guidelines? The preferred style requires the opening /* to be on its
own line.

[ ... ]

> +static void test_one_and_wrap(void)
> +{

[ ... ]

> +	ASSERT_EQ(st.pkt_len[0], base_len, "len0");
> +
> +	/* Fill the whole window with base-length packets (slots 0..W-1),
> +	 * then send 5 more of a different length so they wrap into slots
> +	 * 0..4. Distinct lengths let the checks below catch a wrong, but
> +	 * still in-range, post-wrap index.
> +	 */
> +	if (inject(AGGREGATION_WINDOW - 1, DST_PORT))

[Severity: Low]
Are we missing a standalone /* line for this comment to match the BPF
subsystem multi-line comment formatting rules?

[ ... ]

> +static void test_trunc(void)
> +{

[ ... ]

> +	fill_pkt(&pkt, DST_PORT);
> +	reset_map();
> +
> +	/* Valid Ethernet/IP ethertype, but the IPv4 header is cut off:
> +	 * exercises the program's IPv4 length check.
> +	 */
> +	if (run_pkt(&pkt, ip_trunc, &retval))

[Severity: Low]
Could the opening /* be placed on its own line here as well, keeping the
comment block consistent with modern BPF style?

[ ... ]

> +	err =3D bpf_map_get_next_key(map_fd, NULL, &next);
> +	ASSERT_EQ(err, -ENOENT, "ip trunc no insert");
> +
> +	/* Full Ethernet + IPv4 header, but the TCP header is cut off:
> +	 * exercises the program's TCP length check.
> +	 */
> +	if (run_pkt(&pkt, tcp_trunc, &retval))

[Severity: Low]
Does this comment also need to be updated so the opening /* is on its own
line, adhering to the same formatting standard?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002053837.3494=
918-1-anilkaushikwireless@gmail.com?part=3D1
