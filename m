Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E157364953;
	Wed, 24 Jun 2026 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302927; cv=none; b=gpJg+YjtdUJFsbAFnZ4A/NTxu5muXIHT7Z/hsEV2IX86Sn6cYOfRPR5wSFq9xq0ziunmlwWiw2qPE9eb+YfBzL1jUISfYrJsvpFEYxhtwJokX8EaV+5bpHNioGNoTI9b453tgxcDNSRTSArAklUABozEImX0Xfgk5JcnabCdaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302927; c=relaxed/simple;
	bh=CDl9aSD3ugQlRL37zl+QaFdd9YxDin8pUVH14PTQCck=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=h/FVlwkvnHY8mtwRUUWYSjK/DLL4WYTG82BEIMrhqSmDVdt5c8MlyMy2hJlA2xPwFccHo6O0IpaePfn9Hm3WBBpYfsTVEPmBHijQs6DmU0DYYK8/nXbnTOZ7g1sq66DqT/nuHyQGyT14GgjP9sqSpO+oEPn+WW5xXRLQZJwkrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXdKr9gC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXdKr9gC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DCA1F000E9;
	Wed, 24 Jun 2026 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782302926;
	bh=k1YOOYgUKjDHmumRQDfq+iiMmIY7BMEottbLr4QMTtA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YXdKr9gCJmv7MJK9CnCFNIkVoAK8focLZmghaVam/Jr2toevBHs750tHf7mnXdCcZ
	 XlKwL0eZtz5AHtxcI25YWrCv6TrqlV0CCZws3OwpA9e7cjUqL/42wTVaAuoEvrtyHm
	 b81I9FJ+3pCcodcCvqS6YzXGojGFax8ROuz2Sj9TVLDCeoIk/dSjFjBdjwEv+RxyOF
	 nxVfR2q8SHxMMQ0/WRDpyXh0T+opblWc51fHsQ5WRcUl99f2ShMduI2rpmQInbqMSB
	 8xNeRjFIawpNdBFYMvzy/rCMYROZhTMZmeKs5oRdB6tqumV241zeTusGkM7M75Gb9/
	 G1CELpvSoEnHA==
Content-Type: multipart/mixed; boundary="===============3393112613050661942=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e749abbed0ed9570db275c859933a73faf5a4ba83643f102e7a45f6af7b6827@mail.kernel.org>
In-Reply-To: <20260624111837.889209-2-sun.jian.kdev@gmail.com>
References: <20260624111837.889209-2-sun.jian.kdev@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover link info metadata on ENOSPC
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,laoar.shao@gmail.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,sun.jian.kdev@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 24 Jun 2026 12:08:45 +0000 (UTC)

--===============3393112613050661942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover link info metadata on ENOSPC
>
> Add a perf event tracepoint link info check with a one-byte tp_name
> buffer. The query is expected to return -ENOSPC because the nested name
> buffer is too small, but it should still report the top-level link type,
> perf event type, cookie, and real tp_name length.
>
> Before the fix, bpf_link_get_info_by_fd() returned -ENOSPC but did not
> copy the top-level bpf_link_info back to userspace, leaving info.type as
> zero.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

The commit message refers to "the fix" that changed bpf_link_get_info_by_fd()
behavior, but there is no Fixes: tag. Should this carry a Fixes: tag for
the commit that first returned -ENOSPC without copying the top-level
bpf_link_info?

  Fixes: f2e10bff16a0 ("bpf: Add support for BPF_OBJ_GET_INFO_BY_FD for bpf_link")

Since the test exercises the perf-event nested fill path specifically, a
second tag for the perf_event fill_link_info support may also apply:

  Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28095789600
--===============3393112613050661942==--
