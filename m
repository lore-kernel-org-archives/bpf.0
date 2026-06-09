Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99787175A7E
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040652; cv=none; b=PWWTsqMFHgPHwqwPjFx/5kBjou7Qm7RLU77xGEWCD/OfQFjwHOZhO00l4Bl9eprwekUSD98DRsnBCtprvI9cEWVqGV0iQm7paiImocGdUN2G7HpX+cXW2BObh4pgEHRB1EAgemQoQCULAzGKy4SubKcJ1RU4FYDw4k01TuX7/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040652; c=relaxed/simple;
	bh=ejpellxJKhM/KGATwoMc4zHPaCq5nxm3cwu6wuGA4iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPJbYx/rjJIbz3hnhqFJGpA8gStbfwMJaJvqFfJ3X7irLMJ1fK1DRB3PKGUvrt9zTv+z/DdSTb4mId59dhMF15F2vnH+Kiqdc1n4/9B5iLEQ8goocfPz7LPvy/o8N4fy2g/54/8uNfUqfTCHfOePFU4lJbj5CXXm6Rq+RSYk6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PDfafIFV; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PDfafIFV"
Message-ID: <145c7132-ec43-4238-801d-55d518fb0da8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781040645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmlBWo0+rWPXLwn7ya4fbeJQB/bh8ZRt3Hwo0RZPmh4=;
	b=PDfafIFVxicggATAgq+hYxPYBWoS/ipSJczmMon+f3bhv+mAUEUq90JNq51FvShDXLHr4e
	6forrD8RCkS5QNB1iY7zE7xJg4T1QRzA7AIhMBg5OBbpAHilQ/mXIfEBEmMn9OcSaZX6sX
	rtkO8OgvcvuFg1C0zikgFTHe8Wu1XEc=
Date: Tue, 9 Jun 2026 14:30:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Keep int return type for
 tailcall subprogs with maps
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260609163947.1717694-1-yonghong.song@linux.dev>
 <20260609163952.1718472-1-yonghong.song@linux.dev>
 <DJ4PQYTQDWQT.1ENYNRIC3C7IH@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DJ4PQYTQDWQT.1ENYNRIC3C7IH@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/9/26 11:00 AM, Alexei Starovoitov wrote:
> On Tue Jun 9, 2026 at 9:39 AM PDT, Yonghong Song wrote:
>> LLVM23 ([1]) supports 'true' function signature in BTF. The return type
>> of the caller of a tailcall must be an 'int'. Otherwise, verification will
>> fail (see check_btf_func() in check_btf.c). So with llvm23, it is possible
>> that the compiler may change the caller's return type from 'int' to 'void'.
>> To prevent this, barrier_var() is used to avoid returning a constant prone
>> to be optimized.
>>
>> Use Array map to store the subprog return values. Otherwise, due to
>>
>>          data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
>>          if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
>>                            "find data_map"))
>>                  goto out;
>>
>> in prog_tests/tailcalls.c test_tailcall_hierarchy_count(),
>> the test result will be different from the original one.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/198426
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   | 21 +++++++++++++++----
>>   .../progs/tailcall_bpf2bpf_hierarchy_fentry.c | 20 +++++++++++++++---
>>   2 files changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
>> index d556b19413d7..13b0ee9475a8 100644
>> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
>> @@ -11,25 +11,38 @@ struct {
>>   	__uint(value_size, sizeof(__u32));
>>   } jmp_table SEC(".maps");
>>   
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> +	__uint(max_entries, 2);
>> +	__type(key, int);
>> +	__type(value, __u64);
>> +} array SEC(".maps");
>> +
>>   int count = 0;
>>   
>>   static __noinline
>>   int subprog_tail(struct __sk_buff *skb)
>>   {
>> +	int ret = 0;
>> +
>>   	bpf_tail_call_static(skb, &jmp_table, 0);
>> -	return 0;
>> +	barrier_var(ret);
>> +	return ret;
> I think it's missing the actual fix.
> bpf_tail_call_static() should return 0; instead of being void.
> And here, instead of barrier_var() tricks,
> it can pass the return from bpf_tail_call_static() further out.

The following should work:

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 9d160b5b9c0e..7bf2d6d63436 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -147,7 +147,7 @@
   */
  #if (defined(__clang__) && __clang_major__ >= 8) || (!defined(__clang__) && __GNUC__ > 12)
  #if defined(__bpf__)
-static __always_inline void
+static __always_inline int
  bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
  {
         if (!__builtin_constant_p(slot))
@@ -172,6 +172,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
                      "call 12"
                      :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
                      : "r0", "r1", "r2", "r3", "r4", "r5");
+
+       return 0;
  }
  #endif
  #endif

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 9f680cf44512..d41a832da928 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1120,8 +1120,11 @@ int tail_call(struct __sk_buff *sk)
  static __noinline
  int static_tail_call(struct __sk_buff *sk)
  {
-       bpf_tail_call_static(sk, &jmp_table, 0);
-       return 0;
+       int ret;
+
+       ret = bpf_tail_call_static(sk, &jmp_table, 0);
+       barrier_var(ret);
+       return ret;
  }
  
  /* Tail calls in sub-programs invalidate packet pointers. */
@@ -1144,10 +1147,12 @@ __failure __msg("invalid mem access")
  int invalidate_pkt_pointers_by_static_tail_call(struct __sk_buff *sk)
  {
         int *p = (void *)(long)sk->data;
+       int ret;
  
         if ((void *)(p + 1) > (void *)(long)sk->data_end)
                 return TCX_DROP;
-       static_tail_call(sk);
+       ret = static_tail_call(sk);
+       __sink(ret);
         *p = 42; /* this is unsafe */
         return TCX_PASS;
  }

Note that for above static_tail_call(), we cannot do

int static_tail_call(struct __sk_buff *sk)
{
	return bpf_tail_call_static(sk, &jmp_table, 0);
}

The following is some llvm optimization dump for
return bpf_tail_call_static(sk, &jmp_table, 0):

; Function Attrs: noinline nounwind
define internal fastcc void @static_tail_call(ptr noundef %0) unnamed_addr #2 !dbg !34454 {
     #dbg_value(ptr %0, !34457, !DIExpression(), !34458)
     #dbg_value(ptr %0, !34388, !DIExpression(), !34459)
     #dbg_value(ptr @jmp_table, !34395, !DIExpression(), !34459)
     #dbg_value(i32 0, !34396, !DIExpression(), !34459)
   tail call void asm sideeffect "r1 = $0\0A\09r2 = $1\0A\09r3 = $2\0A\09call 12", "r,r,i,~{r0},~{r1},~{r2},~{r3},~{r4},~{r5}"(ptr %0, ptr nonnull @jmp_table, i32 0) #7, !dbg !34461, !srcloc !34400
   ret void, !dbg !34462
}

define dso_local range(i32 0, 3) i32 @invalidate_pkt_pointers_by_static_tail_call(ptr noundef %0) #3 section "tc" !dbg !34424 {
...
15:                                               ; preds = %1
   tail call fastcc void @static_tail_call(ptr noundef %0), !dbg !34445
   store i32 0, ptr %2, align 4, !dbg !34446, !DIAssignID !34447
     #dbg_assign(i32 0, !34428, !DIExpression(), !34447, ptr %2, !DIExpression(), !34433)
   call void asm sideeffect "", "=*imr,0"(ptr nonnull elementtype(i32) %2, i32 0) #7, !dbg !34448, !srcloc !34449
   store i32 42, ptr %7, align 4, !dbg !34450
   br label %16, !dbg !34451
...
}

For static_tail_call(), compiler knows the return value 0. So it changed
the signature to 'void static_tail_call(...)'. The value '0' is used in
invalidate_pkt_pointers_by_static_tail_call().

Could you check whether the above change make sense?

BTW, for the helper, it would be great if we can return 'r0'.

static __always_inline int
bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
{
         if (!__builtin_constant_p(slot))
                 __bpf_unreachable();

         /*
          * Provide a hard guarantee that LLVM won't optimize setting r2 (map
          * pointer) and r3 (constant map index) from _different paths_ ending
          * up at the _same_ call insn as otherwise we won't be able to use the
          * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
          * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
          * tracking for prog array pokes") for details on verifier tracking.
          *
          * Note on clobber list: we need to stay in-line with BPF calling
          * convention, so even if we don't end up using r0, r4, r5, we need
          * to mark them as clobber so that LLVM doesn't end up using them
          * before / after the call.
          */
         asm volatile("r1 = %[ctx]\n\t"
                      "r2 = %[map]\n\t"
                      "r3 = %[slot]\n\t"
                      "call 12"
                      :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
                      : "r0", "r1", "r2", "r3", "r4", "r5");

         return 'r0';
}

But we have

const struct bpf_func_proto bpf_tail_call_proto = {         /* func is 
unused for tail_call, we set it to pass the          * get_helper_proto 
check          */         .func           = BPF_PTR_POISON,         
.gpl_only       = false,         .ret_type       = RET_VOID,         
.arg1_type      = ARG_PTR_TO_CTX,         .arg2_type      = 
ARG_CONST_MAP_PTR,         .arg3_type      = ARG_ANYTHING, }; and for 
RET_VOID, we have below in verifier.c:         switch 
(base_type(ret_type)) {         case RET_INTEGER:                 /* 
sets type to SCALAR_VALUE */                 mark_reg_unknown(env, regs, 
BPF_REG_0);                 break;         case RET_VOID:               
   regs[BPF_REG_0].type = NOT_INIT;                 break; so we cannot 
return 'r0'.

>
>>   }
>>   
>>   SEC("tc")
>>   int entry(struct __sk_buff *skb)
>>   {
>> -	int ret = 1;
>> +	int ret = 1, ret1, ret2, key1 = 0, key2 = 1;
>>   
>>   	clobber_regs_stack();
>>   
>>   	count++;
>> -	subprog_tail(skb);
>> -	subprog_tail(skb);
>> +	ret1 = subprog_tail(skb);
>> +	ret2 = subprog_tail(skb);
>> +
>> +	bpf_map_update_elem(&array, &key1, &ret1, 0);
>> +	bpf_map_update_elem(&array, &key2, &ret2, 0);

__sink(ret1)/__sink(ret2) should work here.

> I'm sure there is a way to do this without introducing maps or global volatile variables.
>
> pw-bot: cr

