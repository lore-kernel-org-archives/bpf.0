Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A432C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432BA20850
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDKVIm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:08:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:58102 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKVIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 17:08:42 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEgvt-0001v9-IP; Thu, 11 Apr 2019 23:08:29 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEgvt-0004cM-AE; Thu, 11 Apr 2019 23:08:29 +0200
Subject: Re: [PATCH v3 bpf-next 2/4] bpf: add layer 2 encap support to
 bpf_skb_adjust_room
To:     Alan Maguire <alan.maguire@oracle.com>, willemb@google.com,
        ast@kernel.org, davem@davemloft.net, shuah@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        quentin.monnet@netronome.com, john.fastabend@gmail.com,
        rdna@fb.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
References: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
 <1554818803-4070-3-git-send-email-alan.maguire@oracle.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <12f9cef4-f5ff-78a4-ec0f-42f737696735@iogearbox.net>
Date:   Thu, 11 Apr 2019 23:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1554818803-4070-3-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25416/Thu Apr 11 09:55:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/09/2019 04:06 PM, Alan Maguire wrote:
> commit 868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
> introduced support to bpf_skb_adjust_room for GSO-friendly GRE
> and UDP encapsulation.
> 
> For GSO to work for skbs, the inner headers (mac and network) need to
> be marked.  For L3 encapsulation using bpf_skb_adjust_room, the mac
> and network headers are identical.  Here we provide a way of specifying
> the inner mac header length for cases where L2 encap is desired.  Such
> an approach can support encapsulated ethernet headers, MPLS headers etc.
> For example to convert from a packet of form [eth][ip][tcp] to
> [eth][ip][udp][inner mac][ip][tcp], something like the following could
> be done:
> 
> 	headroom = sizeof(iph) + sizeof(struct udphdr) + inner_maclen;
> 
> 	ret = bpf_skb_adjust_room(skb, headroom, BPF_ADJ_ROOM_MAC,
> 				  BPF_F_ADJ_ROOM_ENCAP_L4_UDP |
> 				  BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 |
> 				  BPF_F_ADJ_ROOM_ENCAP_L2(inner_maclen));
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/uapi/linux/bpf.h | 10 ++++++++++
>  net/core/filter.c        | 12 ++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 8370245..912391c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1500,6 +1500,10 @@ struct bpf_stack_build_id {
>   *		* **BPF_F_ADJ_ROOM_ENCAP_L4_UDP **:
>   *		  Use with ENCAP_L3 flags to further specify the tunnel type.
>   *
> + *		* **BPF_F_ADJ_ROOM_ENCAP_L2(len) **:
> + *		  Use with ENCAP_L3/L4 flags to further specify the tunnel
> + *		  type; **len** is the length of the inner MAC header.
> + *
>   * 		A call to this helper is susceptible to change the underlaying
>   * 		packet buffer. Therefore, at load time, all checks on pointers
>   * 		previously done by the verifier are invalidated and must be
> @@ -2641,10 +2645,16 @@ enum bpf_func_id {
>  /* BPF_FUNC_skb_adjust_room flags. */
>  #define BPF_F_ADJ_ROOM_FIXED_GSO	(1ULL << 0)
>  
> +#define	BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
> +#define	BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56

Would appreciate a small whitespace cleanup in that tab after the define
is replaced with a normal space like in the rest of the file.

>  #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	(1ULL << 1)
>  #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	(1ULL << 2)
>  #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
>  #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
> +#define	BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
> +					  BPF_ADJ_ROOM_ENCAP_L2_MASK) \
> +					 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)

Ditto here.

>  /* Mode for BPF_FUNC_skb_adjust_room helper. */
>  enum bpf_adj_room_mode {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 22eb2ed..a1654ef62 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2969,11 +2969,14 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>  #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
> -					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP)
> +					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
> +					 BPF_F_ADJ_ROOM_ENCAP_L2( \
> +					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>  
>  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  			    u64 flags)
>  {

One thing that it seems missing in this but also in Willem's earlier set
is that we reject these flags in bpf_skb_net_shrink(). Both are called from
bpf_skb_adjust_room(), so if we don't support decap yet we should reject
such flags so we can extend in future. Could you or Willem send a follow-up?
Thanks!

> +	u8 inner_mac_len = flags >> BPF_ADJ_ROOM_ENCAP_L2_SHIFT;
>  	bool encap = flags & BPF_F_ADJ_ROOM_ENCAP_L3_MASK;
>  	u16 mac_len = 0, inner_net = 0, inner_trans = 0;
>  	unsigned int gso_type = SKB_GSO_DODGY;
> @@ -3008,6 +3011,8 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  
>  		mac_len = skb->network_header - skb->mac_header;
>  		inner_net = skb->network_header;
> +		if (inner_mac_len > len_diff)
> +			return -EINVAL;
>  		inner_trans = skb->transport_header;
>  	}
>  
> @@ -3016,8 +3021,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  		return ret;
>  
>  	if (encap) {
> -		/* inner mac == inner_net on l3 encap */
> -		skb->inner_mac_header = inner_net;
> +		skb->inner_mac_header = inner_net - inner_mac_len;
>  		skb->inner_network_header = inner_net;
>  		skb->inner_transport_header = inner_trans;
>  		skb_set_inner_protocol(skb, skb->protocol);
> @@ -3031,7 +3035,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  			gso_type |= SKB_GSO_GRE;
>  		else if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
>  			gso_type |= SKB_GSO_IPXIP6;
> -		else
> +		else if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
>  			gso_type |= SKB_GSO_IPXIP4;
>  
>  		if (flags & BPF_F_ADJ_ROOM_ENCAP_L4_GRE ||
> 

