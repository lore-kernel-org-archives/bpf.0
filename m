Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6363F9C0;
	Sat,  3 Oct 2026 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058301; cv=none; b=n5pC3mQiyrOIlf2dYzGpuGA6ceN7YCYftZN1g3of8LcC41/uCNJ/rJkQz7w4/JHtW0tPpZZrxfo+D9SZpn/KOFRHONd8n3LcWaCJYET2k/V/nL4wDx352iQePW8rswBUvPpgV9fDIRjW4CvHQmcoCg5JKzXa6tXHKxa1ALTYJas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058301; c=relaxed/simple;
	bh=5IeaE827rv+Q1p2AXZiCp+95Kthb1WG1NRQ8kweWmek=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RvbA7eDABOr/ZqO8g+qde+A8kgcQFInwLSQepJhHubodRu5KO445+Vjbkqzzh0KK/r8jtUm2r4emKkjrHUU0i9rgh1X1PkrtTA1+mx3aHxEXmGdLkZJWUIpUMnUMCsz5i7C2wJLPoSVXpqL2sc0mJQVv1Ye1qUb4VybJrUyzm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIvu/8ka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIvu/8ka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7ED1F0089B;
	Sat,  3 Oct 2026 20:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791058299;
	bh=HnaJKlN8LxH7o7jG2NsRu7r9mCT0MH+lvPgfyVxXx60=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CIvu/8kaYP9klD37V0LxaOqbWwIxdsfvyhVxjJP8wgSrPQDN5zAK+k+mZ4Id5/3Cx
	 Wo/UMOMVUeAKVjvu565TXDqJprfppbkn63hkwKHRZUCEmbWm0L46raGqxeZt4ssfaT
	 Bv+r6cpG+o01prDJ9A+GuwLuNkgsFcOk8jOiUc+GUdYJG7o4ki+aghuT4Qa5KGZHib
	 jJPQZeraP5K77KAfZRxsa/IEIbB1w6S4qhUohvuWS5D5XJVoLmTb33ReOQCX81GxWi
	 r4FaeMGPOREj0MHbn8JohZ48E1NKt2gF1lwQaCryxy6bWv1X+B6BlXKpIh3Ky0FYId
	 LlXiWgGTNp0nA==
Content-Type: multipart/mixed; boundary="===============7134958192468196825=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e694bd6bbeff7f31ceff7c361dba55514ce3f5ad03d45b4314d07151e82cb86b@mail.kernel.org>
In-Reply-To: <20261003193347.1137527-4-thisseanzhang@gmail.com>
References: <20261003193347.1137527-4-thisseanzhang@gmail.com>
Subject: Re: [RFC bpf-next v2 3/3] selftests/bpf: Add a test for the PPPoE encap/decap adjust_room flags
From: bot+bpf-ci@kernel.org
To: thisseanzhang@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,netdev@vger.kernel.org,nhudson@akamai.com,nbd@nbd.name,dqfext@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  3 Oct 2026 20:11:38 +0000 (UTC)

--===============7134958192468196825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add a test for the PPPoE encap/decap adjust_room flags

TL;DR:
- Test issue: reject-flag-mix and reject-encap-shrink pass even without the
  new ENCAP_PPPOE checks
- No IPv6 truncated-decap subtest, so the inner_len check goes untested

> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c b/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
> new file mode 100644
> index 000000000000..73e602c91230
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
> @@ -0,0 +1,254 @@

[ ... ]

> +void test_tc_pppoe(void)
> +{

[ ... ]

> +	/*
> +	 * A PPPoE packet whose payload is too short to still contain a
> +	 * full IP header after decapsulation.
> +	 */
> +	static const __u8 truncated_pkt[] = {
> +		0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
> +		0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
> +		0x88, 0x64,
> +		0x11, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x21,
> +		0x45, 0x00,
> +	};

[ ... ]

> +	test_decap_reject_input(skel, bad_ppp_pkt, sizeof(bad_ppp_pkt),
> +				"decap-bad-ppp-proto");
> +	test_decap_reject_input(skel, truncated_pkt, sizeof(truncated_pkt),
> +				"decap-truncated");

Does decap-truncated reach the new "full inner L3 header" check in
bpf_skb_net_shrink()?

truncated_pkt is 24 bytes, so in bpf_skb_adjust_room() the generic length
check fires first:

    len_cur = 24 - 14 = 10
    len_cur - len_diff_abs = 2, which is < len_min (sizeof(struct iphdr))

and the call returns -ENOTSUPP before bpf_skb_net_shrink() runs.

The check added by the decap patch:

    /* A full inner L3 header must remain after decapsulation. */
    if (skb->len - off - PPPOE_SES_HLEN < inner_len)
        return -EINVAL;

is redundant for PPP_IP here, because inner_len == len_min == 20.  It is the
only guard for PPP_IPV6, where inner_len is 40, and no subtest feeds a
PPPoE/IPv6 packet with 20-39 bytes after the PPP header.

If that check were removed or broken, an skb could be marked ETH_P_IPV6
without a full IPv6 header, and none of the subtests would notice.

Would it make sense to add an IPv6 truncated case, for example PPP protocol
0x0057 with 20 bytes of payload, so the inner_len check is exercised?

> +	test_reject(skel, 6, fake_ppp_pkt, sizeof(fake_ppp_pkt),
> +		    "reject-decap-fake-ppp-proto");

[ ... ]

> +	test_reject(skel, 1, ip4_pkt, sizeof(ip4_pkt), "reject-encap-len");
> +	test_reject(skel, 2, ip4_pkt, sizeof(ip4_pkt), "reject-encap-mode");
> +	test_reject(skel, 3, ip4_pkt, sizeof(ip4_pkt), "reject-encap-shrink");
> +	test_reject(skel, 4, ip4_pkt, sizeof(ip4_pkt), "reject-flag-mix");

Can reject-flag-mix or reject-encap-shrink fail on a kernel that lacks the
new ENCAP_PPPOE checks?

For reject-flag-mix, case 4 passes ENCAP_PPPOE | DECAP_PPPOE on ip4_pkt, so
skb->protocol is ETH_P_IP.  bpf_skb_adjust_room() returns early at the
decap protocol gate:

    if (unlikely(flags & BPF_F_ADJ_ROOM_DECAP_PPPOE)) {
        if (proto != htons(ETH_P_PPP_SES))
            return -ENOTSUPP;

which is before the ENCAP_PPPOE flag combination check is reached.  Even with
a PPPoE input, a grow with any decap flag is already rejected by the existing
"if (!shrink) return -EINVAL;" in the BPF_F_ADJ_ROOM_DECAP_MASK block.

For reject-encap-shrink, without the "shrink ||" clause in the ENCAP_PPPOE
check, bpf_skb_net_shrink() would still return -EINVAL, because
BPF_F_ADJ_ROOM_ENCAP_PPPOE is outside its allowed flag mask.

tc_pppoe_reject only records !ret, so both subtests pass whether or not the
new checks exist.  A negative test should give a different result on a
kernel that is missing the check it targets.

Should case 4 use ENCAP_PPPOE together with another encap flag, for example
BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 or BPF_F_ADJ_ROOM_ENCAP_L2_ETH, so the new
rejection is actually exercised?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/tc_pppoe.c b/tools/testing/selftests/bpf/progs/tc_pppoe.c
> new file mode 100644
> index 000000000000..b1624f0f9d8a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tc_pppoe.c
> @@ -0,0 +1,163 @@

[ ... ]

> +SEC("tc")
> +int tc_pppoe_reject(struct __sk_buff *skb)
> +{
> +	int ret = 0;
> +
> +	switch (reject_case) {

[ ... ]

> +	case 4:
> +		/* Encap flag combined with a decap flag. */
> +		ret = bpf_skb_adjust_room(skb, PPPOE_SES_HLEN_TEST,
> +					  BPF_ADJ_ROOM_MAC,
> +					  BPF_F_ADJ_ROOM_ENCAP_PPPOE |
> +					  BPF_F_ADJ_ROOM_DECAP_PPPOE);
> +		break;

Does this case reach the ENCAP_PPPOE flag combination check it is meant to
exercise?

prog_tests/tc_pppoe.c runs it as test_reject(skel, 4, ip4_pkt, ...), so
eth_type_trans() in bpf_prog_test_run_skb() sets skb->protocol to
htons(ETH_P_IP).  Because BPF_F_ADJ_ROOM_DECAP_PPPOE is set,
bpf_skb_adjust_room() returns -ENOTSUPP at the protocol check, before the
new validation is reached:

    flags & ((BPF_F_ADJ_ROOM_ENCAP_MASK |
              BPF_F_ADJ_ROOM_DECAP_MASK) &
             ~BPF_F_ADJ_ROOM_ENCAP_PPPOE))
        return -EINVAL;

The call is rejected for the same reason as case 6 (reject-decap-non-pppoe
on the same ip4_pkt), so this subtest adds no coverage.  With a PPPoE input,
a positive len_diff combined with any decap flag would still be caught by
the existing "if (!shrink) return -EINVAL;" in the DECAP_MASK block.

The combination that only the new check rejects is not tested at all:
ENCAP_PPPOE together with another encap flag, for example:

    bpf_skb_adjust_room(skb, PPPOE_SES_HLEN_TEST, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_ENCAP_PPPOE |
                        BPF_F_ADJ_ROOM_ENCAP_L3_IPV4);

If that check were missing, this call would go into bpf_skb_net_grow() with
encap == true and succeed, and reject_unexpected would catch it.  The test
already builds fake_ppp_pkt so that case 6 can fail on a kernel without the
protocol check.

Could case 4 use a second encap flag in the same way, so that it also fails
on a kernel without the check it targets?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37148983810
--===============7134958192468196825==--
