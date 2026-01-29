Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC402441B8
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703202; cv=none; b=Qcdl74U4G309a/DNIU2EKcNtMJ4T2+B8QWPgOulUQdWaYuS+IcGA2MJyvVovYic7Q2Zyywj3IgOjfbC3uuGQw+b7V+DVFL5o4Vy8N+JRz+dVR7TcQFPcd0ImAZ7qv/60ElZHeVgdpaneXKoN2NzfggN245eUvyY8/toyp81BRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703202; c=relaxed/simple;
	bh=DRV1WZvJCZzH1WQi2fG8bNqCkOgISzIgTk5MqLN46JM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jzTjoTHKejJczk1YqxM5TVd9RTtat0qJ+PsRCnKjkGJqxTWDQQBqbvQwL4T1t/Dez+M62IxY5Rb88bWNaeOtJxzThqq/t74ObmxhYxBxRFOMQBJ5zdWfS0BkE3xIgw3xLr6mM6lGBK13H/FW8INrTr8SlfvNSDlgINCJVJS1aVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GHiZiIf+; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GHiZiIf+"
Message-ID: <769c580e-66cf-420d-a27e-f38b11abfde6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769703188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80HkidXIQaDEXINtp7tf3iYZacuhAbVDQJBFXriJFC0=;
	b=GHiZiIf+7/63a30C6bjtpXrkYizrML9OhoJB0LOKOY0dzysyb1U2W/Bb5hWvTxfu28tm93
	UbOAOyV5nae0pft1Et7wtYDn8+lSbogneXvQ2d2WI9PUi9VsGrEyBpP6Grw/IoVvis083W
	1dF5FhI5twOyMqsRf8x/vFu44+icNic=
Date: Thu, 29 Jan 2026 08:13:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Return -1 from
 get_preempt_count() for unsupported architecture
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20260129050949.157410-1-skb99@linux.ibm.com>
 <9d845ebd-2d1f-4f98-9284-a1714676d33e@linux.dev>
In-Reply-To: <9d845ebd-2d1f-4f98-9284-a1714676d33e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/29/26 8:03 AM, Yonghong Song wrote:
>
>
> On 1/28/26 9:09 PM, Saket Kumar Bhaskar wrote:
>> Make get_preempt_count() to return -1 for unsupported
>> architectures instead of 0, so callers can distinguish not supported
>> from a valid preempt_count of 0.
>>
>> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>
> LGTM.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Dig through further. My above Ack is invalid due the following usage
e.g.
static inline int bpf_in_nmi(void)
{
         return get_preempt_count() & NMI_MASK;
}
in bpf_experimental.h. In such cases, returning -1 for get_preempt_count()
may cause bpf_in_nmi() to be true, but this is incorrect.


