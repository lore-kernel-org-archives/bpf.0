Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6843B2E03E4
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431803; cv=none; b=mVjAdWYT8qlb1y1egY2CLZRBBdrHgRVPfPoQLqDOEFM3jed8ircLL+ZlRAZYIMsCgpd5o0G/Zp7MR784cF1vzBt5bQyScqMLUZyvQuMg/kMnrZOE8XyrCsjHhGR7i6ajPv4sZZbHs+hcyEf9TdBUvLD4+g2DbI97/6H1o7byLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431803; c=relaxed/simple;
	bh=vyggCS8/8Qv8n9WV96DxaxC/lL9XVH1s4J/vy2I3mts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mN3/NgUI/AF55xBfydhPdkTMA60iVb6YJpbbpvRjvGaIkquEq5L4C0hg10Ln22vRxMxti7MaMY2RfmwD6I0PfDr187gawG+QSvr322qCClA9NuEjGi09yGbvXdOPrOHCOWHlYTvx42WkRsNO+Ur6w7idDlgn7cFnmD3QUVbqsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UUxoE6FL; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UUxoE6FL"
Message-ID: <7b8e9361-2fc9-4302-b055-3657b19d2272@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783431789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aG3X1ya+0km0oxyUXBPlwAFhN6sHcih76OASOC2zKKE=;
	b=UUxoE6FLRyeyv1pRizrkZgNqtZh3uKh/XEq7RJ2BMQuBd0kbp8ZYmBJwNMHYw2dnfgd2ZH
	EUwT0j+uGcd5/WypU+Je+HfGb3393ucPzyumfpBcVeILXhJr5kbzcS6phn+PeyaZs+mzJW
	SEBD+SxCmGJJni5tp4ROvMtCIDxVXig=
Date: Tue, 7 Jul 2026 21:42:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 2/2] bpf: Reject programs with inlined helpers
 if JIT is not available
To: Eduard Zingerman <eddyz87@gmail.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
 <20260706040006.10331-3-yangtiezhu@loongson.cn>
 <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
 <e86ba5c0-41c2-4492-a316-7693c7d8d3fd@linux.dev>
 <1c1738784ae321ed5c9dfa0aca6d0f483592713f.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <1c1738784ae321ed5c9dfa0aca6d0f483592713f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/7 17:27, Eduard Zingerman wrote:
> On Tue, 2026-07-07 at 10:03 +0800, Leon Hwang wrote:
[...]
>>
>> Vincent Thiberville reported an interpreter fallback issue for the
>> internal BPF_ADDR_PERCPU insn [1].
> 
> As far as I understand, [1] is caused by map lookup helper inlining,

Correct.

> bpf_jit_inlines_helper_call() is unrelated this mechanism and only
> covers that three helpers I listed above.

Yes.

> 
>> And, I was trying to fix assorted interpreter fallback issues [2].
>>
>> I think it is worth fixing the interpreter fallback issue for the JIT
>> inlineable helper.
> 
> Meaning that you'd prefer the bpf_get_smp_processor_id() and co to
> work correctly w/o JIT, do I understand you correctly?
> 
Hmm, no. According to Alexei's comment [1], we should reject the helper
by the way of this patch.

[1] https://lore.kernel.org/bpf/DJN001X0S57Y.18CKUS4NDDQT1@gmail.com/

Thanks,
Leon

