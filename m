Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E273451C8
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242484; cv=none; b=Tc+Yc8ZHNOCzQECrUA/dWGAB4Tr4XwrufxoOeToBs+HmiVirHKII9XyLGaxTybb8JTGUKuSj1pQZ03KtExxesjSoiVM08VIvor1O5Jk4XK6xt42GNtQEz2KVseOODkjTpgAOk0hfi0s8DhmGEWZ0zD7/+yxyVkvvoMbk4EvdhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242484; c=relaxed/simple;
	bh=5yz/7qD9d5nUnJsJaK5U9S/CS7fJOjpjpVIPiaeyP1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DHJ66WUrCyBGkqkefS14EmnAkO3wcG+7D/sDB6soXHBs780kqK8FXtBMi8ww4iiOdgD54HuBU1qwEQ1EBh45g84xykFsk+LPIYU2XwSJCVxKl6u2DipMz1+0OWr9FgKq5/HBVVZpstD0AR+qG2eedaIuHNNNscdsd7Wgd52fyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ChNPkqab; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ChNPkqab"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69796a9f04bso330188a12.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782242480; x=1782847280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTCKNVKjyr3voLzcUOfsCv9QuFqyC7oHt4mjLY0WbOU=;
        b=ChNPkqabujipjv9w1gDwZbhfZk3UiMMwHv2NQbbc/b21CdX4tDMIwC6DhDhkoeN0BK
         psZvV5y5LjnJJ42e4p4u0SmICEpQTcYl3f2PH4g3KXjic7xqZ/lgpL3dfdrgmM3JK8ez
         IUXoGbGXgOb8kh0giCU2ncukGR1XNK6n8tb6B3Fo2tXWDy7ZT9Df8qOB4HxG2zlyg1DC
         1iTEAnSIc8i0VUY1lQF6dnMet1B8Bb7DMhPeWO96yPFxM4y9uCXhzqK9zse4Swl36f48
         eIP5WHrXgwE5cxY4+qeqU4fEttTRXYTRJEzdPcm2V6oYa/aS3a88OfUMPy09V5mv+p81
         KjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782242480; x=1782847280;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTCKNVKjyr3voLzcUOfsCv9QuFqyC7oHt4mjLY0WbOU=;
        b=qMqUo6BKZEBxge8aHDYwELS20Bm9hneLJrdx5LM5PmsOcZCzG1OCKPjDcUXl23RVlT
         HiLhgYcGD3yzuXdotYGZ6IzyLu02CmB6eBo6n3xpoUJvvrVG1BBcCCXqt6JSfU/Fnvix
         HXl25SmN8zxZpgvIaoqV+8vRfyy+bBKkOJhF8dAcfsxVfXW8N4CTsdtgbV/t7M0fw4+u
         OoWfId6VHUi6+THUOdqYmQg0S5Nv2+GaFCQDHPbviQWS08T6igBko0Yxb0qqKotmwe8B
         fUgkd1I2NI186/Kf/8rPyW9RRUFbYPWMVJATGZl1+MbfVtZVAWLFayy+QkGAPI8IwUTm
         2ZNA==
X-Gm-Message-State: AOJu0Yw/+0ofPqRCWYhYt15+Hu503l+QVh7uWK5tsASHzIENVcZf5QNR
	TNQwuaDItm9RRFekcY22NkJaFY1DxVOve87BTq49MycwotV7Og3i/LCmS8ETsWbVa808wW7ySDI
	k8FNnTCY=
X-Gm-Gg: AfdE7cn/MICdglxPJBjSVuZECixlLU0idbDmHzT5/A3IkXUTnaLZnjDPFJ5oV1c0Ltk
	lLP1xO5GC74ttQ4JMcKhsMOAUz1IL3H9/cu23eR16TaSFrLUznVVupp17hYQ91C7YvjHVW2BznM
	f5qMzaWrbSlA0f/wKUWiE+xD2xcCw4WSqoCMsY5NItB71XFreSH0aJYuX8/3Eq+zXpWHsDOcEV2
	UOzJCDMB/hc2MiFsEik9vfqLiXqbIA8PbFvtgB2x2RRsTypeJRBfpYjgLFOL2NNqsBaZJLLurU6
	886HVe83fT89H61owWkChVJ9LeorsMR10qi1OOt7ol2hkytm3vsEg7bjiNzdjmeNU9GgLtXKNbN
	Y84IWIQ+8dyrvf+7UKM+XRuXdXyVszhRxBG7WoLqA+QnoFzPsBkejcJ+f30ShNVni6uDEoPM7K9
	MDm4XSYx0/C9sseuQ=
X-Received: by 2002:a17:907:c205:b0:c0c:48b1:21ca with SMTP id a640c23a62f3a-c0c65adf4a1mr818261166b.29.1782242480048;
        Tue, 23 Jun 2026 12:21:20 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99aff0sm555213266b.19.2026.06.23.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:21:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jakub Kicinski <kuba@kernel.org>,
  Jiayuan Chen <jiayuan.chen@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	(Kuniyuki Iwashima's message of "Tue, 23 Jun 2026 09:08:04 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 23 Jun 2026 21:21:18 +0200
Message-ID: <87v7b9ysep.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
>> completed all code paths related to sockmap-based redirects should be
>> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
>> disabling NET_SOCK_MSG. The implementation of sockmap as a container for
>> socket references would remain under BPF_SYSCALL.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>> Changes in v2:
>> - Handle prot->recvmsg being NULL (Sashiko)
>> - Elaborate on the end goal in description
>> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-v1=
-1-d7e0cb7bb03b@cloudflare.com
>> ---
>>  net/unix/af_unix.c  | 4 ++--
>>  net/unix/unix_bpf.c | 6 ++++++
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index f7a9d55eee8a..84c11c60c75f 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *sock,=
 struct msghdr *msg, size_t si
>>  #ifdef CONFIG_BPF_SYSCALL
>>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>>
>> -       if (prot !=3D &unix_dgram_proto)
>> +       if (prot->recvmsg)
>
> There is no reason to have this dead branch when
> CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
>
> Let's compile out all sockmap code when both configs
> are not enabled.
>
> Since AF_UNIX differs from TCP/UDP, it can take the
> simpler approach.

Okay, will put the whole file behind hidden config option like so:

--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -30,3 +30,8 @@ config UNIX_DIAG
        help
          Support for UNIX socket monitoring interface used by the ss tool.
          If unsure, say Y.
+
+config UNIX_BPF
+       bool
+       depends on UNIX
+       default y if BPF_SYSCALL && NET_SOCK_MSG
