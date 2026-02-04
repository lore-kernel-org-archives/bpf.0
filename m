Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F188927456
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236300; cv=none; b=dd9X4wI1CelnnNke/492F2M2vQ6Y+mF+X21LFFd+BELtiEGg5YnsosEXPS0oyC6wv5IQEyElqjkWXc5174vtl78FetbMsAImqfWX2eLwsjhQPY+dwjOSnLNqkYqATpwScFsmjhEqwj4hdVOVhKvwmAGgKSyDK0o42rkWIPqPkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236300; c=relaxed/simple;
	bh=RodW8yBOZz6ysYNkDfsRd3/P3tfnOzkO8UycEqe9Pj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRLNkxf4Hx7Hc3MbF6vIYeBQL1GV8VK9n6OfuaZDpBVYp0Nc1FjEwRFg47G6NLTkmK8KL5dl98fXfTKpfCyaRldThkFgUEMOQQJrLH+/ePXaPhmi8jke0hRyWRiF2vE/UgzEXZNU6S2KZkT0GlsMjA696hyWd1Xx3O4tycMWWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J9a0Wb5S; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J9a0Wb5S"
Message-ID: <99bfc3be-0517-4e17-b7a5-e504b751d8bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770236297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gi9XIaCgaA1g0K/V/rmmDYgDSWtNyYGCbYjZKLA8l/A=;
	b=J9a0Wb5S2SXd5lZR8awLV2bTVZZ0LLvWJbp/NgnKQAMm5ZNARbR0CWGgMGpz2KqwutBeO0
	vGxEJjuUdu1RRZ6SjxwKYFJkQYNFsruhHAfpe74VMAoLVSlXggyMvGQJePbVEUrp0KMfHs
	6V8iCpMr7q57BMeOx8tcMF6AE22sA1U=
Date: Wed, 4 Feb 2026 12:18:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
 <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
 <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
 <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
 <CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpHBGqKcUT0iMA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpHBGqKcUT0iMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/4/26 11:16 AM, Kuniyuki Iwashima wrote:
> For example, inet_sock(sk)->inet_opt could be freed by
> setsockopt(IP_OPTIONS) even after fentry prog verifies
> that it's not NULL.

This one should be fine because of rcu.

> 
> I'm not sure if bpf_core_cast() etc allows such access, but
> if it's allowed, I think there is no general solution.

bpf_core_cast (i.e. the "kfunc" bpf_rdonly_cast) does not use the 
pointer argument, so should be fine. Its return value is marked as 
PTR_UNTRUSTED. iirc, PTR_UNTRUSTED cannot be passed to helper, so 
bpf_core_cast should be fine overall.

> 
> Fortunately that's not null-deref nor oob-write, and it just reads
> stale info as Martin mentioned... so probably this is WAI for
> tracing prog ?

afaik, the tracing radius is large, so the prog cannot expect much 
guarantee.

Reading in the bpf prog is fine. The exception is handled.

The problem here is passing it to a helper (not kfunc) that depends on 
the arg being valid.

