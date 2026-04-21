Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0740DFCE
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 04:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776745123; cv=none; b=qNKIbV1FY3U+99432bryzdsAJeIU+fibvYRpZtd6wAjSK2mJbsjd8P7xUfBsZo6IwjY4Cwma7UVmmukXI4wmgNuIEQXXrULBl/V13Uq/HzfPo5dSimRBGMVGLcjkORUlAof7mxwX6NQXxkdOBsA8gX1IOax6V1xoTLuyZiz1hVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776745123; c=relaxed/simple;
	bh=v7vaMaIdwKGJ/+wLqJDKxNvhiFy7qPz5Ituf0EM8J6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZS9JjIfyK5g9go9qK0irLy9mFzodp+GjMgamnt6GYf01duceUYa8BVLHPWuF9XlDxkO6Tr4ZXHW869Z5RJZ4NErj199uAh2k9m6NnIsT7Gd6VUonstTEbsE+yLztO5/554uyZn+e445HgSKijx3f7S3Upw9B0BAB727krQtq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r1XodYES; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r1XodYES"
Message-ID: <2a2ae6a9-7b0d-4baf-88ee-4b6896734acf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776745120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xd6rg3NfQs/PnowtYaQGczD00baDqnx0Bww7gLea87Q=;
	b=r1XodYESylgeIHRdcRIlpF66QfsTtKixucV/WT5zPMsx+cV5a1+SRz0tsvzxGYsBuJMM0R
	jbzsEvvuKoJ0AXqdhYCQzCLHywrPR92NmVyQlwm+UF2/Vy/suhTcJNxmltXpOPL9SKSmP7
	5IKf7XAoklph6fHspaVV7ThZVuKPf3U=
Date: Mon, 20 Apr 2026 21:18:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 08/24] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Will Deacon <will@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>
References: <20260421033252.575374-1-yonghong.song@linux.dev>
 <20260421033333.580534-1-yonghong.song@linux.dev>
 <CAADnVQ+vD_06Xs2_=7S4scvv+9_STZVgWtTKTrHRbRJB04OkaA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+vD_06Xs2_=7S4scvv+9_STZVgWtTKTrHRbRJB04OkaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/20/26 8:51 PM, Alexei Starovoitov wrote:
> On Mon, Apr 20, 2026 at 8:36 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Currently BPF functions (subprogs) are limited to 5 register arguments.
>> With [1], the compiler can emit code that passes additional arguments
>> via a dedicated stack area through bpf register BPF_REG_PARAMS (r11),
>> introduced in the previous patch.
>>
>> The compiler uses positive r11 offsets for incoming (callee-side) args
>> and negative r11 offsets for outgoing (caller-side) args, following the
>> x86_64/arm64 calling convention direction. There is an 8-byte gap at
>> offset 0 separating the two regions:
>>    Incoming (callee reads):   r11+8 (arg6), r11+16 (arg7), ...
>>    Outgoing (caller writes):  r11-8 (arg6), r11-16 (arg7), ...
>>
>> The following is an example to show how stack arguments are saved
>> and transferred between caller and callee:
>>
>>    int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>>      ...
>>      bar(a1, a2, a3, a4, a5, a6, a7, a8);
>>      ...
>>    }
>>
>>    Caller (foo)                           Callee (bar)
>>    ============                           ============
>>    Incoming (positive offsets):           Incoming (positive offsets):
>>
>>    r11+8:  [incoming arg 6]               r11+8:  [incoming arg 6] <-+
>>    r11+16: [incoming arg 7]               r11+16: [incoming arg 7] <-|+
>>                                           r11+24: [incoming arg 8] <-||+
>>    Outgoing (negative offsets):                                      |||
>>    r11-8:  [outgoing arg 6 to bar] -------->-------------------------+||
>>    r11-16: [outgoing arg 7 to bar] -------->--------------------------+|
>>    r11-24: [outgoing arg 8 to bar] -------->---------------------------+
>>
>> If the bpf function has more than one call:
>>
>>    int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>>      ...
>>      bar1(a1, a2, a3, a4, a5, a6, a7, a8);
>>      ...
>>      bar2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
>>      ...
>>    }
>>
>>    Caller (foo)                             Callee (bar2)
>>    ============                             ==============
>>    Incoming (positive offsets):             Incoming (positive offsets):
>>
>>    r11+8:  [incoming arg 6]                 r11+8:  [incoming arg 6] <+
>>    r11+16: [incoming arg 7]                 r11+16: [incoming arg 7] <|+
>>                                             r11+24: [incoming arg 8] <||+
>>    Outgoing for bar2 (negative offsets):    r11+32: [incoming arg 9] <|||+
>>    r11-8:  [outgoing arg 6] ---->----------->-------------------------+|||
>>    r11-16: [outgoing arg 7] ---->----------->--------------------------+||
>>    r11-24: [outgoing arg 8] ---->----------->---------------------------+|
>>    r11-32: [outgoing arg 9] ---->----------->----------------------------+
>>
>> The verifier tracks stack arguments separately from the regular r10
>> stack. The stack_arg_regs are stored in bpf_func_state. This separation
>> keeps the stack arg area from interfering with the normal stack and
>> frame pointer (r10) bookkeeping. Similar to stacksafe(), introduce
>> stack_arg_safe() to do pruning check.
>>
>> A per-state bitmask out_stack_arg_mask tracks which outgoing stack arg
>> slots have been written on the current path. Each bit corresponds to
>> an outgoing slot index (bit 0 = r11-8 = arg6, bit 1 = r11-16 = arg7,
>> etc.). At a call site, the verifier checks that all slots required by
>> the callee have their corresponding mask bits set. This enables
>> precise per-path tracking: if one branch of a conditional writes arg6
>> but another does not, the mask correctly reflects the difference and
>> the verifier rejects the uninitialized path. The mask is included in
>> stack_arg_safe() so that states with different sets of initialized
>> slots are not incorrectly pruned together.
> you didn't address my comments.

After sending out v7, I then found you have some comments for v6. I will
address all issues in the next revision.

>
> pw-bot: cr
>

