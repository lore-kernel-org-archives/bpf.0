Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561917;
	b=dtUnuDOlslkThAz3kBwdxhXFSOYpkjrn9lstbqtoREGyaUNMEZTfAWR8uDywambXk7Id
	 SDiTC3s0qf0f11J8NZ5YvTRETh4WpqAH128MX+9m59FW+p/GQoHC1SJq0fnOZcvHdJUx/
	 LH3AoWSYIjjGIsW7QkxC0CAAe7dBnBTKZWVnJnt+tN3wm3cnzonI/BnD/dRVjaFqKObUm
	 B2Mh5Fv9pQvnGa2hj9c5KKXmJqKK+Vx7918xp05JorxfmvuiWdfrC+Y/6jD/JMkDMutI1
	 Z47UrQSuNEdQnaARL7xJ+68qF5hkzJ6s+4S0bAlHk+9R8OoDnxTTiIK916mkYKTO6rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561917;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2393p6LZ89FkQX0fBVSD37lEdDQxrEbbRUOU2mrzvlw=;
	b=YdRSVTuiHgnOrrH1tNgjML4yPR7YU8w5nEGmFq9Rsr3pRqZt+qaSihMDnSzD8g4utOgZ
	 QcfjroNowABgVyuo3hGMCgOgenuxIGGX3WuAIl/xxcyU9+EGlDf48i5E8gkB+JlmwcvOl
	 Pmcp20WM4MCLVz2V4B6k4OPOOOQ1nLwcy/jZ9tM0+KJtp5uCu3/uge8jk1Stz9Y7tBW92
	 4nml7UTihXj1lrUH6XVbE5tAG8sUykE02wKGm8pmu3EdJ1xaP4kx1ANX9bFmaitonHPck
	 f5upewfySa7e5kYhA3qhU+W0knB8ZirFUBxUL6VdeFAxtwqJ+sDSk41i6hx2d7z9fzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="obz/3LQ6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9817606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obz/3LQ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332D71F000C1;
	Sun,  1 Nov 2026 19:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561916;
	bh=2393p6LZ89FkQX0fBVSD37lEdDQxrEbbRUOU2mrzvlw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=obz/3LQ6DzMrmfj+U6AoETZpqRFFyWpdFru7EQICxo8YUYD+b9C+Ig+awfIuxU64K
	 xEBVPXdgoMaQCHzo4IW9YoEw9Hc8XXCj5tn27ovbn7n9mXwyeOtaGCv9sV/ETZjJ0k
	 Mj8Isq1kO/HJmQbmkzqiip49dKLLYOY1k+s3nI4rkYszkX11dOcQX39Dnzg2S9hB+Z
	 c97AyHNdGCiMSMgtjS/xCL2jme5QuaF/OKGJcGz7BYAPzCm2rfM3ZoQO+AzRbj2Etn
	 HYVNajLxPlA/lYuD3hugzHR0HTcXcX3v3bP/B9VMbIIaZG8zhqGB8EvYSU8TelVi18
	 YeVV3e9Qh6ISA==
Content-Type: multipart/mixed; boundary="===============1514127261929035531=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2701eb350fc2a1c883cb6194a4b671e5e6316228e794651c708f967fdced78da@mail.kernel.org>
In-Reply-To: <20261101190535.1454146-14-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-14-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 13/27] bpf: Require prog fd or capability for cgroup detach
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  1 Nov 2026 19:38:36 +0000 (UTC)

--===============1514127261929035531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Require prog fd or capability for cgroup detach

TL;DR: The new -EPERM check on non-multi cgroup detach may be bypassable: a
caller without CAP_NET_ADMIN holding any prog fd could replace the attached
prog via BPF_PROG_ATTACH, then detach it. Should attach get the same check, or
the commit message say so?

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index ce82963bcfc7..ca681d626c9e 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1279,9 +1279,14 @@ static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
>  			return ERR_PTR(-ENOENT);
>  
>  		/* to maintain backward compatibility NONE and OVERRIDE cgroups
> -		 * allow detaching with invalid FD (prog==NULL) in legacy mode
> +		 * allow detaching with invalid FD (prog==NULL) in legacy mode.
> +		 * Without the FD of the attached program the caller needs
> +		 * CAP_NET_ADMIN or CAP_SYS_ADMIN in the initial user namespace.
>  		 */
> -		return hlist_entry(progs->first, typeof(*pl), node);
> +		pl = hlist_entry(progs->first, typeof(*pl), node);
> +		if (pl->prog != prog && !bpf_net_capable())
> +			return ERR_PTR(-EPERM);

Is this check bypassable through BPF_PROG_ATTACH?

A caller without init-ns CAP_NET_ADMIN or CAP_SYS_ADMIN who holds a cgroup
fd and an fd for some other prog P2 of a matching type now gets -EPERM here,
but the non-multi attach path has no equivalent check:

kernel/bpf/cgroup.c:find_attach_entry() {
    ...
	if (!allow_multi) {
		if (hlist_empty(progs))
			return NULL;
		return hlist_entry(progs->first, typeof(*pl), node);
	}
    ...
}

bpf_prog_attach() -> cgroup_bpf_prog_attach() -> __cgroup_bpf_attach() only
checks hierarchy_allows_attach() and that the flags match the existing
ones.  It then overwrites pl->prog and calls bpf_prog_put(old_prog) on the
existing single entry.

Sequence:

root:    attach P1 to cgroup C with flags 0
caller:  BPF_PROG_DETACH(C, P2)         -> -EPERM with this patch
caller:  BPF_PROG_ATTACH(C, P2, 0)      -> replaces P1
caller:  BPF_PROG_DETACH(C, P2)         -> pl->prog == prog, succeeds

Such a caller can exist, for example when P2 was loaded through a BPF token
in a user namespace (bpf_prog_load() uses bpf_token_capable(token,
CAP_NET_ADMIN) for net admin prog types), or when a process loaded P2 and
then dropped its capabilities.

Multi-attach mode requires the fd of the prog being replaced (BPF_F_REPLACE
with replace_bpf_fd), but the non-multi path has no such requirement.  A
caller with no prog fd at all is still blocked, because it cannot attach.

This is pre-existing code that the patch does not touch, but should
non-multi replacement in find_attach_entry() get the same check?  Or should
the commit message say that holders of any prog fd are trusted to replace
the attached prog?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41340841959
--===============1514127261929035531==--
