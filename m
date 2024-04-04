Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B724C9F
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712193075; cv=none; b=NkZ1/WAhrpt66tBuCekVlUqdEQ9xWVTsd6DoItlbI9GJs14Y4gCeIvug8+xi1eo9PtWUhfXGTXGW+eLuMafuRfMw0JZe+O4cdV8wluIwOc67vlYN8Agka/c73hQ9+T6It6tM9LOspYtWMgIuCGad8xqWFhGkDqT1FRiuf9Ym2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712193075; c=relaxed/simple;
	bh=8qAxV+HRLVd9tpuK/VHTwTO0kGdAvx5FAUgsICd4NSE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O9N51ZMgyM7V9JpfMWTJKhE9k4PYqmCBwZuf8IDlVIqXUaFYmxEqeORwaxlJtgWVSJC1/ckcmwyUgsW87mtO3Wz0fOX6tniXdYlV5gmFbLoYHZtLVnFSLi48skrJCYHp/sFsoSBq+oTuDTUF5H0Bg8RtS6N1qB1Ix/x8/7tWF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CToEiavX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CToEiavX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0bec01232so3814345ad.3
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 18:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712193073; x=1712797873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6TLwQwb4gPGALGCRubv48VmueuDJg3TiY2D3GohhFA=;
        b=CToEiavXmghn6rA0ETaii2MxFS4OmFZ5p7jXK7+3janUflgeVj+2LCaTZnBFcA0zO/
         SizkG8MGRYe5BZU02KaAPcqfpEz9SJCXOp9FRrgaqScDe2u1MKSM55MgMZMkB6iIYKWz
         FMx9a4kFmxyaU/H2ydD9+Hp42uAMnUlfVgnxAAlRmikfCVAkmgzVaKlsZXdqpOKQ1uUz
         kgpdbyu9rNMM48h5NFCJ61wXwiBtZh+Qy+SBUMEU1rwa+I1HxEzQRDF4GnwglG7ag2pX
         M9aaOr2QGVOxMGuqXLkU28JPDJD78a0ikoI4NwfKOUFWkfaah+QMxHgMcptiRc8T2R8D
         cg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712193073; x=1712797873;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/6TLwQwb4gPGALGCRubv48VmueuDJg3TiY2D3GohhFA=;
        b=IhQhBvH6c8jWRMJk0nzfkzYkBbitKFMR8t7vKozmUGnxDX/LdRKe0RFsbKJ7gYOvSU
         H4JGTPXflL+mOhAiWXkzBRmMRpjPT/iSdv9bQ5+qJAqifQt94h+xiJ4FIfpeNnNrolv3
         grBHBPN0oPN3nV+TF3+wnUdPaIH7GskcHsbVy2jORvzcAutLW8jpQVU+Bdbb9UvfsavA
         6uH4nvQz5uc/izXpQoDOUY4+5UH4lg02JZ4V7WAtvtI+cgbTg9zr4BU56+mYbx4BitcH
         PYoBfFZkO744RVvUK56W5DUKJpgcmgJE38Tk/eYl5iLJCZmvJp+hiytJMpVvUfOJfCgQ
         nmGw==
X-Gm-Message-State: AOJu0YyLiYo+RnEviG99F27f3HeyfvAswjbexffPf3L31WvYXgL2jRhi
	I5knbEjw8/n4Nf5P9uByja6m2r7PbFfusgX+HcjWmnzoth8N1JyC
X-Google-Smtp-Source: AGHT+IHVmJmNW53ngwnX+5QedZjwhdkOgLzeK127bRDPldoDt4RS70tPeL1zROU57/ZwD6SD5zlx+g==
X-Received: by 2002:a17:902:7c16:b0:1dd:a912:2db3 with SMTP id x22-20020a1709027c1600b001dda9122db3mr894001pll.17.1712193073043;
        Wed, 03 Apr 2024 18:11:13 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001e2882b0637sm3180523plc.255.2024.04.03.18.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 18:11:12 -0700 (PDT)
Date: Wed, 03 Apr 2024 18:11:11 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>
Message-ID: <660dfe2f46769_24afa20845@john.notmuch>
In-Reply-To: <e49ccf43-ae90-4df1-bc10-5ee180ec47ec@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
 <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
 <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
 <660d964a1444b_1cf6b20885@john.notmuch>
 <e49ccf43-ae90-4df1-bc10-5ee180ec47ec@linux.dev>
Subject: RE: run bpf prog w/o sockmap [was: bpf: Add bpf_link support for
 sk_msg and sk_skb progs]
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 4/3/24 10:47 AM, John Fastabend wrote:
> > on my todo list, I want
> > to just remove the map notion and bind progs to socks directly.
> 
> Run the bpf prog without the sockmap? +1, it would be nice.

Part of my motivation for doing this is almost all the bugs syzbot and
others find are related to removing sockets from the map. We never
do this in any of our code. Once a socket is in the map (added at
accept time) it stays there until TCP stack closes it.

Also we have to make up some size for the map that somehow looks like
max number of concurrent sessions for the application. For many
server applicatoins (nginx, httpd, ...) we know this, but is a bit
artifically derived.

> 
> > but other than quick hacks I've never built such a thing nor ran it 
> > in production. 
> 
> How do you see the interface will look like (e.g. attaching the bpf prog to a sk) ?

I would propse doing it directly with a helper/kfunc from the sockops
programs.

  attach_sk_msg_prog(sk, sk_msg_prog)
  attach_sk_skb_prog(sk, sk_skb_prog)

> 
> It will be nice if the whole function (e.g. sk->sk_data_ready or may be some of 
> the sk->sk_prot) can be implemented completely in bpf. I don't have a concrete 
> use case for now but I think it will be powerful.

Perhaps a data_ready prog could also replace the ops?

  attach_sk_data_ready(sk, sk_msg_data_ready)

The attach_sk_data_ready could use pretty much the logic we have for
creating psocks but only replace the sk_data_ready callback.

> 
> [ It is orthogonal to what Yonghong is doing, so the title changed ]
> 
