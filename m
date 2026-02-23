Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2F34CFA8
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845107; cv=none; b=VktDn/WKznRlxB/JZ7IiSafaGlJo4w0LMAcRa1w76WKBpKfbj1tyatfCIBhMhL2AuaOMqDdM1sOhIkoie/shhYOBsC1IRWmYDxHR20ohKVzI8yNgvBkeWGFKzdBMYRT9UpHXgjsJb3XqyD6SnCjXMqSzGcyMWnWDrgQXmN46bD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845107; c=relaxed/simple;
	bh=0uFodMjPk+JdxwNtlnU7QI0PCWofEIVQdGNdAJv3Vpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ectck1tj5eUGJiQEH7FRHldSRQcUITwrxEZNhu85bHmHCoDXsMzrSX/9xUQc1IcnEyiizaLLAt2KgmI38BP2ZQQNqavMOo+44WXWudEoISUQYi7EMzd+wHP3l9vTvNSaf2DYzOKvlN10XGasz5/dPUzgR46svVjihkKWrJF1M4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDvmzPJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDvmzPJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18D8C116C6;
	Mon, 23 Feb 2026 11:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771845107;
	bh=0uFodMjPk+JdxwNtlnU7QI0PCWofEIVQdGNdAJv3Vpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDvmzPJeDymRiXhUdN+v5LljAu0rrNYefw1DhVUo8pqJn5TK1NMDi8Fx0SnG1oR/L
	 fr7Qb2pkwv2cI4/1UaNT/GxgCKJIEjdSC1ckWdwjmAlZ7JB6b8WBYNbn4oaHJaRWmM
	 3M+TjXdKJi1egsPeUERu3pVIsnJ4+oQauLgBySZWDeq4OG9nmjhumL78OlmTWf4Slf
	 pbegYAJCqZ8d+FjManjffY/f7pQxniuw2y4G2aQ6w3L6v27wqmhYVNHAaEU1YGLk37
	 +iZFhDFwSJ02ivvrorgLlYPzYkC7fxAFtol6HrhSxYewZrq0VJoTCKLJbbjmyLmDpc
	 U9wojsxnSq2TQ==
Message-ID: <1956c912-c880-4214-9bc3-e205902459b5@kernel.org>
Date: Mon, 23 Feb 2026 12:11:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/bpf: Enable private stack tests for
 powerpc64
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260216152234.36632-1-adubey@linux.ibm.com>
 <20260216152234.36632-2-adubey@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260216152234.36632-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/02/2026 à 16:22, adubey@linux.ibm.com a écrit :
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> With support of private stack, relevant tests must pass
> on powerpc64.
> 
> #./test_progs -t struct_ops_private_stack
> #434/1   struct_ops_private_stack/private_stack:OK
> #434/2   struct_ops_private_stack/private_stack_fail:OK
> #434/3   struct_ops_private_stack/private_stack_recur:OK
> #434     struct_ops_private_stack:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   tools/testing/selftests/bpf/progs/struct_ops_private_stack.c   | 3 ++-
>   .../selftests/bpf/progs/struct_ops_private_stack_fail.c        | 3 ++-
>   .../selftests/bpf/progs/struct_ops_private_stack_recur.c       | 3 ++-
>   3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> index dbe646013811..1df1111cd029 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> @@ -7,7 +7,8 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
> +				|| defined(__TARGET_ARCH_powerpc)

Won't this also trigger the test on powerpc/32 ?


>   bool skip __attribute((__section__(".data"))) = false;
>   #else
>   bool skip = true;
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> index 3d89ad7cbe2a..e09c1a8782b4 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> @@ -7,7 +7,8 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
> +				|| defined(__TARGET_ARCH_powerpc)
>   bool skip __attribute((__section__(".data"))) = false;
>   #else
>   bool skip = true;
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> index b1f6d7e5a8e5..791800835673 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> @@ -7,7 +7,8 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
> +				|| defined(__TARGET_ARCH_powerpc)
>   bool skip __attribute((__section__(".data"))) = false;
>   #else
>   bool skip = true;

