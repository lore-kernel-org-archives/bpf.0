Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA802DECC2
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952099; cv=none; b=meROZ0YiUENeBj5pbVVbS46Xtc95GIrW4oCxPyWVxFPb/ymbOdSdhxz59lNGTn5QmPsJCC+2GlRiocWZMFUvFjTB2Z8GfHK6Vo+5n1ecePhXuhBZj4BYxBUP3qVxVlh/gI9yR+guxuNJE8gCJPWsVffHzKkluwlcRQNODi/lpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952099; c=relaxed/simple;
	bh=wFePT5+Yd7Tp3foLToQuH9d38IUyxkn5QQmpAY2+fEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXM+Bx3d4YN3woBNQH+kPrpOI+mvxKW18zl4ts32e85+VmgNMmlEpL+2J+Fl7FzG5+WAuxCgqAWEnZj34aIXZHcRqZXWZQqrx34sMHeAN5pbHw6B+kzre4N+MFonlk3tOvMCta+v7rBptNkBm2e5kgI487EhOxvT8iOFHIYrZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DviHr3Tg; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DviHr3Tg"
Message-ID: <c17688ad-7940-4697-abd7-dc5cf9f1e7ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785952095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=My2Outn5Pkhz5i5qO6fw/vJqKE6oWiD3uq/q9fPYqqw=;
	b=DviHr3TgZ6EzbwCCc0xzaWFKEzzRU0KpOI1fgVtnVEb8Mvu1TFaVOlOBxaxPGBr/xK0k/J
	pJWSsbmyXNSdSwE7jVgAKWzEjcm1KrcVgsKZSL+pyjq9ol92bMdfwncWPyvLRSCriFRG5c
	Or46taz2Dey9X9CXGpQl8arrWPHFMDE=
Date: Wed, 5 Aug 2026 10:47:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next 1/4] selftests/bpf: map_kptr: force BPF_STX for the
 scalar store to kptr
Content-Language: en-GB
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org,
 ast@kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org
References: <20260803170251.1898102-1-vineet.gupta@linux.dev>
 <20260803170251.1898102-2-vineet.gupta@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260803170251.1898102-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/3/26 10:02 AM, Vineet Gupta wrote:
> reject_scalar_store_to_kptr stores a scalar constant to a kptr field:
>
>          *(volatile u64 *)&v->unref_ptr = 0xBADC0DE;
>
> Compilers generate one of two encodings for that:
>
>   1. Materialize the constant into a register and emit BPF_STX:
>
>          r1 = 0xbadc0de
>          *(u64 *)(r0 + 0x8) = r1
>
>   2. Or fold it into a single BPF_ST (store immediate):
>
>          *(u64 *)(r0 + 0x8) = 0xbadc0de
>
> check_map_kptr_access() rejects both, but through very different checks.
> BPF_STX goes through map_kptr_match_type(), whose first test is
> base_type(reg->type) != PTR_TO_BTF_ID - the scalar rejection this test is
> named for - and which prints "invalid kptr access, R...". BPF_ST only gets
> the trivial "BPF_ST imm must be 0 when storing to kptr" immediate check and
> never reaches map_kptr_match_type() at all.
>
> So on a compiler that folds the constant - bpf-gcc, and clang from
> -mcpu=v4, which enabled BPF_ST around v4 support due to historical
> verifier limitations - the test fails against its expected message.
>
> Widening the __msg to accept either message would make it pass again, but
> on those toolchains it would then only re-test the imm != 0 path, which
> verifier/map_kptr.c ("map_kptr: BPF_ST imm != 0") already covers, and the
> scalar-vs-PTR_TO_BTF_ID check would lose its only test in the tree.
>
> Route the value through barrier_var() instead, so the store stays a
> BPF_STX everywhere and the test keeps asserting what it was written to
> assert. clang -mcpu=v1..v4 and bpf-gcc 16.1 all emit the register form
> afterwards.
>
>    bpf-gcc, before: #229/20 map_kptr/reject_scalar_store_to_kptr:FAIL
>    bpf-gcc, after : #229/20 map_kptr/reject_scalar_store_to_kptr:OK
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
>   tools/testing/selftests/bpf/progs/map_kptr_fail.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> index f11848dfa78f..cb84e23b83c0 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -390,13 +390,22 @@ __failure __msg("invalid kptr access, R")
>   int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
>   {
>   	struct map_value *v;
> +	u64 val = 0xBADC0DE;
>   	int key = 0;
>   
>   	v = bpf_map_lookup_elem(&array_map, &key);
>   	if (!v)
>   		return 0;
>   
> -	*(volatile u64 *)&v->unref_ptr = 0xBADC0DE;
> +	/*
> +	 * Keep the value in a register so this stays a BPF_STX and keeps
> +	 * exercising map_kptr_match_type(). Compilers that fold the constant
> +	 * into a BPF_ST (store immediate) instead - bpf-gcc, and clang from
> +	 * -mcpu=v4 - would be rejected by the far weaker "BPF_ST imm must be
> +	 * 0" check, which verifier/map_kptr.c already covers.
> +	 */
> +	barrier_var(val);
> +	*(volatile u64 *)&v->unref_ptr = val;

Could you explain in details why gcc16 (with cpuv4) won't work with BPF_ST?
What code gcc16 (with cpuv4) generates?

>   	return 0;
>   }
>   

