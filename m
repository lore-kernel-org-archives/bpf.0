Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548047CA6B;
	Thu, 23 Jul 2026 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824202; cv=none; b=L2BMQ0nIe8SdDoE3xGJFjgqT4cMTQRdG6MCBLxDMBEjG4xO/VwxgxfsHF+Xay1zA5Bcd3dog1DhY8BBD98TCrGF0pcY3KrYW62vQjsQF3A4o+q73sMk3aFnZRo2mqcWqNumPljCFbmA3KsYCSbPOVlzBXoV5GeHYDl6nh3Wnod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824202; c=relaxed/simple;
	bh=NSv22Eowfqwk2yVty+Vsr9j5buPgHvtCCWJEc5Qnck4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjTwj8vQLls3FBB8Az/zMWqaMQdNzsKSgvoQH3Rn4D2UL9wK4Qn9V/8uxzhYGrkn5Yov8Mk7wsR2VhfupTH0ETr8ecoRPd9qj7L0FssHJxlsklpKZ5BNEJBrzEcIUMOcTjV36hEXiwrRJwBMhtQTPL2LTrzy4g0GSuaTA2YeDfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DED91F00A3D;
	Thu, 23 Jul 2026 16:29:56 +0000 (UTC)
From: Jakub Kicinski <kuba@kernel.org>
To: maciej.fijalkowski@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	kernelxing@tencent.com
Subject: Re: [PATCH v4 net 6/6] selftests/xsk: account reclaimed invalid Tx descriptors
Date: Thu, 23 Jul 2026 09:29:50 -0700
Message-ID: <20260723162950.747417-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260719135609.147823-7-maciej.fijalkowski@intel.com>
References: <20260719135609.147823-7-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
selftests/xsk: account reclaimed invalid Tx descriptors

This patch updates the AF_XDP selftests to count every Tx descriptor
submitted (including invalid ones) in valid_frags so the completion ring
accounting matches the kernel's new behavior of returning invalid Tx
descriptors through the completion ring. It also adjusts verbatim
fragment counting and adds explicit end fragments after invalid middle
descriptors.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index de17dd48f176..38ce6060b8fa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -665,11 +665,11 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
>  			if (!frame->valid || !pkt_continues(frame->options))
>  				payload++;
>  		} else {
> -			if (frame->valid)
> +			if (frame->valid) {
>  				len += frame->len;
> -			if (frame->valid && pkt_continues(frame->options))
> -				continue;
> -
> +				if (pkt_continues(frame->options))
> +					continue;
> +			}
>  			pkt->pkt_nb = pkt_nb;
>  			pkt->len = len;
>  			pkt->valid = frame->valid;

[Low]
The commit message says "Update custom stream generation so an invalid
middle fragment terminates the generated Rx packet while Tx completion
accounting still covers the complete invalid packet."

Does this hunk actually change any behavior?

Walking through the four (valid, pkt_continues) combinations for the
non-verbatim branch shows the same control flow before and after:

  valid=1, continues=1  -> len += frame->len; continue
  valid=1, continues=0  -> len += frame->len; fall through to finalize
  valid=0, continues=1  -> fall through to finalize
  valid=0, continues=0  -> fall through to finalize

The Rx-packet termination described in the commit message appears to be
driven by the pkts[] additions and by removing the !pkt->valid early
exit in pkt_nb_frags(), not by this hunk. Would it be clearer to describe
this change as a pure refactor of __pkt_stream_generate_custom(), or
drop it from this commit?

[ ... ]

> @@ -2099,13 +2098,16 @@ int testapp_invalid_desc_mb(struct test_spec *test)
>  		{0, 0, 0, false, 0},
>  		/* Invalid address in the second frame */
>  		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> -		{umem_sz, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> +		{umem_sz * 2, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> +		{0, MIN_PKT_SIZE, 0, false, 0},

[Low]
Would it be worth calling out the umem_sz -> umem_sz * 2 change in the
commit message?

In shared_umem mode the UMEM size is doubled before registration:

  umem_sz *= 2;

so a descriptor address of umem_sz can fall inside the valid UMEM range
for the second socket. Bumping this to umem_sz * 2 ensures the address
is out of range regardless of shared_umem, which is a nice correctness
tweak, but bundling it with the accounting change makes the intent less
obvious and complicates bisection.

>  		/* Invalid len in the middle */
>  		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
>  		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> +		{0, MIN_PKT_SIZE, 0, false, 0},
>  		/* Invalid options in the middle */
>  		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
>  		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},
> +		{0, MIN_PKT_SIZE, 0, false, 0},
>  		/* Transmit 2 frags, receive 3 */
>  		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, XDP_PKT_CONTD},
>  		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, 0},

[ ... ]
