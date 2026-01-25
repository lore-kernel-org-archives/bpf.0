Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8C2F3612
	for <bpf@vger.kernel.org>; Sun, 25 Jan 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368516; cv=none; b=VRtIVrpd05NTh9Dbl6hMYEf1bAr67nXyPjz8CpmYbee2yxFt0TgQaAwN66RNw6Z5Bc54PoeIMXjWeuS9lNUw9Ppqekx6VEVbK15TBxT9qp5TNNjEcdnLyfsTXkVw6gWOH6J6+SvEs+Ppo+qQWWQP47q6z9LkdPJ1s06F59EdqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368516; c=relaxed/simple;
	bh=UaFiLGY06az2o1UrEU9VzuHGzBsf5ccZhhq1L8W6OO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IUVUgcS0ceIlNBnoCENk8EF1nEuL4u4d6oRaYNhTwKzIDz3UwJT0EaXigPFQfpaTEqGCJQvEcbS8CbwME/eCYNNL5kUV/3ptxLUN3nLLPQI9bDqBbYA+7Mc3tgkWnp04rAPlFcpvBX896uQxSwi0L5q9b8j7M08n7WRPpSwJ94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bNEOW6Sq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bNEOW6Sq"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8871718b05so316368366b.2
        for <bpf@vger.kernel.org>; Sun, 25 Jan 2026 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769368513; x=1769973313; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UaFiLGY06az2o1UrEU9VzuHGzBsf5ccZhhq1L8W6OO8=;
        b=bNEOW6SqIW4z4rSTU5lnCtnQJ/VUy2Za4PDQOTpVhD/4kvGocIsBSvtcRZUykt8HNe
         lf9RgQUiGfABnfVawmSaXXHtvHwFNuL9qZkIBbyjalKrVxcHKI7C0jfdeaXVkeoCZdvH
         pfLfMy+DuSp43rQ614YJn2FNB8HWVziu1Z2pg0AOBdSuNPjJ8QAacWrJuafaZL0de/R3
         OOiG55Hsp0d7YUsyATJRrGqUzEG9bdtmb7SxScg4iKPCV1IquZG/c7wM2gfqg3SW9zxR
         HBqRpj8E9diSsNwY8/zIjAhr3WFRCYzrk3Ha6G+F/p1G+klMi/FU5/Uf1JSr0b/eqksh
         Ts7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769368513; x=1769973313;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaFiLGY06az2o1UrEU9VzuHGzBsf5ccZhhq1L8W6OO8=;
        b=JliQc9eokcztrf6aQ5f29dZ5JcGWR/FKYq+qsuS2wNSN0Ew54TdYgvMO2mLC7rM9zr
         +B8t89LSrmc6FoQedagtmuKibltEgugGuRJCjnKcDvw0as5W0yhiZHhBiEAf+L5Y9N0W
         FsvC4tA/kejuf6naCDf2OKsdjec3bKjRGDLOPb6OgALpd6c5x6PPf7Tk5CH89bTQzleQ
         /95BfulI9W+uuu5HGENxgmAcrIhfPNA2Y259jFsA5ODGR59yjE12+M4wNV8ks3k0P4CN
         UGHFMqH+FioL02Y108F3JM5u6QDJWYYwniDNW/Td8qJpQOO8uNf0Tysejs1vcdhxAhnI
         ndRw==
X-Forwarded-Encrypted: i=1; AJvYcCWVscZDm0Z2Yf/4vJiXF2F3p7FSr/4ev90tsW6NiOhcEJhNaGsXvJrlk4O0ssvxmac2xGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydgrrbH8p/1Qc7vyvoH54dtc9zPAhYT/muA2u8Q8iFl62y/DW+
	Wp66rf4hTZNBOyyphzgW+T3wlDB5/PRp9X+DiSlLe7zUEPZE5OBP7uwWKKqN3tDR+OA=
X-Gm-Gg: AZuq6aIEcUVQ38H7zWDR6aBGckT2DnT6tyeuMtuiwycjofUmjZ53FmgBOvZBdXptDRu
	t96BMaj1cwkfzEI6vx6Lx1+0jE6qVoBYz7GFqubNeXkRCX9ia0UhP0qotjr6+qfjnAuf7Xm9mpj
	N16Jy+FiEfHJbDbGX0wDUlNZ3nwl2awHl+GNLLs6VcNKzJqIDKuJoST1RcQSbNZfF6Sl/mXM4qF
	ylzlyTMwbuKbitVd84vfWlJ9XES8Pfi0LEM3+MrCsQMvZM9PugpbtO7VhBMw5BEnDCHxsb0C2ez
	gv4X0X4tgeGZcDUHWr9A02Cav67trnGKE/OjIolsKUSSABRehlG+zdq2ugWFxio1Uz1UkDyugQV
	8/E7g8MQ/qDUhjQSNisQqXDZgJPUYT7KdzbDtYBtmKx0XkX82nbvus7PrNavH2w7BfZWeM2cJkl
	5qOPM=
X-Received: by 2002:a17:907:96a9:b0:b88:60d2:11b8 with SMTP id a640c23a62f3a-b8d0a83048dmr155054466b.4.1769368512869;
        Sun, 25 Jan 2026 11:15:12 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75d669sm494078966b.51.2026.01.25.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:15:12 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Michael Chan <michael.chan@broadcom.com>,
  Pavan Chebbi <pavan.chebbi@broadcom.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Tony Nguyen <anthony.l.nguyen@intel.com>,
  Przemek Kitszel <przemyslaw.kitszel@intel.com>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Leon Romanovsky <leon@kernel.org>,  Tariq Toukan
 <tariqt@nvidia.com>,  Mark Bloch <mbloch@nvidia.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com,  Jakub Kicinski <kuba@kernel.org>,  Amery
 Hung <ameryhung@gmail.com>
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
In-Reply-To: <ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev> (Martin KaFai
	Lau's message of "Thu, 22 Jan 2026 12:21:21 -0800")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org> <87bjixwv41.fsf@cloudflare.com>
	<ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev>
Date: Sun, 25 Jan 2026 20:15:11 +0100
Message-ID: <878qdltsg0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 22, 2026 at 12:21 PM -08, Martin KaFai Lau wrote:
> On 1/13/26 4:33 AM, Jakub Sitnicki wrote:
>> Good point. I'm hoping we don't have to allocate from
>> skb_metadata_set(), which does sound prohibitively expensive. Instead
>> we'd allocate the extension together with the skb if we know upfront
>> that metadata will be used.
>
> [ Sorry for being late. Have been catching up after holidays. ]
>
> For the sk local storage (which was mentioned in other replies as making skb
> metadata to look more like sk local storage), there is a plan (Amery has been
> looking into it) to allocate the storage together with sk for performance
> reason. This means allocating a larger 'struct sock'. The extra space will be at
> the front of sk instead of the end of sk because of how the 'struct sock' is
> embedded in tcp_sock/udp_sock/... If skb is going in the same direction, it
> should be useful to have a similar scheme on: upfront allocation and then shared
> by multiple BPF progs.
>
> The current thinking is to built upon the existing bpf_sk_local_storage usage. A
> boot param decides how much BPF space should be allocated for 'struct
> sock'. When a bpf_sk_storage_map is created (with a new use_reserve flag), the
> space will be allocated permanently from the head space of every sk for this
> map. The read (from a BPF prog) will be at one stable offset before a sk. If
> there is no more head space left, the map creation will fail. User can decide if
> it wants to retry without the 'use_reserve' flag.

Thanks for sharing the plans.

We will definitely be looking into ways of eliminating allocations in
the long run. With one allocation for skb_ext, one for
bpf_local_storage, and one for the actual map, it seems unlikely we will
be able to attach metadata this way to every packet. Which is something
we wanted for our "label packet once, use label everywhere" use case.

I'm not sure how much we can squeeze in together with the sk_buff.
Hopefully at least skb_ext plus a pointer to bpf_local_storage.

I'm also hoping we can allocate memory for bpf_local_storage together
with the backing space for the map, which update triggers the skb
extension activation.

Finally, bpf_local_storage itself has a pretty generous cache which
blows it up. Maybe the cache could be a flexible array, which could be
smaller for skb local storage.

All just ideas ATM. Initial RFC won't have any of these optimizations.
