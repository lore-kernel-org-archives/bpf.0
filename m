Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FA35CB71;
	Wed,  4 Mar 2026 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665348; cv=none; b=n/yuNtZJzbBRhFHZVNw/K8y8DjMiCqbGDVDq+0D/5yU4DM1nZHZjs3ftwXQbg7N0DS7SwGQjTdwf4rCumFf3gAgLYt01Roql94kVrYbwqbRoH5mgNeKs+n0qdB04D4eHlxZP7lnyna8BIxmHkTRv/wZCNexMugAn9c/SV2cA8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665348; c=relaxed/simple;
	bh=7+NHm42qQCXJ5YdXA7l3Jg3imXK5a8YgXfmMaKPzsbM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dG1mmFyKCXgum3FZ2LfZZAgtyD08jIoeEHAPqRI7h631NinQsZp491JAnAaCFt7C1zAQh3p+sDZUVXTo2bsXknXFNhw5d0Tjq6o7JLltFHZSCbudymIsmeqdOgDpTqtCx2cmKBUYC6WFaM6lqW6lgYgcPdDICWclWaXVGCXt7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbjlg7Ak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbjlg7Ak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64585C2BC86;
	Wed,  4 Mar 2026 23:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772665348;
	bh=7+NHm42qQCXJ5YdXA7l3Jg3imXK5a8YgXfmMaKPzsbM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tbjlg7AkF/dTecns+ZFR5VcXzqYdLWBLmu3ukPxAtIxOb/xj948mVx8ulP+S0BsTl
	 HwjQrv1jVnxaRi0kgEb/9OFH18gPkFVwJEu26MFrtnlWuOHW5ft1Oa8nlMUKBcourX
	 ymI5nOWb8Fe4eF3UIZBMVT2nVTlTiahIl92v2VFXNzHUIQTiU2vRyATZwKkj2qnfTZ
	 IRgj/YWPdMQ9TRxwfCCFLm+xOfbc1s79iqq88NLIONn5Nbj4f7ns0X8LlT9Gz5c0M0
	 8XCuB3fKA39n8jrhSpMhLdZDsxumPSuYI2Fb95LgMlWxEQUJNUw+aVbqR4UOXb1VTj
	 GKO19fIY6ARdQ==
Content-Type: multipart/mixed; boundary="===============4401157593288407112=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28376b19ac32833bc93e5688dbb271724f84f19aece2f828c7ca56bbd9706a0f@mail.kernel.org>
In-Reply-To: <20260304222141.497203-3-jolsa@kernel.org>
References: <20260304222141.497203-3-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 02/23] bpf: Use mutex lock pool for bpf trampolines
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 23:02:28 +0000 (UTC)

--===============4401157593288407112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -99,12 +127,12 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
>  	 *   cleanup_direct_functions_after_ipmodify
>  	 *
>  	 * In both cases, direct_mutex is already locked. Use
> -	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
> +	 * mutex_trylock(select_trampoline_lock(tr)) to avoid deadlock in race condition
>  	 * (something else is making changes to this same trampoline).
>  	 */
> -	if (!mutex_trylock(&tr->mutex)) {
> -		/* sleep 1 ms to make sure whatever holding tr->mutex makes
> -		 * some progress.
> +	if (!mutex_trylock(select_trampoline_lock(tr))) {
> +		/* sleep 1 ms to make sure whatever holding select_trampoline_lock(tr)
> +		 * makes some progress.
>  		 */

With a pool of 32 mutexes, the trylock can now also fail because a
different trampoline that hashes to the same pool entry holds the lock.
Should the comment say "something else holds the same pool lock" instead
of "something else is making changes to this same trampoline"?

Similarly, the sleep comment says the holder "makes some progress" but
with a pool lock the holder could be operating on an entirely unrelated
trampoline.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038
--===============4401157593288407112==--
