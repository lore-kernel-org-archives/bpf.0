Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77FD54FAA
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710018198; cv=none; b=KPNAy6djjRuEiPeaRSxvlHwFgrqBi8jVj24kmiF2DS6efeKXuGvCiGgW9hTXDwUMoqvb5mLh/NGwq3Pqd/LxrZuNqMkYgDTbLHzweBVQyJny5b2Ssb2ytojgiFEaPQoS37NampJIDYdBxKMCEgObUDJ6fmfKrzD9Z1J8rhhzMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710018198; c=relaxed/simple;
	bh=Sl4iPFCO0XC4m+zbZNNFYAWYOkWII/pvjwLkH48ADB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWUqzzRbcEykIeW0bmIzOd8FP6rM8e5KlunDMuBeD/g6uUxZQrz0PP+y+gh9jTDP43mAKmmJFXM/3O1o8xXRxv97Ey0RPqKJlxKddz/k8IYrIZscJNRNQRRG7jfginZpDbxDaFFY+1bLkE+1srDCGub0RcKR0258AwO4Oy+n4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V8CUFKnJ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V8CUFKnJ"
Message-ID: <d6c5fdef-6b96-4be5-b778-2f79f49fb193@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710018193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sl4iPFCO0XC4m+zbZNNFYAWYOkWII/pvjwLkH48ADB0=;
	b=V8CUFKnJwBxCfzQjDJJbAyyiTYl+oDErTU30B410eu7eYg2JtN6mkNUkqByQsdtCmTzo7V
	rYY1RE8uwwYBNQBJETlnv52xX4TUc2VlcX1CsLNHG1JrpqpYcRxy+BIYTUGMHvQLzUbQ1P
	0XMkfXwijnXA2+uxOM7U4YSdeM99+aM=
Date: Sat, 9 Mar 2024 13:03:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/5] bpf: Allow helper
 bpf_get_ns_current_pid_tgid() in cgroup and sk_msg programs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Yury Namgung <ynamgung@meta.com>
References: <20240307232659.1115872-1-yonghong.song@linux.dev>
 <20240307232705.1116787-1-yonghong.song@linux.dev>
 <CAEf4Bzb+=OyvTtqwu_q1ouY7dcNVm=uD5rpYohAqGdjFBQntKQ@mail.gmail.com>
 <c8c7968e-79f8-47ec-b549-025af95ff895@linux.dev>
 <CAADnVQJiEEDereGw-pbNj+RAaaZMNKY8m_M_dyPrOEs3o0x_9g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJiEEDereGw-pbNj+RAaaZMNKY8m_M_dyPrOEs3o0x_9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/9/24 11:10 AM, Alexei Starovoitov wrote:
> On Sat, Mar 9, 2024 at 10:40 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 3/8/24 5:06 PM, Andrii Nakryiko wrote:
>>> On Thu, Mar 7, 2024 at 3:27 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> Currently bpf_get_current_pid_tgid() is allowed in tracing, cgroup
>>>> and sk_msg progs while bpf_get_ns_current_pid_tgid() is only allowed
>>>> in tracing progs.
>>>>
>>>> We have an internal use case where for an application running
>>>> in a container (with pid namespace), user wants to get
>>>> the pid associated with the pid namespace in a cgroup bpf
>>>> program. Currently, cgroup bpf progs already allow
>>>> bpf_get_current_pid_tgid(). Let us allow bpf_get_ns_current_pid_tgid()
>>>> as well.
>>>>
>>>> With auditing the code, bpf_get_current_pid_tgid() is also used
>>>> by sk_msg prog. So I added bpf_get_ns_current_pid_tgid()
>>>> support for sk_msg prog, so now for all places where
>>>> bpf_get_current_pid_tgid() can be used, bpf_get_ns_current_pid_tgid()
>>>> can be used as well.
>>>>
>>> If tracing can call both bpf_get_current_pid_tgid() and
>>> bpf_get_ns_current_pid_tgid(), can't we just add both into
>>> bpf_base_func_proto() and have them available for all types of BPF
>>> programs? If it's safe for tracing, it's safe for any program type, so
>>> why not?
>> Do we need any capability to control bpf_get_[ns_]current_pid_tgid()?
>> nothing or CAP_BPF or CAP_PERFMON? In my opinion, pid/tgid
>> is available to user space and there is no leaking kernel private
>> data here, so bpf prog should be able to use it in all prog types.
>> I will wait for a few days. If no people object, I will incorporate
>> this in v2.
> Yeah. It's safe without extra cap-s.
> There is ns_match() inside. Nothing can leak.
> Let's just move it to base_func_proto.

Sounds good. Will move both helpers to base_func_proto.

