Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175A329373
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378780; cv=none; b=EL5nYZ8rZpxXbAQS1lDQLaOinmRwp6rr1+nfRUPViSS6omMeykBzToBUMJC2QWNy1aNW+8v/rHBVEKo4vH3mnz7DC/SplrhqK/RD2Pef7zRXh6At5PqvGZk10wk44xnpKhRcGczELdW9WcZaZLoKAt+X0e7OnWYUaImeMctSiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378780; c=relaxed/simple;
	bh=+FElo7X9gQac48qz+OcS4RcKHsZ021R7wgrdRHvjKbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkgPQrxcP8qp6V0FsofcTBWFEbniKKCpk+t3bzQ/Rtf6hryZgiihOHGaLrw/4Y+MIT+tNd3p10+EaBE4gE4j66Ul6pOj3BYP9cHyXkWuLNeWaBEdjoLUygk/OfEUvw5h6rADCRTVNhGL8vycpuU9ym26kj0pfCl/nuMJQW+aIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OQYxl1j0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OQYxl1j0"
Message-ID: <f0dde6aa-5e03-4f3d-8fb0-adfdd10cb173@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780378767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXk9VIGnTaHw+bzMRwdLOaFGSrYXgWsGbXFL2Z2hI60=;
	b=OQYxl1j0kkGXsb4fcq2bEWrcwAPahnM9g002pPiQj2JBdN9GHBmEnRpW9R/e5QweUVEgo3
	N2z2Xan0JKbpjTEpQ7ivdrMi67x/B1LOGlFFMbRZA4CCjwtu5Bh1sftIwXOTo6ABvOZfdm
	sfn9R3vMcAm13gSarI+aliCm/S5PKI4=
Date: Tue, 2 Jun 2026 13:38:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
Content-Language: en-US
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Peter Oskolkov <posk@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com, Leon Hwang <leon.huangfu@shopee.com>
References: <20260601150203.20352-1-leon.hwang@linux.dev>
 <20260601150203.20352-2-leon.hwang@linux.dev>
 <0fecd90a-d218-48dc-86d1-860ab2e7f6d5@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <0fecd90a-d218-48dc-86d1-860ab2e7f6d5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/6/26 11:17, Jiayuan Chen wrote:
> 
> On 6/1/26 11:02 PM, Leon Hwang wrote:
[...]
>> @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb,
>> void *hdr, u32 len, bool ingress)
>>       if (ingress)
>>           skb_postpush_rcsum(skb, iph, len);
>>       skb_reset_network_header(skb);
>> +    if (ipv4 && is_udp_tunnel)
>> +        skb_set_transport_header(skb, skb_network_offset(skb) + iph-
>> >ihl * 4);
>> +    else if (!ipv4 && is_udp_tunnel)
>> +        skb_set_transport_header(skb, skb_network_offset(skb) +
>> sizeof(struct ipv6hdr));
> 
> 
> I think GRE is also affected, why not unconditionally set transport
> header to network_offset + outer_ip_ihl regardless of outer protocol??
> 

Probably, yes. But, I'm not sure about this.

At Shopee, we encountered the issue that the VxLAN packets encapsulated
with lwt-bpf were dropped on ice driver. And, it is to be fixed by this
patch.

IOW, if someone encounter the same issue for GRE packets, he can fix the
issue by the same way.

Thanks,
Leon

>>       memcpy(skb_network_header(skb), hdr, len);
>>       bpf_compute_data_pointers(skb);
>>       skb_clear_hash(skb);

