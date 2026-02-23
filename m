Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06564361644
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846347; cv=none; b=cP5jYwG2mb9Snl7ES3vBUst5Rgg12WuD6+Uiw7y3c1e24tHNawJ6zK096gIOvWwLezUK8j/ZnICHlWDIfeDz11UBLxin5rsxqBKy63cgT8ZSGx+2DtNr0IFMBSsVn2UrOmwQusZJEtrnX67xmdFCthjKXnymh5+5GYdATP5BqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846347; c=relaxed/simple;
	bh=W5zrbs9uXFemU0SM1Ldkz6CuI7dETwlvOyXhvibTCyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rW5W+gmmi4IcJ8QqpUtudDt1mpoKIjXHqcJeoFKCTpVyGHeUKuHJL6qwYfpuF4wyOQQahL3UlpqI2KkWhnabbckmDAlRGy2XI1nf235zUi1ltcgq/YJCSN1TJcXhUCU52VLjGJeu4nduXTLAED4LVRd65oSyZ5BoILJq97xwSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjnuurU0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU5Lcjoe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjnuurU0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU5Lcjoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771846345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nG2y1gHosJIJuzVfk3SqmU9QwIFbQp0Z8zPn21NlI3E=;
	b=WjnuurU0/yo68Ia6wvII/N+aDMeQ8xg3SULGT2gBe/K1BPLZVbcc7Gofbhid92OMR1clCE
	WGFKOzHPxluFJkpJhLJNZciG5xXA4RnZ0tBUw/30YAehD8KQUvmqq8f5HzzYMm5VlId1YT
	hS499UQQpmuknTjwJgzmuI/o5YtEyTA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-xWp0grwQPxOmqg9WWQ0LhA-1; Mon, 23 Feb 2026 06:32:23 -0500
X-MC-Unique: xWp0grwQPxOmqg9WWQ0LhA-1
X-Mimecast-MFC-AGG-ID: xWp0grwQPxOmqg9WWQ0LhA_1771846342
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837f288194so35790505e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771846342; x=1772451142; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nG2y1gHosJIJuzVfk3SqmU9QwIFbQp0Z8zPn21NlI3E=;
        b=gU5Lcjoe/QCNN2uOnlDRGfdevdN2c3Kd+iiGjpBvXwoFPgQpqvf3nK440b8w4Exqxl
         1Bm6DZZJlZ7Ys8lazxGhSqxVVJsM0hFFdG7L9XFgptRcnDEVb5WojBs01l5+1deqzbCS
         QhjEMAEIed2UG6H/omR8OHeTF7GDp0tRtVvBkeYi95hEgZvFOLtbatVxLnCsrkWBFukS
         D4/jVJ1OU9nHbft03YTQyG6qjPFjgq9U01HgK0H7F9EKVQQPWw2MetCpoXibwcqwhNEh
         kz49iaDw/1dN0cFd+PTGGaVanK/v8DUSFD+3w/NoaFbbVFzyDG+HURv36jsvawqTp+bN
         n4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846342; x=1772451142;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG2y1gHosJIJuzVfk3SqmU9QwIFbQp0Z8zPn21NlI3E=;
        b=iza6C8Fcfq3O2AvF93oD4SaBpYe8az7IwRRzuvxYc7+6hfpD3XW/ZqY6AjqKjCnhfn
         h5cX1KVkgCfmZgPOod5BOMDTqlL80VLzQF85gBchGHe1fWeYE8Cv6S8zsCpInsnORiF9
         EcaVgpN+/WO+kOvWzLO30zxTdVeTQ88NE9xXrX82mw+9bF5uOnjdY5f/aVCuZgi7lF0d
         IB0k08O2J2Er630nSl6vl8EVFLK5EW/lLGlTodI237+6F9jtqYwfYO5KVaX1csjPNrZY
         w0jCwNqgJ8CDRv8/niOCTJGISZ4UDthGIksL6GFCX7D4+XLqFOl7vNtMg+xCPwrpq+Re
         AYXA==
X-Forwarded-Encrypted: i=1; AJvYcCVLTDTZkgr7XyOdXYvVTsEHH1+r6b6rvBZbbaYGqhOY+NQ2T2v6D/vpXwCyqOVrQFdwteA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfjCP5oBmPZshJGmtcWV74LmQleSIVQ6shItZBmtz2Rvl0tKL
	YaBlyeZarKDNoltV1lUrL+7BbfNs1jbRiOglej4nwDj5GApQgfIzZdpgyqvLQDKu3FACh88/NFM
	lm0lk0Uqpgo0OuS0nG4fq1nK+WDtEDoxDDL/8Hk/oEcKfLjrubd7oRg==
X-Gm-Gg: AZuq6aLMy9ne05kh7LOrz9kPIbxI17oqE7bpEsiEkeGEWQ0SvBKGgBTsnntkOFR0EZ1
	DzuLXPrgaJ5lZggsvfWh7/8kM+Hk6Nwy34bbG4KXPS5g9CowqzspCtTK55GjlZ5BOHoSrbgl8xT
	onpiFs5T9LQV0YOrYVEn0PHp6v1qAlY78pFlY0vs1V6lHAwTw/P2auOyBgDMbgFgmihvUWcqqnQ
	RkPzJenWCJJGODOVribXPUZc9feoUBR1H/zt5m+VtdIbS6weUnbRb4nEgfSWhZN9kSO44lA42gL
	q8Cvp5uTt7yc6dVbh7RySIgLamJHssqh7zLnpKr0HVilxf6+Z+vrW/3twCzK0rvqm1wTi6tjrWF
	iAWYQXFyF0tyQ4vhxfww3asJC34MUsaunyzW1PY1DSZF3TQ==
X-Received: by 2002:a05:600c:3516:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-483a96377c9mr136371165e9.24.1771846342319;
        Mon, 23 Feb 2026 03:32:22 -0800 (PST)
X-Received: by 2002:a05:600c:3516:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-483a96377c9mr136370475e9.24.1771846341844;
        Mon, 23 Feb 2026 03:32:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm272520885e9.7.2026.02.23.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:32:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BA84B5166F6; Mon, 23 Feb 2026 12:32:23 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <kohei@enjuk.jp>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jussi Maki <joamaki@gmail.com>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>,
 syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 bpf] bpf: devmap: fix stack-out-of-bounds write in
 get_upper_ifindexes()
In-Reply-To: <20260220193039.7129-1-kohei@enjuk.jp>
References: <20260220193039.7129-1-kohei@enjuk.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 23 Feb 2026 12:32:23 +0100
Message-ID: <87ikbnofug.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kohei Enju <kohei@enjuk.jp> writes:

> get_upper_ifindexes() iterates over all upper devices and writes their
> indices into an array without checking bounds.
>
> Also the callers assume that the max number of upper devices is
> MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
> but that assumption is not correct and the number of upper devices could
> be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
> stack-out-of-bounds write.
>
> Add a max parameter to get_upper_ifindexes() to avoid the issue.
>
> To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
> an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
> Then send a packet to the device to trigger the XDP redirect path.
>
> Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@google.com/T/
> Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> Changes:
>   v2:
>     - fix formatting, accounting that max-line-length is 100
>   v1: https://lore.kernel.org/bpf/20260216201428.65641-1-kohei@enjuk.jp/
> ---
>  kernel/bpf/devmap.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2625601de76e..c8c49d86a403 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -588,16 +588,18 @@ static inline bool is_ifindex_excluded(int *excluded, int num_excluded, int ifin
>  }
>  
>  /* Get ifindex of each upper device. 'indexes' must be able to hold at
> - * least MAX_NEST_DEV elements.
> + * least 'max' elements.
>   * Returns the number of ifindexes added.
>   */
> -static int get_upper_ifindexes(struct net_device *dev, int *indexes)
> +static int get_upper_ifindexes(struct net_device *dev, int *indexes, int max)
>  {
>  	struct net_device *upper;
>  	struct list_head *iter;
>  	int n = 0;
>  
>  	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
> +		if (n >= max)
> +			break;

Hmm, how about returning an error here, and aborting the redirect
entirely? This silent truncation to an arbitrary number seems a bit
surprising, and very hard to debug. With an error, there will at least
be an error tracepoint to catch the failure.

-Toke

