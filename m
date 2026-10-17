Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E4303A04;
	Sat, 17 Oct 2026 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201964; cv=none; b=s05ImI7rlPICOSuJyXmnCykvTNzhB6D4txL/LF8uzMB6HN4Ig3UBvl6qzy0GWEyKr6bwuG9Rx2DwIYjJkM8/hIz914vmyP99Ljse5eM1S5C1+RAGepdjxZariMvPmPF+i+uxD9MQ/JNz40b7BorY3P2HGgBwkrHIgRD3j7TRHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201964; c=relaxed/simple;
	bh=dqJPs/ZSq+kEm9qmjKvO2q+zx+GE1CvNmoK28eKIJeU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ptzsLoIzpNOojyVCjp47kE/xPoZTB6YUZkqBvvBnjOsUBTQ4v+wKtDDeCDS7s/TtZ0hzfcvOt6WgLVvPFdxYLW6pOu2sXPkE4tLpqnqO4pKigVGqI9/WDqfFxJakXdlIWbm1Qg/wVC82xYheERisBwpTHtAnO+gmXHjWTdWyA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeJY+/aE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeJY+/aE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078561F000C4;
	Sat, 17 Oct 2026 01:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201963;
	bh=XglLirrsez4yqv8n/eRTAa92pQ5gI64vJicukpL4zU0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GeJY+/aEwBJVA5qAY61vdwMRJJkW/gqPkS+IqoX4zRzGMcIHvxb8VzDCPOBz/H2OS
	 5vUtm2vXkcv+lSy9KhPhQKeQCDlm1AADXZI+JXKnW6xo2gAZwD9YYEW3TkkJultkhn
	 ij6i6m6WG86WmQxjt20/uSebVCaqrjnezQg979S4yoM3ayDc4Fzk08fHXe5ysiRHg5
	 O2wJv5sF5yBHawHcpKW6ScGVnZhyo8tU1cDYYQjsdOmwhu59jeYpHb10mpy4ICFTEs
	 B5Vd18LMlo344vu3PWSZn2H90V7t4iuSi0+ktb7/95cLSwp4Nlar0CoyPfIpSqC2UL
	 a8p1M0HMsLz+w==
Content-Type: multipart/mixed; boundary="===============5453475719898273485=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8dd7ea54f619380d7dd025e485a6d9d1bb8073daa7fc6b9de339e020c46d4d70@mail.kernel.org>
In-Reply-To: <20261017012451.364800-11-alexei.starovoitov@gmail.com>
References: <20261017012451.364800-11-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 19/38] bpf: Fix stale offload->prog pointer after realloc
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 01:52:41 +0000 (UTC)

--===============5453475719898273485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix stale offload->prog pointer after realloc

TL;DR: The new offload->prog update in bpf_prog_realloc() runs without
bpf_devs_lock, so it may race with device unregistration: possible write to
freed memory, and the stale-pointer use-after-free is only narrowed.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 642f0ab8eb2d..2154c18a5a4d 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -269,6 +269,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
>  		memcpy(fp, fp_old, fp_old->pages * PAGE_SIZE);
>  		fp->pages = pages;
>  		fp->aux->prog = fp;
> +		if (fp->aux->offload)
> +			fp->aux->offload->prog = fp;
>
>  		/* We keep fp->aux from fp_old around in the new
>  		 * reallocated structure.

Can this race with device unregistration?  The new lines read
fp->aux->offload and write offload->prog without holding bpf_devs_lock, and
unregistration can free that offload at the same moment, so the store may
land in freed memory.

bpf_prog_load() calls bpf_prog_dev_bound_init() before bpf_check().
bpf_prog_dev_bound_init() adds the offload to ondev->progs, then drops
bpf_devs_lock and does dev_put(netdev).  After that nothing holds off
unregistration while the verifier runs:

bpf_check()
  ...
  __bpf_patch_insn_data()
    bpf_patch_insn_single()
      bpf_prog_realloc()

At the same time unregister_netdevice_many_notify() ->
bpf_dev_bound_netdev_unregister() takes only rtnl and
down_write(&bpf_devs_lock) and runs:

    list_for_each_entry_safe(offload, ptmp, &ondev->progs, offloads)
        __bpf_prog_offload_destroy(offload->prog);

where __bpf_prog_offload_destroy() does:

    struct bpf_prog_offload *offload = prog->aux->offload;
    ...
    list_del_init(&offload->offloads);
    kfree(offload);
    prog->aux->offload = NULL;

Timeline 1, write to freed memory:

  CPU0 bpf_prog_realloc():
    if (fp->aux->offload)          <- sees offload O, not NULL
  CPU1 bpf_dev_bound_netdev_unregister():
    down_write(&bpf_devs_lock);
    __bpf_prog_offload_destroy(fp_old);   <- kfree(O), aux->offload = NULL
    up_write(&bpf_devs_lock);
  CPU0:
    fp->aux->offload->prog = fp;   <- 8-byte write at offset 0 of freed
                                      struct bpf_prog_offload

If the compiler reloads aux->offload instead of reusing the value it
tested, this becomes a NULL pointer write.

Timeline 2, the stale pointer is narrowed but not closed:

  CPU1 (under bpf_devs_lock) reads offload->prog == fp_old
  CPU0 stores fp into offload->prog, sets fp_old->aux = NULL, and calls
       __bpf_prog_free(fp_old), which ends in vfree(fp_old)
  CPU1 __bpf_prog_offload_destroy(fp_old) then reads fp_old->aux from
       vfree'd memory (or reads NULL)

That is the same fault quoted in the commit message.

Every other place that touches prog->aux->offload during verification takes
bpf_devs_lock and rechecks the pointer under it, because unregistration can
race with verification: bpf_prog_offload_replace_insn(),
bpf_prog_offload_verify_insn(), bpf_prog_offload_finalize(),
bpf_prog_offload_remove_insns() and bpf_dev_bound_resolve_kfunc().  The last
one carries the comment "We don't hold bpf_devs_lock while resolving several
kfuncs and can race with the unregister_netdevice()".  The new code does not
follow that pattern.

bpf_prog_realloc() can already sleep (__vmalloc with GFP_KERNEL), so could
the check and the store be done under down_read(&bpf_devs_lock), held until
before fp_old is freed?  bpf_devs_lock is static in kernel/bpf/offload.c, so
that would need a small helper there, with a stub for
!CONFIG_NET || !CONFIG_BPF_SYSCALL.  The unregister side holds the lock for
writing for its whole scan-and-destroy, so this would exclude both timelines.

The sibling fix a1aa9ef47c29 in bpf_jit_prog_release_other() has the same
unlocked pattern.  No later commit in the series range changes this code.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38991548713
--===============5453475719898273485==--
