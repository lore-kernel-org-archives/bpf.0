Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286277;
	b=cLpWcmBuu6jkFszbK/C0v/CGTmX3y2Jj6l8jQQ9EPO6V9i5pZy9LVpOOtWwWWfPnoviG
	 7WHKAVsfo5u34Wxz4MzGHl/7xjHMULLKB/2jqTlsEkGTJ/Lpe0BubQW9XymK9R0VyCGQB
	 UXwJzqSXNXReFVVGcHsDEFXDt06hnB5wKgTPpJRSr49S1g3nJdxxX39aRMzcUUqnzqLtA
	 DMGBEkVaJ39SfeNmToPkt3S2T+p3tcroRAppROc0BalUrKOrxRpBuuQZ9NL6F8CCEqmNF
	 btB1i2bBqhbWyDYtSLLA7XOGhPvaXAFSZBXg5J+THO3VzYdKzR4Y9Y+5nDRpc7dvnew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286277;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=sTQtQuvBgA0IGvb/6g2lJhjCbr0yYca5Yhs2xAB3Gs0=;
	b=tuLT195d/wxPH6jChJ/cCvEgZZ6W4wz+ALl3nmyK+i2FqtTGaOuslOaXwWxk9nlvBwbG
	 8kBWub7nbvUmfQxAf3go4T8vzesDVDUw+6CEguj1lcI/YTTCOnisXHQC5e9ZIPqCyfwKy
	 wU5/CRUGr7h+spN2DMHkwtMQAKUU0/51ZF2CSM7lihXBCBRkU+Fp5eP2vi0fSCFia23TZ
	 Dg+SR/WIHLYkTrwF/ywzBpo2FO9xQblrqGIKm8Lua0hMZjJqTzh7tb+gQHivRH2QbLZZH
	 6T7mQJnoAYiIVUZI6JxZBmGQutmgD9mAfgTeU3Ht4he/7KcGpFqsXBAz5xHo7XvmdDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dh9D1XuG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B24606A32A
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dh9D1XuG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F98E1F0089F;
	Tue, 10 Nov 2026 04:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286276;
	bh=sTQtQuvBgA0IGvb/6g2lJhjCbr0yYca5Yhs2xAB3Gs0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Dh9D1XuG3VnAIVMGxRmezx9Z2XNtEth/rJm9T7HiBqvzfjPM8QrhjjMDjZqKOjsMQ
	 eKMuarCtAmKzVM7M0Zha6otxddugRi3ndG5NslQbpi0ZF68Jts3C69jvNub3LZ4O7K
	 4mA7aY+JrT6zzSnSdh6SDUaIVhch4DqKzibRUxnrvtHmIlt0DsplUKCxqwBBFQ/po5
	 ZpmuIsRu2VisDFtdmcdEpRCNiRxzc0rbM6RNaHn91VAN6NR80Wi0VitVySefzz9Its
	 bvXL0MiMPl7NHrzZm4VcYIxNCjWwbAZkF28WvArC+0K4EdTyyqzkc2E2KxiYZxnTjK
	 dzcgilO2uu0QQ==
Content-Type: multipart/mixed; boundary="===============2555818128626639347=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <618fe0286de769d167f0081710da3cd2746bdeeff212a22844dbc8176b06d2b8@mail.kernel.org>
In-Reply-To: <20261110003838.8739-7-emil@etsalapatis.com>
References: <20261110003838.8739-7-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 6/9] selftests/bpf: libarena: Handle NMI reentrancy
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:51:16 +0000 (UTC)

--===============2555818128626639347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Handle NMI reentrancy

TL;DR:
- In a standalone libarena build, bpf_in_nmi() may always return false, so the
  NMI trylock and guards would never fire
- New dependency on bpf_experimental.h breaks libarena self-containment, with
  a possible license mismatch

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> @@ -6,6 +6,7 @@
>  #include <libarena/buddy.h>
>  
>  #include <bpf_arena_spin_lock.h>
> +#include <bpf_experimental.h>
>  

This is the first libarena source that pulls in a header living only in
tools/testing/selftests/bpf (found through -I$(BPFDIR)).  Before this patch,
every libarena include came from libarena/include, and commit 8c1e1c33fe5a
("Move arena-related headers into libarena") moved bpf_may_goto.h out of
bpf_experimental.h to keep libarena self-contained.

Is the license also a concern here?  bpf_experimental.h has no SPDX tag, so
it falls under the tree default GPL-2.0, while buddy.bpf.c is
LGPL-2.1 OR BSD-2-Clause, and the bpf_in_nmi()/get_preempt_count() code is
now inlined from it.

There also seems to be a functional problem.  get_preempt_count() selects its
implementation with:

    #if defined(bpf_target_x86)
    ...

and those macros come from <bpf/bpf_tracing.h>, which only sets them when
-D__TARGET_ARCH_* is passed.  The selftests build passes it via BPF_CFLAGS,
but the "Defaults for standalone builds" in libarena/Makefile do not.

In a standalone "make -C libarena" build, can get_preempt_count() fall
through to "return 0;", making bpf_in_nmi() always false?  Then buddy_lock()
would always use the waiting arena_spin_lock_irqsave(), and the
"!grow || bpf_in_nmi()" check in buddy_alloc_memory() and the NMI guard in
buddy_grow() would never fire.

Would it be better to move bpf_in_nmi(), get_preempt_count() and the
preempt-mask defines into a libarena header, as was done for bpf_may_goto.h,
and make sure a standalone build defines __TARGET_ARCH_*?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755638928
--===============2555818128626639347==--
