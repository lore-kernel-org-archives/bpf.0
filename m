Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50032E148
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079861; cv=none; b=CB6CJGM3rsu4jtRdaj2NN/HlfvTw+kNwxaRQkb9OQTMoWO5PUAkZB8w7m6CqwvCVq5uumV/QTwVxOcZrOgkSVg6qwcnEtdiGbiu60ZgzIh14I4h+IUlyPJt0nRCJ7X5QCbf60rg2TANub+2Fca0aHKHe6qFGl9p1Nk/3boQOhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079861; c=relaxed/simple;
	bh=xt56qqVKflx0fkQNFe7QVUab7luc9R4I5ANbQASr0Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juUx01wxS0ShVRXWdqo+dXH0JOw9PVhirHKfuRLmNHgMbjphhDbta7GiQSZh1aeWDy0ZxCi5FOiHlXJcxOIJ70paBhHaOi1ocAYPh785txUwRWcaMt24CzU00IGCCYvFWIW2yRgwEKXZNCB137lYi5Ls3IbmPzW99YnrPxb/l1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MeIIEoUC; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MeIIEoUC"
Message-ID: <5c57bea2-a9ff-438d-a256-954e291670af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766079850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xt56qqVKflx0fkQNFe7QVUab7luc9R4I5ANbQASr0Zo=;
	b=MeIIEoUCzE0vOcFWsVGwzLoy/FfD8bnMvMjUqrxMJhnq7qhbhnc3KtQmcdjyGSO2rpuY92
	/Gyi+feLkh4TBpG6Aa2sDOsRI7vupNvfQRY/hB12l3jw2ZR6nRoh4Jtl4Nq6Z9PF9paWM+
	o/Htomy3/Roo4lB2MCplGTxg2p02WOM=
Date: Thu, 18 Dec 2025 09:44:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: move recursion detection logic to
 helpers
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20251217233608.2374187-1-puranjay@kernel.org>
 <20251217233608.2374187-2-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251217233608.2374187-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/17/25 3:35 PM, Puranjay Mohan wrote:
> BPF programs detect recursion by doing atomic inc/dec on a per-cpu
> active counter from the trampoline. Create two helpers for operations on
> this active counter, this makes it easy to changes the recursion
> detection logic in future.
>
> This change makes no functional changes.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

