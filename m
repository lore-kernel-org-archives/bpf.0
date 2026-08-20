Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B33876A1;
	Thu, 20 Aug 2026 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251350; cv=none; b=harJWvMipY2KLggvnTH5rCXODgAV3L/nnJmHPgK+RJWbsN/MrQL/H9NnR5loETLLFZdh+ZqcYQfu6N/PLxle8FaXBo3eYVnHREIzj/sAhmdqEFQaPW8jP4u1r/MJ6T19VVwaLGZ8i8nWwnyzEEK5QcjXqqOucDsPRKnv2BlvE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251350; c=relaxed/simple;
	bh=zqKTHR2rIfPyrDPM6dA4hSanXkPHfLg1xE54agR4UWY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AQny2grdlulcRZcY5wfChKRBRfm3A1kFEGDzC7slbbf01o0ZIWnqjgoKIVqhSxJXcvYsHzGbQ9VunRUvWmSOk6YWwDV4caP0Mf6/zXL/Nxi8jmZuApln+ezz6Koum6wXUU7FKdcHWKmbY+Ch+H+axgBs9AjI1QBP/5ewNATzViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBjmEBZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBjmEBZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F6A1F000E9;
	Thu, 20 Aug 2026 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787251349;
	bh=Zj1xHxGnvyZZGb+rxiXQX6j2llNLJltAIvL9HceQOcA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aBjmEBZ2l/WgnHLGBgUGKsETPQbm3tn5QwVN8LZii9AWI7UZCrzm7B8KDOvwhxJQS
	 2aEXCdfAiT63hztQGZBW0DbM191aosfymrePLTOnStMgydSTDbLcTKFF8k4dgBmSBw
	 hGMNK1x8sqvKC+u7VAeMIiuUAEkcsD6kvUpv0I+Ml73uUKVjiDeFpF9KC0yBinfiKi
	 XGHlNraIvrgTpLXR5r+8PJtw6m+2FA6qepir/BOmZYHhu4K1gG8s59g9keRnsvN+AP
	 9trRAZAnAHFQnNe3721ibP4nK7oAGTBh7AVHq0DbWz2eLku7Jbh6mVEJs7kZNVz+XV
	 IYdnzr568c/kQ==
Content-Type: multipart/mixed; boundary="===============5239840134286460907=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aaa1b41eac6b31399de8a2d553393c71cdcc5288ca00885b112b39d2b6cc3866@mail.kernel.org>
In-Reply-To: <20260819024443.781764-5-tushar.vyavahare@intel.com>
References: <20260819024443.781764-5-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next v3 4/4] selftests/xsk: add shared-UMEM callback framework and initial test cases
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 18:42:29 +0000 (UTC)

--===============5239840134286460907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 814b8325493f..5d4eb47cbfee 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -224,6 +224,12 @@ int hw_ring_size_reset(struct ifobject *ifobj)
>  static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  			     struct ifobject *ifobj_rx)
>  {
> +	/*
> +	 * Keep the same default as xskxceiver startup: when TX and RX share the same netdev,
> +	 * shared UMEM is the baseline mode for this test harness. Individual tests can still
> +	 * override this as needed.
> +	 */
> +	bool shared_default = ifobj_tx->ifindex == ifobj_rx->ifindex;
>  	u32 i, j;
>
>  	for (i = 0; i < MAX_INTERFACES; i++) {
> @@ -235,6 +241,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  		ifobj->use_fill_ring = true;
>  		ifobj->release_rx = true;
>  		ifobj->validation_func = NULL;
> +		ifobj->shared_umem = shared_default;
>  		ifobj->use_metadata = false;

The shared_default derivation here can never be true in this harness,
can it?

prog_tests/xsk.c uses distinct veth pair ends (VETH_RX "veth0" /
VETH_TX "veth1"), and configure_ifobj() resolves two different
ifindexes. Nothing in test_xsk.c ever assigns ifobj->shared_umem =
true. The only other writer is testapp_poll_txq_tmout(), which merely
saves and restores the current value.

Consequently the umem->base_addr offsetting in xsk_configure_umem(),
the 'shared = (ifobject->shared_umem && tx)' branch in
xsk_configure(), and thread_common_ops_tx() remain unreachable.

The comment asserts the opposite: "when TX and RX share the same
netdev, shared UMEM is the baseline mode for this test harness." In
xskxceiver.c the equivalent derivation can be true because that
binary accepts '-i' twice with the same interface; the ported
harness has no such option, so the copied logic plus its three-line
justification describe behavior that cannot occur.

Should this assignment and comment be removed, or is there a plan to
add same-netdev configuration so the mode is actually exercised?

[ ... ]

> @@ -593,28 +600,95 @@ static int pkt_stream_receive_half(struct test_spec *test)
>  	return 0;
>  }
>
> +static int pkt_stream_replace_seq(struct test_spec *test, pkt_stream_dims_fn dims,
> +				  const void *ctx)
> +{
> +	struct pkt_stream *tx_streams[MAX_SOCKETS] = {};
> +	struct pkt_stream *rx_streams[MAX_SOCKETS] = {};
> +	u32 i, nb_pkts, pkt_len;
> +
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		dims(test->ifobj_tx->xsk_arr[i].pkt_stream, i, ctx, &nb_pkts, &pkt_len);
> +		tx_streams[i] = __pkt_stream_generate(nb_pkts, pkt_len, i, 2);
> +		if (!tx_streams[i])
> +			goto err;
> +
> +		dims(test->ifobj_rx->xsk_arr[i].pkt_stream, i, ctx, &nb_pkts, &pkt_len);
> +		rx_streams[i] = __pkt_stream_generate(nb_pkts, pkt_len, i, 2);
> +		if (!rx_streams[i])
> +			goto err;
> +	}

The hardcoded stride of 2 in __pkt_stream_generate() is correct for the
pre-existing two-socket XDP_SHARED_UMEM test (it produces the even/odd
split), but is it also correct for the new SHARED_UMEM_4_SOCKETS case?

With four sockets the four generated sequences are not disjoint: socket 0
gets pkt_nb = {0,2,4,...,4094} and socket 2 gets pkt_nb = {2,4,...,4096};
socket 1 gets {1,3,...,4095} and socket 3 gets {3,5,...,4097}.

Because the payload written by pkt_generate()/write_payload() and
validated by is_frag_valid() is a function of pkt_nb only (the seqnum
word is '(pkt_nb << 16) | word_index'), a packet that leaks from TX
socket 0 to RX socket 2 (or 1 to 3, and vice versa) is indistinguishable
from the packet that socket really expected, and it is also received in
the expected order.

The only thing that would still catch cross-delivery between those pairs
is the aggregate per-socket count check in receive_pkts(), so the test
largely cannot detect the very misrouting it is meant to cover. The
changelog's '4-socket even/odd split' does not describe the generated
streams (there is no 4-way split).

Using test->nb_sockets as the stride argument would give each socket a
disjoint pkt_nb class while preserving current 2-socket behavior. Does
that make sense here?

[ ... ]

> +static void uneven_dist_dims(struct pkt_stream *orig, u32 sock_id, const void *ctx,
> +			     u32 *nb_pkts, u32 *pkt_len)
> +{
> +	const struct shared_umem_uneven_dist_ctx *cfg = ctx;
> +	u32 pkts_sock0 = cfg->total_pkts / 4;
> +
> +	*nb_pkts = sock_id ? cfg->total_pkts - pkts_sock0 : pkts_sock0;
> +	*pkt_len = cfg->pkt_len;
> +}

[ ... ]

> +static int pkt_stream_uneven_dist_seq(struct test_spec *test,
> +				      const struct shared_umem_uneven_dist_ctx *cfg)
> +{
> +	if (test->nb_sockets < 2 || cfg->total_pkts < 4)
> +		return -EINVAL;
> +
> +	return pkt_stream_replace_seq(test, uneven_dist_dims, cfg);
> +}

The guard validates nb_sockets < 2, but uneven_dist_dims() only
distinguishes socket 0 from "everything else":

	u32 pkts_sock0 = cfg->total_pkts / 4;
	*nb_pkts = sock_id ? cfg->total_pkts - pkts_sock0 : pkts_sock0;

So the 1:3 split it implements is only meaningful for exactly two
sockets. With nb_sockets == 3 or 4 every non-zero slot gets 3/4 *
total_pkts and the aggregate becomes (n - 1) * 3/4 + 1/4 of total_pkts
instead of total_pkts, silently contradicting the ctx the caller
supplied.

The check accepts precisely the configurations the callback cannot
express while rejecting nothing that matters (the only caller,
testapp_shared_umem_uneven_dist(), passes 2).

Should the condition be 'test->nb_sockets != 2', or should
uneven_dist_dims() distribute the remaining 3/4 across the remaining
sockets?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32400920730
--===============5239840134286460907==--
