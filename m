Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8F489FD1
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942155; cv=none; b=BADRH5xQUNfIWzTPe/x7Iji1ymNYjaJG3TUHj1OlzagFPemlu79ADDIZMyyU8FVNW8ZyBjJTjy5lENR1b3xJdMOgRqLvBQawrcAra5UfDWcpngdVSGAHPgxGWvNdeNmtczfO9RJtBVDreObiEUA+I4NZ2sM1UXPidpTBMrI8iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942155; c=relaxed/simple;
	bh=pXKyCSM9FZhLXmXKCC5/hagyDn8EQ5lF9xqVMMSFVIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lXMNOq7OWJOXvYBF0Hg21cHpHMUKDsCiN5WcF30EsE4PnZNw4gwi5+i8VjuqJcyW350eksbjFJgV5TWTlVqSe5ERaplKX50JrZwT2Xb9zxkhvpbAOJQ64ibbI7CEJGRFJg7GwWPtIdtmzO2mc4Mx8bSMkY9PCkjZ4sKEI+PVQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDEdslbd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Siwxu5MY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDEdslbd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Siwxu5MY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790942152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pXKyCSM9FZhLXmXKCC5/hagyDn8EQ5lF9xqVMMSFVIc=;
	b=GDEdslbdqLTWxgeYrJx+CpbNg/hQhgxjfD/CdXdnSwPeJLFWTbZmmSe374XH1exFPbYFNG
	ttcrNRLxiBA/xwr6Otso42NtQsfWJhyL0fG62q6Cc9/gs0gbFfkHnjyKQoeG3HU67Q57AJ
	vwOFRxDjF+pVXlZdKjgv8AKcisa6PRU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-jxD_QokQPrSs7gVNKCcdFg-1; Fri, 02 Oct 2026 07:55:51 -0400
X-MC-Unique: jxD_QokQPrSs7gVNKCcdFg-1
X-Mimecast-MFC-AGG-ID: jxD_QokQPrSs7gVNKCcdFg_1790942150
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a0101292baso36409645e9.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790942150; x=1791546950; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pXKyCSM9FZhLXmXKCC5/hagyDn8EQ5lF9xqVMMSFVIc=;
        b=Siwxu5MY7H7hXsJA3PcvpP9FgbuEkazdWt3BfEjNKclADbd6mtI+bn24AvhYrm/Y7k
         dmT70cDSqp5p7siZCJjuQvXOvM7mQSzpXV9PxSnmpbRIkC+6OWUDK7BoxEPD2K9rF26j
         kxfRuViZYUG8jTNYtyFDhWf4yGSqxgFZ+/e+R2+z+M7jKEADwpiDY63HUz9zWfQndByc
         hY/ds3Dg/rv77pjtUbq46vbqVHFlCWHjL6XZLOgUgRSyeL/5PUQwHxObbVBpsH4V4gHY
         TMSN0RTv2jE8/Pbrmh+KxxOk7jhzcVXYQggVPZqy9hdMNEeOunfbi4CWPSNytKBTMCDT
         RTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790942150; x=1791546950;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pXKyCSM9FZhLXmXKCC5/hagyDn8EQ5lF9xqVMMSFVIc=;
        b=JgZ45ve3wVQg46vCu4MX7XFH8JrUR+3YGGYISCYwkKbg/K7nq6P7vizCrQh+r41D9X
         D262e0CbWngO7D3deleqXrBWv1Y4EGgYbuZfnd2WghqdGF8gmXPJMO9ZoHdVHF0P820L
         GlYzByv8drfGgwzqy+CAAndecflOUDfdOR2plvkFVB26nnazi/arJzwXBroxNSOilv2G
         Idh41+VCJRDDpEJQPinxWGMLKyJN/f8hq9y5avKGt9WRntPiK4sE2wy1BdwhqI/TGnsO
         oF5lW8nMo/K20mqHN/9hAb6khVsZ+qSjihGbw2HR7lwmwm5WZU3Gz7l23xejokiF5GZI
         uYiA==
X-Forwarded-Encrypted: i=1; AKwUvByHHQmdI9qsDe4vqGWKxdoQb2E8ooZpzyPdIBHRGo+McdVUD15IIime61FFIZtxhiOCgwc=@vger.kernel.org
X-Gm-Message-State: AFuF++njYr1CuYCRYHmB0vVN7RnU+4p1wFhfC7PPCVGA2Si9EZtD1KDi
	N9/rdyYR1XCc84UQ3HtqrDnnLb/jx4078m4ehyeMFAJXJFkLlfxdEBxEG94iyt/PxViKtV0oW/k
	Rrk0sHiGg+9uwd9DjP/LcLUFzXEBvLHJAnCS3jLoSCdxkc3mH7FwLdg==
X-Gm-Gg: AYBFou2n/d/orPtaXp4JP5Tvm5snq9l+MSC5e7Z0P1AwxlVTp0L7HbOu8aYrC1unXDk
	beecgTJa6VLxfZmKeJY6t6tSe+siGp/ZgQeVHuNEGFxxXz0CeWY5HqCBRRuy8CDSp7uPAAXsHG7
	9cx0rSMsTbkPKWz01m43K5keC/c7Z5ziy+kfNwcdVUxC5RZYQOLVWEfCob7t93lks4neXdV9GJp
	OiTtTWoP62wKEfFmM8Jv/9XivPCCqeyrQD2VKfr4iH7Q7reNwMUvmGEGtbGvpa8Uk5wxVtq5Rw2
	L3BxxmjJvz7lgqwQ5u4r82fHhs699y1R2lvJQBI6dtTcef1iyzd14JgyT2o0+65A9kDCB5FaxuV
	dCbQT9CjY9S7fcLW4wDhijzVFDDs=
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a02757999cmr45042565e9.16.1790942150020;
        Fri, 02 Oct 2026 04:55:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a02757999cmr45042315e9.16.1790942149646;
        Fri, 02 Oct 2026 04:55:49 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff2280csm44473765e9.4.2026.10.02.04.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:55:49 -0700 (PDT)
Message-ID: <56972260b9221128d7aaf5bb60f90611ec9d7235.camel@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Nam Cao	
 <namcao@linutronix.de>, K Prateek Nayak <kprateek.nayak@amd.com>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner	 <tobias.schaffner@siemens.com>, Viktor Malik
 <vmalik@redhat.com>
Date: Fri, 02 Oct 2026 13:55:48 +0200
In-Reply-To: <20261002102939.GB2823843@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-2-gmonaco@redhat.com>
	 <20261001154934.GT88198@noisy.programming.kicks-ass.net>
	 <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>
	 <20261002102939.GB2823843@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-02 at 12:29 +0200, Peter Zijlstra wrote:
> So mostly I flat out out ignore partial series. It means I have to go
> dig around to figure out the whole picture, and anything that requires
> extra effort goes on the 'later' pile, and you know where that lives.

Alright, I guess I'm going to have to fix my to_cmd script.

> Now, as to 3,4; I'm confused. If I search 'enqueue' I see there is a
> tracepoint attach thingy in the .c file, but I don't see the
> corresponding bits in the .dot file. And per my understanding the .c
> thing is an artifact of the .dot file.

Yes but only partially. There isn't always a 1-1 mapping with model events =
and
tracepoints.

Throttle uses handle_sched_enqueue() for one case of dl_defer_arm, represen=
ting
a fair task running not boosted, in the enqueue case, because it was runnin=
g
with another scheduler.
Boost uses handle_sched_dequeue() in a similar fashion to describe fair tas=
ks
that stop running on the fair runqueue (but may continue on another runqueu=
e).

In both cases I'm reusing an event that can be triggered from other tracepo=
ints
too, ideally to keep the model simpler.

Then it uses handle_sched_enqueue() for dl_server_resume[_throttled]. They =
are
both plain enqueues, in fact, so I could rename them to show what they are.

> Also, IMO it would be *much* preferred if the .rst file would not exist.
> Just have the graph-easy and the description as a comment in the .dot
> file. Then you have the whole thing in one *readable* place.

Well, you make a fair point, I like to have it appear in the html docs, but
obviously no one is going to build the docs to review a patch.
I may look into ways to get both birds with a stone.

Thanks,
Gabriele

