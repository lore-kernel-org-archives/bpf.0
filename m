Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90B3E63AB
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253200; cv=none; b=l1/1SfsePWkLWL5b3x6pPTMSfzYFwxyMyRx37lDthtamd9DAZFwlI3C1+F0EH4VlOBx8JW5o0qEGrt8bHBRKfns+SDYEmLdLZOcUNzMAOIdZQihUxwsmllSFRSVRPmae6gkZUQD+bb9jx8k1w15dJGd9rMk3LtZpmjUgPuKMnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253200; c=relaxed/simple;
	bh=wMsLXN2pdJ5CGkBzG7OFwRUc+pDGe9pNcT2vinhjEbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7DFzir+1jmbEFspgaBIFEWUCfVg911s8A86fsv9dcR+XZeVpG3/txXDxzxx0XrfQ2vW0/KEihuQynI6jyndFSbYQcNoW4TOUCArwhvTBYcjSsi8gTdk55i3a1zGCn4jMfajFzDrrKdRntq4nhDH7AJLFtAnKXIHlMSPwwTzjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iSzBx9Gp; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iSzBx9Gp"
Message-ID: <1b8a2b72-b08f-49fb-940e-f23d90ecec7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773253197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2P6YoU9dCwYl3MSzSFu3W4hJnAvjdqVxxFlPujX3mo=;
	b=iSzBx9GpMOu1q0JY9xJ278SzharsUN+Ku8wHoB/sixSkRf8dLRW2vkjlsQh/HPe7Ku9O0r
	ZPqCXUjVUMacJWEGtqZKBdAN+iNTqxF5TTr5Bu1qab2setQPpM4T2X2hVaC7f78sBlvcxj
	O5usEl/j6qxQgFRRGtR8cRfwiwcyIAI=
Date: Wed, 11 Mar 2026 11:19:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Enforce definition order for __msg macros
 in BPF tests
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: David Faust <david.faust@oracle.com>,
 Jose Marchesi <jose.marchesi@oracle.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
References: <20260305130035.192080-1-cupertino.miranda@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260305130035.192080-1-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/5/26 5:00 AM, Cupertino Miranda wrote:
> Ensure that __msg macros, and similars, used for BPF test validation are
> processed in the order they are defined in the source code.
>
> Neither GCC nor the C standard defines the order in which function
> attributes are consumed. While Clang tends to preserve definition order,
> GCC may process them out of sequence. This inconsistency causes BPF
> tests with multiple __msg entries to fail when compiled with GCC.
>
> This patch fixes the test runner to explicitly sort or process these
> attributes to guarantee predictable matching behavior across different
> compilers.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: David Faust  <david.faust@oracle.com>
> Cc: Jose Marchesi  <jose.marchesi@oracle.com>
> Cc: Elena Zannoni  <elena.zannoni@oracle.com>

I simulated with a few examples, e.g., message sequence numbers
like [4 3 5 2 0 1] and the patch looks correct. So

Acked-by: Yonghong Song <yonghong.song@linux.dev>

