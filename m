Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85180502550
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488451; cv=none; b=e0tg9EvufLYD6ZxuK6GIm1CJjAvEoj8zZGBHjkoasZXmxA36K+ikxqEMPAFrRIxNVxo+pqzOmIxgD2bJo7U9RRBrvJVHvolIyyizW2Txx4d7/sjUJ/8liHN6eQMiRC8tGtaJt1tx+DpXb0zFDmtGFEg5XqBowCRyQBvOSNVUfHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488451; c=relaxed/simple;
	bh=MMEJVQyDCriVzwGMNyLd8382hryEEpnwrQFclQZlXN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vh/ZkgJsB9cisCHSKQrzT9sajBp20MV5EUIVn1KlyQdgCXX2i065DK7wzDciTZLc+CV6xxZGIFZTYili3oi6Ce2iOqBSdTZNIqUbEI0LfN4Jtf2l+xgMpRm4wrgzyRREJAxU+9zdsKVKB347sWitj2bvwQxyhI3xZNNTtJCFTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=UFuTY8ZU; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="UFuTY8ZU"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4af173320f9so3159759b6e.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1791488441; x=1792093241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uG8ZseyZcF0oG3DJsuVakiWKLz2P0jU9GThmD+dl66E=;
        b=UFuTY8ZU2NEuLXqEU64fuFS+LG/RsNRTMP1qcl4wFgDi29rVVHVM+jTk8Zta8yBIH9
         sVSP35TFBEQ8cf/bNHbJ5UV/MrP3h1pkwQLrJN616w+ySqAcfMqcJcClFAC/ewZ80ta8
         xiBOyBVBhgSbX6DZbQYKSm+Ud2N8SlJGhYylY4uLQGYMAZj0RGm8eVVCdjhVEWTlTYQs
         bOgaM6WOeKdKR3O8OUDqmWLXQr7nyKJiWVelnd47KN1WpuiwfWH3I3lutDc+xja0xwWj
         d6hna4UHXv+ruPps0B0/hhzPe0uAceydkxAtOUgZsxgwlcUNV+aKczFBwxPsu8wvyyyB
         A9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488441; x=1792093241;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uG8ZseyZcF0oG3DJsuVakiWKLz2P0jU9GThmD+dl66E=;
        b=OQlU7RxEL3ySlcuRf0nxT7Kd4lDzlPepsxJ9NqDtmAGeVndMxXG5rtklavg2PcI9CY
         r4g4RntK2BNnBzPuRMbQHsOsWqIhJykjkIlyUYYGNaArK8EEPY6mxegiSS2GRmQpjAhS
         heBpAm7rZE3v4kdQ4T/fDiWtKTZ/E4+FNG4WEYH+lX4hc/lYBPSfSca9iacyCiuXKFcX
         xvCZatJEwA32Gu8sZ1o5loPqrkO394akzDCcr3u/Gj1N/zyknikj+rUqpT5T9Mr0l38z
         9rnKoOKE2i/gS8SMI/dOvZ2BVj8kZ6coCV33DVbiPJknBQf8QJjUhP1T+L/zQBW/FImr
         Sdwg==
X-Forwarded-Encrypted: i=1; AKwUvBzvXLDAGuIJPMorfEBuBj+w9kpfwSjrL6Pu2c8g6YsY1MqM5plG18o1Tad5QQNgI1mj1rs=@vger.kernel.org
X-Gm-Message-State: AFuF++mnKzY72is9oh38qmXvhFybbjp+AsEsePHELIjCcPI5QQC0WqFS
	5WEcmZ5zOEnQcmczIJRHOxyrThmv0dlRA2pmkoFgJsu7Dfu2xCsB2Jx1ILRlHclEwRtBf7TIgF7
	qGNcj
X-Gm-Gg: AYBFou1H5dWqeuZdEefZTZcRVlGGqiAV1KWQC2FcAO/9FGy23njHtoqaJVz26gcQxD1
	QjWANUFowEJRId/cbmSTj8lGT0HrJxOvMSxnfF//TvRFcnNSysEFFZYv+ViDVYFyzeo+VwuqvTd
	jED+/StEDuaqmCWt6AwOWgRLztI977jBVh/92Omkwe8l/dqgHFz3pIiihF4spyRPtCSYlRi/7Fz
	pqr1nLNW4en4XsB73E7wqBKH+UprYm3Tb7mFVfuVN0oiW0qZ2CEDoCH0F8ZmsRct8jrhgm80DVQ
	oDNwC+5JA0W+VLIN9CNjoii32g7lcJ4UOmKNNj1HC+6VB29KFazkKAuQPvnD3AKthzvT/OaaczV
	tKfk9OM7a8F9V/rm2u4PobRvnKWxUAyW1IeO8DX37rRGxZeI8NPkLrQPzzCrb+zm6bsos3YtYjj
	Hi8VzQm9XuIjbSInF/oWz0NN7+GmHwsMUFlGozpTRCM0h6++80RiGoIwp+ztRcGXl05Ic1cCVSN
	SE62fvdEZR8P2lN/g==
X-Received: by 2002:a05:6809:208:10b0:4fd:2de8:eb76 with SMTP id 5614622812f47-4fd2de91151mr3740021b6e.23.1791488440753;
        Thu, 08 Oct 2026 12:40:40 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50b570cfd89sm179206b6e.12.2026.10.08.12.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:40:39 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
 linux-nfs@vger.kernel.org, Daire Byrne <daire@dneg.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH RFC v2 9/9] Documentation: describe RPC server transport
 classes and the BPF classifier
Date: Thu, 08 Oct 2026 15:40:37 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F684C9A2-688E-45FB-9649-8416517101AF@hammerspace.com>
In-Reply-To: <bfc94fc2c3501dc91462e99be11495bb893af731.camel@kernel.org>
References: <cover.1791402701.git.bcodding@hammerspace.com>
 <ef239ae64ae4379ad9a55d4fc3642d659dad4ef8.1791402701.git.bcodding@hammerspace.com>
 <bfc94fc2c3501dc91462e99be11495bb893af731.camel@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Oct 2026, at 14:42, Jeff Layton wrote:

> On Wed, 2026-10-07 at 15:59 -0400, Benjamin Coddington wrote:
>> From: Benjamin Coddington <bcodding@hammerspace.com>
>>
>> Dispatch round-robin across clients changes how a service shares its
>> threads, and the classes come from a BPF program the administrator
>> loads, so the administrator needs the model, the class word, and the
>> procedure.  Add a page with those: install a classifier with
>> svc-classify (build, attach, fill the map, check, change, remove, keep=

>> across reboots), six class maps and the share each gives its clients,
>> the tracepoint that shows the class, and how the hook, the program and=

>> the attach model work underneath.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  Documentation/filesystems/nfs/index.rst       |   1 +
>>  .../filesystems/nfs/rpc-server-clients.rst    | 394 +++++++++++++++++=
+
>>  2 files changed, 395 insertions(+)
>>  create mode 100644 Documentation/filesystems/nfs/rpc-server-clients.r=
st
>>
>> diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/f=
ilesystems/nfs/index.rst
>> index a29a212b5b4d..57a61ce0533d 100644
>> --- a/Documentation/filesystems/nfs/index.rst
>> +++ b/Documentation/filesystems/nfs/index.rst
>> @@ -16,3 +16,4 @@ NFS
>>     nfsd-io-modes
>>     knfsd-stats
>>     reexport
>> +   rpc-server-clients
>> diff --git a/Documentation/filesystems/nfs/rpc-server-clients.rst b/Do=
cumentation/filesystems/nfs/rpc-server-clients.rst
>> new file mode 100644
>> index 000000000000..b08351a88314
>> --- /dev/null
>> +++ b/Documentation/filesystems/nfs/rpc-server-clients.rst
>> @@ -0,0 +1,394 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> +RPC server: per-client dispatch and transport classes
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> +
>> +An RPC service thread pool serves its ready transports in FIFO order,=

>> +one request per turn.  A peer with many connections (``nconnect``, a
>> +deep NFSv4.1 slot table, a data mover with a thread per file) takes a=

>> +turn per connection, and a peer with one connection waits behind all
>> +of them.
>> +
>> +With a classifier attached, the pool instead serves its *clients* rou=
nd
>> +robin: each client with work queued gets one request per round, howev=
er
>> +many connections it holds.  Which transports form a client is decided=

>> +by a BPF program the administrator loads, once per accepted connectio=
n.
>> +With no program loaded nothing changes.
>> +
>> +This document describes the model, how to install a classifier with
>> +the ``svc-classify`` tool, what some class maps do, and how it works
>> +underneath.
>> +
>> +Clients, classes and turns
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> +
>> +A *client* is a set of transports that share one turn.  Every service=

>> +(nfsd, lockd, the NFSv4 callback service) keeps its own clients, foun=
d
>> +by *class* and network namespace, or by class, namespace and peer
>> +address.
>> +
>> +The classifier returns a 32-bit class word for each accepted transpor=
t:
>> +
>> +``0``
>> +    ``SVC_CLASS_NONE``: the transport stays on the service's *anonymo=
us
>> +    client*.
>> +
>> +``N``, 1 to 2^31 - 1
>> +    one client for every transport of class ``N``.
>> +
>> +``N | SVC_CLASS_PER_ADDR``
>> +    one client per peer address within class ``N``.  ``N`` may be 0, =
so
>> +    ``SVC_CLASS_PER_ADDR`` alone means one client per peer address.
>> +
>> +``SVC_CLASS_PER_ADDR`` is bit 31.  ``svc-classify`` and this document=

>> +write a class word with the bit set as ``N+addr``; ``svc-classify``
>> +also accepts ``addr`` for ``0+addr``.
>> +
>> +Dispatch rules:
>> +
>> +- A pool serves the clients that have transports queued round robin,
>> +  one request per client per round.
>> +- Within a client, transports are served in FIFO order, except that a=

>> +  transport needing a connection accepted, closed, or a TLS handshake=

>> +  run goes ahead of transports with data, though not two such turns i=
n
>> +  a row while data waits.
>> +- A client's share of the pool does not grow with its connection coun=
t.
>> +  A client with one connection and a client with thirty get the same
>> +  number of turns while both have work queued.
>> +
>> +Things that follow from the rules and are easy to get wrong:
>> +
>> +- The anonymous client is one client.  Once any classifier is attache=
d,
>> +  every transport whose class is ``0`` shares a single turn with ever=
y
>> +  other such transport of that service.  Within that one client the o=
ld
>> +  FIFO order applies, so those peers share the turn in proportion to
>> +  their connection counts.  A map that classifies only the hosts it
>> +  cares about and leaves the rest at ``0`` gives "the rest" one turn
>> +  in total (see example 5 below).
>> +- Per-address clients ignore the port.  Only IPv4 and IPv6 peers can =
be
>> +  keyed by address; a transport whose peer is anything else is left o=
n
>> +  the anonymous client.
>> +- Listeners and UDP sockets are never classified; UDP traffic is serv=
ed
>> +  from the anonymous client.
>> +- A transport keeps the class it was given when accepted.  Changing t=
he
>> +  map, or replacing or removing the classifier, affects connections
>> +  accepted afterwards.  A connection that must be reclassified has to=

>> +  reconnect.
>> +- nfsd has one service per network namespace, so its anonymous client=

>> +  is per namespace.  lockd and the NFSv4 callback service are one
>> +  service for all namespaces; their anonymous clients span namespaces=
=2E
>> +- With no classifier attached anywhere, the pool uses a single FIFO;
>> +  the per-request cost of the feature is then a static branch on
>> +  enqueue and one empty-queue test on dequeue.
>> +  ``CONFIG_SUNRPC_BPF_CLASSIFY`` (default y) builds the hook; without=

>> +  it there is no classification.
>> +
>> +Installing a classifier
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>> +
>> +There is one tool to do it with: ``svc-classify``, in
>> +``tools/net/sunrpc/svc-classify`` of the kernel source.  It carries t=
he
>> +classifier program inside the binary, attaches it, and manages the
>> +class map by address prefix.  ``bpftool`` is not needed, and its
>> +``struct_ops`` subcommands cannot be used in its place (see "How it
>> +works").
>> +
>
> "There is one tool to do it with: ..."

barf.

> The obviously LLM-written documentation gives me the Ick and I stopped
> reading. There is also a lot of info in this doc that is not
> particularly helpful, like "the things that follow from the rules and
> are easy to get wrong".
>
> If you want humans to actually read this, then it probably needs to be
> written by a human. If you think the LLM slop is actually useful for
> other LLMs, then maybe put those bits at the end in a clearly-
> delineated section.

Yeah, you're right.  This really got spit out of the AI tubes without a l=
ot
of refinement by me - thanks for reading even this far.

Ben
