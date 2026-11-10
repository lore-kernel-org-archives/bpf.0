Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.248
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294350;
	b=vOp+aWWtGfEU+I1WmA6BUWUDPsATxqgmL38IOgGZqZAeyz7OHPSHe4RFXrekWFmA+e+/
	 xEivG3WZ84hAN3wENilZJdmo6IoLobJcghOrLYUuXjdpiGqDmixvBcZXbTBh5q5ZG/Y65
	 cdYTXzgM4rnCVSZdZsJVAjtBApbH2rI2U5OvApdQE4YRGW71FEYQXyAmFM5M3nLHd7UOR
	 Yw8611xLOQuAXza6sZMTIQaeBH+OakQelCqscyGZyfaGYHhx0OyDIrEvH1mD4jbjBybeA
	 N/PNY/o/jezRThZvucNB5nPIHWC9AFv6Dw+32NJfvqvbuIpsuzbpSp53JpOKqDjcNBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294350;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zZk3SsVUMy8xoTgawAV8jGI3OOcRbHbKMzszzz5dC0s=;
	b=y4TNFkldHHpK96hG4ZsSQKEokY5qhu8tOmUSuP7Z0H++fSnkBy8pGlGoY0NadeD5IsNu
	 kQbv2oDW2ReNftO+mbjDnJvwLqE+vDTsTv4kJNPKS8nv+DT8rvfIEMim/SctRrbYxNk0q
	 jjMFzvfVSyXRB4KmNAFjxxmd7uUdU4j3Y0E8p2elxHz0QTRsbVxgEQQ5AbQLQRPd8yWWT
	 JrTe8GkcX2BmHu4ppqv7VtU0SKBQqIV1rbzWbOh/3fTcR3Uphtl6obmTv/+pjh7/oX9rP
	 5ivn3GdGJgzYmTn0yCLCBv7Uh+wxbrvc+eCekRDv8tMEwjdVHx+OLsHl2tWNI5WSSiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="uX/FQNF4";
	arc=none smtp.remote-ip=91.218.175.248
Received: from mta0.migadu.com (out-248.mta0.migadu.com [91.218.175.248])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D9606A331
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 07:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5D9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uX/FQNF4
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PDz+qwYH/e/DPGEx5k9eJgKdIlMjdKtiXOXsonysk0k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794294345; v=1; x=1794899145;
 b=uX/FQNF40xr/pIkkUgsE2UNKnZG75Tt6NWSf5BNLlae16iQAeBMtFrIU9GhpOqq/Euhb5aXY
 euuyrcGDewk+jI62Yq7+p2mLv6DqABEtEDLGNMGy3wNBO17j1cUZsBPTnCsrB6BUimiEtWjhrgZ
 mESlCW1ciTfPNgA3w+DJiY/8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6dea8860f641d184;
	Tue, 10 Nov 2026 07:05:27 +0000
X-Mizu-Trace-ID: 6dea8860f641d184
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 15:05:14 +0800
From: Hao Li <hao.li@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slub: Genericize x86-specific cmpxchg16b comment
Message-ID: <avK8RqLl69zIkVY2@fedora>
References: <20261109035906.10857-1-yangtiezhu@loongson.cn>
 <DMQW32TTNOPX.24GN6Q7VI6QJR@gmail.com>
 <145c23ea-bc4d-b235-c822-df94b00a647a@loongson.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145c23ea-bc4d-b235-c822-df94b00a647a@loongson.cn>

On Tue, Nov 10, 2026 at 09:29:04AM +0800, Tiezhu Yang wrote:
> On 11/10/26 2:25 AM, Alexei Starovoitov wrote:
> > On Sun, Nov 08, 2026 at 07:59 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > > atomic primitive is satisfied by different hardware implementations:
> > > (1) arm64: satisfies it via LSE atomics ('casp' instruction)
> > [...]
> > > Update the comment to "double-width atomic cmpxchg", which provides the
> > > following advantages:
> > > (1) Accurately describes the cross-platform hardware invariant.
> > 
> > You ignored Hao's point about shorter commit logs.
> 
> If the following shorter commit message is preferred:
> 
>   mm/slub: Genericize x86-specific cmpxchg16b comment
> 
>   In __kmalloc_nolock_noprof(), update the comment from x86-specific
>   "cmpxchg16b" to generic "double-width atomic cmpxchg".

Ok, LGTM.

> 
> I will wait for a while for more feedback from mm maintainers and send
> v3 if necessary.
> 
> Thanks,
> Tiezhu
> 
