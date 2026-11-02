Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622758;
	b=JwsPjpsDNtPKwaO1bxja2hj9NcKuvxRDykRbU60V/o7bev0j+fOD1pn2QJ6bjfVWT+lJ
	 ChM+uZ1QOXUKLF0aN5TNZkdRyXLfIFa7k7n0/470AAlJsOcnONfaQET82O+0/DyuB3qmN
	 WZJ2BnEiCUX1flXgeqDzyRn5MZyKW6CLN9YY64GHKpQ6Td54kJPb/J+eiFfpT8ibpr9wu
	 VH3mLueAnsq+jUMGe9gZeo5ut676cIsgBz3r24Dot+0fUQDexyIGOLPhF6ZjTfHfkkVOY
	 eOHTmqc+EBFq6SqkVaXBTYk/wweUh+2oQo6Ca9QWUAZWVv7t10KpA/4gvY0BNOaMwqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622758;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=w6jqiUBD5ibgJFs0ugALEEDB7b768frs2A7MQ2xTHQM=;
	b=XSp8A0K2MjFRcAtahp3uPZN78pfEu8wT5tx9y37++zJoPpUyGW0uX+8VHm8STHZjWzKj
	 mWOdtSlCBNgr6GU66i0bOEcOPbGC0DrvfV1GsBNHyzwYQd4iCyNgTAuEInM4f6okb+OtU
	 ACBiOkmtIX0Jq88qFT3O/ZnKD4T6OeTkdWJf/76PO5RbKzwlxdwH+nz1Ts2GnrdQAGelP
	 4c5kUuIbT16gGsGfO+PTqxeiEUb/J4jRgYKcUJDL38lQBBIPgh3AimJs5pvfCS+KSMd4F
	 phLma02/PN+lq3AGIe62YHKxpT+GUzbabXMa7+UeV2vOGBhfUx58Dx7NgCV3GjqG+9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cL9ESvBY;
	arc=none smtp.remote-ip=95.215.58.151
Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76568606A339
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76568606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cL9ESvBY
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SiiP3R6iGc96rRdu87RGjK9ajivgC01xWOp9SC3ZPUw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793622754; v=1; x=1794227554;
 b=cL9ESvBYAL63kpZebLoC7cMqDXiUTe+XViIZ37bDaSZ1Q0a0JYe1iNSmZibWd9qWMknh82ox
 +sJiP+jk4U4LQOo4MKjH4kFkR/e3J8KhK1a8fMaCfur/n4+t6U8TYvgWeqAbtbaXIgi/RG7n2Nn
 IgCgEQpNcYUnpO4gLchGeCIA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b39a93dc725c8c73;
	Mon, 02 Nov 2026 12:32:34 +0000
X-Mizu-Trace-ID: b39a93dc725c8c73
X-Migadu-Flow: FLOW_OUT
Message-ID: <69e66c9c-f2ab-41a7-972d-d1562a6387b8@linux.dev>
Date: Mon, 2 Nov 2026 20:32:24 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an egress
 redirect before each send
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> tcp_sendmsg_locked() expects a caller that has the socket open. It uses
> sk->sk_socket and the wait queue sk->sk_wq. For an egress redirect of an
> sk_msg prog the sender calls it on the target without a reference to the
> target's file. Both pointers are NULL before accept() and after close().
> close() can occur while the sender sleeps. Then the kernel crashes.
>
> Fail the redirect when the target has no struct socket, or when the sender
> has to wait for the connection. The error is EINVAL. After close() it is
> EPIPE, as today. sk_stream_wait_connect() calls remove_wait_queue() without
> a test of SOCK_DEAD. sk_stream_wait_memory() has this test, but it can
> still use sk_wq after the sleep. This patch does not change that. The
> target can change while the sender sleeps there. Thus do both checks before
> each call of tcp_sendmsg_locked(). Clear MSG_FASTOPEN, so that the sender
> does not call the connect code of the target, which uses both pointers.
>
> Today the sender can send before accept() and waits in SYN_SENT. send()
> with MSG_FASTOPEN sends the data. Today it fails with EISCONN. When the
> redirect of a cork fails, send() returns success and the kernel drops the
> data, as today.
>
> The Fixes tags are for the two checks and for MSG_FASTOPEN, in this order.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
> Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  net/ipv4/tcp_bpf.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index fd443350f9b8..ef2e15de0fe3 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -88,6 +88,24 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
>  	return ret;
>  }
>  
> +/*
> + * The target of a redirect belongs to somebody else. A child that nobody has
> + * accepted yet, and an orphan, have no struct socket and no wait queue.
> + * tcp_sendmsg_locked() needs both. See sendmsg_locked() in skbuff.c.
> + * The sender holds no reference to the file of the target, which can be closed
> + * whenever tcp_sendmsg_locked() sleeps. sk_stream_wait_connect() and
> + * inet_wait_for_connect() go back to the wait queue when they wake up, so the
> + * sender must not wait for a connect.
> + */
> +static bool tcp_bpf_redir_allowed(const struct sock *sk)
> +{
> +	if (!sk->sk_socket)
> +		return false;
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return tcp_passive_fastopen(sk);
> +	return true;
> +}
> +
>  static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
>  			int flags, bool uncharge)
>  {
> @@ -109,6 +127,10 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
>  		page = sg_page(sge);
>  
>  retry:
> +		/* Only a redirect sends data which is not charged to sk */
> +		if (!uncharge && unlikely(!tcp_bpf_redir_allowed(sk)))
> +			return sock_flag(sk, SOCK_DEAD) ? -EPIPE : -EINVAL;
> +


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

I can trigger it by redirecting data to a non-accept sk.

==================================================================
BUG: KASAN: null-ptr-deref in tcp_sendmsg_locked+0xfb8/0x4550
Write of size 8 at addr 0000000000000008 by task repro/488
Tainted: [W]=WARN
Call Trace:
 <TASK>
 dump_stack_lvl+0x91/0xf0
 print_report+0x442/0x630
 kasan_report+0xf3/0x130
 kasan_check_range+0x11c/0x200
 __kasan_check_write+0x14/0x30
 tcp_sendmsg_locked+0xfb8/0x4550
 tcp_bpf_push+0x3d0/0xbc0
 tcp_bpf_sendmsg_redir+0x639/0x1050
 tcp_bpf_sendmsg+0xa32/0x1b90
 inet_sendmsg+0xdf/0x100
 __sys_sendto+0x3ed/0x4f0
 __x64_sys_sendto+0xe0/0x1b0
 x64_sys_call+0x1375/0x27e0
 do_syscall_64+0xe5/0x610


