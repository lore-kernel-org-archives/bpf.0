Received: from mta1.migadu.com (out-239.mta1.migadu.com [95.215.58.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC819DF6A
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565540; cv=none; b=r9/5u0lwsMUat5I6TvfWbkuBWlcYKW8aQjXnTNfVZwP43BnvsE9i4qbi9ty9xF4XBRbHI9jUhOsk4AVBGX2AWc02rYw4pBEg3G4QLanalzX044JDlS/IpMzrkpVoQEbOZuFEPD7DxPpw2i8BNjVkR8/uTqmXzLMqocuK6Sfr0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565540; c=relaxed/simple;
	bh=mDstDktF+1VqU/qbZ+6oJUzgnihwa5NgR6dTHJWUIxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1JDLok7VG1noChkiHEqfF7977O6dTLNW7p0w1qm7r5abHl6dnRzg8KShVD8UTCkoW28g7p0GjUhHGDvHTnpH/IYlJSCoQNK+yrEHK+PmLi+Lw2Ui0sV71ONI083gUuHfNxvF3vBbjERcjrQPoV6sOZWaekl8+RCCyoF6voWfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wsSsHmby; arc=none smtp.client-ip=95.215.58.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wsSsHmby"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mDstDktF+1VqU/qbZ+6oJUzgnihwa5NgR6dTHJWUIxQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786565536; v=1; x=1787170336;
 b=wsSsHmby5AZXWZOxaPnX9NhCP6VcRJejKFKTt1vRrgIl9bU9eq+1/iiE9/ZK94QgCfmWBKPw
 0tTH3/zjmhSXJRo1kyNN3kdAnUXAVuZBmOqzSKqUChwsXNoab6vD93QRBmiGtyvo1TTdo72OUiK
 p8veT3Wo7BjUY/8ZoF26Ebtc=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:cd95)
	by smtp.migadu.com with ESMTPS id 47b2de99582644d8;
	Wed, 12 Aug 2026 20:12:16 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <636f9c57-6bca-4f51-9c06-5c2918992ffc@linux.dev>
Date: Wed, 12 Aug 2026 13:12:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 07/13] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260811000947.2381981-1-yonghong.song@linux.dev>
 <f7b8141d61d6b7089679d057252d90cc7e05f22d1bf000ae2bf16259a45cf845@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f7b8141d61d6b7089679d057252d90cc7e05f22d1bf000ae2bf16259a45cf845@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/10/26 6:24 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Add verifier support for 16-byte returns in R0:R2
>>
>> LLVM 23 added support for returning a value in two registers for an
>> __int128, or a struct/union whose size is greater than 8 but not more than
>> 16 bytes. See LLVM patches [1] and [2].
>>
>> Before LLVM 23 the BPF backend could not return these values at all. A
>> by-value struct or union return (of any size) was rejected at compile time
>> with:
>>
>>    error: aggregate returns are not supported
>>
>> and an __int128 return failed later in the backend with:
>>
>>    fatal error: error in backend: unable to allocate function return #1
>>
>> Both are resolved in LLVM 23, which lowers such returns into the R0:R2
>> register pair.
>>
>> This patch adds handling for returns greater than 8 bytes in several
>> places: BPF subprogram returns (the main program, and both global and
>> static subprograms) and kfunc returns.
>>
>> The R0:R2 convention is only implemented in the JIT. The BPF interpreter
>> has no notion of a second return register: a BPF-to-BPF call goes through
>> JMP_CALL_ARGS and a BPF_EXIT hands back BPF_R0 alone, so a caller reading
>> R2 would see a stale value. Force the JIT wherever a caller can observe the
>> pair, that is at the call to a global subprogram in check_func_call() and
>> at the return from a static subprogram in prepare_func_exit(). Kfunc calls
>> need no separate handling since bpf_add_kfunc_call() already sets
>> jit_required for every kfunc call.
>>
>> A by-value struct or union returned by a kfunc must be composed only of
>> scalars, since the verifier models the returned register bits as an unknown
>> scalar and a pointer field would otherwise be laundered into one, escaping
>> provenance and reference tracking.
>>
>> A global subprogram must return a scalar in every return register. The
>> existing exemption for arena pointers now applies only when the return
>> value fits in R0 alone: both halves of a register pair carry a piece of a
>>> 8 byte scalar, so an arena pointer in either of them is a leak rather than
>> a legitimate return value. A subprogram whose whole return value is an
>> arena pointer is unaffected.
>>
>> A static subprogram is handled differently. The verifier walks into its
>> frame, so prepare_func_exit() propagates the return register(s) to the
>> caller. R0 holding a stack pointer has long been rejected outright there,
>> but R2 is deliberately not treated the same way. LLVM owns both sides of a
>> static call and is not bound by the ABI, so even with a 9..16 byte declared
>> return type it may leave R2 untouched when the caller only consumes the low
>> half; R2 can then hold an incidental stack pointer that is not a return
>> value at all, and rejecting the program would be a false positive.
>> Propagating the register as is would be worse: the callee frame is freed
>> immediately afterwards, leaving the caller with a PTR_TO_STACK that refers
>> to a frame which no longer exists. So the caller's R2 is marked
>> uninitialized instead, and only a caller that actually reads the returned
>> upper half fails. As with R0, a pointer into the caller's own frame is
>> scrubbed too, which is conservative but keeps the two registers consistent.
>>
>> Once callers read R0:R2, an extension program can no longer replace a
>> function with a >8 byte return value: an extension's own return is
>> capped at 8 bytes by the program-exit check above, so it would leave R2
>> stale for the target's callers. btf_check_type_match() cannot catch
>> this, as it compares return types by btf_type->info only and an int
>> carries no vlen, so a 16-byte __int128 and an 8-byte long compare equal.
>> Reject such an attach in bpf_check_attach_target() instead.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/190894
>>    [2] https://github.com/llvm/llvm-project/pull/206876
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> The main program is listed among the places that gain handling for a >8
> byte return:
>
>>    This patch adds handling for returns greater than 8 bytes in several
>>    places: BPF subprogram returns (the main program, and both global and
>>    static subprograms) and kfunc returns.
> For the main program the patch does the opposite, though.
> process_bpf_exit_full() gains an outright rejection:
>
> 	if (!cur_frame->subprogno && bpf_ret_reg_pair(env, 0)) {
> 		verbose(env,
> 			"return value larger than 8 bytes is not supported at program exit\n");
> 		return -EINVAL;
> 	}
>
> That rejection and its error message are not described anywhere in the
> changelog.  The only trace of it is the later backward reference:
>
>>    an extension's own return is
>>    capped at 8 bytes by the program-exit check above
> which points at a check the changelog never introduced, and the extension
> reject added in bpf_check_attach_target() rests entirely on that cap.
>
> Could the changelog say directly that a >8 byte return from the main
> program is rejected at BPF_EXIT, rather than listing the main program as a
> place where such returns are now handled?

Okay, will update commit message as you suggested in the above.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762

