Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFC4A092B
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465352; cv=none; b=VKQvpAhmCnaAMjEbWzPoqUbiI5HxY9n7g//ACS90gIyDu9AlopRpEzzzAlzYHb8gp0yT7RSaBUwkR+ixe7ebfX+l1G5aZIdtOn5paPHjUhZpgvZsyu/iteUXy+Oy2NZoGRpCPJsf2G9L+qLzZx6DTs6xzq2PBUzynvU0Yvcn5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465352; c=relaxed/simple;
	bh=IZORgLSswiz9QmuNMURLt7UkMWrabxvr9qyMUZFB970=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOrv2ga8LWZ1XQukMPZM0MbyS7jQOZ/XALHFGvLAAlcLXe8u0YrTTvvLXI7jCrjIRI+3xARX/eOL0MrHbnoBevxuLfDVTtSjutjFHw5LBOzgv6qsbwQfmTgfiJJGBrBtIBk//2llZxd5r5NVxzMvRggFvHlRAqKU8W36vAmhqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD7ZoR0C; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD7ZoR0C"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-486e70f2457so2370537f8f.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791465349; x=1792070149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1GZXZQLgqCvw5WtP3CtocqOoYfauPu8d359Zy0nEiQg=;
        b=LD7ZoR0CffQAQ9pdy6beoeQ2xnS+awZSAS4Nw3T6vrj9i0ZvcnspUaDIof6FhhdcSF
         YrY3+Lap/ELeU6uIQpIuwnSWK47V+ldHSMuzspXtQhFHByzHA+F6CVzYnwEbx4ZnsMyQ
         3pDro/Yv9ciQJ9dBSIA2Kywbi1k+iE5lRD1DfgdwOa90eYN1FVEBg8ygdUUSO6dRTnDw
         iOJkbzEMMflchRvFYq9ntDRVfdmvrjc9ysndKQmBCnBzHlrdb0AN4gBEAbvh4r+5KTYN
         12vGvn3nDgrX67laM4ICmjW3GhIxAcTm4Y3uwJssTHtUpmw+0lb20Ka2xIz7V0bxcfUn
         aXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465349; x=1792070149;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1GZXZQLgqCvw5WtP3CtocqOoYfauPu8d359Zy0nEiQg=;
        b=XOaXy3MAYldz7gq+iWkJjr16HLuAHHPefpH8ZvECJcajy8cZkjtbbL+MZlVvI/ox8c
         pHDQhkxzuRX34BAoLthCob49tQ/HhAitjNbxeoJiYxbpwtpJ7ltHrVS29QGGrsdFOyjQ
         LUIfpuv/p4p/yPIDafv7KHq9NJD2M+drBjOol3EWL0fetSO1hfTe4SC3Aa8EJHPsTncf
         b1DNSCv6lpXk/sjfh7K8AzNN/1SQ9Nb1mG6Jyt9Txp5FpIdylp2m9Joq+C7x77fBilHP
         tTdG4/c5tBDhv9YeRc+Ur/KH+VQJSOq27pRfyhk7krPAvdsNs/255A3xwrINvCPBD7u2
         d9fg==
X-Forwarded-Encrypted: i=1; AKwUvBzJZ2XBcbYEnoQsfPPQg6ix4Iy4KbjcTvyNjFyxfZL6RGQhsI+louCmmYrfW3Ni5/Ttpm0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIG4CFsio2U6hHlnz+TnzCD7kJLNhhKModpdNgui04EYxZK8cuk
	5F75yse+APs39rVemYDsM0ze1EGTCHbLXN7JldYXHD+KQa6OT82/xs//
X-Gm-Gg: AYBFou2IV8Z94OS2iIHgDJ1YT+9CjLE/odBpt5n95geTZtDm4Zxvw/ibHFI76qBk+MS
	g4y+k5NnurMzpK+ywKVUL5Cgl7MmqOoYGcHbNci1lUBles/d9zlnqUEBXF2DF0G9sS5iTGAyUIg
	hyp6+SA+/lVDRHVFseD0M9wWVhk6IZCJkTRwst5So9Dv+7a6PnroqsYX1AnjdLBl82PNkhvhD1Q
	+2Vag6kxe21/0sn/JLVBHCMDNBBP1fh+xFZh/+3ycXKvBUmvvPmcEFaEl1EfHnh3QJwMyZaRVgi
	kfvWCmaCq5HGXkvcxiFl0nhrkfU9hmQ8IH6q8sRhuZaDoAg9nnpsta20+9wJWJDpdTTLfUjtSQo
	LGzyzNcZyMU19rA1CCBnCPoFQc0GIMfhTUFR7VDN5ycc+B1N6iPOR1SFzFauo1Uh2Hx8QzY7wZg
	BL/mnASPDkO4viBeKkOnmH23g2Gv169aXgDVqdrE2GDhj3mlpWSKYVGaXgVmUBLEWBHboiacf9+
	g8bDrdP5iV1yN1xD1oUhsomb/fGxUyyVlAxHeGYuDIIT3ncU3GBZo3SFHwGB0X9EPjoLnj33qmE
	MaByrAbR3TiLhS2u5jROp5+QK54EZ9B+/YtMoEss/Qj/dSju
X-Received: by 2002:a05:6000:230f:b0:48c:7f53:960c with SMTP id ffacd0b85a97d-48c7f539971mr5090297f8f.10.1791465348301;
        Thu, 08 Oct 2026 06:15:48 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71b786d8sm11392383f8f.0.2026.10.08.06.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 06:15:47 -0700 (PDT)
Message-ID: <78a72b62-7c35-4eae-8d6c-ab6dd8c20db2@gmail.com>
Date: Thu, 8 Oct 2026 14:15:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/2] docs: netmem: document netmem and memory
 provider design principles
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Luigi Rizzo <lrizzo@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261005004958.3603059-1-almasrymina@google.com>
 <20261005004958.3603059-3-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261005004958.3603059-3-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/5/26 01:49, Mina Almasry wrote:
> Add a Design Principles section to Documentation/networking/netmem.rst
> covering the netmem_ref abstraction, the prohibition on direct
> downcasting in callers, decoupling memory providers from net_iov,
> decoupling net_iov from unreadability, delegating provider/type logic to
> memory_provider_ops and netmem helpers, and the homogeneous skb fragment
> memory type invariant.
> 
> Cc: Luigi Rizzo <lrizzo@google.com>
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>   Documentation/networking/netmem.rst | 46 +++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> index 217869d1108dd..57e52a947663d 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -19,6 +19,52 @@ Benefits of Netmem :
>   * Simplified Development: Drivers interact with a consistent API,
>     regardless of the underlying memory implementation.
>   
> +Design Principles
> +=================
> +
> +Memory providers (or the default ``page_pool`` allocator) allocate underlying
> +memory (``struct net_iov`` or ``struct page``), cast it to ``netmem_ref``, and
> +supply it to ``page_pool``. The ``page_pool``, drivers, and networking stack
> +operate on ``netmem_ref`` as the abstract type. Existing ``page_pool`` APIs
> +that allocate or free ``struct page`` are legacy compatibility wrappers for
> +drivers that do not yet support ``netmem_ref``. Code that is not yet
> +``netmem``-aware should be converted to ``netmem_ref`` unless it will never
> +need to support ``netmem``.
> +
> +1. **Operate on netmem_ref, do not downcast**: ``page_pool``, drivers, and the
> +   core networking stack should deal with ``netmem_ref`` rather than
> +   ``struct net_iov`` or ``struct page``. Downcasting ``netmem_ref`` to
> +   ``struct net_iov`` or ``struct page`` is not allowed unless a code path
> +   strictly cannot function without knowing the underlying memory type (for
> +   example, ``kmap_local_page()``). In those cases, to keep call sites simple,
> +   add a ``netmem`` helper that performs the operation on behalf of the caller,
> +   cleanly handles all ``net_iov`` and ``page`` cases, and returns an error if
> +   the ``netmem`` type cannot support the requested operation.
> +
> +2. **Decouple memory providers from net_iov**: Memory providers are not limited
> +   to ``struct net_iov``. A memory provider that returns ``struct page``-backed
> +   ``netmem_ref``\ s to upper layers is allowed. Code must not assume that using
> +   a memory provider implies ``net_iov`` memory.
> +
> +3. **Decouple net_iov from unreadability**: ``struct net_iov`` is flexible and
> +   has no inherent restrictions. While current ``net_iov`` implementations are
> +   unreadable by the CPU, future readable ``net_iov`` implementations are
> +   allowed. Code must not assume ``net_iov`` is unreadable; check readability
> +   via ``netmem_address()`` or ``skb_frags_readable()`` instead.
> +
> +4. **Delegate complexity to the lowest layer**: Each layer must respect its
> +   abstraction boundary. ``page_pool`` must not implement per-memory-provider
> +   custom logic in its main code; instead, it delegates provider-specific
> +   handling to ``struct memory_provider_ops``. Similarly, core networking code
> +   should avoid per-``netmem``-type branching and instead delegate operations
> +   to ``netmem`` helpers that handle the underlying memory type.
> +
> +5. **Homogeneous skb fragment memory types**: An ``sk_buff``'s ``frags[]`` are
> +   always backed by ``netmem_ref``\ s of the same memory type. Mixing fragments
> +   from different memory types within a single ``sk_buff`` is not allowed,
> +   keeping ``sk_buff`` handling simple. Consequently, coalescing ``sk_buff``\ s
> +   with different fragment memory types must not happen.

Would be good to expand on what's the memory type here. We have netmem
vs net_iov, and there are different memory provider types, but we need
to restrict it even further, sth in the lines of "if an skb contains a
frag from a memory provider, all its frags should be belong to the same
memory provider".

Otherwise,

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

