Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2478B383993;
	Mon, 17 Aug 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002722; cv=none; b=q92gj71kbfSL+z5kRmaA8lsHdBNsextdH55yKKv6ZRZkzMKFjrqeBmQUwukp4k9TBnmU3VYMmaTS/hSrgF+oUwSSqrlgXuzncyjJh5FqHA2Ethl75zg/QbZYETn0RQujnIeqUOlXngPM4xezdZBchVyRwDtcmNKPgPgAizcVES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002722; c=relaxed/simple;
	bh=lTkI0YGyWLV+sYSwT7nSxKWZIR3zKgaJiXxHro/HD44=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EZIdKZGzvLMlatoW1YiQr6rp+t7TpzzdZ3nWbkpgs90PMh07/gpa2xGScjdEZYq/uD3WqC0zqpcA8P7OFyCV/s7/os7OqkmMBy+stBDqrQceitLoCYhCrUbXhBj2aCoP4OrlkYQAywY6JZPNj0zGtuJeK1m4GKRqdyxZ32wrQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlHuIauh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlHuIauh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C831F000E9;
	Mon, 17 Aug 2026 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787002720;
	bh=f1bSWxwQ8il20hFVOucOY8ZOYG4d51DZEUMg/Jm+h64=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZlHuIauhzcggy13TCI00kFZQFnBtSk1LvbFqUYLJWVSqv7oRjHPrQMJOWeh58IxtS
	 o0PK4sbfZEXdSj6itZgXuVkiWz2WAESfuut4YuwS/sjARWglv7wyYS3jKgmynPkgFf
	 3EOuTDeKkSAPLevmQk8eu8FJlwZzy9vJCg1qGvAG0ueQEsyM02/iBc2EJOdSJTxUkL
	 K7OGYC1IhFsJpnt+2IIXufhDJAAHvLRxJe3kJ7ndlUHZEpPTtlC4mSDkiedH8aLJZn
	 ii+LhMCCP8tVgVzKsNvo2w9ZuO/WpSxIcZt2kFYi/l7SUS8sylP/mjkqtbW0eBk984
	 VoIt5JCi+q1rg==
Content-Type: multipart/mixed; boundary="===============5141211111389517279=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a256e8c8556e33470b90c1f55ecc037f76024df8ea96ef3ffd3eb78921c8bc57@mail.kernel.org>
In-Reply-To: <20260813062754.360131-6-tushar.vyavahare@intel.com>
References: <20260813062754.360131-6-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next v2 5/5] selftests/xsk: make pkt_stream_even_odd_sequence rollback-safe
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 21:38:39 +0000 (UTC)

--===============5141211111389517279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index f84f0edecebe..63a6403e6d5f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -602,26 +602,41 @@ static int pkt_stream_receive_half(struct test_spec *test)
>
>  static int pkt_stream_even_odd_sequence(struct test_spec *test)
>  {
> +	struct pkt_stream *tx_streams[MAX_SOCKETS] = {};
> +	struct pkt_stream *rx_streams[MAX_SOCKETS] = {};
>  	struct pkt_stream *pkt_stream;
>  	u32 i;
>
>  	for (i = 0; i < test->nb_sockets; i++) {
>  		pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
> -		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
> -						   pkt_stream->pkts[0].len, i, 2);
> -		if (!pkt_stream)
> -			return -ENOMEM;
> -		test->ifobj_tx->xsk_arr[i].pkt_stream = pkt_stream;
> +		tx_streams[i] = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
> +						      pkt_stream->pkts[0].len, i, 2);
> +		if (!tx_streams[i])
> +			goto err;
>
>  		pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
> -		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
> -						   pkt_stream->pkts[0].len, i, 2);
> -		if (!pkt_stream)
> -			return -ENOMEM;
> -		test->ifobj_rx->xsk_arr[i].pkt_stream = pkt_stream;
> +		rx_streams[i] = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
> +						      pkt_stream->pkts[0].len, i, 2);
> +		if (!rx_streams[i])
> +			goto err;
> +	}
> +
> +	for (i = 0; i < test->nb_sockets; i++) {
> +		test->ifobj_tx->xsk_arr[i].pkt_stream = tx_streams[i];
> +		test->ifobj_rx->xsk_arr[i].pkt_stream = rx_streams[i];
>  	}
>
>  	return 0;
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
>  }

This isn't a bug, but now that pkt_stream_even_odd_sequence(),
pkt_stream_len_seq() and pkt_stream_uneven_dist_seq() share the same
temporary-array / publish / rollback skeleton, would it be worth factoring
the generate-then-publish and the err: rollback loop into one helper the
three can call?

After this rewrite, all three functions follow the same pattern: allocate
temporary tx_streams and rx_streams arrays, generate streams in a loop with
goto err on failure, publish in a second loop, then have an identical 8-line
err: cleanup block. The only difference between them is the packet-length
expression passed to __pkt_stream_generate().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32069138770
--===============5141211111389517279==--
