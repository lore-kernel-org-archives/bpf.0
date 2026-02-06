Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28B277029
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390303; cv=pass; b=adziZVMjv8LW6EElZBFY4S5+4cthphXTMgDFwm2Rxh11JQboXvTE4qhNjc4ixNpVvKrB+liNdGkyoZGsfVXcCZzPX7gYmKSyOJlPjHzBb0dSV143HTHUrnbJmzKqfGY0opq4iwBOZdxErhZ2WJiVUsz0MGIE2GoxY4tl1b8q0tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390303; c=relaxed/simple;
	bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OR88Ty9JC6BOJ85s7Tw6HC8LuJTFHX+A5Ics5DAdvtTETAEBI8SM7AhZ5eamlhIeFbj+xuf97mHN/jrNRWraVBoIxyQ5jyTPkpjUrsGwT2aA3rRlSzGWwtsAxgWOI4K2+diH7Pem+JWmA/nSlmaBwdilca3guMhDi6gVIii0pZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuGqi28g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMgjoE/C; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuGqi28g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMgjoE/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770390302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
	b=AuGqi28gpF3ZFV83TCjfwdSjgeZghO8sposyArKcw8guclPW2R36HYL4OO7umxJX9cDDeW
	+4sTFahOAmbqEsN6u68egDrlQKXiRJHwxnj6hUY/8aCRBZ9yRnv9zH4Ygrb6M4Wr4PZFRL
	/jePQN+wLUyrxzmhk9MKEYJE8PNlMxI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-TBpFP2h1OF6cUhEBDFLsYA-1; Fri, 06 Feb 2026 10:05:01 -0500
X-MC-Unique: TBpFP2h1OF6cUhEBDFLsYA-1
X-Mimecast-MFC-AGG-ID: TBpFP2h1OF6cUhEBDFLsYA_1770390300
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52f89b415so553103485a.0
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 07:05:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390300; cv=none;
        d=google.com; s=arc-20240605;
        b=PtIgnZKyrTebWxF6owwVDsEPRgcsS+JHo/T1NI/Dgsmv+DrS9KoYnNuVlvP491ByGO
         Wn4VdfE0Dgb6jE5zJ+5VVj3dzaXQCcVs/H0oGtfxuwn7JgMb5Xl/z2YPZ7wu0tMH77vA
         t5XmYt+x66b+j4E9Xlp8Tz34VyF8hRfYcdToS63KTJa/O8ZIQfnl0eD45GhncKwOnwG1
         ILrkjlrU72QVL6dzG8rn4VAyM8Psb2Tv5C+Ayxo/TmvcvVpN1pW7yXBla14TNlAIs+qM
         1YFHEHejX6oNHKsF8n0YGcvex5yMUB9/+GE5RX2UZAgnAeiN0v3U1eKUvwFc9LUymlZQ
         +93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
        fh=G/s5p0C1aeMgcfHTTx90ILubyPN7q73gK2dsjqa862w=;
        b=E3WXagy+k7lb8JiY0FfuVTL/BfP2qpU9Lhvp3A522kk4vflfZYzvyRBImmMnMsOhTH
         HavxAsw/kDLxA7Ek0LgQg5yrbx7nPb2RWPsglibgUL4V+3suibDrCrwK7pJUCuuZcZbG
         zo0YUjWRoukuDpyYTTYcLCPd2N3Xc4Dk9umAbWkk9Rz6W6T84gGHNAnqmzoPh27WLs8B
         wJon62dMY97S8Kymk+1Uqt8MjYXi1VPNVNzdjVmva/PurB4Jov5P6FxaMTjv6PNg9kTY
         YRz19k/E5oWVwGe/CcZlpJVd7tjZaY1llZaKkfVf+6GsRtJQbA66KKpaRy8/vCJujH3o
         pZzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770390300; x=1770995100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
        b=LMgjoE/CQnvRP6wEL/Q+FvY7UCQ0L/3GY0SKMIV5/XXdBQyEhHThQfmoOjWwRfzXKz
         mvrw3NR+mYheG1YoaS8NMC8gHMHlxiZHjfRajdDBBB38bXClw/BgPImd9DROpUraYV09
         FbVuIX6y1ZGaVzT8VHzEW+lzsAIs/Iego6+ENPQdq2kzO4r2oRwD1KjVRWVm0FCd6rLo
         EIr1sWdO07qjk5GKzCO6MwjLbEDg1Uj45LT2lrm9Y09ext8SElC8jS/WowLfuBc1nHKI
         FktwkrjXLLof40tZo/VjZv5Sv7HRKNqwFWAMwyWWbYbF4KmAvf4zzwS3FOpSF0sqmaeZ
         hyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390300; x=1770995100;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
        b=bbwY4hDIr0rmFh7XAbO/94oxC+EsJaw5WUd3wBJruCq8zFMo2e1B1rfpscJ2VvGMWk
         itt6CERVxOFpdlVAxr35zQ8Vpg+x84Opqxgh2+Up2X+iSHXsvbqacjBeAcFsEx7FVKUI
         s+KEstlRr7TfVRx9Wnqc1xfCkhy+dp9Zxfmzm55VoV2+hW1n2ZY4IIKxeZnHgkorzTOS
         RfzmMSLnnnvtFFf/Iobif2Q7ZreXuNkL021q7/TVsIIRYcTO6/WpocRlt8syfyMPApWS
         9oestY50K1k5WsQp+DpSXX2nGydwzp1Zq7wjWzjhQVHv3HvjUXuHBQ3w4iz2A7riA7In
         2EMA==
X-Forwarded-Encrypted: i=1; AJvYcCX+cOqLBV+Nz5Bl6U3nb24XCp07t/fUFokZFRMBc0aRG+hR+4L7+5LrINin1bXJz63Iago=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhh4PrCQhtDl5zlrLtTAxJkiJZwlPLf8z3cJrC2T5j276zzEkW
	xT/N0c1iCqqG9PK8pejI8e4awImGD+De/P0JlQ1YbvFBI1cLtc+YaZH3BjRbdysBumZPBGrqoJK
	q2G9U15q3XoCUifokIwbFJszwMOBzz5f62HILrj9qbSD3ihQr1KBu3eCcVzerIY4ckC+tEoysg8
	eupdS6vEyJ7V9nu5kqGFTnX1H8BSiR
X-Gm-Gg: AZuq6aJMvdpKTsDdevFWYoI7Xbx+gIeeYIaJR+srgVayxZYI6G+Q3qHV+JL7uA3PDIF
	AFiqoXWmv1ga5tbZxA/MvbJ8jiA+kirhLPgP03R8Z9j2S2slpeTNARRRe4H8gYMjpJQ2M8iQOSs
	RALG8qsoZ4MEYcI0h1JOEdZfsBP06d7KgjYqZ1GVnhOmiHVOYbrYU/FAdrLjrEzb5w88+nNBogj
	lKfruc3th2QD7sYPFlGoyFN5w==
X-Received: by 2002:a05:620a:3720:b0:8c6:b14e:655d with SMTP id af79cd13be357-8caf24957d2mr345816485a.74.1770390300481;
        Fri, 06 Feb 2026 07:05:00 -0800 (PST)
X-Received: by 2002:a05:620a:3720:b0:8c6:b14e:655d with SMTP id
 af79cd13be357-8caf24957d2mr345812185a.74.1770390300049; Fri, 06 Feb 2026
 07:05:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Feb 2026 09:04:57 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Feb 2026 09:04:57 -0600
From: Antoine Tenart <atenart@redhat.com>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org> <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
 <877bsr1l1h.fsf@toke.dk> <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
 <87v7gbz1ru.fsf@toke.dk> <CADCXZ1z-gg_VsN4kjf325HvWRxL1irhUC76B_erggm5+A7qQ7g@mail.gmail.com>
 <41da26a6-4024-461f-8254-ac5dcf231397@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <41da26a6-4024-461f-8254-ac5dcf231397@kernel.org>
Date: Fri, 6 Feb 2026 09:04:57 -0600
X-Gm-Features: AZwV_QhCilbFjpthzPSYyG6IlbwC1XfYP-FBXIw9tWB8TwXWyelscAaiXVYCVmc
Message-ID: <CADCXZ1wMxCN3B-c+x4SgqC7H-Wap=e_sJ_hu-2B+96b=ip9OVQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, 
	horms@kernel.org, jiri@resnulli.us, edumazet@google.com, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 06, 2026 at 03:41:23PM +0100, Jesper Dangaard Brouer wrote:
> On 05/02/2026 17.24, Antoine Tenart wrote:
>
> Can you point me at the OVS userspace code that consume these subsys
> drop_reason's?

I think this was mostly added for debugging utilities and not consumed
by OvS directly but I don't know the OvS userspace code tbf. Anything
you're looking for specifically?

Antoine

