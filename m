Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C3395D9F
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929380; cv=none; b=PTJSmSstQ0AuHpUdzTeOMGdA1zG5yxiigQO3NQJ9+iJ/nM2Vt+H4yzGx1UDjOW9+O8fp3OaPO9fr16bCKVzozblB/xml0HBpzKpAR0t/22IHwIQveGiTJd94EHUXancagjNOlMB9NGVke6y9ho/wwaCJeOtaxHGNjpHADeMOOcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929380; c=relaxed/simple;
	bh=NHfZjyhkVxC1U5fPhVwFtqICNsZ1kIJkn+jnD7xhz1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhi3HAuBSU06au6Gl1hKw+nTGkW/s/hBHvWWIS01UtBlZejPqXOVQTI3+lIU++f6us5DCn5c0AFNYr8lVKiVcWzz0jECFO88aBFZbUA4kHxj36CNgpyTQPf4XwugsMTMpJ5pjdTAeV4H0DdvKF9JYA/Tr5aPwkWhNDJSNRZU3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvPUJUu/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVx31Ah5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvPUJUu/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVx31Ah5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783929377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHfZjyhkVxC1U5fPhVwFtqICNsZ1kIJkn+jnD7xhz1s=;
	b=LvPUJUu/1sN6FQd8A31LIgfr4LISqVaSlXp8kQ/RXNgpeEaee2xZu2ONousUMzex2kof82
	9WMhEfEFWGtmhBdd3/eb/Y5bA/Av/9R7x7svYFlT509O/R6n8RhyEJFq4PsfRLRXxkTCxZ
	Nc7A7TBB2XVftoXVxb9P/+hT9pFCdYY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-HQo9yLKgNBC_X9ijgXrSZw-1; Mon, 13 Jul 2026 03:56:16 -0400
X-MC-Unique: HQo9yLKgNBC_X9ijgXrSZw-1
X-Mimecast-MFC-AGG-ID: HQo9yLKgNBC_X9ijgXrSZw_1783929375
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4926596eebcso26476415e9.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783929375; x=1784534175; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHfZjyhkVxC1U5fPhVwFtqICNsZ1kIJkn+jnD7xhz1s=;
        b=UVx31Ah5wbD6eO9vavAhPOWCTd1cErlqT9PphP4mT8XMdu8jxr3OQx/YH1JcyV0Pm9
         1YBrIg0quoM9zMG8JQ4rbkloyX9G82zIPmr1IWt7u9w5si7UcuuxXb67lrqiZ/C/UfQi
         BIYJOz2GFi7fxM1SOy/Qx4vuJajfIiSMt1nzmChLWzGTlLB17XDvpNqbiVOHhCkNWxMk
         imUI6x2tYvCar/buSGgfanI2rGVhQZ4vqVwcovGVTAknlWHOTcd+snOnHVl2fvauO5mm
         Xm4UzCFoKx202CDdy5kzBgLfmoZzG6HnVguP4xcja/3SjtMcBvaDiBpHWSM1D40fkkMJ
         8/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783929375; x=1784534175;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NHfZjyhkVxC1U5fPhVwFtqICNsZ1kIJkn+jnD7xhz1s=;
        b=YUE7rPdwOf/gO08DBMbxyJKZsWHASFcrxVEvy0XCv20HTpElE53NCub7S4eTIGk8X8
         Rr9wAhsADNCdyN6tp17xGUJ21YLYs+oaCX42Cd0VvvZzbnK5SOOyw9QmydTACp937g0n
         2PK3miv6Uy6yV4QU5Hq6waCFbgar7cj2gqwyRhtDtcMpSgcv7Cy3Tk1nBllGda+DdtAb
         kByu2a4Lt4dTZATv7xjLfecxN+ZTvx17iFQAduzay7KO8ObFX/nRkchCqr+yZV7ULIaZ
         hsIZZft/GsF+eyxpvlX4P/JefR+GaP6eLJ5fWvdjD5aWrQWPCJNIPmiIvlF212hR+TEp
         2LuA==
X-Forwarded-Encrypted: i=1; AHgh+RriyYp1dS8G9xTVvCs6+x2pBPtdOqYD9H/L/rONjarVtoPe4ZWqJIU91mC9NuBoeafYOj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX0pLfFO1+y2aT7awLEMfDqW3uBGD/LjbtI7u+cNNz5Z/AxF/
	coS4k5EXo4WL91HI7wmJ7w9x76SDPu7FIOi54b5PJ9y4JcE7NkaSAUpN5ftBbx7QO6HzT7Y9Ta4
	2yAe+jAwitZJyukYeUCQeBlv03MntXEE6ZADUKlxGAwyxY0wYRrDwFQ==
X-Gm-Gg: AfdE7clqF6BCi5b/die0EBa+n/geRXlP3E+AJ5a/GskLtC8Q1E/to/Jk8BWTXjBbVwJ
	x5YcIdqe8idU5MnmeUmKYr96UL4OLWQkQRkpAoAKvYJAptbUsl2CB9tmL3o90/y8nAErQMrFmnI
	kIVUkt4NfOCMdZfczFtrX1EGG0jsEYWh7GQmw6/r4nq3fsPhjlVpT8TrUyPHuahpRvY2iGJE6Mx
	hj8PNXIk8dRAecIablyFu1aotXtrPYebwGCNJY4EoCZCfTa7+cegd/YPL7y78SHtK3RguHIb1zu
	1hbWPa68DiAtOwntYV9tiGIvbEiOpdYQqkwoQkEIz1i5TAynYJ0b6zCF1CKTRnkBy75wIPaU8Pm
	lCQb5CFryNKNCR7JyaGVAhjgyYdNKrmoQYFk6lw==
X-Received: by 2002:a05:600c:4ece:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-493f87d8573mr76495175e9.8.1783929375274;
        Mon, 13 Jul 2026 00:56:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-493f87d8573mr76494685e9.8.1783929374804;
        Mon, 13 Jul 2026 00:56:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm85537025f8f.22.2026.07.13.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:56:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 20E94869E8D; Mon, 13 Jul 2026 09:56:13 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net
Cc: a.s.protopopov@gmail.com, ameryhung@gmail.com, bpf@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, eddyz87@gmail.com,
 edumazet@google.com, emil@etsalapatis.com, eyal.birger@gmail.com,
 hawk@kernel.org, horms@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 leon.hwang@linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, rongtao@cestc.cn,
 sdf@fomichev.me, shuah@kernel.org, song@kernel.org, yatsenko@meta.com,
 yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260708080434.732503-1-avinash.duduskar@gmail.com>
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
 <20260704092159.1256823-2-avinash.duduskar@gmail.com>
 <20260708080434.732503-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 13 Jul 2026 09:56:12 +0200
Message-ID: <878q7fl3vn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> The bpf ci bot flagged the VLAN_FAILURE re-issue advice in the uapi doc
> here, and the finding is real. By the time the lookup fails,
> params->tbid is gone (the h_vlan fields it shares storage with are
> zeroed on entry to bpf_fib_set_fwd_params()) and params->mark is gone
> on the resolved-neighbour path (overwritten by the smac output). A
> program that follows the advice with the same struct and DIRECT|TBID or
> MARK set runs the second lookup with a zero tbid or a garbage mark. The
> selftests did not catch it because every arm re-initializes params,
> which is the safe pattern.
>
> Toke, the re-issue recovery came from
> https://lore.kernel.org/all/87jyrwf9g1.fsf@toke.dk/, so before I
> respin: my preference is to keep the mechanics and fix the sentence,
> "repeat the lookup without the flag, re-initializing *params* first;
> output fields overwrite the inputs they share storage with".
> Overwriting inputs on the way out is the helper's existing behaviour on
> every path (rt_metric lands on top of tos/flowinfo even on NO_NEIGH),
> so one rule, re-initialize before any reuse, seems better than making
> VLAN_FAILURE the only return code that preserves inputs.

Sure, SGTM :)

-Toke

