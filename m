Received: from mta1.migadu.com (out-230.mta1.migadu.com [95.215.58.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89D483BEA
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637905; cv=none; b=euSjIlcTCrl0xACxjyhiLloYbI7rgcVSow1uKqAo7DvnqHGXImA9PUxbrd++ykC+0H85XuvD/cFBY8LV/KTCoSEhjecUxSQRMooWNw0FwCUGb3R7YRpkMt17wBz+yhXsGRcJIkm4wNc8cWKDGX428eTYhTr9102lNcYv7HXUtck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637905; c=relaxed/simple;
	bh=gM3TFE//hvikjKMj/TFefs2iWN3yDc9jeflEfY8CKyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3HNYV23A5Hup8tYIGk7ceOll6RTK+BxCBnVyEEp6Ad3eyBEtTHd1qsDq4vgJsHWwgtKp0hIXVxQ3u5lC5UstNPbpcBYWDmL0yD/KD3EQE0DI9h8Xha2lAl40riaalvbEyrifnRdr8nz6DX+esl52YGIQETwgMWRt64rxTHbdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uezdezav; arc=none smtp.client-ip=95.215.58.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uezdezav"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gM3TFE//hvikjKMj/TFefs2iWN3yDc9jeflEfY8CKyQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786637898; v=1; x=1787242698;
 b=UezdezavBi4rv91aReDDVYdmd57PD3l6D83Bl8Jb58y6YQ+dKiPKnxRjooxN3VHgu3zg4F5u
 2VQI+6NAbVa+znSU5qojnLWaNQHJiNqo6+X5kbxtfk4jFrtFAEfAolz3ECHnhUsaD39zVpVUkts
 OxoD8rc6z75ywMmibBJXszOw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21e8::13e6] (2620:10d:c090:400::5:fb16)
	by smtp.migadu.com with ESMTPS id 4d9e2575af9622e6;
	Thu, 13 Aug 2026 16:18:08 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <ccb6879a-b568-4bc1-b7ec-bb3196135d73@linux.dev>
Date: Thu, 13 Aug 2026 09:17:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/2] selftests/bpf: keep polling connection that is
 still in progress
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
 <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
 <75ec8417-4be5-4e7a-86c9-70a83b793580@linux.dev>
 <DKM96LSV880C.1QEALTH06N0GI@bootlin.com>
 <d92da576-4930-4b10-b8bd-ea1158ec08bc@linux.dev>
 <DKNN0WMD9XW8.MCJAMGS5NPYR@bootlin.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DKNN0WMD9XW8.MCJAMGS5NPYR@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-08-13 12:29 a.m., Alexis Lothoré wrote:
> Hi Ihor,
> thanks for the extensive investigation
> 
> On Wed Aug 12, 2026 at 8:46 PM CEST, Ihor Solodrai wrote:
>> On 8/11/26 9:25 AM, Alexis Lothoré wrote:
>>> On Tue Aug 11, 2026 at 5:05 PM CEST, Jiayuan Chen wrote:
>>>>
>>>> On 8/11/26 10:26 PM, Alexis Lothoré (eBPF Foundation) wrote:
> 
> [...]
> 
> 
>> An entirely different alternative that Eduard brought up in an
>> off-list discussion, is to drop all the timeout machinery from
>> network_helpers.c altogether, and rely solely on the test_progs
>> watchdog to kill the subtest processes: d9d4d127e813 ("selftests/bpf:
>> watchdog timer for test_progs")
>>
>> I am not convinced it's a good idea, because I don't know what will
>> happen with all the tc_* tests if there is no connection timeouts. If
>> you're interested, you could try it and see.
> 
> Hmmm, I'm not very familiar with this mechanism, but aside from the
> potential issues you are mentioning, wouldn't it make us loose a bit of
> info here, when the watchdog kicks the runner out ? We may know from the
> stacktrace that the subtest was in connect(), but we would loose any
> formal error/errno on connection timeout I guess, and I am not sure how
> confident we can get about any watchdog kick being a connect timeout.

That's a good point. The watchdog is the killer of last resort,
we should report proper errors whenever possible, I agree.

> 
>>> That potentially brings back part of the issues he has been mentioning
>>> with selftests duration possibly increasing by a non negligeable amount,
>>> but maybe 1s is a better compromise, compared to my initial 3s proposal
>>> ?
>>>
> 
> 
> 
> 

