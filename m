Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793961274;
	b=YA4pZUohcjU1cikcThy25JhJ8EC8wz5TZBKtndoQnk0NOMq5XV4piLGobB537zlq4NJf
	 H2xt3VD0YUFaJpZq8+sazIZSNphZeEVsVV1/nwcXoTDj1NC474+az/iuctSOAA44HUYLw
	 lWGSa3/8dz25Jg1k9SbiTEeYTyum1+sp6osfCcgbs8FMKNK/d9TbiZmR3wlPlte6jt5R8
	 JXt352mntcjpe09vZTQT7ZL1rY3q+c9alLQZiux1GkAylhFkBuiD4OL3dhOP+FhQGs/Dg
	 IXLINYTfp6UiV5uZhYAyKANRV5JsPnzj0nVkZmYXEC445ZZrZeaMM7Qer+P2Q9DkJXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961274;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Received:From:In-Reply-To:References:
	 X-Clacks-Overhead:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
	b=MB/H6ItTt34HBHNXouYrxKrRMVc4EJYv0XLmVYFpHx69ONJ7OKU8TiGAhtMvNJzXQyW6
	 yhliqBc/YQP/4goJVBtAAiUJSqhlj/zzI8+QLgkDEp4JYh2x4xQey8/kmH3qge/Enofz6
	 dJr834nauAwgSUZ42BzNEm4+2lgqE8HlzvREGgBcQuOLjvKimgit1kKHMSS8wRBbJEpXV
	 L6usGNRjeDfeohefzt0zpiuom/y8ojZmIaAJ7ChxQmhke6lKeVUozMv9CDu+Mr5qpaR3j
	 s6PQLDA2q9jUkgYkeVhZg81CEhuZhQkgU5ZWUCa/w1xtdE9vBhpRLdVgRp7hbEYiAvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SOoSIbEk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qgpZ36Ct;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E9606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 10:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D55E9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SOoSIbEk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qgpZ36Ct
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793961271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
	b=SOoSIbEk+VwEidDd2eqmMY7xpnyIzNoIevLJj8cxb77Dt33eL/HXwMBYlHLRHo4F9CUdIs
	v1T+1d4hj2/iZwKzTD3d/wQTxnXbv6XwU5fOmOzOWsBTGn7eytYsWLEFtwuwwqlPcmFh0H
	RYmo90pH8r/xHfUppgvG7y1q1znlK94=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-IwR9vHLbPk6Bt1ptkhGwMQ-1; Fri, 06 Nov 2026 05:34:30 -0500
X-MC-Unique: IwR9vHLbPk6Bt1ptkhGwMQ-1
X-Mimecast-MFC-AGG-ID: IwR9vHLbPk6Bt1ptkhGwMQ_1793961269
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836caf085e0so5205287b3.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 02:34:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793961269; cv=none;
        d=google.com; s=arc-20260327;
        b=RLqioRAaUFwuGRly7u4K8q/AlMB2MZysBfWiHXbaKrKrv87rk0TNdeutFvElo1zg2N
         pbg6TW7HpeO8tSRmfFMOjC91VqML8trxVWjKXimWFWRBljcje7/pAYX8VPs2tL47SNMg
         vykYNgKEfV0hY0R/HBpopakl+mGfExpBBjRl5RiLF2LHFddQ9Lk8tnAm9g1g32XNxTwk
         yUNkbJBQ2JGoITRMXnh/OHZUY6MdfuxeD/YjZDPw+ZL0rqqSexygkGK3QaESx90oAssV
         gDAKvGWk4zg1z/qPIOL4uDDLHoK7wvmBF2k+S821kQTlhXC8w8rTjKQJuQq3VK0AvBCT
         aFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
        fh=/iYwo+xhRV6HkXbRrwwMRlwuxmoFeCUYwW5/N3NP6Bw=;
        b=cajWjlAHbQrK0Vk9MyEZnPbpNNjlto0EQrWl7UZCvfRXWmxZw7laPDeYhsaHe8BBrY
         TqJztFfXDVFfu+ZMpFNTQ+WtfoDsu7NCVGO6xeNO0D9fBA4jua8KW9X6SNBHJryUGRWx
         FQJz5RM3B/F86UJiSBx3Djg7BCTjItwWIE+hnM4fw2oOIsObgCHNlvH8tBrucLOxOPqg
         kzihixJE9vdi2jnj2mqMl6hO69CMVwijKQJHr1j7GrCR33wl5YDQ2KyE4KaQCxg8ia8U
         qXZRof76nj/3PSZOHBq7NSF14uP/v45FrtBEEwqMp8+AQs+y1+fE14HFMM7o0nkv6xr8
         fLlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793961269; x=1794566069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
        b=qgpZ36CtjCnXnK+qlpid5+8RtJlb717kJVPXmNL19QsJdwUzVBangA3BKsD0VG29Zw
         Dli7fE+aVoWZg8DhOXRill5nv9vnWcS0N09uC7RKmMQxsLxFJSVsbY4QHBj4wOfuox8e
         tD/Kq3iisgYlyxjFVTCbtmYCZoVOyhiX6yqC/uRld+rp4SxpsEY9LQv3IT+3t85TWgFD
         erToRoPdiHuBbGYqirBX1eAS5bVWJ/3x+i7iArNo3XwFMs2rBCGDO7KXlkCYdee0xD2M
         vYQQag6hUp3pcQux5vBWTfw4jnOn9j2hTRq5q+UHtCBQPoUJoQQikNAUeQrF4NaJMPgc
         1d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961269; x=1794566069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
        b=Z2CyuFIg50uiTYe7nsKYk90v2aSamOUCTNT25BRNko7XOSImIdD/aPftN5SAQgjoKV
         8AElNbsLZiT78H/fWKCh2GU8L3jCDREv2McE3yWPA5aePZtuYLZKM71aPpy2BUUBVCEa
         VPRB+0fVzryKGk3DoZ3T1XfQ0WURowZgt5s7YJ6pOh6W+BoCvmzoWtMaNNhv20VNndWd
         G53aGIB/zwzqSElqTTTvCExuhG9gKNJbaEN971DkUxcXCAam63P6dGYZikHrKjIDy+uD
         CgXJuD7MMQyvBeWi5gV98qTMmhH8acnVqx71Bts5YpTKexFwZQIlzLmXcFBiyqHoXXPc
         ETUw==
X-Forwarded-Encrypted: i=1; AL+hErENaILdDy0+JS1IkRbtBWsyIzivb3QxyI5Jn/WKvrZn7SeIt9ayo3zWi6tFRIHo86ttaNI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GGT7f8UvubAoRqesjVRVXJjIhgvQ1xDNIx2HGbpC5wFJf/6kN
	9O5JzX0k6MycVGY/K8D0cEiODPGXuS9liCBXyPnMFr07PK5wUgihEVNmoQAmxcilhXMK8XlLM2w
	zSnD0hYU4XLnQsE3Iu4CH7+a5aKIATLabl/22i5PRpgbn71XHHjvISRB3yTHDGg+Xp+CdCStW7j
	ocoIW1bj6v0+34AlkuIhBYvS4XAc0P
X-Gm-Gg: AYBFou1+B2Q5klkuYc7ZgH9IALr/xzsFQrPuPQxSICgvQHpNaT22FY+QcHwlSWPBJRb
	qcKnd0mT2F5I/dunkGSdctXF4dZvZA2Ez9LOKgYkgxZe8c7nJxV7KlcTlWKUT7GjgPNC66R63H+
	rKxDQfchkgM9m9PnWmld8fqAoUvJgNHFZjBf24d0BYHfdKtNzhYszY+cEpL+WLsqGvZ1qmVKU+U
	2GimSWHML6u6ntQ
X-Received: by 2002:a05:690c:e3ea:b0:8b3:5037:5023 with SMTP id 00721157ae682-8b350375381mr15947b3.15.1793961269484;
        Fri, 06 Nov 2026 02:34:29 -0800 (PST)
X-Received: by 2002:a05:690c:e3ea:b0:8b3:5037:5023 with SMTP id
 00721157ae682-8b350375381mr15717b3.15.1793961269050; Fri, 06 Nov 2026
 02:34:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 04:34:24 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 04:34:24 -0600
From: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
In-Reply-To: <20261103200036.65764-3-tianyi@cloudflare.com>
References: <20261103200036.65764-2-tianyi@cloudflare.com> <20261103200036.65764-3-tianyi@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 04:34:24 -0600
X-Gm-Features: AclHuK-sJ3dqIJeSdHUNf0o0AjI3dtm9DPHkP7CfN-2qlw2BH-a46hIByak0TW4
Message-ID: <CAPB2EArNk4KzPSGD8DXjb0o=pUZ8RFUm=U3ZVU9GRNMzj0OVkg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: fix mac_len of skbs copied by generic XDP
To: Tianyi Gao <tianyi@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tianyi Gao <tianyi@cloudflare.com> writes:

> skb_pp_cow_data() copies the header fields of the old skb with
> skb_copy_header(). skb_copy_header() does not copy mac_len.
>
> Generic XDP uses skb_pp_cow_data() for programs with frags support.
> After such a program, the skb can have mac_len 0.
> cpu_map_generic_redirect() and tc ingress then get the position of the
> Ethernet header wrong.
>
> Copy mac_len in skb_pp_cow_data(), as dev_map_generic_redirect() does
> after skb_copy().
>
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

