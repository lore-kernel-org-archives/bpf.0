Received: from mta1.migadu.com (out-148.mta1.migadu.com [95.215.58.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35085415F06
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530021; cv=none; b=PUfrL5YqNGWTlponB6BhehFCOIKa0/2Fe1zW+Igd41tiTB2jOOMpdgVeUogb2oxx4b4Sa8BKDfFuSwf79Ug0nxhhP9RZzGfkdyTTPobqWUFmSo3Mi2kdzalx9lcGU7jje75uK8rUIj9YQgbiYiqUU/DG9rtSM5Pzw+8NDXGmH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530021; c=relaxed/simple;
	bh=AKKz4R62gWjxKFK3x26tK+HQQR/t32whLyvbOTQp0gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUeUvPr2QkzNyidNFPSL4NY5rHvUY/OAAEx/HTT5Lw1J3gGl/Kt15Mbz7HbxdMzYNb/AIvXMRiH1pFJ10YmCbX8QzObYR/34AmGiGYnjcz5mjooraIBwboVBQGfz3zS0v47AL0jBNI5iM/mCNg3b+lr5b1wGrTvfXFQhmLG4Ubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MkxhGN0Q; arc=none smtp.client-ip=95.215.58.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MkxhGN0Q"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AKKz4R62gWjxKFK3x26tK+HQQR/t32whLyvbOTQp0gc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786530017; v=1; x=1787134817;
 b=MkxhGN0QzPgGHvHGigQAP4Nrrlp44NRjEoH/RqAc51n+jlnotQ6+2UPKB02QXUkcPR18FRl1
 P5DyzS/e7jlnvSbnavrGVDFQ9uXOPFQBE4paVSjnywBoP8fmkm5hSlN94yhsazsn8zRcK6zPJmU
 R+12nCkIj6gipvdZuZ+Jd2Hs=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id 4e831d1d3b8922a3;
	Wed, 12 Aug 2026 10:20:17 +0000
X-Migadu-Scanner: mta11.migadu.com
Authentication-Results: mta11.migadu.com;
	none
Message-ID: <9e2313ac-ea90-4911-9fc3-9581ec44bafd@linux.dev>
Date: Wed, 12 Aug 2026 18:20:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: bpf: WARNING in skb_vlan_push from TC BPF action
To: Kenneth Lee <kennethbwlee@snu.ac.kr>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
 john.fastabend@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, sdf@fomichev.me, yonghong.song@linux.dev,
 rhkrqnwk98@gmail.com
References: <20260812043643.808295-1-kennethbwlee@snu.ac.kr>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260812043643.808295-1-kennethbwlee@snu.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/12/26 12:36 PM, Kenneth Lee wrote:
> Hi,
>
> While fuzzing, the following warning has been found by a custom fuzzer
> developed by Sechang Lim <rhkrqnwk98@gmail.com>:
>
>    skb_vlan_push got skb with skb->data not at mac header (offset 14)


I think we didn't handle skb correctly when xdp prog is attached to L3 
device.

bpf_prog_run_generic_xdp:

     if ((orig_eth_type != eth->h_proto) ||
         (orig_host != ether_addr_equal_64bits(eth->h_dest,
                           skb->dev->dev_addr)) ||
         (orig_bcast != is_multicast_ether_addr_64bits(eth->h_dest))) {
         __skb_push(skb, ETH_HLEN); >>>>>>>> for L3 dev, mac_len is zero 
but now we have L2 area
         skb->pkt_type = PACKET_HOST;
         skb->protocol = eth_type_trans(skb, skb->dev); >>>>>>>> mac_len 
is still 0 but mac_header = data - 14
     }


TC:

__skb_push(skb, skb->mac_len)  >>> try to pointer data to mac header but 
it is pointless since mac_len is 0


int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci)
{
     if (skb_vlan_tag_present(skb)) {
             int offset = skb->data - skb_mac_header(skb); >>>>>>>> 
offset should be 0 because we want data pointer to mac_header is 14
             if (WARN_ONCE(offset, "...offset %d\n", offset))
                     return -EINVAL;
             ...
     }
     return 0;
}


> Unfortunately, we haven't found a reproducer for the warning yet. We'll
> inform you if we have any update on the warning.


Could you check whether the fuzzing log contains any XDP-related operations?


