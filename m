Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE68357D1E;
	Mon, 13 Jul 2026 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971496; cv=none; b=JSgSykMoijy5QTh1nThs/q3sgf5v4ukQyTpvEm8YdFfJv6g0LdnW5xh1umxohEtrBat/zi90bEI4PWxlVhNj3j/J27iDvlYmvkZbAL9+lVvsVuNTwN6eu9mehZbjA7/627v9qt+MZ0ltRyBAzYnFdDML96BGKgcYHcPZVdjSxsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971496; c=relaxed/simple;
	bh=K30J0dLHxxle6noWjW66S805xABSQzqqF0fxU+Z6uRU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Adps+g0wcIawOgKNojC9cAGhLokpfhnLaj8TTBrpyHkFs92MfzstHkoLCiX1DJoEpqb8dl4KlHKc/EZuFf6obp/Q3qytabv84IL3IEnbe3bjEK9Q+byflzkk4WFYwB0gfgCV0si42B2oGSEaYbcslb5wa1REzrDlD3Rt5PXZrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvJYcZlx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvJYcZlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4811F00AC4;
	Mon, 13 Jul 2026 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971495;
	bh=K30J0dLHxxle6noWjW66S805xABSQzqqF0fxU+Z6uRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cvJYcZlx/hP5ce6SpdSNBDNL7FbE10P+dZppOKu+GnPkOFLiB/kxxK0nnqnH8wOZb
	 E8bqsJhuzN448QqvRJuaVohuvEPE4Ju2DtoESTblnjwMh4odrS6l3C8cwQmjLXm9Bk
	 Nl86EZbcheY4asYeh5ID8HrmlB946OAOHol9alZmv/rEWgLQ1l5cQUfU2Q806oTFo8
	 ziMkMDrkLNadwo+T5sCdtBZs5e38u/hmxEDenPrnzI4F5QBU0zf8OlaCyNKHkCzl8J
	 VqoS785ffW+kowxrRJExQAvRjXPQvfoQWEwkpudZjk86IbJrUU3z90Q/ECBwp1yNHl
	 piVM2UoB5egxg==
Date: Mon, 13 Jul 2026 09:38:14 -1000
Message-ID: <be123d445d5558b583b8214ebde49222@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, emil@etsalapatis.com, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, bpf@vger.kernel.org, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET SLOP RFC 1/6] bpf: Support __arena suffix for kfunc arguments
In-Reply-To: <20260713025819.A302C1F000E9@smtp.kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org> <20260713024414.3759854-2-tj@kernel.org> <20260713025819.A302C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On __arena kfunc args relying on the guard region:

This is the arena direct-access contract: the callee dereferences arena
memory directly and the guard absorbs overshoot, like any arena access.
Both kfuncs here read small fixed objects well inside the guard. If we
ever pass objects larger than the guard, the fix is to grow the guard,
not to bounds-check individual kfuncs.

v2: no code change.

Thanks.
