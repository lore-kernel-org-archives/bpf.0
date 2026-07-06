Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E564DB548
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328517; cv=none; b=WU45+9AKx5+hdjcubvpsSImHbXDQ2KoF5MlrZDmbpT00WpovEwGWchxTuqMOl8Qoh8BJzEAp6ame1HBS9A0gRMN5hO1139UOeF1fyj1GNDs4S1kUuhGXoTAA33TvZMZgL2hgyMFDdDgce1tPKQs/m30Vq+NMYG5glaQ+dlvhdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328517; c=relaxed/simple;
	bh=m8GIGSsnH1qHWVBzg3/OAbWR9kYTaq+n6KfKIsKhZbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bER2Csu3aIjNsSjNs+ZJ7v4Pkp1f1c0F+rOuDZCVqsoTpVgGASa+ZUJLoT7JpmAbGXObJvaPULhgr8/iZWH+1ZUPwPaMSHMO5LUhNto/HM6JgZbqUVwFS9JeIZnmON7kGO6Aw75IQ1dzc0q1P9p2LceXYXmPX7jNJojiKM8A0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0FBt5s7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/GdIGhK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0FBt5s7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/GdIGhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783328505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqWYV25RKvq0b7ohsITiNfXnDbPI0PkgLTXYoW15CpI=;
	b=W0FBt5s7YlMRCiBo8teBi+D3CyozF32hPj3YNQRKtCXnSuLgP4+VHEfBaY7fhjZ1mlRtVK
	KKFmjnda7MMLOTZNs/cx6CGixSUCadeDtlZoNINvPXOxccCJAQZTu+t8S+SCxUgqNC37cp
	u656XMjTsUebzYmH/bACN3C/vZIrCXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-aV77UCP0MmiH3YzmGft0RQ-1; Mon, 06 Jul 2026 05:01:44 -0400
X-MC-Unique: aV77UCP0MmiH3YzmGft0RQ-1
X-Mimecast-MFC-AGG-ID: aV77UCP0MmiH3YzmGft0RQ_1783328503
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493d742c668so8047615e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 02:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783328503; x=1783933303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqWYV25RKvq0b7ohsITiNfXnDbPI0PkgLTXYoW15CpI=;
        b=S/GdIGhKXvbJnLAbg0Hqa2QLbZfkxxV4uukXWcNVu4yjhHLtjhGco5sl4RKxUjvu/R
         KxJYek3vWmZshn5gxLRvl96nTnLh1SnCJNE2hsgbE2WdPwgPwHscmmgWjmaWiOMUVZzn
         te1S/1pkLEl73yyIPPCbqa+NOZn4lFhZSibXm2gessnloQfVpVgiQZHx6Pyp/KUZo0Uf
         rmICP/lOKvXaEm/UVR1VpSVMS/qu4zvW6VzXMomVkbtps7VZgea4JO5joLfRMGNKVUBp
         mu5P430Di+FSqffOaDDifGs/Nyb77o9QqSd1Y3oy9xgbohWHJNkw58n9Gb72v3LwSsAH
         TjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328503; x=1783933303;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqWYV25RKvq0b7ohsITiNfXnDbPI0PkgLTXYoW15CpI=;
        b=mg7TWklNr12TAWGGjDxU/JLk+1dzIJXHp66O4DvZf/lSwblg+w+4cENrksAywJQYgV
         wG0ac7hpp8aIEkoSFhdzXzgLa8rvtZYEBHqnJDFEV44VeuPDUUV/7fKGq1SHOFUkA+Ar
         zsvD3nGfSb/0VtmfPJF40YXDh1/+6jEhDyRGLrA/lX4vuoK2bb6dD03IYAf/Po92bjNH
         tUfcV91dX6wQOYHdl+iE610iTB1omcR2033Bw6p6GZKZMeSjUfq7C7kJi0uPbET8OKT6
         LLPO2VyrfXgHbC5T8kXieQfIUeuebyIyakF80BICc1p1ao3mm/WS7/FkDMtzgxyXZozG
         FwEg==
X-Forwarded-Encrypted: i=1; AHgh+RoNuD/h3mE/cJmsJv0hfLPzbMnYXX0G3kR+7iPKolH3nkndgGCI5VwBjse9aLUvfp3tnKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvFISxVBfZGL01m0uyiNSPFvuzyzHSExJCJjjqH1iYtgtgkpx
	gY0dgrQEECxQ28gT5LGhdiw6DHyzRCRwYflD0idTxhI2MtDeb50GRCf8rL+wZvCFsSiNY+G41qW
	bxiKggGMADjOXX1rVlAzi+JBoCFLLlWrNGNAPqeNqWUOaigNgOMNAYg==
X-Gm-Gg: AfdE7cn2bOJwbfzUEVZ9khzsvbiSTLogFhAFzJgqi8OI/V2xriWuwMcw1MCDvSMqZiv
	k1nAvIk3jVtBzAnJ/jXHjA3+eTny2sc/Xb+z0bMckir43FiEw12yNfJ6fI/3yKytAznPHBTG6o2
	iLi4bntwMg4KS7qGHXvQXiHhYjI5JzjQ9n3h2cDdXTBaP2MyWF1P2We+dVEGZVYY2OIa9Lf3VX2
	4PSKPBLF60Lu7fzPfhgS2aE4chloZ+NeLvp1mXXnnCT6r2tGFL5KXulSzAp91K1oXu4NO2Lpdyp
	arDqX4me4s0KfS0ka66Gg4ZtKhj4NHja8y5Y/xpxdBcr+okYR0Td4dIWZj05w2Or4Y6GzqyZ87i
	Y1ox2se4s64zAiZP3YalTLVR0vSSlDr2taAq0B5cI9vjX9/enekWLnb+BBBeEhidIYXTJe2Fm+p
	1nEpnPbrcQdcOp
X-Received: by 2002:a05:600c:a00a:b0:493:c389:d434 with SMTP id 5b1f17b1804b1-493d11d68b8mr112191355e9.15.1783328502804;
        Mon, 06 Jul 2026 02:01:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a00a:b0:493:c389:d434 with SMTP id 5b1f17b1804b1-493d11d68b8mr112190765e9.15.1783328502258;
        Mon, 06 Jul 2026 02:01:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm406103625e9.15.2026.07.06.02.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:01:41 -0700 (PDT)
Message-ID: <43c79a50-eea1-47b4-9a4c-5c61e611c059@redhat.com>
Date: Mon, 6 Jul 2026 11:01:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: jhs@mojatatu.com, bigeasy@linutronix.de, andrii@kernel.org,
 memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Victor Nogueira <victor@mojatatu.com>
References: <20260630123331.186840-1-daniel@iogearbox.net>
 <20260630123331.186840-3-daniel@iogearbox.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630123331.186840-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 2:33 PM, Daniel Borkmann wrote:
> From: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> When a TC filter attached to a qdisc filter chain returns
> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
> act_bpf action), the redirect was silently lost i.e no qdisc classify
> function handled TC_ACT_REDIRECT, so the packet fell through the
> switch and was enqueued normally instead of being redirected.
> 
> This has been broken since bpf_redirect() was introduced for TC in
> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
> for a long time because bpf_net_context was a per-CPU variable that
> was always available.
> 
> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
> on PREEMPT_RT.") turned bpf_net_context into a task_struct member that
> is only set up by explicit callers. Without a caller setting it up,
> bpf_redirect() itself crashes with a NULL pointer dereference in
> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
> adding skb_do_redirect() calls to every qdisc classify function, which
> would require changes across net/sched/. Isolate it to ebpf core where
> it belongs.
> 
> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
> wrapper around tcf_classify() for use by qdisc classify functions and
> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
> than letting it continue silently. Dropping is preferred over
> letting the packet through because the user immediately sees packet
> loss. Silently passing the packet through would hide the problem and
> leave the user wondering why their redirect is not working.
> 
> The clsact fast path, tc_run() continues to call tcf_classify() directly
> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
> sch_handle_egress/ingress() calling skb_do_redirect() as before.
> 
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

I'm sorry, this does not apply cleanly anymore.

Could you please rebase and repost?

Thanks!

Paolo

