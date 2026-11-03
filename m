Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695188;
	b=WHGXg07EEq67PUgrniopMin+TG1sVOcGbQ/RaLvISyzzT7vrsXr905atYG0BUu/vK6JI
	 zWAwlH9hWiz7gaVjYXVImfG0dSmW3KSxv1aXs1kVvTToZAbMXmfTjTfXUl+2OkzjrrGfg
	 FtNQ/0Gm0L8c951lnvpsKpG8xVXpbxjtfMoyMa8UzFT27QxDt61ewTfiL44PLAq6Qhoe3
	 IkCFYUrCWVCUiQyCD63gBr546VJJR5lHP7UXVKzJr1VswHi9ia5vsTNEe4qPPDgMTzf9G
	 GP1+88RSxHKNEUvVichB7PYPlqikhb1EaE7dkaH3GvSUvAJc4sSATU6QUX+YYk4EZNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695188;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=P1Qq20HbOq3rcG+W44qN/ITtiwiepD/zoxsaXvI4zBg=;
	b=mRHzAzsPmJY3VITifmBNBjrldrTBS+qx+gJ7K+fwERtMyQ+ZX/ECKAxQuVzbpxz0e4lM
	 i1B6GpQNTwXoFfArBa27tpR+RJNH1k3o6ZP7yDF86frknxtB6rx6ocBtdZwp9XvEOHWoo
	 W/9810YRvWWSHmloBiNpAfCGe2Kf38VbBodXqa99Fp4zsXyWJKYNBjBf3AoWbCDVVKL7B
	 CdHe3GGBdLSnN+Wk+dxR3vW7xzlG7SnU3liYR46N+ew4Ps6VEowhuLbTcJ4QS+MMhApyz
	 8nGYU3LTNc0jjA9ENiM+bW79yVBQ+p3RmtS/MnXytxoQmxGQiY/PUsZqwPtetYcuEmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5T2k1U8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691A606A32E
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5T2k1U8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2111A1F000C1;
	Tue,  3 Nov 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695187;
	bh=P1Qq20HbOq3rcG+W44qN/ITtiwiepD/zoxsaXvI4zBg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m5T2k1U8PNPjEgmq3Y2NTT8s3l+K9pUXOtfVuxx3tAftAdsG8GPTO8MVi2YAqQGhG
	 JUwM10P9d7QtfmvOWBCs6BjJTGg6CZU+qwmcPf+LJ6r/ns0oY3mO1fdUX71+8cNCoP
	 2FlIwyt5zmfkCCVaO1j3KD3wU/bDlkIzhkyDRQdvUZAzACvjqpZUISjlMhSMA0zbrT
	 yAY/7J6kxZS9j00UG26rm72DNadEOoGLjQAoCXz5hqpS9uUqVXYAytPfa4W5AAJ+0S
	 jCrc7hBdsTLCYdLqQg7Z2Bk2pSmQPoG4Q5D8hR3BSVpNlJl/3vNr3uZWnDU2paTI3N
	 cmUBzknDIEVUA==
Content-Type: multipart/mixed; boundary="===============6944307499286553141=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f140cba1c8d3bbefc759df505554da49c4ffea61ed0684ddb9f1d3c6effa529e@mail.kernel.org>
In-Reply-To: <20261103075916.100050-7-jolsa@kernel.org>
References: <20261103075916.100050-7-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 6/8] selftests/bpf: Test user memory page exec
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ljs@kernel.org,john.fastabend@gmail.com,nierro92@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 08:39:47 +0000 (UTC)

--===============6944307499286553141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test user memory page exec

TL;DR: Nit only: in user_mem.c selftest, the bpf_copy_to_user() ksym
declaration names its second parameter src__srcptr, which may not match the
kernel prototype's src and isn't a recognised verifier suffix.

> diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
> --- a/tools/testing/selftests/bpf/progs/user_mem.c
> +++ b/tools/testing/selftests/bpf/progs/user_mem.c

[ ... ]

> @@ -10,10 +10,13 @@ char _license[] SEC("license") = "GPL";
>  
>  extern unsigned long bpf_user_anon_mmap(unsigned long len, unsigned long prot) __ksym;
>  extern int bpf_user_munmap(unsigned long addr, unsigned long len) __ksym;
> +extern int bpf_copy_to_user(void *unsafe_ptr__ign, const void *src__srcptr,
> +			    u32 src__sz, u64 flags) __ksym;

This isn't a bug, but should the second parameter be named src, as in the
kernel prototype of bpf_copy_to_user()?

The __srcptr suffix looks like a verifier annotation, but the verifier does
not recognise it, and it sits between unsafe_ptr__ign and src__sz, which are
real suffixes.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41602296728
--===============6944307499286553141==--
