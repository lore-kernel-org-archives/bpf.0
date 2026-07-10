Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC63E1689
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722270; cv=none; b=nYCqMPOmvqIHknqCkamUTH6rEtUo4dkILnWB7oYqYpYWq+9mzp78ylr3jezG3SUV+4jhZOX0Ii8gvAlvAWB2lqw8/JVlwZ93ha1JmgLfKcBhr7oZxxPrrNF3V9OWDGth1lmlUMppuK2st6ZbVvdZHb9hBMiHj57bnQya6zsNud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722270; c=relaxed/simple;
	bh=w6uCRYESUORP4ZQ4nJ++DOOO6Tx+JrvDiNeomd06alM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIUxAgmgmoa4FssgJVf9IQps1qpGUuix0Qx/C9Z6LBVeJF0p7TYQFRHrVYNfrTjjtqoQqwkBLcr9Z20pSg3h3JhR8FBduAJ78n1rL7JgdpCrvputooTSZd3ooA7nFXgghq1BpABjZ+Xw5QSBTyt6xzHqCmh9hmPODPg/TbLXG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tph/Xx1D; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tph/Xx1D"
Date: Fri, 10 Jul 2026 22:24:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783722256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6uCRYESUORP4ZQ4nJ++DOOO6Tx+JrvDiNeomd06alM=;
	b=tph/Xx1DJCi5Sy1ovO7bsHrswcaeFFflt0prOOhHOdA72hOjMeqWAWTbAf/7ThEqTnyFFo
	/P4DVoSPEx+gIgwCPH0cjHLQvY+DM5xZDYzTjFQsrFJ3k6P5++tF4pGh8t4H4J1kDxy1VB
	De4c30LaxTU9UTMddeByamLJiTCc7EQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Ben Cressey <ben@cressey.dev>
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
Message-ID: <alFvAK_R0ETnTXAH@linux.dev>
References: <alD1FJjR5r5n5Eau@linux.dev>
 <19e8e6f9-0d4c-4ae4-b519-603420619363@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e8e6f9-0d4c-4ae4-b519-603420619363@iogearbox.net>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 10, 2026 at 04:32:39PM +0200, Daniel Borkmann wrote:
> Given TCP, it would be good to still get an Ack from Kuniyuki or Eric and
> then we can ship it. Are you planning to also follow-up with the other pre-
> existing issue finding?

Yes, I'll send a separate patch for the realloc_batch() double-put next
week.

Thanks,
Jose
