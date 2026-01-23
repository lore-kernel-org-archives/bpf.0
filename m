Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86773312828;
	Fri, 23 Jan 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159288; cv=none; b=fnxkj3ng9GUdwg912dKOWhmku4vhsRy397dLhntvf6mMt4r2R5BLYaMibLal8Y/67PjTkW87CuqEDyzvbrxsUGM7Er5sXssgF7ygljmlQuY1p3zRS0u6/4V9z2h4q5NpQkAycpZ3y0kf5eWY3fgDVEhE76Lsqm0yAYVPDl6OkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159288; c=relaxed/simple;
	bh=D7GcmOXu7mBIlEAjTlL930gifEzDmeHbdUPti2mJGRA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Us4LTt9rZ3KaZg+wQITcVvYxXe8xjbf0IKEfRONh7U6w0b1UrC411jCzHV0dbSidCLlOJildBiOZ+gOp+qbI+pfZuMwP40D7/yEbfIpm9UkTkMWwARBeQ0qiImNUl4JgC7XRP1mqPNrA2VGw+pMuy0NlGLePILOsWZSDwfCZlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoH4yTTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoH4yTTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72401C4CEF1;
	Fri, 23 Jan 2026 09:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769159287;
	bh=D7GcmOXu7mBIlEAjTlL930gifEzDmeHbdUPti2mJGRA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PoH4yTTtWjUqJctPonbBvOVJHJzzGlePEpDv9b9HB89iVcSuoH03ZbAFVfyanm77U
	 oT1j9clsItTKYLkHSM+4ohBYIurnM/wRq9ANa/Ue0zcbPfvXKHiAcfXMgvIVaPQgG/
	 DEswT1xB8kh1LYRCf4nGvM0kk5nyi0lBxOHBLzjzLEiXGnxfSlk7JZuP/mEhtvrroJ
	 gV/255OY7MbNpqiHyr1OgOrPhyTVP/qXwb1iDJ6LeU5h8LaKq/FMN+wKvbHz94GDrY
	 RKp+JP8MMofE9FaqqYGHXXINwBpowE7/TAQII1g/Cq8uNN+phEuq/tGbrZAecdmDz4
	 Nc7jQFi8qb4Fg==
Content-Type: multipart/mixed; boundary="===============2950745961147967484=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <109e6caa10a260b0f02b2595fb021db560daf0b77e9b3d1db61ee57191d6fd25@mail.kernel.org>
In-Reply-To: <20260123084248.259278-3-changwoo@igalia.com>
References: <20260123084248.259278-3-changwoo@igalia.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for execution context kfuncs
From: bot+bpf-ci@kernel.org
To: changwoo@igalia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,kernel-dev@igalia.com,bpf@vger.kernel.org,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,changwoo@igalia.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 09:08:07 +0000 (UTC)

--===============2950745961147967484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 77a81fa8ec6a..8c7add48e447 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> +/* IRQ Work for HardIRQ context */
> +static void ctx_check_irq_fn(struct irq_work *work)
> +{
> +	bpf_testmod_test_hardirq_fn();
> +	tasklet_schedule(&ctx_check_tasklet);
> +}

[ ... ]

> @@ -1844,6 +1872,10 @@ static void bpf_testmod_exit(void)
>  	while (refcount_read(&prog_test_struct.cnt) > 1)
>  		msleep(20);
>
> +	/* Clean up tasklet and irqwork */
> +	tasklet_kill(&ctx_check_tasklet);
> +	irq_work_sync(&ctx_check_irq);

Should the cleanup order be reversed here? The irq_work handler
ctx_check_irq_fn() calls tasklet_schedule(&ctx_check_tasklet). If the
irq_work is still pending when tasklet_kill() is called, the subsequent
irq_work_sync() may trigger the irq_work to run, which would then re-schedule
the already-killed tasklet.

This could lead to a use-after-free if the module unload completes while a
newly scheduled tasklet is still pending, since ctx_check_tasklet_fn() would
point to freed module code.

Would swapping these to call irq_work_sync() first ensure the irq_work cannot
schedule any more tasklets before tasklet_kill() runs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21280227502

--===============2950745961147967484==--
