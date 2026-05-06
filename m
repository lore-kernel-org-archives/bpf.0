Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F447B426
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075291; cv=none; b=VJfmAy3cTXLxt9qqEGqNYAKQqke+NdNqdb0PnmXiMBB9xIxSOweE2af18BcHPz57VkUownYgYtjs5G0TRlT/MxvtjT8sKpCpeEyTujKN6CwgTJWZd8i0UmcRNnf7+7R1mIQtQEBgNh7N7yzLi2alUwxVM/Nf1nCm6YyGuTsig28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075291; c=relaxed/simple;
	bh=6GHtExQubeMxpeJiswlQKfR+TsNt5IrTuelxa9x+GyI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U5/8Ssjv/DMkyBESw0VLCpABy/FyycO7CMpeVPhVhj/XK9PXXifdP6hycpQ79VACbgS85nW6oIMU00QrMa3THwW5Lles1gcdaHsVYXB0uXmNyyD+6n3aV2bZ3ng0LJxyHXupL47sPQ8jUK1+7sl2X9d1UgSUymmKNZ8fbh5BXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDCqQJxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDCqQJxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B7EC2BCB8;
	Wed,  6 May 2026 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778075290;
	bh=6GHtExQubeMxpeJiswlQKfR+TsNt5IrTuelxa9x+GyI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rDCqQJxm1VF60Fawh97NT00nznqLgfyUHCDep4lS9N4TTZc7q69FRgU+AOk5ObUee
	 3J9uY5v62EQ4wzocRfLPPko65he6e2NsIQhCoWvRklcsb5AKj4LOgZWSidnSTzDUuz
	 J7oV+N2/STNgWU68/X/beg/MidTMa/pLdZFpE8PBke6Eq4nVSToRCypVlKLni/FpKt
	 AE6M/uUCZ2J57VT6g4qWCghjAOwVKIGleix+G0Jun0ZryT4Zk5JSRcOD42oo25DJNi
	 IHx7rMq8zg1tXWDjUYpNn8tPhE2xD3AvgGQmiP3xqo3oy9qE/usTLeN/Xm9gnNWEVs
	 Okz4nK6Bgn6Dw==
Content-Type: multipart/mixed; boundary="===============0210074992846174355=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b5ad1207e0bbfefcf69010a405531b6fa0670744fb0e7dc7cf9adb24549313e3@mail.kernel.org>
In-Reply-To: <20260506131257.713895-3-paulhoussel2@gmail.com>
References: <20260506131257.713895-3-paulhoussel2@gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: add tests to verify the enforcement of CONFIG_CGROUP_LSM_NUM
From: bot+bpf-ci@kernel.org
To: paulhoussel2@gmail.com,paul.houssel@orange.com,andrii@kernel.org,yonghong.song@linux.dev,paulhoussel2@gmail.com,kpsingh@kernel.org,ast@kernel.org,song@kernel.org,martin.lau@kernel.org,christian.koenig@amd.com,fw@strlen.de,tjmercier@google.com,lirongqing@baidu.com,paul.chaignon@gmail.com,alibuda@linux.alibaba.com,kuba@kernel.org
Cc: sdf@google.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  6 May 2026 13:48:10 +0000 (UTC)

--===============0210074992846174355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 24855381290d..e4c5dd86c640 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> new file mode 100644
> index 000000000000..0cce61cd7b26
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Orange */
> +
> +/*
> + * 12 LSM programs with lsm_cgroup attachment type, each on a distinct LSM
> + * hook. Used by prog_tests/cgroup_lsm_num.c to verify that the kernel
> + * enforces the CONFIG_CGROUP_LSM_NUM limit on unique per-cgroup LSM hook
> + * slots. With CONFIG_CGROUP_LSM_NUM set to 10, 10 shall be attached and 2
> + * rejected.
> + */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("lsm_cgroup/socket_create")
> +int BPF_PROG(hook0, int family, int type, int protocol, int kern)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_post_create")
> +int BPF_PROG(hook1, struct socket *sock, int family, int type,
> +	     int protocol, int kern)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_socketpair")
> +int BPF_PROG(hook2, struct socket *socka, struct socket *sockb)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_bind")
> +int BPF_PROG(hook3, struct socket *sock, struct sockaddr *address,
> +	     int addrlen)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_connect")
> +int BPF_PROG(hook4, struct socket *sock, struct sockaddr *address,
> +	     int addrlen)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_listen")
> +int BPF_PROG(hook5, struct socket *sock, int backlog)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_accept")
> +int BPF_PROG(hook6, struct socket *sock, struct socket *newsock)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_sendmsg")
> +int BPF_PROG(hook7, struct socket *sock, struct msghdr *msg, int size)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_recvmsg")
> +int BPF_PROG(hook8, struct socket *sock, struct msghdr *msg, int size,
> +	     int flags)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_getsockname")
> +int BPF_PROG(hook9, struct socket *sock)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_getpeername")
> +int BPF_PROG(hook10, struct socket *sock)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_shutdown")
> +int BPF_PROG(hook11, struct socket *sock, int how)
> +{
> +	return 1;
> +}

Could these 12 BPF program declarations be refactored using a macro? The
implementations are identical except for the hook name in the SEC() attribute.
A reviewer previously suggested this approach to reduce verbosity since only
the attach point changes between declarations.

Reference: https://lore.kernel.org/bpf/afs_CIQUer2tfh_3@mail.gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25437889223
--===============0210074992846174355==--
