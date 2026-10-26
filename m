Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986789;
	b=D1P4OEE9nsHOeneXkcG7xOYwBYQBYaKVIV/RkhOr1nifAaHUtRqzth57sZotxpt+D/dP
	 ZQEQCnA/a2bACG7oVzMVOY/4B/Jqdq3WWMOPAk9cM7txkTzgyDsyiZHXfiaH1IRLgrqzp
	 9Uad7nqYY48CAygZGqc8Gy+Nb1QC+t4MsjuP7+zD/200RLU6gB6CRzMpuuXgIlMIcRUVr
	 5Ilr+MSF1y0Msv57PeHvGr5lv+rPa5n+sn4ePMFYsC+pi6+nTosgVLDW2ASTpWqOBKhZk
	 Gn3+z3WsRHu2hazhvKuRAcGsBy1H/vAW7y8fhVNs2pUO9a8ljcSZaTeAFlejWcGibbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986789;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=rg+8qdArxbE6fvNnmqWdWPY/6nA1dN4zrSdk5N6bcIw=;
	b=a8ssKXoLGz0Z3OOnrFfgeMey5fX4s4Qjp/drYkX8L8sAlA1CGXEnJzkPkI+aY1YYM8F4
	 oRkdEKzfpoJDKKth7yYelG75mR3g0Axaeopw5M3HSPcXMzoZpfW8Wi+d+qyOs5ldY7D1L
	 POn8jtGF+qmZcwqO/rvGQkSsiZ/WyvUh5uIqasjRCE+zLSpiYJTQ7voVdOYwV396ppCcS
	 DckWTSbGj+zPFohu8l862g+EKC8Pbc1s3snpCDm6XZMmDh4QSP9Zr13FNKbzQO314J6wm
	 HHMh9gmW06X4vHIUbriaYWXpx4eRJHLUxwArqaU72jWD5Nvf40LdmT105Ti3/id5AMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+8zkVAf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C6606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+8zkVAf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C42B1F01825;
	Mon, 26 Oct 2026 03:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986788;
	bh=rg+8qdArxbE6fvNnmqWdWPY/6nA1dN4zrSdk5N6bcIw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z+8zkVAfQMAQsNhl9cMGG1PivFRDeF2DGGxv1xmEW8EIuBWjyo8OJZWWb/DJADTKC
	 smNsGfr8rR730saBO7hLRYPvkf8Gu7DV8PX9vJKRzb88cL8s5Z4EG3Q0RhoWj3pl1g
	 pAlgsAu+a9/Et0Pj4ShmGbl8wOrjJABaqTxp7z5A3ZH58ND6QcfKY7Qa5lB+RAj0IM
	 eIYxtJqw57oma8QazwSIV8Jt9pwqtUTH6uS4Bbzp2+Wp8JhkCgQjKCy9JIuujVXrFw
	 SNsImsdcehYWdLTlJjOn8/yuN33Lrm+RchHG2Qq4sYw4KGc1+XKOq5KLUvnKlA+7BV
	 /pxHx1I1b7AYg==
Content-Type: multipart/mixed; boundary="===============3898424796731597585=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e0720b9a3b3c0aeaeae687bf72a57da257acfc9b26719d9e5e4a4a74a3ddfa96@mail.kernel.org>
In-Reply-To: <20261026025943.404450-58-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-58-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 57/81] selftests/bpf: Test 32 and 33 call frames
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:08 +0000 (UTC)

--===============3898424796731597585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test 32 and 33 call frames

TL;DR: Test issue: with the JIT disabled, the new 32-frame selftests may hit
the combined stack size limit (512 bytes) at frame 17 first, so
global_func3_32_frames may fail to load and global_func3's message may not
match.

> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
> index b66abb350fb0..3b816afaa278 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c

[ ... ]

> +static __attribute__ ((noinline))
> +int f32(struct __sk_buff *skb)
> +{
> +	return f31(skb);
> +}
> +
> +SEC("tc")
> +__success
> +int global_func3_32_frames(struct __sk_buff *skb)
> +{
> +	return f31(skb);
> +}
> +
>  SEC("tc")
> -__failure __msg("the call stack of 17 frames")
> +__failure __msg("the call stack of 32 frames")
>  int global_func3(struct __sk_buff *skb)
>  {
> -	return f16(skb);
> +	return f32(skb);
>  }

Can these two programs fail when the JIT is disabled?

With bpf_jit_enable=0 on a kernel without CONFIG_BPF_JIT_ALWAYS_ON,
round_up_stack_depth() gives every frame at least 32 bytes:

    if (env->prog->jit_requested)
            return round_up(stack_depth, 16);
    ...
    return round_up(max_t(u32, stack_depth, 1), 32);

and env->stack_limit is MAX_BPF_STACK (512).  check_max_stack_depth_subprog()
adds the frame's depth before it descends to the next call, so the walk goes
main=32, f31=64, ..., f15=544, and fails at the 17th frame:

    combined stack size of 17 calls is 544. Too large

That happens before the MAX_CALL_FRAMES (32) check is reached.  So
global_func3_32_frames, which is marked __success, would be rejected, and
global_func3 would fail with the combined stack size message instead of "the
call stack of 32 frames", so its __msg() would not match.

The main pass cannot catch the chain first.  func_is_on_its_own() is true
for every fN (r1 is PTR_TO_CTX), so each callee is verified in a one-frame
state and setup_func_entry() never sees the chain.

Before this patch the 17 frame chain was rejected in the main pass by
setup_func_entry() ("the call stack of 17 frames") before
check_max_stack_depth() ran, so the test also passed without the JIT.

Would adding __load_if_JITed() to both programs be appropriate?
test_global_func1.c and verifier_unwind.c already handle JIT vs interpreter
differences with __load_if_JITed() or with a {{[0-9]+}} regex in the combined
stack size message.

No later commit in the series changes this file or round_up_stack_depth().
The tools/testing/selftests/bpf/config.* files set CONFIG_BPF_JIT_ALWAYS_ON=y,
so only runs with the JIT off are affected.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============3898424796731597585==--
