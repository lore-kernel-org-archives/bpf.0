Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667225;
	b=uPHva1bbgJo4Sv8N4oDwtN5WPc2CBA6mBYA19dLUD/jESJx3lOxkpWTvl0j94kRZV1GG
	 ajVofQ4aLgeIzgI2tWrzxuxwIbgzN8a1iTgnDLG7IKOcNt5Dm2hNE8ezgN4wRB34WXucf
	 3UrH4KuPVJ7CJLCLYkVC8Yd1y8AswVymNJbQhfvaoFgdBS0MsXE3g4Fe+aDhl/3nF1FIj
	 2bglg/ilkoMK8hR6Do8Pl+CzwTkEiAZYrJx01zGsdnpDxFBxGtwcL++xPSGXSSqgTX/Eq
	 iM7lysonb5sUQgq0pyr3iOsmjPsIERhbQqHNG6nVOftBgQUEX/ipE4/DbDEiXPOHLYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667225;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=3nvZl+aK4H2XkqAXHmwSnryWbtCzEcmlrf5h2Mfz4pc=;
	b=qi1ZTlCXDX3T0ZEBbdLOCBYBzbtpBIrc7R7su0fOybrGjB4e8V8bpW1q+2dMlXEcKzpp
	 zyY85cMMz4peDfQcKPn1ZHUM58ne3JUy2wHmtM3OOIwmJtPsjHcWPh3vWRduJO7jgGq9z
	 SwOZzkP4xxDB87PDn1mHMcG2SWBIXHlCGNfEqWyZ8xqvj6Ac9W2mBQLgQWlxT6RGtmqCL
	 OUq+nrE5WlIM9ZayCIujOxAvn0nvvsuVPIp725542vIkmFTHMz9K1BGw+rrgs2B2KOXlN
	 VFZbA3n5YEpOdiNHJfZSpDp6PXcOdAYOifWco2oraLU36PfYMW88TMsZuETTy45yIgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAwu+nHi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77344606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAwu+nHi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0901F000C4;
	Thu, 26 Nov 2026 04:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667225;
	bh=3nvZl+aK4H2XkqAXHmwSnryWbtCzEcmlrf5h2Mfz4pc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IAwu+nHi0KVsiL0XFbhpTMDyo7xPdpnHdZnTstU0B3hnWSjZ39lCHRhufmnPG1cSb
	 whv3ys8BtRKRFn2DkiP6I9p6mzCSOeaFr5tD7sNGTsqcRkCbcMa+6YfLMbBklYZNB3
	 juzMWhEgx7LWrH136P39IxE774lzFQvBBGZISdtQMUwsCjIrucpqnw0ixjULzzGRJt
	 RPFY/bl6zBi5Oq6A+QZqRAVUGkrUcC2lUXYxHpaK3W5pEINbk3QKgC9X0/2nrS8Lcw
	 LwpuAeqBxk5J7sSuM6+WVoSqI74nFy6WLSWGFihkQk6R7EC38okRK+DiTRwp2hpa5T
	 nAjnJ3PHBPBYw==
Content-Type: multipart/mixed; boundary="===============1498976645729861519=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <87318f8e3ec3c345e91d547d5155af346512941ef6e32535f708348341eb7322@mail.kernel.org>
In-Reply-To: <20261126033816.4124847-5-alexei.starovoitov@gmail.com>
References: <20261126033816.4124847-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf v2 4/4] bpf: Emit nospec after calls and atomics that write to the stack
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,luis.gerhorst@fau.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 04:27:04 +0000 (UTC)

--===============1498976645729861519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Emit nospec after calls and atomics that write to the stack

TL;DR: Commit message only: the second Fixes: tag (880442305a39,
load-acquire/store-release) may be wrong, since it predates nospec_result and
d6f1c85f2253 already covers the problem.

> bpf: Emit nospec after calls and atomics that write to the stack
>
> check_stack_write_fixed_off() sets nospec_result for BPF_ATOMIC insns
> and for calls of helpers and kfuncs too. do_check() ends a speculative
> path there, but bpf_convert_ctx_accesses() emits the nospec only after
> BPF_MEM stores.
> Later passes rewrite a call and need its aux data. Put the nospec in
> front of the next insn.
> Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
> Fixes: 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
> Suggested-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Is the second Fixes: tag correct?

  Fixes: 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")

That commit predates the nospec_result mechanism.  The problem described
here, nospec_result being set for atomics and calls while
bpf_convert_ctx_accesses() emits the nospec only after BPF_MEM stores, comes
from d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1"), which is
already listed in the first Fixes: tag.  Should the 880442305a39 tag be
dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45752115987
--===============1498976645729861519==--
