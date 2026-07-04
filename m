Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0F346E43;
	Sat,  4 Jul 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183270; cv=none; b=prlmgg9N4pY89JyOdJyWMZOtlU/xxWH0nRrmnyo9GxVUumq2Z0/GUbG3tyNVtJUAOT3o3LaoMbIZRFCwqTFx0knjgY2OK9+K1h/Gxu7KiOeHy/tzC1YWRYj7xWdaOIZhKBI3JIZ6WzfVZRW/9X0on/wl7LvwnUZgKw39Je7KeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183270; c=relaxed/simple;
	bh=KLyfcr4pZbvjRBb83ICFhddfx+XwcLOeWRqrdS/GO4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQuF7wKMFK2HzQuoBdGRGy0mCfaq4ylnOR24UzeBjveyZuQUc0fquUjftXIdZ34QuuWcePWUYAWiHmb33jw+SXIC92xDBf3n/9jko+lLZcvt77QrpF6qRo6iG1v1JLV42JbN3OHRDQgdieMYZzO987kNnlMdqNwW2Mv4MGVmijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCHBmwbo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCHBmwbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8751F000E9;
	Sat,  4 Jul 2026 16:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783183268;
	bh=bqfFA+6qIQTAqqCwTLZHCkY69fT4H02s1o+F8hLcFp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XCHBmwbo4lLiJ4fvibhPtALw+W4JqeRuJozvUylHIn7+XnBnhBSS9n0EJA4cj2sXF
	 vyuSvIJ6e7JSP+Kxt3Oat65gCOcsETfRbi23R3Eyr7UIxgA9TD0MWP/iu19+j+zf4M
	 RVw0uECaarHZjohDuNSN2sNtcEhew4ixnWmo/jYaJkaywOlMtEmfdcMR6Wlyp9lcpg
	 3vrZVRbTb/LLhIGLT0ayRtRZJjTT/h0R3tAUxJQCX1aEr1sOTB5ewcL+LCd2o0J/t6
	 KNvOqdTeLsNeZb+2cOWeX59qsw6buhSUP0JomRgZCa7SAsZCOlYwBvKy4Bg7iV5glq
	 JDExh1gRJrB8A==
Message-ID: <1d5521eb-84fc-4417-a3f5-6366694d160a@kernel.org>
Date: Sat, 4 Jul 2026 18:41:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 0/7] xdp: RX checksum metadata hint and
 checksum assertion over redirect
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Vladimir Vdovin <deliran@verdict.gg>
Cc: sdf@fomichev.me, kuba@kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev,
 sdf.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, kernel-team <kernel-team@cloudflare.com>
References: <20260630191510.81402-1-deliran@verdict.gg>
 <akQyT2d0wNF5F5LG@devvm7509.cco0.facebook.com> <akRAUTAqVKkxmoVa@lore-desk>
 <20260701171057.4330-1-deliran@verdict.gg> <akZ7QPfn83OUx5Vm@lore-desk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <akZ7QPfn83OUx5Vm@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/07/2026 16.52, Lorenzo Bianconi wrote:
[...]
>>
>> What's left that is genuinely separate is the "assertion" half -- a non-dev-bound
>> bpf_xdp_assert_rx_csum() that preserves the HW verdict across a
>> cpumap/redirect: it sets a flag on the xdp_buff that rides into the
>> xdp_frame and becomes skb->ip_summed = CHECKSUM_UNNECESSARY in
>> __xdp_build_skb_from_frame().
>>
>> Should I resend that as a small standalone series (v2, assert-only)?
>> It also looks like a PoC that you and Jakub discussed on v3 [1].
> 
> I think we should address the 'CHECKSUM_COMPLETE' use case for it, let's work
> on the problem later, even Jesper is interested in it ;)
>

Yes, I'm very interested in this use-case of transferring HW offload
info when XDP_REDIRECT'ing into CPUMAP or veth.  In my patchset[1] I've
added rx_hash, rx_vlan_tag, and rx_timestamp, but not csum as it was not
available.  My short term use-case is: RX-hash as setting it earlier
allows the GRO engine to hash flows (see dev_gro_receive[2]), plus it
carries info on packet protocol type TCP/UDP IPv4/IPv6.

- [1] 
https://lore.kernel.org/all/175146824674.1421237.18351246421763677468.stgit@firesoul/#r
- [2] https://elixir.bootlin.com/linux/v7.1.2/source/net/core/gro.c#L477

The long term[3] vision behind the patchset is that xdp_frame becomes
the "mini-SKB" that carries enough offload info to avoid allocating SKBs
in the driver.  The ICE driver is very close to this vision. See [4]
where it calls xdp_build_skb_from_buff() and later fills out SKB fields
with HW offloads (ice_process_skb_fields).

What I'm asking is that we generalize this idea of transferring or
storing HW offloads, that are relevant to the SKB.  My patchset makes
info avail to both xdp_buff and xdp_frame by storing data[5] in the
packet top headroom (extending xdp_frame). And like your patch[6] use
xdp_buff_flags to tell with is active. You patch only needed a single
flag as you only handle CHECKSUM_UNNECESSARY, but Lorenzo's patch also
have CHECKSUM_COMPLETE, for which we need to store a csum.

I cannot remember if it was Kuba or Eric that suggested (at netdevconf)
that instead of using a fixed struct, that I should use the same scheme
as SKB extensions.  We could call it SKB core-extensions, to signal the
possibility to move existing SKB member into this area.

--Jesper

- [3] 
https://lore.kernel.org/all/fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org/
- [4] 
https://elixir.bootlin.com/linux/v7.1.2/source/drivers/net/ethernet/intel/ice/ice_txrx.c#L1044-L1060
- [5] 
https://lore.kernel.org/all/175146829944.1421237.13943404585579626611.stgit@firesoul/
- [6] https://lore.kernel.org/all/20260630191510.81402-1-deliran@verdict.gg/
