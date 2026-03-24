Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC337BE7A
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316851; cv=pass; b=RggZCPGTUFdsiOgE6o1PYftZSYXXaNXK4qxw0vOw8cbvRaQWJCgRFoMVjOEAsP1DMCKVQ25wp95oW/K0GeE1POYDcGDUtlR2h0SJJTo9cw1ZNnZy2MnBhJ9yZClpH7CRtPJnshQCyBPNJhHVndkPU/lpdG/GwAX62EPylc2LvcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316851; c=relaxed/simple;
	bh=MUfi36ea7f/nz/pbaSwAf4o+ALXT/+r3vcfoR6Zt4jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dnd7EkvOx4jLfTthaS5m/rzm5Y3rT/Jlo6OqbWJBPWoONjWlL8KmIKzMkhdPujihg2VF2QjEkIpZM5DVRAxZcz93rHvQWWDjvGqRC2913S3p2JwHhjoIzs35LHMbyXm65SMWhxLsWL/lhW60OQv999zoPK+1PILzeD9u+fCY9/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2Ra53+w; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2Ra53+w"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so4390890f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316847; cv=none;
        d=google.com; s=arc-20240605;
        b=fbJOkw0V/k2E3C5w1va/pta9PMS3nWXzHJYb0xykouu4u7t8ltPcBQb8P9JvfQt5qY
         UvwTZ33+1hzbhtXBh741h/kTBvc5aE2SpftzNHWy4u2qvsiLEPj1iaykqPdIahdI2oh6
         LtZ2mgK28/7v8qm8J0Acoo+sgJ2xLiu/fX07nwxJKmu0irO+NkLdqpmQjxeFYBCDEFbD
         jvmWwaJ5LlsdkkmkdCKb0h+2HmIhpMEEE6BW2rcQ8ZNyl2UvcWFUo9K35Cjz8RVHzLqZ
         0yxtfWZVl0CFtA742V8GbD9xj540YM8L/UDlOpEhzG5KSRffLk3NTLbD4qjSqqu5NB66
         rCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E05DQ8tPZZh1ybJbqcTlYE6PvwcKKcHXiXsgT1UEl+w=;
        fh=m2y03ENBI/Gd3hAXQJce4PGJWoE3OjpWevADckSQoBM=;
        b=VuwlepCdTgDws9SQfKvedoLpfe6KevDuy6/HMFrHcAH1gvQx+YMyUZTwMumG+BcywU
         yxwgcj2b1a78LH68ZazdCG96KPw1PIzOcjRESnbh2OnnmOKcz8A7C0jfMsUuc6d9MN5w
         0Kj5OFxhSk/DbPkyxRU/lcrSsd5o4bB56domNNy6UjFE8R9zSCWOJ48Stb9ptlfEckJb
         ca2JZSPy4BZaV3fWdeN8V4qwC677D8+ME9h+NAReF92na7k+XgyYL8Z8r42FPmNywqdM
         XBEt+WY4xLrCPkyO825fiEMZtoy0HvgbsjcnODKtHq+CsCAhGdhIA5lra8oxonWrFNrY
         AHqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316847; x=1774921647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E05DQ8tPZZh1ybJbqcTlYE6PvwcKKcHXiXsgT1UEl+w=;
        b=R2Ra53+wTqe4fKM0YowcYvj30AagsiIUCnlyrF/Byb9Z7ZfYIYs1cOyvsTQT9KtaBe
         F29JEmIo0dGfEC7ePCHm+PQ4vd5ldCNJcs83CyZxvRRNHOjFUDm6mNIEG+kGrPN80ZYo
         H6JKZBXZhk9U7DUdGSNIZmEAu3gRAItOfACzkPfXwh6U9SAWZMeYejoOrM0cfSAyALfD
         vKbkSp9hkqQfn7X6YRR2++cVG88E2eotlNTmD+owYMGDwBl0aoXfDhomZZUjGgsOPoew
         s/B/SeMJL12hyK31kgSqu8WBOjnMmZl+zIDXL5f1gLFgdwX0Dr0xhVWDH4PqAo8nSRrT
         5nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316847; x=1774921647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E05DQ8tPZZh1ybJbqcTlYE6PvwcKKcHXiXsgT1UEl+w=;
        b=ToST6jMGdnYPEdIIZPG9Ejm4L8YM3slzduCnyGQofyfKlZKV6/eA39BduClTZxSX2S
         dsSGBirX6c1qQoxkh1Zj2ll4kidTqIxD1sV/pepxnF6g+3Zj8jb7t8FAPZqYN+mIypla
         5OyhLg2yLgVtqZvEzBDnVP47ecwAps2bC39Fl0WO6EyleywIsupSzTBkYaHJLi5UQ4/T
         nEScTwH+zLi1hb8qFm1Wib0cBb+Cq6XWnX9ITWqiux4/LqSuKS0erB9VQkxUe6uWH8Pv
         E1sShUUcmKUbqKNmZfs5oaCciCYWkPQ8ruy4UR0JWfBHzXfRntfAJubjswvnpyLIGC9L
         PvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxYLLimYCH58PNfKESXG19UkY4VfgScoYPT9MuUPZO3KYs8bSBZznancsarkRI3D8Ns4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8iA4EtvPUd6Cka4y5dGx00RRrfjqbtp2zvgAlj13L262ZZJ8
	vVHtr1KRFXFfGr68QYV0IrMGYpYKcrK5inFOwmTHTA7WzDql2n294XVRYMpLZubQmFZ6/V5lFAj
	ffLvHo+kneco9IxxfOVR5V5htWfVjgZk=
X-Gm-Gg: ATEYQzyU1CVDWqYr1xTe2bwvE8pAsuv1iSjz/EDGemoU9+hisrevgyFDS6iFNK1wqFm
	glAjT9Mq9MByrVGflTf9hzFcddpuiTAj2lH+DUcerxO8r8PxZcug//PJrpit+h+ho2zCl4eoNRu
	mtMflWJ/cSS+KJmhSnpd0yMf/TxjlT1FiqDJijLfGEyCgAXr4MyqtYKGOgAgbXaKFjZVq/NU9iD
	MhwLRyJrm+ZSpzGt/VLD9nKM1UWvZhuHsZ2b/d5xU96nhVNuOgLTK3+A21jWlxL/xL1/T4DFs57
	ADMa9wbMuTCzqwNnMRqB900xYA/j9LojZ52f42pQIul8yNmTo3PNMq6FN/Y=
X-Received: by 2002:a05:6000:5c8:b0:43b:4951:6b37 with SMTP id
 ffacd0b85a97d-43b80592328mr2021634f8f.15.1774316846771; Mon, 23 Mar 2026
 18:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com> <20260316013651.3225328-11-ankur.a.arora@oracle.com>
In-Reply-To: <20260316013651.3225328-11-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 02:46:50 +0100
X-Gm-Features: AQROBzDT8zHTe-cnXwc3ToHi1r8Z06VC2JgJudU67Ap-gCTlXPytLAmMbqYbD7w
Message-ID: <CAP01T77qL1SF_-FFjbT4wJaYAe8g3XRNO0pyPs9c54qdcN5MGQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/12] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, rdunlap@infradead.org, 
	david.laight.linux@gmail.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 02:37, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> Switch out the conditional load interfaces used by rqspinlock
> to smp_cond_read_acquire_timeout() and its wrapper,
> atomic_cond_read_acquire_timeout().
>
> Both these handle the timeout and amortize as needed, so use the
> non-amortized RES_CHECK_TIMEOUT.
>
> RES_CHECK_TIMEOUT does double duty here -- presenting the current
> clock value, the timeout/deadlock error from clock_deadlock() to
> the cond-load and, returning the error value via ret.
>
> For correctness, we need to ensure that the error case of the
> cond-load interface always agrees with that in clock_deadlock().
>
> For the most part, this is fine because there's no independent clock,
> or double reads from the clock in cond-load -- either of which could
> lead to its internal state going out of sync from that of
> clock_deadlock().
>
> There is, however, an edge case where clock_deadlock() checks for:
>
>         if (time > ts->timeout_end)
>                 return -ETIMEDOUT;
>
> while smp_cond_load_acquire_timeout() checks for:
>
>         __time_now = (time_expr_ns);
>         if (__time_now <= 0 || __time_now >= __time_end) {
>                 VAL = READ_ONCE(*__PTR);
>                 break;
>         }
>
> This runs into a problem when (__time_now == __time_end) since
> clock_deadlock() does not treat it as a timeout condition but
> the second clause in the conditional above does.
> So, add an equality check in clock_deadlock().
>
> Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
> the spin-count used in the amortized version. We only do this for
> non-arm64 as that uses a waiting implementation.
>
> Cc: bpf@vger.kernel.org
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
