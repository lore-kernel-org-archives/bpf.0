Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0219CD0A;
	Thu, 26 Mar 2026 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490091; cv=none; b=JhBC4b3Sgl1uqKr6pB1vUocGoLM2G9EOimzpDMSMjWcMMv/hen00qq1c/Rf31gcn+xnCDyJWEpu4GKaHozaACQ0IinEsoVTIvdjfi/WWIlq/zTUlMEIouNOmL1zfpZ2kDjldTBdTpCcxod6p2AJ/+B/6Y65gqbaMobIqS89fs74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490091; c=relaxed/simple;
	bh=7AsTQq45MWjMVRdEksS9jBff1D31xwz5g9Ys2Ne4jBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=de5vquiy2CrEPYcTIqm/+/kiweBWLP3O/to51N5Z8BXNVoXoOUTjXnZgry91yYNekv0BGpap7oWfilPJyVgYKDi9ebu0gBPoc+Eq5K2J4stNNhF/HZT2/cm3JBBmgkT4EQmam96RqEKbbHvvhWIaJDhpKTbWVrcZFmqipbTahpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BrKSk0q9; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BrKSk0q9"
Message-ID: <4baf0a48-510b-426a-af08-ab668dc96fcf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774490088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aPCyOfTD6u8DlklhyLKO+iXpv4T7cbRNQGqAvTkARI=;
	b=BrKSk0q9fwl5NMwsxVdRxn1ja9XRbpxg1KD7WVAUqLPb88lZYfhfM7JiY/G52Yj6Scatn0
	d/PywLAveqwU3RruOgE0DufGKT4QvuQYcJhGaGotLmoyhUVEIvN0PlGtARNDMcgdlZVkuC
	7bhVfNc8VdOWcbGjQTkknLAXraMgjKs=
Date: Thu, 26 Mar 2026 09:54:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 1/2] bpf: tcp: Reject non-TCP skb in
 bpf_sk_assign_tcp_reqsk()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260323105510.51990-1-jiayuan.chen@linux.dev>
 <20260323105510.51990-2-jiayuan.chen@linux.dev>
 <CAAVpQUDpkro_cA-vP1=L=NhAQ4WDPGdm8nVrUBiooiuji3kXow@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUDpkro_cA-vP1=L=NhAQ4WDPGdm8nVrUBiooiuji3kXow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/26/26 8:04 AM, Kuniyuki Iwashima wrote:
> On Mon, Mar 23, 2026 at 3:55 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> bpf_sk_assign_tcp_reqsk() only validates skb->protocol (L3) but does not
>> check the L4 protocol in the IP header. A BPF program can call this kfunc
>> on a UDP skb with a valid TCP listener socket, which will succeed and
>> attach a TCP reqsk to the UDP skb.
>>
>> When the UDP skb enters the UDP receive path, skb_steal_sock() returns
>> the TCP listener from the reqsk. The UDP code then passes this TCP socket
>> to udp_unicast_rcv_skb() -> __udp_enqueue_schedule_skb(), which casts
>> it to udp_sock and accesses UDP-specific fields at invalid offsets,
>> causing a null pointer dereference and kernel panic:
>>
>>    BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1df0
>>    Read of size 4 at addr 0000000000000008 by task test_progs/537
>>
>>    CPU: 1 UID: 0 PID: 537 Comm: test_progs Not tainted 7.0.0-rc4+ #46 PREEMPT
>>    Call Trace:
>>     <IRQ>
>>     dump_stack_lvl (lib/dump_stack.c:123)
>>     print_report (mm/kasan/report.c:487)
>>     kasan_report (mm/kasan/report.c:597)
>>     __kasan_check_read (mm/kasan/shadow.c:32)
>>     __udp_enqueue_schedule_skb (net/ipv4/udp.c:1719)
>>     udp_queue_rcv_one_skb (net/ipv4/udp.c:2370 net/ipv4/udp.c:2500)
>>     udp_queue_rcv_skb (net/ipv4/udp.c:2532)
>>     udp_unicast_rcv_skb (net/ipv4/udp.c:2684)
>>     __udp4_lib_rcv (net/ipv4/udp.c:2742)
>>     udp_rcv (net/ipv4/udp.c:2937)
>>     ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
>>     ip_local_deliver_finish (./include/linux/rcupdate.h:879 net/ipv4/ip_input.c:242)
>>     ip_local_deliver (net/ipv4/ip_input.c:265)
>>     __netif_receive_skb_one_core (net/core/dev.c:6164 (discriminator 4))
>>     __netif_receive_skb (net/core/dev.c:6280)
>>
>> Fix this by checking the IP header's protocol field in
>> bpf_sk_assign_tcp_reqsk() and rejecting non-TCP skbs with -EINVAL.
>>
>> Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
>> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Thanks, the fix looks good.
> Just curious how you found this, are you trying to use this
> feature for CDN or AI just found it ?
>
Hi Kuniyuki,

Thanks for the review!

While investigating this feature for gateway optimization,
we reviewed the implementation and discovered these bugs.

We haven't deployed this yet, but it's on our roadmap.

