Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D338F232
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692132; cv=none; b=S8QGmirCMSQwJSY3QXjLv1Xbdd1WpuuC/PXNckU0n4Uhe+yXVC9s42sPlRkFWQGzTv2fKUr+IIru05mzpk8pcTmF7qEjPUOL5bSoXKo/vXaafLR0NDNE4P5pXZJ3PgI0DC/VdJGzD7g9EIgnUt3IbYnUXPaPW4VCXsgKqd7rzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692132; c=relaxed/simple;
	bh=dKD3lfRLeU0Wy7T4Pw+z/UrywE1lZ4SnuD1RYTh1mdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tajW7yjwdieHQtacNkHs5vdLuZ+eQoVgXniDUI8SSjV7rjxNJGu3Q82eIcjOLipIWIb5Gqe+1r/dYnCAkf+IMmVDxtqsfqPGCRRLAzLZnG5F48LTq2G9VbTGbB8XN4Ws/LaX0dpozUCzOtVDkGyj/BP/JmWgTcwbYlQpRVN2EX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+zALwlX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+zALwlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4973DC2BCB4;
	Mon, 20 Apr 2026 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776692132;
	bh=dKD3lfRLeU0Wy7T4Pw+z/UrywE1lZ4SnuD1RYTh1mdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=e+zALwlX2ixvLWlrN2k3UYiVQsTNt3wUfc79gZlv9dsgZTkMvs7bx9hX2UYSXTzqb
	 DumRX6TLpWNSuJnK91XP5S97frYkvuuxsRJB9GKT9EAJ0F3ivsBvWhWykVyGR8m4i3
	 BwH5zU1qi3kk1MVGUFTPOFbrEcj0/chIZT8G2HQ3w6cmbR/BG+qtwnFpTNmsl9ruN3
	 ohysFlY1guJZDkClm9aHEzBEyjZcCfYopNOKiiLNQ0oaImSgCWUd5ECLNmdsz6VyGO
	 LtqmHMfZzg3rhtsi7oiRBEpKKnTlhvbYfPpn5WLeTBAvP24oe7awx9ElZSrbHffmSd
	 SscS4PQEcA9VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 2/2] selftests/bpf: Add LoongArch support
 for get_preempt_count()
Reply-To: sashiko@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420111516.19982-3-yangtiezhu@loongson.cn>
References: <20260420111516.19982-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 13:35:31 +0000
Message-Id: <20260420133532.4973DC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] BPF programs including `bpf_experimental.h` will fail to compile o=
n LoongArch due to a non-existent `thread_info` field in `struct task_struc=
t`.
--

commit 82453686fe5eacd9f219e2a050dc016b297cfc79
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Add LoongArch support for get_preempt_count()

This commit adds LoongArch support for get_preempt_count() in the BPF
experimental helpers. It enables bpf_in_interrupt() and related macros to
work properly on LoongArch systems.

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index e5c039bc44cb4..5847bbf12d240 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -507,6 +507,8 @@ static inline int get_preempt_count(void)
>  	return bpf_get_lowcore()->preempt_count;
>  #elif defined(bpf_target_riscv)
>  	return bpf_get_current_task_btf()->thread_info.preempt_count;
> +#elif defined(bpf_target_loongarch)
> +	return bpf_get_current_task_btf()->thread_info.preempt_count;

Will this compile successfully on LoongArch?

Since LoongArch does not select CONFIG_THREAD_INFO_IN_TASK, struct
thread_info is allocated on the kernel stack rather than being embedded
within struct task_struct. Because of this, the generated BTF and vmlinux.h
for LoongArch will not contain a thread_info field in task_struct.

Could this lead to a compiler error indicating that there is no member named
thread_info in struct task_struct when building BPF selftests?

>  #endif
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420111516.1998=
2-1-yangtiezhu@loongson.cn?part=3D2
