Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F137F006
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035100; cv=none; b=LTaTujCI7vJhuqcdFGdtxrHfT9m4r+dcbrO22JfvDin9fuyVPFaiRjE1uLDoyVkZnVb79ZTRjEPrFWk2fdJ1d9+8/CP+Cr9oPTw0HC4u4SM16vvTUvHYwaZnH2pLzESWBL67wOdlfwhq/XSrJe7UxorOa9haY92928p7tPXKLs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035100; c=relaxed/simple;
	bh=KThKQta56dMpvBu0TEFOgMfwqr0+qOm6N1vzNkcAPLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0O/B7IiTW51onSTwyPD/FelUZzcP2nxA14BiWlCClRCCI5xu1sfUXMw0qpJqBV7f1S7jTPTxmKCZDLL2xwz2fFh+bhWsZHYqSFU7Dfu2tRc/tdi3SGiK4Dlu7BoXmSUdKYGCLEFAiaWWo1yQk6pdKzbVGPW9D95Wc04jjCMKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=giIUdzs4; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="giIUdzs4"
Message-ID: <cfa8641e-2a4d-42f1-8a91-28cbf1478227@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786035082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TryxzgWqZQI2DT9mmhsWxctZDISmjHPgtJQJ++MzMOk=;
	b=giIUdzs4m7dIlg6x1lIVqFRLAdwaVaOkJZ9NWp+DDwNbUy6Mf/vkkHz29cJPC7H8wcJLzG
	5ikDMWfYoWCTDqkD/dBEZpnHWpp5XeN4zPPoB7W33g+DOBwdgCOANZF30O5V7ZvlCLRsgX
	BIBp/nRd7VP2YrU8id3BiVKYZEPyU0A=
Date: Thu, 6 Aug 2026 09:50:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next 1/4] selftests/bpf: map_kptr: force BPF_STX for the
 scalar store to kptr
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 ast@kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org
References: <20260803170251.1898102-1-vineet.gupta@linux.dev>
 <20260803170251.1898102-2-vineet.gupta@linux.dev>
 <c17688ad-7940-4697-abd7-dc5cf9f1e7ec@linux.dev>
 <5a47b073-e1d5-499c-89bd-44500a88bf27@linux.dev>
 <66f7ffe9-b8f3-4369-996a-967636b60401@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <66f7ffe9-b8f3-4369-996a-967636b60401@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 9:37 AM, Yonghong Song wrote:
> On 8/5/26 12:25 PM, Vineet Gupta wrote:
>> On 8/5/26 10:47 AM, Yonghong Song wrote:
>>> On 8/3/26 10:02 AM, Vineet Gupta wrote:
>>>> reject_scalar_store_to_kptr stores a scalar constant to a kptr field:
>>>>
>>>>            *(volatile u64 *)&v->unref_ptr = 0xBADC0DE;
>>>>
>>>> Compilers generate one of two encodings for that:
>>>>
>>>>     1. Materialize the constant into a register and emit BPF_STX:
>>>>
>>>>            r1 = 0xbadc0de
>>>>            *(u64 *)(r0 + 0x8) = r1
>>>>
>>>>     2. Or fold it into a single BPF_ST (store immediate):
>>>>
>>>>            *(u64 *)(r0 + 0x8) = 0xbadc0de
>>>>
>>>> check_map_kptr_access() rejects both, but through very different
>>>> checks.
>>>> BPF_STX goes through map_kptr_match_type(), whose first test is
>>>> base_type(reg->type) != PTR_TO_BTF_ID - the scalar rejection this
>>>> test is
>>>> named for - and which prints "invalid kptr access, R...". BPF_ST
>>>> only gets
>>>> the trivial "BPF_ST imm must be 0 when storing to kptr" immediate
>>>> check and
>>>> never reaches map_kptr_match_type() at all.
>>>>
>>>> So on a compiler that folds the constant - bpf-gcc, and clang from
>>>> -mcpu=v4, which enabled BPF_ST around v4 support due to historical
>>>> verifier limitations - the test fails against its expected message.
>>>>
>>>> Widening the __msg to accept either message would make it pass
>>>> again, but
>>>> on those toolchains it would then only re-test the imm != 0 path, which
>>>> verifier/map_kptr.c ("map_kptr: BPF_ST imm != 0") already covers,
>>>> and the
>>>> scalar-vs-PTR_TO_BTF_ID check would lose its only test in the tree.
>>>>
>>>> Route the value through barrier_var() instead, so the store stays a
>>>> BPF_STX everywhere and the test keeps asserting what it was written to
>>>> assert. clang -mcpu=v1..v4 and bpf-gcc 16.1 all emit the register form
>>>> afterwards.
>>>>
>>>>      bpf-gcc, before: #229/20 map_kptr/reject_scalar_store_to_kptr:FAIL
>>>>      bpf-gcc, after : #229/20 map_kptr/reject_scalar_store_to_kptr:OK
>>>>
>>>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>>>> ---
>>>>     tools/testing/selftests/bpf/progs/map_kptr_fail.c | 11 ++++++++++-
>>>>     1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
>>>> b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
>>>> index f11848dfa78f..cb84e23b83c0 100644
>>>> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
>>>> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
>>>> @@ -390,13 +390,22 @@ __failure __msg("invalid kptr access, R")
>>>>     int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
>>>>     {
>>>>         struct map_value *v;
>>>> +    u64 val = 0xBADC0DE;
>>>>         int key = 0;
>>>>            v = bpf_map_lookup_elem(&array_map, &key);
>>>>         if (!v)
>>>>             return 0;
>>>>     -    *(volatile u64 *)&v->unref_ptr = 0xBADC0DE;
>>>> +    /*
>>>> +     * Keep the value in a register so this stays a BPF_STX and keeps
>>>> +     * exercising map_kptr_match_type(). Compilers that fold the
>>>> constant
>>>> +     * into a BPF_ST (store immediate) instead - bpf-gcc, and clang
>>>> from
>>>> +     * -mcpu=v4 - would be rejected by the far weaker "BPF_ST imm
>>>> must be
>>>> +     * 0" check, which verifier/map_kptr.c already covers.
>>>> +     */
>>>> +    barrier_var(val);
>>>> +    *(volatile u64 *)&v->unref_ptr = val;
>>> Could you explain in details why gcc16 (with cpuv4) won't work with
>>> BPF_ST?
>>> What code gcc16 (with cpuv4) generates?
>> GCC generates BPF_ST (and clang -mcpu=v4 does as well)
>>
>>     7: (7a) *(u64 *)(r0 +8) = 195936478
>>     BPF_ST imm must be 0 when storing to kptr at off=8
>>     processed 7 insns (limit 1000000) max_states_per_insn 0 total_states
>>     0 peak_states 0 mark_read 0
>>     =============
>>     EXPECTED   SUBSTR: 'invalid kptr access, R'
>>
>>
>> The issue is not codegen or BPF_ST vs. BPF_STX, its a deliberate bad
>> write to a pointer.
>> The current __msg in test only matches v3 (STX) form. v4's
>> store-immediate hits a different verifier check with a different message.
>> My first approach was to support both in the __msg, but then Claude
>> suggested to not do it that way because it would reduce coverage as
>> mentioned in the changelog above.
> For clang side, we can do:
>
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> index f11848dfa78f..b9f6d6764431 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -386,7 +386,11 @@ int kptr_xchg_possibly_null(struct __sk_buff *ctx)
>    }
>    
>    SEC("?tc")
> +#ifdef __BPF_FEATURE_ST
> +__failure __msg("BPF_ST imm must be 0 when storing to kptr at off=8")
> +#else
>    __failure __msg("invalid kptr access, R")
> +#endif
>    int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
>    {
>           struct map_value *v;
> ...
>
> Note that __BPF_FEATURE_ST is only enabled for cpuv4 in clang.
> Does gcc has similar macro like above __BPF_FEATURE_ST?

Yes it does and also similarly enabled for cpu=v4.
The suggestion does look cleaner, but feels fragile.
Both forms of codegen are valid from selftest passing perspective.
BPF_FEATURE_ST implies compiler supports the feature but the actual 
generation is subject to optimization level etc.

Your call.

Thx,
-Vineet
