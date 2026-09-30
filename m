Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B51FDA61;
	Wed, 30 Sep 2026 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729945; cv=none; b=c23MWbtDaKeawfu+LDmteJK5vjfOjFdwE7J+d89bPWu5vY7JJj+jbwV7+DiY+eeUjbfWC58OwIpdLxoqNXXjWgJ3tceqynIBB7NsBTOafPKi2eeH+gbBIs0IOrdfEyelXYsH6p2+m37DYJaLfwUGq+bxRoj6d+cmJIKZVzEaSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729945; c=relaxed/simple;
	bh=qx7lmYGSdJRJeo3RiDyeINkO8lC825afuGcmSQbV+qk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VRRiYIIncSRkIby0O0WLTvrqpBwi/e7tgNCf6sDcKKSTb3HMGijY6h2ciAoCSh7yx9RfmkoV+Ial1HQzpIhOSEZhQFYWy4l1cGl4ZyUOEd8Jt4LSwJTWz4lLbHfl8ZY2ScMsCBun3xnBTK52VVs8dhQ3CHZy1Y14yaO6zlCGSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biRho/1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biRho/1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035721F000FF;
	Wed, 30 Sep 2026 00:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729943;
	bh=XTrLrGRG4xIx3eTuE+g1DFQKR2Cwh+SOj4wPxjxRjI0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=biRho/1ZbOutBa/vNiqnRhlY6SwZutcqbYN3Ghx2ERPPdyel9b4jYby9XtC61UEsV
	 wEgUvhg9aE12hy3ZjO2q31Xf1IxrHiecPibhcOFabPBIgmkqZtnqJ+qeedqXfXbSlf
	 udBQzNwWqjBULWd5KHkQkAUoMCeLkWzU+D7shyl556qZ7oZKcWzD61hrViPzVGtxPs
	 T8nGaTpU86WzzgCosyuWxin2kk1hDkVrdVL1jYinoDHqsR6MHIUteQkCVKOghO22hL
	 icPma4AsQcGvuissGa5Mx+Qf+jkynKalCNVyntsiiZ7z0TUKpDD+i0/bQGgRTNZKu6
	 zf3/ySVQDBmcg==
Content-Type: multipart/mixed; boundary="===============6181959472590134412=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <92a44bb46f421bebc4ab85faa0f95944cbb9d877d8e9372f51cfaae358841d2b@mail.kernel.org>
In-Reply-To: <7c139810be5ffc9764ed4236efc28794@kernel.org>
References: <7c139810be5ffc9764ed4236efc28794@kernel.org>
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Work around pahole 1.32 dropping scx_bpf_task_set_lazy_resched() from BTF
From: bot+bpf-ci@kernel.org
To: tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com
Cc: emil@etsalapatis.com,david.dai@linux.dev,yonghong.song@linux.dev,ast@kernel.org,bpf@vger.kernel.org,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 00:59:02 +0000 (UTC)

--===============6181959472590134412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> sched_ext: Work around pahole 1.32 dropping scx_bpf_task_set_lazy_resched() from BTF
>
> With clang and pahole 1.32, x86-64 vmlinux BTF lacks
> scx_bpf_task_set_lazy_resched() and sched_ext fails to initialize:
>
>   sched_ext: Failed to register kfunc sets (-22)
>
> clang describes the lazy argument only after the prologue moves it into a
> callee-saved register, which pahole 1.32 rejects as not being the argument
> register. Released pahole is affected whatever the eventual fix. Keep the
> argument on the stack with barrier_data() so that its location names no
> register. OPTIMIZER_HIDE_VAR() would fix x86-64 but break arm64.
>
> Fixes: f8e5a4e3f3be ("sched_ext: Add lazy preemption support")

Does the Fixes tag reference a commit that exists in this branch's history?
The tag points to f8e5a4e3f3be, but if that commit is not an ancestor of
this commit, the Fixes tag would be referencing a commit from a different
tree or branch.

Can you verify that f8e5a4e3f3be is reachable from this commit's history,
or clarify which commit in this branch originally introduced the lazy
preemption support that needs the workaround?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36651688234
--===============6181959472590134412==--
