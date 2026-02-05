Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B493A9DA7
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291263; cv=none; b=YGCXol2mHJ1AAxTIq6b6g4mQukGo1EHWTspqsbl/oXhYk8phMuyLW10MvUHP4vhot4qVVcsQZRE8rdyllYZA/MO7zkGRxwEHuXQl1hzJwyZQx89WGuisOD8QOIEaoJIgSfp6Sa8SAjNdT1HEl1yLLL82+YyMURzywOw2ylzdKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291263; c=relaxed/simple;
	bh=N4P1rTEaiRVoBP5YzqUCAYVm+4YmWUXPGm+5vZ1R368=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAf+FJdhjHDhC0cEYBmEZw1zKxZI6536txXHPlmWlPdW/W0RQw0YLPYFrsJcQ5IKT0+U7Kw/NYGt8NfdCUScCQ/T6rC3QeHWExT+GavhTHQfDXNIaPX0Nmq6RO0lJ5wKcI6T9K9N2TsmRzizhP5n3autZBpc+z9duolRiE6Y4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYPxu70z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5E1laiZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYPxu70z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5E1laiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770291262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjEzuRz7BplWMcNqxxm3QxaRX6RnMIACl/NvfHd6qac=;
	b=UYPxu70z0VTKYYUMmfqUdByc+zwjMrDy1jsYJzwHTEmaaDSdDr5vBbV/T50jUiSnz2ht7m
	pZvB2XF9i6hHhz/MquJZiY4nqORY5ui5fJqh4p20Uv3RVCmBmEZaIlTBQEYnk/tTmf7ZMf
	b1a/RDj+k2tHoD7G6vcczoXoe2HYX+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-TB1hxyjbP2C7pCwPh9SA9Q-1; Thu, 05 Feb 2026 06:34:21 -0500
X-MC-Unique: TB1hxyjbP2C7pCwPh9SA9Q-1
X-Mimecast-MFC-AGG-ID: TB1hxyjbP2C7pCwPh9SA9Q_1770291260
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435af2d3144so664617f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 03:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770291260; x=1770896060; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjEzuRz7BplWMcNqxxm3QxaRX6RnMIACl/NvfHd6qac=;
        b=I5E1laiZ94aNfAKKZeIH0rmuOUXAjqDww9PZRtRKnREnEtxf5pnOqh0Qp+pYlDs1BB
         o1WE23mZGAAerqLFZFJ0p9LjYTyDyon/ideyWtCPkXfGxVIKxTnlO4dpi8nk3z8zE/ju
         dL6zcrFXCEKEBrnRKNIm39G7cE5bwp3fB2iLFRwfG84QFJUJDAskfnsIZ6ZLDN/MfwrF
         hFO2m0TfZBt3lCtOw0Ji40Px4nMdhAzx5/DUmx/ptNbOTAfN7h1qDCL0HAPRiaQumCN2
         x9yCTrUUAgL6eZ3/dSuQcCEoYUpC8WJ/PNM089EZeSziPNVYDfFLItfoKrqE1JycZ068
         1DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770291260; x=1770896060;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjEzuRz7BplWMcNqxxm3QxaRX6RnMIACl/NvfHd6qac=;
        b=dCnwqjFp/FTFPs/hRxiSDk92X7VXz8MRV/PJMXQYx3ZjGWkMnf//cfkYo2IB/Vkoj+
         VUDKjdROUvRBW3ZgL/0D0M0tABleqhJv93TboCdNOKAQ1iOzP7xv4adtTvYM2Ec4AHWz
         /jwf7JoTsNtLH39r3VOeIs7yAg7eM7iBP9UUhKVAS23ISP9QjbnwjSBQ4DFIf0/bY4+Y
         h26OusgGrFWXQNz5sVp93/EHaVrJg5T0YR4Pm0l0KlBqEh0pHFB1WN3RLUXRpXCYhemo
         Og327YwsQnSJYM+5DA4KKxrc5GT2pyse955jlm+gK19LXPgaoTbcGQIKmaqlKyOc9a8q
         m4kA==
X-Forwarded-Encrypted: i=1; AJvYcCV9tN9mJko64u98xVjj0t6gJVvuCnIg+anh202QK/CFbmkZqQm+ap5R7WLee8jqxbHbrTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynCkflzpXFQqTK3UsbheK4Shf6USOM67VpLYe6mPp50Z9Wooz/
	vSC+e5N4rXis+lNPYfdikdNFQIqlqymqWc83JfXngK0adbzIlxQMR9a6260FmyAlYHwgqK829Ma
	/2O3GUKq9nDqF36NVtGObX2QaHskpEvErtY4H9/E8Bi9X9drObLv4jQ==
X-Gm-Gg: AZuq6aKUFyp5FtcF1QGcKgMhrYKLFpK5qBuQtSB6lfiXDerxjFs95WZZ6j5XYoq+728
	qc0yR5IjjCFWCD4oVfe2ZV4a5mpCuXMN8hxbW8P2qGYr1LSXUuVGyS1OjBg3I2jBf9L5fr5CVga
	5+Cz5BLdVMRZtm7JUTuRNyiVA82aC6vdt9VyCLoNmQjXmmEv01/mCTayJKmWNCFVD0Mdvyv69D7
	ho/VclZMYbmXMKHzE/BhcESr4XynqasfpIUienQez26M2xB/ZcGIRWxqaLGn69BhavVqIzk12gB
	5b36aMo9fBbCjIcw7gFyuatVNpAozOa+jRDcGJ6kgcGgCnJIkKKQPxcivLqRZr/ANJ2MQw71WiZ
	p4Q2/UFxWT0Lg22DR+T4wQjN48mn5HA5G2Z7l
X-Received: by 2002:a5d:64c7:0:b0:431:488:b9bc with SMTP id ffacd0b85a97d-43617e351camr9160961f8f.10.1770291259886;
        Thu, 05 Feb 2026 03:34:19 -0800 (PST)
X-Received: by 2002:a5d:64c7:0:b0:431:488:b9bc with SMTP id ffacd0b85a97d-43617e351camr9160905f8f.10.1770291259456;
        Thu, 05 Feb 2026 03:34:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d47sm12473826f8f.5.2026.02.05.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:34:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 27C274D1132; Thu, 05 Feb 2026 12:34:18 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com,
 Antoine Tenart <atenart@redhat.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
In-Reply-To: <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org>
 <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 05 Feb 2026 12:34:18 +0100
Message-ID: <877bsr1l1h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 05/02/2026 04.04, Jakub Kicinski wrote:
>> On Wed, 04 Feb 2026 18:02:49 +0100 Jesper Dangaard Brouer wrote:
>>> RFC: Seeking feedback on this refactoring approach.
>>>
>>> This series refactors qdisc drop reason handling by introducing a dedicated
>>> enum qdisc_drop_reason and trace_qdisc_drop tracepoint, providing qdisc
>>> layer drop diagnostics with direct qdisc context visibility.
>> 
>> I like this!
>
> Awesome, then I will continue in this direction :-)
>
>> It will presumably require existing users to migrate over
>> but sooner we do it the fewer users that have to move?
>
> I agree. Existing users will loose some details, but the patchset
> results in fallback to SKB_DROP_REASON_QDISC_DROP as a drop reason,
> which existing tools/users will still handle.
> (The more specific drop reason is now avail via trace_qdisc_drop).
>
> Eric and Toke is this acceptable for your users?

I like it! My only concern is that drop monitor tools will see two
events for each qdisc drop. I guess that could be relatively
straight-forwardly deduplicated in the tool, though? +Antoine who works
on Retis to give him a chance to complain if not :)

> In patch 1/3 I kept the qdisc "name" as part of the enum for FQ and
> CAKE. IMHO this should be changed for next patchset, but I offer you the
> chance to review and suggest generic naming (else I will choose).

You mean you'd just name it something like QDISC_DROP_FLOOD_PROTECTION
instead of QDISC_DROP_CAKE_FLOOD? No strong objections to that...

-Toke

