Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFE3BA23F;
	Sun, 28 Jun 2026 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684115; cv=none; b=nB+0dEUdJUnLToqMSRsnAGd+vaoVPvHdyl3U7TuI3l61nmIhzeNoaIk84/qp/mNmB7bw0EXhPvyPQ4BGZ/+mqN7pahho1+gavtftBB+RfwTQSD0tBifCjMfucE7a+LDHzh5YfQF9Z6LHKaMPHaSi9u945XF07SCej7IXzyQ7SB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684115; c=relaxed/simple;
	bh=lT5FBYAGjucFu5IEMRieLs1JdvAq/UPoD1SUZqini1o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h2COOYiGHsjZHA0sBwXjITE0UDKvcp+CaAv9QbZ0xCY0I88bOGK2wJjfrHMj5q95ga1WYWBBrsheLl71FX0LGRd4ZLv8dVtP6Br4P4iZTQL8oTQKy7lS5NM0YuZEVU/CLrQ/6nWGtndQdUvqGNxxrc3tlakNNZSxBWuvf48UAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Aa9aIpBr; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Aa9aIpBr"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdxZP-001Zgd-9t; Mon, 29 Jun 2026 00:01:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=7KBuH7EGbpc9g/eKId5Y5zgz4rib6zGTEjTk3SZENN4=; b=Aa9aIpBragsjTme7+DfSy+pe60
	pA2xIFAx3fUAi1r9kt22g5wog062YJOLi98DN01HOOdLMXoP3Fkli9qMM75bLzjLyfSUhhMrPGjuI
	yA5oCA7wa0Hlvf4s+s0KMA96MkwZDIZFfDExzKT5/RRfSk66tSyiJ+9dm59tDOIeW9oQU/HCLyBd4
	fMVmiGEDkmH8rw5cT9/nif93h09feT56GOyBr/j/qSSLq/0AaUE/YpJoKIDocG22X3n03iR3KOTeP
	UF9I2X5svDsn1QTRk++6uFJSSeUVnGN01I/Q2rZSP0oAlNHtTmYvM6Lm3D9wM4JIbg6N9WUEwtaZ5
	BsH7jIhQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdxYa-0005bC-He; Mon, 29 Jun 2026 00:01:43 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdxY0-00BgFH-TU;
	Mon, 29 Jun 2026 00:00:16 +0200
Message-ID: <ea367ec7-cc4a-4809-8f03-be3dc24d0440@rbox.co>
Date: Mon, 29 Jun 2026 00:00:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <CABFUUZGg1B0vaw9DFX3uTHxpRyyGtvn04Ae=Ob-VmnuVJB4KLg@mail.gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <CABFUUZGg1B0vaw9DFX3uTHxpRyyGtvn04Ae=Ob-VmnuVJB4KLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/27/26 19:34, sun jian wrote:
> On Sat, Jun 27, 2026 at 4:37 AM Michal Luczaj <mhal@rbox.co> wrote:
>>
>> Fix for UDP sockets getting leaked during sockmap lookup/release.
>> Accompanied by selftests updates.
>> ...
> 
> Hi Michal,
> 
> I tested this series on bpf.git base commit:
>   26490a375cb9be9bac96b5171610fd85ca6c2305
> The test environment was virtme-ng x86_64.

Great, thank you.

> However, I can reproduce the same timeout in three consecutive
> runs on the unmodified base commit, so this looks pre-existing or
> environmental in my virtme-ng setup rather than a regression from
> this series.

Yup, same for me. Good thing bpf-next appears to have this fixed.

thanks,
Michal
