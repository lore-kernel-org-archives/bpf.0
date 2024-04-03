Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840B138494
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182154; cv=none; b=FAsAVvcJqYGXuySwDZSPfVGoSRJywVIE30fWOTrIIbBM1yaMIhHKX7wBrFSX9YUMNri0Rv0IvAW9Nosf2cfGze80VmnbaCW51NBW4jbc+/odz5WkLMxXXmnVqdrZzRljrzFdAX5Kk1g7BMe5ohT5Qhw0jAfBBYx3vgwOcl86zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182154; c=relaxed/simple;
	bh=FpHPjv0qIcd4vDdHXrn3+DHWPPEl7ptGp3fvQDOeXbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPnvYWYCWwwWMEhD+9FgB0hTKPy5i5HOBtP1aV5RvPCMmsBMGRJ0jpoorCSYRWn0pq0RafXj1ENVi6NW1+bwvjSLazjDXkbsPzPJKOtQMHFtxYA93LxQfAg770S5hf+ORpSS2RW3iXoLtyZ4daeFjr/MIXN/eVQKeQazYmwI1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u769mNG4; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u769mNG4"
Message-ID: <e49ccf43-ae90-4df1-bc10-5ee180ec47ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712182150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oprPbI5wOD8JwZb3qLbOe/m4jL9fo1Bz0dDSO1rtpPs=;
	b=u769mNG4+qN4XNPvsopUn7s2uQPwU7aVbaJ1X9NRtAD2AnGCDfkPDsbYj2Y83Uk7CrGMDh
	EDtzMzoU+6klGiIxffBJBGq480ZK8DCMAAd5nUpelMvj1FqCBj8YNQhPq1kySCVRH5NX8f
	rxk8uiIPErEKlOZzXk/KlEmjyz25hgw=
Date: Wed, 3 Apr 2024 15:09:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: run bpf prog w/o sockmap [was: bpf: Add bpf_link support for sk_msg
 and sk_skb progs]
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
 <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
 <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
 <660d964a1444b_1cf6b20885@john.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <660d964a1444b_1cf6b20885@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/3/24 10:47 AM, John Fastabend wrote:
> on my todo list, I want
> to just remove the map notion and bind progs to socks directly.

Run the bpf prog without the sockmap? +1, it would be nice.

> but other than quick hacks I've never built such a thing nor ran it 
> in production. 

How do you see the interface will look like (e.g. attaching the bpf prog to a sk) ?

It will be nice if the whole function (e.g. sk->sk_data_ready or may be some of 
the sk->sk_prot) can be implemented completely in bpf. I don't have a concrete 
use case for now but I think it will be powerful.

[ It is orthogonal to what Yonghong is doing, so the title changed ]

