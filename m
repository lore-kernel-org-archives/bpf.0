Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41010364E85
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499361; cv=none; b=RkUgZDTIvr+8mrbSD0x/1C7BL2SAvTdA2V492YVS19GzLDLv0jz26+WXGGrYlzd84KQzJ5NhEHcpsBs324vkNfgfxi41ed6DzwfqNJhTpefy+IL6I/++xNAWgjEIxoItGBO1KMOiwyENAV0+InldkWGFEW5vXo9zRc60aqBCK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499361; c=relaxed/simple;
	bh=AGk4y8oFpNibhByHKIxcRS7KnQx6z20Q8VC6dFl1tNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmP1eBlN/7j1VmuSmvqABZvChyojEGH8byH87pGEMgpVGwf7GI1BZMzvBm5pp/Y3unCd/pR31b9jlbJTjv9AygR2Rf+P72513trIlzXGcco60N3xz2LiVB74oZo4hgaFWvLrfaoMV7ZL35zxm/tGGmxZ9On+SmlAZonlrPh7ITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CSrtt9Un; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CSrtt9Un"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663bfso33750166b.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499357; x=1790104157; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=CSrtt9Unpbm2RA3J8D1Piu8PqBvT7/aa/KZ5CE3c3D++Q65F+8LC8PQhJ+YAQkLRZF
         FOCbEfcedihMauvO8i4QEZYDfsgCMc/AU6Y/5BuRF/k4i643ZbHqsUyNas20hZQzkd2E
         0RZUaMtkje/C5faG2xlXImdyEwn4T014v7tJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499357; x=1790104157;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=N7HQx8xuyaWtDw6TD+ZNMfbhbaaClNTerzLRR3Rmrk+L7RxaJ1/AaRiCWzlk2o2q19
         V7vqEUfq5NdjJDO/ZB7D0WsYQXBow1Kf+QdLjzXBPWZ4ZyZTIdeuxbJ4PlpbukXg4Tbl
         XfVNlyZbRSsSac6RMEQ3SBbHutIvXCG0Yz1dQzGsQjGs7wo9fw9D5xSaRBqXPUjuMXK/
         ZTB/ymx6S4qzCUXGUhSBgOcNXHPzR+acDYXCnZ1zklM54kqXcqFeq91yrsAXd6yNLwaI
         +Z+Dw1/1KlNmH8xOT0PoMaZ+4WgF+nLSFIyY7AJ/BwNgDRMxxhdHgFcCz5ZW035SNFF9
         ckSQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7kSrlFPaFAbBblFwT+sjdC3Ujuyj26ZVoS/1WeF7L682KOMHsqHlAwGpymA7i6jU+oEw=@vger.kernel.org
X-Gm-Message-State: AFuF++kxS7p1+KcMZrHXxhomlLrirF+1df2idlEzNUswiF6dmJshdjV7
	PUKF8wM/0s8brJJwA9YPP3pu+b23Ij1hHllASIvm+Yn9Vjk37+7n28o6JONiTuuCEInzwa7znII
	u01tkBmA=
X-Gm-Gg: AYBFou2pfD3lGi84d8fZ26Ok96eumTGO9mxKxcN5qCHt23CM1s6Wa884nTup+/pzi7e
	XyyhMInjT4NlF96s7JB345Jij+WlpSlY6i8VgXc/MZ4Rs5WQbbGx9cX17I2LdkFf7cSc8R/gt0G
	IHZTiL23ztXkPGKg2IA0LOL6fby5fbDgqUR5oBVAKOWFx8TJvEIf/L4zRujwvNrg7R57OOQyumB
	CshrXdNjInbojSZHPQuQVHK13ZSu92AThD1Ui5P2kf99SMxuc6z94gKxaX1sEGyx80jQIVE9gv7
	/4DRE+kLNRryPjqi6HVNaY3znB991m8ltNjP/qdesbuJUfqSCVNGtgq3n9pB6fy2fw+BYQFgXUV
	KvL5NBN6N1owoW6p5/q0P3LQQ/XB0eqfnGwolelRxmLT91685W2/T40v6sLyRan2Lcr0mkzd/0r
	1Q2kIUr7qP9w45rUdCB9izlX6bZ6hoR+A6KpMq+QUruTXS6ZmbLq7M4Yz5a0G3z7T5AMj4jx8MA
	biKxc2xbOUULsvxUVxSJbQlohJFUCZtHUj1bx51S60R64pCRQ==
X-Received: by 2002:a17:906:4fcb:b0:c26:22ae:b66b with SMTP id a640c23a62f3a-c29b86b7565mr980711366b.15.1789499357330;
        Tue, 15 Sep 2026 12:09:17 -0700 (PDT)
Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com. [74.125.228.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de487970sm16621466b.29.2026.09.15.12.09.15
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:09:16 -0700 (PDT)
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c254fa663bfso33743666b.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:09:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzlunxOdCtRWK/uYrhtTDULcVVfx4n8HAIBPU7QsLPcCM+y9KeJj9qrattsuodLEhKeZhc=@vger.kernel.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus
