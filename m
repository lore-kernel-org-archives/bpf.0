Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241452F39CE
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721333; cv=none; b=uwRicSR/+4v6E6syEGMf8MFgtgQjEs9DgWv4S4vde2hwtYdgF8L2Pmwo40NP4jcyBCYc7b6WMG/SvamF5inMigIei5w1pppj+G39y69QuioQPyleyVIeJyUWPOjTTBz34Qaep5aHifhdODJ1pKwCR6OAoeR6oQ9WwkEn7y9qZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721333; c=relaxed/simple;
	bh=YqzkF3t9JsUfH3ytHJKrAmAe0npwiEGA8Sexp5Fwajo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+fzj4+BoLqwtvO6OaP8W8mk7I3Dz+1J41BUSI+stz6irKhtyIjUKDH7ermNdFLuazY8LtWRNLIQXaiZaI9CUE9LuGelEDal6kPZwC9yvfsj0mK8v6R72fhYj5/E+HCosRlTnTLNnRRaGBV/w3dn9BZx0qX6w3r1jZnS0rAMF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rBp82SML; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rBp82SML"
Message-ID: <b2fe4e37-d210-4c58-9eda-185834af7338@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785721316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phjtXBZH5qw3aRtfmDQaQR5EW/xbyoroD0eWLT6vTSk=;
	b=rBp82SMLYwhGqV2sRJXOtjo316/RWT8rmKeyjfFgTzVXNy5TWnGSyNy5L5sovKe5rZtWAN
	yytwdC9nfkODTzIHUeQzfjovcpUS3q9q65jToTDh29G5Rm5gxaop3CLyUA2BhKC7oM3uWm
	a+ygFYbYuvK2WvPIMpbbysk2eiy9qtg=
Date: Mon, 3 Aug 2026 09:41:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix sleepable check for tracing prog
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Sechang Lim <rhkrqnwk98@gmail.com>, Varun R Mallya <varunrmallya@gmail.com>,
 Viktor Malik <vmalik@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20260725132624.78373-1-leon.hwang@linux.dev>
 <CAEf4BzaoQaODE4F1wfrp37=83bePY=gKpunacKr3rmO230+B3Q@mail.gmail.com>
 <66eaf62b-202b-45b9-8934-fbbc80caa84a@linux.dev>
 <CAEf4BzbjmW0e6DqFLUAyV+m_usHSkHpux3AdS72bJtsmYQC_LA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzbjmW0e6DqFLUAyV+m_usHSkHpux3AdS72bJtsmYQC_LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 31/7/26 23:21, Andrii Nakryiko wrote:
> On Thu, Jul 30, 2026 at 10:20 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 31/7/26 08:07, Andrii Nakryiko wrote:
>>> On Sat, Jul 25, 2026 at 6:27 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
>>>> is allowed to attach to '__x64_'-alike prefix symbols.
>>>>
>>>> It is because the verifier does not verify whether the symbol is a kernel
>>>> function or a bpf prog. That said, a sleepable tracing prog is allowed to
>>>> attach to a bpf prog target whose name has '__x64_'-alike prefix.
>>>>
>>>> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
>>>
>>> we do have addr, so we should be able to distinguish between attaching
>>> to kernel function vs BPF program, no?
>>
>>
>> Yes, we can distinguish a bpf prog from a kernel function by addr.
>>
>> I'd prefer passing 'tgt_prog' to btf_id_allow_sleepable() as a simple
>> change.
>>
> 
> I don't think there is a need for new tgt_prog argument, we can just
> check that supplied btf is not kernel/module BTF (see btf_is_kernel())
> 

Makes sense.

Will use btf_is_kernel().

Thanks,
Leon

