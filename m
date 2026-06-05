Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265E320A37
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663215; cv=none; b=OaGX+TgGAQ/OUVpLV54ziN+orVSl3QpyBdciLKdRXx0NCbxl5copV2+SEKD0monsgjahKxNriXgZO2EEH1PmFcR80CEEjxbhlMl+wbxtwhisYY0KrewPtBTIMzv3XyU2mtWhIeqZfGqkgiNIeXe2lD/zBFx8E4kozNnXMOUuv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663215; c=relaxed/simple;
	bh=xSd9kj9XReGahRc16uKhxjSZsyOTeUOycmmcgCKdpcY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d1GGJwFgqjJ3Mj819tH1ycygfXNqmDSCWf2Memn5WIcv+bl5wXMj3Ae1Mad1IYcHYvXnIo5aOnnecJqSQjXcpnimcKgFaOT2upHK6XkmZi1uDKDtlm3112B5te9Cpp0+UF3MFs+K5wtvVSCq/BqQZ/YiCmAzJsQfzxQrHqwazpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MauHRf6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MauHRf6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26241F00898;
	Fri,  5 Jun 2026 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780663214;
	bh=cJexMuPmYhCvgUO+5Aqtz9QG7oESzutlSnh31B2akNA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MauHRf6dqSIcOeaRo1JGoGWVA7DPsaTRL9FIAGhXLv+bd0eYmaK/Jn9Kftdczwp+O
	 ZHsr+O6U1D+LKpYUUw3xcB0I9p69ZqZvdbxTOZNsd1abAWAEmUr7AZn1eL0CCOSX9B
	 F6iM6QZiB8Zu0wnDczT9nNUwq5gh6GE1p1p8sxT4zdzQVeKmseDJu1UcAY4Kcf1fnW
	 dfaZjvvr974BJ54xY9z5Enfj2di4FUbmQuB7rJkwuusmGctKY0HIFJ8nBhegPCcs5I
	 LOgb/rlSW5iM5GlZeRkaK1XvJt1H2l5BD8THc9YAo9LzuVUHCPeEYqcQ2s6z5tQk/m
	 b8kObgIGsdjVg==
Content-Type: multipart/mixed; boundary="===============5498321925662630629=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c9e4188fa9cbb374ade681d6283ec6ecf7c3e0a6dd1f2a2a467319364928c085@mail.kernel.org>
In-Reply-To: <20260605-rhash-v7-3-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-3-5b8e05f8630d@meta.com>
Subject: Re: [PATCH bpf-next v7 03/12] rhashtable: Use irq work for shrinking
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 12:40:13 +0000 (UTC)

--===============5498321925662630629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> rhashtable: Use irq work for shrinking
>
> Use irq work for automatic shrinking so that this may be called in NMI
> context.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

This looks like it completes a fix that was only partially applied
earlier.  The shrink path here is being switched to irq_work:

	atomic_dec(&ht->nelems);
	if (unlikely(ht->p.automatic_shrinking &&
		     rht_shrink_below_30(ht, tbl)))
-		schedule_work(&ht->run_work);
+		irq_work_queue(&ht->run_irq_work);

The earlier "rhashtable: Use irq work" change introduced run_irq_work,
rht_deferred_irq_work and init_irq_work and converted the insert/grow
path to irq_work, but it left this shrink path still calling
schedule_work() directly.  Calling schedule_work() here can close a
lock-ordering cycle (caller_lock -> pool->lock -> pi_lock -> rq->__lock)
and cannot run from NMI context.

Should this carry a Fixes: tag pointing at that earlier
"rhashtable: Use irq work" commit?

I was not able to resolve the exact introducing commit SHA in this tree,
since that history is squashed into the CI base snapshot and the
introducing change is not present as a standalone commit.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27013077824
--===============5498321925662630629==--
