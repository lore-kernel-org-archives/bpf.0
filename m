Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B52282F3E;
	Mon, 25 May 2026 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727006; cv=none; b=IvK8pYmMeo4HkJo9JUPfULGqyKCnzIvkzv52arnO9pzqueYLffpBQYuF8MdRt3mw0VPGoNpmudS39c6EnSEy8BvhylPNNRZaLA0ZX4U+6R3+XtmJ6m2Au++BObdGFhWVhRsKfy1VgH6q0zoR0U/FkjaCxFL0KwHaWt9v51PEhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727006; c=relaxed/simple;
	bh=8QMEmF8K6+SwfF1T9r1YL3dIwMga2dH+ZBRAYE482RI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Qgl4QQnq+l712iF3wvZ+mbPifRl45vZjD7pmEc60GIPkpecHVu7bQwR/FA3a7eh50wLZcZZ93hAaGMZsV/NeC1U1xaONYfbk2KLryc5rutd47ca1Sls159XL897jmse4tZg2mDUwjCVvTFlB1mWmJ68u2acgrJ+/PJyEpEbLzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPO31xjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPO31xjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B921F1F000E9;
	Mon, 25 May 2026 16:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727005;
	bh=fLvFBz01chHF2Dz6LQXQ4kXGryk0+H6+SSheBDkFVV8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nPO31xjfXTr+zHZ17GaOLYOFmqMckKh7I3WdrvQ/wQadInTOBi2G5J0FJ9ShrxbWU
	 dY1m9wnW1YVLAQ2jSfTjkhgvQ6i1u/wuyHlTPbZSHq41YML8QG52WYGC6+xb94VC9h
	 Xz2fL4iCwWBUPHlZC2Yv7Q00LiZ9shKxIjwtqy7ywPRwUtWiNm4taC1cJtwZlLS6sg
	 MYX/79AJnI87j/I2oxONqZPtBd3BWmqcdWjQM28S9L2ZqtiRz3Pdy67qjVOulJyurC
	 sel7OyxzK8BHjQaxgbfNHgehIgE1l4Z+rk/hdBQ9OIdlxV684kRZ8ITUlsJF+Mfkdx
	 KRg1xKFg4Gtzg==
Content-Type: multipart/mixed; boundary="===============0714806253349847334=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8cff7fda54cee7804535f32b9df53a6eee9d45b00acfac63296e8c4a110e1a0@mail.kernel.org>
In-Reply-To: <20260524114243.259916-1-find.dhiraj@gmail.com>
References: <20260524114243.259916-1-find.dhiraj@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel-doc for arena page kfuncs
From: bot+bpf-ci@kernel.org
To: find.dhiraj@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,alexei.starovoitov@gmail.com,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,corbet@lwn.net,skhan@linuxfoundation.org,emil@etsalapatis.com,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 25 May 2026 16:36:44 +0000 (UTC)

--===============0714806253349847334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add kernel-doc for arena page kfuncs
>
> The page-management kfuncs exposed by BPF arena -
> bpf_arena_alloc_pages(), bpf_arena_free_pages() and
> bpf_arena_reserve_pages() - are part of the BPF kfunc ABI but lack
> rendered documentation. Their contracts (valid argument ranges,
> sleepable-only context, and the set of error returns) are today only
                    ^^^^^^^^^^^^^^^^^^^^
> discoverable by reading kernel/bpf/arena.c.

Is the description "sleepable-only context" accurate here? The BPF
verifier supports calling bpf_arena_alloc_pages() and
bpf_arena_free_pages() in non-sleepable contexts by dynamically
replacing the calls with their non-sleepable variants.

Looking at the BTF_ID_FLAGS definitions, they do not include
KF_SLEEPABLE. While the code documentation was fixed in v2 to reflect
this, the commit message text was not updated.

This was flagged by both bot+bpf-ci@kernel.org and sashiko-bot@kernel.org
in their reviews of v2:

https://lore.kernel.org/bpf/a0b9a09127618cb4e3dd1aae92ef25aab9beb90bd533490ec5be7789420d9ef4@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26409601656
--===============0714806253349847334==--
