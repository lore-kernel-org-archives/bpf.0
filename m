Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14E382F3B
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773438087; cv=none; b=Gs9OwKzw1+lXz4KxvPHFzRXDqyuo05yTXnM6B2cqT3weC3CXnE4GSvOfHRo+SXsVaqBi7HPUtJBdtGOZMc7jsJx+R3a5fOzw9q9D1583TgdrStG/4/nmmeW4ptOZgUXEVgYxFGGNqpKOGu4ybrMmr8VtMyxNXRu642DYy9qBBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773438087; c=relaxed/simple;
	bh=UsQ5Z/H004a3gbtiVVY2qPE/rEufspBZU0Qup2sm2fs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BUdaYin8JubPv0sKIsNAMB1oZAw3xD2kzGbwkRdJj0YShylFatCd2D/fYU7y85xgeZu8gEWmpuemt92aaHmk7ujZKe0XwbbZSNRxtwLfrIJQw9e5mcrn9gk69eaERguycvNQOu0L4Fa6vrPHOR7AHnO4Ya5CjjPWYrFdctyXFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdABMRCB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdABMRCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BE3C19421;
	Fri, 13 Mar 2026 21:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773438086;
	bh=UsQ5Z/H004a3gbtiVVY2qPE/rEufspBZU0Qup2sm2fs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tdABMRCBbFLmNR3yCJFOHDzM9DJR/0fupfhiwl0LwqMNCER8r5wqy9MSVu/zk5oAV
	 1MpnzhzcQQBYUX5djwaTycn1DKqJFn/w5w83RCrvsmiH/+wfwwK4nE0t3XC0yIkH2E
	 xU4PO+dykdr0FDEjvg7x8Ds0kXchkbKoDUVwpnP94s02O22yNtkNuN21Lsmne+Of8f
	 EsL/xTN9p4lZ9s+RleFV17RPMg2lQXsqFy+RWSKqpRGjK/psR4n9E0zdR/ZiOU+UuO
	 3tjJbE6enAKmrwNKcCX5MyWOPoaXvsZNqV2gdeORCSNd5HDGS4jp5DyLXjvPTD7h4j
	 WTaGsSr+ti9Xw==
Content-Type: multipart/mixed; boundary="===============9048695101306002757=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe73e23767361f286a8c2fe0936343c85684390211b831dd4aba9c9eb65c6c1f@mail.kernel.org>
In-Reply-To: <20260313-sleepable_tracepoints-v4-5-debc688a66b3@meta.com>
References: <20260313-sleepable_tracepoints-v4-5-debc688a66b3@meta.com>
Subject: Re: [PATCH bpf-next v4 5/5] selftests/bpf: Add tests for sleepable tracepoint programs
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Mar 2026 21:41:26 +0000 (UTC)

--===============9048695101306002757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a negative test (test_sleepable_raw_tp_fail) that verifies
> sleepable programs are rejected on non-faultable tracepoints
> (sched_switch).

The commit message references test_sleepable_raw_tp_fail, but this
name doesn't appear anywhere in the committed code. It looks like a
leftover from v2 of the series, where the negative test lived in a
separate file (progs/test_sleepable_raw_tp_fail.c).

In this version the negative test is handle_sched_switch in
progs/test_sleepable_tracepoints.c, tested via the RUN_TESTS macro.
Should the commit message be updated to reflect the current naming?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23070834076
--===============9048695101306002757==--
