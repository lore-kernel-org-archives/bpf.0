Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE65348C47;
	Sun, 28 Jun 2026 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683961; cv=none; b=pBIJMjU63IGD9nrdfnRdinEf9Bl4/u75HvgoGhxRGyKU65hrDCmWCea1M9TTgZ+r4/Ngyxk2EUycK7r1PYwYVNGpbnfvBu0A3g8OlPuFz0FVcuI9HpybAs6uuW5INwtyi39x5YyA/Z5YS7OXTVDmrlI6wfUSAooe6D1obtn8v0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683961; c=relaxed/simple;
	bh=ANvYV3bj+Y4afWXCh7EYSGpmbUPz6qEbChgwaakvHt8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WwnXXSyNfu2/qB77Odk4tux0VsGhXTo1zh17gyaOm2yOb3lhT9acjXeUZg9Dm+Og6FEoZcVS//7VK7fAf859vNs6evBuuzqTn0CwJvSmGrhp0lsWpDxMoEpq3uJWU4qpDRU1EoG619+TLUj5M4zddozqO/lxE5o3rNBEvOl3iFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OIP5T3+J; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OIP5T3+J"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdxWq-001ZLo-Kn; Sun, 28 Jun 2026 23:59:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=YPw84bxPaC1tOS8Jb9NaP4dSqs1KHqksSKnTohhbvZE=; b=OIP5T3+JAnIfc9UzzXT5hJA1Bt
	BCDcflZLTMOHo9fq2CZDMqy+CHCMYgHDEnMJZjDQigmgxhOCT1BTmsQi3DJaaFCTpcuEg7eZrmJCU
	71ThnihZG7mp6lR//Rto5AqDFsZD5B9peOno+G326PxVrPWagWzb5qQusEydPxuXyTjybhUrHoG0Z
	a737li/PfGAnAj3fk/Hn4k138wR2Daq9Svs+/b06aRS08eX3s2lVdONYvN9QODnswIsYlhIquzyc8
	ErM0KedoLQik3KfpDCGlm8koaCbiVfLHM+3RtR1DxgzjdfI64/d0t8uH2VpTRYIFOqq9p5yLYg7rv
	jw99QK+Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdxWp-0005zI-Ft; Sun, 28 Jun 2026 23:59:03 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdxWn-00DOhE-Cl;
	Sun, 28 Jun 2026 23:59:01 +0200
Message-ID: <a5615598-9740-4bda-8ace-e6704b97d17b@rbox.co>
Date: Sun, 28 Jun 2026 23:58:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 2/4] selftests/bpf: Ensure UDP sockets are bound
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
 <20260626-sockmap-lookup-udp-leak-v2-2-7e7e201c951a@rbox.co>
 <CAAVpQUCGpSWuei+cX9LL1WG=-14_FJU75G2njvvWCugsSMWDqQ@mail.gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <CAAVpQUCGpSWuei+cX9LL1WG=-14_FJU75G2njvvWCugsSMWDqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/26/26 22:47, Kuniyuki Iwashima wrote:
> On Fri, Jun 26, 2026 at 1:37 PM Michal Luczaj <mhal@rbox.co> wrote:
>>
>> Update sockmap_basic tests to bind sockets before they are used. This
>> accommodates the recent change in sockmap that rejects unbound UDP sockets.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> nit: this should be patch 1.

OK, I'll push it up.

thanks,
Michal

