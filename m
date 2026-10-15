Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37A541444;
	Thu, 15 Oct 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084066; cv=none; b=ijmpQfCFxxAFVoR3UnaK8MJu5kIm3SexjJi2qNP0g1+YCKj7mPGeP0+EH64pg3IbQ0FoTdACVSqFMIhue9wEG3/iBln5Vro2bGsBBdLzmH2BgkblPugTzN9NVCFjPATFbk1viWb8O03ScaMTK26wUHJLV21v+66UkKzemNTXWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084066; c=relaxed/simple;
	bh=Rq4rz8ejG4MzNUFw2LynldTsZt0A4pwMuMglCCBru1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIT3jB4ZLuW7gl7Vx85V+evx0L4QkiGn0rg7q1hG646obMtsNu2C38B0Wv7fpvizdVYA2tKmMGqYXsgL/BRslHgXJeHE9eZLlGrt8PIUoGb+fu+Rf7OlZGF4UsgP9o175r1VpMCr+/QbCPZagPk+ZD+NrEuD9B5S85MNntQ+v9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qihKUJuQ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qihKUJuQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+5NkBZFtpa5VrgsGwb1KrVE2QUF4HGyypdi0JGeLIZs=; b=qihKUJuQxoagOGyM4ypddrq/9k
	pE5orJdNiwal9Os/IU/NF19LeMxmNFJCcFUq+9rERYDj9kgGQul/zgi6cXMBeOel9BQLk8hZ6DEPX
	9W8/xYT3uU1hr6St/EF2CuuRgJSVPHi4shbHNAtzLh29EiWs12v8IRIiPvPKGSx4fxcO4I6QOeRhn
	7d46p39aa9gsiaZCE/xRohnvXUcNnT2h/8+8UMIAy5/PcYx5YBh7JH3UyK7lL+/E0NIZRyRxDna95
	smBGQQF+zR8u1G9gxX9keBZUF/1Y/9/VkDnco01me1HQ+FvSQq+tS66ykgFR+D9qV/ncpuECDyvix
	GFRpBcvQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHOvU-0001r6-02;
	Thu, 15 Oct 2026 19:07:32 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHOvS-0005nx-2c;
	Thu, 15 Oct 2026 19:07:30 +0200
Message-ID: <c1492f78-5229-4cc1-b4f6-691199a0e521@iogearbox.net>
Date: Thu, 15 Oct 2026 19:07:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Record only the test ICMP echo in
 tc8 of tc_netkit_scrub
To: Qiliang Yuan <odys.yuan@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009-selftests-bpf-tc-netkit-scrub-v1-1-f46c07a40e7c@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261009-selftests-bpf-tc-netkit-scrub-v1-1-f46c07a40e7c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28154/Thu Oct 15 08:24:22 2026)

On 10/9/26 3:49 AM, Qiliang Yuan wrote:
> tc_netkit_scrub attaches tc8 to the primary netkit device, sends an ICMP
> echo with a mark and a priority through it, and checks the mark and the
> priority that tc8 saw against what the scrub mode lets through.
> 
> tc8 records the mark and priority of every packet it sees, and the
> device also carries what the system sends on its own once the device
> is up, like IPv6 neighbor discovery or the mDNS of avahi-daemon. When
> such a packet goes out after the echo, it overwrites what tc8 recorded,
> and the test finds a mark and a priority of 0.
> 
> Record only IPv4 ICMP packets in tc8.
> 
> Fixes: 716fa7dadf11 ("selftests/bpf: Extend netkit tests to validate skb meta data")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>   tools/testing/selftests/bpf/progs/test_tc_link.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
> index 630f12e51b075..3c44ee06cfae8 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_link.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
> @@ -4,6 +4,8 @@
>   
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
> +#include <linux/in.h>
> +#include <linux/ip.h>
>   #include <linux/stddef.h>
>   #include <linux/if_packet.h>
>   #include <bpf/bpf_endian.h>
> @@ -119,6 +121,14 @@ SEC("tc/egress")
>   int tc8(struct __sk_buff *skb)
>   {
>   	struct net_device *dev = BPF_CORE_READ((struct sk_buff *)skb, dev);
> +	__u8 proto;
> +
> +	/* Look only at the ICMP echo of the test, not at IPv6 ND or mDNS */
> +	if (skb->protocol != bpf_htons(ETH_P_IP) ||
> +	    bpf_skb_load_bytes(skb, sizeof(struct ethhdr) + offsetof(struct iphdr, protocol),
> +			       &proto, sizeof(proto)) ||
> +	    proto != IPPROTO_ICMP)
> +		return TCX_PASS;
>   
>   	seen_tc8 = true;
>   	mark = skb->mark;
Could you streamline this a bit to be more in existing style?
__bpf_constant_htons, and make the checks/error paths similar.

Thanks,
Daniel
