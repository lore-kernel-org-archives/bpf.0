Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0284AA035;
	Thu, 24 Sep 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269079; cv=none; b=uNmdqzwzf4To++rR1uvmycNXZmVlf2xIak+ievDT4/3Fq/YFEgB/fQMol6eRubEQZCESCkIaOuCcrhb83AxTv8l7/RzA6FP+nL0r2CgKPkYVHV13QmJJPer/7HRpsB6CMYSvNxsMk3+daPWzq4hsfSu8ZyOPVgiV2D2UJgg/FrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269079; c=relaxed/simple;
	bh=1kaLkFxrgcauaJ9CU9EUWzsWBhexjjiTY5Agq+l/Jng=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cQwtg3r2/py1NPPTeCt0x5ZghTLbLBmI2+sowDf4x6bomyvM4y7b+njCgbt3Pper1ouS4Mx9MuVSulLZvhcGNyZu4Cwb1yWu86iwOjb7j5SknY32NoGUUbqwiy9asf3jrzDSQYwZ+QNhR3JsNx+mZGhWTLpj2dvSf4a+++FQO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEFrT61o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEFrT61o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E9D1F00899;
	Thu, 24 Sep 2026 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269077;
	bh=1kaLkFxrgcauaJ9CU9EUWzsWBhexjjiTY5Agq+l/Jng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WEFrT61ojUTqGGhXUPJcusVLhUxf92U513U6uMx54tpISVIodsKxYflfnTonJ9bcB
	 GtpiHbEbOou7ovC3rqn/qsiJJt4lS5scavQdmxyrPm6M+DiMA1DkfPrX67YG2lCshI
	 UQPQmdvuc4CiFslNVu5eJIQSHqOeFzTlFdAAAFEK0pqu6j2d00RkiisAD8v2oqEurp
	 oU5gzAVhPO3ohicjqw+BOUngKsBX05UlTb5BxQlfbZU1wuFSU1WQ6qDhUbBOEYur2h
	 pP/JnQYCsxHJm/Z96xoQ4dfGG2Rufds1CbWBuDKBsFPq11NB3cACfyTthqFWxP+oqT
	 JuMGYPq0CXDZg==
Date: Thu, 24 Sep 2026 06:57:56 -1000
Message-ID: <6ae9d2d1972afdedf0117ec01aba783f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: arighi@nvidia.com,
	bpf@vger.kernel.org,
	bsegall@google.com,
	changwoo@igalia.com,
	dietmar.eggemann@arm.com,
	etsal@meta.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	yphbchou0911@gmail.com
Subject: Re: [PATCH] sched_ext: Place dsq_vtime next to dsq_priq
In-Reply-To: <20260924161446.3039726-1-usama.arif@linux.dev>
References: <20260924161446.3039726-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Thu, Sep 24, 2026 at 09:14:46AM -0700, Usama Arif wrote:
> scx_dispatch_enqueue() calls rb_add() for a vtime-ordered DSQ while
> holding dsq->lock. At each level of the descent, scx_dsq_priq_less()
> loads the visited task's dsq_vtime, and that comparison selects rb_left
> or rb_right from the same task's dsq_priq. In the x86-64 benchmark
> configuration, these accesses fell on different 64-byte cache lines
> before this change, so a cold visited task could require a second cache
> line fill on the dependent descent path.

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
