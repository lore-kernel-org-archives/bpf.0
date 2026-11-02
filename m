Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609704;
	b=dVzyLuazeX0jqpwCgt6PntNpCyfp96gToZBG+bqj+JcXecCVoAWC7U5oj95bTy7CqZSE
	 T+EZLymVGwz2EgQUBY+cJvu2v3wCYaOLsKZNvo7dai8aFtVZQikw7yZNNY7PRx3ehvT9m
	 oy0TBi3xuwJGZeCuzESwZ8i8Fbs8YPAWRL3+aaNcc010r50ABftv9k85YYfSo0/zmIaLJ
	 if2daVMvxhF6XrIy0pn9Xhq7WeqxJZtpabJZDApqRW2XpRH6ngRLOE+DdVupz1OzRxu7V
	 OsfluyUQQC5iDDkXafpg7/hOrinWPzPpsVk0aDGJvsBULfOVKrLhQiPiGjwQXn33Rnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609704;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mle+NIlXkrafF5xGCK7Z3UNOEf1ykyCcklkT9REqyzw=;
	b=ACZtlSPIyaSkbkmjhwfHX0wh7dgZrHnU9XCYwa4ApPbCaJ7UOio8Bb5R88U3eJJ4b56b
	 NkW5g2JR/M5SZd+Qt8JHhk3BUWUucXDt2uMlBggdXMJx/eod6FkTo4U08wIQgf33I7YJi
	 1LprgmTMnYEKSo3Zs0czdfZvG/UBseo6mxNGjkhKTjAHudThQ5HvWJvPLDWChs+OnplJm
	 pnRE33Yw78fNZBTVNq5AjF6pA/dbo0yNHV6HS3x2jJ56rLyN4GZc+OJn74dKP9QXExN0l
	 JadmlrUE4ex1y/Mq6n76YWB3azF6CUrX+C20iv74S5RoMXzH6s/4/jdObAmmO/U8JDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=URR8JRFC;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3060606A324;
	Mon,  2 Nov 2026 08:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3060606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=URR8JRFC
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xNnoY-00B8nD-GC; Mon, 02 Nov 2026 09:54:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=mle+NIlXkrafF5xGCK7Z3UNOEf1ykyCcklkT9REqyzw=; b=URR8JRFCVx/BTa6tC0SC34HbSi
	FamZlQHtkoCy1nCYcKoVNV+U8CUckkPCfMsIkG4H6/tYWRZ/i/Vt+gD4JdNLXuVN1q7KTptrBttV8
	XPT1WR0OUivtmZpFLmAmRNGOFLTDKz90/qZNhBF0T7lZgvCjbbrmuvP60Q8+1thu+gCBcAhBfeJyY
	XADeYpwL+/Le8X5JGCPFc40Mh3iypww9yLXtGaSkxajQ/CDfCZgkH1+KfI8kkSSl4JHEietPkd/9m
	bMIOQWO2aMDNOAShv+siilVLLUc1sbT/bAkoHazmVwq7dCPUnz8puMATGN5Q27XWX7ajBrZ0V+1qx
	p5DLXuZg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xNnoM-0000bz-Do; Mon, 02 Nov 2026 09:54:38 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNno3-00B7Ye-Lf;
	Mon, 02 Nov 2026 09:54:19 +0100
Message-ID: <7c609c7f-1dc3-438a-b6b0-7e59ed62d1f6@rbox.co>
Date: Mon, 2 Nov 2026 09:54:18 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH RFC v2 0/4] bpf, sockmap: Restrict iter-context sockmap
 updates to sockmap iterators
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Lorenz Bauer
 <lmb@cloudflare.com>, Eric Dumazet <edumazet@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 02:15, Michal Luczaj wrote:
> Follow-up to Sashiko's report [1] and the decision to restrict which
> iterator may perform sockmap updates [2].
> 
> Short series: remove about-to-be-stale test, restrict updates, add a
> negative test. Related bonus: mark bpf_iter__sockmap::sk as PTR_TRUSTED.
> 
> [1]: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
> [2]: https://msgid.link/87echn2fhd.fsf@cloudflare.com

Apologies, I forgot to strip the RFC prefix (which I set thinking bpf-next
is closed).

Sashikos reviews just as pointed out by Alexei: bpf_sock_destroy(). I left
out the tracing_iter_filter() change since I was not confident I understood
the reasoning behind it.

thanks,
Michal

