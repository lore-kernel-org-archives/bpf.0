Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B646D098
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661849; cv=none; b=q8HLoxRDpEzIN/k7jsgyxHFIFLVQs+Cjm1oXSMMJwPYpijLrpZzFnHh2HMx189YBuNLK/pzHUyr0lx6UEkzdYv011pH38tqh+JTlOlcJ7eMCI87LN3CbmuuUnV4dBk3+2qDq18Jrw2vrsclOwJ0dwLPILQWuWAG83WiBxqMdXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661849; c=relaxed/simple;
	bh=cORZVbqM3eFwRSKUS7EP2gVPo2dqxwN0ZywsfK6umOM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=oLKGoL9wIuX/e30sVjbpbd9sfR8Cr6M8gM2uQpqQzdknC8uWP83hoQ3SYpJUR2BdLYv2D3AYHp2lAoOCiYA6hrnyz5PLhqcJVy19kdCv6TIOM8kVl/kflwsVllFB4lx5dd6awpuwOuKTa+kBf/rR9qPgqRaRUmN6i+GXErZ+iR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhsDLMvh; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhsDLMvh"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-493e55619a2so24256075e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784661846; x=1785266646; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hZgHks4ec8eMjqtz7edpvaA3KS3nyRCBHqNjcy/fc/U=;
        b=qhsDLMvhQFi8L9oudMZSjsoRZkV+cA9aSSK2Avzu8Kmes3S/Izf5cqglFPXLVfYGGI
         ngz+W8Jy+u7CQcHpXmxV5O4rPXxkh8AyOZo4KNHhTO+jz/cfvTFGj/V76DeiXvXzY0MG
         3nkWap50KPNGJzupby+jxHqSx13pGNR8aKdf/weEu5kurhmnXex8Ox5rn6IEUXMjI8gQ
         Doin3coAYtjYrrw3vceGZlFK8v28B6ioUZZ474Hs77qCKdIocXkYFD3CumArym4Lugu6
         SSuKqfKMkZ6r2M3jrV6//Lyny13JPEKyrFOc1JENuS6nyaGSmcwHuioUrWDWyxx8GKvG
         uyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784661846; x=1785266646;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hZgHks4ec8eMjqtz7edpvaA3KS3nyRCBHqNjcy/fc/U=;
        b=mma9ALg4EluXVDqr6RDMZDN91/vlnQrmuoa00Zo5BbsYa7q2/LWhb46QupvQGSDZIE
         drABb/W1jgi+iKGkiMKRWTxzHvALtq6Z7+gdTV+26ycNIETaMvsnHePeSttVlf93+yc0
         VY7qymFmDm1yct/aZDZEFAuHPgdZ2mQXtbsDE0uRSO9UCD5vZVqJEAvFbDgd4NvKjn2A
         Dg9mISw7Pwt4SLfDZSPqpEo04zxywpkFKdBXD7i79g+mhZmQ498UvVOKf4b4oADUQh7Y
         I/hSxtWIDeHhC34XjN6UDdlfMUlEJLKBwn88kdIiEICiO84r0YNGLylgcnlSd3Xb80Nm
         9eZQ==
X-Gm-Message-State: AOJu0YzziLBex6XmUigVRpAP5Re7Ni377STsSDo5wkBokBzBwykBSZv5
	L0l48IOMyqHVNVs8vgsk91Bl9WRtkEdFi/3GvIWYVAKyTwrdgXN3wjNM
X-Gm-Gg: AfdE7cl+4FoqSqEr9rHfKHFe7TA4NQrxOHUmZxoAeWC6JLBTUhUf+lWpWfck9z/MtoB
	k+HaLFHevoa9CcBOJRJCRKEecljFyLL8efmNwuOEL53Hs5O4rFH+2N7OpH16E1e+Wr6VawuyK6K
	wn9ZuuyZK6pIovunxEcBLEnIpxxhfXubiv5LoaMebP9ICGq6QXXE3g3qbn8TiFpNdgUzsBYMtjX
	NDADF4U262Es/JVYUIjAZnTioitfhLavkx6GnXSEACOKZDZR/7s8K3maXxB+wz0eXokqFeTkUku
	56vdrncmxECqDlK1nMjz2rA0BAMpKRTn5Cr1qzt7iqolqkWgUu9BtSVVWOawXKiD1LVnWG0CtqS
	GqhrXkp6glIu/qZ865GibDbcQAGhl/FyP/hBwl9PLw6beX0qYajHTYNdw0nm6CszPPC6PJFYWut
	YiwBYD/H4R4XVOGlRYF9rqn0w5Dx0Y7CHY6XCvnnXVHJOXMZPrxe/qoT/psQxSbLsK9EM58Rdsd
	Tva0R2HaiXmCNCS4y4JIYVqSOkVio6huXkrZvkYhBh1oandnPEzWjg=
X-Received: by 2002:a05:600c:45d3:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4955233b700mr171381265e9.2.1784661846199;
        Tue, 21 Jul 2026 12:24:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51986sm46719237f8f.11.2026.07.21.12.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 21:24:05 +0200
Message-Id: <DK4HTPHX3NL8.2N1FK8D2N9521@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Jose Fernandez (Anthropic)"
 <jose.fernandez@linux.dev>, "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260717-bpf-iter-tcp-refcnt-v2-1-8e81f0ac6f3e@linux.dev>
 <20260717025253.23EEB1F000E9@smtp.kernel.org>
In-Reply-To: <20260717025253.23EEB1F000E9@smtp.kernel.org>

On Fri Jul 17, 2026 at 4:52 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Low] The patch introduces a multi-line comment that violates the BPF s=
ubsystem comment style guidelines.
>
> Pre-existing issues:
> - [High] Double-put and wild pointer dereference of batch sockets on the =
first bpf_iter_tcp_realloc_batch failure path.
> --
>
> --- Patch [1]: [PATCH bpf v2] bpf: tcp: Fix use-after-free in bpf_iter_tc=
p_established_batch() ---
> commit c52d637a13758169d9dce0d7c05be97965d399d3
> Author: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
>
> bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
>
> This commit fixes a use-after-free issue in the TCP iterator caused by
> request sockets being published to the ehash chain with a refcount of 0
> before being updated. The fix uses refcount_inc_not_zero() to safely hand=
le
> these sockets during batch iteration. It also refactors the batch complet=
ion
> logic to rely on whether any sockets were left behind during the walk.
>
> Link: https://lore.kernel.org/bpf/20260620-bpf-iter-tcp-refcnt-v1-1-883bf=
9e69495@linux.dev
>
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -3073,24 +3073,24 @@ static unsigned int bpf_iter_tcp_established_bat=
ch(struct seq_file *seq,
>
> [ ... ]
>
>>  	sk_nulls_for_each_from(sk, node) {
>> -		if (seq_sk_match(seq, sk)) {
>> -			if (iter->end_sk < iter->max_sk) {
>> -				sock_hold(sk);
>> -				iter->batch[iter->end_sk++].sk =3D sk;
>> -			} else if (!*start_sk) {
>> -				/* Remember where we left off. */
>> -				*start_sk =3D sk;
>> -			}
>> -			expected++;
>> +		if (!seq_sk_match(seq, sk))
>> +			continue;
>> +		expected++;
>> +		if (iter->end_sk < iter->max_sk) {
>> +			/* reqsk_queue_hash_req() inserts with sk_refcnt =3D=3D 0
>> +			 * and refcount_set()s it after the bucket lock drops.
>> +			 */
>
> [Severity: Low]
> Does this multi-line comment follow the BPF subsystem comment style?
> The BPF subsystem guide expects the opening block to be on its own line:
>
> /*
>  * reqsk_queue_hash_req() inserts with sk_refcnt =3D=3D 0
>  ...
>
>> +			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>> +				continue;
>
> [ ... ]
>
>> @@ -3128,12 +3128,14 @@ static struct sock *bpf_iter_tcp_batch(struct se=
q_file *seq)
>>  	struct sock *sk;
>>  	int err;
>>
>> +again:
>>  	sk =3D bpf_iter_tcp_resume(seq);
>>  	if (!sk)
>>  		return NULL; /* Done */
>>
>>  	expected =3D bpf_iter_fill_batch(seq, &sk);
>> -	if (likely(iter->end_sk =3D=3D expected))
>> +	/* sk carries the first socket that did not fit in the batch. */
>> +	if (likely(!sk))
>>  		goto done;
>
> [Severity: High]
> This is a pre-existing issue, but I wanted to ask about the reallocation
> failure path that occurs just after this block in bpf_iter_tcp_batch().
>
> If bpf_iter_tcp_realloc_batch() fails, the function calls
> bpf_iter_tcp_put_batch() and returns an error without clearing iter->end_=
sk.
>
> When this happens, bpf_iter_tcp_put_batch() overwrites item->sk with a
> cookie:
>
> net/ipv4/tcp_ipv4.c:bpf_iter_tcp_put_batch() {
>     ...
>     while (cur_sk < iter->end_sk) {
>         ...
>         sock_gen_put(item->sk);
>         item->cookie =3D cookie;
>     }
> }
>
> Because the seq framework subsequently calls bpf_iter_tcp_seq_stop(), it =
sees
> iter->cur_sk < iter->end_sk and calls bpf_iter_tcp_put_batch() a second t=
ime.
>
> Could this lead to a wild pointer dereference when sock_gen_put() tries
> to use the cookie as a socket pointer during the second pass?

Hi Kuniyuki,
Thoughts on the fix and Sashiko's concern? (The latter should be probably b=
e
fixed separately, if needed).

