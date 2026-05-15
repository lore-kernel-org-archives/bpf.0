Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40935BDA8;
	Fri, 15 May 2026 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838219; cv=none; b=FWdJBaShXT+fNwx/SMrOi13YhTQP1Ruk3G0e7HQHgKJJXLKvnnHMX4E8lfjqFubdqJCPFpJ0YxF8Eu1vu6i/AaHoUG4s4wmheL8I8yevqi2hZr0gRmmPk4t/mfAE7AbFKwSLPlKMd8kjvhAEDKaok9UVEUFXsHuCXHkk5BYT/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838219; c=relaxed/simple;
	bh=qitwp4UEv6HvSRkDO/BDr87eUzsVOa4pzi6lNUAYUQI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FprBx6eq1F3t/Z4PN2Bsqi2T2NLelWiL0jWIvqkv6SwhZKv00EkuuLr8noV30ZFyIBgmS/5gdgCXG6xz2EERvyBBkGz6kfJE35OBit+kgK+ehOlknlKSJXq+VxVid7YPNX1wvs/5XZStGBtLyyLN5McsLEiuZ5/3AR1QO5vrKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV9Kb/hW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV9Kb/hW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8851C2BCB0;
	Fri, 15 May 2026 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778838219;
	bh=qitwp4UEv6HvSRkDO/BDr87eUzsVOa4pzi6lNUAYUQI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FV9Kb/hW6Vhkp76L4jMaia2Afx3R25oZI3miVmDLT0g3rm248jb9ppk2iKHq1l0FR
	 gKUWg7P41hoX0yCufoJMUEHwgqMklKkI2Oht0K8P46D7yeJLA6NGOm6KtxbScp+tdM
	 YpdUV7lnXkiKqzpsLnUg6Cvh9ticVVUJrFxEpj1xkMCUCkWwpvmIkZ59AyYtA5AqA2
	 eQSra7UXHVu9UZdLJF0bDys3JD3sysL1N5/S558Pev50w9lC/UE4MJav4HB6pRVtUE
	 fz7XkBDSdGrYzEZ+fxVbB3bz3rNBPRWjOckHRd3jsFV+6USnGhBn6EJKAfLWEvyLeZ
	 BEIz/PSFT06uA==
Content-Type: multipart/mixed; boundary="===============2268827500131786950=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <40fed078da36c9985d9c08486c546c7b76a3664c4f77b8a5ad707f79e5c4d454@mail.kernel.org>
In-Reply-To: <20260515090631.284426-1-arnd@kernel.org>
References: <20260515090631.284426-1-arnd@kernel.org>
Subject: Re: [PATCH] bpf: make bpf_session_cookie() reference optional
From: bot+bpf-ci@kernel.org
To: arnd@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,menglong8.dong@gmail.com
Cc: arnd@arndb.de,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,puranjay@kernel.org,yatsenko@meta.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 15 May 2026 09:43:38 +0000 (UTC)

--===============2268827500131786950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 2cc68d16a6fde2cca5c308c947ae835c366fe09c
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Fri May 15 11:06:15 2026 +0200
>
>     bpf: make bpf_session_cookie() reference optional

The commit subject references bpf_session_cookie(), but the patch actually
makes bpf_session_is_return() conditional. Should the subject line be
updated to reflect the correct function name?

Reference: https://lore.kernel.org/bpf/20260515091607.ED08CC2BCB8@smtp.kernel.org/

>
>     Building without CONFIG_BPF_EVENTS produces a build-time
>     warning:
>
>     WARN: resolve_btfids: unresolved symbol bpf_session_is_return
>
>     The function is actually defined in kernel/trace/bpf_trace.o,
>     which is built conditionally based on configuration.
>
>     Make the reference to this function conditional as well,
>     as is already done in the bpf verifier for other functions.
>
>     Fixes: 8fe4dc4f6456 ("bpf: change prototype of bpf_session_{cookie,is_return}")
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 76a07f09ab64..cec4edc86485 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11088,7 +11088,11 @@ BTF_ID(func, bpf_task_work_schedule_resume)
>  BTF_ID(func, bpf_arena_alloc_pages)
>  BTF_ID(func, bpf_arena_free_pages)
>  BTF_ID(func, bpf_arena_reserve_pages)
> +#ifdef CONFIG_BPF_EVENTS
>  BTF_ID(func, bpf_session_is_return)
> +#else
> +BTF_ID_UNUSED
> +#endif
>  BTF_ID(func, bpf_stream_vprintk)
>  BTF_ID(func, bpf_stream_print_stack)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25910298674
--===============2268827500131786950==--
