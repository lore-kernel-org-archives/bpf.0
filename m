Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286241;
	b=xpptZyNeUp5BCrHc54Dqdv0EVENHlszZss/S5chXA4C+keBG85Cgkwu5nQw/igaiQ1X8
	 qx4IreE4wHxHQs3zi/+bC4R3oLSpifozeEsWLzEeYukAQ3rN0NTomeljIt397r2p/5Jm/
	 t1MhvUHSFzcxaGaaxBmPXsdICWNd9vOaj1TF0Q4wrfLy4b40vWURH+a+LFlLQxRNMuqYC
	 o6YYwbWMl8rNYYxXFpUs2uU3DH4yfXY3n8X0VjCKHLgZu8LJduegykacEmBgAmJDUCVoG
	 HAvZnwBrBfAdx0LqBYkxMr2Soa8BQtkfKlyySMvqIlkJUB26LXR/7Jo93+vRbcqDXzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286241;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=gXecaWd+i8Q2i3lrDZCJvbvb1cqh2i41dTV8pTGFnPI=;
	b=EbeNBgVlgZ18UJqgF2voIcIwbR6KjbWUpyD9gdkPUbVe7SDKDEIDs32i31FZ4bPMxGDN
	 OA0teb+l+qQi3t5U7yQ70zqF5CXFlIiAH+YJ5v+kFOFXy1dPR5e0iTx9Y/OgWgV71SlSF
	 YvTK54FRRMf5t3WBzC2pxaDAU9EbHphnUanGm+xw1QWTApVhWbVkcX6Sw9VRrm7Kcm0nr
	 ljLs5iUki/nuk72rXfwuNG7jvjAjtw/KQ6VvjsrRwyY62Nj4doykgZsHKxJbqiiHH1GiT
	 avnZ+dvovDtGX/WfvrbY9rd5t7UJrAhGkfXB7rg+P7LTDVCVKXiTgo9x0BFiqy7spGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xv1xt1We;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6D606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xv1xt1We
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4726B1F0089F;
	Tue, 10 Nov 2026 04:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286240;
	bh=gXecaWd+i8Q2i3lrDZCJvbvb1cqh2i41dTV8pTGFnPI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Xv1xt1We+ClE7x5Sbon3zzoB8mNX3wickBWS+/DM5Lvqlfx+G7Sm4fRylDEfMQy4x
	 XKSG0/+DgkoAD9EpFblzkjwwVrtk5T5Et9Ve+J4AkDyDD8TEpL9ZLW454nUvriJgtd
	 bgoXV0SJKHQLkfw9itQmNrIhHen7VrXHiM5oNxH24J9rp88dwuVpsRzHyxRnynU4Sw
	 /AhuHim7+IAbXMAFgpD5LCu3ACeFhKTvfyoWq7xp+vPlDSmfpyLqJraZTuArOaB02B
	 W6Je/WrRanTeyLQ1Pn+/0TOnUTu/DgSgC/veKifSLcMRmS1kI00qCLp+Rs++mk2dfc
	 jrLTCAEnRf4FQ==
Content-Type: multipart/mixed; boundary="===============4952816233644553512=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <85f8bd7fcab6e512515f20353415e21e0d312b1e739756b4449b950ebb03e856@mail.kernel.org>
In-Reply-To: <9f1f608b4ee5e6f5e9f5807f95c7fe2fa60d5343.1794269507.git.memxor@gmail.com>
References: <9f1f608b4ee5e6f5e9f5807f95c7fe2fa60d5343.1794269507.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 18/20] selftests/bpf: Test BPF kthreads
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,shakeel.butt@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:50:40 +0000 (UTC)

--===============4952816233644553512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test BPF kthreads

TL;DR: Nit only, in the selftest: thread_sleeping() duplicates the
open/read/close sequence that read_file() already provides, so it could call
read_file() instead. Not a bug.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c b/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c

[ ... ]

> +/* Whether the thread sleeps: state 'S' in /proc/<tid>/stat, read past the parenthesised comm. */
> +static bool thread_sleeping(__u32 tid)
> +{
> +	char path[64], buf[512], *p;
> +	int fd, n;
> +
> +	snprintf(path, sizeof(path), "/proc/%u/stat", tid);
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return false;
> +	n = read(fd, buf, sizeof(buf) - 1);
> +	close(fd);
> +	if (n <= 0)
> +		return false;
> +	buf[n] = 0;

This isn't a bug, but could thread_sleeping() call read_file() (moved
above it) and test for a result <= 0, rather than repeating its
open/read/close/NUL-terminate sequence?

read_file() later in the same file already does this for
/proc/<tid>/comm in check_comm().

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755601621
--===============4952816233644553512==--
