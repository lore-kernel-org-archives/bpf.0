Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646795;
	b=JOqAhbcOeuWUTqsNn08+KD0yVk88iiV4lC+odsz35RsNymjDHdf5+7+Eb2UywIAY/qoy
	 M5+tKkoGyNmWpXNRYlm+4TkWGuIRX1PzOW+OR78Dp6tSGwrGnEozuER1kF2Rq4SjZ7F/f
	 djMiYQvVob+tvGeLdJXytOIfZBPdNxJ2Ll64LaozZU/ibhGaBv8U9cSiTG81ORS67X+1N
	 mxlqmQofsISqM8Qcz+F4Jpay3v/qOmEU4072yRsbSvTm6v7ULRb00cBfGImREi3t7bJtS
	 Cx4VM05J889OMc/O+zd9tTCAAWmh0yvYcM2EqAONtiIGySFxeEuP4GMgt52wE11i1MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=qWSc3wxeA0aUeT06xpUv57ACRWiYfD6BXLwXzl7b/xU=;
	b=JE3UsXO29D5eCzlgYcArF+aGiitT6eTzXS7a/i2TzHiT6gK42QngzuOP0e+5Qh7kEky9
	 yNlfOphWA/ZO/EgIV0o56IWh6W5cEkfgFksFb53RtJAi/2EFfoP6r+sKt8S0GK+QbcM75
	 8lHkoVwp1PXGSDNJyyhfv+BFT9E/+LxCGiAsJKuvcf8JNDLUXexhjTys2An/E56EW+9tX
	 VtQ76hR4BK4e5ANMKNxKFlOnuJNWBDpcLuj/GRNUjpn8R8CT224DdKNbrsez/PAgxpNdU
	 2OLyayIlCpgyMUlbUWFqjSHFGqh7Pdui8EKBxGHIryyEgL6adjKRsMV9FlVandl3rWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AGgIgNYv;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F4606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE2F4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AGgIgNYv
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc758830601so2071363a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646794; x=1794251594; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qWSc3wxeA0aUeT06xpUv57ACRWiYfD6BXLwXzl7b/xU=;
        b=AGgIgNYv+1UTnvfh/F07/DULKtzMOSoD7VEwy6wFpWFPnWWmGUJBsR1uXYYRIufWr6
         9ZwCr2EIRbWAzrBR4o1aJJhEBn3G7/KNe5lyhpFrA7DNQ8w0GlbjnI0wt9tvTJg/aSh9
         qoaUBjGodgVKzQnV3wRlptSZ/BhltVMcRK26772justhnwVP6v4kJFKyio3x7KbAQADq
         J0P2vUb+ruGwWzNjX0/WoycfTdBwwR01pdS6qioqjZvyiuZ49N5ojBt1UA+L0v/VS/ZY
         Cvtoma1S7MF8t+7/ux+4RgsIky4t+L+XlBIA5ZGL/ZTkdqMHHvJhLghtVrKKm8AjkH2o
         tv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646794; x=1794251594;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWSc3wxeA0aUeT06xpUv57ACRWiYfD6BXLwXzl7b/xU=;
        b=CzC/MytgJnJTJcJc+Kpo57WBCebadig9JRgKY8Kq/3rTAVRPJKCqBZ1Ze7xiuagu/4
         463bsHuJOtxbUQA5UH8CdIWGMAo9MCMm4Jv6WMtFL5JtUFd9L43X9Q832oskCVxf3Y0i
         lUUtO+IoBbW9nxf8X663MlePw/Gz1a6pwGezTrjKWwJDwGgCp8bfvSzVgfQcwPfHFB6C
         pmt4OFvNvr8epCI2ZIVwnqnjK/N89iiie3X4v2zdaMLkg7+mHUPlkFYwapye7YxB/QvH
         7eqJfU8jKnIm7BSaN1euoqSh5dC0v/8pP9sEL0naKR1kos2WWg212Qgk39fknGPHxtA9
         a7dw==
X-Forwarded-Encrypted: i=1; AKwUvBwEyQCtc7Qs9Bw7NpFHnTqMDeLLPH6Rn314KNUoCYu/yDOhmV0hC2TjLMit6oQ72ocRMfg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Zt8h0h9U0vDyDOCK2Sd778YJa0juVBGpccHyhcrWF0bXtRd2U
	w+N2XdzDIoQTojCUaXvcxe+6Ls32Pabm0LqDurbLXMB3nYkaU8D8PXG9
X-Gm-Gg: AYBFou07yoWzGWc9c0jbeUgN7992sEONaOqWJoGKxN9w0T0BnDDILW5vrJFQy8MRAQv
	/rphaZ4K68cmEPthWrtZtdXkJ/4axiBik8UH84YX9nw8GRQwBPj2KAokYlnJuxK6ezHjC+sGzr3
	QgW3YHy60EwF+EeHWVKrv5EaKHIROBUGila4IGU9Do1H0KBeB/l4kDp7DqMApql6mdKL2tfSUyC
	BimXmTsDKl0QDXCnEq+pLkxdzfeap8ZDk5ulk7dezK+3Qj1RAxfuHuufrzONfEBixw0KNddFY5J
	P+7lBVs5C4IokrhIMg9IAZ8CD+bXv0KvD2aO2uTUfjf/ymw2QMB5dB1+r9tTIrjoIEGXuzFbDof
	iWvJDxZZvcrObj2IDbo4iv04bbpnj1QWFkJ8gxY6t+Vf6rGOBIazTRf68MoTfGM7DTpef7tSK1A
	Yg4EJkY/Pxqe4I3sqXJxx7wrmP2Gsl/0xEymxYz2GNZ+PzQpzfUvbMbKy450rSHso9soK7763Uw
	2CQIxaBzlv+7woICHnKQ1vtG8X57XpNlnb81s5+VJaKSf8voX2i2Vi1b90Tf5S/ikTf1IDaNhU5
	2w2dqumMmirGfV+p+4omrbkgArk2szNdl+9mYpZluHdz3HrHLv45nimwTgT2KyfCXnZt
X-Received: by 2002:a17:90b:3d4b:b0:3ad:eb4c:26fb with SMTP id 98e67ed59e1d1-3ae897c87acmr9116933a91.23.1793646794112;
        Mon, 02 Nov 2026 11:13:14 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7dea24sm451194a91.5.2026.11.02.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:13:13 -0800 (PST)
Date: Mon, 02 Nov 2026 12:12:46 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
Message-ID: <tnw2q0.1tgt7zq8oeb0@gmail.com>
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
>When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
>message. It then subtracts tosend bytes from *copied, the return value of
>sendmsg(). But tosend is the number of bytes that the verdict applies to.
>After bpf_msg_apply_bytes() tosend can be less than the message size. Then
>sendmsg() reports dropped bytes as sent.
>
>Subtract the number of bytes that sk_msg_free() frees. After an error the
>SK_PASS branch already does this. The SK_REDIRECT branch does the same if
>the message is not the cork. Nothing changes when tosend is equal to the
>message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.
>
>Fixes: ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg")
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
