Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0232EC0B4;
	Thu,  5 Mar 2026 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710544; cv=none; b=U2CljUub4NqZuxPBEkB7qMvklmDlyWOAtDhBvdyH7aza5lHerNZtpjJvLaN5Bs2KkzVOiFwBeaEkVuLADcr6fUQNxrho1bEXWF31kNe6Fqz+h0DbI8uCfj0tZG8+OoymDVEm41PZFXa1gzh16T3wiRPVr8mfxOe/OmUGRoQngJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710544; c=relaxed/simple;
	bh=bBAuEFjQoy1Sqf5HpXr5h2QBD4XftTaYD0olVeE+nFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQliPqMNNr/VWbN/yWST7nzz32fOCa/HcrYSZC9ULeWAqFa5Y8/AJ3n5Mkft73HSMtVT1RhLdqypR7/4ggUyZnGkXJ8RtQIwuxSW5uA4l+FQlRqMi+xSbTit00LYanuLrI/HQDL2flSghqLiyii9vsqN1QVkszbfLTtyLzGmVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AaAvIJj6; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AaAvIJj6"
Date: Thu, 5 Mar 2026 19:35:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772710541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZsu2QiRBa937NrqSnequfmiO5HgVbDE/h3Cjf8XHDg=;
	b=AaAvIJj6BVI0lswBS6a/RsMpASqQ1qjc6oGJv/xIANIHwNiSf3+tDOSRHaEy7czVjAlcqZ
	negyQl+wWswkdD4shsUZdf9SGSzuAU/2uuL9OB+WHdhAXFVr2CFFICunKnZR6c1+RetfJQ
	eYfKE+0A1f9DmMggXn2N0aMK4/wyfLE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space()
 for UDP.
Message-ID: <jy77n43h6kvpaz3wk6rhdfogxmpaixmjf2p277qjvcvnynhh2f@d7atem5igamx>
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221233234.3814768-3-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 21, 2026 at 11:30:49PM +0800, Kuniyuki Iwashima wrote:
> UDP TX skb->destructor() is sock_wfree(), and UDP only
> holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().
> 
> Otherwise, sk->sk_write_space() is read locklessly.
> 
> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
> 
> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

> ---
> v3: Use WRITE_ONCE() in udp_bpf_update_proto()
> v2: Cache sk->sk_write_space in sock_wfree()
> ---
>  net/core/skmsg.c   | 2 +-
>  net/core/sock.c    | 8 ++++++--
>  net/ipv4/udp_bpf.c | 2 +-
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 75fa94217e1e..3d7eb2f4ac98 100644
[...]
