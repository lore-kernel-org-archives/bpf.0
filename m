Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524623;
	b=va8ldEX95LmRikE7O7sO+zSosrzVM4iiVqH3a6AYK2xYL4X7CPnRJJtl+JOmtF/1RXGS
	 1AoLsUXWuNRgJsf8bGkUFsC8Hqiu34kLQhOqjSKxujGQtaQx7ow6aIaNpTwWP+RkAIc+D
	 hYpa8R1pSmipjxE00Ze4frlgdedcCzv5j6c9LINjWabllpgzpPrSFHV7gLMLTpbFrhBMo
	 8WXhX4Slmn8AQXdnIGqbMYGifkDQL8DCcEa4GR3LxMrIQ7EwjBx0WPlXK3pTDraSnXt/R
	 novFMpxUStwJsbT38g4uCZDlNxZ/kEzqDV3OJJyDcbcqyV2D+iCYlnJeK7f1YAaWkWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524623;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iHJWURAqQ0IVUoK7o5uHs8cfAX2ElHoNFWjHaD9MIt4=;
	b=1yBqPGra9gqFYAZaNTRQ0qusQKZTIxj+xiNhS+j5/uf8M05Reb8HFzdiEII/65AR2xZy
	 VDygMe1a7GOxFNDP1wxhV7vN1K9JxfQzVvlUndFNGAFGaMvmeO0rf20z+6xTR4fO3dqKK
	 owWBLgTcoUTyd1M5kdx262NKmbEWCJ6VRjznnc/z0gx9nnBLuFevHlXF7NfHNPRTIsdXn
	 n2Geiu3kd22KXvVyu36aAr7zZMZKEd5pyKl8UXcYh5evaQMGYROyp87PazpJGIQ+vcsK3
	 7CkYF2D7Eg/BgAcNx2zul+HfBvyOEn+f1PcTxFVhj+IqxgZq9ShY+zQXweqnr6KCr4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eT+ZLLlN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFF606A33C;
	Tue, 20 Oct 2026 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eT+ZLLlN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7BC1F000CC;
	Tue, 20 Oct 2026 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524622;
	bh=iHJWURAqQ0IVUoK7o5uHs8cfAX2ElHoNFWjHaD9MIt4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eT+ZLLlNo5E3mFN09TJIGwclUHB+Y1jCwmuvH/uIu9Do1B8XBqA6XkXkB+CkKOF6O
	 Rn0iK3V7uR8ZUrTy+KXRf4bC045n5S/UTIHwMnHf+Bt2N4i559cmxmCM8EVy/JqJsa
	 k4qevaaiD6rW4Srt5zTW4g8QcZGQZRl34Uwzh9DGPIzImth0B2LrOB9KRMqJjIzw/b
	 lQW3qYXVlQzXFvuz7FbTAjcS7CVvoPWVQPzTBqhHZJjEryxFD5FLgSqlQRfyn85fpB
	 CuRepE3rdx9rdZyZuD5IYhZHrsn81/XR8nOu7JTe6DNfdqwtVNE0Bj20ORjyUR1bfm
	 WoMTGluEHl5ng==
Subject: Re: [PATCH v4 net-next 03/15] selftests: xsk: drop the
 single-interface loopback mode
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:21 +0000
Message-ID: <179252462171.3135.11469820955726744310@kernel.org>
In-Reply-To: <20261016174338.787135-4-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-4-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] testapp_hw_sw_min_ring_size() and
  testapp_hw_sw_max_ring_size() no longer resize the HW rings, and they…
- [Low] The two new multi-line comments above
  testapp_hw_sw_min_ring_size() and testapp_hw_sw_max_ring_size() in…
- [Low] The commit message says xskxceiver 'resized the rings for them
  and restored the sizes it had found only when it exited'.

--

selftests: xsk: drop the single-interface loopback mode

This patch removes the xskxceiver mode that bound both endpoints to queue 0
of one interface through a shared UMEM, along with the -i IFACE option of
test_xsk.sh. It also drops the HW ring resizing for HW_SW_MIN_RING_SIZE and
HW_SW_MAX_RING_SIZE, and set_hw_ring_size(). Ring sizing is left to the
hardware test runner added later in the series.

> test_xsk.sh ran HW_SW_MIN_RING_SIZE and HW_SW_MAX_RING_SIZE only in
> this mode, as veth has no ring parameters. xskxceiver resized the rings
> for them and restored the sizes it had found only when it exited, so a
> killed run left the test sizes behind for the next run to take as the
> defaults.

[Severity: Low]
Is the "only when it exited" part accurate? Before this patch,
__test_spec_init() also restored the saved sizes:

    if (ifobj_tx->hw_ring_size_supp)
        hw_ring_size_reset(ifobj_tx);

__test_spec_init() is called from test_init(), which main() calls before
every test, and from test_spec_reset(). So the defaults were restored
before each test case, and not only at exit.

A run killed during HW_SW_MIN_RING_SIZE or HW_SW_MAX_RING_SIZE would still
leave the test sizes behind, because the next restore only happens at the
next test init or at exit. Could the rationale describe that window
instead?

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 05457f77ca52c..b9126fe66e1a7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -1897,18 +1827,6 @@ static int testapp_validate_traffic(struct test_spec *test)
>  		return TEST_SKIP;
>  	}
>  
> -	if (test->set_ring) {
> -		if (ifobj_tx->hw_ring_size_supp) {
> -			if (set_ring_size(ifobj_tx)) {
> -				ksft_print_msg("Failed to change HW ring size.\n");
> -				return TEST_FAILURE;
> -			}
> -		} else {
> -			ksft_print_msg("Changing HW ring size not supported.\n");
> -			return TEST_SKIP;
> -		}
> -	}
> -
>  	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
>  }

[ ... ]

> @@ -2481,14 +2379,19 @@ int testapp_xdp_metadata_mb(struct test_spec *test)
>  	return testapp_xdp_metadata_copy(test);
>  }
>  
> +/* Expects the HW TX ring of the sender to hold DEFAULT_BATCH_SIZE
> + * descriptors.
> + */

[Severity: Low]
This isn't a bug, but the BPF selftests use multi-line comments with the
opening /* on its own line. The same goes for the new comment above
testapp_hw_sw_max_ring_size().

>  int testapp_hw_sw_min_ring_size(struct test_spec *test)
>  {
>  	int ret;
>  
> -	test->set_ring = true;
> +	if (!test->ifobj_tx->hw_ring_size_supp) {
> +		ksft_print_msg("HW ring sizes not supported.\n");
> +		return TEST_SKIP;
> +	}
> +
>  	test->total_steps = 2;
> -	test->ifobj_tx->ring.tx_pending = DEFAULT_BATCH_SIZE;
> -	test->ifobj_tx->ring.rx_pending = DEFAULT_BATCH_SIZE * 2;
>  	test->ifobj_tx->xsk->batch_size = 1;
>  	test->ifobj_rx->xsk->batch_size = 1;
>  	ret = testapp_validate_traffic(test);

[ ... ]

> @@ -2501,16 +2404,21 @@ int testapp_hw_sw_min_ring_size(struct test_spec *test)
>  	return testapp_validate_traffic(test);
>  }
>  
> +/* Expects the HW TX ring of the sender and the HW RX ring of the receiver
> + * at their maximum sizes.
> + */
>  int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  {
>  	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 4;
>  	u32 batch_size;
>  	int ret;
>  
> -	test->set_ring = true;
> +	if (!test->ifobj_tx->hw_ring_size_supp) {
> +		ksft_print_msg("HW ring sizes not supported.\n");
> +		return TEST_SKIP;
> +	}
> +
>  	test->total_steps = 2;
> -	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
> -	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;

[Severity: Medium]
With the resizing gone, testapp_hw_sw_min_ring_size() and
testapp_hw_sw_max_ring_size() only check hw_ring_size_supp, which main()
sets when get_hw_ring_size() succeeds.

Nothing compares ring.tx_pending with DEFAULT_BATCH_SIZE for the min case,
or with tx_max_pending and rx_max_pending for the max case. The max case
still sizes its batches from the device maximum:

    batch_size = min(test->ifobj_tx->ring.tx_max_pending, max_descs) - 8;

Before this patch, testapp_validate_traffic() resized the sender's rings
whenever set_ring and hw_ring_size_supp were both set, two-NIC xskxceiver
runs included.

Could a manual xskxceiver run on NICs at their default ring sizes now pass
HW_SW_MIN_RING_SIZE or HW_SW_MAX_RING_SIZE without testing the boundary
the new comments describe? Would it be worth skipping these cases when the
ring sizes read at startup don't match what they expect?

These cases skip under test_xsk.sh, because veth has no get_ringparam. The
test_progs wrapper doesn't run them either, since they are in
ci_skip_tests.

Later in the series, "selftests: drv-net: test AF_XDP zero-copy with an SKB
peer" adds drivers/net/hw/xsk.py. Its _size_rings() sets the rings with
ethtool -G before each case and restores them afterwards. That leaves the
gap only for manual runs between this patch and that one.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
