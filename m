Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830352CCD7
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915752; cv=none; b=PACDL2ZKJWhdmIspNQbVgImJZimJMYgJLVilqyend7tfxEUc3Ez9hsug0fGKnt9on71uCNM8S+jHviLRjC6tq+aKlh1Bvk9RdeGjoSDxlMhoi8Gd9EVER8w7s1pW3kyxTfyzxO/6a3ZyBxcBTgpR9gMudhXSec3r86dku2jj0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915752; c=relaxed/simple;
	bh=FUcGpTNl69IjIbl7brNxNSRxvyUJMlB+mXVSdomxf0A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GYsHa/x/yzgcFOQ5t7T4boimV87O9rqx8uOmQcuEXvnSsOPs60t/95NHlZDV95dbk8gdxmN1FUrBlJEGkWSb6OhcSnhBzRchHYZc8VWVOMWXCLBaJr/UGOBHRQtU0BpZvThDZXmc+RX7FUtKSU1PUihs6UVNsSqXfkdJ59xTeWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3GX4J3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3GX4J3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF831F000FF;
	Tue, 13 Oct 2026 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791915750;
	bh=RscgrbGtlT536DrddR3MsH+fIRcixgBvZNQy8HRAAz8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=O3GX4J3RmAgpWk0ktFKLK/C2nW+IOO5YtBGfQtouyxYARq2w6Hlffu8i1Rm6A3wUd
	 0eV2qUHpTGC5sKXKb5d5BlN5O6Qgggm1TKdIIlgE6epn7ex2F16iDwaUoyCuPWlJcd
	 NPyXwanHKM4zGdvm4jN0sGfQQK4JDwyzRnDCdXy4iEBc5b9+fgjDxsMdDKrHQpDFnn
	 kc4upZEQijy4xVA395dCFNbJT+ZuSK/HyhzgdUelAZEkLwoKpmkfKc4qsBIqqZ1QPT
	 T3naUu+1Xtsj89M0/zhd13vRR/DLfKV/8lBo04Jt2VrkN5QzX0BL8X1YTks1tDyerj
	 gsTGfKfYqe95g==
Content-Type: multipart/mixed; boundary="===============1441693752770932196=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d1fd91cd937361d722b8e92b31d083eb9facfb66d387d508b35043b3e6a17d22@mail.kernel.org>
In-Reply-To: <20261013171230.523677-19-daniel@iogearbox.net>
References: <20261013171230.523677-19-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 18/18] selftests/bpf: Remove the old test_bpf module
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 18:22:29 +0000 (UTC)

--===============1441693752770932196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Remove the old test_bpf module

TL;DR:
- Commit message may overstate successors: classic BPF tests (SKF_AD_*
  converter, sparc32 cBPF JIT) seem to have no replacement
- The two skb_segment crash-fix tests seem not covered by net_test.c, so
  regressions may go uncaught

> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> deleted file mode 100644
> index af6f3340c034..000000000000
> --- a/lib/test_bpf.c
> +++ /dev/null
> @@ -1,15934 +0,0 @@

[ ... ]

> -enum {
> -	CLASSIC  = BIT(6),	/* Old BPF instructions only. */
> -	INTERNAL = BIT(7),	/* Extended instruction set.  */
> -};

The commit message says "The instruction tests of the test_bpf module live
in the BPF selftests now, as the jit_insns test of test_progs".  Does that
hold for the tests flagged CLASSIC?

None of the roughly 135 CLASSIC tests in the deleted file appear to have
been carried over.  tools/testing/selftests/bpf/prog_tests/jit_insns.c has
no sock_filter, BPF_STMT/BPF_JUMP, BPF_ABS/BPF_IND or SKF_AD_* usage, so
only the INTERNAL tests seem to have a successor.

The classic tests went through bpf_prog_create(), and that leaves two areas
without systematic in-tree coverage.

1) The ancillary load handling in convert_bpf_extensions() in
net/core/filter.c, which is used by every SO_ATTACH_FILTER and seccomp
filter.  The deleted tests covered SKF_AD_PROTOCOL, HATYPE, IFINDEX, MARK,
RXHASH, QUEUE, VLAN_TAG, VLAN_TAG_PRESENT, PAY_OFFSET, NLATTR, NLATTR_NEST
and ALU_XOR_X, each of which has a "case SKF_AD_OFF + SKF_AD_..." in
convert_bpf_extensions().  The remaining selftests only use SKF_AD_CPU,
SKF_AD_PKTTYPE and SKF_AD_OFF (toeplitz.c, csum.c, gro.c, psock_lib.h,
reuseport_bpf_cpu.c, skf_net_off.c).

2) The sparc32 classic JIT.  arch/sparc/Kconfig still has:

    select HAVE_CBPF_JIT if SPARC32

and bpf_jit_compile() in arch/sparc/net/bpf_jit_comp_32.c is only reached
from cBPF programs.  The advice that archs "move over to the BPF selftests
for proper coverage" does not seem to apply there, since test_progs only
loads eBPF programs.

The previous commit (71a5c374fa65) says it carries "only the relevant
instruction tests", so dropping the classic tests may be deliberate.  Even
so, could the changelog avoid saying that the instruction tests now live in
the BPF selftests, and could the lost cBPF converter and extension coverage
be acknowledged or ported?


[ ... ]

> -struct skb_segment_test {
> -	const char *descr;
> -	struct sk_buff *(*build_skb)(void);
> -	netdev_features_t features;
> -};
> -
> -static struct skb_segment_test skb_segment_tests[] __initconst = {
> -	{
> -		.descr = "gso_with_rx_frags",
> -		.build_skb = build_test_skb,
> -		.features = NETIF_F_SG | NETIF_F_GSO_PARTIAL | NETIF_F_IP_CSUM |
> -			    NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM
> -	},
> -	{
> -		.descr = "gso_linear_no_head_frag",
> -		.build_skb = build_test_skb_linear_no_head_frag,
> -		.features = NETIF_F_SG | NETIF_F_FRAGLIST |
> -			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_GSO |
> -			    NETIF_F_GRO | NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM |
> -			    NETIF_F_HW_VLAN_STAG_TX
> -	}
> -};
> -

The commit message says the skb_segment tests "have a KUnit successor in
net/core/net_test.c".  Are these two cases actually covered there?

They were added as reproducers for BUG_ON crash fixes in skb_segment():

  gso_with_rx_frags (76db8087c4c9) for 13acc94eff12 ("net: permit
  skb_segment on head_frag frag_list skb")

  gso_linear_no_head_frag (cf204a718357) for 3dcbdb134f32 ("net: gso: Fix
  skb_segment splat when splitting gso_size mangled skb having
  linear-headed frag_list")

For gso_linear_no_head_frag, build_test_skb_linear_no_head_frag() builds
alloc_skb() frag_list members (head_frag = 0, linear data) with
SKB_GSO_TCPV6 | SKB_GSO_DODGY and a gso_size of 1288 that differs from
skb_headlen(head_skb).  That is the input needed to reach this block at the
top of skb_segment():

    if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
        !gso_by_frags && mss != skb_headlen(head_skb)) {
        ...
            if (skb_headlen(check_skb) && !check_skb->head_frag) {
                ...
                features &= ~NETIF_F_SG;

net/core/net_test.c never reaches it.  gso_test_func() never sets gso_type,
which stays 0 because __finalize_skb_around() clears the shinfo, and every
frag_list member is built with build_skb(page_address(page), frag_size +
shinfo_size), which sets head_frag = 1 whenever frag_size is non-zero.  So
there is no DODGY skb and no linear non-head_frag frag_list member.

For gso_with_rx_frags, the head skb and its frag_list member are
dev_alloc_skb() head_frag skbs, each with 8 linear bytes plus a 64-byte rx
frag, and the features include NETIF_F_SG | NETIF_F_GSO_PARTIAL.  The
segmentation loop then reaches this code in skb_segment():

    if (!skb_headlen(list_skb)) {
        BUG_ON(!nfrags);
    } else {
        BUG_ON(!list_skb->head_frag);
        /* to make room for head_frag. */
        i--;
        frag--;
    }

followed by:

    *nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;

In the net_test.c cases this path does not seem to be hit:

- frag_list and frag_list_pure have mss-aligned linear frag_list members,
  so after the head segment every iteration takes the skb_clone(list_skb)
  path under "hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
  (skb_headlen(list_skb) == len || sg)".
- frag_list_non_uniform clears NETIF_F_SG and takes the skb_copy_bits()
  path.
- gso_by_frags always takes the clone path.
- frags and gso_partial have no frag_list.

net_test.c's skb_segment test came from b3098d32ed6e ("net: add skb_segment
kunit test") and was never extended with these two cases, and a search of
tools/testing/, lib/ and the KUnit files finds no other skb_segment() test.
After this commit, a regression of either fix would have no in-tree test
that catches it.

Could the two cases be ported into the gso_test cases[] table in
net/core/net_test.c, for example a DODGY case with alloc_skb()-backed
frag_list members and a case with head_frag plus page-frag frag_list
members, before the module is removed?  Alternatively, could the commit
message stop describing net_test.c as the successor of these tests?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38442623945
--===============1441693752770932196==--
