Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E613E1688;
	Fri,  9 Oct 2026 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547985; cv=none; b=nZ6GPzxfpezYPDXvcGjtFGDrAlBgr9o3E3mX7pqFLPMRaNvGhB/zGwG48PRPw0D9oQY4Kg8j1O7tq7Y7EaYGTzwWuY3BxpamDN0mVY45/jlb4mZFUg083n6TCRKINZMt53h9I0fpkoaFBsnpZo6Qi+LiV5bn4Ube4Rp/tzp+WBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547985; c=relaxed/simple;
	bh=HA6ElQkQmLxART6l0FM2pn+3b6US7P3oeOJ8fPUvL+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B861O/gEbnOsql4f7ldRhswEGTYqxeyHZmYfOFEHBjsDy9d1RTggTHL3oj10QucBZGwcTBsrn9zu0GxLAOE2uN2HElAdptwdVijNA5ZmEFHnwUCjNJ9H3PrI3cjvHVNhNWvNoqScqFCSCHlzOADJTCuFvO+xKQOpdhYPd91f24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8uhyrF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8uhyrF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4374B1F00893;
	Fri,  9 Oct 2026 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547975;
	bh=5DgSawWwcWZTCLSsTzXPu9dHG4TFqomzTXZm0QKw3jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Z8uhyrF4VrpVPeiqWN2o/HjZw41C/IDZ67obtl6YYNHWK1es+/YTgGtT+AKfmZuft
	 bHgLQuSxuHf4y0FXs3i+fvaC6umAs9uTlE+czX2QW9gRi86xk6JdrWmKQvIWp5c7/d
	 tyV9/2BavTVh8yppT8cI1QPsTvQeiwPR/AviUgHClx5RscGvd12j4LzrTCgIjGz5J5
	 ZErrYH2yCCpgey3N/NzUc/HrCII3oHIOuXNUoxoUT+sb5PadWAwXLvucqusF/awD6p
	 OulF1/D9a+C7woVQ+2yS1bUgDpzr5GsobXE5ebyc5gmPfD2B1Cp0gT6M2MmCpJfPqB
	 nM9vLKwY9p4ag==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net-next 12/14] selftests: xsk: share test case
 definitions with hardware runner
In-Reply-To: <20261008114909.734364-13-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-13-maciej.fijalkowski@intel.com>
Date: Fri, 09 Oct 2026 14:12:52 +0200
Message-ID: <875wzbqdh7.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Keep case names, functions, and hardware directions in an X-macro
> header. The C test table keeps its order, so the test IDs do not
> change. This allows the Python runner added by the next patch to read
> the same definitions. Only the runner uses the hardware directions,
> the DUT roles in which it runs a case; xskxceiver ignores them.
>
> Install the header with selftests so the Python runner can read it
> from an installed tree.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  tools/testing/selftests/net/lib/Makefile      |  2 +-
>  .../testing/selftests/net/lib/xsk/test_xsk.h  | 46 ++-------------
>  .../net/lib/xsk/test_xsk_case_defs.h          | 57 +++++++++++++++++++
>  3 files changed, 62 insertions(+), 43 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib/xsk/test_xsk_case_defs.h
>
> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> index 066d011c478a..15353021cecf 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -28,7 +28,7 @@ TEST_GEN_FILES := \
>  	xdp_helper \
>  # end of TEST_GEN_FILES
>  
> -TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
> +TEST_INCLUDES := $(wildcard py/*.py sh/*.sh) xsk/test_xsk_case_defs.h
>  
>  include ../../lib.mk
>  
> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> index c37423030eb6..e1ffd054c8f7 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> @@ -309,48 +309,10 @@ int worker_testapp_validate_rx(struct test_spec *test);
>  int worker_testapp_validate_tx(struct test_spec *test);
>  
>  static const struct test_spec tests[] = {
> -	{.name = "SEND_RECEIVE", .test_func = testapp_send_receive},
> -	{.name = "SEND_RECEIVE_2K_FRAME", .test_func = testapp_send_receive_2k_frame},
> -	{.name = "SEND_RECEIVE_SINGLE_PKT", .test_func = testapp_single_pkt},
> -	{.name = "POLL_RX", .test_func = testapp_poll_rx},
> -	{.name = "POLL_TX", .test_func = testapp_poll_tx},
> -	{.name = "POLL_RXQ_FULL", .test_func = testapp_poll_rxq_tmout},
> -	{.name = "POLL_TXQ_FULL", .test_func = testapp_poll_txq_tmout},
> -	{.name = "ALIGNED_INV_DESC", .test_func = testapp_aligned_inv_desc},
> -	{.name = "ALIGNED_INV_DESC_2K_FRAME_SIZE", .test_func = testapp_aligned_inv_desc_2k_frame},
> -	{.name = "UMEM_HEADROOM", .test_func = testapp_headroom},
> -	{.name = "BIDIRECTIONAL", .test_func = testapp_bidirectional},
> -	{.name = "STAT_RX_DROPPED", .test_func = testapp_stats_rx_dropped},
> -	{.name = "STAT_TX_INVALID", .test_func = testapp_stats_tx_invalid_descs},
> -	{.name = "STAT_RX_FULL", .test_func = testapp_stats_rx_full},
> -	{.name = "STAT_FILL_EMPTY", .test_func = testapp_stats_fill_empty},
> -	{.name = "XDP_PROG_CLEANUP", .test_func = testapp_xdp_prog_cleanup},
> -	{.name = "XDP_DROP_HALF", .test_func = testapp_xdp_drop},
> -	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
> -	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
> -	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
> -	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
> -	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
> -	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
> -	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
> -	/* Flaky tests */
> -	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
> -	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
> -	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
> -	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
> -	/* Tests with huge page dependency */
> -	{.name = "SEND_RECEIVE_UNALIGNED", .test_func = testapp_send_receive_unaligned},
> -	{.name = "UNALIGNED_INV_DESC", .test_func = testapp_unaligned_inv_desc},
> -	{.name = "UNALIGNED_INV_DESC_4001_FRAME_SIZE",
> -	 .test_func = testapp_unaligned_inv_desc_4001_frame},
> -	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
> -	 .test_func = testapp_send_receive_unaligned_mb},
> -	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
> -	/* Test with HW ring size dependency */
> -	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
> -	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
> -	/* Too long test */
> -	{.name = "TEARDOWN", .test_func = testapp_teardown},
> +#define XSK_TEST_CASE(_name, _func, ...) \
> +	{ .name = #_name, .test_func = _func },
> +#include "test_xsk_case_defs.h"
> +#undef XSK_TEST_CASE
>  };

Hmm. Maybe not for this revision, but I'm getting a vibe that we're
mixing reusable operations with test receipes.

Ideally the operations would reside in the C-code, and the recipes in
Python...
