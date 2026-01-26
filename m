Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCD331237
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424786; cv=none; b=oQzp3SVUb4lT68eeGvagfMb3HhCZQ68NwIKZpz5VhF5kSir6Vm4cdTUgxjkAQg0OIWJszoi3wTmXS9ob4UzNwaEX447yLGm8kMMH5kD24s6OqE/O+G44TkpW3YSS5aYk/mRCHNo0ooQH0JtTYd9uKN+H6lO+Fb5kF31xJbXHd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424786; c=relaxed/simple;
	bh=wi91apMevgorcUoNdYgJdCJWvTz1n03aU7FKUWmZnAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hms4YFFeGyZ5m79AOQdj/pS8vLwaLlJBJq95O2oYi+/QjLULrnXHXmYHU3+7CB4eQMLNSzrU0DbfV8rbfE8kwp3ekNS89yVDdenXuEZeftrWb7l14aiKhUIFa+eAfmlekM75s8fn7KMBE8WAoP22fRV/FmUIX1n+ENyJrcsCJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LMLl0CdU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LMLl0CdU"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8707005183so696907566b.0
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 02:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769424783; x=1770029583; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HQyMiysYGwMm5ScyZuRYthPeCj1mNuauMhUi+x7J5g=;
        b=LMLl0CdUhJ43KTJp9v0VbiAarCY6oEIqZZ7jGGOZTBcXw1st3dVaauwSKXKrr2EdBn
         9SdDC3EkaSzdIi7/Y+mfMU2R9jxZmt03ate7/fn+rzq8L1RQvXDyzgSYFQb6UTQ6n3ZV
         LUsWxBW6OUNaWfKDqUs5h3JIXbNM7ppsb23vDL9snkCsnYZdknYPcvOzUtWKp2DQM7lL
         gpdwUN/cku23XlvwSiUZVCL/0mzYzKEBwgLQQUKeCg2fqPUa7gbJFwAm1pWrdbRmS47I
         jQDNbiX/DxZa4b2DlysJl6cpVdDnRLWEXiDFf3Y2DUjQc830fM7w8AnFxGOHK0jxsHlU
         Cm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424783; x=1770029583;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HQyMiysYGwMm5ScyZuRYthPeCj1mNuauMhUi+x7J5g=;
        b=YXmWewE4Z8gn3vDx+9+enMEDqSJdQMYplV/VzUAI/hZLyJueQYG34LWAPX9b45mBOw
         dPNFW+HOjTOOjKVYiQ+aLiArb6h/djkGcN85vvATGysxY+/nuLMPfBzNsgEFdjSSKlAh
         TG8u2cZJoJsi2pQHJhu1fyqfyQbom4BGzTXh5y/dR0qVjCWrUazrm97k7C3OYUS0du6o
         gKVmQJeqdwUOGCWlfNY/iMWOIkfigERh7NezteeFUPQzwZoFSdFdsFY5Y01p8jAvnvOC
         EM2jv8B5xvFTROk8dGyK5ZlYfYhkyV3n4VDwk76BHgKyQpcn0fbKe2BVBCD/L1nr/PTS
         JAcg==
X-Gm-Message-State: AOJu0YzHFAPK7atm55KlXrFXH480/M/drTUYMErcUr4WVntg0Sk41fBP
	XBz2bx0cH8C39PJO5vc3X9Ee0D+x/kFpT5xJncf/1w6V9ydrn9Jn/J0c1haWUodqRpY=
X-Gm-Gg: AZuq6aKpiUV6HlKTS0xZBq1C/6i6gmS5qMqo17Mo/b+FshPvpUl4TjFC3+nmo0tH7g6
	h5pq53wJGSCC9kC4a/cJHO97d+5r/DNYWkmV0WnxxSDOZg9LIP5GiB0Yd8v8Rl+fjYtcrGO8ncn
	zsRb5IwPE6hypXPCfBrs9AdrgeNM9n5u8pwYp/anfLBhTao46vwlgvKeye7PIOfkINOxqbMy36U
	Ow4A2Uk6Zf2NulrT/Fl2ALjQuVULWviGnehPrWT4dU2WkAPT2w2VBGg0BSpl0/wRuI0njHm1B4Y
	JBb1WGqZ6lij9ZHYYclVaZTB0g0ysbbxIxTnGNgMRd5+ojLGsU6fMFcx4fNeoaJkCpM4+OmV+T9
	6k7qFd6QLv8wSSvcG3C4XYq4HkSHnGr3ilkkhqclSoPP5gX/AWCkJTzUcsM6kmFjcUqN6N2kUgR
	zCmzQ=
X-Received: by 2002:a17:907:3cc2:b0:b86:f194:9eec with SMTP id a640c23a62f3a-b8d20b4f26emr305487166b.18.1769424782815;
        Mon, 26 Jan 2026 02:53:02 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6ff080sm587357766b.38.2026.01.26.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:53:02 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 2/3] bpf, sockmap: Fix FIONREAD for sockmap
In-Reply-To: <20260124113314.113584-3-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Sat, 24 Jan 2026 19:32:44 +0800")
References: <20260124113314.113584-1-jiayuan.chen@linux.dev>
	<20260124113314.113584-3-jiayuan.chen@linux.dev>
Date: Mon, 26 Jan 2026 11:53:01 +0100
Message-ID: <87zf60sl0y.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jan 24, 2026 at 07:32 PM +08, Jiayuan Chen wrote:
> A socket using sockmap has its own independent receive queue: ingress_msg.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> Therefore, for sockmap, relying solely on copied_seq and rcv_nxt to
> calculate FIONREAD is not enough.
>
> This patch adds a new msg_tot_len field in the psock structure to record
> the data length in ingress_msg. Additionally, we implement new ioctl
> interfaces for TCP and UDP to intercept FIONREAD operations.
>
> Note that we intentionally do not include sk_receive_queue data in the
> FIONREAD result. Data in sk_receive_queue has not yet been processed by
> the BPF verdict program, and may be redirected to other sockets or
> dropped. Including it would create semantic ambiguity since this data
> may never be readable by the user.
>
> Unix and VSOCK sockets have similar issues, but fixing them is outside
> the scope of this patch as it would require more intrusive changes.
>
> Previous work by John Fastabend made some efforts towards FIONREAD support:
> commit e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Although the current patch is based on the previous work by John Fastabend,
> it is acceptable for our Fixes tag to point to the same commit.
>
>                                                       FD1:read()
>                                                       --  FD1->copied_seq++
>                                                           |  [read data]
>                                                           |
>                                    [enqueue data]         v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Thanks, Jiayuan!

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
