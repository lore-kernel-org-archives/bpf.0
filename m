Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE038551D;
	Wed,  2 Sep 2026 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371299; cv=none; b=Wo8Oh3UF5Kbvn3RVgtAxGz8fYEYd94mP2LIfaIoKEvZrJFhOeju2+f+Z1q6ephGBYjj/JSAtDOZsqSCq4fZvTy1a7qAGnIS/LATCoFzTDUgZCAxT02/jccGZM9foqno5RHJv9xfZcrSouLWcOGo6UMJWiSm8hdIpRx/IwTRj8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371299; c=relaxed/simple;
	bh=vPmsoIF7ixKnh5khR0zbHIXVjt+NXsgyyIJm81TB6pk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=P1K0qFrEM2Z9TKA4EFTU/lsqDwTkBT55dahYReetWqC248mJHD7gLXorJ3PP6wTLfTZKrI7QqPw00G+76hHD0rmQrmQF9v55uF14WbsMJxqvK8Xo8ZQBXbnsueDVUwWRfT9Dm1k4GzJq5KIW1+m10+7vXOvWVN4gbzy5pYGK06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arheDYgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arheDYgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D251F000E9;
	Wed,  2 Sep 2026 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788371297;
	bh=jbM1AZIWfVPk3R5iLOrXk3OwomZn57qgixjPv6pYWRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=arheDYgT3Rb9jHbvU7pjNglMZhG0dUBCxoE4HkJ18p28+FII72nCIxXg7z4GjL2TS
	 ZW3Xk8RVDKCxFvRXakxkU0gfT2Zzy63LRgR2dqz3Ko7+hIyl96kLqjTSE29IrO7T8T
	 hEZayjGg1mJzTfsqU92zuuut5ssMNyI2zLnTMt9uYA7yLy+3EDSISaeLlDTa7Vgjtb
	 vuAzHq3Hz/kjjAGnTutGdYPQO+0wTKdZDGouNQT6zWFtcoUBrVZRdEvoJoL3+nk65A
	 YxC8CpRndx5Y0c+BvHnXufkYyMPVkzxV95NrIFZfhytNKditjPiAhie9RL8xwH6Onl
	 a0r69d5nw4kFg==
Date: Wed, 02 Sep 2026 07:48:16 -1000
Message-ID: <a8b5c606e0e52a93f8bee7e6d6a7f78c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	michalblk@google.com,
	emil@etsalapatis.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cuitao@kylinos.cn
Subject: Re: [PATCH v2] sched_ext: don't deliver duplicate
 ops.cgroup_set_idle() for same value
In-Reply-To: <20260901124347.755904-1-cui.tao@linux.dev>
References: <20260901124347.755904-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> ops.cgroup_set_idle() is documented to be invoked when a cgroup
> transitions between idle and non-idle states, and scx_group_set_weight()
> already skips value-preserving writes. scx_group_set_idle() delivers
> every write unconditionally, so rewriting an already-correct cpu.idle
> value feeds the BPF scheduler a transition callback each time, which
> toggle- or accounting-based schedulers miscount. Mirror the weight
> guard and only deliver on an actual change.

Applied to sched_ext/for-7.3-fixes with the subject capitalized and the
new comparison changed to tg->scx.idle, which is the field's name there:

-	    tg->scx.sched_idle != idle)
+	    tg->scx.idle != idle)

The rename to tg->scx.sched_idle is on for-7.4 and the for-next merge
switches the comparison back.

Thanks.

--
tejun
