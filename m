Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E773409121;
	Wed, 12 Aug 2026 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531689; cv=none; b=qBIi7oQDCGpH5UVWTM5MUoVq+mAnnJ03jqivjbRmK9wlAth+mIQJqR9ZcNnVRDqq2YEAH8NdZ3nuGFmHK2tDAMTIY3Ie4Nze1xvnUqE2O+yUThjdfT3yVTmZAnpBWZdmohfb/8kypUc0tPUYw5PkvFy+jTxQEqsaOfioA8VGU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531689; c=relaxed/simple;
	bh=ircjVui5fcPLKosfW2Lj0j3Pndydm4YkSSiBAvTtEgU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=umBppHhbfJZuB16BDuO3fQtqCsMUwje/qNzgt7IT0gIHKm+ccVASEPwTXrm2hIEdnp5Oc0iuSidcRr54MDhckz+AR0ENhqPf7qUSgnURV8qajn/yGBJiCspmf57z1Sb9iBZHz+PoI+TsvQU+8WKKJLX83884ncmQcx40TkE4sJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtbQw40v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtbQw40v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E7E1F000E9;
	Wed, 12 Aug 2026 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786531687;
	bh=BrlyDxdNLZr5aTCv0a4NOp4cia3qj3dIK3fGQrfnoxk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZtbQw40vcDU9NGt6kIAdnhT2s9kR3Q2bhVvOagMSRHXhRe+OPRMFxRoSbdIMouobL
	 7WA2LUFkby5W13xwDFiAKVDLNZMySTq8BDSQdqLVYOdxfCWUZXuP7r8ophCfMLD14X
	 v9oaOhgoHsFiJEU3/RhWicPExV6xOutccsneGy7f9aIO8U83YjjL+/5eNK/kFBMgRU
	 b/rjs25YJTpkZWwmhBqhFo+DlkReh0BrOZLP4vpPLhSjJqj1uWEGvgYDdzsRVH2c3w
	 LWBVUlT5b2APpigPGgmt7Or8xVFe8JS21fa++pXTt6YoxyQ/3im/x9LpKBfnJE9BnW
	 LQwxLcqgXfTXw==
Content-Type: multipart/mixed; boundary="===============5263543539982007423=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96ae36f751c60c798d9a5912c09dc3e0392618561588959c9fdc33faed92c039@mail.kernel.org>
In-Reply-To: <20260812083115.73100-7-nhudson@akamai.com>
References: <20260812083115.73100-7-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v7 6/6] selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 10:48:07 +0000 (UTC)

--===============5263543539982007423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> index 1aa7c9463980b..67ba27d693474 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> @@ -438,7 +438,6 @@ static int setup(void)
>  	SYS(fail_close_ns_client, "ip link add %s type veth peer name %s",
>  	    "veth1 mtu 1500 netns " CLIENT_NS " address " MAC_ADDR_VETH1,
>  	    "veth2 mtu 1500 netns " SERVER_NS " address " MAC_ADDR_VETH2);
> -	SYS(fail_close_ns_client, "ethtool -K veth1 tso off");
>  	SYS(fail_close_ns_client, "ip link set veth1 up");

Dropping the TSO-off setting here changes what the encap side of the test
exercises. With TSO off, veth1's xmit path had to software-segment the
BPF-encapsulated GSO skb, which validated the encap-side GSO metadata
(inner_protocol, inner_protocol_type, inner header offsets, gso_type,
csum_start) written by BPF_F_ADJ_ROOM_ENCAP_* through gre_gso_segment()
and UDP-tunnel GSO. With TSO on, veth advertises NETIF_F_GSO_SOFTWARE and
NETIF_F_GSO_ENCAP_ALL, so the encapsulated GSO super-packet is forwarded
to veth2 intact and no tunnel GSO segmentation happens anywhere in the
path for any of the 12 `.test_gso = true` subtests.

It also changes what the kernel-decap leg sees: a GSO super-packet through
gre_rcv()/fou_udp_recv() -> iptunnel_pull_offloads() instead of a stream
of segmented packets.

Is it intentional to remove the encap-side segmentation coverage, or should
both modes be preserved?

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> index 7376df405a6be..853bca9629103 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c

[ ... ]

> @@ -655,6 +688,40 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
>  	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
>  		return TC_ACT_SHOT;
>
> +	kskb = bpf_cast_to_kern_ctx(skb);
> +	shinfo = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
> +	if (shinfo->gso_size) {
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
> +			return TC_ACT_SHOT;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +			return TC_ACT_SHOT;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +			return TC_ACT_SHOT;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +			return TC_ACT_SHOT;
> +
> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> +			if ((shinfo->gso_type & SKB_GSO_TUNNEL_MASK) &&
> +			    !kskb->encapsulation)
> +				return TC_ACT_SHOT;
> +			if (!(shinfo->gso_type & SKB_GSO_TUNNEL_MASK) &&
> +			    kskb->encapsulation)
> +				return TC_ACT_SHOT;
> +		}
> +	} else if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
> +		   kskb->encapsulation) {
> +		return TC_ACT_SHOT;
> +	}
> +

All of the new GSO assertions sit under `if (shinfo->gso_size)`. If the
packet reaching veth2 ingress is not a GSO skb, this entire block is
skipped, the program returns TC_ACT_OK, and the subtest reports PASS.

Whether a GSO skb reaches the BPF decap program at all depends on emergent
path behavior: TCP builds a GSO skb because sk_setup_caps() forces
NETIF_F_GSO|NETIF_F_GSO_SOFTWARE for TCP sockets, and veth1 does not
segment it because VETH_FEATURES includes NETIF_F_GSO_SOFTWARE and
NETIF_F_GSO_ENCAP_ALL.

Nothing in the test verifies that assumption held. There is no counter or
flag exported to user space saying "a GSO skb was seen and validated". If
a future change to veth features, to sk_route_caps, to the send size, or
to the MTU clamping stops producing GSO skbs on that path, the newly added
assertions become silent no-ops and the test keeps passing green - a false
pass of precisely the kind selftests.md warns about under "Test the
Interface.../negative-test tautologies".

The sibling test progs/decap_sanity.c shows the pattern that avoids this:
record state in a global (init_csum_partial, etc.) and ASSERT_* on it from
the prog_tests side, so "the check never ran" is distinguishable from "the
check passed".

Should this test export a flag or counter indicating that the GSO
validation actually executed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31584739682
--===============5263543539982007423==--
