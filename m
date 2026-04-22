Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADC1C69D
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776834383; cv=none; b=UGhp1rYS/lj7/wJC7HfVrFNZl7tFc6pWnklpxGX0QaCjGu5ruB+VYT/10w7V93Yc226ZwB/fox7xHWysNKwss21jrfuJKlHlMx5N3heOPTAsyATExeplDIG8sCfdVhnNMDYuyzCXP2pak7ThHZeXZediZ2vvRL2IBzPF/1Edamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776834383; c=relaxed/simple;
	bh=xGwKfExeAyRXOcJ9GqvA135TODWRUCOjYTSeqSRO3tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eHlFSsjYPKwCIStMBkOiP1+d3nWT1BCWQPSuKZhygJyBbij/Tq0tYmiu62F2XprNM6+5P1myH1T5pd7+3YIc9EzUGIxKYdunlI+SLCK2GJwXoiVFTl/unMKVCwxV4Q81HC+FkKsAK4T4B8DIBEtjtBRPKxhfodiEyyGLjpojFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gFIoN/Ud; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gFIoN/Ud"
Message-ID: <e03558e0-e097-4480-b5d7-de2979b576ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776834376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nfAE9HDuK/37R4UeC9uZx1HVQgNy9RzoW9NqfXCYkU=;
	b=gFIoN/UdmOPN1lvj/8mKp0lTDirpRzVIDOJz5k70LlRc+dhmH451Auhnf0kV8ciLm5bamh
	K3zrTwrSqY9ohs8GJ1LCTksVqaF4UHSjKucqsd0nhpGQgY5AwkrOJoGe1F4sbnSwfC9JOX
	LouxPukElF/CPePyvfVxYM7X/A4MVsA=
Date: Wed, 22 Apr 2026 13:05:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Reject TCP_NODELAY in bpf-tcp-cc
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, shuah@kernel.org,
 ihor.solodrai@linux.dev, jiayuan.chen@linux.dev, hoyeon.lee@suse.com,
 ameryhung@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260421155804.135786-1-kafai.wan@linux.dev>
 <20260421155804.135786-3-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260421155804.135786-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/21/26 11:58 PM, KaFai Wan wrote:
> A BPF TCP congestion control program can call bpf_setsockopt() from
> its callbacks. In current kernels, if it calls
> bpf_setsockopt(TCP_NODELAY) from cwnd_event_tx_start(), the call can
> re-enter the TCP transmit path before the outer tcp_transmit_skb()
> has completed and advanced the send head.
>
> This can re-trigger CA_EVENT_TX_START and lead to unbounded recursion:
>
>    tcp_transmit_skb()
>      -> tcp_event_data_sent()
>        -> tcp_ca_event(sk, CA_EVENT_TX_START)
>          -> cwnd_event_tx_start()
>            -> bpf_setsockopt(TCP_NODELAY)
>              -> tcp_push_pending_frames()
>                -> tcp_write_xmit()
>                  -> tcp_transmit_skb()
>
> This leads to unbounded recursion and can overflow the kernel stack.
>
> Reject TCP_NODELAY with -EOPNOTSUPP for bpf-tcp-cc by introducing
> a dedicated setsockopt proto for BPF_PROG_TYPE_STRUCT_OPS TCP
> congestion control programs.
>
> Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
