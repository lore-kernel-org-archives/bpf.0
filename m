Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D235C183;
	Fri, 10 Apr 2026 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804426; cv=none; b=cg6NStrqrZyLe5/n/syvzmUoHThOKUHCGC2hIL4r6U7HZzEzHUAbF5x1+2DGkzjyGPrKFCLDoRuz8FOTJqYLwpGdcBsaNCdud6XQiX8WOmExhIT9jS8bqXkeCjFcsR9UVFIWnaCirA6qlA9Zj5ExnuaDfIdVn7X1PfehcMPOy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804426; c=relaxed/simple;
	bh=FYOED05A4FXTMvwtmbTUN4lSeCMdZLyjXVtRNchrCS4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MWfH8BA64KX8/glDeO/EoBNKOAOlkTpjI96JEKYSntFKsBaaunFOqxzgKuXNNfMKeDdyovcGmmKmn6qfxngta0oY4nxORVY557mj57h8Ej19UkZCEr559njEdksk0PUEf48Y2ZhVx/pJaWq5lsWxPnSRc/f5YmiVatuXDb6ID3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyzCwBUH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyzCwBUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E39C19421;
	Fri, 10 Apr 2026 07:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775804426;
	bh=FYOED05A4FXTMvwtmbTUN4lSeCMdZLyjXVtRNchrCS4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VyzCwBUHZcB2xXJzaUT7G23ULE8qfTLNikzouzE6oe5IQYiy61MvTo/LhNVPreMCW
	 prbVCljZZM7sVQe+Gz6pbpowQsCzsXXA/6fnBm0KzQQ4KNiaCznmmPEoHHQc27w3/n
	 zpo99n8p07dk5BMYENEihJYqs0qBHAsgOn13jwxho2ahd7FnQZGYnEA7EoAf2eGB7n
	 WCaHJocImbjKlEJWnvGS98XUsazui3+kbyVtSyAl3giKTvhoPJ0a5wM3RTp+7ZRWv8
	 50glDeGwjxdjvLkz85o2wrdutW/zPrSdr/PPbZf3HMBG2kqdeSsYYRimr03Yg1AmIk
	 iEydLmWYpkqLw==
Content-Type: multipart/mixed; boundary="===============2539386933282708395=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <60e1c3bebe4eefa53d73bdfa1f016af7abedb294634614119aab1380b9d46eaa@mail.kernel.org>
In-Reply-To: <20260410061037.149532-2-yangfeng59949@163.com>
References: <20260410061037.149532-2-yangfeng59949@163.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,kpsingh@kernel.org,mattbobrowski@google.com,jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 07:00:25 +0000 (UTC)

--===============2539386933282708395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9c1135d373e2..37975e9a291c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +/* hooks return 0 or 1 */
> +BTF_SET_START(bool_security_hooks)
> +BTF_ID(func, security_xfrm_state_pol_flow_match)
> +BTF_ID(func, security_audit_rule_known)
> +BTF_ID(func, security_inode_xattr_skipcap)
> +BTF_SET_END(bool_security_hooks)

There are two issues with this BTF set.

First, security_inode_xattr_skipcap does not exist as a kernel function.
The LSM hook inode_xattr_skipcap is only invoked via call_int_hook()
inside security_inode_setxattr() and security_inode_removexattr().
There is no standalone security_inode_xattr_skipcap() wrapper. The
equivalent entry in bool_lsm_hooks in kernel/bpf/bpf_lsm.c correctly
references bpf_lsm_inode_xattr_skipcap instead.

Second, the v1 of this patch had #ifdef guards matching those in
bool_lsm_hooks:

    #ifdef CONFIG_SECURITY_NETWORK_XFRM
    BTF_ID(func, security_xfrm_state_pol_flow_match)
    #endif
    #ifdef CONFIG_AUDIT
    BTF_ID(func, security_audit_rule_known)
    #endif

These guards were dropped in v2. security_xfrm_state_pol_flow_match
is defined under CONFIG_SECURITY_NETWORK_XFRM in security/security.c,
and security_audit_rule_known is defined under CONFIG_AUDIT. Without
the guards, BTF_IDs will be unresolvable when those configs are
disabled.

> +
> +/* Similar to bpf_lsm_get_retval_range,
> + * ensure that the return values of fmod_ret are valid.
> + */

This isn't a bug, but the BPF subsystem uses the kernel multi-line
comment style where the opening /* goes on its own line:

    /*
     * Similar to bpf_lsm_get_retval_range,
     * ensure that the return values of fmod_ret are valid.
     */

[ ... ]

This commit appears to be a major bug fix addressing a kernel NULL
pointer dereference but is missing a Fixes: tag. The bug was
introduced when fmod_ret was first allowed on security_* functions
without return value validation:

    Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24229694699
--===============2539386933282708395==--
