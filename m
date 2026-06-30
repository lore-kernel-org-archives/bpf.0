Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EF2882B7
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785670; cv=none; b=UjzKzBwOyDdhk+tOo8g+6EK3Z60Gy2g0n8OEwE+NxtljvAfxNP5ZxH9zNdmnjTuzDulD2j6DhrqmDfEdbW7xDZ4kO+TJDbhzZx5y2hbW1/hIXX8ZoVOcoTbFzs5akTVNRgfcgOMzmWDxcm1Y14HOxOqLnCMAnkxblpy3UX9ykWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785670; c=relaxed/simple;
	bh=FQzy4cAfERQWKiFWqRGsLShXKr3V3U1l/gdATRjlQfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cf+VWPHtL9zvFrG0Gkg05OjkrKBDIdSdYPJILRCfcQKOrlodXRm4TlCW04zer2KRtLnLgbOU6xxJ9Wm2/rWUN7ug0nOO+keL5RhwWyZsLq92BTqj6T/nVMGi4yspz21XCOjz/z0LBZXNJ7HxxwKv1ZG/y0UWv5HlOM0Jcn3wJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KxvJ+REr; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KxvJ+REr"
Message-ID: <1f10e056-744e-45bf-af93-6192668be79c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782785666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpOKK/yk1zJCi69ZRKcl4qzI64WcdOOVWQyvaUeEG5M=;
	b=KxvJ+RErUVdsIcTzHUauiPGpgFaJYeNeeljI4FYbDkJ5uyMper9cKs25ngrLuVHQ0N5sxD
	DRbkYqTsbMLLxUQYQWJ1uih8UO3xMqZL+aaEjtqMNM1afh0MhS6djvWkjlJuzrVk5JeWFj
	GU4C0N4xuR6VGNPH3jEH/aL0beJfRFM=
Date: Tue, 30 Jun 2026 10:14:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
 Rong Tao <rongtao@cestc.cn>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <855e44f3-d22c-47e5-8bd1-c5d9f7014a75@linux.dev>
 <ec28f0f9-0693-4c9b-88fa-bffca446a63c@huaweicloud.com>
 <b8d8ab5e-bef1-4c95-8e5b-ea9768041b2e@linux.dev>
 <55499fcf-d552-4366-9016-21ede7f687ac@huaweicloud.com>
 <4f30012f-778b-4c7d-b610-2e18cf01abdd@linux.dev>
 <678ec73d-06f1-4860-94be-be000ca462d4@huaweicloud.com>
 <b4b906cb-e7b2-4ba7-bbb9-e6c813238859@linux.dev>
 <8ea18b6a-932c-4eb0-a536-d52ce3e1f457@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <8ea18b6a-932c-4eb0-a536-d52ce3e1f457@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/6/26 09:19, Xu Kuohai wrote:
> On 6/29/2026 9:53 PM, Leon Hwang wrote:
> 
> So it is more of a user-space workaround than a formal solution. And even
> for this workaround, there is no need to add a new libbpf API to remove the
> stub. You can simply build two versions of bpf prog, one with subprog and
> one without. When you need to trace fentry, load the first one; otherwise,
> load the second one.

Yep.

> 
> What SDT resolves is dynamic tracing after the prog is loaded, the hacking
> before loading does not apply.
> 
I think current implementation is too complicated to justify this kind
of workaround. I'd be more comfortable with a simpler approach.

Thanks,
Leon

