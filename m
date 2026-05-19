Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8923395E
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186689; cv=none; b=Hlcu2ZFGML8UtUX7kPDw/DGsVFPfF9v5kXaUN1Es5HxqK3bayx5W/6K77xIiIYz78AHua99ETYH1netOhwhJkOuhIT/2slkWGJcWHo/S+yiB+4WjSQyKmJvfcND382Ioptt0Pyi+nPObMquqTpfl7O8a5O5wSV4BFCecwnTjTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186689; c=relaxed/simple;
	bh=6HIR7Q4pB6PFCdXGL3eLp/n+DechocWPILOr0WfivCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNEqdFzImKQOzrbdsFOjxGBD8bD+AyR7QnB3gw1B2JBl+RehxPKadV9Q/CfdVUcZhKz+gxxVW8MSvO2whYhYrfryTiaac4/zoRFNK1k690mska6J9UqrhSWxabx6ctLGs0MRPjCcVgQ4QIkDoRvuqeQyEUmLGq4bYXePdLifjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ug1qLetC; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ug1qLetC"
Message-ID: <cade9c21-ddef-44da-bcf5-74b274f657b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779186675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHwZRedyWWVWgO8xphRxOuzhCaXmhiFbfqD2vY158R8=;
	b=Ug1qLetCDgE0Q8CGYN/HA1QOWYX82Qovjy48SpoOJ7TcVqlfaqcarDsuVilhrLsJ+sEk/l
	nPCuJV/pG0TBdCNgO6Ax/UaKk3mLTCT4n1lNLMK2J7HHkv9t85tHtW5Evb2LjFMS8HVupT
	pnPC5T6GQqQtmux0VvZxLtiEn5v8cQo=
Date: Tue, 19 May 2026 18:31:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: sashiko-reviews@lists.linux.dev, Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260518082344.96647-6-kerneljasonxing@gmail.com>
 <20260519082514.AD96BC2BCC6@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260519082514.AD96BC2BCC6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/19/26 4:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] BPF sock_ops hook is called without holding the socket lock, violating core locking rules and risking data corruption.
> - [Medium] Missing BPF RX timestamping for zero-copy receive (tcp_zerocopy_receive).
> - [Medium] MSG_PEEK causes event duplication, corrupting BPF statistics.
> - [Medium] Data race due to lockless read of sk->sk_bpf_cb_flags.
> --
>
> commit bdfc9a5e79a8f2a8060029cde75cfb38b923754a
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> bpf: enable bpf timestamping rx in TCP layer
>
> This commit introduces BPF RX timestamping for TCP by adding a BPF hook
> to tcp_recvmsg(). It evaluates timestamping flags and conditionally
> calls bpf_skops_rx_timestamping().
>
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 21ece4c716121..64c69bb3578af 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
>>   	release_sock(sk);
>>   
>>   	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
>> -		if (cmsg_flags & TCP_CMSG_TS)
>> -			tcp_recv_timestamp(msg, sk, &tss);
>> +		if (cmsg_flags & TCP_CMSG_TS) {
>> +			u32 tsflags = READ_ONCE(sk->sk_tsflags);
>> +
>> +			if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>> +			    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
> Since the socket lock was released above, is it safe to read
> sk->sk_bpf_cb_flags here without READ_ONCE()? It appears
> bpf_sock_ops_cb_flags_set() could modify this concurrently, potentially
> causing a data race.
>
>> +				bpf_skops_rx_timestamping(sk, &tss,
>> +							  BPF_SOCK_OPS_TSTAMP_RCV_CB);
> Does executing the BPF_PROG_TYPE_SOCK_OPS program here without holding the
> socket lock risk data races? Since the program receives a full socket
> context and can call helpers like bpf_setsockopt(), this might trigger
> assertions in sock_owned_by_me(sk) or corrupt socket state.


For this point above, I think it's not true since 
bpf_sock_ops_setsockopt will return EOPNOTSUPP when

bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB


>
> If MSG_PEEK is passed in the flags, will this cause the BPF program to be
> invoked multiple times for the same skb? The callback doesn't seem to
> receive arguments indicating a peek, which might artificially inflate packet
> counts and skew latency metrics.
>
>> +			if (sock_flag(sk, SOCK_RCVTSTAMP) ||
>> +			    tsflags & SOF_TIMESTAMPING_SOFTWARE ||
>> +			    tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
>> +				tcp_recv_timestamp(msg, sk, &tss);
> Will packets processed via the zero-copy receive path miss these RX
> timestamp events? High-performance applications using tcp_zerocopy_receive()
> go through tcp_zc_finalize_rx_tstamp(), which directly calls
> tcp_recv_timestamp() but seems to omit this new BPF callback.
>
>> +		}
>>   		if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
>>   			msg->msg_inq = tcp_inq_hint(sk);
>>   			if (cmsg_flags & TCP_CMSG_INQ)
