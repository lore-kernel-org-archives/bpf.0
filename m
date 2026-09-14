Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108EA471404
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392426; cv=none; b=c0KhbgIq4S55AEWzIMXr+77DB2t/uaSR9dAf+Na9chBYkuZmbCvLqY2IEdfYbPzclSgelkcxJhNHJFEmW5aTzZEB6M7jqcmDMmvBxCHkBj9xdKlYdSWwGuiQj1nxp6kVjVmS1Vsic058KRtp5LTUNrqkK3q6ac1Es5Ze6+gGT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392426; c=relaxed/simple;
	bh=l0lhuYy169kdWsUScpBcaZs79QeG3ZeOfu+RAugSXtM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FUlmivmHRZRleakpRs1/2aff4tgRvx8e3Jb8wBr8scVRkjwzIErzsNqZQfkTCOGHurYQS4LgeRaSQkrDII9DoZvODB9y21NNeOWkLo2Uz3j7p2HXBaoSsHatKjGgP54FBinfvIjih/lmCCkwZVKzw9ppSZseEblBs0X5JTQGXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSA2pD3P; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSA2pD3P"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499c930cb9cso11087515e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392423; x=1789997223; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sk1veACjWFv3gtBWyBailRnxXUecWRRaguzzY5A5jU0=;
        b=kSA2pD3PQAIud7YM2p/LXO6Msoj3TMKCtNWMKK1VZnrdGkDMeNgdA+t69yh864E1VI
         PR+SLfXRFN+AOyLokn6EY21VFsWCyiPfXKKoqLX40igCy82c9gC986gq3eKOu6GYDz1C
         Mh+qROOH3SYA3V0T/3cB4mx8P1MLXw3pp9JhtQPh+7Hd7X7WJTt0gVVJwDaayLidbh0u
         XI3PQyGTxvQfD6DBQlLQ/GaZXYlWTuSRfbC1Naaa7w7rN/jO77VfjMt4muREZ66ohsMM
         mFzG9bJsT6WOv97Ak0NMf8srOP9rYtXkpSiXSWax1yGgTELDaOw5f5O04I8gq7jVhyPy
         gP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392423; x=1789997223;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sk1veACjWFv3gtBWyBailRnxXUecWRRaguzzY5A5jU0=;
        b=WT7i9feOQaG5vlfxlsOD/nA4X6+6R61+M1zH12A1sTRHWIaTD842ueo7deYx4yPD3o
         NKntcPIEqKBhQ6IfLwI7y3STIBZcXa2WCUQl3bHF7t9sH8AKn4qmnF0yf+jZY5n4mN6R
         kIyxdZlgK5r9WCCFN2WzX1VWwZ7/fz9+JzC6rRRL2GqvQcB3puJ9MAAqvDsG8kyuE4D0
         OuZvwdfgQa6+Qq9Gmge8A3IRamLYOwimBKYWHlMIyqVdLMmh8PP/5r9g4rwD87RDt90Z
         aEGwifja3HwuNHa0Pwox+r97u7KV84doZzYJOGH/XSNxogKW+jROe7GYxNVoYchJ2PuX
         d8dg==
X-Gm-Message-State: AFuF++lsbceMXIZrVmJxrDfrh5ll3EzTEBRkQ+B28FN/kHHd2ooXykpA
	CvapLH0TkooNgipX+RTTrJ9PsAui6qjNgb/7F8E1ragZ4ixz2jNyRJQyWmIz/LOV
X-Gm-Gg: AYBFou00jqUuzPY4Osd0eSeEVX/C4x4KKtBNNzABCeCWAKaPA4Ccj6nj9SZV6WmyQQ6
	DaMTjuFEbArRXZE+iXq+4AYEMWfrUBpp4JZL+QLyuh9D7p1xbRuLukIzyd1e3JxuF8s8sFdgJsZ
	d7WNjaehFjc3yoSlsSt7Cm970Ixe/QtXbLrkEFUMpd2yKkxQidq3tSXoFGWlwSnkFndRMYjBy5j
	mIuml5RYTLhB6JgArjdCdaXl93kmCaPPIJ8XXPFYTnWZVzvZ2dVN+NNHBhQRCpBQnXHr6v56fBe
	d+pUl7O83mUWDA7wpeVcFsIcmL0ZXg2ay+O6Fi0/WdZBVGhDPUfgwnRXw4r3t5HqMkGEJUAvDuv
	wtbN9V93y2ZTYFHmW4b6FiJiyJwc8PIByXVFbIoz8dGeyOtIh4rIUGLVcDnGzk9o8eCM25X4AMj
	+Tvg9aLj8whJsvsZxx7GXCTICPnAmK1+b53mLy1pq3kWkH3XKcoiyhhM1rbnVUtjR4ToCKjpa1s
	4H79So9VHSFyQNZGlrRTsXy95yryYNfnBfJ2woMaXe7Lz7WlTCwX26hkFZ6soV0rxgX1TAreNLo
	NHuyakGWQEKSphjYsT7wyC9db/7jt8XerL8x+E8/MNCggSED
X-Received: by 2002:a05:600c:3593:b0:49c:e3ad:41d3 with SMTP id 5b1f17b1804b1-49e7a5edc17mr32459815e9.0.1789392423056;
        Mon, 14 Sep 2026 06:27:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60946249sm344442945e9.0.2026.09.14.06.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 06:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 15:27:02 +0200
Message-Id: <DLF2OAEKW80O.1BVYORL67XIKU@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Nicholas Carlini" <npc@anthropic.com>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf v3 0/2] Fix global subprog verification context
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260914131923.2544250-1-memxor@gmail.com>
In-Reply-To: <20260914131923.2544250-1-memxor@gmail.com>

On Mon Sep 14, 2026 at 3:19 PM CEST, Kumar Kartikeya Dwivedi wrote:
> Global subprogs can be invoked in both sleepable and non-sleepable
> contexts, but are verified based on context assumptions for the program
> type as a whole and not the precise context in which they are invoked.
> Nicholas identified that this can violate verifier safety assumptions.
> Verify global subprogs once for each observed sleepability context and ad=
d
> workqueue callback regression tests.
>

By mistake, I tagged bpf tree for this one, sorry. I can respin again after=
 a
round of feedback or let someone else decide to apply it to either tree, if=
 this
version is landable.

> Changelog:
> ----------
> v2 -> v3
> v2: https://lore.kernel.org/bpf/20260905051224.2325381-1-memxor@gmail.com
>
>  * Clarify that globals are checked only in contexts from which they are
>    reached, with two passes only when both contexts occur. (Alexei)
>  * Implement in_sleepable_context() as !in_rcu_cs(). (Alexei, Eduard)
>  * Keep the original subprogram traversal order and repeat until all
>    called contexts have been verified. (Eduard)
>  * Explain why instruction accounting needs the saved total and why the
>    exception callback uses the main program's context. (Eduard)
>  * Rename the do_check_common() parameter to is_sleepable. (BPF CI)
>  * Preserve the harmless global calls with __weak __noinline and check
>    their instruction totals across both contexts. Drop the redundant
>    task-work global RCU test and retain the review acknowledgment. (Eduar=
d)
>
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20260905034018.2095649-1-memxor@gmail.com
>
>  * Preserve the harmless global subprog calls in the positive test with
>    barrier() so LLVM cannot eliminate the intended coverage.
>  * Return zero explicitly from workqueue callbacks after global subprog c=
alls.
>  * Document cumulative instruction accounting across verification context=
s.
>  * Fix BPF multi-line comment formatting.
>
> Kumar Kartikeya Dwivedi (2):
>   bpf: Verify global subprogs in each sleepability context
>   selftests/bpf: Test global subprog callback contexts
>
>  include/linux/bpf.h                           |   5 +-
>  kernel/bpf/verifier.c                         |  71 ++++++------
>  .../bpf/progs/verifier_async_cb_context.c     | 106 ++++++++++++++++++
>  3 files changed, 146 insertions(+), 36 deletions(-)
>
>
> base-commit: 29fcf9ce4bbdf4cc339def776860e1c0095bca98

