Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E01473C8E;
	Thu, 13 Aug 2026 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623254; cv=none; b=OePSToewlJcxs9d2lHhnkdpHiHaKHcW2/hEex31ieYB/psrWx5Eqgk7dI/hmdr3+QJMtPnoTTreSyCgSKCm61qp7mcy5yU0oRwQZSZAq7r93JFd9H/1pctXxok69/v/7zwNji0pgJceDz7wz6Wa1Hp0cLX/RS5CRGB6ZWa4PkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623254; c=relaxed/simple;
	bh=gGm/ExMumVKt7nZIyAnbhJNVSX7mnB1sNqKBRgcA6io=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uQ8va3PytAkmA+GYu0vt+xSSRvoLrD7hA5lM0+HYbaPaGh0ztV4+4Nwoo64jfymE151cs+ekaJ2JDaMwbVj1ciIEppFJr0C74x+G7Ez9Kn0vaH32h5p6ice2OT1XE+93yEf7R0PTVtZpYGDpsYmOC78BVe+3179R3vp86kHJYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/aT6B7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/aT6B7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1E01F000E9;
	Thu, 13 Aug 2026 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786623252;
	bh=k5K4v3Oq0c3irSaac+ZD7SGrjbsbpVIzajzCevJVbQo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X/aT6B7q//G3cMARpJy5Q1BY9Bi7tkZZXfn8x7OiZMFgRrWHIqkE5tb08FT8fXN4V
	 D+anhR+njHMVIdeTLE1JnGA256XuvWpcHpwbrrPQHRCyY1kMPPT/EvjC2Ry1y1Irq2
	 1T/ikDIq6TfcXUE8SDX9fsJWC2QbWG6eubFiLZfrlUO0YMNZw0OMb+GBHF1i1DDSlK
	 YDZZhFzHnd9TfywmjWGIvDfWs5egR7M4goAEY+AJekpLvL3UA5MvH41sRAyKLjACIN
	 9wYOkdsk3+y+ozVByGi3gZ4Py3s1u5dL2/Jj8U9txgGHGfS7CvYq+kcYDcuYSZGnFY
	 8zCfDDgoZDagg==
Content-Type: multipart/mixed; boundary="===============0957559469555378417=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c5481925e539bd3a00343eb765e1f50ea99d0878c7ca3858d68d460b7076c95f@mail.kernel.org>
In-Reply-To: <20260813112039.247862-2-maze@google.com>
References: <20260813112039.247862-2-maze@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for bpf_sockopt is_compat field
From: bot+bpf-ci@kernel.org
To: maze@google.com,zenczykowski@gmail.com,ast@kernel.org,daniel@iogearbox.net
Cc: netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,maze@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 12:14:12 +0000 (UTC)

--===============0957559469555378417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for bpf_sockopt is_compat field
>
> Sync tools/include/uapi/linux/bpf.h with the addition of the 'is_compat'
> field in 'struct bpf_sockopt' and add test cases to 'prog_tests/sockopt.c'
> to verify context access permissions:
>
>  - Test reading 'ctx->is_compat' in 'cgroup/{g,s}etsockopt'
>    (expecting 0 in native execution).
>  - Check verifier rejects writes to 'ctx->is_compat'
>    in 'cgroup/{g,s}etsockopt'.
>
> Tested via:
>   tools/testing/selftests/bpf/vmtest.sh -- ./test_progs -t sockopt

This isn't a bug, but would it be worth separating the 'Tested via:'
line with a blank line and saying explicitly that the compat==1 path is
not reachable from a native test_progs build, so readers know what the
new cases do and do not cover?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31696027015
--===============0957559469555378417==--
