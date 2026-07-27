Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18D2931DB
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130071; cv=none; b=eFwMyQ5y8FacEgK6026iRp8mQN2ABnBgYiai+dqlsVQ+N9nvt8CG50bf2DWaa3jIzjUYMQHB//2K8p83fO22h9EYEKQODwHvWqabpGhwM0GdMUhV7ODhb8URKEJbA+IazMJ5+E2bZ9AhaCLWBGOK2wp9KmK8GpKp5Rlyx1dddAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130071; c=relaxed/simple;
	bh=0/7GcxJOOijC3oXm4aTH9Zz2aWv+8JdOmc1+DQYGcSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KatLrVyccbvH6hGPq+nPC6VCXCodCcJ2fwS0/VyjDlJYAEDKTemq9mFS96MJfkj94GxySfMMIDIwGLFWXXKQZixqOKSx5TPFS//6MbgNYE8eTUAxgGTylMrwP0sNIsKu6fZTpnXi59s85FDx/vFW18kvGoAlWSRVfCumoIEWiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vAcGVkOA; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vAcGVkOA"
Message-ID: <de8b0e10-ed86-41f7-98fe-9818df89c4b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785130066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPHxesfISLckDVAL3+MlqpBEdxWMTPPVKYBVVV6OlJk=;
	b=vAcGVkOAKmFc9HaKLcxXYrGiIaGI8CYBYqE6NbJLXSA9MxYzWqfqGo+3+Essqc5gBD0MgB
	72HIuNUZNTTPwpXdXiKHO5b2LZhOBfmNk223Sg41Ue2lb3WDwBkuPDBTvRfRen/ZhFRqek
	oUSBTOMGidvTv446SZYG9Mc7GH29+sc=
Date: Mon, 27 Jul 2026 13:27:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Log error code on trampoline unlink
 failure
To: xu.xin16@zte.com.cn
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260727103158658fTr4mVbmUdVPeIguhCrHf@zte.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260727103158658fTr4mVbmUdVPeIguhCrHf@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/7/26 10:31, xu.xin16@zte.com.cn wrote:
[...]
>>>
>>
>> Would it be better to include this multi_detach() one?
>>
>>         WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
>>                     NULL, &trampoline_multi_ops, data));
>>
> 
> Sure, what about moving WARNing into __bpf_trampoline_unlink_prog and then the failures of
> __bpf_trampoline_unlink_prog everywhere will be logged.

No. I think it's callers' responsibility to log warning.

Thanks,
Leon

