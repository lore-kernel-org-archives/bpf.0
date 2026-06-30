Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286E23EAAD
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847751; cv=none; b=awXaDGTmN+kFKqSlZOJWT0fNtCACSo2khZjWyt/QA8zn8JLmDjcEzK2S2emWKzuePZsyrP7sAw8TJpSmKhZVfFLFWqMHSLMCaVOoDtwMTe66yjnw/PnBFxmT1GobfAMUkcwg/ymlg1U7/2cIbtzo26HD3XblBRyBKFNPy+aa49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847751; c=relaxed/simple;
	bh=x+8huQqiC82NAimNcrhhvQ1PmItKodFSxSI3JDgez9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQ6POyphbsZtkgQ5z6bvC269dNvACFjjvYM7qmTDWnuEzRWwSQQPsKXJpW4Mimmocg8vYiutfrYhha0uRflzXClaeBR/d+Dd7ZQ1jl1Fajc/KBsZrC/dfU2b8SAHFBUbZA0Q3Nrv/1E4jWm2CDIGvwe/WpWC6GCqFadIfXyGyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c0PEU2su; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c0PEU2su"
Message-ID: <216b5567-a3f6-4720-8528-9868afe2012a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782847748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqme0CcKYd9stTaU6/fK+QQLz80YYOgkT82K/Ap9gm4=;
	b=c0PEU2suc7ppxKj9Gy7B6mxrDveG/XWjG5qebibXjT5rW9o1I0KUUGHVBkpPbIGZi0UGAD
	POYv8lf2JniG/AgIF9tLZnQsVMHXioJSX9V1lVg6HAgip1QkjhqgWk2mXFrbQ3xdLZiaSF
	Hz0rnJKhohMhzclf4QyDhwZhpxmhrNI=
Date: Tue, 30 Jun 2026 12:28:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: libarena: Fix can-loop zero
 variable definition
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, mattbobrowski@google.com,
 song@kernel.org
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-3-emil@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260618085626.19633-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 1:56 AM, Emil Tsalapatis wrote:
> BPF can_loop based loops require the index variable to stay imprecise.
> This means we must initialize them from a currently imprecise variable
> instead of directly assigning 0 to them, like so:
> 
> static volatile u32 zero = 0;
> 
> for (i = zero; i < NUM_LOOPS; i++) {
> 	/* loop body */
> }
> 
> The libarena implementation of this technique is currently faulty. For
> the technique to work, the variable must not be in a map. This includes
> the .rodata DATASEC map used for const variables. However, libarena
> still defines the zero variable as constant.
> 
> Modify the zero variable definition into a volatile variable. This
> change adds a complication caused by the compiler optimizing array
> derefences from
> 
> for (i = zero; i < NUM_LOOPS; i++) {
> 	val = *(ptr + i);
> }
> 
> into
> 
> for (i = zero; i < NUM_LOOPS; i++) {
> 	val = *ptr++;
> }
> 
> and causing verification failures. Use the barrier_var() clobber macro
> to prevent this optimization from taking place. After that, remove the
> bpf_for() invocations introduced in libarena for parallel spmc testing.
> 
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/libarena/include/libarena/common.h     | 2 +-
>  .../bpf/libarena/selftests/test_asan_buddy.bpf.c         | 8 ++++++--
>  .../selftests/bpf/libarena/selftests/test_buddy.bpf.c    | 8 ++++++--
>  .../bpf/libarena/selftests/test_parallel_spmc.bpf.c      | 9 ++++-----
>  tools/testing/selftests/bpf/libarena/src/common.bpf.c    | 3 +--
>  5 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> index a3eb1641ac36..931ace9a49e2 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> @@ -43,7 +43,7 @@ struct {
>   * imprecise. To force the variable to be imprecise, initialize it with
>   * the opaque volatile variable 0 instead of the constant 0.
>   */
> -extern const volatile u32 zero;
> +volatile u32 zero __weak;
>  extern volatile u64 asan_violated;
>  
>  int arena_fls(__u64 word);
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
> index 256d62a03ce7..3266a28f53d7 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
> @@ -154,7 +154,8 @@ __weak int asan_test_buddy_oob(void)
>  	size_t sizes[] = {
>  		7, 8, 17, 18, 64, 256, 317, 512, 1024,
>  	};
> -	int ret, i;
> +	int ret;
> +	u32 i;
>  
>  	ret = buddy_init(&buddy);
>  	if (ret) {
> @@ -163,6 +164,7 @@ __weak int asan_test_buddy_oob(void)
>  	}
>  
>  	for (i = zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++) {
> +		barrier_var(i);

Looks like we are using two different idioms for keeping indices
imprecise and blocking the compiler optimization: the `barrier_var(i)`
like here, and `volatile u32 i` declaration in patches #4 and #5.

My understanding is the barrier is generally better performance-wise,
since volatile var would be re-loaded every time.

Does it make sense to converge on a single pattern (at least in the
context of libarena)?


> [...]

