Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695189;
	b=Xkw/4eUseu534/UZEneUZ4K+RdnigdLQ5HTltKebjqGljP3rk0KHXm479AcBGwvByACY
	 S6S2LO8Adrh7IFOL5+AaL/J/fzFer6bQUm3N82t0BdcK7z4ydDJVGz8QCBS4PJMDHfxnF
	 RjDFYq14ZrzMHgQvtc2cEsjlH8MpqrrdDQ15Y5tOqonBBx7ZaYrwgb+Ej6YnxUxTbCCs/
	 LjLiSUBwM6cVx6L3aPy9PgQ3uDProatS/Xc1/L68CQyTn9kJ+0zmKbh/RfFLP3nUdXqKZ
	 g+mISZ862kakah4NYCLgmRSNNyZSiVsCD2Zxt8TlJW4CqdDuBFqJ+8CAoVV3W4f6dOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695189;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Lx72p1lVsfYHQLEawleuzl6MVpu20ohq4n3mluAj6XQ=;
	b=k9mbZeGa2KQ/ARussc3ZOQ9kwpMS/rpASAc3Yz+wvQ656Cp6hcMEzb+xgkqCGm+/mFw7
	 aF+PugzWf/2lKbHswdSmD8tJ27H+eLfZLsVhzGVF77Q4+Z5l2to7JIf0+mN/1Dljrejlf
	 xMWs46d6Hk0kh7AgMu19axROxNGLI7Ou8tXetO8dYQgZAl/3Qd+JK2x/8AzjORzVGz1Yb
	 HktGPgEILWcrwA9tASX/U2v9fRB5aWa9l8KDrNscu6UfsHv06KVaqGDU2njGq2GWgKtKu
	 Z8rZ8IZteHDrpGuUaV/lyjUBna8kD5/vWGH3mGtpFZ5DyU1lEqGgWqlxSVPuzZ7cLkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAM5KWJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E95E606A337
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAM5KWJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBDC1F00A18;
	Tue,  3 Nov 2026 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695189;
	bh=Lx72p1lVsfYHQLEawleuzl6MVpu20ohq4n3mluAj6XQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XAM5KWJjPb2vmDAgw8Sg+o6J4pTPTe5jEBXNkxRuKxYRVd2v569X4RnKBrlvpgq/d
	 zlHcqXy6tRoq/WQkeRxoRVcbodhVf5RjdpeZlBx/L+Pc0il/q/ndacgNcyDuAUvcO2
	 DbbKEub6EN+7P+6FMMNduebEpGd7GAiY508KcHnymynUecCGM806ZUrnxl7F708RV/
	 YihSxxWaS7mR9PZgX0XTopnz2frH12+DrGlXzVt4fhwtOMfNNrg0gaCLL79gjbN+0C
	 lgKLLWy1c98qgnZPg5c25I5bByWjdK89Go6f/AclrezaHCjKU6VGpt7xCiujGKmXqA
	 GLzFpE6n4lftQ==
Content-Type: multipart/mixed; boundary="===============0296960252652514333=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <28b71b95a782f28f081233a18a48ab18cfb5483df6ec6980f8168cbecfd93543@mail.kernel.org>
In-Reply-To: <20261103075916.100050-9-jolsa@kernel.org>
References: <20261103075916.100050-9-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 8/8] selftests/bpf: Test user memory kfunc errors
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ljs@kernel.org,john.fastabend@gmail.com,nierro92@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 08:39:48 +0000 (UTC)

--===============0296960252652514333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test user memory kfunc errors

TL;DR: Test nit only: the user_mem_kprobe() selftest looks redundant with
user_mem_nonsleepable(), since both have the same body and expected failure
and load as the same program type. One may be droppable.

> diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
> --- a/tools/testing/selftests/bpf/progs/user_mem.c
> +++ b/tools/testing/selftests/bpf/progs/user_mem.c

[ ... ]

> @@ -80,3 +80,32 @@ int user_mem_test(struct pt_regs *ctx)
> +SEC("?uprobe//proc/self/exe:user_mem_trigger")
> +__failure
> +__msg("program must be sleepable to call sleepable kfunc bpf_user_anon_mmap")
> +__msg("cannot be used in non-sleepable program")
> +int user_mem_nonsleepable(struct pt_regs *ctx)
> +{
> +	bpf_user_anon_mmap(4096, 1);
> +	return 0;
> +}
> +
> +SEC("?kprobe")
> +__failure
> +__msg("program must be sleepable to call sleepable kfunc bpf_user_anon_mmap")
> +__msg("cannot be used in non-sleepable program")
> +int user_mem_kprobe(struct pt_regs *ctx)
> +{
> +	bpf_user_anon_mmap(4096, 1);
> +	return 0;
> +}

This isn't a bug, but user_mem_kprobe() has the same body and the same
__failure and __msg() annotations as user_mem_nonsleepable() above it.

Since SEC("kprobe") and SEC("uprobe") both load as BPF_PROG_TYPE_KPROBE
and the attach target is not used at load time, does user_mem_kprobe()
test anything that user_mem_nonsleepable() does not, or could one of the
two be dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41602296728
--===============0296960252652514333==--
