Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D723B7B93
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048766; cv=none; b=An0aj6ZjwMyfIeRINCWSlb265K0oY6QjjuLZxnB4B/jyQb4Rxi6AvwGakYi4ECtXXnkRzv2TOv8YI8XDnHK6Q14wBhRaON4cIjAFfxggWbm+2MDwScTqkdaAjI7fxyUVTE52kFnRgUWtQywNrl88mPic0flTuvoIyGJecMbxk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048766; c=relaxed/simple;
	bh=HgPHL8gonzVC0uAGPlIdajaxxCvcRWBQI8RMcZDUHsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYrvpMYzZvxQbPMczs/3yOaiJk/WIsRqDbIyY93KWg3FrQnsQ5M4JJ4gIuwlh3vh6w4mnk8N+sD4Fo8hpoZF0ewizBHY0XgLcPsCl0G872YetCk3FF1y/WE8fGs73UI47kaeBaEz1rx8umBbfii/rwuCGUPZFiqMwW9qh2WxzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b4iQSGrm; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b4iQSGrm"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HgPHL8gonzVC0uAGPlIdajaxxCvcRWBQI8RMcZDUHsE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790048761; v=1; x=1790653561;
 b=b4iQSGrmW2y7ETUnpY8Ef4+0b98BjOf6aKHeTh2/SVgoT84BcZP8zLXdvgFjC5ftR3qIfbnw
 168F36U+819jNg+WuzF6bTKHj+74asoGTu5T5STiXwEb78notXaKbgeLwkuD1NGKfd1/UabaYyv
 N+b3DYP6aSrVgOk3C9Gh07wE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ec91fd8032a34d01;
	Tue, 22 Sep 2026 03:46:01 +0000
X-Mizu-Trace-ID: ec91fd8032a34d01
X-Migadu-Flow: FLOW_OUT
Message-ID: <73a766ca-8198-4677-8c29-29fac8489f73@linux.dev>
Date: Mon, 21 Sep 2026 20:45:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 07/20] bpf: Refuse exception cleanup shapes
 bpf_throw() cannot dispatch
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210109.1719713-1-yonghong.song@linux.dev>
 <d87ccb2d98acc167a80ce894a844abb29ee433a9.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d87ccb2d98acc167a80ce894a844abb29ee433a9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/26 5:30 PM, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 14:01 -0700, Yonghong Song wrote:
>> The table is on the instructions and the landing pads are in the control
>> flow graph. What is left before bpf_throw() can be taught to dispatch them
>> is to work out what that walk will need, and refuse the shapes it could not
>> handle.
>>
>> bpf_check_cleanup_exceptions() runs after bpf_check_cfg(). Everything it
>> needs is control flow, so it reads what that walk has already worked out
>> rather than working it out again:
>>
>>    subprog_info.might_throw   which subprograms an exception may leave,
>>                               closed over the call graph by
>>                               merge_callee_effects() as the walk pops each
>>                               callee
>>    cleanup_reachability()     what each instruction can reach -- a resume, a
>>                               plain exit, a throw, an indirect jump
>>    cleanup_mark_pad_bodies()  which instructions only ever run with an
>>                               exception already in flight
>>
>> What it refuses:
>>
>>    - a pad that reaches both a resume and a plain exit, or neither: nothing
>>      says whether it is a cleanup pad or a catch pad
>>    - a catch pad, which ends in a plain exit: the walker calls a pad as a
>>      subroutine and cannot hand a frame back its own execution
>>    - a throw in a pad, or a call from a pad to a subprogram that can throw:
>>      a second unwind over frames the first is still discarding
>>    - a bpf_unwind_resume() outside a pad body
>>    - a subprogram that may unwind used as a helper callback: the helper's
>>      own kernel frame would end the walk before it found a boundary
>>    - a tail call, an indirect jump, or an outgoing on-stack call argument in
>>      a pad body, all of which touch a stack the pad does not own
>>    - a BPF_LD_[ABS|IND] in a pad body: a failed load leaves the subprogram
>>      through the hidden exit gen_ld_abs() patches in, and an exit in a pad
>>      is the epilogue, which pops off the walker's stack and returns through
>>      the frame the walk is discarding
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Why is it necessary to hand-roll a CFG traversal and a separate pass
> for this check? Given that bpf verifier state already maintains
> `unwinding' flag, the instructions properties can be checked from
> do_check_insn(), e.g.:
> - bpf_throw()               -- reject if unwinding
> - call to a throwing global -- reject if unwinding
> - bpf_unwind_resume()       -- require unwinding and the pad-owning frame
> - BPF_EXIT                  -- reject in the pad-owning frame, allow in callees
> - LD_{ABS,IND}              -- reject if unwinding
>
> I think that would take much less code, wdyt?

This is a good idea. Let me try. Thanks!

>
>>   include/linux/bpf_verifier.h |   1 +
>>   kernel/bpf/exception.c       | 404 +++++++++++++++++++++++++++++++++++
>>   kernel/bpf/exception.h       |   2 +
>>   kernel/bpf/fixups.c          |   1 +
>>   kernel/bpf/verifier.c        |   8 +
>>   5 files changed, 416 insertions(+)
> ...

