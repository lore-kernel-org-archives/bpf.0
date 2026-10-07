Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4341C30F;
	Wed,  7 Oct 2026 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359045; cv=none; b=mUHmlGPyednDRRmnnCPuwGI22tOu58lbY8KzK5Y37SOV6TBNPDFIZLamB5Gx+KZzuJfeQ+ANK7AIdEdL0EZUf8PRxMbkD0DaPNGqzaYGGM51p1tAef0oH2cIFSb9qOx7IFilM1r4Ah3oK4CVOF25JGKpa3C0YkVXKYHy+V6lCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359045; c=relaxed/simple;
	bh=HnI9Orr9cFzycjkpUEC5RPW2/zW7ejSYjCFK4MnW6ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hb/aEvQLLG6LtjfMjMwJRVhdKwGeK0jrt5UiwvTsbPieyojcxWE7p8RWvX41YgC5s7ROyTuczj4vhm9fCyKW8m8amOogqcyrdgNTAdTjzFGFAbpODXJ2KAUZHbir9oXp3zvJLwrbaV5a47OnDqELFFZOpO3iruNobHdetCQY2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFNJjI2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFNJjI2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB251F0089C;
	Wed,  7 Oct 2026 07:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791359035;
	bh=e10A52x8eNlaxr8y/42fRB7ZGuOuiwnvD+s8zuy+cZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aFNJjI2HN5zYP+wGvdq0gTjxVQeS58dPwkFtQTceZrRXzlyOa+XZXocBo5oF5MYRM
	 YHSsXYhSrfT71ShRbctGTD+MMbpSBM8nX8NmTBkLibsieIlhPpguCh8srFcNKvS4au
	 yF0dryWnvzdlwgmGbyeyCcI2dzscWIwbjPnjGp6kifTj4cGrTdf1XMgY72jAPw4sNB
	 ZhlFsEldW8scrJa4k3SQghw47/vX6b/T8emjrtp7G1iMNdjv/7qWjHPKQHX7Anczl7
	 OvNV2kjJe24xgi2Vj4vsBP2rn9QiiJ01rA33xxw8CMOflS3OMjs0HJKfWy4r9gyM/y
	 ljpC0P91mNLIA==
Message-ID: <4818da7c-be7e-4f97-b5a3-bee05ada500a@kernel.org>
Date: Wed, 7 Oct 2026 09:43:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/2] net: netmem: document netmem and memory
 provider design in comments
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Luigi Rizzo <lrizzo@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>
References: <20261005004958.3603059-1-almasrymina@google.com>
 <20261005004958.3603059-2-almasrymina@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20261005004958.3603059-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/5/26 02:49, Mina Almasry wrote:
> Clarify the netmem, memory provider, page_pool, and skb fragment design
> principles in header and code comments:
> 
> - Memory providers allocate struct net_iov or struct page, cast them to
>    netmem_ref, and pass them to page_pool; page_pool, drivers, and the
>    core stack operate on netmem_ref and must not downcast to page or
>    net_iov outside dedicated netmem helpers.
> - Memory providers are not restricted to net_iov and may supply
>    page-backed netmems.
> - net_iov is not inherently unreadable; future readable net_iov types
>    are allowed.
> - Per-provider logic belongs in memory_provider_ops, and per-netmem-type
>    logic belongs in netmem helpers.
> - All frags in an skb must share the same backing netmem memory type,
>    and skbs with different frag memory types must not be coalesced.
> 
> Cc: Luigi Rizzo <lrizzo@google.com>
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>   include/linux/skbuff.h                  |  4 ++++
>   include/net/netmem.h                    | 29 ++++++++++++++++---------

./scripts/get_maintainer.pl --file include/net/netmem.h

Returns "maintainer:NETWORKING [GENERAL]"

>   include/net/page_pool/helpers.h         | 18 ++++++++++-----
>   include/net/page_pool/memory_provider.h |  8 +++++++
>   include/net/page_pool/types.h           |  6 ++---
>   net/core/skbuff.c                       |  3 +++
>   6 files changed, 50 insertions(+), 18 deletions(-)

Changes LGTM.

I suggest that you Mina is added the MAINTAINERS for PAGE POOL.
And do we want a new section for NETMEM ?

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

