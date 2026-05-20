Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACD3ED3A4
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297355; cv=none; b=ozxKs1k4bL4eutRL3rUoUNzCG+kD11O812wHOpaS83pzwq0QPv0x/ucIQksDDGJ1o+E1QB25zJNLWthRKYrN/sOO2XR1weX1eWa73GeFah7UH7zCvxSfBcbli1hW8tLD751nfXyzwq+Sqfxm1X52AELci9jmmqaEpVNhlMYzhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297355; c=relaxed/simple;
	bh=MLt2tnNzp74uVGtu4VkKS+MkXNeMGEZuFO6OXzbqmTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHJ9UrhTyTXC6fyt8JQq5ackfUgRxhZhhNGr/Pu/6/jcgOQRNdaOkA5klsvGf7sgcRZ8XkIyIufyI+SKALNiAFBews8z7O65ClUbUk1ovxJqmJYRKPd8jsAp9t5WK22l4wPnnVPPPoOJVEJSqTDpWEeOTh5LTORdEOZFejVjjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1EVlD0+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1EVlD0+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-836ebdeb969so2435509b3a.3
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779297352; x=1779902152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ue8SwT8+H83JFEChssYsR7+2GhS8y/4jRpnpitk4RZE=;
        b=F1EVlD0++I+2eLAxLUkf0k2lqcK+bZlv6Xr68KDJLtaWhBPjuIuUa1f+qlFzJTW+uB
         MXu2MlEIGHfH8Q+FVf9PgF1sKycVDMmiRA9+MHVDflLena7rtvYT10D9BV7tExme02+4
         cRBD1vtrDnzAmS6t7x5TZvdJY/BlgoTTXOCiopmvB2Yny1bWJTmmhsiYob6Bn91ZAW8Y
         wrbpPq48T07otDS6P1siyTY5qUuJdp/lvZlMRhtjqe9bzTMpjTSjqFbAVfvTT/Qsq0UN
         ThVyTEH9CnbwnTTFjgOVrRnpJ2wdVVRnyLQjemz/g1VyIS1cDuSjCFfUhB/75Ggfem3z
         W89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297352; x=1779902152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ue8SwT8+H83JFEChssYsR7+2GhS8y/4jRpnpitk4RZE=;
        b=cq/vF0zvEHQ2geaDqjj1aXw05r+7tC7I+D5ZZr7v5kJMnsPvZcOG6FytRELgMzdlgd
         bGrZyvg0AKCj1vXzN8OU51is41U743pmHjTBvxASakv0+Q1N8L+xnwIVKEQMxAu54KEQ
         5UIoEWxDKqVNBkDvSgWCa20QrdMcNf55oeMwOPQtHq68YxEZ8bMnUM6luIKf1RI96YNq
         XCE0Gql+eIkWVScVlcvjJ/shjgy6CaxsCvuzrQlQEtVnbpQ3CTip9f5uocVYXpC9/e6H
         qDElzJUb6VBYXVf7sIUtBiSSchT4mne+AmVkSda3qO+sKMxLYK+HC+Q8LtAft/qpkgvQ
         iTwg==
X-Forwarded-Encrypted: i=1; AFNElJ/fwXVGYFItP2e4eGJVWpIPCWhYnxPraCmt/6b8NajIzgd7LjTW2l551mWzvkYDGm2nBA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60aGl5+AdoZlQv4XgOAFjwufL7y0mqbCt1JrSKZE2NlnE6c8L
	iRnM4qOw/f3oj4mW7EII48eakxHVEAUhk+9VhQk3gJKZMjNCAIFwnj1IglBwRA==
X-Gm-Gg: Acq92OFaX/2DQGK+lopONfegzLLHuN8NKm3mnU85OWl3p2J/ZD3IorHfSp3ke4rNwV7
	AKrFWy1c2ef9CuqyIlxkg6QvqI2P6HbAWkPjxcR5JHgLUg57u8nw4nwX31IW18pGqHR5L4pVjsV
	gSOukPXdJ+2M5r7E6YWO5PIw3I9cXNH4bOuoYy/E5o4WKZKg/teqkLzMcAlEZK289H+kcr44cb/
	b0Lrn30l4grgXy8s2TGgdmoMtGf24SBWmnfQ2yKN6lRUwN4ah7DAXfCsRulTxSQ6MUKs+vNQ2Ok
	95uPp9UXZmVpw3947a1E/maUqjfjHYTLNGsB4k0/dfIWW6LaxiAlOuMyi0PgVAykq+6sVlN85jZ
	3GEIup/4aFhvUI8v+wb8tnMMja0yZsEe5muIgo2NteHmiTLrgZCgtWjCckWFypESxyD7CE5RJb1
	UAsj4sghmnD6pZzEgmilayUkJ5lD7tCK8=
X-Received: by 2002:a05:6a00:240e:b0:835:cc47:6fe8 with SMTP id d2e1a72fcca58-83f33dae668mr26095823b3a.46.1779297351847;
        Wed, 20 May 2026 10:15:51 -0700 (PDT)
Received: from john-p8 ([98.97.43.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660easm21263882b3a.11.2026.05.20.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:15:51 -0700 (PDT)
Date: Wed, 20 May 2026 10:15:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Christopher Lusk <clusk@northecho.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: tls: preserve split open record on async
 encrypt
Message-ID: <huduxtn6parzgiaf5cyiyrrvjjvx6jsdedowvrd4nkwmuyeind@j6migjgofh2i>
References: <20260515151556.189841-2-clusk@northecho.dev>
 <20260516151628.F18DEC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260516151628.F18DEC19425@smtp.kernel.org>

On Sat, May 16, 2026 at 03:16:28PM +0000, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>- [Critical] Error masking in bpf_exec_tx_verdict() leads to zero-copy Use-After-Free
>- [Critical] Use-After-Free during __SK_REDIRECT socket lock drop
>--
>
>commit d94934a96df0cedb5ae4fee1bc9264e363a4efb9
>Author: Christopher Lusk <clusk@northecho.dev>
>
>net: tls: preserve split open record on async encrypt
>
>When a BPF sk_msg verdict reduces the apply_bytes size below the open
>record, the record is split. This patch ensures the remainder record
>remains rooted when the initial encryption completes asynchronously.
>
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 2590e855f6a5a..5682849e102c7 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>
>[ ... ]
>
>> @@ -861,6 +869,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
>>  	struct sock *sk_redir;
>>  	struct tls_rec *rec;
>>  	bool enospc, policy, redir_ingress;
>> +	bool async = false;
>>  	int err = 0, send;
>>  	u32 delta = 0;
>
>[ ... ]
>
>> @@ -910,6 +919,10 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
>>  	switch (psock->eval) {
>>  	case __SK_PASS:
>>  		err = tls_push_record(sk, flags, record_type);
>> +		if (err == -EINPROGRESS) {
>> +			async = true;
>> +			err = 0;
>> +		}
>>  		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
>>  			*copied -= sk_msg_free(sk, msg);
>>  			tls_free_open_rec(sk);
>
>[ ... ]
>
>> @@ -979,7 +992,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
>>  	}
>>   out_err:
>>  	sk_psock_put(sk, psock);
>> -	return err;
>> +	return err ?: (async ? -EINPROGRESS : 0);
>>  }
>
>If async is true due to -EINPROGRESS from a previous fragment, but a
>subsequent fragment encounters an error (for example, if __SK_DROP returns
>-EACCES, or if tls_push_record() returns -ENOMEM), does this return
>statement mask the -EINPROGRESS status?
>
>If the error code overrides -EINPROGRESS, the caller tls_sw_sendmsg() might
>not increment its num_async counter. When the send ends, it could skip
>calling tls_encrypt_async_wait(). If MSG_ZEROCOPY was used, could this
>allow the function to return to userspace while the hardware crypto engine
>is still reading the pages, leading to a use-after-free?

Christopher, this at least looks like a legitimate concern. Did you plan
to address and send a v2? Or explain why this is not required?

Thanks,
John

