Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D423E33D
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770011667; cv=none; b=KrMc/evtEr3c93ekHatj0cZr347JCd6nVObmPU2/bfp7tiEu65xRBfDy3jRSdJ0SGTt4uzLd7DL/EBIhtCE3mIzlQTnmjgn+y1xYcpjVbwWdyUf4B3Ivd+tWQe+2+415llQKfWgozzPLNMb+HOSTVRhmnDbZ/PnfbMymF2SYxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770011667; c=relaxed/simple;
	bh=lywCEDPlyt3OiiQXvf51QMlsZ5pzc1imtu/yowAFg8o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G4HArUP1BVIQm5s6NhQ4W7HHxr++o9oa7nmRRzm9AZrTPSTPTEwbs5ErK+XHCFYMq7nHr3lh5Gw3pOZOnLK4Qz7jR7Fijl/7fgyD0kADbKi9d6xnFiNnR1jcrMgT/ev/0caldUj60JxCDO2JgaRb149CMRLB7mlAyw44drbXAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lOa+etln; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lOa+etln"
Message-ID: <fc05dd15-7119-4db7-9ddf-270bd9b838c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770011663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Puxak2G+sBfL8q+PoNUkwncDertRMCGcIIZgmn1JsYo=;
	b=lOa+etlnIqi57X6jQidrane+sY2vEBUct3hUX9jhq/pDN7i9y9CBmfGpuMRoviBZrnK8jj
	NYxK4nwYjGYDuqFfozx45SODW/+fzOAe0fRyHOd5ut4eMbLhhTiD9PSxZ22Yx4eM+JGRv9
	zW5JnF8thNlnZh8Hsjqe7M1ceGoOtz4=
Date: Mon, 2 Feb 2026 13:54:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Disallow BPF_F_LOCK with mixed
 special fields and centralize flag checks
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260123055658.372869-1-leon.hwang@linux.dev>
 <20260123055658.372869-2-leon.hwang@linux.dev>
 <CAP01T77UY=FjNg9RDFQP8UYsS67gJBEsJjZBobu=Dh-fHG-+Yw@mail.gmail.com>
 <2a351923-5918-4735-8072-f21379e598c4@linux.dev>
In-Reply-To: <2a351923-5918-4735-8072-f21379e598c4@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 28/1/26 23:22, Leon Hwang wrote:
> 
> 
> On 2026/1/28 10:27, Kumar Kartikeya Dwivedi wrote:
>> On Fri, 23 Jan 2026 at 06:58, Leon Hwang <leon.hwang@linux.dev> wrote:
>>>
>>> Disallow combining BPF_F_LOCK with map values that contain special BTF
>>> fields other than bpf_spin_lock (e.g. kptr or uptr). Such mixing may lead
>>> to subtle or undefined behavior in map value handling. Reject these
>>> combinations early by returning -EOPNOTSUPP.
>>
>> The commit log is really suboptimal in giving context on why you're doing this.
>> You should summarize the discussion from [0], otherwise unless people
>> go dig that thread they'd have no clue.
>>
>> Also, I would remove the 'undefined behavior' wording. It's just
>> semantically different, in that the update doesn't free fields,
>> but there's no undefined behavior.
>>
>>   [0]: https://lore.kernel.org/bpf/CAADnVQLib8ebe8cmGRj98YZiArendX8u=dSKNUrUFz6NGq7LRg@mail.gmail.com
>>

Hi Martin,

Do you recall the original reasoning for disallowing BPF_F_LOCK together
with BPF_UPTR in 'bpf_task_storage.c::bpf_pid_task_storage_update_elem()'?

I didn’t find an explicit explanation in the commit message of
ba512b00e5ef (“bpf: Add uptr support in the map_value of the task local
storage”), and I’m trying to better understand the underlying concern.

This is in the context of addressing Alexei’s comment in the linked
discussion: I’d like to clearly articulate the risks of mixing
BPF_F_LOCK with other special fields, rather than relying on vague
phrasing.

Thanks,
Leon

