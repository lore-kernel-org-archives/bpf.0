Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E4351C2D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367264; cv=none; b=rHyVoH+BXD3MJXMpy/PkrPAYb6MzkywzrDdMyJ0PeJjFGkKx7COXTOLGEj6NlXdB0wmZSSbM5JLPkIsmuQjafRRX1pc2rq9Mc6VbKvqwvso8oPDpy6FnjvuyumwqtHk1deTXtWRhbfQNnDOUM3DmHmHVNTPSrl8lwUSMlk8GX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367264; c=relaxed/simple;
	bh=wWwnc1fD7B7ogdr99JZMcUfN7ebO7guXwXu26EM+nQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhUGZrSdjmFENNuhnpM/2JdCioWUbIfV1MsF/Z0WkUN2Enj8+2h5PZKYLtvcXf/EDz7hrbG/KeqTQEq0U9IcK2qF7FVoiZZPX0oE5FnWhA103JL2RNPO3w75QcqQWq5zySp9zZK6W5c7bl7FjHu/UD7e9gYd7CdwibVbx99ev5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U0R0CsIp; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U0R0CsIp"
Message-ID: <9a7b8678-2bfd-48fd-83e3-52aa693eb540@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780367260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrffuvfK4t1FtFy20xwpdt6crWuCsSg9rHUJ/9RMZ6M=;
	b=U0R0CsIpwwaer9N9alDAlJNV/r5u+H/+PrpTmhpcS/wj3O5sLqtq5LE9zlrXpiMDiSjgPd
	ZGwEyehO1Usc+bj8AwptHpDuB05fNRHBFurv0DTQ6kmyEYEfWsiH9em5De2CKaIreIASDx
	50jaT0F9JDbMYFB+DWf5wOL0XbM1emI=
Date: Tue, 2 Jun 2026 10:27:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add tests to verify the fix of
 encapsulating VxLAN in lwt
Content-Language: en-US
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
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
 <20260601150203.20352-3-leon.hwang@linux.dev>
 <DIXX90BMJRXM.1XKUMNSDY9OO@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DIXX90BMJRXM.1XKUMNSDY9OO@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/6/26 02:24, Emil Tsalapatis wrote:
> On Mon Jun 1, 2026 at 11:02 AM EDT, Leon Hwang wrote:
[...]
>> @@ -35,6 +38,10 @@
>>  #define IP6_ADDR_SRC IP6_ADDR_1
>>  #define IP6_ADDR_DST IP6_ADDR_4
>>  
>> +/* VxLAN tunnel endpoints, reachable via the bottom route (veth5/6/7/8). */
>> +#define IP4_ADDR_VXLAN  "172.16.17.100"
>> +#define IP6_ADDR_VXLAN  "fb20::1"
> 
> There's a whole series of existing IP definitions at the top of the file, we
> should put those new ones right below them. And fb20 -> fb11 to keep
> with the pattern imo.
> 

Ack.

>> +
>>  /* Setup/topology:
>>   *
>>   *    NS1             NS2             NS3
>> @@ -538,3 +545,160 @@ void test_lwt_ip_encap_ipv4(void)
>>  	if (test__start_subtest("ingress"))
>>  		lwt_ip_encap(IPV4_ENCAP, INGRESS, "");
>>  }
>> +
>> +/*
>> + * VxLAN Setup/topology:
>> + *
>> + * NS1 (IP*_ADDR_1)                NS2                  NS3 (IP*_ADDR_4)
>> + *       [ping src]
>> + *           |                          top route
>> + *         veth1 (LWT encap)  <<-- veth2        veth3  <<-- veth4 (ping dst)
>> + *           |                                                ^
>> + *       (bottom route)                                       | (inner pkt)
>> + *           v                        bottom route            |
>> + *         veth5              -->> veth6        veth7  -->> veth8 (vxlan decap)
>> + *                                                          (IP*_ADDR_VXLAN)
>> + *
> Not sure if this is rendering weird for me but NS2 could be tabbed over
> once more for clarity.
> 

NS2 here is to make sure the LWT-encap VxLAN packets can be routed
correctly like other lwt tests.

>> + * Add the VxLAN endpoint addresses to NS3's veth8, create standard
>> + * VxLAN decap devices bound to those addresses, and install routes so
>> + * NS1/NS2 can reach the endpoints via the bottom route.
>> + */
[...]
>> +fail_close:
>> +	close_netns(nstoken);
>> +fail:
>> +	return -1;
>> +}
>> +
>> +/*
>> + * VxLAN encap tests (IPv4-outer and IPv6-outer variants).
>> + *
>> + * Test 1 - functional: the BPF LWT xmit program encapsulates the packet
>> + *   (protocol=UDP, port=4789) and re-routes it without dropping it.
>> + *   Verified by ping success.
>> + *
>> + * Test 2 - fix verification: after bpf_lwt_push_ip_encap() the
>> + *   skb->transport_header must point at the outer UDP header, i.e.
>> + *   transport_header - network_header == sizeof(outer IP header).
>> + *   Without the fix the transport_header still points at the inner
>> + *   transport layer, giving a wrong (larger) offset.
>> + */
> 
> The Test 2 bullet regurgitates the AI's context, can you rephrase it so
> that it's not framed as a fix but as a test?
> 

Hmm, better to drop this comment, I think.

>> +static void lwt_ip_encap_vxlan(bool ipv4_encap)
>> +{
>> +	char ns1[NETNS_NAME_SIZE] = NETNS_BASE "-1-";
>> +	char ns2[NETNS_NAME_SIZE] = NETNS_BASE "-2-";
>> +	char ns3[NETNS_NAME_SIZE] = NETNS_BASE "-3-";
>> +	const char *sec = ipv4_encap ? "encap_vxlan" : "encap_vxlan6";
[...]
>> +
>> +SEC("encap_vxlan")
>> +int bpf_lwt_encap_vxlan(struct __sk_buff *skb)
>> +{
>> +	struct encap_hdr {
>> +		struct iphdr    iph;
>> +		struct udphdr   udph;
>> +		struct vxlanhdr vxh;
>> +		struct ethhdr   eth;
>> +	} __attribute__((__packed__)) /* packed is required to avoid padding */ hdr;
> 
> Comment is unnecessary here.
> 

Ack.

>> +	int err;
>> +
>> +	memset(&hdr, 0, sizeof(hdr));
>> +
>> +	hdr.iph.ihl      = 5;
>> +	hdr.iph.version  = 4;
>> +	hdr.iph.ttl      = 0x40;
>> +	hdr.iph.protocol = 17; /* IPPROTO_UDP */
>> +	hdr.iph.tot_len  = bpf_htons(skb->len + sizeof(hdr));
>> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>> +	hdr.iph.saddr = 0x640510ac;  /* 172.16.5.100  */
>> +	hdr.iph.daddr = 0x641110ac;  /* 172.16.17.100 */
> 
> Ideally want to keep the addresses we are hardcoding here and the
> the addresses we're declaring in the userspace part in sync. Here
> we've hardcoded the addresses three multiple ways (be, le, and string
> in the userspace part).
> 

I think it's OK to hardcode them here like the gre tests.

>> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>> +	hdr.iph.saddr = 0xac100564;  /* 172.16.5.100 */
>> +	hdr.iph.daddr = 0xac101164;  /* 172.16.17.100 */
>> +#else
>> +#error "Fix your compiler's __BYTE_ORDER__?!"
>> +#endif
>> +
>> +	hdr.udph.source = bpf_htons(VXLAN_PORT);
>> +	hdr.udph.dest   = bpf_htons(VXLAN_PORT);
>> +	hdr.udph.len    = bpf_htons(skb->len + sizeof(hdr.udph) + sizeof(hdr.vxh) +
>> +				    sizeof(hdr.eth));
>> +
>> +	hdr.vxh.vx_flags = bpf_htonl(VXLAN_FLAGS);
>> +	hdr.vxh.vx_vni   = bpf_htonl(VXLAN_VNI << 8);
>> +
>> +	__builtin_memcpy(hdr.eth.h_dest, bcast, ETH_ALEN);
>> +	__builtin_memcpy(hdr.eth.h_source, srcmac, ETH_ALEN);
>> +	hdr.eth.h_proto = bpf_htons(ETH_P_IP);
>> +
>> +	err = bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &hdr, sizeof(hdr));
>> +	if (err)
>> +		return BPF_DROP;
>> +
>> +	return BPF_LWT_REROUTE;
>> +}
>> +
>> +SEC("encap_vxlan6")
>> +int bpf_lwt_encap_vxlan6(struct __sk_buff *skb)
>> +{
>> +	struct encap_hdr {
>> +		struct ipv6hdr  ip6hdr;
>> +		struct udphdr   udph;
>> +		struct vxlanhdr vxh;
>> +		struct ethhdr   eth;
>> +	} __attribute__((__packed__)) /* packed is required to avoid padding */ hdr;

Will drop the comment.

>> +	int err;
>> +
[...]
>> +	return BPF_LWT_REROUTE;
>> +}
>> +
>>  char _license[] SEC("license") = "GPL";
>> diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c
> 
> We definitely need to change the name here this is straight from the AI.
> 

Will fold it into test_lwt_ip_encap.c to avoid creating a new file.

>> new file mode 100644
>> index 000000000000..6945f83b94f2
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_core_read.h>
>> +
>> +#define NEXTHDR_UDP		17	/* UDP message. */
> 
> Unnecessary, we hardcode 17 in the other test.
> 

Ack.

Thanks,
Leon

[...]

