Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB324A06D
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763408; cv=none; b=I05k4stSqeh0JMxPU9uU+ljI39VZ4zkOQSloz7uzbHy7ogqOjVdsZtS6/t7ty0z6aof+yF4eTk5nIzue5sKjSxA8duR6u9rbK1f6E0wEjrjPULESapA9K6EyvUaYiRDJ43ga/ZpOPWVgxSybsNd5MUTI47ahNn559piu3Pz10f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763408; c=relaxed/simple;
	bh=hW8k1M3eYBQLaugbkpRIdd2q5RoaUrCDbPsxCn1C0H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdWWeNTF4TCocSFCJS+U/qz69mVhzFsJS71kL868cIbyGzQrpNam92QXx7k/3LeKgDJK1/Gcluk0FUUv2K7XKniZPGEdvQwdBHlFGSwjXJRRskfsNwQycx4bUyhDAQ0p0Fb0lPl2c1+LwvxQsHiQsAgVFkf6avb909wqsGv+sV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U33+bEHU; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U33+bEHU"
Message-ID: <e7316548-8f90-4569-8ef9-e7a14a5ccd16@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772763405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dsJFvz8c8+NiwptLCraMsGHt0DyLIi8uXR/x+VyrhI=;
	b=U33+bEHURKSP9p00OLya3jFvvtH9xRFJnQIbZZvEl3JmRCprSg1h0BmWGTA1/H8fNfn6t+
	mjR3AbtHZXFgYPo9pA2tTe4nIHVMqxYBNw4bEtXesGzmEzyB6Vn6tYcseemSoroAIYyzVM
	3i9aIHCl8OJaDrlFjQL/qQzLqwyOvfU=
Date: Fri, 6 Mar 2026 10:16:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/3] Always allow sleepable and fmod_ret programs
 on syscalls
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1772721009.git.vmalik@redhat.com>
 <f93e9762-fa64-481a-8537-12f6af95abf6@linux.dev>
 <CAP01T77dvSCyGq4L6XFS3uMeB7dTwCRvbePL-mnbEHDU7xvm=A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAP01T77dvSCyGq4L6XFS3uMeB7dTwCRvbePL-mnbEHDU7xvm=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/3/26 10:14, Kumar Kartikeya Dwivedi wrote:
> On Fri, 6 Mar 2026 at 03:04, Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Hi Viktor,
>>
>> On 5/3/26 23:25, Viktor Malik wrote:
>>> Both sleepable and fmod_ret programs are only allowed on selected
>>> functions. For convenience, the error injection list was originally
>>> used.
>>>
>>> When error injection is disabled, that list is empty and sleepable
>>> tracing programs, as well as fmod_ret programs, are effectively
>>> unavailable.
>>>
>>> This patch series addresses the issue by at least enabling sleepable and
>>> fmod_ret programs on syscalls, if error injection is disabled.
>>>
>>
>> Could you please explain more about the purpose in cover letter?
>>
>> I'm curious about enabling fmod_ret programs on syscalls, as they are
>> able to modify the retval of syscalls.
> 
> It was already discussed at length here:
> https://lore.kernel.org/bpf/CAADnVQJ4PU7bCb5XO9+zMZhLRSdbCKwxG6Rtojh2Rc3UZ8H43Q@mail.gmail.com/
> 

Thanks for pointing this out.

Thanks,
Leon

> I think the next version could include a link to the previous thread
> in the cover letter for posterity.
> 
>>
>> Thanks,
>> Leon
>>
>>> Viktor Malik (3):
>>>   bpf: Always allow sleepable programs on syscalls
>>>   bpf: Always allow fmod_ret programs on syscalls
>>>   selftests/bpf: Move sleepable refcounted_kptr tests to syscalls
>>>
>>>  kernel/bpf/verifier.c                         | 79 +++++++++++++++----
>>>  .../selftests/bpf/progs/refcounted_kptr.c     |  4 +-
>>>  .../bpf/progs/refcounted_kptr_fail.c          |  2 +-
>>>  3 files changed, 68 insertions(+), 17 deletions(-)
>>>
>>
>>

