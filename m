Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B33BB101
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540926; cv=none; b=ZWbZAMI7KB2KoWpYs3D6VqWYp0B993hs6Tdx4R7LVvg5HP5KTf+0cDE5dH6RGt++V3X2eN41W9vjXX5XLSEIu/2J6n1Um9DVWF+NGrw7hF2Q5Nd+hPsnZOAEvM63a/b5f6Yl/EpNM670E6BM+idbRcAnizd03wi5q1Y+teMnqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540926; c=relaxed/simple;
	bh=oCY/2/+jF6mIHacSXk5AtEqhXekdHvFLFo2m7ReRGI4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n2j7a9AHnrC3y7PWus6+oUXDcEAEW2dwZ5xCQCZ83wjrhAfvSKbrH+JC0GfBAulx5lHy4rRLN5a2tOUxLq2DgnQ+zbhOM5yZ8laEx9W7Rk1st9xOrTnuFeMlKtoygM62sutaH8q5RMopEb29GSFE+rNbxqBQvKI1n3ObVPxvivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R84iefhv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R84iefhv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C006A1F000FF;
	Sun, 27 Sep 2026 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540924;
	bh=mCa3tf9NRwPdso2cJeWWqMc0A81zHMg1f6fKwqRmt2M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=R84iefhvYfabouqGZlbbWv9S20KAhpLifEoTkTpy2/cvXZeTOIlLOOtQZqHNr/NSv
	 evhqZ/jq1E3Z8loT8jjUsNMbLdKelc3HVOGkN176pKqWx9WtgfMaUCIECDk3EdmEZ7
	 azT6ZhjoUz2F6/BWVSdc3Av+MCVRTUIzsu/dkQ+jpaQzOtx4824XFrTHqwP3txSJtQ
	 EXqo3AAo3JowaaW3jVuL+QFclHcvfTXYZQ3urPOqiN6pqWY8/obAYzT5ieYvFcUyUL
	 2TeplDEkV6br5ssDLMuraksWGGPe7703xOQZmub6yTAcfTmNpvx3fHpElJdodDt7x4
	 +mgdtwW1WYgQA==
Content-Type: multipart/mixed; boundary="===============8033139815241500174=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e8bd217fc4331db08cc619ee438601ef4d40e3a844e127718ccac64dad4edef@mail.kernel.org>
In-Reply-To: <20260927120406.1041915-3-xyx2021@mail.ustc.edu.cn>
References: <20260927120406.1041915-3-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: Test borrowed iterator result lifetimes
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:28:43 +0000 (UTC)

--===============8033139815241500174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test borrowed iterator result lifetimes
>
>     Exercise borrowed VMA results before and after iterator advancement
>     and destruction, including NULL next, trusted fields, and a FILE
>     dynptr that must be discarded before advancing. Keep positive controls
>     for using the current element and discarding the dynptr first.
>
>     Use a test-module iterator returning current to verify the explicit
>     independent-lifetime exception. Retain controls for RCU-protected
>     results. The annotated programs check verifier loading and diagnostics;
>     they do not request runtime execution of the added programs.
>
>     Assisted-by: LLM
>     Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

This patch is part of a series (patch 2/2) that adds test coverage
for iterator lifetime tracking. In v5 review of the series, Alexei
Starovoitov requested changing from opt-in (KF_ITER_LIFETIME) to
opt-out for iterator lifetime tracking:

  "So all four iterators that return a non-rcu struct pointer got
  the flag and the only one without it is the testmod iterator
  added in patch 2. With opt-in a new iterator that forgets the
  flag gets the same UAF. I feel it's better to do opt-out.

  pw-bot: cr"

Reference: https://lore.kernel.org/bpf/DLM8JHZUINUJ.3V54PKAS0QV9B@gmail.com/

Amery Hung also agreed with this approach:

  "Let's do opt-out because that is the safe default behavior."

The current v6 series claims to implement opt-out using
KF_ITER_RET_INDEPENDENT, but this version has not yet received review
feedback from the maintainers who requested the change.

Has patch 1/2 of this series been reviewed by Alexei and Amery to
confirm the opt-out implementation correctly addresses their v5 change
request?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346633318
--===============8033139815241500174==--
