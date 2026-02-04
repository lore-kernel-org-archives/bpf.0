Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC421850A4
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244049; cv=none; b=rMH+Zoke7FkRnoKSHnbc8NUPZkhPU+qG40nJu7Sep5in8IK0qubRmlUHwuBxt+rygK+HJeSN5axCnFdvd85/laNfF6cnto12jYmwAhTVFYSfRzJCecRWHSvRAErM7zBSXqC/+Lg/n/24xqecqneooTPAAX393EyNrOVg5wu/TLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244049; c=relaxed/simple;
	bh=wZZ/SeQyb+jbaasVwUURB5k+BXkw3yx4fwjfmMYXfzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIkiE7UzWQr0vJl5/hnLGp4niaBvXp7lwbOeyCV3pJ/AVei+iKxPJcpa6mpifFAwU9/sc8wkcc1FnsaYuK97z+8Q0pKDPbY5YJVoxyz+bmxwQMBbGiarLQFtnIxXrTPSrFNWLq9UGCOFMfV5+TDYp+WuUmttZmvlGqaPYhCe4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cNkCVy31; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cNkCVy31"
Message-ID: <917eadc0-9341-48d5-a795-8a7d5318886c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770244046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpHQHK9ByhXjOMLtKt5IA11owJ/tFaX0XM7vmCRxYqk=;
	b=cNkCVy31xTsJNCh2BvARgaCcHZ+Vj23CgpcBd321pKayWHu/qZAQDj5lVGQ8o9yhzQgIxN
	mOO4I4MZ5LylIA/8wcRV/i+NAq4WlqzBSnoHP2Cmej5wwwEXNu8xamtbc33Ptcugi0SIxq
	xbRKyBO9BfISXwf7FLEums4kmzAC+lE=
Date: Wed, 4 Feb 2026 14:27:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_tcp_sock() helper in XDP
To: afabre@cloudflare.com
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, wferguson@cloudflare.com, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev, bot+bpf-ci@kernel.org
References: <20260204-afabre-bpf_tcp_sock-v1-1-a22b40c630c0@cloudflare.com>
 <167a8f4235973cd42372884aa66182a10fd17e50c70626b1fa0e659933e82b4e@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <167a8f4235973cd42372884aa66182a10fd17e50c70626b1fa0e659933e82b4e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2/4/26 5:04 AM, bot+bpf-ci@kernel.org wrote:
>>      But the TCP TIME-WAIT state needs special handling for this: packets
>>      received for a TIME-WAIT socket can either belong to the current
>>      incarnation of the connection, or a new incarnation. The only way to
>>      determine this is to compare the sequence numbers.
>>
>>      Add the bpf_tcp_sock() helper in XDP to allow the socket sequence
>>      numbers to be read.
> 
> Can this approach work for TIME-WAIT sockets? Looking at bpf_tcp_sock() in
> net/core/filter.c:
> 
>      if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
>          return (unsigned long)sk;
>      return (unsigned long)NULL;
> 
> And sk_fullsock() in include/net/sock.h:
> 
>      static inline bool sk_fullsock(const struct sock *sk)
>      {
>          return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
>      }
> 
> TIME-WAIT sockets are explicitly excluded by sk_fullsock(), so bpf_tcp_sock()
> returns NULL for them. The sequence numbers stored in TIME-WAIT sockets
> (skc_tw_rcv_nxt and skc_tw_snd_nxt in sock_common) would not be accessible
> through this helper.
> 
> The change itself is useful for accessing tcp_sock fields from established
> connections in XDP, but the commit message implies this solves the TIME-WAIT
> sequence number problem described, which doesn't appear to be the case.

or use "tp = bpf_core_cast(sk, struct tcp_sock /* or tcp_timewait_sock 
*/);". The bpf prog can also read all members of the kernel struct 
instead of a subset defined in bpf_tcp_sock.

pw-bot: cr

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21671977729
> 
> AI-authorship-score: low
> AI-authorship-explanation: The commit message style is consistent with human-written kernel patches, with natural technical language and standard formatting; the technical error is more likely human oversight than AI hallucination.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: The issue is a misleading commit message that claims the change enables TIME-WAIT socket sequence number reading, but the bpf_tcp_sock() helper explicitly returns NULL for TIME-WAIT sockets.

