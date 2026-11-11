Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371791;
	b=yMSarFKKnN6GxZPxHUqKWbHZPOv9SsUcRo4DCZudkaCFlYNvaEyntWDs3G7EfmfhtSp2
	 +HEjQVaU1I6QocFyPk2Qo8/MZamDKUJAux5WGaQ/81QDZMj2ek4WoHkoOrHM/kZeT+6E2
	 vZOGsH+NftotT9TFdfCPfYSmgSql8grmmTrvHHBwyBsdhxqhTHOhyxnWvvh5QC9cBBooH
	 NaLtrjlltXsom3Y9s81SKBJb11Ite3ZkvY7jJ7W8L+Yp1P+64RkcSRNpyNR5EAyoERQ/L
	 NzZvLSTxJo1TEAWeJ585YNu1XSbU9ky0bhd4nfd+zJ7cpRB6e3iTDtLVs5f/T5XRssw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nQIsmcJjH2fywb189dLaEmD4dfcBeVxKBhQKAxACyMA=;
	b=qvjcRPI9+fVTZRuDBdPspjhWGVvZtxzOSXUPvwpkJvOzQB9lYa22fxqQ2DZ9K0sM2IJp
	 SwPEa6zN0d5yCrt98wu4D6p76M4tMFRKbjvwIBHxCIfs6D13h5LSdHV5VfG7MycFWkQt/
	 63fU6Wz8d+3Debl+l0vne+V1YmCGG93VgmhI4BoHz4lcnZIUitKDRXj1ReqonRZaTIobj
	 IxSZ/VFgP/eRniOFw5WiDkYR5O0BL2qp8JImY18yTasmZE4htJSoWhpub7UtW3OCN9f+z
	 e1TIm//OHQ57sdkAtbvvHIRLVTj84yuLjpf9gACkVS9qj44L427Rs5xGNb22OPzL/kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnSy5IEE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ACB606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnSy5IEE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1471F0089F;
	Wed, 11 Nov 2026 04:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371791;
	bh=nQIsmcJjH2fywb189dLaEmD4dfcBeVxKBhQKAxACyMA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XnSy5IEE7ljIj/bRs4Oif3Ks9fNuZr8NUyrwHLrNopPN5fs/jbTcGRP/Q0HU80vy9
	 hKCkQJ0Fq40EJ5BhO6YfOQD70SI0cGqT5mNFD0Mj95HRnV2UfZklYEZuoMURk2ovuS
	 SWrpyYGHcDegqlct0IndL80M36bc45bbjq5LohCyYdXsluvaZ7PNluRuuW1jZGzYLI
	 Nj6wskHiQBgIajN/u6+PDW9koi2jdNsJhP20y2UuNedyCA+RPO69wnbwv7YjkuBTKC
	 a/89oziGq1TYRkLaW6Yv8Mfx+0FpEnR/jsTuTos++BXTgKckVe4P28jFWokeJJrrYF
	 DcMU50EwOwLHw==
Message-ID: <sashiko-outbox-208301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next v3 3/3] selftests/bpf: Add a test for the PPPoE
 encap/decap kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: ThisSeanZhang <thisseanzhang@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261111032141.525444-4-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com>
 <20261111032141.525444-4-thisseanzhang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:36:30 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] selftests/bpf: single-word handle used in Signed-off-by trailer
- [Low] selftests/bpf: missing subtest isolation for tc_pppoe_fail in
  test_tc_pppoe()
- [Low] selftests/bpf: uninitialized reads on run_prog() error in
  test_encap_decap()
--

commit 0a18ebb6cc8079a048ec95f72882a33d91363974
Author: ThisSeanZhang <thisseanzhang@gmail.com>

> selftests/bpf: Add a test for the PPPoE encap/decap kfuncs
>
> Add a tc test that exercises the bpf_skb_pppoe_encap() and
> bpf_skb_pppoe_decap() kfuncs.
>
> The encap program is run over plain Ethernet/IPv4 and Ethernet/IPv6
> packets. The test checks that the kernel writes a correct PPPoE
> session header between the Ethernet and network headers (version,
> type, code, session id, length and PPP protocol), that skb->protocol
> becomes ETH_P_PPP_SES, and that the payload is preserved. It then
> runs the decap program and checks that the original packet and
> protocol metadata are restored.
>
> The rejection paths are driven by the packet input: encapsulation of
> a non-IP packet (ARP), decapsulation of a packet whose protocol is
> not ETH_P_PPP_SES (plain IPv4, and an IPv4 packet whose bytes at the
> PPP protocol offset decode as PPP_IP), decapsulation of a PPPoE
> packet with an unsupported PPP protocol (IPCP), and decapsulation of
> a packet too short to still hold an IP header.
>
> A separate program that holds a packet pointer across a call to
> bpf_skb_pppoe_encap() must fail verification, covering the
> KF_CHANGES_PKT invalidation from the first patch.
>
> Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>

[Severity: High]
The Signed-off-by trailer, commit author, and file copyright headers use
the single-word handle "ThisSeanZhang".  Per
Documentation/process/submitting-patches.rst, the Developer's Certificate
of Origin requires a space-separated real full name.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c b/tools/te=
sting/selftests/bpf/prog_tests/tc_pppoe.c
> new file mode 100644
> index 0000000000000..5420d3bf321ac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
[ ... ]
> +static int run_prog(int prog_fd, const void *data_in, __u32 size_in,
> +		    void *data_out, __u32 size_out, __u32 *retval,
> +		    __u32 *size_out_actual)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		    .data_in =3D (void *)data_in,
> +		    .data_size_in =3D size_in,
> +		    .data_out =3D data_out,
> +		    .data_size_out =3D size_out,
> +	);
> +	int ret;
> +
> +	ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
> +	if (!ret && retval)
> +		*retval =3D opts.retval;
> +	if (!ret && size_out_actual)
> +		*size_out_actual =3D opts.data_size_out;
> +
> +	return ret;
> +}
> +
> +static void test_encap_decap(struct tc_pppoe *skel, const char *subtest,
> +			     const __u8 *pkt, __u32 pkt_len, int ethertype,
> +			     __u8 ppp_proto)
> +{
> +	__u8 encap_pkt[128];
> +	__u8 decap_pkt[128];
> +	__u32 retval, out_len;
> +	int ret;
> +
> +	if (!test__start_subtest(subtest))
> +		return;
> +
> +	skel->bss->encap_proto =3D 0;
> +	ret =3D run_prog(bpf_program__fd(skel->progs.tc_pppoe_encap),
> +		       pkt, pkt_len, encap_pkt, sizeof(encap_pkt),
> +		       &retval, &out_len);
> +	ASSERT_OK(ret, "encap test_run");
> +	ASSERT_OK(retval, "encap retval");
> +	ASSERT_EQ(out_len, pkt_len + PPPOE_SES_HLEN, "encap pkt len");

[Severity: Low]
Can test_encap_decap() read uninitialized stack memory if run_prog()
fails?

run_prog() only populates *retval and *size_out_actual when
bpf_prog_test_run_opts() returns 0, and ASSERT_OK(ret, ...) does not
return on failure.  If either run_prog() call fails, execution continues
to evaluate assertions on uninitialized retval, out_len, encap_pkt, and
decap_pkt (which can also trigger -Werror=3Dmaybe-uninitialized when
run_prog() is inlined).  Returning early when !ASSERT_OK(ret, ...) avoids
this.

[ ... ]

> +	/*
> +	 * KF_CHANGES_PKT must make the verifier reject a program that
> +	 * keeps a packet pointer across the call.
> +	 */
> +	fail_skel =3D tc_pppoe_fail__open_and_load();
> +	if (!ASSERT_ERR_PTR(fail_skel, "stale packet pointer rejected"))
> +		tc_pppoe_fail__destroy(fail_skel);
> +}

[Severity: Low]
Does calling tc_pppoe_fail__open_and_load() without starting a subtest
attach its result to the preceding subtest?

In test_progs, the "decap-non-pppoe-fake-proto" subtest stays active until
the next test__start_subtest() call or until test_tc_pppoe() returns, and
filtered runs (such as test_progs -t tc_pppoe/encap-decap-v4) will still
execute tc_pppoe_fail__open_and_load() outside any subtest.  Using
RUN_TESTS(tc_pppoe_fail) with __failure and __msg() annotations from
bpf_misc.h on tc_pppoe_stale_ptr(), or guarding this check with
test__start_subtest(), would isolate it properly and verify the expected
verifier error message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111032141.5254=
44-1-thisseanzhang@gmail.com?part=3D3
