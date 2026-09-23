Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3193F9F50;
	Wed, 23 Sep 2026 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206076; cv=none; b=CwD+RpOcNBVFOSVEhLHU+4UpInVFVqWDLNiSmP+ORN+LQvixmA8lwVeIN8wFJiDI6mEfOqJ6a6+McAO7atyr4JaWXhw2oi+16/2L5GS0NE2wzCKX6ivUyKSemh+3GvbfEaSYy5yC8BZLjinpjdy21xkzQt/djUI7WsbxNJiDmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206076; c=relaxed/simple;
	bh=gDbjAZ45itE2XS2BUFGq+oHEFGj4NKIZIDSd5o7Xw20=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iWrp5gsgW4LDMdk1khyMIHuvW/q7KQoJFFQ/8QqJDE4V1hGMemvJb35o2OpGs5hZFRRwlT9pvaH88Je5fa7/8txrehMjVIfbnEl9FV/HBnEFvpKkSWtAtNoN+bazfGl+Fjm3D7b+NpIXcIE8qbSHZlxmvA/LwtHBnyI11mJj76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAq06q2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAq06q2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1BE1F000FF;
	Wed, 23 Sep 2026 23:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790206075;
	bh=gDbjAZ45itE2XS2BUFGq+oHEFGj4NKIZIDSd5o7Xw20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SAq06q2j96lacE0s/WMU7cQ2PJbVsatqgNGFD4rcj6szkgekQf8r2vv3S1Tu4oVp9
	 MgoodUiPUvGc+jM5C07+BtVOqE+4F4kNia7osmtcLRKK9kmEzPny5sUxHkZCPgdkIG
	 Vt7BeMFfM+m9w13eILKgLas9PqrI/b85bgJ0g8YTWMsBdpoS4MoL2/HhBRg6BgKbW2
	 fZgLxG53h1VCMgs/vQ7ELgILYCRGTJdpSdniWwYaJyttMjNlt1U91eyj7NSBngE4n6
	 fyY+XW/S4aRoa9cTGyDcLfXDnxujRRqeV0sxcIE5SoJig/zVLikstPhuQUwxy8DjxH
	 t+pRkCZ/PR3Hw==
Date: Wed, 23 Sep 2026 13:27:54 -1000
Message-ID: <c21c23f034e82b7802572050cf702865@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: arighi@nvidia.com, bpf@vger.kernel.org, bsegall@google.com,
    changwoo@igalia.com, dietmar.eggemann@arm.com, etsal@meta.com,
    juri.lelli@redhat.com, kprateek.nayak@amd.com,
    linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
    peterz@infradead.org, rostedt@goodmis.org, sched-ext@lists.linux.dev,
    vincent.guittot@linaro.org, void@manifault.com, vschneid@redhat.com,
    yphbchou0911@gmail.com, emil@etsalapatis.com, david.dai@linux.dev
Subject: Re: [PATCH] sched_ext: Avoid relocking DSQ during remote DSQ moves
In-Reply-To: <20260923213444.3231509-1-usama.arif@linux.dev>
References: <20260923213444.3231509-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.4 with the context adjusted (the patch was
against for-next).

Thanks.

--
tejun
