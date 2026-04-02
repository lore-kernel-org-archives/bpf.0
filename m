Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE439B962
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119131; cv=none; b=GnSBZDXXtx0SxDQehMzHA/wm3DJmWzG0ntkKO6J1+JNg8ytpTvvoiQFg5mt/WN1FbBpaRsdRUAQNdvxxpA5bMSKcTxzajUuOgNQAnDVEhA7EmbqTYtr8Qm1gxT3aUL8Nk8gFY7H5uAnFhXlXUmo/6kN/tBcXhsrLqqjKWho8YNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119131; c=relaxed/simple;
	bh=ZsZA9LlXyJ1D27ScN89sB+DLKYnxPqwULA/8jPshz8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1onNZlCmNXImWnWYeidVKBGkq1NXbmDwURPAVQtIZhxvWgIDgVGVIIsYzWLyTHrR27o9a6k6P7ZSKbwOsfPttZNH0vUF+s67Bti+XW1JiUdkQOdOunH8l+sUN9ii+rGNuK7kTArBNs7FKe6rFhYJwwBr0vj7Vtd5XSpfW0QXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NIBJCsI/; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NIBJCsI/"
Message-ID: <7f4e3b36-3e9e-4db5-9423-cbf4174e30d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775119127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsZA9LlXyJ1D27ScN89sB+DLKYnxPqwULA/8jPshz8w=;
	b=NIBJCsI/7L25b0KJcba+yOyuuGXK5VaryBSgt3XewtOCrcv8EGGfJUTadJUmauXHs9NDPC
	BcXm+X//DwsO+mvo87Jxw7Pqz4Jl5o1jwvc6QfAHADkCpFN45h3pe182mA/Km/CgE+EhzK
	1pHD230q7Xz5RjqpKSvCBjid8jj/99A=
Date: Thu, 2 Apr 2026 16:38:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>,
 Mina Almasry <almasrymina@google.com>, Eric Biggers <ebiggers@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Soheil Hassas Yeganeh <soheil@google.com>,
 Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260402033138.388574-1-jiayuan.chen@linux.dev>
 <CANn89iLdRZd-qO4tRpSGamHpggh=r5vM4xes5npYCnkwcNG89A@mail.gmail.com>
 <ad90b2a9-0f67-4796-94bc-9dbb76a575af@linux.dev>
 <CANn89iLLwk9G6K8r=hOxsQQ2AsW751E+2pOoud9c-R+R-3i6hg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iLLwk9G6K8r=hOxsQQ2AsW751E+2pOoud9c-R+R-3i6hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/2/26 4:03 PM, Eric Dumazet wrote:
> On Wed, Apr 1, 2026 at 9:15 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> If we no longer care about the cost of accessing a struct page in the
>> free path, which the original commit was trying to avoid, this is
>> indeed the simplest fix — kfree() correctly handles objects via
>> virt_to_slab.
> We only have SLUB in modern kernels, kmem_cache_free() needs to touch it.
>
> Using is_kfence_address() in net/core/skbuff.c is pushing too hard in
> my opinion.
Thanks, I understand.
