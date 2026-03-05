Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64C3CD8C8
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726869; cv=none; b=giXIbo2B9TLYikzeYm/L1/YcmQ5P12hM3uektJnykUtrhE6LhJUCKXDrbGdy8t2E7gqkovK2Xh0ULQwXgyiGudfq+igXSH9NsLRptmy4X0gdedlsgDrxVWAdbYYooFdSp8hhnnaZ8jT7qrI2XgHB4/FzO2KTvIiTz9viPfO5D+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726869; c=relaxed/simple;
	bh=wyDdKhC6AKW647Gbkhu26+emVWAdaSBQi30bjN7YN3w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R1qlR29DUgWQNH2DgfMQRPPvt6inFLKqKjzzvuZaTQbUuIFUARHNfAvqz48KAU9p3CQiUylBSyZZgaJ94E1Bio01I2DbH3LM1F8crAOl14vbVMknIf1xyt3ZDS2qmoXblH2CmarAkBbsadxglFOZVt5so7N2Sy3Nw0OAJs3p8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2wgvQqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2wgvQqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B62C116C6;
	Thu,  5 Mar 2026 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772726868;
	bh=wyDdKhC6AKW647Gbkhu26+emVWAdaSBQi30bjN7YN3w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=F2wgvQqVxKdfAnM/h4+ZsUukCsf+1rEtKiIF3aEkq60uw+/4VHuY4K6v26LRABNNg
	 4PNHxqCMgC5qnHdPXmwpX1uZnZe7R51SbGHKI6zhQDVJQiuOJWg8wvO8Sy3Sflfd2k
	 v56YnymA34I0cJdYZp1meBzvm2032gRBOQ1GnnYmXUjUejzf1O8B9GbLf29eQ13Ly5
	 wNk7pVQ8bvSsPjRNShLcUeuVdOCr7ltx6cxqQBx635JA87T7JcBtdKjOGRFr273xBp
	 G2M+Dx1M7id/MLOKTUAkdBnUtiqUohjPWpjwce1WmvcLaLpb4j34czRdneynudG7K8
	 wGQAO+QGr7HxA==
Content-Type: multipart/mixed; boundary="===============3399455638811838457=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e21c875dcc2ec41524707acee1fd07bcd9dd3868cd6cdd63a9d7625c764271f3@mail.kernel.org>
In-Reply-To: <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
References: <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Always allow sleepable programs on syscalls
From: bot+bpf-ci@kernel.org
To: vmalik@redhat.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,shuah@kernel.org,leon.hwang@linux.dev,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Mar 2026 16:07:48 +0000 (UTC)

--===============3399455638811838457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d92cf2821657..cb80a3ddb7a4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +#else
> +
> +static bool has_arch_syscall_prefix(const char *func_name)
> +{
> +#if defined(__x86_64__)
> +	return !strncmp(func_name, "__x64_", 6);
> +#elif defined(__i386__)
> +	return !strncmp(func_name, "__ia32_", 7);
> +#elif defined(__s390x__)
> +	return !strncmp(func_name, "__s390x_", 8);
> +#elif defined(__aarch64__)
> +	return !strncmp(func_name, "__arm64_", 8);
> +#elif defined(__riscv)
> +	return !strncmp(func_name, "__riscv_", 8);
> +#elif defined(__powerpc__) || defined(__powerpc64__)
> +	return !strncmp(func_name, "sys", 3);
                                    ^^^^^

The other architectures use prefixes that uniquely identify syscall
wrappers (__x64_sys_*, __arm64_sys_*, etc.), but "sys" with length 3
would also match sysfs_*, sysctl_*, sysrq_*, and other non-syscall
kernel functions.

Looking at arch/powerpc/include/asm/syscall_wrapper.h, __SYSCALL_DEFINEx
generates names like sys_read and SYSCALL_DEFINE0 generates sys_fork, so
the actual common prefix for powerpc syscalls is "sys_" (4 characters
with the underscore).

Should this be "sys_" with length 4 instead?

> +#else
> +	return false;
> +#endif
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22725431483
--===============3399455638811838457==--
