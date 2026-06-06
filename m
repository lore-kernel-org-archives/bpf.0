Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CA376A1A;
	Sat,  6 Jun 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780739883; cv=none; b=cmgJqiHPhgpjB0Eoeo/qABfNNQmcdxLEy3l17dFSWHXq3O4Xjz9UM3GBrFAsHUvQAN74i62GSVuQMFrMkyNHgKrMLbD7Tj+PpJgEzWdX5JA/w4EtEqE5E4CgP6bOFxI3K1J7z0AcgkEmg7mELPKR4z1zZWKTuRgidU3x6gP0GUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780739883; c=relaxed/simple;
	bh=CellXVqeRWhFNMUarLq7kQwqiF3f3ews2tRRHgwsKRM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lzyIky9GsQXxwW1nRE71JRB4Y4Pg89kFiZx8VT4An3anAQJWxtRgzftddzIyi6aPN9iJo8IYHZD8zECiOAQnInEg/BowNQLQfZ+UHlafRkJx0vnqQfhVP8w89v7p0hAjelhS7/2V9kOrn0E0hFa4SWCuZlecVaFCbv6ddwIKLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyqP9tra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyqP9tra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071B41F00893;
	Sat,  6 Jun 2026 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780739882;
	bh=74D38Xn/Du0FACRSGzdlEfwOjvGfhOPWoQNKCM+Otc8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fyqP9tra1ZEKK1ECg7o4am5PRgsBcs5Q+wPd5A/LOl/qa+pIyc7cqj6VuObu/wvB7
	 k7O9/f1XHU+k0Zunl/16si+nYydWrnzpjiO0IJ0GbqhMLTbSc3SUUwRTTcDcEG4DEu
	 9aUWNKKIXCfFf65aMqdKXrRyv3AefC0qCKfD+/J/jKBQr4meF0eK/47lh4c4GNkR/a
	 ZwnY7URMC4axPmKvdomE2Dg7SZEK3sNOei2k9mrDADQbMioQ7CUfbiY6rvZLqjUYd5
	 8dyi/YI6Aww7brL/vBC9bBQIqHGYATDCfBxSU9JUJ2skYav7phzY08eusQklDb7piS
	 buxGPq4gOg0/A==
Content-Type: multipart/mixed; boundary="===============6514777531700268933=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e6200419922b7cbfd94a9c019a1cef12697d3f32dbe1d660eab4bca79ae9ea9@mail.kernel.org>
In-Reply-To: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
References: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf v3] bpf: fix NULL pointer dereference in bpf_task_from_vpid()
From: bot+bpf-ci@kernel.org
To: rhkrqnwk98@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,juntong.deng@outlook.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  6 Jun 2026 09:58:02 +0000 (UTC)

--===============6514777531700268933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3c..226c31ccb5d6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2912,7 +2912,14 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
>  {
>  	struct task_struct *p;
>
> +	if (in_interrupt())
> +		return NULL;

This isn't a bug, but a review comment on v3 about this in_interrupt()
check does not appear to have been answered.

The comment noted that in_interrupt() evaluates to irq_count(), so it
returns true not only in hardware and softirq context but also in normal
task context whenever bottom halves are disabled, such as inside
local_bh_disable() or spin_lock_bh().

Would this cause bpf_task_from_vpid() to return NULL for a valid BPF
program running in a BH-disabled task context, where current still has a
valid pid namespace?

Would using !in_task() instead filter out the asynchronous contexts
without rejecting BH-disabled task contexts?

  https://lore.kernel.org/bpf/20260606091941.1803115-1-rhkrqnwk98@gmail.com/

> +
>  	rcu_read_lock();
> +	if (!task_active_pid_ns(current)) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
>  	p = find_task_by_vpid(vpid);
>  	if (p)
>  		p = bpf_task_acquire(p);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27058795186
--===============6514777531700268933==--
