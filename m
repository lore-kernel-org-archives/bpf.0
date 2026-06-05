Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFD413610;
	Fri,  5 Jun 2026 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672795; cv=none; b=fdH7EJCZjSloSGWmvxXnpkwHsVRHYvTYlXKx3gl4BirPKzEee7YuupwVofrFCkjh3CcoQ34x79ox7vhroaeU95Z3k0T/BTuKXv0vFWa1wGhQwIpTpx2Wx3svE2OBWHZRYyCPuJQe4hPnkFbYBx6+TKSAd2L5pH6fTwRCiFJnrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672795; c=relaxed/simple;
	bh=Nn7ihjl5FXZNoElklrIWL8p9oF1i90/b+DuG1J+JdDU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PcPRHGiKpfZls/uAtqA2oEeJP9HDtgrmkhdt8SITScw70WCWHPCPyK3fZJVpmR85+Llx6Eu/pE1N6S5bVn+zTn41lqdWPk+sX4Nbmk+JU9begklMi+1zsPpH0m88iJpugOLjc4+Igs7V2Rkx1SF6xevPkL8PDjyO07oO54PeqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKDzKm31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKDzKm31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD08C1F00898;
	Fri,  5 Jun 2026 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780672789;
	bh=S+gtjbVoF0BKMIshuZbQIy7ScHU1EE6+yGZRSyjlvNw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YKDzKm31bALSDZmSKlH/MAcLAwuQ/fWwTtPSB8W3Fyv8rDjour7JqhAPeSY6x2wG0
	 GT3k2ymeboPussDGb+dLFI4NWy7Vgnoiz4eAqDQ2W5IQs241gV402sm6NTulfyvXcw
	 8gNpln54SgTEMZgE1Usd33hg3JZ9Kif+0enh3INRr28bBOn5JEhhb88lC0sSfF7TW3
	 7N1miPdUMWSO2zkvdhvd7p4mjr3t/qjbpmOmymFg0m4DfBomZO0f/z2cEUnpQM+6Os
	 6fdr9a+AE1hUrrUQARVuep+Zo2p658Cs18mFQ98vm8reUjcFt77ntfITgsmhus0N6h
	 2BzjScublHnqA==
Content-Type: multipart/mixed; boundary="===============0693000919240842923=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e1cdea54c3e6310fa98dc570463350bd8bf749c5cb133a8160a4950484946c8f@mail.kernel.org>
In-Reply-To: <20260605140243.664590-2-xukuohai@huaweicloud.com>
References: <20260605140243.664590-2-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v5 1/3] selftests/bpf: Restrict bpf_set_retval argument in sk_bypass_prot_mem
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,sdf@fomichev.me,zhuyifei@google.com,mattbobrowski@google.com,2022090917019@std.uestc.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 15:19:48 +0000 (UTC)

--===============0693000919240842923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c b/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
> index 09a00d11ffcc..bae5283fca6b 100644
> --- a/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
> +++ b/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c

[ ... ]

> @@ -97,6 +98,7 @@ int sock_create(struct bpf_sock *ctx)
>  	return 1;
>
>  err:
> +	set_if_not_errno_or_zero(err, -EFAULT);
>  	bpf_set_retval(err);
>  	return 0;
>  }

Could this cause a verifier bounds violation when multiple programs are
attached to a boolean LSM hook?

When do_refine_retval_range() calls bpf_lsm_get_retval_range() for a
boolean LSM hook, it strictly refines the register bounds to [0, 1].

However, if multiple programs are attached to the same cgroup hook via
BPF_F_ALLOW_MULTI, they run sequentially in bpf_prog_run_array_cg().
If the first program returns 0 (within the [0, 1] bounds),
bpf_prog_run_array_cg() translates this into an error code:

kernel/bpf/cgroup.c:bpf_prog_run_array_cg() {
    ...
    if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
        run_ctx.retval = -EPERM;
    ...
}

When the next BPF program in the array executes and calls bpf_get_retval(),
it receives the current run_ctx.retval, which is now -EPERM (-1).

Since the verifier statically assumes bpf_get_retval() will only return
0 or 1, could receiving -1 at runtime allow bypassing verifier checks and
performing out-of-bounds memory accesses?

This concern was raised by sashiko-bot on lore in v5:
https://lore.kernel.org/bpf/20260605144232.95A141F00893@smtp.kernel.org


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27021279696
--===============0693000919240842923==--
