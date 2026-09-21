Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D754921B4
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991220; cv=none; b=YU7sfwRVFtgW2UCMj/uO4sBDLyImCk3UKfS270Xz1IXnJ0zpfiJobChxzTvb5McnMjpn99K/COcSly9/x8KmFQddGWWvQVidqTHpMSJOqALs0+HERiKEjj6N+fUf+PVHLOJKcKvvjFKjxRXp42pPgxt2FIDzvzJHKDomJfgKRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991220; c=relaxed/simple;
	bh=CukPi6mwk5YtEucP3bbx6fXib/ZpGUFZ5xcTPSFcEwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9ZU3gilV9gpy1FEkVY/fEkGYVeUImUPOu1p3PojWAOY/kfdreQGBCDNEN/VkA9y8CvwyBPYNKqZ6gwcfGJDQ46jNr7O3B2MMODayn6s4dQ9gQFGWsET9DBUvVagq/fmfeK0T8aX/Ua1fQgru2z3xzfVQeEeo5wUZSyh0Zf/fvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NhfYAO/J; arc=none smtp.client-ip=91.218.175.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NhfYAO/J"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CukPi6mwk5YtEucP3bbx6fXib/ZpGUFZ5xcTPSFcEwc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789991213; v=1; x=1790596013;
 b=NhfYAO/JlY4QsgTAbcjRSWlao1ARw3UiIYDyMFlT+0wgoGGZ/cRfjYpdALRabNwKlmwm4ZAy
 jCjc7LCqgDyBNhckOJqvO+6czs61qyTwoqiR5xB49l6FUjR+JG4PERw7srDXRCAY5eSnQsZUC2g
 Ev0MtJurILXSG+JXVogApC+I=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8a9cf8d0feabb79b;
	Mon, 21 Sep 2026 11:46:53 +0000
X-Mizu-Trace-ID: 8a9cf8d0feabb79b
X-Migadu-Flow: FLOW_OUT
Message-ID: <08ff0ec5-55aa-46ae-a224-b2d02aa2979e@linux.dev>
Date: Mon, 21 Sep 2026 19:46:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
To: bot+bpf-ci@kernel.org, geliang@kernel.org, john.fastabend@gmail.com,
 jakub@cloudflare.com, jiayuan.chen@linux.dev, edumazet@google.com,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org,
 martineau@kernel.org
Cc: tanggeliang@kylinos.cn, netdev@vger.kernel.org, bpf@vger.kernel.org,
 mptcp@lists.linux.dev, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
References: <85d9a0f138fa024354edde023a05f9d07b6ac87a.1789633546.git.tanggeliang@kylinos.cn>
 <b39121f2d0860a81719fb0b3f9b16bde9157bc043d7cc918497afc6d896877de@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <b39121f2d0860a81719fb0b3f9b16bde9157bc043d7cc918497afc6d896877de@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/17/26 5:45 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: drop duplicate check_app_limited in tcp_bpf_push
>>
>> Before commit c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to use
>> MSG_SPLICE_PAGES"), do_tcp_sendpages() did not call
>> tcp_rate_check_app_limited() internally, so callers needed an explicit
>> tcp_rate_check_app_limited() to cover it. That commit replaced
>> do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, which perform
>> the check on every path that queues data. The outer call became redundant
>> but was left in place.
> This isn't a bug, but would it be clearer to cite ebf2e8860eea ("tcp_bpf:
> Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg") as the
> commit that left the outer tcp_rate_check_app_limited() in tcp_bpf_push(),
> with c5c37af6ecad9 mentioned as the commit that moved the check inside
> do_tcp_sendpages()?
>
> Looking at the git history, c5c37af6ecad9 only touched net/ipv4/tcp.c and
> turned do_tcp_sendpages() into a wrapper that calls tcp_sendmsg_locked().
> The direct tcp_sendmsg_locked() call in tcp_bpf_push() was introduced by
> ebf2e8860eea, which kept the outer tcp_rate_check_app_limited(sk) while
> inlining the wrapper.
>

CI is right. ebf2e8860eea should be accurate.


> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35203307255
