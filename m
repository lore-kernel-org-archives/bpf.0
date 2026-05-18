Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CA389460
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086049; cv=none; b=unqQI97WNbaY+y4E1B5Tsfh/FWi2Hzch+hbkJta1u1GCe3qJUsXHhzm/92boO15Ygtc74WWGW+kDEwYos6FYtdfyE6VF0B2IjZxH4EuWp8zdrrQHk8xnSjtS6GxZ39ir5ClLK1UI+kXA5Y2GVJaE6KqlMKsZG4G1SKe45bygXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086049; c=relaxed/simple;
	bh=79WR2PBMlf4ayxIEr9XHNebhfg5uodUf6AAlLC3VWI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CsqN2+hQnHFY6jk8LpUBbX9u90s+Y6Rw+6d/HxfIwGoPt/2YSICCGQxrxXt2MHcFUZyAsj6ssS3ebHDswNo+M9kLlpvnvj8Cv3EENephlKDWyo8Q9kB1lmmWwdiPa8X9yjv8J8lv0Br8nwJhg1jDpjMZ3KJprtuMpui3N64ur7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAUEUJqZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAUEUJqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA18C2BCB7;
	Mon, 18 May 2026 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779086049;
	bh=79WR2PBMlf4ayxIEr9XHNebhfg5uodUf6AAlLC3VWI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fAUEUJqZMyfPHCo4m+q5c6P7D4Dog2g+nH8/kqFoLT5ryxRS24hr/MebHlFkV2WPO
	 fwVinxgCGceZLfJ84AlTyhkf1mOfsPUMgWIVdeWx4K02Fbo0Y7t8jAQnjlGeCiEuOj
	 hCJBkgjLO/jxo6R+4jFXUNwprQTtNnTQZOeZZOkQ++OCEwN6XGHJWrJWgQt2opMbMW
	 rMxLvIyeUS9Rly3wGQG0sbAIslnEp8AKkgCHX/JAZdIT6ehYunhr1yS+aqeCcQpLSN
	 vLLO1/DomZJ23tl8cPLzL+rEtJS/BpmIY80Zda3uoJ50jbs2QD40yYehp2pOjAZ5em
	 6F93oHFvQIjXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 5/5] selftests/xsk: drain CQ to wait for TX
 completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517063311.28921-6-kerneljasonxing@gmail.com>
References: <20260517063311.28921-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 06:34:08 +0000
Message-Id: <20260518063408.EEA18C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The racy drain loop in `wait_for_tx_completion()` can exit prema=
turely and fail to drain pending CQ entries, leading to test flakiness.
--

commit 25f4d14929e097cf7028dd26ec4e4bae16aa1a5b
Author: Jason Xing <kerneljasonxing@gmail.com>

selftests/xsk: drain CQ to wait for TX completion

This patch addresses test timeouts in xsk multi-buffer invalid-desc tests
caused by dropped descriptors publishing their buffer addresses to the
completion queue. It clamps outstanding_tx to zero to handle extra CQ
completions and adds a drain loop to consume remaining entries.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 7950c504ed289..1f196c8ebc738 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -1293,6 +1289,17 @@ static int wait_for_tx_completion(struct xsk_socke=
t_info *xsk)
>  		complete_pkts(xsk, xsk->batch_size);
>  	}
> =20
> +	do {
> +		if (xsk_ring_prod__needs_wakeup(&xsk->tx))
> +			kick_tx(xsk);
> +		rcvd =3D xsk_ring_cons__peek(&xsk->umem->cq, xsk->batch_size, &idx);
> +		if (rcvd)
> +			xsk_ring_cons__release(&xsk->umem->cq, rcvd);
> +	} while (rcvd);

Could this drain loop exit prematurely? If the hardware or kernel is slight=
ly
delayed in posting the remaining completions, xsk_ring_cons__peek() will
return 0 on the first iteration, causing the loop to terminate immediately
without waiting.

> +
> +	usleep(100);
> +	complete_pkts(xsk, xsk->batch_size);

Relying on a hardcoded usleep(100) and a single complete_pkts() call might
not be sufficient if the hardware takes longer than 100us or if the number
of remaining completions exceeds xsk->batch_size.

Would it be more robust to track the total number of submitted descriptors
(including invalid ones) in outstanding_tx instead of using a timeout-based
drain?

> +
>  	return TEST_PASS;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517063311.2892=
1-1-kerneljasonxing@gmail.com?part=3D5
