Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC649B5AC;
	Thu, 24 Sep 2026 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265889; cv=none; b=VxwGYzKcavmcr6O8bgRvX5IwgeeVp5CH8vtQj7c6KeQkQzL1L4G2D8jvBzEVjQArCCtNzTBoBI7mUHRiu5sAomeofnUTOrjcAi1ustQgsasBGcAMgBk72FuEVSL4dp3NFD622o+KK13SgG7SFJQCYYxVvnfpnvV716tkwD+1tcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265889; c=relaxed/simple;
	bh=ZBZp9HglQOhQKt4dIt+xL6zDV43m4IyQrnOIZRqaQ38=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GnsU+26Gbrlf62plNzS1o9ErI9+xaMSYZ9C9IX8RnstTpun+SUykx1TI6HfLaAfNZCb1Al2ouq/rhiPBdNcav8S2idR9AffHMeER+nZj4x/jl/PXiiP/MgiNpg+en8S6Ju+aKDA86ft/B6635yF9AF+F8eO1jQuHMsdOXflXMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLkfCbBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLkfCbBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE95D1F000FF;
	Thu, 24 Sep 2026 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265887;
	bh=kfqajJnz6Vz4il9Oe5BJNKl83aa4hZcOU5gr4udVkVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gLkfCbBcqHYj08MTCX36R+Sna2nA8MeHJDUVpJEJRlM/a1i3oCMNF7J5duzQIdL/x
	 uIzsHQQUkVq1QL4ZT2HKZlA4EEKIAytQLoT4qIjzVzKWJW28kFAQz8H7AxHLE43itF
	 GmmX46bpPeMMBCsg4HsukB/9oaQlw6Ymn59b9TtnrHMfeh5p9Eldi9xPRQ8wGtDIMY
	 fzMEoZbYIH8yD+C6PADFG3oATJeXxQXmEsrw38YAJbWGoIHkCFX1NI3XY10GzEbHs/
	 BvJvDiKSMi5Qxau19x74sGsL5ONij5sPbTnhHqqyLDTplbIiQI47L4MJPZ4+U8FlLW
	 aNnoud2dLT+GA==
Date: Thu, 24 Sep 2026 06:04:47 -1000
Message-ID: <9dd9a20323b92268b57c4edd0be094ab@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: arighi@nvidia.com, bpf@vger.kernel.org, bsegall@google.com,
    changwoo@igalia.com, dietmar.eggemann@arm.com, etsal@meta.com,
    juri.lelli@redhat.com, kprateek.nayak@amd.com,
    linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
    peterz@infradead.org, rostedt@goodmis.org, sched-ext@lists.linux.dev,
    vincent.guittot@linaro.org, void@manifault.com, vschneid@redhat.com,
    yphbchou0911@gmail.com, emil@etsalapatis.com, david.dai@linux.dev
Subject: Re: [PATCH v2] sched_ext: Update scx_dispatch_dequeue() comments
In-Reply-To: <20260924130503.853919-1-usama.arif@linux.dev>
References: <20260924130503.853919-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.4 with the following tag added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
