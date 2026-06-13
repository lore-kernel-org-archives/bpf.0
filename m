Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625E39E6D4
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781314619; cv=none; b=ZdWOMvW7HMg+CEiQpvzDDmrjDn9Ni/m3rjRgfxMBTnqz/mQF5yufPfQGtUem1Nxve9YkyeCFtTCTxXrDw2s/javDGZ3Tr37Dv49gkQ6/P0DCdWUXQE8Zug+lETwrGdjkosY+VoK9W5fMs+EEsty361NdlOdUkw/vm1shpMS8KGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781314619; c=relaxed/simple;
	bh=ATCD8YWcyycCwAf5daRrjVD1RP8gGZsuumqpfm7uutY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KqnwzX7kXSPyScQKKwS30rV0yQTja/iCBVkd72N7MvH+C6+v4Lh3YxiqbO/B5O0cgrYNzOyGEF4zDij3uXiFdMM/2ggIralxiYDahAdi1nxS8X6U8oFJzh7VxY6MeIde06YqbAHld+oc+ydK0meXb8OZuCnwN9YUp3Xv/Z+7VX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpY886Fr; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpY886Fr"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6b5c374e5so1772218a34.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781314617; x=1781919417; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvfgZCv77btIU2CurjCFxTmu/1bI2beZuVQe8JJi27c=;
        b=CpY886FrNj4EQww+vVk87tNbyjOoMjx5GMiDePF0Y5cfPIi/mYw+Z5j18KHqIZZEbg
         FcDVvF609q7lA5/qi9oCQWCW/F0JTLseILy9f1ltPgHuI+ERjGzNq4trVID7nckeTiEB
         lcKYy7CuOQtxw0uLSNFJtBBqYZhraCvIM0i2GpgkCGt3IMvKQZhG5pmOwRGoFDizFjrC
         0j5mLhEc8kclUYhZE5PWjZLar0R1iPaX0IzytiUn2tQUaz5KdiQ18c6McNxBWis8E8zg
         ocTy7QMIm5+h12O4CGNre7BV46gPOqf+3Jng+FbkUF/Gr+3vBXrpw2cD9ivkz806XQEi
         c7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781314617; x=1781919417;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvfgZCv77btIU2CurjCFxTmu/1bI2beZuVQe8JJi27c=;
        b=nDKTQgI6FvLqgoNYPOcT/evEf3vbyxvH8d1UqMqw7WUhj0uokdoh3vJOJyORUbLxeB
         DpDD7w4LN7XXV+A5PPYh0WNAcgOdnRwTW5j3YzIWR93gWW+w1CNocPkgFNQ/TloHQE1+
         kXuVO6KVfru2/Ap0PyfboFxsvDUR7DJVwBfCrTTI3dJgKfQhQLlfYU6IKuyvXibKxJR2
         gc+EdLbk/+pOP8myTvzki3gO0Rdh+c1h27OCX5/ZjmSh3pS1yZxRy/Kjkw2WwJ19C6Ra
         CAIQV6EIi/jWarwNQD8YyUfcckpTiMfaC7K+q3R6O5CkJVa4g8fkJdUfgBG+0acBUuEM
         uhnw==
X-Forwarded-Encrypted: i=1; AFNElJ+PLUllnU9SKxpQ26yRDTygm/iTeB9c/pY/MnpIlnBdaVd28xJIksAhqWmHSmuM++KnFsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwBvOJRc7yaNh07K1a5fGywnMDGNBYk9xOaUtnFOT7Z6k3Aaq
	Y0ZsgjCeOK1ZcwmkBJKHCO+rNC6icEDQNaoyk7S74vVMF75BJXajM/4B
X-Gm-Gg: Acq92OHDx/NpkcMagLDQhtyH3Hq2LTLOhi24HI6Lp22j8HjrOIPC6Nd4rcPLmlAd1vk
	EWNQ14YA6dp7RW3Fv59C7QptmQilPBaMI9ZjkaoOJJo1taLAsAjbciYaNX3THiMGPmken/suH8k
	kdBUsW0HhiiqWtAG0rNVvCEd+2hV6Xdv7CV/SQLx2XdTBpwtN2GV7sf99/ZVwr2VcKg9mqA8/pF
	oTYZNZbjrRMxEOkYu9IwyUmuTskOMwF7Ayv6kKwWCbkh3xn3x/2E8iMCF6ehp3/JgLP3bpkfLYy
	tG5bj0H+7jduRSvsBaEd50fRLCjmzENnWzCKdcHqEG03CYdkP4X/bYjgvTPqLyIOam51muh1Q8m
	pR+m/l4JPO4+068JVbNlhnb0U5dKEnRSIv/8/IllfTicyfBDLRPXM0C/s7lX2qBjE1DIxLZU256
	HqxnYwWOaMYBBqJua0EkaASAGRBdG8LVlKdPnq6Jt5wIs+7aP6hwOE8BF05fBg+xUoy78IJtZFL
	Sp80AzaoU+X2lY9
X-Received: by 2002:a05:6808:159c:b0:486:cab8:cb7e with SMTP id 5614622812f47-4872dd9f213mr3099133b6e.1.1781314616544;
        Fri, 12 Jun 2026 18:36:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-487315b016csm2006539b6e.18.2026.06.12.18.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 18:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 18:36:54 -0700
Message-Id: <DJ7JBWTVOBVX.1YKW7ULLZC9Z4@gmail.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <bestswngs@gmail.com>,
 <bpf@vger.kernel.org>, <cong.wang@bytedance.com>, <daniel@iogearbox.net>,
 <davem@davemloft.net>, <eddyz87@gmail.com>, <edumazet@google.com>,
 <emil@etsalapatis.com>, <hawk@kernel.org>, <horms@kernel.org>,
 <ihor.solodrai@linux.dev>, <jakub@cloudflare.com>,
 <john.fastabend@gmail.com>, <jolsa@kernel.org>, <kuba@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <martin.lau@linux.dev>, <memxor@gmail.com>, <mmmxny@gmail.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <rhkrqnwk98@gmail.com>,
 <sdf@fomichev.me>, <shuah@kernel.org>, <song@kernel.org>, <xmei5@asu.edu>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 3/7] bpf, sockmap: zero-initialize pages
 allocated in bpf_msg_push_data
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, <jiayuan.chen@linux.dev>
X-Mailer: aerc
References: <20260612130919.299124-4-jiayuan.chen@linux.dev>
 <20260613002906.1336958-1-kuniyu@google.com>
In-Reply-To: <20260613002906.1336958-1-kuniyu@google.com>

On Fri Jun 12, 2026 at 5:28 PM PDT, Kuniyuki Iwashima wrote:
> From: Jiayuan Chen <jiayuan.chen@linux.dev>
> Date: Fri, 12 Jun 2026 21:07:47 +0800
>> From: Weiming Shi <bestswngs@gmail.com>
>>=20
>> bpf_msg_push_data() allocates pages via alloc_pages() without
>> __GFP_ZERO. In the non-copy path, the entire page of uninitialized
>> heap content is added directly to the sk_msg scatterlist, which is
>> then transmitted over TCP to userspace via tcp_bpf_push(). In the
>> copy path, a gap of len bytes between the front and back memcpy
>> regions is similarly left uninitialized.
>>=20
>> This leads to a kernel heap information leak: stale page content
>> including kernel pointers from the direct-map and vmemmap regions
>> is transmitted to userspace, which can be used to defeat KASLR.
>>=20
>> Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
>> page is always zeroed before it enters the scatterlist.
>>=20
>> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel=
.org
>> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>> Tested-by: Xiang Mei <xmei5@asu.edu>
>> Tested-by: Xinyu Ma <mmmxny@gmail.com>
>> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>  net/core/filter.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 3e555f276ba80..6e345ca65ca14 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -2832,7 +2832,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg=
, u32, start,
>>  	if (unlikely(copy + len < copy))
>>  		return -EINVAL;
>> =20
>> -	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>> +	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZE=
RO,
>
> This is a red flag.
>
> We have a bunch of KMSAN reports due to raw/packet sockets,
> which requires CAP_NET_ADMIN, and leave them unfixed although
> some people attempted to "fix" them by adding __GFP_ZERO to
> __alloc_skb().

yep. It's a bpf prog responsibility to avoid garbage in the payload.

pw-bot: cr
