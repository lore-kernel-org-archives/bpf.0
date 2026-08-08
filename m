Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB7415F14
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193277; cv=none; b=M26RnLaMakTk/c1S2ChN2l+gnsEuT2kSjMDU8vRw5nrILUvjekmpdGRZPfQW11PYit/g0kbvYfuJnSpTcO76N2KFHGw4DQdGRcEfJxEaUk/vopo2XFQ1wxkKT3KyQdLlMkmQEqTfzz/3Cmzzq7GVqjy+NJ6W+8BDBpsw0f7//LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193277; c=relaxed/simple;
	bh=qb73j1244SUuLMU6IxWAzM/p8hHM4ve7XQUcq+mCTVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h42lmpaq0YvC6+D/6TDDWhtUpTEyyxwn9DmcBKEGx6LwtjqOAga7vlCJoFnhJQq7mODuI4qOxm0mMpTb/HDJZC80j/PdSDsSCMuJnPngi3oRt3peyjlJNIu/yuD66bp7daaRaMHiW6zHxZA1+FEE/lMPdrjc6bSGiUJCO0PvLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KGEG1ie5; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KGEG1ie5"
Message-ID: <5dcc8d71-11bf-40cd-9cca-e47187954a61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786193239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qb73j1244SUuLMU6IxWAzM/p8hHM4ve7XQUcq+mCTVo=;
	b=KGEG1ie53B4HmFbCA8+FqlmMeKfUV7ylFmFf22c7efSKy2nGZ5PNrtuqLdhLhORPjayLgB
	+DmT0p8c1TR+MJhQWMLQEGB7lSZYeyneYUMww2vWHJ7yVhjv9aZzipDbePkDuCTnvz+4qR
	0vsycRrg6YNl0LGUKkKIOfXk7UHhLcs=
Date: Sat, 8 Aug 2026 20:46:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/5] net: Add connect_socket() helper
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
 liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
 ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-2-mahe.tardy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260807171532.125149-2-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/8/26 1:15 AM, Mahe Tardy wrote:
> Add a helper that connects an existing socket while invoking the LSM
> hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> logic. Other socket operations have equivalent helpers that trigger the
> appropriate LSM hooks that can be reused, this one was the only one
> missing.
>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


