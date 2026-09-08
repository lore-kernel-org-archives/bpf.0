Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0315908B7;
	Tue,  8 Sep 2026 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888094; cv=none; b=EkTEmEesCfNu5D9jXrHLxZaBw6dnaSQ4zaZz90PS8hbdK+9VzrhmQjzlylqTV/4/bAP0TUyfoqDKxDwLA0KRTr5ePSqCDP3SIr+ieYR9Yc4g1M/K9HEOtVejhX9gY/HjBsziggsBt79txXkK5oX9UeI/0PI8GcW3L/5TeL73cw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888094; c=relaxed/simple;
	bh=ntd7vMiKDm1Lw1Lbez/LKqlSrMWxg49bhyGdjAem4kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KriQqKFPcUqksaL5oHkIb+DSmHsPya8As8om+xrWnQGvt2o8wCzeljE/a4W8y2gsDCDEqe1HIKN9T82VCuBwLV3xYcLxz6t/oFstPs4M3ySP/ucEkJC6G+4qIOHKFniQFKhfLhnz6o6EmVrFttns2QBoiK4UYLtLFA533OZfdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxkOGuQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxkOGuQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A028B1F00A3A;
	Tue,  8 Sep 2026 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888092;
	bh=jhZ0SShC3oYkzoQzahUEc6hPC67BJJIUyAnVfy10OVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cxkOGuQflBHj3LDc4ZQEbnP7Qrs2DSmnxsOuhKRNxByoq7o6pja7SLIaZGwCckMqR
	 nX9CjN+PET66S20WcJ0dz7k2Mo9XiODiRlkSons8I6wqb8PUyEGORjZEeZznFJZule
	 a06l9IrDKCx8/um0eZRazY1w+IuMYqA36HbqisiQR5Dp8Ad7ix/Jby45FENxXpb5dj
	 JQL3MrKi4wvjq6KIiEyS/Euy2aYlCFvor3LtuNaLUupokUh9NtiKJweI5CZ2Kl9Llo
	 Trtix2IvaMWBfKnWoNfj/0o5DmtZohthaq9l5w+nqj+p//SHrOlEh/Mzx8428b2BB2
	 rF3XSZAgGZbOA==
From: Tejun Heo <tj@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 0/2] sched: fix typos and repeated words in comments
Date: Tue, 08 Sep 2026 07:13:02 -1000
Message-ID: <178888758275.2.6189775612518482207@kernel.org>
In-Reply-To: <20260907064943.25304-1-hemanth.selam@gmail.com>
References: <20260907064943.25304-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

> Hemanth Selam (2):
>   sched: fix typo "upto" in comments
>   tools/sched_ext: fix repeated word 'be' in comment

Applied 1-2 to sched_ext/for-7.4.

Thanks.
-- 
tejun
