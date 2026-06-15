Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E521ADC97
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781489773; cv=none; b=W/GhzHkDrd2m4YoBfd9I4/nKM60u14tm7893h/APAaJ8V2AMdDLgDz4CVA4DLxrUK6RtqVlT3Zq8CAMGkyz6uuGIjIklFs81oqhteyWD/nhSLrQXy5xeC7+EE7tUWWF5SPvf5K1AF/I1EKHMh8HC/C6oPX0hd0Dqrs2WGYqIOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781489773; c=relaxed/simple;
	bh=eINvWcmu7/ak5vC5LvLEObhfPjqLtcxutNLDwDi9a1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP8S/QH3wrGhszbSrb5+sa2cyZvhXqdfBu4xGVA8X+INJ0cTSx2PjP2xz9FaLbPIQ28JetBffpFpwJzWaJV8YDLCkqgBZjNe4FO0Y4wWC8nHtcxCVkYv0/N2BFmiUyyH5uyh3kXvb/ZQ8DFrbuBQNYWwxbCTx8cLBItuTRfiBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JtkNEjl4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JtkNEjl4"
Message-ID: <ac19b45f-9272-46f3-bd87-7249e22be338@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781489760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zC3DwuDuk987jph3z5y1dHndewPDOcnd5xS3RmqYk2s=;
	b=JtkNEjl4ddeP0lSv1fyLNMBjDOJVjiwla3AzIDZW8BjqDQ7xgRxHbxlpSnxWFyTh98VuL+
	LNBBXpeShDyb59Q7YKB0CPaKhnRTWHWXOdw5cewdpKgUjIQVkF6iM91Mq2JNuAYLLah+wp
	lfa1flvEDnvD4+tj+TBCsjuyJLuSjVo=
Date: Mon, 15 Jun 2026 10:15:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Fix unaligned interpreter panic on JIT
 fallback path
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260611101216.30153-1-yangtiezhu@loongson.cn>
 <093f957d-3d3a-4ce7-b59b-06203c556629@huaweicloud.com>
 <9c84609b-3b82-9a43-0f25-4ac632109819@loongson.cn>
 <f8d1b14f-e577-44bf-baf7-fe9da871889d@linux.dev>
 <ad046aad-c258-d121-41a2-7fa823b3cb02@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <ad046aad-c258-d121-41a2-7fa823b3cb02@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 15/6/26 10:05, Tiezhu Yang wrote:
> On 2026/6/15 上午9:49, Leon Hwang wrote:
>> On 15/6/26 09:23, Tiezhu Yang wrote:
[...]
>>
>> I think bpf_fixup_inline_helpers() is not accurate, since it is to fix
>> those non-inline helpers here. bpf_fixup_non_inline_helpers() is a
>> candidate. However, a shorter name is preferred.
> 
> I see your point. Indeed, we are fixing up the helpers that ultimately
> failed to be inlined on the fallback path.
> 
> How about shortening it to fixup_fallback_helpers()? Since it is a
> static function, we can safely drop the bpf_ prefix to keep it concise,
> clean, and accurate.If that looks good to you, I will use this name and
> remove the redundant check in the next version.
> 
bpf_fixup_fallback_helpers() or fixup_fallback_helpers() works for me.

Thanks,
Leon

