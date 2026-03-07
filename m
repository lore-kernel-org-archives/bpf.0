Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AF224FA
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841836; cv=none; b=ST3R1RMTooGEsu/3Hl922CQfDH+CzY8Bl5ZPtLZH1ytCkGSDisRwlgF5jcdJ62TQBTF+6JN92LGXEl0Tyvgnwb8UYpxLTIxJblV6O9RZfNusKcB44xSGY9kEHTtj7C/Da5wGo093nsDNewUyyqhS0z8UDAw9F2iLgZBVnbnQ+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841836; c=relaxed/simple;
	bh=Oq6i+H3v/yPVvO2FJiTNolpyjO3CpjZSQcMebne3h8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeE3RT2szPPYN5mMe8XW1E9SyacIdc0D4AKe+Ghbmf5kz9BsRQqFCCEO1/hlemS4umoDuyJbrmxfJmC/yiIFPCPlJmNi9CipBolG30YYvMztZXuBYvnYY086n3e33LHOHEE82K2RaO10G46Fnb0XI3c5y7smxE5iDt15h6kL+Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ihXinTtH; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ihXinTtH"
Message-ID: <dc3a8b4c-32f3-4905-8cca-078f220abfef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772841832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHbeFglmCtgzA3qJvWmuinGohwBorJjMNIER9qJwK6c=;
	b=ihXinTtHdoZ+Cnx64OuUP3org3GvdBYo6bMdbg2NFzvT015bfNYpMDlSBttTh6O5xrZYah
	dBvBaQSLbexAejGr78NFhy/iOR25WW+JQpOWjoz6ZkMvTY7wQNba3sRGxXittla8D2WtJX
	fjHSISQihkFk7qGZ9K7qgfKarYL5qSs=
Date: Fri, 6 Mar 2026 16:03:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for
 UDP.
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-3-kuniyu@google.com>
 <fjt7fesjnzwuzeuiouv6rpvoxebounjqv3jlc34tvmzh252zep@hizdvwr2qwe4>
 <CAAVpQUAJgFtcJGtuMufS9mhaShs7OQDxx7jTGOSbG9wCdeCN7Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUAJgFtcJGtuMufS9mhaShs7OQDxx7jTGOSbG9wCdeCN7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/4/26 7:43 PM, Kuniyuki Iwashima wrote:
> On Wed, Mar 4, 2026 at 5:48 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>
>> On Sat, Feb 21, 2026 at 11:30:49PM +0800, Kuniyuki Iwashima wrote:
>>> UDP TX skb->destructor() is sock_wfree(), and UDP only
>>> holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().
>>>
>>> Otherwise, sk->sk_write_space() is read locklessly.
>>>
>>> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
>>>
>>> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>>> ---
>>> v3: Use WRITE_ONCE() in udp_bpf_update_proto()
>>> v2: Cache sk->sk_write_space in sock_wfree()
>>> ---
>>>   net/core/skmsg.c   | 2 +-
>>>   net/core/sock.c    | 8 ++++++--
>>>   net/ipv4/udp_bpf.c | 2 +-
>>>   3 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>>> index 75fa94217e1e..3d7eb2f4ac98 100644
>>> --- a/net/core/skmsg.c
>>> +++ b/net/core/skmsg.c
>>> @@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
>>>
>>>        psock->saved_data_ready = sk->sk_data_ready;
>>>        WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
>>> -     sk->sk_write_space = sk_psock_write_space;
>>> +     WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
>>>   }
>>
>> I noticed that Patch 1 and 2 were submitted earlier and are on bpf tree.
>> Given that Eric's commit (which you reviewed) is now in net.git, these two patches
>> should probably be dropped in the next version, right? Just confirming.
> 
> I was thinking git can just handle them well, and even the
> patch 2 has a delta in sock_wfree().

At least for patch 1, I am not sure git can handle it well without human 
intervention because the sk_write_space is backward from Eric.

For the missing change in sock_wfree (?), it probably makes sense to 
create a separate patch on top of Eric's change and target net. My 
understanding is patch 3-6 can be on its own without patch 1+2.

