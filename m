Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C3327210
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724862; cv=none; b=SnIN1gBVCDrzpY47x3KHXh+He3MVjfNzaKuoXVdrFPmm1JqUrgLYmuugxXzBeIRnDKJwEkBME0cnjB2R2yPHzDD47yPxnqLo2j+/vrKrJAOiBS+BgZgoD7WjbIwDJRqsMxDNwwnNxic+bee2Un3tPWTliddigULAhQpfAj1jDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724862; c=relaxed/simple;
	bh=hveGr/d+FQYMTlccMNoSD3lD1Dur23sNDD8P8EjZjNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FWV/d7By+ogeZKfmhRXZciRVwWfIsL3BnjfjIARmV7LunlpBQycwezb3h0FqWFgRVPDpWGZ6et14q25+BV1/UkwPXUHmgbP/mm9NeiI6Ml6bSNRa27we5Gmg4qMvShOJVxNxpLZWibqa1LONXxOEk2EYjLXv8gRGYHhHhBPc0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGVV48t4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kUN7YN/i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGVV48t4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kUN7YN/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hveGr/d+FQYMTlccMNoSD3lD1Dur23sNDD8P8EjZjNc=;
	b=PGVV48t4zsriI3FFTsolBX/d0hVZNypxpxtQVmQECbHdwZCVmgx8Tz+dnixuCTTYti/xbB
	UNocs8rPcoU7j9sZVMCXBuhdO4blzTgZYhfKHiMK8qwo6p41MogDZkGXHQUoSulMblSSFo
	6JmPohOXoBd3INZreStGAR4K8JczHnU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-48rnnYNFMSya064CWQ4f5Q-1; Tue, 10 Feb 2026 07:00:57 -0500
X-MC-Unique: 48rnnYNFMSya064CWQ4f5Q-1
X-Mimecast-MFC-AGG-ID: 48rnnYNFMSya064CWQ4f5Q_1770724857
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435ab9ed85dso2524921f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 04:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724856; x=1771329656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hveGr/d+FQYMTlccMNoSD3lD1Dur23sNDD8P8EjZjNc=;
        b=kUN7YN/iouu5rY84KQaRvw+PfCR+TVfgTc/9zfUGez6na93nCCWljgm3n3+3X0yuhR
         aACbbV7l8BevDzOL0SsmYz04jkA3LJbpS3tje2K44+0t+gjtUlE4HeEQ8EP5upQVZafY
         iFc/Z0G09CUR4c2RWfL47GlErDr35HLA4c8sXpIaK1NTzrnPfiwV3xqvo1aqiA/Qpn8E
         dymS0y9Fn422V0K/7oJxJVYN2+eh1p7jM7xuejKl2ZKaP0jDmx+BSCvwizXuEBvMG96X
         UfEl94HHj9MKNYBOv4sErsJ9ZlfQOyqLZF5k63pEPya3bmo1qe0PP4k5fFrCXJkhptuc
         JZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724856; x=1771329656;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hveGr/d+FQYMTlccMNoSD3lD1Dur23sNDD8P8EjZjNc=;
        b=Y9MzfkYmfETmDOSuCkP0SQhXHV7TwCtYdmvSnEpwZdwpx8/OpsAmMrmuwL22HWVVsF
         1waM6S4asrIlejB8RA4SJnFKzNSZP0f90ouKgqpMpgpqfm/xyopGD3aia2hQ6nV7mRAs
         QWK7AhQSEzxViDPmkxAJJ1DFUj4I5lIj0+frD42C2ZSfr1+S0LQYjAOkZO6Z3ocuxE0t
         YqYYXxXZTccwbLClEE5clbwjFmTvUoEJajlEwexVzIS547vNokLlc22tjB81k6MDJiyU
         gRR70Tq4aWRC6TobQG+MaY3dkrD/USo3V+H1WYxdgfwbpVEO1fMlKgITwvyWCocElBzd
         NwcA==
X-Forwarded-Encrypted: i=1; AJvYcCX0moKaYU6rrVcprHl3hTTzsuJRU/+FCQ33znxGPmSd4+D2V3x6/CpsWdNpdWCPEcRA5pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9S2GUKSwn7XUE1BcASsjmW5oE8gNzJzPjhxEJYqyQz4p8DSLr
	zanuU5EtrReb2EgPiUB48N6nxB1rZsa0rmVaKzIoForS91KKC2yMKtAubxvxptpk3NavLil+gK/
	qHjDmiWjiG1gHP7VOVrzuLq56pWhcwQRNubZn6HplWflFsc+RTeW2FA==
X-Gm-Gg: AZuq6aLqRKAT997OWo71qN1x+RsU3+bVUjfLgomV2RhnSOLmYgw2LxdShuHg12vb82w
	ziXBoN9ylU39mv29Dx0YqHqISVrGJq0ZsUCJ451Pa+7pKs9z02IpJtW7I/eDbGt7A+dJzDdsNVc
	GJamy5Z56oC9284mMk8yZCyq0KGVrJw7QGwcxNj6C8AMVzsweY3moXQ1Ds1x3AmQlbXVVPSf9Mx
	Qnv4mw3t8GLzXkrkjj9yM58cv78blzOjQJ8Rp1R9kEfHrBZd+9e5u8YErmEc6KNBcRSsnc4ldf8
	uUc7+wFHgJQYOHYkGglbmoTkKA1xioQgjSRjAgMK1EYmoHgf8kF6yXELtyJyS38b8m3huElpnzo
	fNqqPqQxYzIN1XIaAj6Dc/Wu/ZYXdNZl6GuCZgB4qEGzOag==
X-Received: by 2002:a05:6000:2601:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4362938a448mr23078111f8f.46.1770724856487;
        Tue, 10 Feb 2026 04:00:56 -0800 (PST)
X-Received: by 2002:a05:6000:2601:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4362938a448mr23078050f8f.46.1770724855993;
        Tue, 10 Feb 2026 04:00:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376accfc58sm18883666f8f.16.2026.02.10.04.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:00:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 65B754FE8A4; Tue, 10 Feb 2026 13:00:53 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 6/6] net: sched: sch_dualpi2: use
 qdisc_dequeue_drop() for dequeue drops
In-Reply-To: <177039509565.2258217.3624858167198291525.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039509565.2258217.3624858167198291525.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 13:00:53 +0100
Message-ID: <87pl6cyfii.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> DualPI2 drops packets during dequeue but was using kfree_skb_reason()
> directly, bypassing trace_qdisc_drop. Convert to qdisc_dequeue_drop()
> and add QDISC_DROP_L4S_STEP_NON_ECN to the qdisc drop reason enum.
>
> - Set TCQ_F_DEQUEUE_DROPS flag in dualpi2_init()
> - Use enum qdisc_drop_reason in drop_and_retry()
> - Replace kfree_skb_reason() with qdisc_dequeue_drop()
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602061240.CRDtcOeX-lkp@i=
ntel.com/
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

