Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE083264D2
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109786; cv=none; b=T5Nq1F9DVLetBHMNIw9fNjULIBcmCYpZt7WxB6kuy/+BNSJ7pc3DYz4OKYwieC1bOlY6MDdajAqAn/Lg4ZtXVGOp2a+Vi+EXS9RZ96PtLetebGmFcRYth/Du+kZ8guMHTqykILJ9yU8HEsq4GS1peFC4i5MExKXtY27rUuWZpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109786; c=relaxed/simple;
	bh=5r13J6OybuNRUXFTInteQCtWxGnSgEkgkKGM9ySWNIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQB8qp4BPUlI+GSBXPy27Zcd92m3Yn7ks9KBPBu09OhIKo/zsJmmDyRKjbkhqxKsJhkZhvAwyJVPNEdAQtdhNg/zBzJOhvRX5xtSzNMYuFjlTNkYTflW+gGz6KoKai5miY2QqeHkzyO0OVSe2AMS/vSYH6C8dq0TaUC5z1zjnCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J4YIKq0s; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J4YIKq0s"
Message-ID: <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775109781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp2Uz55WPBdKd3AM7qNmo54xU5IrnaTOu8LTItTYIug=;
	b=J4YIKq0s4cYP92JAKqv6aRvi6n9JlpQAHEgGtKGWqKyMQ4ruZRQ+s0xty0oQsenkcyAyJm
	6Z0/2DmQL1cdqwnEtlJcvRgt7fm/OlBzPi27EC9RnFUIyJDtrmHBreVstCB54hKY7P6hX8
	XTsMvabMGofpgbRNwIF83N0FnxVPFkQ=
Date: Thu, 2 Apr 2026 14:02:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] udp_bpf: fix use-after-free in udp_bpf_recvmsg()
To: Deepanshu Kartikey <kartikey406@gmail.com>, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: ast@kernel.org, cong.wang@bytedance.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
References: <20260402050928.32946-1-kartikey406@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260402050928.32946-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/2/26 1:09 PM, Deepanshu Kartikey wrote:
> udp_bpf_recvmsg() calls sk_msg_recvmsg() without holding lock_sock(),
> unlike tcp_bpf_recvmsg() which properly acquires lock_sock() before
> calling __sk_msg_recvmsg(). This allows concurrent tasks to race inside
> sk_msg_recvmsg() on the same psock ingress queue, where one task can
> free msg_rx via kfree_sk_msg() while another task is still reading it
> via sk_msg_elem(), causing a slab-use-after-free.
>
> Fix this by adding lock_sock()/release_sock() around the sk_msg_recvmsg()
> path in udp_bpf_recvmsg(), consistent with tcp_bpf_recvmsg(). Also make
> udp_msg_wait_data() release lock_sock() before sleeping and reacquire it
> after waking, so it can be called with the socket lock held, consistent
> with how tcp_msg_wait_data() uses sk_wait_event() which does the same
> internally.
>
> Note: syzbot testing shows a separate pre-existing warning:
>    sk->sk_forward_alloc
>    WARNING: net/ipv4/af_inet.c:162 inet_sock_destruct
> This warning triggers from the idle CPU path (pv_native_safe_halt)
> and is unrelated to this patch. It appears to be a pre-existing
> memory accounting issue in the UDP sockmap path that requires
> separate investigation.
>
>
> Reported-by: syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=431f9a9e3f5227fbb904
> Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>   net/ipv4/udp_bpf.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 9f33b07b1481..f924b255cee6 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -50,7 +50,9 @@ static int udp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>   	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>   	ret = udp_msg_has_data(sk, psock);
>   	if (!ret) {
> +		release_sock(sk);
>   		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);
>   		ret = udp_msg_has_data(sk, psock);
>   	}
>   	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> @@ -79,6 +81,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>   		goto out;
>   	}
>   
> +	lock_sock(sk);
>   msg_bytes_ready:
>   	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
>   	if (!copied) {
> @@ -90,12 +93,14 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>   		if (data) {
>   			if (psock_has_data(psock))
>   				goto msg_bytes_ready;
> +			release_sock(sk);
>   			ret = sk_udp_recvmsg(sk, msg, len, flags);
>   			goto out;
>   		}
>   		copied = -EAGAIN;
>   	}
>   	ret = copied;
> +	release_sock(sk);
>   out:
>   	sk_psock_put(sk, psock);
>   	return ret;

Kuniyuki  is already working on this. Please see the
existing discussion.

https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/


