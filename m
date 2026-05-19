Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9FC327C0D
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158761; cv=none; b=XDR+DswhxSNjN742l4wO8wKwtmoal5OdK4JfzFMYkW5bmXvMsi5vf5VMEq9YJOq3pETYjjMkIXQudlkCxdlo21ZbsCPYzZ1GU8mmwtkxkmM3lD55HJiz3beyQMCW7Y9bqDRC5wKUEVAROfOnFBYKPYUzeXjohfPIp3+tOhL/uZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158761; c=relaxed/simple;
	bh=92NybR2OyFgFMwFLDLpOZS+tu8JOIDRJBDOB5IJwnGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/FWSr2Bt3YuaZ+vzR327ExZvYEj2ffH2WWXXckxY1Y4aolGwRmI2pmjWskoZyaSNIU25uVmeSjWXf3Vfj0u2RdAxt+Tz5JAorghmBZEeG/iFmieES7IacuR6Lku/EwFuRncdWyFN2/e3NiUPHa30/iHz1ncQsEqXRDwcc9e0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dyS5dsBL; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dyS5dsBL"
Message-ID: <51259935-dc50-4a77-99ff-4b0dc8992b3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779158757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHbmIBC02BCR+H4DhynnSzevoRTO77Y3/7fIqNwMI4w=;
	b=dyS5dsBL4iJYJMOTSaCNWOyztmStsUyfYyblK68DBr3evJATjSW3wCycG6fXOdfhFLVSal
	ee81rNhpi31WC/eKcBsBcMwK57Q74ErGRsFRXGcoLDI0uN8/8MY+V3ikrtC4oDV1d5Eq9A
	JkT/W4FluZXG0MI4j3l1cDkai7kjpLQ=
Date: Tue, 19 May 2026 10:45:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/5] bpf: Check tail zero of bpf_common_attr
 using offsetofend
Content-Language: en-US
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260518145446.6794-1-leon.hwang@linux.dev>
 <20260518145446.6794-2-leon.hwang@linux.dev>
 <e86e1075-f62c-4167-86df-158841952940@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <e86e1075-f62c-4167-86df-158841952940@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/5/26 00:14, Mykyta Yatsenko wrote:
> 
> 
> On 5/18/26 3:54 PM, Leon Hwang wrote:
[...]
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 6600e126fbfb..83de8fb9b9aa 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -6278,7 +6278,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>>  
>>  	memset(&attr_common, 0, sizeof(attr_common));
>>  	if (cmd & BPF_COMMON_ATTRS) {
>> -		err = bpf_check_uarg_tail_zero(uattr_common, sizeof(attr_common), size_common);
>> +		err = bpf_check_uarg_tail_zero(uattr_common,
>> +					       offsetofend(struct bpf_common_attr, log_true_size),
>> +					       size_common);
> 
> The change looks correct.
> 
> It looks like similar behavior exists in 2 other places of this file:
> bpf_map_get_info_by_fd()
> bpf_prog_get_info_by_fd()
> 

Verify by 'pahole -C bpf_map_info/bpf_prog_info'.

Yes, there are 4 bytes padding at the end of these two structs.

> Does it make sense to fix those too, just to make sure agents follow the
> pattern correctly next time?
> 

Will post separate patches to fix them.

Thanks,
Leon

