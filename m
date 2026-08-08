Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93633263B
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786205019; cv=none; b=iDl3Fe/na10t5NF+9klw/S/WWz2McVwRndFQRi45OZOWApYyMYQ9CE2XDIXhmWSY9z22mTd45POuW1MzSLR/wmBSA38sNwQvbupJMYzIhj1qigEqzvDlgNyBNGIV47FRvd9vc6f/3pLwwAEyvgemX1kmJjwKEBPsgQI3zgaKCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786205019; c=relaxed/simple;
	bh=ILHf0iFPsOL//tvtiBRcG1RLIHbs+oDyF4gx2B63WiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPWlZrmV9W+w3FUtze1P74/mMjJSbcdy5vix2OZA9ykX2Ohf1L/lwzHIis7e4fJYNa98MUo6chDXEc85FJao3EnWALAM2FHoFMT69q4/+JlHM3a8PJ7q4VKwYNDeO1rITbWcPY0Hr7CyPsbgcWNf6tuagI8eDfTw1CB85VsQ3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j10b+b6N; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j10b+b6N"
Message-ID: <1de41ecc-9ff3-42b7-8b1b-f71b233965ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786205004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAbay96Idmxx0yTlNvviqCOHwEEy0ezS9jpgEf1b4qc=;
	b=j10b+b6NYJn/0GDK6/O3nRk6OjafP95iLGzxHqIGpokvsudDdETSjF2EtTqdLmpY9nXEI/
	frSLisZf9OR5llPulxiyR2C58e9pqa62ZNv+s/KyRHOE6smVHF25lMErHtd4s/d8PLVzmh
	7Dn4cUwE72fjESkl5dbIiWs0AolWXO0=
Date: Sat, 8 Aug 2026 09:02:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 05/13] bpf: Account R2 of register-pair
 returns in live register analysis
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
 <20260804203548.1872337-1-yonghong.song@linux.dev>
 <20260804211451.A7F621F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260804211451.A7F621F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/4/26 2:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The verifier fails to check if BPF_REG_2 is initialized at BPF_EXIT for global subprograms returning > 8 bytes, which can lead to leaking uninitialized memory.
> - [High] The verifier fails to copy the callee's R2 to the caller's R2 in prepare_func_exit() for static subprograms returning > 8 bytes.
> --
>
> --- Patch [5]: [PATCH bpf-next v2 05/13] bpf: Account R2 of register-pair returns in live register analysis ---
> commit 149c9afee6775ff575a63e08693b340337d96491
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Account R2 of register-pair returns in live register analysis
>
> This commit updates the live register analysis in the BPF verifier to mark R2
> as read at BPF_EXIT for subprograms returning a value larger than 8 bytes. It
> uses bpf_ret_reg_pair() to determine if a subprogram returns its value in the
> R0:R2 register pair.
>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 0aadfbae0acc5..68df6d8db4bda 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
> [ ... ]
>> @@ -2174,7 +2179,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
>>   			break;
>>   		case BPF_EXIT:
>>   			def = 0;
>> -			use = r0;
>> +			use = ret_reg_pair ? (r0 | BIT(BPF_REG_2)) : r0;
> [Severity: High]
> Does check_global_subprog_return_code() also need to check BPF_REG_2 when the
> subprogram returns a register pair?
>
> If a global BPF subprogram returns a 16-byte value (e.g., an __int128 or
> struct) but does not write to R2 before exiting, the verifier only validates
> that BPF_REG_0 is initialized:
>
> kernel/bpf/verifier.c:check_global_subprog_return_code() {
>      ...
> 	return check_global_ret_scalar_reg(env, BPF_REG_0);
> }
>
> Although check_global_ret_scalar_reg() was refactored earlier in this series
> so that it can be reused for R2, there appears to be no call added to check R2
> in check_global_subprog_return_code().
>
> Can this allow a global subprogram to leak uninitialized kernel memory or
> pointers in the CPU register corresponding to R2 back to the kernel caller?
>
> [Severity: High]
> Additionally, should prepare_func_exit() copy the callee's R2 to the caller's
> R2 for static subprograms returning > 8 bytes?
>
> Currently, prepare_func_exit() only copies R0:
>
> kernel/bpf/verifier.c:prepare_func_exit() {
>      ...
> 	} else {
> 		/* return to the caller whatever r0 had in the callee */
> 		caller->regs[BPF_REG_0] = *r0;
> 	}
>      ...
> }
>
> If a BPF program calls a static subprogram that returns a 16-byte value, and
> the caller attempts to use the upper 8 bytes returned in R2, won't the verifier
> reject the valid program with a read of uninitialized register error?
>
> This happens because the caller's R2 was marked NOT_INIT prior to the call by
> clear_caller_saved_regs(), but prepare_func_exit() does not propagate the
> callee's R2 value back to the caller.

We should be okay here. The actually allowing R2 is in later commit
  Add verifier support for 16-byte returns in R0:R2

>
>>   			break;
>>   		case BPF_CALL:
>>   			def = ALL_CALLER_SAVED_REGS;

