Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327A1DA23
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776533834; cv=none; b=BmHOv+4iuuz87t1ZK1kZwx23cKma4SKRfytYJ75V9sPR8kCtmepy8PpNP4tm9FBFCqrVnF5C+fPaeL2+iCSn+QjREsY0CsBe2z0tIcTj5Brd3miOYC4rASYPAlHJ4ay6xiNhPFTGrBhbObXw4KyFj72IonQWiaeeWgZKwhkLFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776533834; c=relaxed/simple;
	bh=wNIIhB+V/5T0EQVlLcxb71XgtA1Ge97iXGvi32Jpa78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfG/a156wPaZnDQ3BnDg4rVwrTgcIjJQ1dZ/A/jNh1ymqYKRiat9Yl7M5xnO202UcxEMgKGj4ffjj7Z1atbhxHNooR71EQHMHq4BasQqResHksAy5jhXEKrdHnREXboczVctK0I0qyhI/tr1VFBdfuESuBgdlxHxdvupLOMO+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=psrqRGvj; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="psrqRGvj"
Message-ID: <45f70cff-6693-4cc9-b48f-eab9bce00969@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776533830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRh/p/YnUrAlL1nARbFD+xQ1kPIOOV2zWLUkCYDziro=;
	b=psrqRGvjp046qRhfRZ7QA+nm05GK55sEYrJrP6zEq0ZwZsNzZ0GNrCfe9wwWL6pV78bwA9
	v9vuuS8KwRcdeL7f5gKK5iwVlxrlqx7exQMbixbWx227Fyql2sAzSubuxKtXpsERkxjYY4
	B3/+sDctqTMt3l0iFb5jIUwRvwvZwco=
Date: Sat, 18 Apr 2026 10:37:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Reject stack arguments if tail
 call reachable
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417034749.2630580-1-yonghong.song@linux.dev>
 <20260417040800.A5345C19425@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260417040800.A5345C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:08 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Critical] False negative allowing tail calls and stack arguments together, leading to JIT memory corruption
> - [High] State leak in verifier DFS causing false positive rejections of valid BPF programs
> --
>
> commit df24720ae892549300f1910df635621a3875dbdf
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject stack arguments if tail call reachable
>
> This commit updates the verifier to reject BPF programs if they contain both
> tail calls and stack arguments. This is enforced during the maximum stack
> depth check traversal.
>
>> Tailcalls are been deprecated. So reject stack arguments
>> if tail call is in the way.
> This isn't a bug, but there is a grammatical error here. "are been" should
> likely be "have been".
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 7a65b532e84a8..739c3127520c3 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5662,6 +5662,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>   				verbose(env, "cannot tail call within exception cb\n");
>>   				return -EINVAL;
>>   			}
>> +			if (subprog[tmp].incoming_stack_arg_depth ||
>> +			    subprog[tmp].outgoing_stack_arg_depth) {
>> +				verbose(env, "tail_calls are not allowed in programs with stack args\n");
>> +				return -EINVAL;
>> +			}
> Looking at the earlier parts of check_max_stack_depth_subprog(), the local
> variable tail_call_reachable only appears to be set to true when jumping
> into a callee that has a tail call:
>
>      if (subprog[idx].has_tail_call)
>          tail_call_reachable = true;
>
> If the main program (subprog[0]) natively contains a tail call,
> tail_call_reachable would remain false, causing this entire check block to
> be skipped.
>
> Does this logic successfully catch the case where the main program itself
> contains a tail call and also uses stack arguments?
>
> If this escapes the verifier, the JIT might emit prologue tail call
> instructions (pushing 24 bytes on x86) while calculating stack argument
> offsets assuming no tail call pushes, overwriting the BPF program stack.
>
> Could this regression lead to memory corruption in the JIT?
>
> When the traversal pops a frame to return to the caller and jumps back to
> continue_func, the tail_call_reachable variable is not reset to false:
>
>      /* pop caller idx from callee */
>      idx = dinfo[idx].caller;
>      ...
>      goto continue_func;
>
> If the verifier traverses a subprogram with a tail call, returns, and then
> traverses a completely unrelated sibling subprogram that uses stack
> arguments, it seems it would incorrectly evaluate tail_call_reachable as
> true and reject the valid sibling.
>
> Is there a state leak in this DFS traversal that could cause false positive
> rejections of valid BPF programs?

You are right. This has been their for sometime. So I guess we can live
with it even for stack arguments.

>
>>   			subprog[tmp].tail_call_reachable = true;
>>   		}
>>   	if (subprog[0].tail_call_reachable)

