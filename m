Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4A3E4C7F
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460046; cv=none; b=r2UqPdYCCCqRP0ehc1ZZSIjr+TEyr36JjPZ+QTWd1yc8cWIsMrr19WLvzXooUTaw1aI55KfMe1jzct7QQynKczuj8KdNqKzpUeeA26VWMXQimnYyebxic7JNKwEpo874kVj1NP3EvA5yxkM6GcYLO0BKZFtjA9o1fikUqMANN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460046; c=relaxed/simple;
	bh=4M11YbD9z8oBJeyAOn0ddq/b5r2GHRThYIozQUFrkts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvPeBL6VK5p48+xbEzyR+cW89ZsKnqIgZOI6lcsR1hQf4YgZdFtQzzXaGGUMWw8dZc9aTScYvVtp+3mvYs0qfyDtEgFWnz2stBDKt8K8NUYzqavnEq9IxA1aV+UIrAKGKCZwcwxJaCLH/+LmqnZ3wv+lLW7aiHaJeK5ZFTAWovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s0FuTW3y; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s0FuTW3y"
Message-ID: <cbe15485-b7c6-4e9b-80e5-36aad2dc4e2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774460032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4M11YbD9z8oBJeyAOn0ddq/b5r2GHRThYIozQUFrkts=;
	b=s0FuTW3yvHIwga1XtzaU8BcnhKWu5WJCZJD5aEMvkh5qqyqaYeFcEtV1nDgxBHIE1YT4XV
	q9S5c9E7ARrXc+WFV328kEOvjSusMjPW481dDnl2krKhnaKanmnFhob+/UJ1reqiNhtwwm
	+hf7+3E9aJ+ecELywX88T4bAMqwWsCw=
Date: Wed, 25 Mar 2026 10:33:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 03/11 net-next v5] ipv6: replace IS_BUILTIN(CONFIG_IPV6)
 with IS_ENABLED(CONFIG_IPV6)
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20260325120928.15848-1-fmancera@suse.de>
 <20260325120928.15848-4-fmancera@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260325120928.15848-4-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/25/26 5:08 AM, Fernando Fernandez Mancera wrote:
> As IPv6 is built-in only, it does not make sense to continue using
> IS_BUILTIN(CONFIG_IPV6). Therefore, replace it with IS_ENABLED() when
> necessary and drop it if it isn't valid anymore.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

