Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA2280A5A
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407403; cv=none; b=R6dxL7lYiFQmHML+bp51yDyBqY8ClrlCzJm4f1HqQTBKkppZ+cogdSgXkAUy1bVcqYZsGolkNQMxCYJBk+zdtQ8imDG+Q+m7FiSobqidxvYPrrSaBxSGd2WEVVMY3UXwsobb2WTwemz9rignXQSNIICt32LavJpam09EUASegIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407403; c=relaxed/simple;
	bh=xNJ4oDmPMlv0RBwpwOWvwOvu+vgNBtYEUPi8WUNfH+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sr46Q7l7RaaWhj1UaM9LE8wDFDtaH5yd0iLAQN6cLCG9kQyVojI//c28NJCPDd3LYeV1+AWpYHJIs3wtYhdwW/cdZQrXYlfEiY2dd8pI+7K5esS28ZYZOdY4yo//HbArGV8hrB+Cy/zPTTO1RFW63s1MnEskmtfflP2waOhmrUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WhBqWpvM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WhBqWpvM"
Message-ID: <81194df4-7857-4b1e-929c-d6a60251f032@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786407387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdnsKEeqoGvjOvi0tYUtpyoiE9Y0K1fJfRm1YYBah+4=;
	b=WhBqWpvMa33ApcPgrH9yvY371+r8p/63c7g5eJ1W58C+dRviOAqam/uRDOWPHM38wdPKL/
	Ktpzcvh7qKv0RITqxEXwWoEY6+KpTe2nRs4M1iVvuOdyojuNaLjtoJi6cQQdSbaM1jglrY
	8Kj7N9Dj06DsqMIPI5wAOdmVTNIU8IY=
Date: Mon, 10 Aug 2026 17:16:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test resolve_btfids arena
 argument suffixes
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
References: <20260809085155.3305519-1-memxor@gmail.com>
 <20260809085155.3305519-3-memxor@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260809085155.3305519-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026-08-09 1:51 a.m., Kumar Kartikeya Dwivedi wrote:
> Add a suffix-only kfunc declaration with arena annotations on all five
> arguments. Verify that resolve_btfids emits address_space(1) type tags
> for every position without KF_ARENA_ARG flags in the BTF ID sets.
> 
> Represent expected arena arguments as a per-parameter bitmap so the
> test covers suffixes beyond the two positions expressible by flags.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/resolve_btfids.c | 35 ++++++++++---------
>   tools/testing/selftests/bpf/progs/btf_data.c  |  9 +++++
>   2 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 732cfed35e1c..9bd84fe32b89 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -15,6 +15,7 @@
>   #define DECL_TAG_FASTCALL "bpf_fastcall"
>   #define DECL_TAG_KFUNC "bpf_kfunc"
>   #define TYPE_ATTR_ARENA "address_space(1)"
> +#define ARENA_ARG(n) (1U << (n))
>   
>   #ifndef KF_FASTCALL
>   #define KF_FASTCALL (1 << 12)
> @@ -49,13 +50,18 @@ struct kfunc_symbol {
>   	const char	*name;
>   	s32		 id;
>   	u32		 flags;
> +	u32		 arena_args;
> +	bool		 arena_ret;
>   };
>   
>   static struct kfunc_symbol kfunc_symbols[] = {
> -	{ "kfunc_a", -1, 0 },
> -	{ "kfunc_b", -1, KF_FASTCALL },
> -	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2 },
> -	{ "kfunc_d", -1, KF_ARENA_ARG2 },
> +	{ "kfunc_a", -1, 0, 0, false },
> +	{ "kfunc_b", -1, KF_FASTCALL, 0, false },
> +	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2,
> +	  ARENA_ARG(0) | ARENA_ARG(1), true },
> +	{ "kfunc_d", -1, KF_ARENA_ARG2, ARENA_ARG(1), false },
> +	{ "kfunc_e", -1, 0, ARENA_ARG(0) | ARENA_ARG(1) | ARENA_ARG(2) |
> +	  ARENA_ARG(3) | ARENA_ARG(4), false },
>   };
>   
>   /* Align the .BTF_ids section to 4 bytes */
> @@ -105,6 +111,7 @@ BTF_ID_FLAGS(func, kfunc_a)
>   BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
>   BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
>   BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
> +BTF_ID_FLAGS(func, kfunc_e)

It really makes me uneasy that we now can have some kfuncs that are
flagged with ARENA flags, and others that are not, but still work with
arena pointers.

But I guess we decided to remove the flags soon(tm), oh well.

>   BTF_KFUNCS_END(test_kfunc_set)
>   
>   /*
> @@ -112,6 +119,7 @@ BTF_KFUNCS_END(test_kfunc_set)
>    * actually sort at least one of the two sets.
>    */
>   BTF_KFUNCS_START(test_kfunc_set_rev)
> +BTF_ID_FLAGS(func, kfunc_e)
>   BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
>   BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
>   BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
> @@ -301,15 +309,15 @@ void test_resolve_btfids(void)
>   	}
>   
>   	/*
> -	 * Check resolve_btfids wrapped exactly the arena-flagged return/args
> -	 * with the address_space(1) type attribute, and left other
> +	 * Check resolve_btfids wrapped exactly the arena-flagged or suffixed
> +	 * return/args with the address_space(1) type attribute, and left other
>   	 * pointers/returns untouched.
>   	 */
>   	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
>   		const struct btf_type *fn, *proto;
>   		const struct btf_param *params;
>   		const char *name = kfunc_symbols[i].name;
> -		u32 fl = kfunc_symbols[i].flags;
> +		u32 arena_args = kfunc_symbols[i].arena_args;
>   		__u32 nr;
>   
>   		fn = btf__type_by_id(btf, kfunc_symbols[i].id);
> @@ -322,15 +330,10 @@ void test_resolve_btfids(void)
>   		nr = btf_vlen(proto);
>   
>   		ASSERT_EQ(is_arena_tagged_ptr(btf, proto->type),
> -			  !!(fl & KF_ARENA_RET), name);
> -		if (nr > 0) {
> -			ASSERT_EQ(is_arena_tagged_ptr(btf, params[0].type),
> -				  !!(fl & KF_ARENA_ARG1), name);
> -		}
> -		if (nr > 1) {
> -			ASSERT_EQ(is_arena_tagged_ptr(btf, params[1].type),
> -				  !!(fl & KF_ARENA_ARG2), name);
> -		}
> +			  kfunc_symbols[i].arena_ret, name);
> +		for (j = 0; j < nr; j++)
> +			ASSERT_EQ(is_arena_tagged_ptr(btf, params[j].type),
> +				  !!(arena_args & ARENA_ARG(j)), name);
>   	}
>   
>   out:
> diff --git a/tools/testing/selftests/bpf/progs/btf_data.c b/tools/testing/selftests/bpf/progs/btf_data.c
> index ec34f7a6e038..ea41c9801432 100644
> --- a/tools/testing/selftests/bpf/progs/btf_data.c
> +++ b/tools/testing/selftests/bpf/progs/btf_data.c
> @@ -68,3 +68,12 @@ int kfunc_d(struct root_struct *a, struct root_struct *b)
>   {
>   	return 0;
>   }
> +
> +int kfunc_e(struct root_struct *a__arena,
> +	    struct root_struct *b__arena__nullable,
> +	    struct root_struct *c__arena,
> +	    struct root_struct *d__arena__nullable,
> +	    struct root_struct *e__arena)

Can we have test cases with mixed args too?

   int kfunc_f(struct foo *a, struct bar *b__arena, int flags)

And also one with both KF_ARENA_RET flag and __arena suffixed args?

> +{
> +	return 0;
> +}

