Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905B44B696
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694145; cv=none; b=jK4UM065Gj59JBeQFMO/l72BRJGJUrGkfGmximKXHCzjqfSLOIppweeiz7QTIzHfigHvc6X2kEfI4IOSwl/vVs7iM0NeorRYdeVYuklIYSBTG6GsVp7kSuYl5F1QQA4+lRFf8vjAUrYaEtSDteNVC1AOp9zMqKHP1JN/nGCs7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694145; c=relaxed/simple;
	bh=5qT1HELfiNtH3yJPrODbxQdEaIaE9mb1MDlPmdbm5s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bA6BEhZ2VFHiUYQagtJZmG+nbeieH4O3ijHar27MWtpDJRGTvX9GPrXDIcCSZnHpBvcU0kcgROmusXFQYyoR53T9/SLm2WlX4Fx/9ZPK9F3GZS3KSwcRSPBaHNa02yjoDwf8fk2TaLqU6idtmhLdVShh9D8g5KdUggs1ArRb5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tFec3y1s; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tFec3y1s"
Message-ID: <0b02e692-1ee1-42e3-a437-97a3a9ca2481@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778694139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pW5+vVaUKpFUQjfSSshc0rJkeBTIj62VGe+zMypxPc=;
	b=tFec3y1srhx+RvUKvUlway36Oetbi/ItQlTDdSVa4dI8Gbgp1CX1UWfDzlfmloTHBtLady
	aYJ6BWI0k1k+vdNSLv/n9bEEdTebo6niMYmg+o7aHWZTAQQRLE0huOU0ppo4QMfEd25uLy
	4MFd/PRui/4igNO2pKFCIofnGnND/x4=
Date: Wed, 13 May 2026 10:41:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 00/25] bpf: Support stack arguments for BPF
 functions and kfuncs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
 <CAADnVQKjVKG8cfMBpWpmbtPToGPSyD13aXLNOzb2PTQm_bS_2w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKjVKG8cfMBpWpmbtPToGPSyD13aXLNOzb2PTQm_bS_2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/13/26 6:33 PM, Alexei Starovoitov wrote:
> On Tue, May 12, 2026 at 9:50 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Currently, bpf function calls and kfunc's are limited by 5 reg-level
>> parameters. For function calls with more than 5 parameters,
>> developers can use always inlining or pass a struct pointer
>> after packing more parameters in that struct although it may have
>> some inconvenience. But there is no workaround for kfunc if more
>> than 5 parameters is needed.
>>
>> This patch set lifts the 5-argument limit by introducing stack-based
>> argument passing for BPF functions and kfunc's, coordinated with
>> compiler support in LLVM [1]. The compiler emits loads/stores through
>> a new bpf register r11 (BPF_REG_PARAMS), to pass arguments beyond
>> the 5th, keeping the stack arg area separate from the r10-based program
>> stack. The current maximum number of arguments is capped at
>> MAX_BPF_FUNC_ARGS (12), which is sufficient for the vast majority of
>> use cases.
>>
>> All kfunc/bpf-function arguments are caller saved, including stack
>> arguments. For register arguments (r1-r5), the verifier already marks
>> them as clobbered after each call. For stack arguments, the verifier
>> invalidates all outgoing stack arg slots immediately after a call,
>> requiring the compiler to re-store them before any subsequent call.
>> This follows the native calling convention where all function
>> parameters are caller saved.
>>
>> The x86_64 JIT translates r11-relative accesses to RBP-relative
>> native instructions. Each function's stack allocation is extended
>> by 'max_outgoing' bytes to hold the outgoing arg area below the
>> callee-saved registers. This makes implementation easier as the r10
>> can be reused for stack argument access. At both BPF-to-BPF and kfunc
>> calls, outgoing args are pushed onto the expected calling convention
>> locations directly. The incoming parameters can directly get the value
>> from caller.
>>
>> Global subprogs and freplace progs with >5 args are not yet supported.
>> Only x86_64 and arm64 are supported for now. Same selftests are tested
>> by both x86_64 and arm64. Please see each individual patch for details.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/189060
>>
>> Changelogs:
>>    v3 -> v4:
> Applied, but see veristat failures:
>
> |strobelight-server-monitors-gpu_mem_snapshot-gpu_mem_snapshot_bpf-gpu_mem_snapshot_bpf.o|handle_cu_mem_address_reserve_ret
> |success -> failure (!!)|-100.00 % |
> |strobelight-server-monitors-gpu_mem_snapshot-gpu_mem_snapshot_bpf-gpu_mem_snapshot_bpf.o|handle_cu_mem_create_ret
> |success -> failure (!!)|-100.00 % |
> |strobelight-server-monitors-gpu_mem_snapshot-gpu_mem_snapshot_bpf-gpu_mem_snapshot_bpf.o|handle_malloc_ret
> |success -> failure (!!)|-100.00 % |
> |strobelight-server-monitors-gpu_mem_snapshot-gpu_mem_snapshot_bpf-gpu_mem_snapshot_bpf.o|handle_mtia_allocate_exit
> |success -> failure (!!)|-83.67 %
>
> I couldn't see what might have caused it. Hopefully something minor.
> Pls follow up.

I found the reason, for gpu_mem_snapshot/bpf/gpu_mem_snapshot.bpf.c,
the source code:

static int alloc_exit(
     struct pt_regs* ctx,
     uint8_t alloc_type,
     uint64_t direct_addr,
     uint16_t extra_arg_cnt,
     uint64_t extra_arg0,
     uint64_t extra_arg1) {
   uint64_t pid_tgid = bpf_get_current_pid_tgid();
   ...
} // 6 arguments

SEC("uretprobe")
int BPF_KPROBE(handle_malloc_ret) {
   return alloc_exit(ctx, STROBELIGHT_GPU_MEM_ALLOC_SAMPLE, 0, 0, 0, 0);
}

But actually, the 'struct pt_regs* ctx' argument is a dead argument
and llvm compiler removed it. So for final code, the alloc_exit()
has 5 arguments and this is what bpf backend see.

Note that function call signature still has 6 arguments.

I am using llvm21 to test which is CI current using.

Without kernel stack argument support
=====================================

we have

btf_check_func_arg_match()
    btf_prepare_func_args()
      ...
      nargs = btf_type_vlen(t); // nargs = 6
      if (nargs > MAX_BPF_FUNC_REG_ARGS) {
         if (!is_global)
              return -EINVAL;
         bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\n",
              tname, nargs, MAX_BPF_FUNC_REG_ARGS);
         return -EINVAL;
      }

So bpf_prepare_func_args() return -EINVAL.
Eventually error code propagated back to check_func_call:

         err = btf_check_subprog_call(env, subprog, caller->regs);
         if (err == -EFAULT)
                 return err;
         ...
Since the return value is not -EFAULT, verification continues
although btf type does not agree with the actual parameter number.

With kernel stack argument support
==================================

we have

btf_check_func_arg_match()
   btf_prepare_func_args()
     ...
     nargs = btf_type_vlen(t); // nargs = 6
     ... // all arguments validated properly
   
   return 0

// error message: callee expects 6 args, stack arg1 is not initialized

This is expected since optimized function signature only has 5 parameters
in llvm bpf backend.

How to resolve this issue
=========================

I have merged a patch internally with the following manual change:

  static int alloc_exit(
-    struct pt_regs* ctx,
      uint8_t alloc_type,
      uint64_t direct_addr,
      uint16_t extra_arg_cnt,
@@ -728,7 +727,7 @@
  
  SEC("uretprobe")
  int BPF_KPROBE(handle_malloc_ret) {
-  return alloc_exit(ctx, STROBELIGHT_GPU_MEM_ALLOC_SAMPLE, 0, 0, 0, 0);
+  return alloc_exit(STROBELIGHT_GPU_MEM_ALLOC_SAMPLE, 0, 0, 0, 0);
  }
  
  SEC("uprobe")
@@ -768,7 +767,7 @@
  
  SEC("uretprobe")
  int BPF_KPROBE(handle_cu_mem_create_ret) {
-  return alloc_exit(ctx, STROBELIGHT_CU_MEM_CREATE_SAMPLE, 0, 0, 0, 0);
+  return alloc_exit(STROBELIGHT_CU_MEM_CREATE_SAMPLE, 0, 0, 0, 0);
  }

...


This should fix the issue and next CI gets meta bpf progs and the error
should be gone.

To really fix this issue, we should encode btf with true signatures, i.e.,
btf should match the actual function parameters. This should be done
in llvm.

