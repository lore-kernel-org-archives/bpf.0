Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FF3FE344;
	Wed, 12 Aug 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528680; cv=none; b=UvlgiAest/Rflfm9uGzrJp2sSlbHVDMEfPWG3Kj7f+aFg2LypkvpAs+ov5IC4BAuW6OjXTc+9LRZLSPk6kVy5/emmaUTwQA0rngE1KsW3C2vjZT/YuM0CmgtFvSFmisgExsVU7Lwj9JxFfWGN9/UWZjB8Q9vbSAX8PP4m//y/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528680; c=relaxed/simple;
	bh=5zncZcxIRPa3eufXFkgxxQZad1daY0RVPsE9a28bMXU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UXyKGY4zFQggb1HBficj2dch7/YvfeCNK+PyL6R+QXI/5CgTM/CdZXAqsj9cykY3skVH6X49e1FF7eB7saIlBkLyY1ungxi0+xBdRot3oddM3u/964S05fpMp/3zNa9Yh4MzW5dawJRSFANweCsVpgfh67HeVFRLdtpbAzTe6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO9LEbIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO9LEbIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187AF1F00A3A;
	Wed, 12 Aug 2026 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528679;
	bh=nBfkeXkDttAePNJS88TfKNU7LOjN23DdXIk0GuOlpZY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mO9LEbIJuwV+Cqm9TUTON2Cq1a3vxrog1qh29BiH5D6opObe67j4PVqUq2rjjJoou
	 PU/azuDzR6jWesXQEhzqWLcOb8Za+2EB+zcwwtH5Zhu6LJRsW7HWEObwXOJ8VXfEtt
	 ANtKLVrK/Xv/PSF/2SBRr4sNnWsucJDoZsaGaAahSODShU/GZ+wPgZb737m+w/gOS7
	 xwPtMy0/XoMIlzBp5s93PEKkPGB2H03aTueCvFTPFU6kgTeWtQYDm34Ksvjf0z4oCa
	 M+t+ezjI00SpX3BRQl2yvrfebs6I69gzjjRzBMotlHQsPYg0U8fFKe/+J8krSWdfAI
	 JLjG46kJnxzlA==
Content-Type: multipart/mixed; boundary="===============2264567004168986464=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <24a9298eed591e7d7e31d4d6f0d652d276292fb7d575b57397d3c2e055912739@mail.kernel.org>
In-Reply-To: <20260812091654.244752-1-zirajs7@gmail.com>
References: <20260812091654.244752-1-zirajs7@gmail.com>
Subject: Re: [PATCH bpf] bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX getname hooks
From: bot+bpf-ci@kernel.org
To: zirajs7@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,kuniyu@google.com,emil@etsalapatis.com,bpf@vger.kernel.org,netdev@vger.kernel.org,rhkrqnwk98@gmail.com,daan.j.demeyer@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 09:57:58 +0000 (UTC)

--===============2264567004168986464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 16845987b244..1e80a52ef86d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8350,10 +8350,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		case BPF_CGROUP_UNIX_SENDMSG:
>  		case BPF_CGROUP_INET4_GETPEERNAME:
>  		case BPF_CGROUP_INET6_GETPEERNAME:
> -		case BPF_CGROUP_UNIX_GETPEERNAME:
>  		case BPF_CGROUP_INET4_GETSOCKNAME:
>  		case BPF_CGROUP_INET6_GETSOCKNAME:
> -		case BPF_CGROUP_UNIX_GETSOCKNAME:
>  			return &bpf_sock_addr_setsockopt_proto;
>  		default:
>  			return NULL;
> @@ -8373,10 +8371,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		case BPF_CGROUP_UNIX_SENDMSG:
>  		case BPF_CGROUP_INET4_GETPEERNAME:
>  		case BPF_CGROUP_INET6_GETPEERNAME:
> -		case BPF_CGROUP_UNIX_GETPEERNAME:
>  		case BPF_CGROUP_INET4_GETSOCKNAME:
>  		case BPF_CGROUP_INET6_GETSOCKNAME:
> -		case BPF_CGROUP_UNIX_GETSOCKNAME:
>  			return &bpf_sock_addr_getsockopt_proto;

Is this removal a deliberate ABI restriction? Programs that previously
loaded with expected_attach_type BPF_CGROUP_UNIX_GETPEERNAME or
BPF_CGROUP_UNIX_GETSOCKNAME and called bpf_setsockopt() or
bpf_getsockopt() now fail BPF_PROG_LOAD with 'unknown func
bpf_setsockopt#...'.

For BPF_PROG_TYPE_CGROUP_SOCK_ADDR, bpf_prog_attach_check_attach_type()
requires an exact match:

  case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
  ...
	return attach_type == prog->expected_attach_type ? 0 : -EINVAL;

in kernel/bpf/syscall.c (bpf_link creation enforces the same check).
Gating on prog->expected_attach_type at verification time cannot be
worked around, so any working deployment can stop loading its programs
across a stable point release if this patch lands in stable kernels.

An alternative fix exists that removes the bug without removing
functionality: run the hook under BPF_CGROUP_RUN_SA_PROG_LOCK (as used
in unix_connect, unix_sendmsg, unix_recvmsg in net/unix/af_unix.c),
which wraps the run in lock_sock()/release_sock(). inet_getname() and
inet6_getname() take lock_sock() themselves, which is why the INET
GETPEERNAME/GETSOCKNAME labels can safely stay in the lists. Only
unix_getname() runs the hook without acquiring the socket lock (it uses
smp_load_acquire(&unix_sk(sk)->addr) instead).

The design intent points the other way: beecf11bc218 ("bpf:
Bpf_{g,s}etsockopt for struct bpf_sock_addr") introduced these helpers
with the explicit assumption that 'context sk is already locked and
socket lock is non-nestable', and cgroup_common_func_proto() in
kernel/bpf/cgroup.c already returns NULL for bpf_get_retval/
bpf_set_retval on these same getname attach types, so per-attach-type
helper gating has precedent.  No in-tree selftest breaks.

Should the changelog state that the removal is deliberate and that no
users are expected, making the ABI trade-off explicit for the maintainer
and for stable? Or explain why locking unix_getname()'s hook was
rejected as the fix?


>     _bpf_setsockopt() and _bpf_getsockopt() call sock_owned_by_me() for
>     full sockets, so these helpers expect the socket lock to be held.
>
>     BPF_CGROUP_UNIX_GETPEERNAME and BPF_CGROUP_UNIX_GETSOCKNAME run BPF
>     programs without acquiring the socket lock. A program attached to
>     either hook can therefore trigger the sock_owned_by_me() warning by
>     calling bpf_setsockopt() or bpf_getsockopt().

Is describing the impact as triggering 'the sock_owned_by_me() warning'
accurate?

sock_owned_by_me() is a no-op unless lockdep is built in:

  static inline void sock_owned_by_me(const struct sock *sk)
  {
  #ifdef CONFIG_LOCKDEP
	  WARN_ON_ONCE(!lockdep_sock_is_held(sk) && debug_locks);
  #endif
  }

in include/net/sock.h. On a production kernel without CONFIG_LOCKDEP
nothing is printed at all, so a reader may conclude the issue is
debug-only and does not warrant a Fixes: tag or a stable backport.

The actual consequence is that _bpf_setsockopt() proceeds
unconditionally after the assertion:

  if (sk_fullsock(sk))
	  sock_owned_by_me(sk);
  return __bpf_setsockopt(sk, level, optname, optval, optlen);

in net/core/filter.c (the same shape appears in _bpf_getsockopt()).
AF_UNIX sockets are always full sockets (sk_fullsock() is true), and
unix_getname() runs the hook with no socket lock at all. So a BPF
program on these hooks mutates socket state through sk_setsockopt() with
no serialization against concurrent socket operations.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31583057641
--===============2264567004168986464==--
