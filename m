Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6173F075A;
	Fri,  5 Jun 2026 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686535; cv=none; b=KggaTwqrcT4QURjzWCgR5GfFQeDF5icS354ZaLxayQMtNhhRRuGloiftGZF98JlBDYPGKq8XOcN7RXKU9j9E5DvSSbtujcYy3RNvtQRz2vUUUVsZKq1fpxi2uaSEvJkG2rP8KmvWXusUPFHJLbGAzotn+TAa99wW27M/zFV9Hd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686535; c=relaxed/simple;
	bh=3DL/LpvyUq4LonJwd/lyFJqbPQGAHBZMHDkJ7spP++o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JRlWBPq8mI4v5Xq5OuWBwR/LeVJGBszNmzDfHmgnf9Ix7MJoKR8+z51l/kFbxFeFuoKMz9LLuyEyI4FKxgXTBKHNv7MwvEyAhs09bkfdj7//LiNqLEAH6WKe7lhzfYAuLL5dJIGLN0YBSKy8v66MqwK6t/z/kfMWBPOUHDi7Yws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx15zSB0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx15zSB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D821F00893;
	Fri,  5 Jun 2026 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780686534;
	bh=q6qqrSbjMEYTyY2+C+bT1l6eDfMipQNqFU3HH5CfK+s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gx15zSB07Kcd7e0URuPQrwrz2SGDJYPZNx9I0+bNLOC7Z4eAcYMNlU8+rvLG6GLys
	 aoHitcJMgMx+uVU27yDkv+Kha+HsaoSR1fWvW5xcZ+Lt4pxgBdRaR5ms2+RTNlkJpn
	 MPAl9cr0UNcTv90gO9ylX0pl5nAVnhUw4IH76JFwFEEycCumtV6YyjbF5AOdUawYW5
	 yqoHPBo2Iikxpx6mWgP+fpI2sWdEAIH7DUbpxj73K0dIOS7xj6SoeiQOSKbGbMtKOb
	 okdI4khZybTRyv+JAr5RCBtWVoo495PW2W6y6p989ndBy7z30dsO7gxD9J4xXQVaQI
	 Jeb1lK591AHaw==
Content-Type: multipart/mixed; boundary="===============7693173522675949626=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7e270031a11c9c839dde64ca32cdedda701639a999fc824c9dd135433e8d12b6@mail.kernel.org>
In-Reply-To: <20260605183551.969144-6-ameryhung@gmail.com>
References: <20260605183551.969144-6-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 19:08:53 +0000 (UTC)

--===============7693173522675949626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> index d5fae5e4cf9a..3bb9e2612f8f 100644
> --- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> @@ -87,7 +87,8 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
>  	struct task_struct *task = bpf_get_current_task_btf();
>  	struct file *file = bpf_get_task_exe_file(task);
>  	struct bpf_dynptr dynptr;
> -	char *data;
> +	char buf[1];
> +	const char *data;
>
>  	if (!file)
>  		return 0;
> @@ -95,15 +96,14 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
>  	if (bpf_dynptr_from_file(file, 0, &dynptr))
>  		goto out;
>
> -	data = bpf_dynptr_data(&dynptr, 0, 1);
> +	data = bpf_dynptr_slice(&dynptr, 0, buf, sizeof(buf));

A note from the earlier review on v1: an automated review bot suggested
initializing the stack buffer here, e.g.

	char buf[1] = {0};

worrying that the uninitialized 'buf' passed to bpf_dynptr_slice() could
make the verifier reject the program early with an invalid stack read,
which would bypass the intended reference-leak check.

This looks like a false positive, since the buf argument to
bpf_dynptr_slice() is a destination the helper writes into, so
uninitialized stack memory should be valid there, and the v1 patch
already carried an Acked-by from Eduard Zingerman.

Was this comment considered, and is the test still failing for the
intended reference-leak reason rather than an early verifier rejection?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27034008594
--===============7693173522675949626==--
