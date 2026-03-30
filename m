Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC77191F98
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884478; cv=pass; b=e8QiW29yqbE58f670wqn+ZwCWAPRb5iSPkvqxtLYa4hLC6axIf7dzmrKxnXkZEtFiNlmQcu/zI+vffUiFKXhho47mwhm/i8oWeImNRtGGrNOOsubCNE3og0cc4s0d3RkeIlFKDYO7usJSQWkY0tGS5ySQNK1wzcp9Kf+N3d+EOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884478; c=relaxed/simple;
	bh=6NUrIWPjL4cX/GifRZh7N3nhRyrA5p7otgPIPFd71lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/+CJgxA2YTQy8zgdNi5ljpHKHuchhOhlliud2BNbRsAQRejABD1DuIfp6vdSRPaxe0suAEAuZ52HdlSNWKTPGxf3mALtbg780+YvWt5bTaVNxnUYPuy9JiNI2tw53/azvf+kVFhm+hdX1f0kvknIoht51a9MS7HRdC6DnFKSk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBl57MC7; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBl57MC7"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b949bf4easo2682642f8f.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 08:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774884475; cv=none;
        d=google.com; s=arc-20240605;
        b=MITLbgpOjODVAxPJ8h2LNZPOjxEtGdqU3CkBgNlPYniGHzm0hQFNBzozuRBc7sXv/c
         JQwQfV31XGHKWobQ34M1YMTRPbZc1dcUuWlOF4bXXD9jwMJ03zABy9LyI7UP7qytxxKk
         v41NNyuPr4HYSvPuTdDc+ox/ehhOwxwzyaYpz00ZWEjdzNSoHCdI16cIGXRLBZj8NKjL
         UUbWLj/FmjzGYXh0r32Urrpz2IfVcorbeSFbnelbetGzwm03yuCUGuGX6Fv9S3Wc8iJe
         vO9P5bdL+Fv4kK6xZK+5n+kKXRcO3Sz65KGscf8r6of2B1XAHSb1MkJJyNJSZ+2xSH4q
         x+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RxqYfAlIR95kFylOp4SXU7JdBxCuCsZJFmKFaCwjZOI=;
        fh=FEa3z0euo0ziQXNlek+YnT82MzV21GQXBAlDv54dzSQ=;
        b=L9GVDI3jVYUvcgmYczAqXo7ICqv/M7v7neQazGItFYK+FPo7Zc8iG3rh28q8eOnO5d
         oitolm/+8zYAciYdKN0WjrE5zXoJLP5KzUiZUKGBZzWQkf6s7OIwN0m7kq+8q1H+n5Lf
         dxlDaOxM1fOcqSWRzzwg43y2EWsN4YOv3fdPsX7nX9IRb7XprAlDbu3L1AzHNTBlBH9F
         8YmpUU8/nZxcy+ZVywa/AVv+TYLPglADxz2vg+vfQKADN1T3JuSxvzv94D+77z5SBsSQ
         EqLeyf9iBRSsZhxspVrvUt6tWSbDfsNCPGmRSbCAM2RCLfwgddCV0XXVio7zKCwkipuT
         EMww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774884475; x=1775489275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RxqYfAlIR95kFylOp4SXU7JdBxCuCsZJFmKFaCwjZOI=;
        b=KBl57MC7tn04rluh9+V+JerBoZeq2IlBUcCiKoQ3L8eifriuJGca/DVQVPG6wnPmBm
         sG0xcCLngVLCr649Bq+7xeeGrXwlWzEsKYIXHEDHWdeBbJLDPrE5400zNg4VQFkx6m3o
         wZZI+ZWPQR2Nl1qOf3cu1N6JRcyI5KWsxCGL71J0gSQQr3Sz0zMMsclac59xAxGzFOOL
         FZyoDtRRLqmzH7WrEKqogV6PIhZbmJUl9mYSKMpS/ZQby9Ngf6vz+iydznShyTsqsK4Y
         lF2WWdZzpXewQpkRjamf9IH2hL8hHsGWdDs4vhrNW8iraFeq2rK3UG+mePm/1/wvdC39
         RXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774884475; x=1775489275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxqYfAlIR95kFylOp4SXU7JdBxCuCsZJFmKFaCwjZOI=;
        b=hv6kAWuR0dhg6DCDJqzBrnIV/Y0JBJK24axiEWgM74i5fVRd4oYI3PEcqRyyZabOZG
         xNt7IYzyb7wMwQlgTtM3pW3By1uAj2hL+7cQh8qR4yq01S06VfdDxgKRAFPkHi8kQpzy
         ZQbB/1TN60EwL5os0r3Mp2kYlvlF1BHA6WzcKPkVS+Fg1pHBiz4OWAEFZHzlPKHg86yE
         QpF/nV99pJPP5+kiViPwIf9UmY3naLIbCtH2E2EVXFTm0j2syqcOA9/RaPwg2Kme+jbX
         HVXADdqAVtG4ZqLMqWHvYhxKpHI38x0zjgtAm8rDoKkwDJJGX/AA+xh7sg3Jm5YobGvp
         f/oQ==
X-Gm-Message-State: AOJu0Yxedd7j9vbu9Hej8vUBI4FErbPzXhyUCuT4baA6hmAXZBLDnrHo
	Ei/t6BbhcT1W0I9jaVeY3JZbhu6I0AgTxoljm9ZpJP/xUN1OMpvOa0wAwYC+NhDM8AkDzm7u98g
	zSmQ5TQaS7oOAhdKn87EZoTr/CWpkuVs=
X-Gm-Gg: ATEYQzyrv+a00EMfSZF32TWKWOxH4bQpsMMBkPmjnKbauk5fmqYbg3QtTCo7O9tIdyV
	z5Eiar4TkmzxFQU4AIUVvdNk8G0cGrUpr0xiRgcyLChT5NFRQDV52yb1kLM9WD2DUCDD/2tex7h
	rPqgDi2ORsAZCOyak4wDljpb+GtKftN34BBA0Im824wCjh1EcWaZJX6GCJVL8wnakYtmXYKNmSn
	vFCTIMTQyQKfEZoj0omWxTec/71ltGtKAlW2RMhS5IvdZfMzlf13J+q/7y78zybUp/8qfTkSCCW
	xk7hkSsHpIRn5pC2Xtx0ussISJtIrEDJeZL7zKW9neen7lvvhYh1HVl9EEX9
X-Received: by 2002:a05:6000:2283:b0:43c:fe0e:5bbf with SMTP id
 ffacd0b85a97d-43cfe0e5e66mr7907044f8f.22.1774884475195; Mon, 30 Mar 2026
 08:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330032124.3141001-1-memxor@gmail.com> <20260330032124.3141001-2-memxor@gmail.com>
 <20260330110711.178e66c5@gandalf.local.home>
In-Reply-To: <20260330110711.178e66c5@gandalf.local.home>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 30 Mar 2026 17:27:18 +0200
X-Gm-Features: AQROBzCRfyPPqZvNvTueDJKW5KAI_3b1KLp1is0WeVcdsfu6jVA_3wxGbtmg6-Y
Message-ID: <CAP01T778hqWy5GKZNzd=fqY3to0Qt+CdfMA664qR5aXUMuVbfw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix grace period wait for tracepoint bpf_link
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Mar 2026 at 17:06, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 30 Mar 2026 05:21:22 +0200
> Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -113,6 +113,10 @@ void for_each_tracepoint_in_module(struct module *mod,
> >   */
> >  #ifdef CONFIG_TRACEPOINTS
> >  extern struct srcu_struct tracepoint_srcu;
> > +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> > +{
> > +     return &tracepoint_srcu;
> > +}
> >  static inline void tracepoint_synchronize_unregister(void)
> >  {
> >       synchronize_rcu_tasks_trace();
> > @@ -123,6 +127,10 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> >       return tp->ext && tp->ext->faultable;
> >  }
> >  #else
> > +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> > +{
> > +     return NULL;
> > +}
>
> I rather not export the internal workings of tracepoints like this. We do
> have a tracepoint_synchronize_unregister().
>
> Either you can add a workqueue that calls this and then frees the
> data. Or possibly we can create some kind of:
>
> void call_tracepoint_synchronize_unregister(struct rcu_head *head, rcu_callback_t func)
>
> helper function.
>
> But let's not make tracepoints being protected by SRCU an exposed API.

This is reasonable, though a slight hiccup is that we don't want both
RCU tasks trace and SRCU grace period waits here, which a generic
unregister API would try to do like tracepoint_synchronize_unregister().

I don't think we can generically chain grace periods on our own at
all. So can we make a non_faultable variant for it, for clarity? The
existing name would be too long though; how about
call_tracepoint_unregister_non_faultable()?

>
> -- Steve
>
