Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B943B2FFC
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383906; cv=none; b=L3IsI/tSyqEnK1dNdQXz4SROzcAVfg+gthLBm99dPmKCijQmdw0vSpriQUJSkDuJlsdE4y+ejADQVj+Xl/8hpbRwALaenTLjcX87HRcRHHmeyq7w9jbGJjhVAwHuWQWj65z/XAhsLljf7KGDY+B8ksdPbndernMvKEwrtj5/wJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383906; c=relaxed/simple;
	bh=5oP+/aTKJ+enGuB3Bh2TxLME3CBRBGwXw2eS1fMjAmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajJ0UW3pRXqSRa2CaoyJbXFHOrGxap6UaNaIO1wvkuDNn97gOIXv234XQEMXB58LOu6UVeXgLCoG8U3T3JTkep5nelwWYXk+/7BGlx35XMV45d1vhrYfgqwB83bo+l2Ozu0sp6oRD6CoO48lQgYpqBxzKy7BapeTmb+v244dvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GeKfPEb6; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GeKfPEb6"
Message-ID: <9a50d5b2-d3bb-4609-a810-003320540c45@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777383900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtKcuyRuY2HWpCwJ5nOA8Qprq/CoMLkFBcZif+m/6JY=;
	b=GeKfPEb6voAMVCaDo9JMgRwg8JBIC0ZAbKrrsIu8mMdkJ6x+nvn+OVQFO+0DxnffvsXjYM
	lFDekpLtOeIiFW6sn9J1zxGov6bMugIbVPW0ZJgzBzJcOppc22FPBXt9fhDBTD8ximfd7u
	6X9Ei/1OFImo68WUqZLdkChDLO9G5r4=
Date: Tue, 28 Apr 2026 14:44:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Rename libarena malloc/free
 methods
To: Emil Tsalapatis <etsal@meta.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
References: <20260428134252.2783519-1-etsal@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260428134252.2783519-1-etsal@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/28/26 2:42 PM, Emil Tsalapatis wrote:
> From: Emil Tsalapatis <emil@etsalapatis.com>
> 
> The s390 architecture uses the token "free" for an enum, conflicting
> with the malloc/free definitions. Rename the calls to arena_malloc and
> arena_free instead to prevent collisions.
> 
> Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Emil Tsalapatis <etsal@meta.com>
> Fixes: 7c8d208d816d0504aa916138ae097d9cb4ed4e56 ("Introduce arena library and runtime)

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> ---
>  tools/testing/selftests/bpf/libarena/Makefile               | 2 --
>  .../selftests/bpf/libarena/include/libarena/common.h        | 6 +++---
>  tools/testing/selftests/bpf/libarena/src/common.bpf.c       | 4 ++--
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
> index 3c695f9c0054..5e2ab514805e 100644
> --- a/tools/testing/selftests/bpf/libarena/Makefile
> +++ b/tools/testing/selftests/bpf/libarena/Makefile
> @@ -51,8 +51,6 @@ ASAN_FLAGS += -mllvm -asan-destructor-kind=none
>  override BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
>  override BPF_CFLAGS += -O2 -g
>  override BPF_CFLAGS += -Wno-incompatible-pointer-types-discards-qualifiers
> -# Required to define our own arena-based free()
> -override BPF_CFLAGS += -Wno-incompatible-library-redeclaration
>  # Required for suppressing harmless vmlinux.h-related warnings.
>  override BPF_CFLAGS += -Wno-missing-declarations
>  override BPF_CFLAGS += $(INCLUDES)
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> index e54cb7b869bd..ca1a6c1d6477 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> @@ -48,9 +48,9 @@ extern volatile u64 asan_violated;
>  
>  int arena_fls(__u64 word);
>  
> -u64 malloc_internal(size_t size);
> -#define malloc(size) ((void __arena *)malloc_internal((size)))
> -void free(void __arena *ptr);
> +u64 arena_malloc_internal(size_t size);
> +#define arena_malloc(size) ((void __arena *)arena_malloc_internal((size)))
> +void arena_free(void __arena *ptr);
>  
>  /*
>   * The verifier associates arenas with programs by checking LD.IMM
> diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> index e5da1e37e83e..544bf9e1cb38 100644
> --- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> @@ -38,12 +38,12 @@ __weak int arena_buddy_reset(void)
>  	return buddy_init(&buddy);
>  }
>  
> -__weak u64 malloc_internal(size_t size)
> +__weak u64 arena_malloc_internal(size_t size)
>  {
>  	return buddy_alloc_internal(&buddy, size);
>  }
>  
> -__weak void free(void __arg_arena __arena *ptr)
> +__weak void arena_free(void __arg_arena __arena *ptr)
>  {
>  	buddy_free_internal(&buddy, (u64)ptr);
>  }

