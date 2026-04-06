Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928538E5E6;
	Mon,  6 Apr 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505199; cv=none; b=KkVZmiYF1jQncSbDv76B47St/Ac8e4+zjULmJ3rXXE3h2/odox7ht5I6+hx2l5ep6zHPoi/3FefgZfcn5B2ZeJyEjOBXYGogghAYoxcbvkQrK63HQUQ/S4wVwINRm5SJkFFOq+EtpDAHDPZ2j7t8606OGKIR6u2qu8pZ4fvb6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505199; c=relaxed/simple;
	bh=eouATSlX8G6NY+XWDHTk7j04brbeOYKRBaUKpumKmWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/0/NozVhha8VKgxjtj9n20I+A+agZvcdKGbEbL7AB3sXGMVSqU8AYaIl//ruwUTqcguJ7YGs2MXKX5KiMw4NaNJ8+zcSmFGHQFxIcit0/Rw2kP8UP0mm+39flv33Mh5XmP6k0TUZA09sEiDJ/sn+ZrYgXFQtJcqUYnaftybaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ck9qypBU; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ck9qypBU"
Date: Mon, 6 Apr 2026 12:53:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775505196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXovqCnmzrS4eafaIE4xviHOkrXx/YXiMKIkCRxRFy8=;
	b=Ck9qypBUUeubWrUPGT1KdtemkqhN1WZ44o57VDvfufj1WmgJt5zaTSzQ4Kk+PjofRyNJbA
	ASmdOuiwsBzwk8RZdlw06SUEgTqdiJABpgU5YViHUI7e7LVXa8DZ2N0cul4YdYsqcsJaW9
	xlscoPDKRvKpgOXipVgtqvNnJ8bfM+g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v6 1/2] bpf: tcp: Reject non-TCP skb in
 bpf_sk_assign_tcp_reqsk()
Message-ID: <20264619471.he8Q.martin.lau@linux.dev>
References: <20260403015851.148209-1-jiayuan.chen@linux.dev>
 <20260403015851.148209-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403015851.148209-2-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 03, 2026 at 09:58:27AM +0800, Jiayuan Chen wrote:
> bpf_sk_assign_tcp_reqsk() only validates skb->protocol (L3) but does not
> check the L4 protocol in the IP header. A BPF program can call this kfunc
> on a UDP skb with a valid TCP listener socket, which will succeed and
> attach a TCP reqsk to the UDP skb.
> 
> When the UDP skb enters the UDP receive path, skb_steal_sock() returns
> the TCP listener from the reqsk. The UDP code then passes this TCP socket
> to udp_unicast_rcv_skb() -> __udp_enqueue_schedule_skb(), which casts
> it to udp_sock and accesses UDP-specific fields at invalid offsets,
> causing a null pointer dereference and kernel panic:
> 
>   BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1df0
>   Read of size 4 at addr 0000000000000008 by task test_progs/537
> 
>   CPU: 1 UID: 0 PID: 537 Comm: test_progs Not tainted 7.0.0-rc4+ #46 PREEMPT
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl (lib/dump_stack.c:123)
>    print_report (mm/kasan/report.c:487)
>    kasan_report (mm/kasan/report.c:597)
>    __kasan_check_read (mm/kasan/shadow.c:32)
>    __udp_enqueue_schedule_skb (net/ipv4/udp.c:1719)
>    udp_queue_rcv_one_skb (net/ipv4/udp.c:2370 net/ipv4/udp.c:2500)
>    udp_queue_rcv_skb (net/ipv4/udp.c:2532)
>    udp_unicast_rcv_skb (net/ipv4/udp.c:2684)
>    __udp4_lib_rcv (net/ipv4/udp.c:2742)
>    udp_rcv (net/ipv4/udp.c:2937)
>    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
>    ip_local_deliver_finish (./include/linux/rcupdate.h:879 net/ipv4/ip_input.c:242)
>    ip_local_deliver (net/ipv4/ip_input.c:265)
>    __netif_receive_skb_one_core (net/core/dev.c:6164 (discriminator 4))
>    __netif_receive_skb (net/core/dev.c:6280)
> 
> Fix this by checking the IP header's protocol field in
> bpf_sk_assign_tcp_reqsk() and rejecting non-TCP skbs with -EINVAL.
> 
> Note that for IPv6, the nexthdr check does not walk extension headers.
> This is uncommon for TCP SYN packets in practice, and keeping it simple
> was agreed upon by Kuniyuki Iwashima.

sashiko has flagged a similar issue with larger scope.
Please take a look. Thanks.

https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%40linux.dev
