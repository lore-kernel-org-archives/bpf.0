Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C140488C;
	Tue, 13 Oct 2026 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899523; cv=none; b=N1TrSVaQexsO5wGRR9RrIDXxewCF5UpNmFqP6dIGYUEbRhjGeDcutJVVk9DuOUoqBUBGVETMDS0yLPeZvWDvhvIO8Y6dp/a6KGxutKUDNfl9b+Yz/iQKAP8fJtei/SU6ZBwZx62lQejpOH6F1ECMPZHH4Q3TbyTP3yN5+QpZzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899523; c=relaxed/simple;
	bh=CzkczMTrPs68RWkLRw2AltQ/eucosntYOAGSgTJWbWo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eyg4w0qw6CIJRw8IK4XOxoewvKJFyWPPLolRLcvbfdJkZYn9wD6WVUTzWpdk+h0vggan0iSfqdh7uLjB708K1KdfR2Fz3ShK/E5GasTgcs7qmNqU7j/jF1y4v7dIOavpBowagXTHNGx6Dh0IxIotdcqH1ZwCg5GSdU/ktiuF/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEjbIHBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEjbIHBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFBE1F000FF;
	Tue, 13 Oct 2026 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899521;
	bh=G32wiI4qOUiolozAkV820CbG6zt5mOOYhyIhH56goN0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kEjbIHBZOuM8JQPe1pPTkyuH+dRImma5IcVxAX79E59k7wAKGa3bykbVdNydDq66w
	 v3lemYPF73xS7VqP37lMSSFIY8GNCQ7867Soh17dRV6JMblpaxVhmh11JHa4cruWoS
	 edkJN4mwHhcH9UWvkk8dJLHYpx105Wowu9FE5uh3CB0PhpFvmNrh4+fW5osqsvi9b8
	 jeReT4rujS13xD/umn6BLdS7LtEC0s7E9IhnPF6rzg1JLMXoM4WbuEUSQxEuL08EIo
	 f7GHH+S2aYNcIjCqrvCJ5HPGjNhpTyfjssEgyehENCNfocpar+Y69xxU0aE2bLPgjQ
	 bKXw5/CzogTdg==
Content-Type: multipart/mixed; boundary="===============8104651796735048521=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <69c3c1d057b9a47a37b8ddd6eda79c5ca0dade966fa2962f256c50255853e1d4@mail.kernel.org>
In-Reply-To: <20261013122125.843451-4-zhen.ni@easystack.cn>
References: <20261013122125.843451-4-zhen.ni@easystack.cn>
Subject: Re: [PATCH v2 3/6] mm/page_owner: add open-coded page_owner iterator
From: bot+bpf-ci@kernel.org
To: zhen.ni@easystack.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,akpm@linux-foundation.org,vbabka@kernel.org,surenb@google.com,mhocko@suse.com,brendan.jackman@linux.dev,hannes@cmpxchg.org,ziy@nvidia.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,zhen.ni@easystack.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 13:51:58 +0000 (UTC)

--===============8104651796735048521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> mm/page_owner: add open-coded page_owner iterator

TL;DR: The new page_owner kfuncs may lack KF_PERFMON, so a CAP_BPF-only
syscall program could read page_owner records and symbolized allocation stacks
that are root-only in debugfs.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a284f20c97d5..85ce368315f9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -5177,6 +5177,12 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>  #endif
> +#ifdef CONFIG_PAGE_OWNER
> +BTF_ID_FLAGS(func, bpf_iter_page_owner_new, KF_ITER_NEW | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_page_owner_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_page_owner_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_page_owner_stack_snprint, KF_SLEEPABLE)
> +#endif
>  BTF_ID_FLAGS(func, __bpf_trap)
>  BTF_ID_FLAGS(func, bpf_strcmp, KF_PERFMON);
>  BTF_ID_FLAGS(func, bpf_strcasecmp, KF_PERFMON);

Should bpf_page_owner_stack_snprint(), and probably bpf_iter_page_owner_new(),
carry KF_PERFMON here?

These kfuncs are added to common_btf_ids, which is registered for
BPF_PROG_TYPE_UNSPEC, and none of them has KF_PERFMON.

BPF_PROG_TYPE_SYSCALL programs are always sleepable (check_attach_btf_id()
requires it), and they only need CAP_BPF (or a delegated BPF token) since
SYSCALL is not covered by is_perfmon_prog_type().

That means a CAP_BPF-only loader can walk all page_owner records and use
bpf_page_owner_stack_snprint() to copy symbolized allocation stack traces
into program memory.  This skips the allow_ptr_leaks gate that
check_ptr_to_btf_access() applies when the same data is read field by field.

The debugfs interface that exposes this information is root-only: page_owner
is 0600 and the page_owner_stacks/* files are 0400.

This tree already has KF_PERFMON (commit 88ce88e933e4 "bpf: Add KF_PERFMON
kfunc flag"), and comparable kfuncs use it, for example bpf_get_kmem_cache()
and bpf_probe_read_kernel_dynptr() in this same table.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38403671988
--===============8104651796735048521==--
