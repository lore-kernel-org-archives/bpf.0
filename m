Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A079DA
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776816579; cv=none; b=bnl8eKDAJyQ+9GwmRDsrK0/g+4ktjWGr3PPWpi05OQGdMsv02uENrn3Prevh46eyDX2PASC7zbjeDx+fGWsPGOT9ZhdvwNvB9E8xhedXQMcVgpnsL7JulCXA6khBnp49Iq8snqmsZN5gA+KaHIDxMngWdeS4DrFyiojnhnt534M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776816579; c=relaxed/simple;
	bh=yJJzWrnNgywcSNFLdC5NA3yx7NDXdZL8ebqh/wjcsKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yz2mOEs5xiraCvC2MiP0wAoUKqHFjeR0SMQ0WOVdIH3Pv1i+5OMfItU9uSZIN7ueoK0DLuwqZ3+hNBM98U7BHv7OSvHx9OL93pJuLjogPksdzkdyWxMXSgSlMWGwoMR1zlv0r7ot+aIj64T0YCWs8oB6UgsyClsTLyAZ3/HnOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D774VSDy; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D774VSDy"
Message-ID: <a98248e8-8b70-4125-b494-1a5ff12396fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776816570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqZ8Jq6AVFSQ1i1LPGkrG5oiVVHKCQlufAsTrVWCWzM=;
	b=D774VSDyLCYsHPC3p8OWpbF7ta8cM+e/DM/zb6AW1A6I48tAg/y0tAIeS1xbXbovVGb+BZ
	FknHFzEoe/RSJqDue16CpBzTTWvUkrHWygZqPQEmoGpL/4TGDBTRtxIV3FXDJ+2cDrzhzA
	ZfAeLbvRQkJc93nwrjRSQ57lviTy03Y=
Date: Tue, 21 Apr 2026 17:09:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 8/9] bpf: Introduce bpf register BPF_REG_PARAMS
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
 <20260421172007.3512280-1-yonghong.song@linux.dev>
 <DHZ6DPP9Q67P.17W3L0YIPN8Z4@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DHZ6DPP9Q67P.17W3L0YIPN8Z4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/21/26 3:10 PM, Alexei Starovoitov wrote:
> On Tue Apr 21, 2026 at 10:20 AM PDT, Yonghong Song wrote:
>>   
>>   /* Kernel hidden auxiliary/helper register. */
>> -#define BPF_REG_AX		MAX_BPF_REG
>> -#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
>> +#define BPF_REG_PARAMS		MAX_BPF_REG
>> +#define BPF_REG_AX		(MAX_BPF_REG + 1)
>> +#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 2)
> ...
>
>> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
>> @@ -630,13 +630,13 @@ __xlated("...")
>>   __xlated("4: r0 = &(void __percpu *)(r0)")
>>   __xlated("...")
>>   /* may_goto expansion starts */
>> -__xlated("6: r11 = *(u64 *)(r10 -24)")
>> -__xlated("7: if r11 == 0x0 goto pc+6")
>> -__xlated("8: r11 -= 1")
>> -__xlated("9: if r11 != 0x0 goto pc+2")
>> -__xlated("10: r11 = -24")
>> +__xlated("6: r12 = *(u64 *)(r10 -24)")
>> +__xlated("7: if r12 == 0x0 goto pc+6")
>> +__xlated("8: r12 -= 1")
>> +__xlated("9: if r12 != 0x0 goto pc+2")
>> +__xlated("10: r12 = -24")
> maybe shift it to r15 right away, so we don't need to touch this code
> if/when true r12 is introduced?

We can do this. Do you think the following is okay:

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b77d0b06db6e..fe7b6b943ea4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -59,9 +59,9 @@ struct ctl_table_header;
  
  /* Kernel hidden auxiliary/helper register. */
  #define BPF_REG_PARAMS         MAX_BPF_REG
-#define BPF_REG_AX             (MAX_BPF_REG + 1)
-#define MAX_BPF_EXT_REG                (MAX_BPF_REG + 2)
+#define MAX_BPF_EXT_REG                (MAX_BPF_REG + 1)
  #define MAX_BPF_JIT_REG                MAX_BPF_EXT_REG
+#define BPF_REG_AX             (MAX_BPF_REG + 4)
  
  /* unused opcode to mark special call to bpf_tail_call() helper */
  #define BPF_TAIL_CALL  0xf0
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ae10b9ca018d..3ad286ef3085 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1299,8 +1299,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
         u32 imm_rnd = get_random_u32();
         s16 off;
  
-       BUILD_BUG_ON(BPF_REG_PARAMS + 2 != MAX_BPF_JIT_REG);
-       BUILD_BUG_ON(BPF_REG_AX + 1 != MAX_BPF_JIT_REG);
+       BUILD_BUG_ON(BPF_REG_PARAMS + 1 != MAX_BPF_JIT_REG);
+       BUILD_BUG_ON(BPF_REG_AX != MAX_BPF_JIT_REG + 3);
  
         /* Constraints on AX register:
          *


