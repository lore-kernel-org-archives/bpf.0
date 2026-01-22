Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35858392838
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113321; cv=none; b=UmttREwMylOuAGLjpJMGiExHt2D+Arrft6hIeMHtZojLkEjxgmCrgzbE76aKpuaR0X7mBHilP33qk/ULUq3sOT9xlwgnZW1wNcoDg12aRVwZ7abwTjB8qA30i/XLvVq2WEZn4AIExcYT3wfpF+EtYvEuL3qPozEwmhd3NXOEeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113321; c=relaxed/simple;
	bh=MBz9V95XIV9RSXmKmjbflPIhLxIbuc9EdkzrUGIegkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7ZqImWc2+Wt+esZrNHezHB0LyUHMn4mU5+QoA5W2P95tHjbzvmo7RNhNRLmGI26xLbu4y7XkKboJ/h1qVy7SlUHFKdJfm7VNHDLCiSNPDICOadPODqtY6vE7XIgm/H44DVCXKWsudkQ8hNKQRmP7H+00Gt8htNf1bZU8grnEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PwXNemkS; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PwXNemkS"
Message-ID: <ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769113307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmsPbxD4P2U6cfRhimAmDFnoSDOJmyA6gTw2jvjRFQo=;
	b=PwXNemkSVY+ky4LEOmfP2pan4B5MDwzZCRi6xu+xEhtfhvYzFZS7qTQxmSfgbVn8p7vAse
	8kz6jbK06oD70NIh5+furf0Dm3ao8i8vlft2osWnUQKB38nwgSp1lE6TquDLMrCmz/M5rm
	4RgcUg9CBFSFRB9bO8oReErZOUz3QeI=
Date: Thu, 22 Jan 2026 12:21:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com,
 Jakub Kicinski <kuba@kernel.org>, Amery Hung <ameryhung@gmail.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260112190856.3ff91f8d@kernel.org> <87bjixwv41.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87bjixwv41.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/13/26 4:33 AM, Jakub Sitnicki wrote:
> Good point. I'm hoping we don't have to allocate from
> skb_metadata_set(), which does sound prohibitively expensive. Instead
> we'd allocate the extension together with the skb if we know upfront
> that metadata will be used.

[ Sorry for being late. Have been catching up after holidays. ]

For the sk local storage (which was mentioned in other replies as making 
skb metadata to look more like sk local storage), there is a plan (Amery 
has been looking into it) to allocate the storage together with sk for 
performance reason. This means allocating a larger 'struct sock'. The 
extra space will be at the front of sk instead of the end of sk because 
of how the 'struct sock' is embedded in tcp_sock/udp_sock/... If skb is 
going in the same direction, it should be useful to have a similar 
scheme on: upfront allocation and then shared by multiple BPF progs.

The current thinking is to built upon the existing bpf_sk_local_storage 
usage. A boot param decides how much BPF space should be allocated for 
'struct sock'. When a bpf_sk_storage_map is created (with a new 
use_reserve flag), the space will be allocated permanently from the head 
space of every sk for this map. The read (from a BPF prog) will be at 
one stable offset before a sk. If there is no more head space left, the 
map creation will fail. User can decide if it wants to retry without the 
'use_reserve' flag.

