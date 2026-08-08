Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578383A3822
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786216222; cv=none; b=i+9TtmywsJy0ki6plK3Me4l/dHV/iKH4QS+P9LYGbeORPWYEkTiZ/M2Asma4vXFUik/nSpqAT+TzPoZ2DYjuB2BStwoIuiRQEST3GqDFvkR8OVkraLrf8q5QIuUz0+V6Impk3Th1PB2a17WEI6v1h+snZt6zEsh9Igaa0ysJEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786216222; c=relaxed/simple;
	bh=zGOl/lNsiSRwP3SudFsil8LZrCo8zdBu7PitMewYD7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LL8I+NsCWuijN0VWYsZwAhDPReASDiSSlTwZFbY5X5kkydfbwtu//0lmuJRiRXDTeauO8dYn5emNp6gyUb9ryT7vKO5xw8JKp10PadjCrep31F+b83MRSZNmbvC3yS6bSRhojgSd66/Wp6PeH4d7B74Okj6rIrUT0JBGYNKXp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MdghHMrP; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MdghHMrP"
Message-ID: <ca1bf012-3720-4f97-b2e4-77bcffdf60c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786216218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgEksIRUG3cvtMM/ICb5y3BdtoGtDp/zshCF9+Xysi4=;
	b=MdghHMrPpzU1AkwHgkjQZ6dZakKvkVuCejUTGRqYaD3XU+QaphjwMyemzDmaPEabugDST5
	OjN1DetVCYIKExSd4HW6g+KlwkXwXHC3ghEDE4Pmuvpzyd8KsH9wyaQXNbVV1H0IeFsosf
	tIotxoZ6SIXKOWafm3Rwd/O95sWymlc=
Date: Sat, 8 Aug 2026 12:10:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: map_kptr: expect BPF_ST
 reject msg on cpuv4 toolchains
Content-Language: en-GB
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20260807204434.1036279-1-vineet.gupta@linux.dev>
 <20260807204434.1036279-2-vineet.gupta@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260807204434.1036279-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/7/26 1:44 PM, Vineet Gupta wrote:
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
> These go through different rejection paths and output different
> messages.
>   - BPF_STX goes through map_kptr_match_type(), which prints
>     "invalid kptr access, R...".
>   - BPF_ST only gets the immediate check printing
>     "BPF_ST imm must be 0 when storing to kptr"
>
> The test only expects the BPF_STX message, so it fails on a toolchain
> that folds the constant - bpf-gcc, and clang -mcpu=v4:
>
>    7: (7a) *(u64 *)(r0 +8) = 195936478
>    BPF_ST imm must be 0 when storing to kptr at off=8
>    ...
>    EXPECTED   SUBSTR: 'invalid kptr access, R'
>
> Pick the expected message with __BPF_FEATURE_ST, which clang and bpf-gcc
> both define exactly when BPF_ST codegen is available - cpuv4 for clang,
> and by default for bpf-gcc, whose default cpu is v4.
>
>    bpf-gcc, before: #229/20 map_kptr/reject_scalar_store_to_kptr:FAIL
>    bpf-gcc, after : #229/20 map_kptr/reject_scalar_store_to_kptr:OK
>
> Two caveats worth noting:
>
> - On a BPF_ST toolchain the test now only exercises the imm != 0 check
>    and never reaches map_kptr_match_type(), so the scalar-vs-PTR_TO_BTF_ID
>    rejection the test is named for is only covered by the non-ST builds.
>    The imm path itself is already covered compiler-independently by
>    verifier/map_kptr.c ("map_kptr: BPF_ST imm != 0").
>
> - __BPF_FEATURE_ST says the compiler *can* emit BPF_ST, not that it will.
>    The encoding also depends on the optimization level: clang -mcpu=v4 -O0
>    still emits BPF_STX, which would send the #ifdef down the wrong branch
>    and fail the test. Selftests always build BPF objects at -O2 so this
>    does not bite today, but it is a latent failure mode if that changes.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/progs/map_kptr_fail.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> index f11848dfa78f..5e25ca806060 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -386,7 +386,16 @@ int kptr_xchg_possibly_null(struct __sk_buff *ctx)
>   }
>   
>   SEC("?tc")
> +/*
> + * A compiler with BPF_ST folds the constant into a store-immediate, which the
> + * verifier rejects on a different path (and with a different message) than the
> + * BPF_STX form.
> + */
> +#ifdef __BPF_FEATURE_ST
> +__failure __msg("BPF_ST imm must be 0 when storing to kptr at off=8")
> +#else
>   __failure __msg("invalid kptr access, R")
> +#endif
>   int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
>   {
>   	struct map_value *v;

