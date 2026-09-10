Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29B4A2A4D
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053030; cv=none; b=ihI4cYSExUb4xIauov2YCnLO4gt008WlCYKFx/tg4fkLJqtKjf+MwgGKztcQimPi5Qw//8/scsXCrPfdd0hToXun07X3N2c76AH/7g5yxhvpZTnrpl1v5SvaI9QSxurWaZZ/iJbTcwZdaMUefvFEOFzmCy9eBzwd/LZLG5s6VEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053030; c=relaxed/simple;
	bh=fz5ut/YPuVAihtFwi7QQXS6J4MqVfPaFOgABJ6YU9MI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R9Ddsy36wMcTOafLAHEtOxK+IwXqlWEzqMh5sKdShCARicNPTqHcXDdj+ZnnmM0ZlUecHyX017GNLiX0M01HE800BRF6cgnVA/TWUQSChnDQfHJ+MLSf2PKU9mnlT8Rd7JHkaCdFUdsjrgAlsMv9BiY71Tg5cuFVfUmcj6djbtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu42pXIc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu42pXIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067461F00898;
	Thu, 10 Sep 2026 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053020;
	bh=PVVhlhMJALD41TVKe0MLCQIYOB91YPjTKWClx5dCOQQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Iu42pXIcAxXNK6suR0sxFGnKfJSWiUikJRZUC0F+cD6ijSD9wLSBUgC1nxFMHWZph
	 dbvIZxE54EoaS1xqeQTRV3FrdTndVurDf9C6VnfCgyJOejxHOW76XVICgz/iiai9ex
	 kw/nWMsm+IXdeOyeZgCaV1Y9zzz7loT6vQmCmRdtIuh/kbpzCZ9IKytzYApvBI0Jg6
	 vvc9w9F13SPYqBQl0njygsvZQJ2UxbwJiSLB9LDnUn7juwef8S23EN4+wQeKKNxG24
	 EFKaEwp95FV0wCa5hMjVKuZkO8cs20gHzrubjaVWdFNdfzcMgyinh3ACIvCHVFCzTA
	 vBYmGIC2WUqgw==
Content-Type: multipart/mixed; boundary="===============3642126716669322024=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2c6397fd5a002902b955551e07c392e00229c297e7cc0f03ffe89f21e8782998@mail.kernel.org>
In-Reply-To: <20260910142107.40582-2-daniel@iogearbox.net>
References: <20260910142107.40582-2-daniel@iogearbox.net>
Subject: Re: [PATCH bpf 2/4] bpf: Require CAP_PERFMON for kfuncs reading memory
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 15:10:19 +0000 (UTC)

--===============3642126716669322024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b3cc5c8fc875..8a0eeb4f6236 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

Alexei Starovoitov (BPF maintainer) explicitly rejected a similar approach
in June 2026. Nuoqi Gui submitted a patch series to gate dynptr probe-read
kfuncs (bpf_probe_read_user_dynptr, bpf_probe_read_kernel_dynptr,
bpf_probe_read_user_str_dynptr, bpf_probe_read_kernel_str_dynptr) with
CAP_PERFMON.

Alexei responded with:

> On Mon Jun 15, 2026 at 1:31 AM PDT, Nuoqi Gui wrote:
> > The dynptr probe-read kfuncs are registered as common kfuncs. That lets a
> > program with the generic kfunc privilege gate call
> > bpf_probe_read_kernel_dynptr(), while the legacy bpf_probe_read_kernel()
> > helper is exposed only with CAP_PERFMON and is blocked by kernel-read
> > lockdown.
>
> It's fine as-is. Won't fix.
>
> pw-bot: cr

Reference: https://lore.kernel.org/bpf/DJ9QOWVIXFHR.1S8UL5H0USVCB@gmail.com/

The current patch takes the same approach of requiring CAP_PERFMON for
these kfuncs, which directly contradicts the maintainer's prior decision.

Does this need to be addressed or justified before proceeding?

> @@ -4920,11 +4920,11 @@ BTF_ID_FLAGS(func, bpf_wq_set_callback, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_wq_start)
>  BTF_ID_FLAGS(func, bpf_preempt_disable)
>  BTF_ID_FLAGS(func, bpf_preempt_enable)
> -BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW | KF_PERFMON)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> -BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE | KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE | KF_PERFMON)
>  BTF_ID_FLAGS(func, bpf_get_kmem_cache)

After this series every kfunc in common_btf_ids that takes a
program-supplied address is KF_PERFMON except bpf_get_kmem_cache(),
which is left with no flags two lines below the newly gated
bpf_copy_from_user_task_str entry.

Looking at mm/slab_common.c bpf_get_kmem_cache():

    __bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
    {
            struct slab *slab;

            if (!virt_addr_valid((void *)(long)addr))
                    return NULL;
            slab = virt_to_slab((void *)(long)addr);
            return slab ? slab->slab_cache : NULL;
    }

The kfunc takes a raw scalar address that the verifier does not
constrain and dereferences the page/slab metadata for it. Field reads
on the returned pointer are still blocked (PTR_TO_BTF_ID | PTR_UNTRUSTED
-> check_ptr_to_btf_access() -EPERM), but the NULL/non-NULL result is
observable.

So a CAP_BPF-only program can still probe whether an arbitrary kernel
address is a valid slab object. Once bpf_rdonly_cast() and the
probe-read kfuncs are gated, this appears to be the remaining ungated
address oracle in the same list.

Is this kfunc considered out of scope for this patch, or should it also
be gated?

> @@ -4932,14 +4932,14 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_local_irq_save)
>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
>  #ifdef CONFIG_BPF_EVENTS
> -BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
> -BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
> -BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
> -BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
> -BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr, KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr, KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr, KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr, KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE | KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE | KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_PERFMON)
>  #endif

The commit message states these kfuncs are now gated "similarly as we do
for the old-style BPF helper equivalents." The helper equivalents are
gated by two things, not one. Looking at kernel/bpf/helpers.c
bpf_base_func_proto():

    case BPF_FUNC_probe_read_kernel:
            return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
                   NULL : &bpf_probe_read_kernel_proto;
    ...
    case BPF_FUNC_probe_read_kernel_str:
            return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
                   NULL : &bpf_probe_read_kernel_str_proto;

KF_PERFMON restores the capability half of that gate, but
LOCKDOWN_BPF_READ_KERNEL has no kfunc counterpart anywhere in the tree
(the only users are bpf_base_func_proto() and tracing_func_proto()).

So with lockdown=confidentiality, bpf_probe_read_kernel_dynptr(),
bpf_probe_read_kernel_str_dynptr(), bpf_iter_bits_new(), the bpf_str*()
kfuncs and bpf_stream_vprintk("%pks"/"%pB") still read kernel RAM for a
CAP_PERFMON holder while the equivalent helpers are refused.

Should the commit message acknowledge that this only addresses the
capability half of the gate, or should a follow-up gate also check
lockdown?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34490344966
--===============3642126716669322024==--
