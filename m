Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D3355F57
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805603; cv=none; b=NExb5TObJ8/EuwUVHGDBYZOVXz+1X44rpUzvblwIjzCIET4nDjSOF9k9VY+6HnOODzRhZkjvmnopPzts41OaA4Q2M5i9yTlBj2Idrg+pskYfGE3HQY+cTcwsSezXGrV1+ciMVs7GsLS+TQdvWDWrZPHOuYmOn8xw3oZXYJlNCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805603; c=relaxed/simple;
	bh=YeBVCeauekm9I4EZoE9KgKDLAKsaRIrAyNxRCFPDe0Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmnTrpTIVCLhtzI5z7VYxPfN8YUNlGu2MXERcbZlhL/aZD284yTw/GOz6JVrn6zvHqD2dWpF1yP1JrfF09BWrKWRP3AyIURFloxsF8wAEBtzH6E50xm983zsXQ0zPixOBoQE/Ofe1aoth3BkQ+ThQO6UrSt2EEWr8QBtxF3UMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUawmq9n; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUawmq9n"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so112099215e9.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805600; x=1780410400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UyMYHXc7gW0Hm+VADntLu7+SEKFOAsvci8NMt8Y69Uc=;
        b=KUawmq9nFNY6LYNFtwpPQ5uLUaJZsTJsh3gHPeVoj933QngpNCprUuhI590HG02Ijw
         ixFgwXsux2suz1IAhwJGtEmRvW7YiVVC7GmYpEVLrH4MLXqIc9xVUchEc1LIZYEqW0J7
         92wIeliuoxTL+opCb8ItmLUQCl8LYIeWr8pQabAnXqXW5t8wEZfboGgRrBs+kqLIH9RB
         0w/6AXM9RBFO7EG4yUPGA1WuMVIJ0WFnjlUdAIUaMG5PNciqQzGnXiOpjYfLjz86bzKa
         68KKHXkbAf12BEETYUVoo5PGRvVY7tSzTE9gi4mgs+vtahQuHwsLBko4z0mA770Jtu+X
         k6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805600; x=1780410400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyMYHXc7gW0Hm+VADntLu7+SEKFOAsvci8NMt8Y69Uc=;
        b=iNw++llEBLJ7hAf2KFvdOcS8fPfThn7KY+CsESZJxvuhz0/Uyc4IhcDqHFDlUT6bgl
         1SJ6JLOBIOjeGpPPsIQRWPNLsR5IP6n+ApsmZahXjudpyO89Ruxa5+uGlY5NPP3TcjV1
         kEma7KuWtE3P7+2aUpcx4g59wuR4IxoQ95cTel68IUce3JgBtr09yRzspH+Ag+j3DIz0
         eKDZAfdHQYEYKqsDNJ44g75PzhilzeyC9ioFpiFkev4B5XyUpkzERXX55PF2SCNT/SCF
         /5ZJ/32XKyflqNq8f/u24DPWbUyehlVJLSQR1xBp6Q+GJm1m1LkSjH8gFDM999lSZOJZ
         Kf+A==
X-Forwarded-Encrypted: i=1; AFNElJ8bVxbl8pcAQsJUYLkcUf+DyfwvAz1TPXZm9nHfCFoIKwzs4iGPvHMIBSeMQJ9Ri9yFODg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRIFpIpAYB5diUybCoIMdT16WJSWGNRJZajhdxkjDvDD8M4Di
	8j32fnjto9V3C8YhWKbKjAOUCglqVBxA2/E0A8100W0X2D6nn3S1KrpF
X-Gm-Gg: Acq92OHpRkd9yjdF0rs452xNZhKpN8hnL7zaWD2ZGaSFPgesg19apnoIXNTRViNS8Jv
	xzNnyjx6gCO0yB9sadJNdllEpSj0SKBBkq42gYhkJH7e87mpl+cARik8nLk0AHYqG7jxKvf9X4O
	qSR+ghNQutum6dly1lGCtLnORtpi6mxfMi4gHyH6LpJ0jpu4v+NqvhoAY059wrCcBLBNhYUMjcS
	UTSuOeQOV1k9vXXmPFLZ39y+p63MkOfM+MsbSmdMcUFf6dg4/W8efBjccKl+AIMaXj/7VShbufP
	v91bZZGn2xajqiJf+CaJGccRWoEMq8rGbE5kuaDa31RfxNAX/VB9FQ96Ms/8wFTLNA8MCKlW3VI
	3vqMTctDOBTy7BXYQjSU5F6M6sWmFwVc0Xdr8NmmwxloSm6qcSlBpwBcuF9afSkczxPeyz6eodP
	L9DfDuUgu1QzGCpHQ6
X-Received: by 2002:a05:600c:628f:b0:490:5057:f602 with SMTP id 5b1f17b1804b1-49050580d79mr258141665e9.17.1779805599766;
        Tue, 26 May 2026 07:26:39 -0700 (PDT)
Received: from krava ([2a00:102a:403b:6530:533a:f167:d705:6aca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d71688sm37991070f8f.33.2026.05.26.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:26:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 26 May 2026 16:26:36 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 05/12] libbpf: Change has_nop_combo to work on top of
 nop10
Message-ID: <ahWtnED2e7RU64B4@krava>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-6-jolsa@kernel.org>
 <CAEf4BzY3bV+gkA4fRm=jzaTowG1QtXogLDOKkG3CrR5EWzDPcg@mail.gmail.com>
 <ahDKatbb_ixUY_XF@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahDKatbb_ixUY_XF@krava>

On Fri, May 22, 2026 at 11:28:10PM +0200, Jiri Olsa wrote:
> On Fri, May 22, 2026 at 11:52:56AM -0700, Andrii Nakryiko wrote:
> > On Thu, May 21, 2026 at 5:45 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> > > fixing has_nop_combo to reflect that.
> > >
> > > Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
> > > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/bpf/usdt.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > > index e3710933fd52..484a4354e82b 100644
> > > --- a/tools/lib/bpf/usdt.c
> > > +++ b/tools/lib/bpf/usdt.c
> > > @@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> > >
> > >         /*
> > >          * Detect kernel support for uprobe() syscall, it's presence means we can
> > > -        * take advantage of faster nop5 uprobe handling.
> > > +        * take advantage of faster nop10 uprobe handling.
> > >          * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
> > 
> > Would be nice to add commit that switches nop5 to nop10 (but until it
> > lands hash is not stable, so, hmmm, maybe we'll land this patch
> > separately? send it a bit later to bpf-next?)
> 
> hm, I think that would affect the subtest_optimized_attach usdt test
> which depend on this behaviour, will check

usdt/optimized_attach will fail without this change,
I'll make note to update it later when we have the hash

jirka
