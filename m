Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD833A6EB
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377057; cv=none; b=VjxfVpyGLWoxJpbpDoE7gk7TmhmywDv4hyiA32UDRKMd7x8m4nBzO4KADVH3EZAQUoBSu8Reky+Q2EybEZAue4yIG/uAPgtqFH2+pyKEGWIm2Z2WSn3oTLn7Hxuv/wuQ4zxszwP5owQZOF5wOzaAFF/jml3jeBKKe4FrKmEaezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377057; c=relaxed/simple;
	bh=CkRrkLNRGh2zCKqsmt+SPMhud/dqY9HlhebCsfTZwIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYhJtCfxKImn7p2+JOUmQrLVrTnyHz0G2i7vr5sYPY4hdB0GkQCELGJVnfQNTo2xs2X1/ah7Dp9R6mrZzFtydPyMqUQW2xt/XHQNmnBQjI958LROrA76pb9XbDk+1O6NDIyY6hAoEqmGVt5LWq3Zeg8LneNT2snv5O7rzW1rl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z8NJKZP7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z8NJKZP7"
Message-ID: <60a0b32d-b02b-419d-9d71-3293261333cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774377053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9fTdPH1aCElwFWRzX6/IMyrZGmyXLUmrj2QhF1Rny8=;
	b=Z8NJKZP7HM7wGHfKLM8Ss8Ax9rDQPBpQYbWcL07MZeQyaZOv2IO9cTyo9gxuocOvQVRXZ7
	xXfOsngesNEjmU2La6z3/JHRpyeiUq2oDdPmK1AhF6mgWipwraJAlFd04xtHSJCLSG/zmp
	9eYQy+0MUyARbKGBLLoYBuInpOinqSc=
Date: Tue, 24 Mar 2026 11:30:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
To: Nick Hudson <nhudson@akamai.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Max Tottenham <mtottenh@akamai.com>, Anna Glasgall <aglasgal@akamai.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-5-nhudson@akamai.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260318134242.2725749-5-nhudson@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/18/26 6:42 AM, Nick Hudson wrote:
> Add checks to require shrink-only decap, reject conflicting decap flag
> combinations, and verify removed length is sufficient for claimed header
> decapsulation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>   net/core/filter.c | 47 +++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7c2871b40fe4..47aec44a9cd3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -56,6 +56,7 @@
>   #include <net/sock_reuseport.h>
>   #include <net/busy_poll.h>
>   #include <net/tcp.h>
> +#include <net/gre.h>
>   #include <net/xfrm.h>
>   #include <net/udp.h>
>   #include <linux/bpf_trace.h>
> @@ -3496,7 +3497,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>   					 BPF_F_ADJ_ROOM_ENCAP_L2( \
>   					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>   
> -#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>   
>   #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
>   					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
> @@ -3743,20 +3746,44 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>   		return -ENOTSUPP;
>   	}
>   
> -	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> +	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {

This change should be done together with the macro refactoring patch 
mentioned in patch 3.

> +		u32 len_decap_min = 0;
> +
>   		if (!shrink)
>   			return -EINVAL;
>   
> -		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
> +		/* Reject mutually exclusive decap flag pairs. */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)

iiuc, this 'if' and the len_min assignment changes below replace the 
existing switch case. Please separate this no-op change from the new 
flag validation logic. It is small enough to be done together in the 
macro refactoring patch also.

> +			return -EINVAL;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
> +			return -EINVAL;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> +			return -EINVAL;
> +
> +		/* Reject mutually exclusive decap tunnel type flags. */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
> +		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +			return -EINVAL;
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> +			len_decap_min += sizeof(struct udphdr);
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +			len_decap_min += sizeof(struct gre_base_hdr);
> +
> +		if (len_diff_abs < len_decap_min)
> +			return -EINVAL;
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
>   			len_min = sizeof(struct iphdr);
> -			break;
> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>   			len_min = sizeof(struct ipv6hdr);
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
>   	}
>   
>   	len_cur = skb->len - skb_network_offset(skb);

