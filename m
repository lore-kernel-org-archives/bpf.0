Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41F2E7635
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054735; cv=none; b=uzjTwZ1OmjU7+Dq5CW7QaLtMUx/rX4Ky1O6sSywq3Z4Yo5HyhgrqPjGVrz+t8ZGfeNAXYhcHqrYFyK2PeC+L+04GtsBssiJbtacw/79DV4OC91zR58znrYEILQJ6cDzv83tbU2pd2CLGVxTChpJYl/x70sLiTAwCzG3oTigrFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054735; c=relaxed/simple;
	bh=62uohTRKl0OM+sEC4Vkt/hhO6ul8Eq0uykp/8L9mEVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ3vbHctu6+PcIuM394KGhwocY7X/N9tB8FbAENp/yE1ZS8ic6583K8ywb3vs1pnwnngkxXgErKF5o7JMx7EQQAbzop2/FMvi7kAXgDscS09C4dNkxOduFCkPK0XRIWwSAful7fztLPy2REvnCP8/nIIofj7O0GLeF51j6tPtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV4hRQn6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV4hRQn6"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381018b9375so5260244a91.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784054730; x=1784659530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b6nkP4rSjqnpaQArQbVk/tr97ZX+rJm31+SVlfb5Lu0=;
        b=YV4hRQn6dzehF2rVe/iwKs8Ffg2aJT72hWb9hMocZ7ve9m5r5YPUnbJ/ZxWSCn44eP
         G+elCIbjDz40B+mIlCGp57BE8n+Gbz5NXnpNrjBGaW8SndfXT0ksdMfzjg0qGeNQwS7r
         olBIIF6wRgPJ6fV+G4mCwT0NkYDmqRqVLKcuCGsIVR3lxq1oPvYZHWwtuKXJcIxJV6/L
         0UO+h0D6311ColeRvds1jfBH6FqIwkf/jQb5Hqh8urC+LvPf6OrGjz+/9UQIerWBk0gw
         WIg7YIi7W9FvIAdy/eCWGNfp1UzVnmscDJq4Skl+F8ASwhiVD41EAiPtw3MdCD4wyT8Y
         0sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054730; x=1784659530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b6nkP4rSjqnpaQArQbVk/tr97ZX+rJm31+SVlfb5Lu0=;
        b=VPAVi3dodefETXKvpenBh2DkwkQw7GnhSLQVjuJuglNiuETErCNbsyWgkDlDe3Da+L
         v776VN9WEtX0uH3YvUhwDaAFYYsIL9DDsUeislrBsrb4SgKXXpmuQBf8j5xMFNdcbvg+
         rU3SZs3eCDf4cX3QYvW45BC/Oyk0GGBjoasei8QAto9i18X497b5bUzYTbX12Bi6xwJD
         T/E6FcaPa2Q8P2IDA8yycoIfVnKEiohKTg3MjM1+fwUQeY5ZSJSlzmd/Q48TLu4qcfmF
         EvO0jGBVfVYKe1Rv7okLtVShThkr06eAMl/QW7QP4/bH5fMbTyujg7kUcBo5C0TL0w1e
         iQ4A==
X-Forwarded-Encrypted: i=1; AHgh+RqEpq+IUCo9yRk4XTRewrJU4K+aWbIRKzqX9BKSO0sQHlVTjLHce8WYgsA6U0g5v1tcJVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67aTsUMEDRDiH2jh49fNcU2ZrRtUerA3K7DYHiEMOJNStfOtf
	vHXInopTQC1Ep3y90y2TbhNKwp2HBT+m+erTaJnIuUzTDywL4BmJa6Oz
X-Gm-Gg: AfdE7clmhspfCRKdHkmoofSPfKbhuDqYLheho/jqH44NNxWlLOQ8MlQj1pyZ/qwFKh9
	qj48hcsGN8LdSANDvmVF2IXI5le1CTGa2rhRM3Ur9KRHze5KORRybN6bONKv2qx6HDGTNtVhYxR
	pwRamgSzFpoLHyTY8mvfcZGGTSihTY9ZlxGuf01cGLxctVNF3jL9KQ8fBwmwqqKkrz9m0TJ6B95
	ePPD/eJr+wjG8jo31IBK0DMd+XdU3THQox+wGYfQ+JXh/GL1p7+rUtnBrAtSNKFIVjoa145BhMC
	voP8UfscNuz4ennmeOwa6DO8otbdgE7RGfghPpn/POwrOl6Zc4vfPHDjUymY18zaqWzSnKQd2iB
	CqY/FuusICP1YyFi8MxLmYx2rktvBLFZGrLkDJhocHvK7/NRaV7CvC+0VHs4s4A4793w5OfYt6D
	juBzmdZ21SIA==
X-Received: by 2002:a17:90b:1fc6:b0:382:5c31:1f8a with SMTP id 98e67ed59e1d1-38dc7769973mr13933137a91.27.1784054730379;
        Tue, 14 Jul 2026 11:45:30 -0700 (PDT)
Received: from john-p8 ([98.97.42.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172b6da2sm1946213a91.4.2026.07.14.11.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:45:29 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:45:27 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Mattia Meleleo <mattia.meleleo@coralogix.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program
Message-ID: <alaAp3qrrn3XYd8u@john-p8>
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
 <20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com>
 <20260708171659.8695B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708171659.8695B1F000E9@smtp.kernel.org>

On Wed, Jul 08, 2026 at 05:16:59PM +0000, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
>New issues:
>- [High] FIONREAD (SIOCINQ) double-counts available bytes when a verdict program is detached, exposes negative values, and under-reports bytes when a verdict program is active.
>
>Pre-existing issues:
>- [High] udp_bpf_ioctl() suffers from the exact same bug that this patch fixes for tcp_bpf_ioctl(). Without a verdict program, data stays in sk_receive_queue and UDP FIONREAD returns 0.
>- [High] Data race and sequence number corruption in psock->ingress_bytes during SK_REDIRECT.
>--
>
>--- Patch [1]: [PATCH bpf v3 1/2] bpf, sockmap: Account for receive queue in FIONREAD without a verdict program ---
>commit fc144ea49f61a51adcd404a526d68065c61d0452
>Author: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
>bpf, sockmap: Account for receive queue in FIONREAD without a verdict program
>
>This commit modifies tcp_bpf_ioctl() to add the output of tcp_inq() to the
>reported FIONREAD value when no stream or skb verdict program is attached.
>This correctly accounts for data resting in sk_receive_queue that has not
>been diverted to the ingress_msg list.
>
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index cc0bd73f36b6d..8e905b50deadb 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>[ ... ]
>> @@ -344,7 +345,21 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>>  		return -EINVAL;
>>
>>  	slow = lock_sock_fast(sk);
>> -	*karg = sk_psock_msg_inq(sk);
>> +	psock = sk_psock_get(sk);
>> +	if (unlikely(!psock)) {
>> +		unlock_sock_fast(sk, slow);
>> +		return tcp_ioctl(sk, cmd, karg);
>> +	}
>> +	*karg = sk_psock_get_msg_len_nolock(psock);
>> +	/* Without a verdict program, ingress data is never diverted to
>> +	 * ingress_msg: it stays in sk_receive_queue and is read through
>> +	 * the fallback to tcp_recvmsg(), so account for it like
>> +	 * tcp_ioctl() does.
>> +	 */
>> +	if (!READ_ONCE(psock->progs.stream_verdict) &&
>> +	    !READ_ONCE(psock->progs.skb_verdict))
>> +		*karg += tcp_inq(sk);
>
>[Severity: High]
>Does this conditional logic double-count available bytes or under-report them
>in some situations?
>
>If a stream verdict program is attached, data is queued (which delays
>tp->copied_seq), and then the program is detached. The unread bytes sit in
>both msg_tot_len (ingress_msg) and are also reflected in tcp_inq(sk) because
>copied_seq was held back. Adding them together here would double-count the
>available data.

This is fine lets ignore this for now. Every system we have adds sockets
to the sockmap on connect so this condition is not seen. And above 
solves common case.

>
>Conversely, when a verdict program is active, tcp_inq(sk) is ignored. Could
>this fail to account for unparsed data in sk_receive_queue, leading to an
>under-reported value?
>
>> +	sk_psock_put(sk, psock);
>>  	unlock_sock_fast(sk, slow);
>>
>>  	return 0;
>
>[Severity: High]
>This isn't a bug introduced by this patch, but udp_bpf_ioctl() in
>net/ipv4/udp_bpf.c appears to suffer from the exact same bug that this patch
>fixes for tcp_bpf_ioctl().

Sure but doesn't need to hold up this patch. Mattia would you want to
fix this as well? Otherwise I'll put it on my list and get to it at
some point.

>
>net/ipv4/udp_bpf.c:udp_bpf_ioctl() {
>    ...
>    *karg = sk_msg_first_len(sk);
>    ...
>}
>
>Without a verdict program, data stays in sk_receive_queue, and UDP FIONREAD
>constantly returns 0. Could a similar fallback to the native receive queue be
>applied there to prevent user-space applications from hanging or dropping
>packets when relying on ioctl(FIONREAD)?

yes we should do something here.

>
>[Severity: High]
>This is a pre-existing issue, but is there a data race and sequence number
>corruption in psock->ingress_bytes during SK_REDIRECT?

yep pre-existing needs another patch.

>
>In sk_psock_skb_ingress_enqueue(), psock->ingress_bytes is incremented without
>locks:
>
>net/core/skmsg.c:sk_psock_skb_ingress_enqueue() {
>    ...
>    psock->ingress_bytes += len;
>    ...
>}
>
>Concurrently, tcp_bpf_strp_read_sock() locklessly resets psock->ingress_bytes
>to 0 and uses it to adjust tp->copied_seq:
>
>net/ipv4/tcp_bpf.c:tcp_bpf_strp_read_sock() {
>    ...
>    psock->ingress_bytes = 0;
>    ...
>    tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
>    ...
>}
>
>If another socket redirects data to this socket, the target socket's
>psock->ingress_bytes is incremented by the workqueue or softirq. Does the race
>with tcp_bpf_strp_read_sock() cause redirected bytes to be incorrectly
>subtracted from the target socket's tp->copied_seq, artificially holding back
>the ACK sequence and corrupting the TCP state?
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com?part=1
