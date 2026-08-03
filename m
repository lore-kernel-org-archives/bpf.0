Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B7265CBE
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785717012; cv=none; b=hF+n+x1us263eQs/HPgBxUpsI6x+ZunokSxQtcmR5XX0k//ENDrrWRigrcwZFoHr2O9ow+uiHIt/c3/IACfwn2qHhJTrYoeLjnX8JECnlmvLDWRLkOOGjBbLZDBQA80C1XGRVUgyUGMEWdzbq3XlTk3yUmxFOGlYTOqUoCIKVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785717012; c=relaxed/simple;
	bh=MgL/A1OL5VxKOy8fuemacuOQqMhbRsRzexGTXwULKm8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GGoCB+KUpP/EHJIKz4nER0b1O5Xqk8C2F+zVMivKkzMdS/oPr2Qt04c5ee3M09mnZdYLc/oLAI0krA0irbKyqrD7bS/vVD674dQPqlUlZkKf4KHLYqYJI99v2fAoU/qUs2AiwjoPzD7dFhZ9AX2vHCO+332koSMbkW4dgzraOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj6Bta+D; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj6Bta+D"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473b8c0fd5aso581634f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 17:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785717008; x=1786321808; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XJtB3G2q64cgAdmsXjeDVMSjpj2t0iKFamiuOTeDEY0=;
        b=Zj6Bta+DkFDTmctquAgTKQwH0Zj3b4jieGW2yCMX1nWYz59eEbGWrb9f2rLkIWV2EU
         M/ZQDc3ERkr0/CVXZHlrupH/YUBafnnXeeEQjPEUBnQV+nfMAdFllgzfWMgX+XFh+mc2
         Ij97L6psvikHVqSoYxlJuZAqRkLX/41CmCYk3OqeuOk7AdFRnwrXnu2zdppHbS5eS4gx
         NfOcZBxvMJKyseq9A6fIH7y3BEk1L6ZCYoF9PxUUpXH8otU8Wn3s3a5Py1Nxh91aE3TV
         LIGxtAmsjGusF4lXVAS/lkBNmjRdTsBZ+CWT9FZ9kuviuOWZeeZ3t5bFe+V9+IzOikFw
         deRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785717008; x=1786321808;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJtB3G2q64cgAdmsXjeDVMSjpj2t0iKFamiuOTeDEY0=;
        b=QGFKzVnbCcHo9KUV7Ki/jp58G7VpQj1isH2WJIcFrryWgswAVoRTQbrQGdzQv8IQAV
         ZZh3nDDTrmeh6NzG9C5J9dMbzage2j3Pm0ydsH91OOPtx5OrhZSDmROF+t4MRE8Dmy6n
         EZQXHQ4I6IKjDveejPEYQDZxeQqFTDpS9S3+Q7to6aplBF3VQA+DVgRX+Dki1I+Hj69t
         QmtHpHN2jaF+NgdWqnYkzIH5GVs5YpEext5Pk8wh9pQAEWoZVdZ0ySS5UX131tHnsuRP
         0s37lgKtN0TZ0aFAKiIJrjcLsz9gk8r7BnbrCOwMjx70IXBwcTD06SaFynlYl4tF9Yjl
         Y+vg==
X-Forwarded-Encrypted: i=1; AHgh+RowVKAwmq3DeiWC8V4Ve6mm0gMyFwqpVMOClhXU1YYANSiryKifyJdsGG4cgxtXuI7W3pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtH2MlsIkX0L0lGvqwVF7GH/Awr4325tb28dTS3PYH9wXCnD/
	Zj2O/IvEbgEQEAGOBgak6Q/TVXv2rp4ha3JCcduGXqOL8N5Nkzen/Psc
X-Gm-Gg: AR+sD136HTc+JiGOkG5PVA/1jjzQvUCaEjt/9ZQmDqHUzfgYds1UV24Pfk7yCeW0Hpj
	Uoc7fmn99Q6JHjSia5vfNA2FN8MdhiZRyZoxsqkKhXwKoyfUiGwrukHLivh9cQAWm1jbqRRK33P
	HDI2+FqKHKiR0HBMXJ2LzFvMWFFApRUGsa1EYT9Hp2KwahEJVObz2JDbz8HxWa6gTUDKVVQKenp
	dP3vl780WsoiEXaz563h4JhRxLx/6pjh2OeG+GhLfySaVqT1sRS3JnWRi47SjL+x0XZPc4Ojn3d
	BsHQeH5Ne4/3XkPIfbVgHmDzz+gH3/iUkEx2itgYL7d7e8FLIC+TB9+V0IQ9L14SPlPoJ+kAgDH
	3TqejmcmXxgy0WWXfsE0JCluCQdUw68CYLBjGJjdecIwMVk2QWPKqGxzS/P2NhB2RAFdBeKK1sx
	VhQ4hDoi87w7VpoUeHhT5zgCaiJIWBND7bT475EH8ghoRh413BFJ6R0ZIz6XJLaYgDw7dZ1vSA3
	/rNr48aHK5DTobqJPWPWY+p2lhynVkYPkzZtl6husMkAdEtFJXOiXPKcTC665A/wc5ilJmuFvo/
	PPWvMZL7ma7a2GJmz++NpbJiqF8ily1qs04R8A==
X-Received: by 2002:a5d:5f42:0:b0:47f:90a4:ff42 with SMTP id ffacd0b85a97d-47fd72ba4dfmr20398387f8f.5.1785717008087;
        Sun, 02 Aug 2026 17:30:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458b05fsm27676880f8f.28.2026.08.02.17.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 02:30:05 +0200
Message-Id: <DKEVUJFTGKN5.HQGLRFLQMISY@gmail.com>
Cc: "Eric Dumazet" <edumazet@google.com>, "Neal Cardwell"
 <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Emil
 Tsalapatis" <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v3] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Jose Fernandez (Anthropic)"
 <jose.fernandez@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260730-bpf-iter-tcp-refcnt-v3-1-754b9c8a6717@linux.dev>
 <CAAVpQUAoxyhmfbfCGeMUyQK7F4RifMsFDM0XyDqO9SOMZmASvA@mail.gmail.com>
In-Reply-To: <CAAVpQUAoxyhmfbfCGeMUyQK7F4RifMsFDM0XyDqO9SOMZmASvA@mail.gmail.com>

On Fri Jul 31, 2026 at 7:39 AM CEST, Kuniyuki Iwashima wrote:
> On Fri, Jul 31, 2026 at 12:33=E2=80=AFAM Jose Fernandez (Anthropic)
> <jose.fernandez@linux.dev> wrote:
>>
>> reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
>> the ehash chain, drops the bucket lock, and only afterwards sets
>> rsk_refcnt to 3.
>>
>> Lockless readers such as __inet_lookup_established() handle this with
>> refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses plain
>> sock_hold() while holding the bucket lock, on the assumption that the
>> lock guarantees sk_refcnt > 0. That assumption does not hold for
>> request_sock:
>>
>>   CPU 0                                CPU 1
>>   -----                                -----
>>   tcp_conn_request()
>>    reqsk_queue_hash_req()
>>     inet_ehash_insert(req)
>>      spin_lock(bucket)
>>      __sk_nulls_add_node_rcu(req)      // rsk_refcnt =3D=3D 0
>>      spin_unlock(bucket)
>>                                        bpf_iter_tcp_established_batch()
>>                                         spin_lock(bucket)
>>                                         sock_hold(req)   <-- addition on=
 0
>>                                         spin_unlock(bucket)
>>     refcount_set(&req->rsk_refcnt, 3)  // clobbers saturated value
>>
>> which surfaces as:
>>
>>   refcount_t: addition on 0; use-after-free.
>>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x48/0x90, CPU#1
>>   Call Trace:
>>    bpf_iter_tcp_established_batch+0x14e/0x170
>>    bpf_iter_tcp_batch+0x53/0x200
>>    bpf_iter_tcp_seq_next+0x27/0x70
>>    bpf_seq_read+0x107/0x410
>>    vfs_read+0xb9/0x380
>>
>> The iterator's stolen reference is lost when the publishing CPU's
>> refcount_set() overwrites the count, leaving the socket one reference
>> short. When the last legitimate owner drops its reference the reqsk is
>> freed while still reachable, leading to use-after-free.
>>
>> This reproduces in seconds with tcp_syncookies=3D0, a handful of threads
>> doing connect()/close() to a local listener while others read an
>> iter/tcp link in a tight loop.
>>
>> Use refcount_inc_not_zero() and skip the socket on failure. A skipped
>> socket is still part of the bucket, so keep counting it in expected.
>> The reallocations are sized from expected, and a request sock whose
>> refcount gets published while the lock is held across the last realloc
>> must already have room.
>>
>> A skipped socket is counted in expected but never batched, so end_sk
>> can be short of expected on a batch that is actually complete. Decide
>> completeness by whether the walk left any socket behind instead. The
>> WARN after the locked realloc checks the same, replacing an
>> end_sk =3D=3D expected check that could not hold on that path since
>> commit cdec67a489d4 ("bpf: tcp: Make sure iter->batch always
>> contains a full bucket snapshot").
>>
>> If every matching socket in a bucket is mid-init (refcount 0), end_sk
>> stays 0. Advance to the next bucket rather than returning a batch entry
>> that was never filled this round.
>>
>> Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
>> Assisted-by: Claude:unspecified
>> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Thanks !

pw-bot is asleep. Applied to bpf.
