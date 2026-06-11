Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A625342538
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178479; cv=none; b=EbemcagR5z8PfFY1bJnpe6GCMFMrMDhvwBi+hUrI0vtHOfIQYi+zWoUS6U2TMmuy8v/2Bymlq43HsHVxll4mjHi6IxGTM3oNyoSX3l9V8KY/pwCsK47Xao6BMp4I6GZ4F4ZYclYECjwKxyJNfIzsRiscrFQF3f9a2RnMhz60Bqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178479; c=relaxed/simple;
	bh=XoJJqz/Vzlhe5uQ13vjg3VCYz0+nnya2oNA5rEu2MFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvSPMYjqIYWW+0megSGQHoZxv3EWm/6tYSJK3uDQcdC7Y+GbQ7T7OHRVOETaUGxRYCx3vFh8yGyG4p9qtqAf49mNDVIaGgXeF2QApYXXR/NahmVl94d1v1EY0BhCBkEkY1bDapgeD7KW/d4JeXNzw3kd7EBNt4r4U6q/XMowYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RORblfg7; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RORblfg7"
Message-ID: <ee8eb9dc-3692-44eb-b807-3699201ddc49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781178475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQnWBNAsCzAJ3HZFLh8gKD/BTcTn+ZltOUCQYwic1XA=;
	b=RORblfg7meoiuNtp/4rapSWxIbyQ3GSD56k+VHAHqBL8MYQlHZlZ8AwsPmqEN/U1lUg5xC
	2TkMpkl7U1+iTVWyuEPZSZNb6SJAm00yHNu1vXY1DlG/NXb3xMs4wKQHraPF7QMXm8y1S3
	pxg1RJ3/urOmVLrfdS3obkRRcKbX5Hs=
Date: Thu, 11 Jun 2026 19:47:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] tcp: clear sock_ops cb flags before force-closing
 a child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 Lawrence Brakmo <brakmo@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/11/26 5:29 PM, Sechang Lim wrote:
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():
>
>    WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>    RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>    Call Trace:
>     <IRQ>
>     tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>     tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>     tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>     tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>     </IRQ>
>
> The child is freed before it is ever established, so it should run no
> sock_ops callback. Clear its cb flags in inet_csk_prepare_for_destroy_sock(),
> the common point for the IPv4, IPv6 and chtls forced-close paths and for the
> MPTCP ->syn_recv_sock() failure path (dispose_child), which reaches tcp_done()
> on a child that was never established too.
>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


