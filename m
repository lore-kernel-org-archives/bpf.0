Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D0202C48
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087202; cv=none; b=uXSfZqqDx52NZpuQhxNHIl6dOxIb8yDBrZDcvfCzAG8E5ehCOzdHCWcZnL5iTYYsWPJkMxWwUZlvc2qafwdGmUsewbCOFNC+RxHXjwCwlkG/agKSkxgf8xqJykrz7Bq/5t+NL9NRziXD8Vgs17t7lF4jxqvSF4nuetjI6xSQ72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087202; c=relaxed/simple;
	bh=5hSwuYzqLHBd2Rbp9pi9pVM76pIigB/2Sd0H5qFJyoM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LB+jP0zAmi8oT84WxKr0a0/lDZon1lA72JH6tHpDmuEYCyPUrCKmt+ztB8kaGhTsWpepkktpSXcu56jGZXnzbMNT64agBvNuAj7qPlo683a22Rl8F6NPluj0zYShnlPjpzt3OypiuR+33uExHCpjsSCo2YELorVGVDzZOmonNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG32wOf1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG32wOf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53076C116C6;
	Tue,  3 Feb 2026 02:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770087201;
	bh=5hSwuYzqLHBd2Rbp9pi9pVM76pIigB/2Sd0H5qFJyoM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tG32wOf16HHLrwTR+/aNUFOxpfdAB4s9aZTNxK6SeffCoGcpmI9y/hKkDShdpq3qD
	 135QbHN/qajKpLcQo20SIY+OtjUX6YO84B0xe2zuX+qvFOAh0qyN7JUsixf2Vhfbon
	 6F9jcv4fL/2EWmPlG/YmHszbmtMSfa01qIJByT4Ydfh0TgtgkjrpIvVJj9dIfOoojy
	 /gRkg2AjXBVZABUuWXQqtFmR8eoaTIi0XLfHrw/wuOKmJnuObGjTZ9GsJGWYq1sB3T
	 5xWOaf6G0fOD327Z6hxya158oMBlb6RJrAFY7VmLlhGI6TZB3ZLW7m6bUgQlhNvC7M
	 ngFuRCnx046Mg==
Content-Type: multipart/mixed; boundary="===============2609981117455602617=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e1a50428767daa8e647fa8fcc19acc59d83cf5c1e3e975821d14b47b94078f84@mail.kernel.org>
In-Reply-To: <20260203022229.1630849-3-puranjay@kernel.org>
References: <20260203022229.1630849-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: verifier: Clear singular ids for scalars
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@meta.com,andrii.nakryiko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 02:53:21 +0000 (UTC)

--===============2609981117455602617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit ca2bffc24660b903cc21dad2f51a3a89f918b2eb
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: verifier: Clear singular ids for scalars

This commit finds and clears singular (unique) scalar register IDs before
caching verifier states. When only one register has a given ID, the ID can
no longer participate in bounds propagation, so clearing it to zero
enables better state pruning by treating such registers as independent.

>     Verifier assigns ids to scalar registers/stack slots when they are
>     linked through a mov or stack spill/fill instruction. These ids are
>     later used to progagate newly found bounds to from one register to all
                     ^^^^^^^^^                   ^^^^^^^

This isn't a bug, but the commit message has "progagate" which should be
"propagate", and "to from one register" appears to have an extra word.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21614542865

AI-authorship-score: low
AI-authorship-explanation: The code follows kernel conventions consistently; commit message typos and natural technical phrasing suggest human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor commit message typos that do not affect code correctness or system stability.

--===============2609981117455602617==--
