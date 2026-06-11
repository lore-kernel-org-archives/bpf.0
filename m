Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555D233954
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142028; cv=none; b=lPhflftrC061VHWWPvCMxDigIesoxWdMUrlk4Sz0wasvxayYO+aF5QvGWTDOt1v3OU1Ly0iGBEp53LqRFHhRFtEU1s1b3Lddu1vXCJLXCCT/B6I3xQNKkZrS7o0wQRkuRP+Q9P/JvKuMFvD9bLYVNMrUawPj2VWxLQNduaJZrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142028; c=relaxed/simple;
	bh=CNUoljYbzeXKKvcBmGRIE1LPgz1ctKa80nHHy9WK7p4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=mlxFY4Lpggdhjh2gavRB/9NLRAwKCmib7OEmw60hCjPy4LqgI35HfZZaINtI6Upl12Xqv5AQX3j4j5bOs4bNL1Ou3qxuXUMw1nV/QaAIVNNXJnL8t2pMhwU6iEBqPNU1hTFzsM4rBkObFJtdIeBfQNA8NxAii0JCc9Abucjkff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KcZVa/Xm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KcZVa/Xm"
Message-ID: <b2e6655c-14ad-4d71-aa42-ec15d2c71f8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781142024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCmj4A1uqQI3Be+iSDOnrPctRTz+a0+7IW/PtmYHLo8=;
	b=KcZVa/Xm+VlxLlLl9zmI43gn/BPUGT9S3Vh01x4HChqVnwi6lGfpaCtmYdor921K1t5GwC
	pfumWxTlqOKzLcODDRRA7KPpHd0NljewJ1Iq1TMgcSGLp6MNhC38QDTyg24GuO2EAiAFzL
	ogj1K/wH8+txc1QGO7WApX3pAYsZ+3w=
Date: Thu, 11 Jun 2026 09:40:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 0/4] bpf, skmsg: some fixes for skmsg
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
References: <20260611013547.247039-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260611013547.247039-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/11/26 9:35 AM, Jiayuan Chen wrote:
> All fixes are from previous patches sent by Weiming Shi and Zhang Cen,
> which have already been reviewed by me and John.
>
> https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.com/
> https://lore.kernel.org/bpf/20260424190310.1520555-2-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.com/

Note:

Because there were too many similar patches, I selected the earliest 
submitted patch and retained their credit.


> Weiming Shi (3):
>    bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
>    bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
>    bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data
>
> Zhang Cen (1):
>    bpf, sockmap: keep sk_msg copy state in sync
>
>   net/core/filter.c | 95 +++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 88 insertions(+), 7 deletions(-)
>
