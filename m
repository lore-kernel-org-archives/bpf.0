Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331D35E1B6;
	Fri, 29 May 2026 03:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780026985; cv=none; b=omWhzFpAbFJlqeN24YN0dCheVtCUz+k85THJ2bctxrdYEqcA7xzP2VC0xaEuf4dMiguGDA9cKjk8XZVcyqiPGGrGps+n5qW6ZTIkHSWShEzXIgkdUBhyUYzofP4NHqRQh/2tI0EoCtAMb8VHBGwrJR55Jr0PVHMCLy9m48i8csI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780026985; c=relaxed/simple;
	bh=qVsQ2/9n08ZFnCiznCbBpYcH3eItdKp575vi7vIDvA0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XJrjnzEuGWVtn4TfszVYuPSctO8n3MGXMzAC3OaaCL9VRoy5S0uiZHgjxdsCY4lHS7uP545xI681+LLmer6wBzwcWOtoOGJs/wdMfuecv0A+qvoyzjh9eNQ8wkjo/NyAtb+6vQYcjoSYpD7wLWFeIz+F7yBNbL9esE8fSA1w0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKCPywUs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKCPywUs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555281F00893;
	Fri, 29 May 2026 03:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780026984;
	bh=7kTXNQtQzKALPD1svYOBsVyZcmIFmBt7hjhAaAEt0T8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gKCPywUstP45ezFpQq1o8f7AOtP/HgTUCU17YsPKR9siKklH5kVBqC9/N3ALX9zqB
	 rBsb60bjeBAfW9arSDgk7X8iuTD/Be9mLazBc5+iDjXH62JRSs+7hGt8ObQ5sJkEtc
	 8Krfg3c58MH7AHxeipaA/ZaXLkV8Rgnfq5QkrQOIbmLRkYN1kGuZlQ237N0DWZ2MNN
	 CKktUNge1+xzPdX0yfyaplLgVDJoWOL9yWgxiX4rqgFvmc9mbOhrdNu+8Ndg88LQ6X
	 JvYMWy2kHSP8guqoJZlhvLvVLtfmdwT2y3NE57BB/MSVGVFxsabf/jdMcR+1D1EMGN
	 RF4Gq9OuMYp+Q==
Content-Type: multipart/mixed; boundary="===============8176134022569863166=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <12a9251e9f1a616fc86f4a2b6a87e547d75f820ce517895cdbf87bae81c970f1@mail.kernel.org>
In-Reply-To: <20260529031026.2716641-3-dawei.feng@seu.edu.cn>
References: <20260529031026.2716641-3-dawei.feng@seu.edu.cn>
Subject: Re: [PATCH v2 2/3] bpf: cgroup: NUL-terminate replaced sysctl value
From: bot+bpf-ci@kernel.org
To: dawei.feng@seu.edu.cn,martin.lau@linux.dev
Cc: emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kees@kernel.org,joel.granados@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,jianhao.xu@seu.edu.cn,dawei.feng@seu.edu.cn,zilin@seu.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 03:56:24 +0000 (UTC)

--===============8176134022569863166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> When writing to sysctls, proc_sys_call_handler() guarantees that the
> buffer passed to proc handlers is NUL-terminated. If
> bpf_sysctl_set_new_value() replaces the pending sysctl value, it can
> hand a replacement buffer directly to proc handlers. However, the
> helper currently copies only buf_len
> bytes into that buffer without appending a NUL terminator, leaving
> downstream parsers vulnerable to out-of-bounds access.
>
> Fix this by appending a '\0' after the replaced value to restore the
> expected sysctl semantics. Since the helper already rejects buf_len
> greater than PAGE_SIZE - 1, there is always room for the extra byte.
>
> Reproduced in a QEMU x86_64 guest booted with KASAN while exercising
> the sysctl replacement path with a cgroup/sysctl BPF program.
>
> [ ... KASAN report snipped ... ]
>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

This fixes an out-of-bounds read in bpf_sysctl_set_new_value().  The
missing NUL terminator after the memcpy() of the replacement value looks
like it was introduced by the commit that added the helper.  Should this
carry:

  Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpers")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26616337824
--===============8176134022569863166==--
