Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5DA38D6AC
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176302; cv=none; b=EIaGJWZukZI1KHSR2336h/sROO4ZE+cn8NogH/91bhoGn1xwbaNzbJQA7+hEnzV46a4OQEcnKGmChQBHY1Qwui8JeQKR7cF5XEwuuh+z6HJsEObGENw0PAESOxDHvSbxHA+mX2XmByR+uG4tVT7z4iaQSzxZv0lFYCIz6B7SLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176302; c=relaxed/simple;
	bh=O8a2/WBRbv32P6u+xKwUptJYVFXTEkF6AOcsc4Bfz8E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JuQAjHBuFSmJQyUStklaYgaDc420M7R/82DRujns5k7GTuW7fWGFvTeYfm+dEhVsSdgXB7l8T4hgxmpkmiSHBc3FClpZV/rNv0Rx6o0vmJQe7Y3Op9PKzsm64nDuIx328Vp6ViXrg1NwFlsB3ph5xccjGGjyoKJ7mik/QjxN2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt4HQYyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt4HQYyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1878C19423;
	Tue, 10 Mar 2026 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773176302;
	bh=O8a2/WBRbv32P6u+xKwUptJYVFXTEkF6AOcsc4Bfz8E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gt4HQYyEeQLT805IPRgTzZnqox1FYgvLJ5JO/H6X2QGDnfowLjfyEAQf6DfXp71/z
	 o0svAHgPgcmNLF6g8GwVkG1pg8QmVlRyXkJzCchtWGJhJZfJqT4wAYD7lkwQgTU99z
	 UgNcFgx1O31cXIbqGAxEZ+muXc/VME1OJsTxE15pcYOF+SCD6TG8OS7aTLmTifYCgG
	 ppJjldJZyofB1HvQ+SJVoCE5SOlC8nJ5F1lj0G8KoDU+qa5qnPV7yMc5v0PTo7sQ7c
	 ga33P+0wd2vCxMnu8W9fy9ZNBVOz8jRicIp23su6UKiSRfEsshXMTuLHppzq6lqbgv
	 pLuIzBBaryu4Q==
Content-Type: multipart/mixed; boundary="===============2206586132517625042=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <273ca8530942f90fe7445333e7117b71249743582b8c29a431352e4c02c5413e@mail.kernel.org>
In-Reply-To: <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
References: <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition in struct_ops
From: bot+bpf-ci@kernel.org
To: grbell@redhat.com,bpf@vger.kernel.org
Cc: martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,grbell@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Mar 2026 20:58:21 +0000 (UTC)

--===============2206586132517625042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 09fcbb125155..81c9f46a7bb7 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>  		list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>  			if (btf_mod->module != module)
>  				continue;
> +			unsigned int timeout = 1000;
> +			while (refcount_read(&btf_mod->btf->refcnt) > 1
> +			&& timeout > 0 ) {
> +				msleep(1);
> +				timeout--;
> +			}
>  			list_del(&btf_mod->list);

This while loop calls msleep() while holding btf_module_mutex, which
was acquired at the top of the MODULE_STATE_GOING case. This can hold
the mutex for up to 1 second.

During that time, all concurrent callers of btf_try_get_module(),
btf_get_module_btf(), and any other module state notifications that
need btf_module_mutex will block. This includes the BPF verifier path
through __find_kfunc_desc_btf() and check_struct_ops_btf_id().

Additionally, module notifier callbacks run under the module
subsystem's own locks. Sleeping here for up to a second delays all
module load and unload operations system-wide.

Could the mutex be dropped before the wait, or could a different
synchronization mechanism be used here, such as a completion?

Also, if the timeout expires with the refcount still above 1, the
code falls through to list_del() and cleanup anyway. The commit
message states:

> This ensures BTF objects are properly cleaned up from the
> cache before their module metadata is removed, eliminating the timing
> window that caused the race condition.

This does not appear to be accurate, since the timeout makes the fix
probabilistic rather than a guarantee. If a BTF reference is held for
longer than 1 second, the original race condition would still occur.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22923069980
--===============2206586132517625042==--
