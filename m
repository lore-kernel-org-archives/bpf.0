Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05D3C1F3A
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579497; cv=none; b=b3FRxLrI/+J6Lh0UCDOF09bS+rrvgVF6pyStYemf0hKWbJ90hNWKNNidBtfuU3B93a35TbozHr4eyRbRnahofFW5A0vXkPdRUY5SVzBhTfFl15KQErVIu5lf/7m1W9I8wLJcc81M+ZyYwz27FrAPqerxfHppaofpCbh27RUslE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579497; c=relaxed/simple;
	bh=OEVRspgpZFEFYjbibDV/9ytiChyzOpbNEbnCQl9h1/8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svQZaHN8Up40MrZ2HkWCgWFnwCMXdliU8ucW7lIMOPj/guX8fFuvuGbjms/3TqoOWasJNd7vkTAKA/Y5UP+HBtvNETk8JKgGoDRDEEdYo68QwHkunjFgwIPF+j8M9DA/08G6QPje1SUffIMfcYM6zh+376Df6/jGwRiwbN4U4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEeLeNa6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEeLeNa6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49547fc63a0so16678685e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579494; x=1785184294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JNXrl8uAnSaabKLk4mLhy/7LlQjg64laH35dy7W7Yjg=;
        b=NEeLeNa6ll6TP9GclRV/vn6Y169Y1ZePs4u1Wm3Im8AvEtPD+WR+mnlfBIwooHYBWI
         0V/3KkFJqhckLKkmN2l4Akh0WQfmYqx1CwecZ47uqzapFnLDilT96jSaUrgCiTAy8NnQ
         bgz2OMS8ohIcm+8pjNgQiQmeigOdTbXrMSGWaIxTLKugrxF9gHIOF7F7da6223Do0QeD
         iEoPDDMZ03aBrqDxMQ8YfmafzmOvazXYUPevsKZJ36/+fVrHS3S+iCmz2xHJzLaWqvjW
         4rNcj163wyLchRTVhpuYv90Stmia4LSTH93h8wGd2wpoz8auEVhGviDDYWLF249mY98M
         rDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579494; x=1785184294;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNXrl8uAnSaabKLk4mLhy/7LlQjg64laH35dy7W7Yjg=;
        b=D9MdrMQ3xPlPHV3Mo0sVfnBFge+WRbzPuabVczmSmB5XFyN1CMGi3lSxY80w6LUuZN
         qN55BKyZ4LzrHg3km6quJd41cXaxmQznWy0IIp0w591vgY2tEm5V8M+fGlOiX87jnIdv
         aS7LNfa1IXoxNcODSjDaJdmiMx1CIF1+J6k8VhhKV4iZleHr7ctr6qCkmfCSrTKX73UN
         yLDfw4Z0Ash0xxGl/+8/sh4OR86vWgQNf7SGez+tKjPs92tNLgjGGfv4JKhu9TnMC9f8
         RYFRPsm1lRhMeVM+LCsQBpQ0R3wHNjNqd4Ww7zDnJQqjjngXD4XclS+vJyH91RbLhvq8
         8x6g==
X-Gm-Message-State: AOJu0YzdLnLishyEJb0P2auJ82IwDcqgZqsM+xAWP6MpwuFtKLtu8bch
	y0GZebYOTswPCqO1U2YKEqPe+vNIw2ELch9uVq4CFm++eLB1p76WOWELt/0zHhCG
X-Gm-Gg: AfdE7ck7l6XVghk2f7rpclH7mmySy3dxt04bybOWgkSCJPAT0jTzLTAGZI9FgI+Focr
	qIta3eF0rjAfvoxXT+/I48XlUAziorENrd61jzBWAdqBDjhJfdOvMQ6G23Ce6pqURmYdZiRt8he
	CIp4ecF4ABwzEV1yWyuBdBZ8DsiyFBIsN6uJQPzA86N/DhiNR/glmW1mVf/VhyU7DYghIsPEc9I
	7G5O9oxs3ulP83aI+cnRBpFXk+57RaCKdXlRU2omHDGfhE3uuMnbIVFPKVWBKi7ZQ4O3kC7hQ7A
	H9sMuAR2+mleB+TYrR6LSAESv1/QneimOn1odWbMV2uyOU/ApoPir7GKtfFMsZzHZoGy5xaUZjK
	KEAX2ekhqRBQllg+je1fyrmpHH/cqNt0KJYWg2SL5Gdbdrg6Hi4BKXLBTY4g068DIlA==
X-Received: by 2002:a05:600c:524c:b0:495:4e12:6ae5 with SMTP id 5b1f17b1804b1-4954e126afamr167377215e9.26.1784579494090;
        Mon, 20 Jul 2026 13:31:34 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f69e5eff1sm23614805f8f.19.2026.07.20.13.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:31:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Jul 2026 22:31:32 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 6/9] bpf: Factor callchain_store function from
 __bpf_get_stack
Message-ID: <al6FpDgLN6VRaHKO@krava>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-7-jolsa@kernel.org>
 <20260720090721.2D26B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720090721.2D26B1F000E9@smtp.kernel.org>

On Mon, Jul 20, 2026 at 09:07:20AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The 'size' parameter in callchain_store() is unused.
> --
> 
> --- Patch [6]: [PATCH bpf-next 6/9] bpf: Factor callchain_store function from __bpf_get_stack ---
> commit aee65ba10526fcf4c6320ea660fc50a555551cc1
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Factor callchain_store function from __bpf_get_stack
> 
> This commit extracts the logic for storing trace entries into a user-supplied
> buffer from __bpf_get_stack() and places it into a new helper function named
> callchain_store().
> 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index a64b14ffd1e8e..b990643f25cd8 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> [ ... ]
> > @@ -747,6 +747,29 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe = {
> >  	.arg3_type	= ARG_ANYTHING,
> >  };
> >  
> > +static u32 callchain_store(struct perf_callchain_entry *trace, void *buf, u32 size,
> > +			   u32 elem_size, u64 flags)
> 
> [Severity: Low]
> This isn't a bug, but the 'size' parameter doesn't appear to be used anywhere
> within callchain_store() in kernel/bpf/stackmap.c. Could it be safely removed
> from the function signature since the bounds checking is handled in the caller?

true, will remove

jirka
