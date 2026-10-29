Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268259;
	b=TTaphGGlDyi0nODL/xfWHMaxW0JE23nlFNf1vJ6YMSoGYlJFvnaoPUtxGTzFFL983KJm
	 Al2QMswxDMex89iXORAvi9sG6JV8lnbLXfIBH0or5qxf9XPn2m9emsMl2h65VHkUjw3bG
	 ndEjPH42VGLkpnZz4HqC3FsjK3QTDfMFjC8ZiDzTwq2/1iLsCZXtOG81zDUKtw8Na4opv
	 jTkwamxHFNmv24124HY606DUN39jzGB7nIupDD6W5u1/AVWWC9xhbDd5Ui2cxbG6OmXLc
	 /bUarBXErMZGkY19/5w0fTvDL2Sxqh83HwTgMGJaWi5Lzs/1YHfuT9RD2RALe+z42yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268259;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LB/73nfCAHiY8ms6QFBHreSDwl9iYXEvUDaC3DV6Zu0=;
	b=CWCq6DgZmWkJmp0RAEJuus61MkyAYxVXEuzPLwhAK5FdUSo2w6YXBH4I5wbp4u/zmCR4
	 0dSamyTnDtbEsWbc0ecwmCrTrQ9XhGEz2yLu1Dsenxj7JBze1TAxHZfey6BKwlrk+TIQs
	 Dhrt84Ce167Ksfs1hAeL2A9esvKngUKWh03fzJQzOALQhI/PVE2evFN3wgV3NJxSZ4eFu
	 Lg3rzeus6ZFMbSLuB5wbBm6kqq275g6+Cg2BTsBV8Lmsu7Y3RtqxgYJNMb4Q/JvyV+cy/
	 9lB1nJSzcNldJvb/UQOhgQ2ndqkamKHZDJQoivb4atC9MokJkYVK9zComnoik7eOeTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iPwGQoE7;
	arc=none smtp.remote-ip=91.218.175.231
Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4B606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 10:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E4B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iPwGQoE7
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BAYzLGPgGf5837fXM6g/DklP8VVuXY5OJdBGwkWAxDk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793268255; v=1; x=1793873055;
 b=iPwGQoE7VILxHpot2og/jzQBP5gy0zacBVQBG7TQcAJeU91hRwwlXKJBWLArlz01il9yURMu
 ShNwI2kcP+iD7BXhmsurw27sSws3zEEvsAVUeNmySH6yZ3906cNfPiFO+eeYj/JXGdOYYsci9C+
 NnyMaRHvJDfEWvm1bC2IZptM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9324b428c442bf0e;
	Thu, 29 Oct 2026 10:04:15 +0000
X-Mizu-Trace-ID: 9324b428c442bf0e
X-Migadu-Flow: FLOW_OUT
Message-ID: <d06638d4-72fd-4b35-9d78-a2e45856d83b@linux.dev>
Date: Thu, 29 Oct 2026 18:04:07 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, josef@toxicopanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 linux-kselftest@vger.kernel.org, cuitao@kylinos.cn, ameryhung@gmail.com,
 alexei.starovoitov@gmail.com
Subject: Re: [PATCH 1/5] blk-iocost: move shared definitions to blk-iocost.h
To: Tejun Heo <tj@kernel.org>
References: <20261028143534.135968-1-cui.tao@linux.dev>
 <20261028143534.135968-2-cui.tao@linux.dev>
 <3f51067b3d4d549e8414bc19bb612cb5@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <3f51067b3d4d549e8414bc19bb612cb5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Tejun,

在 2026/10/29 04:09, Tejun Heo 写道:
> Hello, Tao.
> 
> On Wed, Oct 28, 2026 at 10:35:30PM +0800, Tao Cui wrote:
>> -static struct blkcg_policy blkcg_policy_iocost;
>> -
>> -/* accessors and helpers */
>> -static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
> 
> This isn't a pure move. The comment is dropped here.
> 
>>  }
>>
>> -
>>  static int ioc_weight_show(struct seq_file *sf, void *v)
> 
> The blank line removal is unrelated to the move.
> 
>> +	bool				user_qos_params:1;
>> +	bool				user_cost_model:1;
>> +
>> +};
> 
> The blank line is new, and 2/5 then replaces it.
> 

Dropping patch 1 resolves all three: v12 folds the definitions back
into blk-iocost.c with the original comments and spacing intact, so
there is no move left to keep pure.

Sorry, I should have caught these before posting.

Thanks,
Tao

> Thanks.
> 
> --
> tejun

