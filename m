Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983386329
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774131571; cv=none; b=Yrp5EW/FFauHWejfBZ9GSrCrVhy9++HOpGZ/qDL+ZXzuOhoTS+RfAu3ZNF0+pEwyOkOxZO6ISJaJd0u8TRdeIoK/Ldt5G60UYgAkSGCqWCw21UZ5FKyO+WXhkN6vfX8IfX++VBVQa7tCDns/zevHrnc5QtbmY8ETgwIABiJbRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774131571; c=relaxed/simple;
	bh=untriQDrI9JrqqAryq328gYRFIcFVTEGJLTS8OVKAsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES8+NWOj2ZzeAJg1HnQYUS43IBCc/oyB2SrskIbY6n/tfzN77UucccBNQ/rHP2Y8VQhxSFBsCVgfGgpc5tJHeNTbJLo+BeMs2AMqXLRxfP8Bxvy1XRGempEhvlYi0pesuiqJZwuMOv6BxyNYCQK4O0uTIoWXJPaxXgg3GppVy0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZJ92URr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZJ92URr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aaed195901so11889175ad.0
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774131569; x=1774736369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UH7xGCZswuKf4dKmiZyNPuYLDLgcZOJqX/W8j0hzLfk=;
        b=IZJ92URrpU0S1UQulvYiS9QTSWsVBbAxsKmZ18B7pWbRwoR6aqGsZDPIVYts38QUPk
         Zw8MgVg4XvbX0dhgu/xqn1DaqEA7zQ3j66A9jby57p8ssrgDSEGvyrJIf+C9kkQdFVjR
         3pTmOwE43mQMZJVzlsK7jFOlbHFhpq2VLye8/jiP4eHCLmPMNbm9hP1b8/MpR8rBD2iV
         nxjGL9+cNduV8ynqc4e5hCQVDpzpsG6abAUt+QXz3UefQv+gPBuzVKgqZG0DvK2MnNPn
         3YF6y1UZreIfO5x1ht/4k1IlqZU30OwishFHyGXaL0MIrhmxM+EoYbUtux01ayJQFWJP
         84jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774131569; x=1774736369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UH7xGCZswuKf4dKmiZyNPuYLDLgcZOJqX/W8j0hzLfk=;
        b=UV6UGeGztXHGOm5Lq9g5xLeLTTIstufe424WT5/yguc943R5/mAlDhdywBYoG3gIon
         iPS8TQWdx5yePEXo744WXOf5YwQ/5nGvHu7YRnz+qduxsLf1ipXVGXaPmjlhPOrLe9pT
         S+NeN2iFzZJS5u0/0jhCLc4oEvEnJyPmZr2nVQwMinq+BU7qd0tTN/e98F7A6fC29TTs
         iPNmguD444JW9sdEfUKDN4ttz6OylxEVGkKGH2PjfpHmYVJCORFsoxDpluSuIwQ9/G5Z
         O8Xz3I7Metki3mkk/PczA336mdz1VpTdezDWqRHbGKSSkWZfCMSnTXEjeEFSOSZBfdNO
         x76w==
X-Forwarded-Encrypted: i=1; AJvYcCWaINEiaCBxsK02DcAncaD3FhaaLLTkEu0/YjESuf9oYuRCTiKNs1OEERsfHOhlLuTnJCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwldhXIqkfocLb4QyB5ek0nWMsG3eWcdbZmc9qkXmOjBQTZ3RM
	5jkiLrbigSFqh1ZtZDq4SxHpLz8QFwPc27h9gnN+5eu9iR5OND9MPwDu
X-Gm-Gg: ATEYQzyHnBQSL+FDudZCNn1PdD5jbu+eTVhvkAk6IwoCoMY/2FmWq+vSaNEXZ/qlrQF
	3bw44PX5zS2J3x+Fj/pe5UdLZdGfLQYRp/2IyfkHkrv+aKfzgoN4uXlIqstO9ZhGC3l1iihrYlo
	+5MegO0OBSm0V57NOfXDV0tKZ0Dp77ORA0DB08I6THZbRCXDrh8gEw7E2SGx41oEgsP/xEadhu3
	kl5Q+7ogoGISJltG3XW5LXTHFc2xIsUj7Vht/mbqBCbHzrQFIBL6hz50I6AVanlMv6c4ukBTbTw
	OBMd5GrydhTQQvEPHA2eccTtT1dmoi97Ka9FRs2qvOjjHu338fawbbbKCdMmdsBoqGtfvuqN3kR
	dF7qi2wvssKXBggkkWbbl63qSJAKEjAsibUy/TyQndIdSbH+7uWCz1zWntrYNWymtDmvOWENtNC
	nCqYr7LEP+HtSbwcFCCgaCp4oLVG7WanWuabEqpoiVdw==
X-Received: by 2002:a17:902:f64a:b0:2b0:9292:60c6 with SMTP id d9443c01a7336-2b09292655amr11579955ad.52.1774131568745;
        Sat, 21 Mar 2026 15:19:28 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:277d::3ef:49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352ae70sm64241385ad.23.2026.03.21.15.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 15:19:28 -0700 (PDT)
Date: Sun, 22 Mar 2026 03:49:17 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: keisuke.nishimura@inria.fr, ameryhung@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org,
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test for struct_ops __ref
 argument in any position
Message-ID: <ab8ZZRd-u1_GXy0B@computer>
References: <20260321214038.80479-1-varunrmallya@gmail.com>
 <923f781f67dc846a8e61ed40f4ce45fc3ae71ba0db3ca3074a02153f33f5c887@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923f781f67dc846a8e61ed40f4ce45fc3ae71ba0db3ca3074a02153f33f5c887@mail.kernel.org>

On Sat, Mar 21, 2026 at 10:13:45PM +0000, bot+bpf-ci@kernel.org wrote:
> 
> Will this test pass without Keisuke's fix [0] being applied first?

No, it needs to be applied first. 

> The stub function has task__nullable as the second argument and
> task__ref as the third.  prepare_arg_info() populates the arg_info
> array in order, so info[0] corresponds to the __nullable arg
> (refcounted = false) and info[1] to the __ref arg (refcounted = true).
> 
> In check_struct_ops_btf_id(), the loop that sets has_refcounted_arg
> currently reads:
> 
>     for (i = 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
>         if (st_ops_desc->arg_info[member_idx].info->refcounted) {
> This always checks info[0].refcounted (the __nullable entry, which is
> false), never info[i].refcounted.  The __ref argument at info[1] is
> never examined, so has_refcounted_arg stays false and the tail call
> is permitted.
> 
> Since the test expects __failure, but the program loads successfully
> without the fix, the test will always fail when run on a tree that
> does not include the companion verifier fix.
> 
> This patch may need to be folded into (or applied after) Keisuke's
> fix so the two land together.

Yes, that is the intention.

> > +	/* ctx[2] is used because the refcounted variable is the third argument */
> > +	struct task_struct *refcounted_task = (struct task_struct *)ctx[2];
> > +
> > +	bpf_task_release(refcounted_task);
> > +	bpf_tail_call(ctx, &prog_array, 0);
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23389590355

