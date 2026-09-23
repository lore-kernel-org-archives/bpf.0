Received: from mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2ED41F5D7
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186971; cv=none; b=ckhZ4OApuzSRTGsiEeGvLWsZ3ZOiEfFfsUOKarIcpxiCBytgjtwGYepF7Gts/1/Jydk7sf0D+nk/OzNPc5EtOPGvsskO0CZPuZL7g1CGT+9o72JxpADuKH+nyslLRtG3QkxnoIKj/C8ivmYjEKFoASavOCjyLjk385+2JQaGNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186971; c=relaxed/simple;
	bh=2OSwAATVuMCSkiCTvVkrFXgtQXDm39p0VcxTLm/GZ+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZznT9dmb7O9O6z0AthhpXAUpbwWx2Zb84U4UMsG9+zza59QtfzU8IVBW3Z2/TQrmyzyl1WT9cNqxmfvv0QKPCUubIyyvQn2PQRkKVuw4n3lkCP0a7AZ+O1x5ozI6zaUcwIzO6EIqZ6p8aIbu7piqEuNsTuL5QYX3Ldbt9JDRnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gUONVBC8; arc=none smtp.client-ip=95.215.58.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gUONVBC8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2OSwAATVuMCSkiCTvVkrFXgtQXDm39p0VcxTLm/GZ+4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790186968; v=1; x=1790791768;
 b=gUONVBC8ahJOvHbWxJKHIyIVhLaNhT2f7po7sn03rIyTQyDhq+ke4NyCqh9oK3leyK2+V8l6
 Q20gFLPOwHY1CTScnUcyx1i5FimZ6YfyzeFtT3ooikE3QZg+lFXCHWJEYkfHTCf+YLg3sS2Qx/j
 SMEB7xFcXccwfowiAJvn3NOQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c87db9c4947cdb24;
	Wed, 23 Sep 2026 18:09:28 +0000
X-Mizu-Trace-ID: c87db9c4947cdb24
X-Migadu-Flow: FLOW_OUT
Message-ID: <981c9440-2fb8-4236-9d6e-759f9f2bbbaa@linux.dev>
Date: Wed, 23 Sep 2026 11:09:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045922.2417689-1-yonghong.song@linux.dev>
 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
 <3469ede8-6c37-49c9-b261-d2c8506eada5@linux.dev>
 <0c312ad4f725193e714a50c5fcfc31ad2b273f7d.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0c312ad4f725193e714a50c5fcfc31ad2b273f7d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/23/26 11:06 AM, Eduard Zingerman wrote:
> On Wed, 2026-09-23 at 10:27 -0700, Yonghong Song wrote:
>
> ...
>
>> This patch is to avoid a verification failure. Let us say, we remove this
>> patch and run the following
>>     ./test_progs -t exceptions_cleanup
>> and we will get the following failure:
> ...
>
>> This patch intends to explore *unreachable* insns to avoid verification failure.
>>
>> I think due to "record = { begin = 1, end = 2, pad = 4 }", it is considered that the code at 'pad = 4'
>> is not dead, but actually it does dead later so we have the above failure.
>>
>> So I add this patch to avoid failure. But maybe we should just remove this patch,
>> and mark this test as failure as indeed landing pad is not reachable.
>>
>> WDYT?
> But that's a self-fulfilling thing, the test you are pointing at looks
> as follows:
>
>   /*
>    * 15. A region around a call the kernel knows cannot unwind: no call site is
>    * marked, nothing reaches the pad, and the sweep removes it. The program is
>    * otherwise ordinary and has to load.
>    */
>   static __used __naked __noinline __u64 nounwind_rec_frame(void)
>   {
>           ...
>   }
>
> So, the test is added to test this cfg pass, the cfg pass is added to
> make this test pass, meanwhile compiler does not generate such code.
> I don't see a point, tbh.

Confirmed. Will remove this patch.

