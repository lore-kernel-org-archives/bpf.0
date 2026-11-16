Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811145;
	b=iNPS9ysHwtEj3ykkrdg1lt5PRb0NzEDO2hI5I0vv8fshTDaKF4Nb6bHq8UU1fm82sAvY
	 wiPvzM+S35pD4WqIQOigU54zHgNZ1/WYFeQe1VQUoHDV9INqIZlmVs8CflayjFqAIDjoW
	 Dhb8bx324YtA4ClF7oQLb5nn6xzj2MRKJLI/bz91zaCyXYZY62HJ88hwLZbHKNa54M80h
	 obbpTZz5qxjAtD29CdqLOTYZaX5uQl0lkAnpOcNXwuzZ9LqrIY/5/C5HAFTMOAECT1r71
	 ln+EQizakPbyJM+Vp6M3xxoQRzA2ahwKwfcZs+C5H5K+16oOIhFJXMDu8ThTlTkpJew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811145;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=dJgZhcMv7ea2YBuJvrkc+dUHwjxJcFg1LZOPQGAMgg0=;
	b=fbHBM/pyKggEJrAoGbn9YRlSDS8gOl2SFpKJPxiaIJNYUQFnoLDoZxfgDnWBVFaAdnA7
	 b9zXM0MWaXeTfWgCx6bX34xajZOaKk7+jsz/o66ymylkuRLIiqIVOHH18cuVt2dF3FNxb
	 Lw2a4lr5kevhavT6vZotM8T+aM02JuYDQVemZpRbiioImFviuNfGZ+fpXngQzkIWcaPxe
	 ZKP2inWWglYvYzRRK1hkG9GUPx6N+bglFmpBGb3OZ3do7YHQCA8fSCY+sud3fyJzdji8X
	 U9ftk5AtQhGHRmjET49YnI6i5+sePLRku4Bgi2+prdFd2iO/IKOADtfMm06xri5dzfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4SQa783;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4960606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4SQa783
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62CB1F000C4;
	Mon, 16 Nov 2026 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811145;
	bh=dJgZhcMv7ea2YBuJvrkc+dUHwjxJcFg1LZOPQGAMgg0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=L4SQa783/ufXhlkTvVrQkafDNAd1oWtWeeb5cB+5XOYz0ACKnfsBDsqi/d0yn1M79
	 0RAKT4to5/ATgwfeY2o5JuxfvrijhPot49Y8lNpPIiG1XFyVPjAb81x9L3npCpQaVj
	 U0n+JbYjGiMyeo92wN2ktI3Um6Kjp4Wjy7val15wILyGeEiU57oZTfcVQeoFm0fU9M
	 U4OUkpg+LObXCRNyljUlOozbLRg5IdZcNR5h74La28eqba4zB38HFGMwKKRtvWkWCl
	 Dg74ajYFPDvrgf8ZXLgHPhjPmcZWpD8eFZAv5IpOmhQD1WebzVkcPtKH4zLK0AJWJo
	 9nl3jKrUCisHQ==
Content-Type: multipart/mixed; boundary="===============7742321736229767026=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4e73a33b07c44378b126d92568d7ec76b6e2a4828d86291e544014ede68b58e3@mail.kernel.org>
In-Reply-To: <20261116055638.4171529-2-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 01/21] bpf: Stop a load only when the loader is killed or has to freeze
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 06:39:04 +0000 (UTC)

--===============7742321736229767026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Stop a load only when the loader is killed or has to freeze

TL;DR: The -ERESTARTNOINTR conversion in SYSCALL_DEFINE5 may miss commands
with BPF_COMMON_ATTRS set, so a load or map create frozen mid-verification
could return EINTR to user space instead of restarting.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -6604,7 +6604,13 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>  SYSCALL_DEFINE5(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size,
>  		struct bpf_common_attr __user *, uattr_common, unsigned int, size_common)
>  {
> -	return __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
> +	int err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
> +
> +	/* bpf_must_abort() ended the command, nothing of it is left */
> +	if (err == -EINTR && task_sigpending(current) &&
> +	    (cmd == BPF_PROG_LOAD || cmd == BPF_BTF_LOAD || cmd == BPF_MAP_CREATE))
> +		return -ERESTARTNOINTR;
> +	return err;
>  }

Can this comparison miss callers that set BPF_COMMON_ATTRS in cmd?  User
space may OR BPF_COMMON_ATTRS (1 << 16) into cmd, and __sys_bpf() clears the
flag only in its own by-value copy:

    if (cmd & BPF_COMMON_ATTRS) {
        ...
        cmd &= ~BPF_COMMON_ATTRS;

In SYSCALL_DEFINE5, cmd is still for example 0x10005 for
BPF_PROG_LOAD | BPF_COMMON_ATTRS, so none of the three comparisons match and
-EINTR from bpf_must_abort() is returned to user space.

For example, if the cgroup is frozen during verification of a
BPF_PROG_LOAD | BPF_COMMON_ATTRS call, bpf_check() fails with -EINTR and
bpf() returns EINTR after the thaw instead of restarting.  Before this patch
that case returned -EAGAIN, which retry loops such as libbpf's
sys_bpf_prog_load() handle; nothing in user space retries on EINTR.

This also appears to contradict the commit message: "system or cgroup
freezer  stops, the task freezes, bpf() starts again" and "The restart is
not visible in user space."

It becomes reachable from libbpf itself later in the series.  Commit
34298ce5cf25 ("bpf: Walk each type once when looking for special fields")
adds bpf_must_abort() to btf_find_field(), and map_check_btf() passes
ERR_PTR(-EINTR) from btf_parse_fields() back up.  libbpf's bpf_map_create()
with log_opts goes through __sys_bpf_fd() -> sys_bpf_ext_fd(), which sends
BPF_MAP_CREATE | BPF_COMMON_ATTRS, so map creation can now fail with EINTR
when the loader is frozen during map_check_btf().  SYSCALL_DEFINE5 is
unchanged at the end of the series (a9ddecf27d8a).

Would masking the flag before the test, for example
(cmd & ~BPF_COMMON_ATTRS) == BPF_PROG_LOAD, cover these callers?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43815411838
--===============7742321736229767026==--
