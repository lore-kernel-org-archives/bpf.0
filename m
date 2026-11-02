Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645688;
	b=ruaXclrkF6jE4O+IxBH6tFyDPHikT7cqa7hEKxZ8BRSq7DXl67/VF9NvrXEUbu+IF+YT
	 6uDoftmC+cfXDpDy1L65Bj+mfTsmoJODKFOV2arnTObQPifM9F8V3Hs89XgG15gMMS5kZ
	 5z9KLdSaim+1DfFeBVGqabPbFqml6OH6r3Zl6BD9u7tzzBR/CYqTbFMz+1WKOnU0WT8Un
	 7MRikFpkjhah5C24Q+SO697TQkmIDO5fmHZXlp4b7c8PJ3DXEt/Gll2cPz3aKibVxcLh2
	 mTWhJPGJxx741R/qrPlLKCmTGCAI2g73Zxa1O7Dy6bMtrVkhN4C0GvWQDW5LmqMBvaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=6aeVIk6rnbx33zfjOjUUS+2fD1SQ2yd81uhuQUT7lRc=;
	b=MjMr/dJ8v6xTDwSWxElEHTCRokzies1RNRXAl2hrec2xPVIPCffV0H2YGv1VKjEt/YGC
	 Pzo5w0PJ0to+CVI9XdBhk82K8/K7GEv5gk4/vv1MICaV3JOrmey0KYg+P1vXo49SKFb1K
	 EbzRQdf3/EPREEvCyegNncRHwxl2b635G+iEKZ8VcXRS3l8PesvoXN0qd9PRnhrBpfbHf
	 n+pxVf+BISzsWHTCAn2i7P9ZRI3Cyi4pfBQ+w+N3v37Q+Za+9fPG0Wq8dXSTVEwSZ1C+i
	 lLcUrB0D98/3azqqp6Zo1SHns9TUs7us1vP35ZdiCNRvU8up3StUnm2k1Af7BmeToog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hcfC1PbP;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAFD606A32F
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 18:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDAFD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hcfC1PbP
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ccca948203aso1253083a12.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 10:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793645687; x=1794250487; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6aeVIk6rnbx33zfjOjUUS+2fD1SQ2yd81uhuQUT7lRc=;
        b=hcfC1PbPoIdiB7FzTh3mEBmRHJNkNfHudgqL5I6jaPuyVN+QtQMg7IlzD0phqrxyec
         4El+qeRC5so1Y7Lu6P9KU1w/wRz483M6vWWqmPNCbf4tB7P0YqPqikfH91/rxa8qPfTt
         43H2uy0Hzt9Kv8RHLhx351JhDY/LhumttS2mosfwnFhfugaVHsxGC7xJMrFiAB6TthB6
         wHe4B9kQzZJCHfFro6PNcEtO61UWFYVa+bBdaGpSC0HNm2d0Csnm/OXxELOcxXhaY4uW
         rryAUm/26VRK3eMpGD+wEOQ9i/IJz+LNMCAo/I8Y5J5Y47a7CdGSYbtW5NW+QqTGqDWn
         QAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645687; x=1794250487;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6aeVIk6rnbx33zfjOjUUS+2fD1SQ2yd81uhuQUT7lRc=;
        b=ojOK1w72G/wGS2I+JBIKJuoQQzHBbh8GPgIzbw7myPSxQVGEditag1pY1GMwjvO3SS
         8MvmCoR5rqxQKRN6xmv4kFoRZ9ZOgwyc6MkSatCNHqKTVlW4kguZ4fGj8sBFrmQIJWj6
         tKLxVGrRBeFDICr4Dy4hYowzRDaZENrZ8Kwzl9RcfUSOYiS0m9E+eXOuEior8mXRPgqv
         oXFjnLpSGrIKSQEdQUrS8ybmSPXNGddjyasWI/8VuNrxyOHjkCKs/lSZIY3tGl0yERRH
         +AszZYV8OwazHRMikSj5o0prSHn/PgIMq8poNULCxOpK153PcI2Elr1QVFoaDQan7tdF
         rQCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAJHSFdoGxPnhhNjb50O2hmStkTXk/Nke9ElbW6hlYHGUHUN2cnC39j92xxbbjWDpSLsQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Pb1ND87wmuZU7FtlujD13KmOBGiJaaA4PvEw5k0hcGBp1GF7Y
	U+mdE2lxTxZftH8+o3OjvnlGa32lyNSK2WQjlAzfI/U2klRBAq9LFPay
X-Gm-Gg: AYBFou1FyT/96Gaud8TuppSO+ssXYHk3TUeAeWQAHwEJ9Sn6UOlu/ZBFGwqYpuX1MzN
	IKwd77c0Um4pw5UgCbF4Be46ROAN/zw1ru6sOh4/1b4tHRFkNRZvRrB9ul4zlYSx6Cdh15Q1wdO
	ehstOL1C8h7gErS7Pk5lwQXtozeA/1NE5PLzO4kUkSkItt0S/izIVbKx8F27aTzgehWnq5eodFr
	dK3Sc7k/LVc2WzVMZFRYgU5Sll3iaLdA3wSsW5K57XRq5zejyUJwXu/CF5ZPsHksjakRY5NbO1f
	jZqFsYbIL8aSzd8EAdhiwQYIPqAi3joW35e8PR+EU5B8fJtNSe4MgCxGun/4T5oqiWyapiHtv6L
	IZreJ+gjlJ6ydnOTMm9c+lbRpt66KxAX/vhoLJpFHamyQYM5KUo3DfJfVPgWBjMJDzgOFysqC8w
	+pAbRY6U5E/sUyBRLAd2MfRjWzlHU+FSnL/sfM6GkgjZirFL+LVrowEKLdlTXurrRGxzjD7bQ8I
	KAkXbspl7soOExw5BP9o8beUfSfRktg/pBx82kfuQyos0TFK/aQNHlXDB9ztXfplOLK2+mHnu5a
	IIvkUNJxcKNZKtTVhnDDVkT9CCEXOi/lvyfHxRyo4Ia4Z56sAyWTyS9gJDesh3AcvF/2rjuXdbS
	myVERETctFfFupw==
X-Received: by 2002:a17:902:e88d:b0:2e2:c55c:90c with SMTP id d9443c01a7336-2eb3650b7b7mr104071795ad.64.1793645687169;
        Mon, 02 Nov 2026 10:54:47 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39266f42sm31215645ad.40.2026.11.02.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:54:46 -0800 (PST)
Date: Mon, 02 Nov 2026 11:51:58 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
Message-ID: <tnw1v9.qyjuvdc9kq45@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:21, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Alexei Starovoitov <ast@kernel.org>
>
>tcp_bpf_send_verdict() keeps the verdict of the sk_msg prog in psock->eval
>and runs the prog only when eval is __SK_NONE. For __SK_PASS it resets eval
>only after tcp_bpf_push() returns 0. But the push can release the socket
>lock in sk_stream_wait_memory(), and it can fail. Then another
>tcp_bpf_sendmsg() sends its message and does not run the prog.
>
>With bpf_msg_apply_bytes() the verdict covers apply_bytes bytes. After a
>failed push, apply_bytes still includes the sent bytes. Thus the verdict
>covers more bytes than the prog requested.
>
>Reset eval before the push when apply_bytes is 0. If this push fails, the
>prog now runs for the rest of the message. The same already occurs when a
>message does not fit into one sk_msg.
>
>When the push fails, subtract the sent bytes from apply_bytes. When
>apply_bytes is not 0, eval stays __SK_PASS during the push, and the prog
>does not run for another message, as today. The verdict must still cover
>the bytes that a failed push does not send. But such a message also lowers
>apply_bytes. Thus, if apply_bytes is 0 after the subtraction, end the
>verdict, as after a push that returns 0.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>
>Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---
> net/ipv4/tcp_bpf.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>index d90bcc911b36..b016aa419fb2 100644
>--- a/net/ipv4/tcp_bpf.c
>+++ b/net/ipv4/tcp_bpf.c
>@@ -457,8 +457,22 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
> 
> 	switch (psock->eval) {
> 	case __SK_PASS:
>+		/* The push may sleep without the socket lock, and it may fail */
>+		if (!psock->apply_bytes)
>+			psock->eval = __SK_NONE;
>+		origsize = msg->sg.size;
> 		ret = tcp_bpf_push(sk, msg, tosend, flags, true);
> 		if (unlikely(ret)) {
>+			/* A part of it may have gone out */
>+			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
>+			/* Another sender can use up the rest during the push */

Interesting. We've never hit this with http parsers. We do use this to
skip payloads some times.

Thanks.
