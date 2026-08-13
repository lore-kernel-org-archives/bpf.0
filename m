Received: from mta1.migadu.com (out-128.mta1.migadu.com [95.215.58.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6C3B9DB6
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645450; cv=none; b=ZMWixJg8g8etcMawGTNbf82paI0bwsY4FJMxvcKFJupO0y0q7BX9ul4mQymV6jHImojXT/3vefhHgGDxQ9Gvy3JCvOTZIGrXiblAA+JzM6xzeuzMupp1YUUfzhqmWPNeoJl5BMJ2h7o6ec91CWgts/4m5CRsPm80d2E0JjA5Evc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645450; c=relaxed/simple;
	bh=T7u6cls7hTVwvYMjrLC774Vk+oYLyDm5SpzhtfHpIUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWfNMOdBa9GU9hSErY1R1jfn/pbmJROO33EmiCVUOAtEBOz4kx1Mh8zVE6CxPQQHyx9L0l357vPgh7QC89CQIj1Mu3ISsTZxElJUgdRy08Sbn5br6dKp4ox3H2zuudqd21hKQ5j6GhwI06LxJtbDNzjabEXBOcMIKZ1WB0jveew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I3jB316e; arc=none smtp.client-ip=95.215.58.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I3jB316e"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T7u6cls7hTVwvYMjrLC774Vk+oYLyDm5SpzhtfHpIUA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786645446; v=1; x=1787250246;
 b=I3jB316eSl2yAw7tTUD13BKMahuOucgKVj6TMd5AxXAhFcJwN5cPTUe/UIdqatcq20+ryrJ7
 kelDU94GzWW3NSISKXAhuy1jjqiXzyx8UsThZJ9ug4XE6lLVwrSBftkPwUhicamWdkP2lPLXZuu
 DbBFmKl5gXnQ7X5ImNxVL9dM=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id fbef01275abb57c2;
	Thu, 13 Aug 2026 18:24:06 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <10dcb3f6-c2a4-4e74-9289-876d618096a6@linux.dev>
Date: Thu, 13 Aug 2026 11:24:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 10/13] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
 <20260811001002.2383554-1-yonghong.song@linux.dev>
 <ed7cb5e74fa401e9d2061c8a30baa8e6d1d64776.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ed7cb5e74fa401e9d2061c8a30baa8e6d1d64776.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/26 4:15 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-10 at 17:10 -0700, Yonghong Song wrote:
>
> ...
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests
> ...
>
>> +static void run_subtest(const char *name, struct bpf_program *prog, bool supported)
>> +{
>> +	if (!test__start_subtest(name))
>> +		return;
>> +
>> +	if (!supported) {
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	run_prog(prog);
>> +}
>> +
>> +static void test_int128_c(void)
> Can this set of runner functions be replaced with RUN_TEST() macro and
> __retval() annotations on the BPF side?

Will use RUN_TEST().

>
> ...

