Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084552F95
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778398; cv=none; b=nyP3zYLrq0CzFA5Q6LHLK5X5H4J5BKoJyFZCarS1jY6LHYuhy9G9nbfs5ZVTHHUAiRrgz+ob23nxTPJVPy8m1RSEYBAa7v/kzpMRAopiBXt5ps06j641bpUGwHXAlKfhtGUboOyFGcfCWg/CcY69BIVDNRo7ih6XcgA9TCfJmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778398; c=relaxed/simple;
	bh=M7JooqxhdWYea4plzORL0v2OMwlVA0hITUGPfyr/rxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAP3fK+t5fw1Z8iy9rVcc823pIDdTZkgD5z+ffwI3DH7iBcfi62Z0BHXdNWmF7MVe+WLGJwpgs74ozQLI5MhKyfFxzySHiJzmCQoAJ/ClIl2gltsdBvXIR9nXvcTVBpOeYJzEClBqiQRwyi7we+3ELBmVmt7OtiEZ2QklsWAlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W/LMiKkl; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W/LMiKkl"
Message-ID: <4bcdd9cc-6149-490e-b3df-a39346e5035b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710778394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7JooqxhdWYea4plzORL0v2OMwlVA0hITUGPfyr/rxw=;
	b=W/LMiKkl6A4zdyQuXXzHGTu6K+ix0qYxeckWn56Lr46JxVD++xmIb6GSHomV5XuUqBTnxN
	LOhg+TZiWK4q32Hpl4i2AcyLD09newzHoBR+5j9LENN/eoOiAZkWDEc6cbM9sdpw/86qeV
	iZYKYZuyFvzzKM8Rzo1HI380XLGGl/A=
Date: Mon, 18 Mar 2024 09:13:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
Content-Language: en-GB
To: Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org
Cc: Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <6a1d94f7-b4bf-4315-b862-4e278abbaa73@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6a1d94f7-b4bf-4315-b862-4e278abbaa73@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/17/24 11:52 PM, Hari Bathini wrote:
> Just checking on whether this will go via bpf or mm tree?

Sending to bpf-next should be okay.
Could you resubmit the patch as CONFIG_CRASH_DUMP probably not
available to bpf-next when you initially submitted the patch.

>
> On 09/02/24 6:05 pm, Hari Bathini wrote:
>> With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
>> to the below warning:
>>
>>    "WARN: resolve_btfids: unresolved symbol crash_kexec"
>>
>> Fix it by using the appropriate #ifdef.
>>
>> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>   kernel/bpf/helpers.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 4db1c658254c..e408d1115e26 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2545,7 +2545,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>>   __bpf_kfunc_end_defs();
>>     BTF_KFUNCS_START(generic_btf_ids)
>> -#ifdef CONFIG_KEXEC_CORE
>> +#ifdef CONFIG_CRASH_DUMP
>>   BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>>   #endif
>>   BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>
