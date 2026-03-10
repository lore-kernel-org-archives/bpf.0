Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B12F25F0;
	Tue, 10 Mar 2026 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107925; cv=none; b=m76Ls+b79rujh0wWTLkSwiihWs9LN4L8A8T2Bywfo1e1Qwb01Ac5sDGOp1P6exCDo3Fc/8GaQJ0+uh9G0UfV74gLEKtk2JRJrBhKrAd71JKMVoHXXPHPsyBBPTgNKZcKzUhLxb3DDLvwevi0sN4A5BtQqlz89a1xHlccbS0HZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107925; c=relaxed/simple;
	bh=YDNxGWu2Cu9b9o0az4nb8RNC1YwXnECiDyGcqPaGOxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgZrO0xQ9/rBmOshmToo6IURhiEG+S7RHVduH2BqJaWtQGQtVQe8dOoLxmiTXHqnXL6QklVMzGjsE1yh2BKXOk/R/temvEBEa746h6LjD5UdRo1w8l7iaGNKzcSYAjpqpXwMjoWHeInTQscalsL7s1VmAMbc9Ea54LlDJ9AQJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsiCudPb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsiCudPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28602C4CEF7;
	Tue, 10 Mar 2026 01:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773107924;
	bh=YDNxGWu2Cu9b9o0az4nb8RNC1YwXnECiDyGcqPaGOxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HsiCudPbojaJDGOhS9r9jx81Tq6xXW2AbYNZOnmnnqn1BCG4grdb9vJUelc1/cNw+
	 hnQTSOoSXcbIg23QYmhX79/LW2n6xnJfgB3qHinb8EP7gzbHtGwmggOep+nDh7yqoy
	 I1r83+JeszlKYoTpISaLOXwUl2oGqnY5eaY3fAGbL+oGzWoinatvBNGQwuuZyEPrbx
	 nkp6V/YJVn5jyW2iO5OFO3054+I3QmcsCihdOW2inGdNpDsnjAS/Fq02A1D49Qn5fv
	 GinViF7YheiYMI7Z/wBZPWjVMNgLMgFnHRy8zzD6wmEJAsqsD0jietLKPWWVucBJpo
	 QsbVTdPeoMPaQ==
Date: Mon, 9 Mar 2026 18:58:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?="
 <toke@redhat.com>, eric.dumazet@gmail.com, Yunsheng Lin
 <linyunsheng@huawei.com>
Subject: Re: [PATCH v2 net-next] net/sched: do not reset queues in graft
 operations
Message-ID: <20260309185843.50ce9259@kernel.org>
In-Reply-To: <20260307163430.470644-1-edumazet@google.com>
References: <20260307163430.470644-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 16:34:30 +0000 Eric Dumazet wrote:
> I think the problem (quadratic behavior) was added in commit
> 2fb541c862c9 ("net: sch_generic: aviod concurrent reset and enqueue op
> for lockless qdisc") but this does not look serious enough to deserve
> risky backports.

FWIW I was wondering whether with your recent llist in place we could
retire the NOLOCK concept. So many workarounds grew around it at
this point :( But in a naive pktgen+dummy test llist ends up dropping
most packets. Not sure what it looks like on a more realistic setup.
