Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D1194AE6
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741223; cv=none; b=eZurFSPIfZ15H1ztDd1sXZIMXmaZAJkJr0ihy0NuTMZFlkSqXFDo3hZSeW2tVqsOCJdmZdb9nV6QMtVAL0wDmTN7XSxC9cF8IuhF2iIu41Gh9m3izaZnsFQ1GtVEj7aVoaLg3JN3pm9eLEERwTGk9fw/hUoUiKndwcx3B5PeCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741223; c=relaxed/simple;
	bh=YjvCXrmkXvc5p34BkRbGSbVvUh7v9W22aOyPpMUTucU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FL38AmWFMWqLO35bgElNTqsYBgqxXGypXyCJZcy5Jm9XxiLMnLMSVhAbyLmRQjQEoW/fDOP0SmRWbSIRxt46TGr3jYHsKotmIlDuAJsY3g4Wn5jZVS7+Ham9nxuH6Fgd87Vvud42pJvAFqLp42s1gaAnZWZt/zsrOWkVYgNQydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R3X2aHe/; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R3X2aHe/"
Message-ID: <b4b906cb-e7b2-4ba7-bbb9-e6c813238859@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782741209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiHBYSotC47dxNOr6QB9cbxgvyAIGmUOJM5SiwG5fR0=;
	b=R3X2aHe/5naXW6ThXGZdc4KigHamrt7p5Zd8jORL24i2kDQ8ouT363ZIN3fqtUvYiapaHn
	E6hXWWGGCQTpeDUKNgyvX7syxjs79+E3MjodzugnPuTyz1bTlyyVB8Wj98nOCORrWhMs8e
	EvROL9P2rmInqkbQvBNCRdd/t63yWL0=
Date: Mon, 29 Jun 2026 21:53:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
 Rong Tao <rongtao@cestc.cn>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <855e44f3-d22c-47e5-8bd1-c5d9f7014a75@linux.dev>
 <ec28f0f9-0693-4c9b-88fa-bffca446a63c@huaweicloud.com>
 <b8d8ab5e-bef1-4c95-8e5b-ea9768041b2e@linux.dev>
 <55499fcf-d552-4366-9016-21ede7f687ac@huaweicloud.com>
 <4f30012f-778b-4c7d-b610-2e18cf01abdd@linux.dev>
 <678ec73d-06f1-4860-94be-be000ca462d4@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <678ec73d-06f1-4860-94be-be000ca462d4@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/6/29 19:32, Xu Kuohai wrote:
> On 6/29/2026 6:55 PM, Leon Hwang wrote:
>> On 29/6/26 15:51, Xu Kuohai wrote:
>>>>
>>>> With the elimination, the callsite of 'subprog' has been eliminated.
>>>>
>>>> However, as you mentioned above, the argument preparation insns are
>>>> kept.
>>>>
>>>
>>> I see, the CALL insntruction is removed, not patched to NOP.
>>>
>>> So the call site is either a call to subprog, or totally removed. The
>>> fentry
>>> tracing only works when the CALL instruction and the subprog are not
>>> eliminated.
>>> This is exactly what SDT tries to solve.
>>>
>> So, why not add a macro for the stub following the subprog+fentry idea?
>>
>> #define DEFINE_TRACING_STUB(__stub, ...)     \
>> static __noinline void __stub(...)        \
>> {                        \
>>     ...                    \
>> }
>>
>> DEFINE_TRACING_STUB(my_trace, int, len, int, ret);
>>
>> SEC("xdp")
>> int xdp_prog(struct xdp_md *ctx)
>> {
>>     ...
>>     my_trace(len, ret);
>>     ...
>> }
>>
>> Then, add a libbpf API bpf_program__remove_stub(prog, my_stub) to drop
>> the stub by the way like my demo.
>>
> 
> Since the stub prog is dropped in libbpf, where is the fentry prog
> attached?
> 

No. By default, the stub prog won't be dropped by libbpf. The
bpf_program__remove_stub() API is provided so that users can
intentionally remove the stub prog.

Maybe bpf_program__remove_subprog() would be a better name for the API,
because it is to remove a subprog.

Thanks,
Leon

