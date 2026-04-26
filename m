Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B623603E9
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777232014; cv=none; b=kJd4ejb7qYj6bEqgtY7KtLcTFka7xEP1UDVT/Rs+jPvgmfbiWrJLrGPeu6+EEHb0u37o5XmjCZ2Xn7u/s44zclPDbrQB7jK1hYUG0gp6FV7k8yv9F3tgPy76lyznN5RSTqrs+mNYPPzomtyc6lU+1pbV6bqk2YMLugbShzw8pW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777232014; c=relaxed/simple;
	bh=srIafJ4UADVLnPsl44lzG+DRKgeN7d1och7xW/pNCW8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H7PqppDgfnzhyffCoQCmnpRDQ59FwKdu478PLZcjnft5mDYlcfMHxhZ3LY9z1aDKYALCFdQ+truANuKdORHG7pMG6SlV3KTXYJxXxeWC/XwZwOBLSyQjZc8/402icj6mBrDrlxalA9prWoH4c3PfWaNIM/9ehJgKELKF73VGmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avk8/TyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avk8/TyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C7AC2BCAF;
	Sun, 26 Apr 2026 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777232013;
	bh=srIafJ4UADVLnPsl44lzG+DRKgeN7d1och7xW/pNCW8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Avk8/TyPjAkibpb64uMvliNx/rICleMPkNaFDzDUp3gS5A1kcGnJjSOY8k5Z34h5Q
	 ZIqE73CBy8DdSd9FKpPFaPKHgDLUCdxR0lm4bprP7MoC/CPKHPHVOSK9rwncf90nI7
	 ZzSBehVP7kp31COR0NK8ms14Of24t7QdXRQ43siQkJ9RI7n+SFa03g6bmXXA/QFZ43
	 /Q1rwclqWy22ICHMO0vEyffIlSoTjdlqNJ1cEvKmU7FLBdBvf/Fu58VlyUc0IiuVgZ
	 P6pxRLVu6Yr05IP1xGWf0CQwYgQ38kdFWUyIboLyTeCnlHozKWFn0KpxStS+JuGJtS
	 Mu+XvodfDn4/g==
Content-Type: multipart/mixed; boundary="===============3515059286963746757=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <03bbb60ea8641e9c7b8091abee5ed77d73464f78ca04d26fae4608758743ccb4@mail.kernel.org>
In-Reply-To: <20260426190338.4615-6-emil@etsalapatis.com>
References: <20260426190338.4615-6-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v9 5/8] selftests/bpf: Add ASAN support for libarena selftests
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,mattbobrowski@google.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 26 Apr 2026 19:33:33 +0000 (UTC)

--===============3515059286963746757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
> new file mode 100644
> index 000000000000..1d3edc4372ac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#pragma once
> +
> +#define ST_PAGES 64
> +
> +static inline void print_asan_map_state(void __arena *addr)
> +{
> +	arena_stdout("%s:%d ASAN %p -> (val: %x gran: %x set: [%s])",
> +			__func__, __LINE__, addr,
> +			*(s8a *)(addr), ASAN_GRANULE(addr),
> +			asan_shadow_set(addr) ? "yes" : "no");
> +}

The print_asan_map_state() function dereferences addr with `*(s8a *)(addr)`,
which could be problematic. Could this trigger a secondary ASAN violation or
BPF exception if addr points to unmapped memory outside the arena?

In v8, sashiko-bot noted that this dereference could terminate the test before
the debug output is printed if addr is invalid. The suggestion was to use the
__noasan attribute to avoid interception by ASAN instrumentation.

Reference: https://lore.kernel.org/bpf/20260421211538.7BCA0C2BCB0@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24964771851
--===============3515059286963746757==--
