Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B61F0E34
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495520; cv=none; b=tud8wKEmkV+mdF6nztCUND2zsDg0mIzKds1McHUhklL1W+PpvUcYFrM1hCIK0UVMNPvOQ2ZDpHrOJpC1022VtbZJcWnin6V5Pl7TdiKlK2lxSwyYlhIeUK4EYv7D0DjdHKvEV0mL8beKhVOedp5q8kyyOkjFV9ijx5EoN+LDhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495520; c=relaxed/simple;
	bh=PeO3Wn4eC2AsM7MoyTFPPR2RxQrGibPXKvXagwq9jD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGZNTuPIKALxNYzkBETFdRmtl15ba29Im2SHdMH22BGL5wvIX87fk+54UlUK+D1ZbMcREExvU1zuqAl4opmK/tv7mc+b00jYUypL4vgoewezb5YIuZ8/ePeaZFiSQt3sxXF4iidBhtd0QaBj6YkbP5j9Gvyqq9K3I2HiRTQYSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=auY2R3sw; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="auY2R3sw"
Message-ID: <4c27a461-2714-4c27-8604-dedd506a09aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774495506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNdfjJHD6SMD9Xw8BJ+zCQWvHXfF4m3AH/8ikcFZoxY=;
	b=auY2R3swKFmiQYJ62EhZeIZ6lJgq+hhn4f8D4apQgKw3hvmi8awSu9dy5bBPhVf1PseunR
	Bf14bYgKDDOiMNz9HrgunVljUnXDZ/QWZHVfptyhd8vBoV8P/D+2pfg3Jzfk43UPDVM1Pm
	JY1JwnQOPI2JXs2PC41PuCSNh9gyV2k=
Date: Thu, 26 Mar 2026 11:24:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add protocol check test for
 bpf_sk_assign_tcp_reqsk()
To: Martin KaFai Lau <martin.lau@linux.dev>
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
>> +
>>
I looked into using bpf_prog_test_run, but it won't work here
because bpf_sk_assign_tcp_reqsk() requires the skb to come from TC ingress
— it checks skb_at_tc_ingress() internally and returns -EINVAL otherwise.

For the synchronization concern, instead of kern_sync_rcu(), I now create
a UDP server bound to the target port and recv() the packet after sendto().
Since the BPF program returns TC_ACT_OK, the packet passes through TC 
ingress
and arrives at the UDP socket. The recv() naturally blocks until the BPF 
program
has finished processing, so no timing tricks are needed.

