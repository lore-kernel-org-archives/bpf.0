Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3D4AA028
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401629; cv=none; b=CJ0GSEdJSORgW1yrRIsTkYi+s7EI3ky/qtZqL/SD0assibKxvrQqILwM0yGUprJC0DcybR20xLfAX5VU0TLVIwzwXVwDhSXrCZ7XBbPClxy6nmEj3APS182vlnq31C4+t4duueXTPf0/dAc+ouQsK3HvGBUJgVy9+G3kL8hGIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401629; c=relaxed/simple;
	bh=23uLVGVu4LenPJTiUbtiHkyS7W5/ZO7Ic3YJWLzrJ8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FtPylIdCekc0M2cXDTS7S7MFxEwrirBTL4JEc6wAwY/jXworKjuzaD67SqdsBST+yHobmdgG+cHXUafgm4VwGSfEsjBPlBn5YvjmAlHMfzRZ1wvW57Wj2CrkZ6vRbunOwEYLFrOxeBiUXa61yuTVNXWuFzJwIGOcMP7nwpeWjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N7B4PspO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N7B4PspO"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so2187316a12.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792401626; x=1793006426; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rCnbEw2lvBYbntrA6KDS3EO6vufdqSnBrzMmqli8drs=;
        b=N7B4PspOq9/uakZFaemK5D2GJIoFlyDJz0JsUXxdX31t+m2Dauj4XpS2EkeuQKOdQK
         wh7Nw7ttBy4ELbOtSYNv8tnTYh6+p8NQEB5WFUDhN+wgg8VqjjLwl5bqhs3xCbmGIXKx
         i5QjNH6U6AnZPuLL0e/Y7IC5j52uMt7wcpWCB9Cn5qTDwwoTYn8+DMeTwvi/gKrm1Qby
         RxDIrBARe3ujeUbAo6+zhot+jzY4erZQvdN7Fq3/DJQB9OVOdot7wM9Wyq2W/n3jETal
         u60AD7/aJeGZi9MJ6nJC8JFXUDR+X2dZnTavmhaaE3doRuAzwmg0F5ZgFW3A8pUd4/ye
         r6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401626; x=1793006426;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rCnbEw2lvBYbntrA6KDS3EO6vufdqSnBrzMmqli8drs=;
        b=CIgyFQYuVb0ZXdy2gmrLPm3DEWtYzP0lzm4FFHIcnwkQ5dlq4RRLSPLxlLxcIDFPkc
         0D4E9EgfO6x8GVCvOcGhbc8yK2VvyLC/BBTqLTZJsQUhE3HV3m8TDscGcQZ+RvT+BhF9
         sc33gRyHmyTP/5jUySGwtlJ/KzXQDBAodnRZo1M8RPtQqGEO2DvDaSHC2uJ2FnexiypQ
         1f3QAv0ziV2zYH9JBYMgj40JcEOkJGTC9ymG7hzMmd+3R/DERhPTy3SfeouhawcIqX4d
         zQkYDoQGOSv5ihswSO+7VA+tDveL/5/49Bjbifrk+PudQe4I4YuiFCTHgYv4ni9R6rQh
         aBjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwF0lr2TZ683JoIZQMXHgPIvRRoxdyFT2iYi8l2keN4Z5s4EL5uwPAQ262myznP0brRz/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/dgzEJu5mGh07NqT9hODq+cglwE8IXz2GxJ7/6WMX1VqHJOWf
	Ap/80SVqZ0SyKV8/B2fsOGHmphCnikQlxgIY7eoXhEMGqaQUB8oY2fv2iD4Hbx4bmgc=
X-Gm-Gg: AYBFou0JUaT2JN4r3BTdecUOKQYZxDQqQhe3UbuQv2qFYTRbQpFw3MkRBAygHd6Q0Jb
	96+ynIh+Rroh5BxXaO4Zxiv6g+EwW+A/sGKfq/SK8KlMVBlw3dMnSYVRY0cQdU/Z5XVTuRL/h4z
	u9Rmz9nFrkafRPg3vbhJWZEm+OoOtwWeEwA5OrvFRfWABOykZt76fWsTkDvHKS3/xceaTrQujin
	Sz2VcEleZEi7/Tn819cbp/KAUOZjQXKfhppelkb4NWm/BmhmVXxlQdur+hQ5f6/WJ+axGgmjc1W
	f5mzlSOZEKyJIpalkmCqROw02OAXkcfjwEhwPsgDb998DIliQB7RN6gw6R8G5a0pH3eEI2ESbBN
	Sy8U/EtDGOP+p8lGMmXDkslWjp7X9wyBv5Ox7BEunGgzfZuUreXKNvTanDIlaj8IVkgG9AgjrOv
	2FAHwLldxOqoZGf3k678k6xxdVq34bmMqFEgS882KOOcOiMquPxirNwwqWIyhF
X-Received: by 2002:a17:906:ba89:b0:c31:c767:ae0b with SMTP id a640c23a62f3a-c4196dac03amr433604866b.0.1792401625664;
        Mon, 19 Oct 2026 02:20:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm342196266b.61.2026.10.19.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:20:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Willem Ferguson <wferguson@cloudflare.com>,  netdev@vger.kernel.org,
  davem@davemloft.net,  edumazet@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  ncardwell@google.com,  bpf@vger.kernel.org,
  ast@kernel.org,  daniel@iogearbox.net,  andrii@kernel.org,
  eddyz87@gmail.com,  memxor@gmail.com,  linux-doc@vger.kernel.org,
  corbet@lwn.net,  linux-kselftest@vger.kernel.org,  shuah@kernel.org,
  linux-kernel@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next 0/4] tcp: carry a BPF-chosen identifier in
 TSval low bits
In-Reply-To: <atFI9vl5hy09Dc0t@devvm7509.cco0.facebook.com> (Stanislav
	Fomichev's message of "Thu, 15 Oct 2026 14:45:02 -0700")
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
	<atFI9vl5hy09Dc0t@devvm7509.cco0.facebook.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 19 Oct 2026 11:20:24 +0200
Message-ID: <87a4oaf3mv.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hey Stan,

On Thu, Oct 15, 2026 at 02:45 PM -07, Stanislav Fomichev wrote:
> On 10/13, Willem Ferguson wrote:

[...]

>> Questions for reviewers:
>> 
>>  1. Is encoding an identifier in the low bits of TSval acceptable in
>>     principle, given the trade-offs above?
>>  2. If so, what feedback do you have on the implementation?
>
> Don't see any feedback yet, so from the top of my head: looks like you
> control two sides of the communication, so why not a custom (bpf) tcp option?
> Would you need that on every packet and it makes it expensive?
>
> Or any other field you can abuse maybe? IPv6 Flow label?

Nah, we don't control the client unfortunately.

Client here is any device that connects to our edge PoP.

> Implementation-wise, the sock_ops is going away in favor of bpf_tcp_ops,
> so BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG is a no go.

Yeah, we have just recently realized [1].

Thanks for feedback.

[1] https://lore.kernel.org/all/877bjk893u.fsf@cloudflare.com/


