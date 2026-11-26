Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673050;
	b=VA8BGwU0AIwKl1nc+qtYMHUFpDDMv/mwP9g/nINvQii/J8Bp+ahHsQzmgcK0QP63rw/S
	 YBLMWtcXdGBMmdUDNH0zWCs6ND8vhkPlLdk3XFt1iL5jZLQWh5x+A6dTF0f9gIV8o6x6y
	 8QlVGdMAgTn93/6RvaBwZ2dJposgATof7Y4qPUpTDFtJZ5EujlTVkB2vUQZ0SkeAOoOxy
	 LwGO2+KC0/JP+8KLvcMNz1+Z31ORevtfyjZR5V6gaR5HeeRUbH0XCwoNNBUTBU2cEQUqe
	 lTWwMYNGoXMjuz1A85GBlidLZCiw1BxnRW19b3Q6DFzCIF5KYzED/2rHsqpZffebnew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673050;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+6BoYFUglSSc6mkUPhaVW51yracEdEviiXUN1lqnpTA=;
	b=Dvnh1hX+TkU5cqZaV3oc2raRrhYxsm0a89B7f6YwO1uAbkFrKSCyPXmi464j2m891r6A
	 u17DJxIPqOm98l2ozQ6lKJTiLmHeR48lkeNXJxX6L1RVOgWulbWCq+/tPQvocwCyhj0rM
	 FnfWMewk6X4dXd+p01uLe08XCyafvWqReOA/YOo4THzqLwprivRt7lGIMruEMST9G6WYa
	 Bl2EJIiLM5WlxYAe72zjlDyxK1QECE7iL/tyhX7ezBd2Lbye4r0tfrl2CZiRRmkJpw1Vv
	 TAGzBHlic3Kh3kIyDSl+v0YFG6c2Z5uOn/n76Tj06rfPS4tXAEOCtoDK/97BuZ0lLiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K588e/I8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDBD606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K588e/I8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160C81F000C0;
	Thu, 26 Nov 2026 06:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795673050;
	bh=+6BoYFUglSSc6mkUPhaVW51yracEdEviiXUN1lqnpTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K588e/I8n3S8owSVCIusNqF0jN1GO0jneQ6XLF7jvTZ6l/fyjTTFTGm4/v5ISWcDx
	 51NsQgvDeulxUICXu2AnckVCK77i7A0mCKQrqhYydyMERD0KMR7P6PSfpD1BzzXnR8
	 qHQHOYu7j+CROTZaT+FwynT0LSW2jgItuNSMoxVkmvR3UaY/ZP4c0qLq9mWcVFYmRj
	 trSMjZIaDFR2pDbzWuiHwGkRsYZynp3rRIi2nAq0oTx56letNrURH4OjeaqlacKosn
	 KpBARQ/VQK7/V6xxDnVCimL60OQRKISFdccSm/bzM7XcgWgETYIiwfh4M5TiF1jePf
	 wga6aGtDAM6DQ==
Message-ID: <sashiko-outbox-234819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/5] selftests/bpf: Enable 2 KiB private
 stack test for LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261126055355.9967-3-dongtai.guo@linux.dev>
References: <20261126055355.9967-1-dongtai.guo@linux.dev>
 <20261126055355.9967-3-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:04:09 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: private_stack_two_frames() enabled for
  unsupported LoongArch JIT
--

commit 65d887cfcad54f20dce9c27e1aed6c9c9985bbb9
Author: George Guo <guodongtai@kylinos.cn>

selftests/bpf: Enable 2 KiB private stack test for LoongArch

This commit adds __arch_loongarch to the private_stack_two_frames test in
verifier_large_stack.c.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/t=
ools/testing/selftests/bpf/progs/verifier_large_stack.c
> index cbabb41d973c8..f25455d628d5c 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_large_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
> @@ -248,6 +248,7 @@ __description("private stack: two frames of 2048 byte=
s")
>  __load_if_large_stack()
>  __arch_x86_64
>  __arch_arm64
> +__arch_loongarch
>  __success __log_level(4)
>  __msg("stack depth max 2048")
>  __msg("subprog 0 (private_stack_two_frames) main {{.*}} stack 2048")

[Severity: Medium]
Does this depend on LoongArch JIT patches that are not in the tree yet?

arch/loongarch/net/bpf_jit.c implements neither bpf_jit_supports_large_stac=
k()
nor bpf_jit_supports_private_stack(), so both use the weak defaults in
kernel/bpf/core.c that return false.  As a result, is_large_stack_supported=
()
returns false and __load_if_large_stack() still causes run_subtest() to skip
private_stack_two_frames on LoongArch, and if large stack support is later
added before private stack support, bpf_enable_priv_stack() will return
NO_PRIV_STACK and the verifier will reject the two 2048-byte frames.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126055355.9967=
-1-dongtai.guo@linux.dev?part=3D2
