Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084052797AC
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774404237; cv=none; b=avYYmpn/TMM9Dds/guZ688gpcjfxv9qJs5y3LVcHx/pGUfTh1M2HsnxaynZ1hZzhXFGzLueYv60qywL47KpdbtxQVClvLB2cqUYW7RhiGFGvMucG5Q+7Lejbtpj/hRPI0MmxcANKRsB0FHyiCeQ4mj8yhgXNaLCzoTpxC9EbX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774404237; c=relaxed/simple;
	bh=FBj2k2onSYkiwjhaLRfcgj6oQDXAwjnNmWP90B5dd2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvJFTiv9jFL/gGJCfY6Bu2AtO9CygOBbkyFZlqnUqn8jHlJ7ZBh+SeON/XVsH71dH3cCfU1wBx0zfOypF6G4Yzm8AJESglWdzjtFIuf34mr720YmckxnQtQIlwH4CioWCb4E+Wqi1wLR1b5GvY03ImPv1LYnqUcAmA1UvJzRXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FW6+c/Jh; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FW6+c/Jh"
Message-ID: <3ced5df7-eae7-429c-ae4b-997c8e0757a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774404234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ6L7c17NwUK0cThq8qvVRNBfwezsgTcXadk51qOIX0=;
	b=FW6+c/JhlVJ71xjNdi5liTuY1+UYVNzs3qc5QyaGhNQOl0mcHMOmVX/ppUPT7bhetl6RPP
	hmEX0AyyCM5n+S1x0i8ZQtkEI9x5cTo3h/R146FsqceCjzWt8aOKM8rUfTfoMJ8lVbYczx
	E1sscW613hq/NC0EyCVV4TmlKRlIA4Q=
Date: Wed, 25 Mar 2026 10:03:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add protocol check test for
 bpf_sk_assign_tcp_reqsk()
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>, Eric Dumazet <edumazet@google.com>
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260323105510.51990-1-jiayuan.chen@linux.dev>
 <20260323105510.51990-3-jiayuan.chen@linux.dev>
 <9adc3c2e-0d5a-4863-b3ed-194d8f9fd630@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <9adc3c2e-0d5a-4863-b3ed-194d8f9fd630@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/25/26 5:59 AM, Martin KaFai Lau wrote:
> On 3/23/26 3:54 AM, Jiayuan Chen wrote:
>> +void test_tcp_custom_syncookie_protocol_check(void)
>> +{
>> +    struct test_tcp_custom_syncookie *skel;
>> +    struct sockaddr_in tcp_addr, udp_addr;
>> +    socklen_t addr_len = sizeof(tcp_addr);
>> +    int tcp_server = -1, udp_client = -1;
>> +    char buf[32] = "test";
>> +    int ret;
>> +
>> +    if (setup_netns())
>> +        return;
>> +
>> +    skel = test_tcp_custom_syncookie__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +        return;
>>   +    /* Create a TCP listener so the BPF can find a LISTEN socket */
>> +    tcp_server = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
>> +    if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
>> +        goto destroy_skel;
>> +
>> +    ret = getsockname(tcp_server, (struct sockaddr *)&tcp_addr, 
>> &addr_len);
>> +    if (!ASSERT_OK(ret, "getsockname"))
>> +        goto close_tcp;
>> +
>> +    skel->bss->tcp_listener_port = ntohs(tcp_addr.sin_port);
>> +    skel->bss->udp_test_port = 9999;
>> +
>> +    ret = bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto);
>> +    if (setup_tc(ret))
>> +        goto close_tcp;
>> +
>> +    udp_client = socket(AF_INET, SOCK_DGRAM, 0);
>> +    if (!ASSERT_NEQ(udp_client, -1, "udp socket"))
>> +        goto cleanup_tc;
>> +
>> +    memset(&udp_addr, 0, sizeof(udp_addr));
>> +    udp_addr.sin_family = AF_INET;
>> +    udp_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
>> +    udp_addr.sin_port = htons(9999);
>> +
>> +    ret = sendto(udp_client, buf, sizeof(buf), 0,
>> +             (struct sockaddr *)&udp_addr, sizeof(udp_addr));
>> +    ASSERT_EQ(ret, sizeof(buf), "sendto udp");
>> +
>> +    /* Wait for TC ingress BPF to process the skb. */
>> +    kern_sync_rcu();
>
> hmm... is it guaranteed to work? Regardless, it checks the error 
> returned from bpf_sk_assign_tcp_reqsk(). Maybe bpf_prog_test_run is 
> simpler?
>
> pw-bot: cr
>


Hi Martin,

Thanks for your suggestion.

The intent of using the real network stack was to demonstrate the
actual null-ptr-deref panic, so reviewers can better understand the
issue. Once we agree the root cause is the missing protocol check in
bpf_sk_assign_tcp_reqsk(), switching to bpf_prog_test_run to just
validate the return value makes sense.


