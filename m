Received: from mta1.migadu.com (out-66.mta1.migadu.com [95.215.58.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421C7E792
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681163; cv=none; b=JAFONpFJfk1nph5QN6poFi+EkM8E0G+m5lfvAKfvKix3E72k/W5NaKfvZcla2RFOJR/c473v7cg6FkkXe/qmD3/s2LG2vvbQsKNpQ0rHeGunn4YX9B4fNa5e/vJzaMG65nV5bynYyLtyCJQLnbPvqFDXmR9lz7QajDGlxVLS/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681163; c=relaxed/simple;
	bh=PWTd6nbJVXaCT9i/7lgHburJ3nsC5QC91t07UUeLu2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ci5rBP/G7bWoK+wpjIrHUirViLU5YFF6aDuzXZLLQPZxyPRxBZpDW7pyJbmCOf1df0pwj49ITLE3quNYIJHsKCreq+anyXlAGC3Yg3u6VlPLPOH0TAxgstRBQq1/afGEdlin3Z7CgzghzsjGyCfmTT76/BgcBONGrLFwfvKiXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fh5ZsFkj; arc=none smtp.client-ip=95.215.58.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fh5ZsFkj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PWTd6nbJVXaCT9i/7lgHburJ3nsC5QC91t07UUeLu2E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786681159; v=1; x=1787285959;
 b=Fh5ZsFkjANu5ro3H31wiUlkAV/UBI/hWAlwF0Sv2wCHMwZXam9gH6Sgavtyqjjs4Vfw2RCRh
 Oj9WGaIfHOUT3Q6mzcm9tWVKCo2HIPGUaCRGvfggPzUlnm4OAvitLiuUlpt98ZXXt3bN7zPr9hb
 /teh9BHg++fclGAWhkR7gxFU=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:8612:2bc7:48f:e0cb:d896:8a1b] (2600:382:8612:2bc7:48f:e0cb:d896:8a1b)
	by smtp.migadu.com with ESMTPS id 40e941041e0ea910;
	Fri, 14 Aug 2026 04:19:19 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <42509a3a-6019-4362-a2dd-795eaaf4aeef@linux.dev>
Date: Thu, 13 Aug 2026 21:19:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftest/bpf: make pyperf600 a success again
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com
References: <20260813232943.581283-1-andrii@kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260813232943.581283-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/26 4:29 PM, Andrii Nakryiko wrote:
> pyperf600 has been running into 8K BPF_COMPLEXITY_LIMIT_JMP_SEQ limitations
> for a long while now, after some internal compiler changes.
>
> Until BPF verifier is bestowed with scalar evolution logic, make that test
> actually work by doing what would anyone should do in such situations: by
> moving repeatable per-iteration work into independently verified global
> functions.
>
> `void *` argument is a problem for global funcs, but a static function wrapper
> doing necessary casts and a bit of __arg_nonnull magic dust is all it takes.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

  Acked-by: Yonghong Song <yonghong.song@linux.dev>


