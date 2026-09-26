Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23930274D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790458407; cv=none; b=D2WjCi+/Vb1dV7jBbSPjFONgxOAw/nZchz0acrIrZmYfdgnYoKzQ9FX2HsF/KdiIGV3r2dV58GNr+gbmz5cItF4auY0JzZMlxcjd6uPHZEY13f6QUQTzWNl8Qldla6cDdeKjQxFwZ8vx3kPgwCLLZ2zhyOr6O/VbeHu6pmfmp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790458407; c=relaxed/simple;
	bh=RoqpOukFLX7pbHeqr2eBKlkjLEHDmV5WCHZILmjwhJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TykupaNX2770A3Y4IesTJJ2yszn23oarn1if64UsBdRApnyg5ftzBe42Gui0Uod2dBtMNwF68iTQ6koMIM4XOmXTNdXN6231hBHXT+Hx+1Qjt+bIkjNVQONCytf2SyOnnKIlLZ6IBMmqIh/enfUJk8uNImZ3cYU+VzRn8BoRFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxQuij6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxQuij6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03AD1F000FF;
	Sat, 26 Sep 2026 21:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790458405;
	bh=ncC3VnoKD9FVbli6nQhtR5FrqrnvSPAjZ3MBRMjizyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SxQuij6H1n0GDTwWyL3ARYhR4+8oAHWuAlWe5PjHcUwkacICAqU7+BOfVJ5mKc5Uw
	 MRGhi/lf7OT95Ybo67yiskeSgy0h7YgcvcZRBrAeSgE5+B99j9CCX9ICjkC8qTiQCY
	 odf8LLKCvvLblz28zRNQD0HLe2ICkW5kNE9+JgyN3u0wTM7aslJL+y1+gDFY9sW8vi
	 NUVmw+8y3TSr9n9QhoapYSer9PPC/Ynb/tM5G9Kw1Zj3XZJXpy+ukDBITBCvqPBCBL
	 9bkTMTPv1rViqcf6/dgjiRxXQ23jP7XJ0hNtjTEZNJvAoc6rh9W+KByAakKtX21eT/
	 mMrlvBHpXmMPA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next 3/3] selftests/bpf: Add a test for the PPPoE
 encap/decap adjust_room flags
Reply-To: sashiko-reviews@lists.linux.dev
To: ThisSeanZhang <thisseanzhang@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926210757.2152159-4-thisseanzhang@gmail.com>
References: <20260926210757.2152159-1-thisseanzhang@gmail.com>
 <20260926210757.2152159-4-thisseanzhang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 21:33:25 +0000
Message-Id: <20260926213325.B03AD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: incorrect multi-line comment style
--

commit fe908855753e03da84cf9e3447581e4350dd47f1
Author: ThisSeanZhang <thisseanzhang@gmail.com>

selftests/bpf: Add a test for the PPPoE encap/decap adjust_room flags

This commit adds a tc selftest that exercises the new PPPoE flags of
bpf_skb_adjust_room(). It verifies encapsulation and decapsulation behaviors
over IPv4 and IPv6, as well as multiple error conditions.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c b/tools/te=
sting/selftests/bpf/prog_tests/tc_pppoe.c
> new file mode 100644
> index 0000000000000..ee914e828d4db
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c

[ ... ]

> +static void test_encap_decap(struct tc_pppoe *skel, const char *subtest,
> +			     const __u8 *pkt, __u32 pkt_len, int ethertype,
> +			     __u8 ppp_proto)
> +{

[ ... ]

> +	/* Ethernet header, with the ethertype changed to PPPoE session. */
> +	ASSERT_EQ(encap_pkt[12], 0x88, "encap eth h_proto");
> +	ASSERT_EQ(encap_pkt[13], 0x64, "encap eth h_proto");
> +	/* PPPoE session header: ver/type/code, session id, length and
> +	 * PPP protocol.
> +	 */

[Severity: Low]
This isn't a bug, but the BPF subsystem prefers the opening /* of multi-line
comments to be on its own line.

> +	ASSERT_EQ(encap_pkt[14], 0x11, "encap pppoe ver/type");
> +	ASSERT_EQ(encap_pkt[15], 0x00, "encap pppoe code");

[ ... ]

> +	ASSERT_EQ(encap_pkt[20], 0x00, "encap ppp proto");
> +	ASSERT_EQ(encap_pkt[21], ppp_proto, "encap ppp proto");
> +	/* The original packet must be shifted unchanged behind the
> +	 * new header.
> +	 */

[Severity: Low]
Could the opening /* be placed on its own line to match the BPF multi-line
comment style?

> +	ASSERT_MEMEQ(encap_pkt + 14 + PPP_SES_HLEN, pkt + 14,
> +		     pkt_len - 14, "encap payload");

[ ... ]

> +void test_tc_pppoe(void)
> +{
> +	/* A PPPoE packet whose PPP protocol is neither IPv4 nor IPv6:
> +	 * IP control protocol (0x8021) in this case.
> +	 */

[Severity: Low]
Does this follow the modern kernel multi-line comment style expected in the
BPF subsystem?

> +	static const __u8 bad_ppp_pkt[] =3D {
> +		0x11, 0x22, 0x33, 0x44, 0x55, 0x66,

[ ... ]

> +		0x00, 0x00, 0x00, 0x00,
> +	};
> +	/* A PPPoE packet whose payload is too short to still contain a
> +	 * full IP header after decapsulation.
> +	 */

[Severity: Low]
It looks like the opening /* is not on its own line here either.

> +	static const __u8 truncated_pkt[] =3D {
> +		0x11, 0x22, 0x33, 0x44, 0x55, 0x66,

[ ... ]

> +	test_decap_reject_input(skel, truncated_pkt, sizeof(truncated_pkt),
> +				"decap-truncated");
> +	test_reject(skel, 6, fake_ppp_pkt, sizeof(fake_ppp_pkt),
> +		    "reject-decap-fake-ppp-proto");
> +
> +	/* Encapsulate a v4 packet once more to get a PPPoE packet as
> +	 * input for the "decap without the flag" rejection case.
> +	 */

[Severity: Low]
This is a minor style observation, but multi-line comments in BPF tests
should start with /* on a separate line.

> +	ASSERT_OK(run_prog(bpf_program__fd(skel->progs.tc_pppoe_encap),
> +			   ip4_pkt, sizeof(ip4_pkt), encap_pkt,

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/tc_pppoe.c b/tools/testing=
/selftests/bpf/progs/tc_pppoe.c
> new file mode 100644
> index 0000000000000..357e1b5706f7a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tc_pppoe.c

[ ... ]

> +/* skb->protocol as observed after the helper call. */
> +int encap_proto;
> +int decap_proto;
> +
> +/* Set when tc_pppoe_reject observes a call that should have been
> + * rejected by the helper.
> + */

[Severity: Low]
This isn't a functional issue, but BPF style guidelines recommend placing t=
he
opening /* of a multi-line comment on its own line.

> +int reject_unexpected;
> +
> +SEC("tc")
> +int tc_pppoe_encap(struct __sk_buff *skb)
> +{
> +	__u8 hdr[PPPOE_SES_HLEN_TEST] =3D {
> +		0x11, 0x00,			/* ver, type, code */
> +		0xde, 0xad,			/* session id */
> +		0x00, 0x00,			/* length, set below */
> +		0x00, 0x00,			/* PPP protocol, set below */
> +	};
> +	struct ethhdr eth;
> +	/* The PPPoE length field covers everything after the 6 byte
> +	 * session header: the PPP protocol field plus the payload.
> +	 */

[Severity: Low]
Could this comment be formatted to match the multi-line comment style used
in the BPF subsystem?

> +	__u16 plen =3D skb->len - ETH_HLEN_TEST + 2;
> +
> +	hdr[4] =3D (plen >> 8) & 0xff;

[ ... ]

> +SEC("tc")
> +int tc_pppoe_decap(struct __sk_buff *skb)
> +{
> +	struct ethhdr eth;

[ ... ]

> +	decap_proto =3D skb->protocol;
> +
> +	/* Restore the ethertype to the protocol of the decapsulated
> +	 * payload, as picked by the kernel from the PPP protocol field.
> +	 */

[Severity: Low]
Does this multi-line comment align with the BPF coding style?

> +	eth.h_proto =3D (__be16)skb->protocol;
> +	if (bpf_skb_store_bytes(skb, 0, &eth, sizeof(eth), 0))
> +		return TC_ACT_SHOT_TEST;
> +
> +	return TC_ACT_OK_TEST;
> +}
> +
> +/* Every bpf_skb_adjust_room() call below must be rejected by the
> + * helper; tc_pppoe_reject reports (and fails the test) if one of
> + * them unexpectedly succeeds.
> + */

[Severity: Low]
This is a minor style observation, but the opening /* here should ideally be
on its own line.

> +SEC("tc")
> +int tc_pppoe_reject(struct __sk_buff *skb)
> +{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926210757.2152=
159-1-thisseanzhang@gmail.com?part=3D3
