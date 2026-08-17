Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B9B47254E;
	Mon, 17 Aug 2026 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002727; cv=none; b=Zv4BnB3ITJ5D28FPrednJ50UwCvmd/NYGW4VcUKxrc5PEYPVAIRK+x7DrOjwNqcMDQHRFcHdtOhUEVbVLyjCKu0gVWBWNqheF5vtRzMIatzA4fF8O+XtLMAFO4T/BesfD5XayERGt6T3Akah5XleTCShJANsGT3MCzFWFzKXDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002727; c=relaxed/simple;
	bh=lBwPqQcgn/QPR3ZlAYLnmWh3/cgR5iSobD0YpUnGXuo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oJsZssscmSQjn6DKvTvUlAsR8I1Rhh1g2WQXEZg4i5hruW/Rqlz3NUPrvg7SvduRlSJGtP/Mcdt9vME3DIzsrT+r/LL5qeOyC5LHPM+m//kHcoIxBAh+3FDvdPqIsyq2nDmVb4XI64g/SgudfxAGf376CwYM1djLfqRBaYAtdzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwaj8+a2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwaj8+a2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37261F00A3D;
	Mon, 17 Aug 2026 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787002722;
	bh=uqKAZJZOwCjtCcValP0Svyc82ibVRwXCjuaJFNW9fUk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Mwaj8+a2Fl1jXJZq1lfrglWIiZCbZaKqUmVYwGcmQklkW0r+JCnc8SQgz0Hc8gFgD
	 nRTcwT/LMUDKaeRZA6xbn6OsXRfHv06nkA+MOwXW2HzxzeoQjIFKXc7S8q6wOS5gVi
	 tf/61utLZF2xoUnQOdpZLOynTJPV3ExtHVQMJMv19Nd0s8B51SAinE4gV+8Qq5kp98
	 YjacJgqvezFcqoXoQTjpMxZBnpn+kbsgUSyjvciKLdWwuPSK2Fe5db5Rwgd1ST0NLd
	 tLS5i8HgULvYZusdHOayZPTR1Ww0rzzJm0yHSMSi0hKas3dqflypYZZmSRheGYqNw6
	 +Kx1Zv+Onnvig==
Content-Type: multipart/mixed; boundary="===============0626224048180925867=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <21d3883a1eb6d7a62f162a10fe36771252c907f65080b7c9318216a5d927a172@mail.kernel.org>
In-Reply-To: <20260813062754.360131-5-tushar.vyavahare@intel.com>
References: <20260813062754.360131-5-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next v2 4/5] selftests/xsk: add shared-UMEM callback framework and initial test cases
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 21:38:41 +0000 (UTC)

--===============0626224048180925867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 0bcc1aeaf4c6..f84f0edecebe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -617,6 +624,86 @@ static int pkt_stream_even_odd_sequence(struct test_spec *test)
>  	return 0;
>  }
>
> +static int pkt_stream_len_seq(struct test_spec *test, u32 short_len, u32 long_len)
> +{
> +	struct pkt_stream *tx_streams[MAX_SOCKETS] = {};
> +	struct pkt_stream *rx_streams[MAX_SOCKETS] = {};
> +	struct pkt_stream *pkt_stream;
> +	u32 i;
> +
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		u32 pkt_len = i ? long_len : short_len;
> +
> +		pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
> +		tx_streams[i] = __pkt_stream_generate(pkt_stream->nb_pkts / 2, pkt_len, i, 2);
> +		if (!tx_streams[i])
> +			goto err;
> +
> +		pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
> +		rx_streams[i] = __pkt_stream_generate(pkt_stream->nb_pkts / 2, pkt_len, i, 2);
> +		if (!rx_streams[i])
> +			goto err;
> +	}
> +
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		test->ifobj_tx->xsk_arr[i].pkt_stream = tx_streams[i];
> +		test->ifobj_rx->xsk_arr[i].pkt_stream = rx_streams[i];
> +	}
> +
> +	return 0;
> +
> +err:
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		if (tx_streams[i])
> +			pkt_stream_delete(tx_streams[i]);
> +		if (rx_streams[i])
> +			pkt_stream_delete(rx_streams[i]);
> +	}
> +
> +	return -ENOMEM;
> +}
> +
> +static int pkt_stream_uneven_dist_seq(struct test_spec *test, u32 total_pkts, u32 pkt_len)
> +{
> +	struct pkt_stream *tx_streams[MAX_SOCKETS] = {};
> +	struct pkt_stream *rx_streams[MAX_SOCKETS] = {};
> +	u32 i, pkts_sock0;
> +
> +	if (test->nb_sockets < 2 || total_pkts < 4)
> +		return -EINVAL;
> +
> +	pkts_sock0 = total_pkts / 4;
> +
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		u32 nb_pkts = (i == 0) ? pkts_sock0 : (total_pkts - pkts_sock0);
> +
> +		tx_streams[i] = __pkt_stream_generate(nb_pkts, pkt_len, i, 2);
> +		if (!tx_streams[i])
> +			goto err;
> +
> +		rx_streams[i] = __pkt_stream_generate(nb_pkts, pkt_len, i, 2);
> +		if (!rx_streams[i])
> +			goto err;
> +	}
> +
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		test->ifobj_tx->xsk_arr[i].pkt_stream = tx_streams[i];
> +		test->ifobj_rx->xsk_arr[i].pkt_stream = rx_streams[i];
> +	}
> +
> +	return 0;
> +
> +err:
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		if (tx_streams[i])
> +			pkt_stream_delete(tx_streams[i]);
> +		if (rx_streams[i])
> +			pkt_stream_delete(rx_streams[i]);
> +	}
> +
> +	return -ENOMEM;
> +}
> +

[ ... ]

> @@ -2288,6 +2375,168 @@ int testapp_xdp_shared_umem(struct test_spec *test)
>  	return ret;
>  }
>
> +static int shared_umem_test_prepare(struct test_spec *test)
> +{
> +	u32 i;
> +
> +	if (test->nb_sockets > MAX_SOCKETS) {
> +		ksft_print_msg("ERROR: [%s] invalid socket count %u\n", __func__, test->nb_sockets);
> +		return TEST_FAILURE;
> +	}
> +
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		if (!test->ifobj_rx->xsk_arr[i].pkt_stream ||
> +		    !test->ifobj_tx->xsk_arr[i].pkt_stream) {
> +			ksft_print_msg("ERROR: [%s] missing stream for socket %u\n", __func__, i);
> +			return TEST_FAILURE;
> +		}
> +	}
> +
> +	return TEST_PASS;
> +}
> +
> +static int shared_umem_seq_even_odd(struct test_spec *test, const void *ctx)
> +{
> +	(void)ctx;
> +
> +	return pkt_stream_even_odd_sequence(test) ? TEST_FAILURE : TEST_PASS;
> +}
> +
> +static int shared_umem_seq_len(struct test_spec *test, const void *ctx)
> +{
> +	const struct shared_umem_len_ctx *cfg = ctx;
> +
> +	return pkt_stream_len_seq(test, cfg->short_len, cfg->long_len) ? TEST_FAILURE : TEST_PASS;
> +}
> +
> +static int shared_umem_seq_uneven_dist(struct test_spec *test, const void *ctx)
> +{
> +	const struct shared_umem_uneven_dist_ctx *cfg = ctx;
> +
> +	return pkt_stream_uneven_dist_seq(test, cfg->total_pkts,
> +					 cfg->pkt_len) ? TEST_FAILURE : TEST_PASS;
> +}
> +
> +static int shared_umem_post_uneven_dist(struct test_spec *test, int ret, const void *ctx)
> +{
> +	struct pkt_stream *tx_stream_0, *tx_stream_1;
> +	struct pkt_stream *rx_stream_0, *rx_stream_1;
> +
> +	(void)ctx;
> +
> +	tx_stream_0 = test->ifobj_tx->xsk_arr[0].pkt_stream;
> +	tx_stream_1 = test->ifobj_tx->xsk_arr[1].pkt_stream;
> +	rx_stream_0 = test->ifobj_rx->xsk_arr[0].pkt_stream;
> +	rx_stream_1 = test->ifobj_rx->xsk_arr[1].pkt_stream;
> +
> +	if (tx_stream_1->nb_valid_entries <= tx_stream_0->nb_valid_entries)
> +		return TEST_FAILURE;
> +
> +	if (!ret && rx_stream_1->nb_rx_pkts <= rx_stream_0->nb_rx_pkts) {
> +		ksft_print_msg("ERROR: socket1 rx_pkts (%u) not greater than socket0 (%u)\n",
> +			       rx_stream_1->nb_rx_pkts, rx_stream_0->nb_rx_pkts);
> +		ret = TEST_FAILURE;
> +	}
> +
> +	return ret;
> +}

Can these two checks validate anything the generic traffic path does
not already catch?

pkt_stream_uneven_dist_seq() builds socket 0 with total_pkts/4 packets
and socket 1 with the remainder, and every packet is marked valid:

    pkts_sock0 = total_pkts / 4;
    for (i = 0; i < test->nb_sockets; i++) {
        u32 nb_pkts = (i == 0) ? pkts_sock0 : (total_pkts - pkts_sock0);
        tx_streams[i] = __pkt_stream_generate(nb_pkts, pkt_len, i, 2);
        ...

With total_pkts = DEFAULT_PKT_CNT * 4 the values are fixed at 4096 vs
12288, so the first check always passes and the branch is unreachable.

For the second check, ret == TEST_PASS can only come from
testapp_validate_traffic() when the RX worker's receive_pkts() returned
0. receive_pkts() only exits the loop via all_packets_received()
returning true, which requires pkt_stream->nb_rx_pkts ==
pkt_stream->nb_valid_entries for every socket. Any other exit sets
test->fail and yields TEST_FAILURE.

So when ret == 0, rx_stream_1->nb_rx_pkts is necessarily 12288 and
rx_stream_0->nb_rx_pkts is 4096, and the comparison is always false.

The 1:3 distribution claim is asserted only by the generic per-socket
packet accounting, not by this hook. Would it be better to verify
distribution steering against something the kernel decides, such as
per-socket XDP_STATISTICS or a redirect count from the BPF program?

> +
> +static int run_shared_umem_test(struct test_spec *test, struct bpf_program *xdp_prog_rx,
> +				struct bpf_program *xdp_prog_tx, struct bpf_map *xskmap_rx,
> +				struct bpf_map *xskmap_tx, u32 nb_sockets,
> +				shared_umem_seq_fn seq_fn, shared_umem_post_fn post_fn,
> +				const void *ctx)
> +{
> +	int ret;
> +
> +	test->total_steps = 1;
> +	test->nb_sockets = nb_sockets;
> +
> +	test_spec_set_xdp_prog(test, xdp_prog_rx, xdp_prog_tx, xskmap_rx, xskmap_tx);
> +
> +	ret = shared_umem_test_prepare(test);
> +	if (ret)
> +		return ret;
> +
> +	ret = seq_fn(test, ctx);
> +	if (ret)
> +		return ret;

Does this leak the streams when seq_fn() fails?

For the two callers that use shared_umem_seq_even_odd(),
testapp_shared_umem_4_sockets() and testapp_shared_umem_unaligned(), the
underlying pkt_stream_even_odd_sequence() publishes each replacement
stream into test->ifobj_{tx,rx}->xsk_arr[i].pkt_stream as soon as it is
allocated:

    for (i = 0; i < test->nb_sockets; i++) {
        tx_pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
        tx_streams[i] = __pkt_stream_generate(...);
        if (!tx_streams[i]) {
            pkt_stream_delete(tx_pkt_stream);
            return -ENOMEM;
        }
        test->ifobj_tx->xsk_arr[i].pkt_stream = tx_streams[i];
        ...

If allocation fails mid-loop, the already-published streams for slots
0..(i-1) are never freed on the error path shown here, so
release_even_odd_sequence() is skipped and xsk_arr[] is left holding a
partially replaced stream set until the next __test_spec_init().

The two seq helpers added by this same commit, pkt_stream_len_seq() and
pkt_stream_uneven_dist_seq(), already use the staged temp-array + err:
rollback shape, so only the even/odd path is exposed.

> +
> +	ret = testapp_validate_traffic(test);
> +	if (post_fn)
> +		ret = post_fn(test, ret, ctx);
> +
> +	release_even_odd_sequence(test);
> +
> +	return ret;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32069138770
--===============0626224048180925867==--
