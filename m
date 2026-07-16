Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9463BA34
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165452; cv=none; b=MEzSB19zx6rgzaZtcdm2SquJsC/nOGJhg8YZF456TRByg0Felw+r+zFDKIei5ZDa1Cnnb61kEiyQcTplH/eWIIRRbw9ckyX9uPhd+HXrwYSM8FaTC6mmq4dUkXGQsMxlKHxNmkr5BPLPP9npJKIHy0OsHfvl4MXooqVnBJQ2Pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165452; c=relaxed/simple;
	bh=0u/Yz2U1NTm26LD1YDnijhGNyUJGfapsH7huxkap2f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D63X0JMlZWt4JDZMpIAf6D4Zr5h8hnen7dGhFL3ldPQh6O6ze54bycJJ9M5c/edMkcueqKDcyWTs3tWbIn9IKKkDIGJ1TaQi9IbR4R7N9lI+JPhq6HmPOnRHs/y0eBNrNbNRY8rxYCdbzPOfk85A9rP2TwejapJ/lRnxsa17NXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uZZEdc1W; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uZZEdc1W"
Message-ID: <95e690bf-2eed-469f-93ef-6ae3fb2a7162@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784165438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/vBddbqg04cfaRaFv+qk3RcSCgTr78WnBrXr8n/n0Y=;
	b=uZZEdc1W2Nl2f0RH63ytABeftJ2/sMj0bMoGbXyS7S48tvK/rt7+iXgqJLiNcWt6tfq20Q
	H2lI9IbZE/m70BH1VfNhX1+hyfjjaE1zFyYhjoUghV3aMuJN6OuZuZjR40hN/WsQ9Vs/4z
	hzoslWky52ed40sdPbzQQQqwEBPam7U=
Date: Thu, 16 Jul 2026 09:30:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup
To: Nnamdi Onyeyiri <nnamdio@gmail.com>, jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com,
 kuba@kernel.org, kuniyu@google.com, ncardwell@google.com,
 netdev@vger.kernel.org, pabeni@redhat.com, sashiko-reviews@lists.linux.dev
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260715213538.37229-1-nnamdio@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260715213538.37229-1-nnamdio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/16/26 5:35 AM, Nnamdi Onyeyiri wrote:
> Spurious wakeups in tcp_msg_wait_data() isn't being handled by
> tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser(), leading to unexpected
> EAGAIN errors returned by recvfrom()/recv().  Adding handling for the
> wakeup and a selftest.
>
> This issue was first discovered in an application that adds sockets to
> a sockmap as a way to view the received data.  No redirects or any
> other operations are performed.
>
> Sashiko has noted a few other pre-existing issues in the same area
> (https://patch.msgid.link/20260714205118.17DB11F000E9@smtp.kernel.org)
> that can lead to EAGAIN in tcp_bpf_recvmsg() and
> tcp_bpf_recvmsg_parser().  A local run of Sashiko also identified a
> potential issue in tcp_bpf_recvmsg() handling zero-data FIN packets when
> the MSG_PEEK flag is set.  To prevent this patchset from growing too
> large, I intend to submit follow up patches to address these once this
> one has been accepted.
>
> Changes in v2:
> - In tcp_bpf_recvmsg, handle signals and the socket closing in the loop.
> - Fix spurious wakeups when SO_RCVTIMEO has been set on the socket.
> - Link to v1: https://patch.msgid.link/ak_rR-Skd8Mvn4mH@localhost.localdomain
>
> Changes in v3:
> - Added the sockmap_recvfrom selftest.
> - Link to v2: https://patch.msgid.link/alFRK66z45eDNZA7@localhost.localdomain
>
> Changes in v4:
> - Fix potential data loss in tcp_bpf_recvmsg() when a FIN or RST has
>    been received.
> - Check the return code of pthread_create() in the selftest.
> - Fix race caused by using EXPECT macros in a thread in selftest.
> - Link to v3: https://patch.msgid.link/20260714203927.32289-1-nnamdio@gmail.com

Please do not send a patch by replying to an old thread.


> Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
> ---
> Nnamdi Onyeyiri (2):
>    bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
>    bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup


Please use a commit subject like "selftests/bpf: add selftest xxx" for 
the selftest patch.



>
>   net/ipv4/tcp_bpf.c                            |  69 +++-
>   tools/testing/selftests/net/.gitignore        |   2 +
>   tools/testing/selftests/net/Makefile          |   5 +
>   .../selftests/net/sockmap_recvfrom.bpf.c      |  31 ++
>   .../testing/selftests/net/sockmap_recvfrom.c  | 299 ++++++++++++++++++


Please use existing test frameworks such as sockmap_basic.c or 
sockmap_strp.c.


