Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139677;
	b=jiVtCFEZ7le8NOcgSMLdWxW7gH8QbH9PBDGzPC+Uvsef8AtMye6PpvX/dIOOx/VIfaGu
	 lBz+leXUEnHbw+VyVqM2upqNHY9NC1Duf9hD4GdryNkIhbAif/irfBGMmbZGKJ7yTFz4S
	 OmoG97ttyoz8R6lrD1rdsFwx9N17VzhAdQcYLgE2Nz12Of/5SD/ARGkdJxFJrmjV9DbYm
	 uB5r2Mk1E7aArDi5mItuTPybfNjXgG8mF2aDJnOA6GA9UGXpQP3P4yGt6L+zH2gbrDYLx
	 y/71q79BgplHIJaHqp7lBjpK/SUTacYhFh8S18gxjpZn4M9VAeoSicCQP0327VMWtQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2bDTmkmhM4XZVFBip7SpaJb7mMVIkHIwjC2jt+jxj28=;
	b=f+ZUenK6DAyBWuGE2wqR18xwDBGaMTxYA1Ed9PdW81w+9fyoNix9tjbi/1RaDlQKl26u
	 FURfSGQ85OKgixU38pUuc1ZnRxxs++Zbd48DNMeIdyEUFe2LvQpAbB3Uhfh8AHinnNIeG
	 VnwV8ANlY4rF+MNSVem/nmJlXRN0yKIcA5Bn5133OUrcGIu1hiVlQgVdUrLmUbk1Qg8kB
	 UUpQtjNu7LPuSlwyd+ijqhb+mk3WuNemHEm5ZDVTO5rdQKdqAznM07GW990DNFRA2nCoQ
	 DHEAulOqNVUiN1nxw0cuuqI6ueyRaG6XUBMkIbt1yZqKgjM8EDvUKcvoV79SB2TTb3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=m96n+t1k;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C93606A31E;
	Tue, 27 Oct 2026 22:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C93606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=m96n+t1k
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xLpXP-00C4Qw-RT; Tue, 27 Oct 2026 23:20:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=2bDTmkmhM4XZVFBip7SpaJb7mMVIkHIwjC2jt+jxj28=; b=m96n+t1ks2ArQW8Et067ICkF9y
	+f6nD6xtIxt3iyU/6q6NYckT0m5a9vH4Y9vPvsdVY0ATKu3sp7uXc6hZ9HoWrQkHk1pzBiwSjKRWh
	G/SXa7TqahNnFKiX5XUIm+7tRqkDCOLpW5aYrmfUJ7xd3U79BS87tSxHMG0Y0XUN5Tq6GGi/YA+5I
	63XFPcOIE+Wf4M18rl1ZztBFYYSsTE52H8BhCsihrlYfqrD/9KzsFieuf/GH9S4Bqzgz6w50TtW9S
	UVZ+iK759aw59aYLwDX2v5AWUKu09h4BcBM2qK8xgEkpIhUNPN6iGlhFaa6bN20OVvnPGuKVcSLJK
	wfMu2Biw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xLpXJ-0005Kd-9f; Tue, 27 Oct 2026 23:20:53 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xLpX7-00DiYf-Ls;
	Tue, 27 Oct 2026 23:20:41 +0100
Message-ID: <03ce1d61-edc2-4999-8506-64e79961b378@rbox.co>
Date: Tue, 27 Oct 2026 23:20:35 +0100
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
 <0bcebb4f-4b36-4f8e-a3cd-1eb0455081a8@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <0bcebb4f-4b36-4f8e-a3cd-1eb0455081a8@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/26 13:12, Michal Luczaj wrote:
> On 10/19/26 21:40, Alexei Starovoitov wrote:
>> On Mon, Oct 19, 2026 at 08:20 AM Michal Luczaj <mhal@rbox.co> wrote:
>>> On 10/17/26 01:52, Alexei Starovoitov wrote:
>>>> unix_state_lock() in bpf_iter_unix_seq_show() was added only for
>>>> unix_stream_bpf_update_proto() called from the iter prog.
>>>> iter/unix cannot get there anymore.
>>>> can we drop it ? can be a follow up...
>>>
>>> So we don't care about having a stable socket state while iterating? Which
>>> is the case for iter/sockmap, but is unlike iter/{tcp,udp}.
>>
>> Not sure. Is there a value?
> 
> Isn't it (currently) necessary for iter/{unix,sockmap} dgram peer
> disappearing on connect(AF_UNSPEC)?
> 
> But, if I understand correctly, the removal of plain PTR_TO_BTF_ID will
> make pointers like `peer` inaccessible to helpers. And we just accept progs
> have to deal with potentially stale data, e.g. the value of sk_shutdown.
> 
>>>> Should we restrict it to ctx->sk somehow?
>>>
>>> I recall a discussion about having BPF helpers accept only trusted
>>> pointers:
>>> https://lore.kernel.org/bpf/CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com/
>>> Restricting only iter/unix seems better?
>>
>> we just discussed at bpf sync meeting that it's time to
>> finally remove plain PTR_TO_BTF_ID.
>> Otherwise we keep hitting this bug everywhere.
>>
>> in the meantime can we do it for this one arg ?
>> Mark ctx->sk as PTR_TRUSTED in sock_map_iter_reg
>> like iter/tcp and iter/udp do ?
> 
> Ah, sure. So the same bit for unix_reg_info left for later?
> 
> I've noticed commit 7cc639dc45c5 ("bpf: Don't take an extension for an
> iterator program") got merged. Should I post v2 with the env->prog->type
> check dropped or you guys don't want to restrict iters anymore?

Thread stalled and I'm not sure how/if to proceed.
As for PTR_TRUSTED in sock_map_iter_reg I'm waiting for bpf-next to open.

thanks,
Michal
