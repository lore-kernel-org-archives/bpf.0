Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27F3BED5D
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322771; cv=none; b=JyTvjJ90J2eCb38kIEludfl0ox8/lEgwAZ0P22+AdZ3QPS/pnC2lnMoBNuYlAh+8/eltJQBvNYUiCIMmagFSw3XSO1Nk0Mpr/Y9vSn5f9D+OTnjI6AudKLV8fw8UTHGq3k1ROx2Ulp7IGYcXdPfGvFMALItStmAEz4L7KWKnCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322771; c=relaxed/simple;
	bh=uCgy/4a3O45IKbt53bkbdtju6nVoH67NjrRZwRGOQKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlWtBq7r+IT6XfIIzzbas2jjPFeTuAq16elvDCNpoABDnUM2WOgGwlmLuXY/hbtIlaRh/iHPvbInZYqGLUv4zjTNrekYUKSWku7Idkf2AbbUy1ODrVwKCCMej5vE2bOZU/crIo77Q4Bv1L8P2GeaNy6iWDNMZUvYGqgLDKkLT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IkOjbUcC; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IkOjbUcC"
Message-ID: <14e9e301-38da-4800-a1a6-9913c8d3cbf9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773322757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMYxCY6UeSuDYqBhMw/GjMm6u1qYKBPdLAkA3zqj/aY=;
	b=IkOjbUcC2VEP4LSLMMoZOUZeVQuS5QXzTMHpO6lSR8shlxoVxt9sz6+li1zVGw22ifVZKG
	2hwPY0AvWefeYF1lFoDXA02IOu7sT2HB0bD8QruPmBC9AlSoGRUl9MZlc2+0TT5NNEAZwq
	rPxTrFnaNGpH51JUlmZIGsIc4se4H/o=
Date: Thu, 12 Mar 2026 21:39:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260303150639.85007-1-leon.hwang@linux.dev>
 <20260303150639.85007-4-leon.hwang@linux.dev> <abHwii5stH93Vz5E@krava>
 <931b490b-ab29-44fc-b888-8ac1ee8d8ccc@linux.dev> <abKZfhWs9Gojuvip@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <abKZfhWs9Gojuvip@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/3/12 18:46, Jiri Olsa wrote:
> On Thu, Mar 12, 2026 at 10:24:24AM +0800, Leon Hwang wrote:
>> On 12/3/26 06:45, Jiri Olsa wrote:
[...]
>>
>> Actually, without this patch, when "bpf_fentry_test1" runs, the arg "a"
>> will be updated as 0. Thus, bpf_prog_test_run_tracing() returns -EFAULT
>> instead of 0.
>>
>> bpf_prog_test_run_tracing()
>> |-->bpf_fentry_test1()
>>     |-->dummy_kprobe()
>>         |-->kprobe() /* via tail call */
>>             |-->regs->di = 0;
>>     return 1; /* instead of 2 */
>> return -EFAULT;
>>
>> Yep, the commit log is not clear to describe this abuse problem. Will
>> update it.
> 
> ah right :-\ ok, I think we need to do the suggested one way check and
> that should prevent kprobes having writeable ctx
> 

Yeah, will apply strict both-ways check. See
https://lore.kernel.org/bpf/8a3c7f14-b3d1-4208-acbd-76e5db6c5320@linux.dev/.

Thanks,
Leon

