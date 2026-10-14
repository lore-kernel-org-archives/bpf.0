Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1F4349A2
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968903; cv=none; b=SZ7IJegvMN0CSHMZFuR21Tt9JF2wSRwvFOTLh1ZZA8CUrANLmeVdrXxCro9ZJEa0HyUDn2XVpbP5nnceO6p834ZRabwFY1xEqlA4VOO/1MTRvjze5jARGnVt8bftdN9QO1escx+i8goxtbRPBuSfkdXJ2T7kPG/BP1qbs7YGnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968903; c=relaxed/simple;
	bh=t3WPcOBQXBUjthn81UKd7oXqWoABg309HZeVAhQJHA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjljoq5S76wd/f2GXI0S4dI5DPdlELkzeXaFjB9p0TtRuRNMINMnl/U2UXjfTbYhLbNcQanbrxHJRavR5KI0km8CBnWzoWH0Yg4W9xDmkugHRevoe9V219JU0bsaBCUtampEzpbPVRhnCN4eKA0v3PEyYjvZZzMjbLT5R+NU8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTc6ibn5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTc6ibn5"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48deeadb3fdso210852f8f.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791968900; x=1792573700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EKVSeE4bjA6cQl42EhHNb5mQnnjAquRALU0RVbJrsQM=;
        b=XTc6ibn5qUvTZnlDx3v+86tWKoT5IWQDEgrUim8pSFNcrgCVxz5sRES10e3kUVLtJF
         ddI2PFntBrzOgwoM8JG/1oQR3PeKNAmeyUT63fiEwcl8ZApgr/ZPRixGu6nKfPALLdrb
         NeIZH3GoBwHUc0iV6v0ADrIAZT4fEAJHAJOuuKS6Gm4tUIzmVpLsPdyrnLHOQ52gRKWc
         xlLb2wnZHkPKainyRtkBuWDrlnjRgziLoDGC/u/voxjyf0ajiMMyw3UNM6yZ2r6EacEB
         WbHkgvVQXcyEdZBPvo7mfdLS0gvrBgjsX96OYgzLdiNB4pTyVgY+mMwIrAWb0KWnlR16
         i39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791968900; x=1792573700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EKVSeE4bjA6cQl42EhHNb5mQnnjAquRALU0RVbJrsQM=;
        b=Kr+ZAwCW6LecrmCpDPYtgcKrlQHvdKCLJQqlhYRh1UYU1cGduWxNcJthdQnAOia2vG
         sp9Kwa3mLYmCrP6O2e39SHjAwtZQC3e5J5NOiDevHTuk8BirxEilyMkSJ7q98pvk+jSL
         xKyvRXaAHpTw8A9UvMQLpDLJnNCghQ4dSfoB01L5CuJJFVsRSiraU47AT0ckCG6zvQx6
         ofXsgtBrJsmngJPhCOfekglzff9xduJRpua6eZXmBxEqPe7+s/qIduK+AD6mVYYpWb3G
         63iuc8WuALhevdUTf5WUth+N3WX9IqyBAHjUa3F/ZeuE1L3b6NQGiwJXk99B2JZP7iZs
         gysQ==
X-Gm-Message-State: AFq9FYLtK6PZU74zAg0gR6liQJWi6GK9G6TuCeyk1KnLIx7xSl9RSRz2
	c5+BxDqj/PF9ixQzAOXkFKYYbJMV1V3J4hHVZ9Za11ZJ1boz/7p1RsJkOErZ/d5KBsY=
X-Gm-Gg: AYBFou1a2jNsldnYbE02leeAY0N8yhlSpsUKU45bHi3GkirfcM2zBYqrgzFHXczky7Z
	sZ46DLozj3EswGx2cF2aM9oloJPWJsTh3ZfoQNu3RYHYju0ODj32EbRx+WBOZCwiBWp6Lw5PWDe
	50MwyOh9mBPPwORJHqWNPe2s0yxf/Wb7258o9wIICkovIw+lkJJcVJMK4LT2GB4yMfq98QB8QGg
	aoFCAgobCpdery671hGOqu2wlFqgsHJPwXwVjBTNBpLqJLOuWQ6AP7FauBr5ZUBLy/WZFvZmfud
	kYUjAqVt2iPRKbPgnSsYlbPrKbSquNnAA2p2gyQQn3hP+d5TJtR7ubpC7lAVhVufTJqoeyCiIuf
	gmr2L0htyClAR6hjcgNNPtq+GcNrx7e2wmVKJJHwLQGF0zPfLK8vALKU9x+qWNZ5WFdED8LsH1V
	91Sf6WeKTPt3Gs7UfERs+WC86dGvxrsIzC/0VITiiRm5inR+3IJX7W2T32CHZjNYB/oc5UYUaPZ
	omB6fMzpsdVYTRBJ9Tg0pZbQ29bJfxwL9ui
X-Received: by 2002:a05:6000:41c5:b0:48c:4274:20d7 with SMTP id ffacd0b85a97d-48db9466102mr30472816f8f.6.1791968899468;
        Wed, 14 Oct 2026 02:08:19 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de77606fbsm4343080f8f.53.2026.10.14.02.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:08:19 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:08:17 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: allow ksock connect/send calls from wq
Message-ID: <as9GgXQ_K5UrW9g7@gmail.com>
References: <20261013182726.276372-1-mahe.tardy@gmail.com>
 <sashiko-outbox-170341@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-170341@kernel.org>

On Tue, Oct 13, 2026 at 06:35:59PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests/bpf: u64 map key causes workqueue double-init on big-endian
> --
> 
> commit 5eb6c40a460d2cca2d0dee2b208a0164f311d369
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> bpf: allow ksock connect/send calls from wq
> 
> This commit relaxes the constraint preventing the use of ksock kfuncs from
> asynchronous workqueues. It also updates the ksock_wq selftest to verify
> that connect() and send() function properly when called from workqueues.
> 
> > diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
> > index 16a1873d132ed..290736e219e1d 100644
> > --- a/tools/testing/selftests/bpf/progs/ksock_wq.c
> > +++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
> [ ... ]
> > @@ -43,20 +73,40 @@ static int ksock_wq_callback(void *map, int *key, void *value)
> >  SEC("syscall")
> >  int ksock_wq_start(void *ctx)
> >  {
> > +	struct bpf_ksock_create_opts opts = {
> > +		.family = AF_INET,
> > +		.type = SOCK_DGRAM,
> > +		.protocol = IPPROTO_UDP,
> > +	};
> >  	struct ksock_wq_value *value;
> > -	u32 key = 0;
> > -	int err;
> > +	struct bpf_ksock *ks;
> > +	u64 key = 0;
> > +	int err = 0;
> >  
> > -	value = bpf_map_lookup_elem(&work_map, &key);
> > -	if (!value)
> > -		return -ENOENT;
> > -	err = bpf_wq_init(&value->work, &work_map, 0);
> > -	if (err)
> > +	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
> > +	if (!ks)
> >  		return err;
> > -	err = bpf_wq_set_callback(&value->work, ksock_wq_callback, 0);
> > +	err = ksock_ctx_insert(ks);
> >  	if (err)
> >  		return err;
> > -	return bpf_wq_start(&value->work, 0);
> > +	for (key = 0; key < 2; key++) {
> > +		value = bpf_map_lookup_elem(&work_map, &key);
> 
> [Severity: Medium]
> Can this cause a workqueue double-init on big-endian architectures?
> 
> The work_map map is defined with a u32 key, but the key variable here was
> changed to u64. On big-endian systems, passing &key to bpf_map_lookup_elem()
> will read the most significant 32 bits, which will evaluate to 0 for both
> key = 0 and key = 1.
> 
> Because of this, the loop would fetch the map element for index 0 twice.
> During the second iteration, bpf_wq_init() would be called on value->work
> while it may already be actively queued from the first iteration. Does
> re-initializing an active work_struct without serialization run the risk
> of corrupting the global workqueue list and crashing?

Yeah key should have been a u32 but when doing so the verifier loose
track of its value because it's only taking 4 bytes on the stack and
then it detects an infinite loop for my two iterations, I'll do:

	u32 key __attribute__((aligned(8))) = 0;

So that the verifier can properly track the value in the for loop.

> 
> > +		if (!value)
> > +			return -ENOENT;
> > +		err = bpf_wq_init(&value->work, &work_map, 0);
> > +		if (err)
> > +			return err;
> > +		if (key)
> > +			err = bpf_wq_set_callback(&value->work, ksock_wq_create, 0);
> > +		else
> > +			err = bpf_wq_set_callback(&value->work, ksock_wq_connect_send, 0);
> > +		if (err)
> > +			return err;
> > +		err = bpf_wq_start(&value->work, 0);
> > +		if (err)
> > +			return err;
> > +	}
> > +	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261013182726.276372-1-mahe.tardy@gmail.com?part=1
