Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581196;
	b=EzmYqWzSl+d/ZkEsoYFHNODBm4s8OKUPFvoMyZHuFMdnIIRqKF0ZM1NGXfZvP2myKAnU
	 vesK5jBPi6sDV9g9Lkb0f564bSvBksVOR9Q6+U6W1zw5TZQoYBTGWzUNo89yt9GjiQ9cT
	 y6aN8amGZc2JWOUIAT44b5DM5w3SkVkoxdxv4VIrjFvi3LVG7NFO8FZLq4pZRz111gfFa
	 ilE7PkJNQtczqmNF9BkqxGGYJfnypDsMMjpHi0Wa5iqWVp6qDlu5vWaRIng4yvgUWrx5A
	 Oc+bWPMR8y5M6rYNkZp+SdXHZ487cZjUR17OgtZJEYKvlSvf1NS+T6Y5oYymgGqoSDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581196;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CXMv09XJSztEi4kmUF5Oe+G9R6xGXMmruVw6YW2Pd2Y=;
	b=dB8Xm6Gi/+9iOzBPTvZ5aXhHD4euOt2eWm2f1V78goTuNRPvOFJky5oYI+K4T85UfzT3
	 FtpW2mou1jdq1g7kmM/+LLlwB5ooVPhlxBkkxpzTHSy6H6C62/4mR+lxnoGRWbv1HtIve
	 N7jD7kHjmnCs3AUVcz/bve24e3Plj1QRCiYlHhFcfZno17bkhWe346l+K1rWoxxmLNbzB
	 64K3/7JgW39PRdM2fWqW9JaFjqJzKFJij95IIEV/HwMCZJ0ZVF7LDuST16Cj+2MQegmr5
	 IgQ2RluPzim9TftY0Hzw9P0Vm8hCy9Z5ta8DNBB37GjJNe09yIE4rKv0JTqjrRL+SUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=donkSVSY;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E4606A319;
	Wed, 21 Oct 2026 11:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B2E4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=donkSVSY
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xJUFb-008aAb-5x; Wed, 21 Oct 2026 13:12:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=CXMv09XJSztEi4kmUF5Oe+G9R6xGXMmruVw6YW2Pd2Y=; b=donkSVSYfoTTKXNn7kOlP4uleN
	VCeBNTAb5XZK7N9ndwdPuXLLND3igtkl3NGPEtMh4gOfdfKTiksPZkpsNGbQNeCkzyiQChjuKXupG
	ctDW7Ug47fvnrutMNxIGqaomvPp4WCcMNYsKEpC4ddlQHLU2lGoRIihLgbiiXYcYzY+hgaLYCBhA7
	C3IQTB+UGh6Z4TDruutRz5UTjLdLXPUdKq1lfwHURh49mDeQAdwYiLOIV/qkgQm0KGzjlltYbO79P
	qsUlOAdFwD/gtEgLXqU3DGLKNXonV4ZpRhicTK9jM5Tkf8bAO/+GL2WPFRbkJgA/bXNPJQ+jBvUMX
	XfIGK/0A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xJUFa-0007U2-77; Wed, 21 Oct 2026 13:12:54 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xJUFH-00CepH-Jb;
	Wed, 21 Oct 2026 13:12:35 +0200
Message-ID: <0bcebb4f-4b36-4f8e-a3cd-1eb0455081a8@rbox.co>
Date: Wed, 21 Oct 2026 13:12:34 +0200
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
Subject: Re: [PATCH bpf-next 2/3] bpf, sockmap: Restrict iter-context sockmap
 updates to iter/sockmap
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Lorenz Bauer <lmb@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
 <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
 <DM6O08VBRY20.1PFUYACCZ38JL@gmail.com>
 <a9ba4549-4bae-4516-85ef-ee38f13551cd@rbox.co>
 <DM92JCFA4X4U.30MTDH0KCPTJ@gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <DM92JCFA4X4U.30MTDH0KCPTJ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/26 21:40, Alexei Starovoitov wrote:
> On Mon, Oct 19, 2026 at 08:20 AM Michal Luczaj <mhal@rbox.co> wrote:
>> On 10/17/26 01:52, Alexei Starovoitov wrote:
>>> unix_state_lock() in bpf_iter_unix_seq_show() was added only for
>>> unix_stream_bpf_update_proto() called from the iter prog.
>>> iter/unix cannot get there anymore.
>>> can we drop it ? can be a follow up...
>>
>> So we don't care about having a stable socket state while iterating? Which
>> is the case for iter/sockmap, but is unlike iter/{tcp,udp}.
> 
> Not sure. Is there a value?

Isn't it (currently) necessary for iter/{unix,sockmap} dgram peer
disappearing on connect(AF_UNSPEC)?

But, if I understand correctly, the removal of plain PTR_TO_BTF_ID will
make pointers like `peer` inaccessible to helpers. And we just accept progs
have to deal with potentially stale data, e.g. the value of sk_shutdown.

>>> Should we restrict it to ctx->sk somehow?
>>
>> I recall a discussion about having BPF helpers accept only trusted
>> pointers:
>> https://lore.kernel.org/bpf/CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com/
>> Restricting only iter/unix seems better?
> 
> we just discussed at bpf sync meeting that it's time to
> finally remove plain PTR_TO_BTF_ID.
> Otherwise we keep hitting this bug everywhere.
> 
> in the meantime can we do it for this one arg ?
> Mark ctx->sk as PTR_TRUSTED in sock_map_iter_reg
> like iter/tcp and iter/udp do ?

Ah, sure. So the same bit for unix_reg_info left for later?

I've noticed commit 7cc639dc45c5 ("bpf: Don't take an extension for an
iterator program") got merged. Should I post v2 with the env->prog->type
check dropped or you guys don't want to restrict iters anymore?

