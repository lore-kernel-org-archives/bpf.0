Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FB409E0A
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413091; cv=none; b=QuWEx4DY1NaS9SjHaWru8FL7miagWTomzoNRvEACLoj9NGS2XcVNsYMTtNWEhwKhXSVch0vGbVvmCCp3pM6G+U0WjUZynY3hbvsd1PsaEVbLVDt62G4JSVNwuoTN4jQo8gpnSw2puhq5bcPOPjBvPeoWDX8LlBKDjjoeiiwvCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413091; c=relaxed/simple;
	bh=F6+HuJcjqQetXfHVxkrCfjsK8kE/b6rl5gEXfz7oP0k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHHcD0eNAZ+sFnfVF6tdXzHnXi4OJ/cLXVI6//vevbzhoYxM9oOdUrfyXBpIeHm2vQRiB3jqvpTTzYRVwvGE8faqebzwv3xvh3/uC3eSMiQ5TCAVaV/WS9mBROhlOWIbsl6YcAPXcduLcrSFItCTMuVXXtAPaxJ35OyySyeCaeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiAC6VdB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiAC6VdB"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15d47266baso252409466b.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785413086; x=1786017886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bv2TPjJrAexeMwtadngu3CR04WKboYWuZzb8dKFULGM=;
        b=YiAC6VdBsC+rg1wy1knPGH4s0wTBpTAtOwCAGN5yOziaXtM51G87idnag64EvdscBU
         iQ+8DmjjBrMQR0rB8hNRptT9TJ54t8PKA1gJabsWTQcxlEUdC7sMWC1XoG5DV8pIeMFH
         l62mGrN5viz/Uf7CD733FSicEVk85EJOigozp5I6sipXp/5hZ9vNavh3tk3Nbwwz/PvQ
         9R1gNBfmyJfRiwCrZFIX/B0fiEIMTJW3M3lU5aLG4DORYpfXyx05gHtv23tjqfSYlceZ
         Hn6yvK7LH0Iar0iM3ZTLUzkFhVYfRawTePc8Iaev/+Fucouz7LFSfFOlXFGIE/57XgPS
         Oj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413086; x=1786017886;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bv2TPjJrAexeMwtadngu3CR04WKboYWuZzb8dKFULGM=;
        b=oVeTZPwhFjzCX/UJynUPJgwNwDLX4Jjt4JpoCOyqihS3sbTmF7ty0LV7XRIS5TGyXH
         14jx0HiqCNqe1J5jugTh1+U+A7A7MgQ37+BkfpJ2ONoCcQyWaZ5guxiX/U9n1QSGluhe
         8fzYEd1kKzAVZqux8FD8XwuGYFqSwgv6Us7jG2HD57YREDpaa49MqqKyVGay3usJKyAX
         lBsR0+9MAfkljhOWzuGCKTbhldNKHysFAj9nE0SXaw6zznkYfe9Vzq2YIK0j6ZHoTUha
         G9tWacYwnhawDswtD+JoXDm6Oijmx5po0141xumUrqrbjcxYT2Lcb8hfUeU/7JdwAUsZ
         t0ig==
X-Forwarded-Encrypted: i=1; AHgh+RqctDYsmBRZuIq/LcBXoPAKShtIwe82JZbSfZOnARk4ISpK8J8ycUGMzTDYi1w3mNwvEPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHbIxJJcZamqJ7RCRvKJClCiH23OXHPtfwMbk0LnQnaOhN3W6e
	ACGeM1JpWXeEH6ErwB2BzfPgvHOsj6AUOc+VLRN25ChnfDn4FEDshHRs
X-Gm-Gg: AR+sD12JXFpRK++0FyQPvN/7m4R6hCqL2j3n88+f9KV6RbPbWKERmj3dJF1fNbs4pxB
	vKDLrKzsgeFzrzipZGMwGQTsjPEtJ3e79FGFg+zxeBrzQB6fF7ndbrft+AfPguUlL9gaia7D/xI
	RMdmE4efx75oTdhdq857iYIRM9pKpjX54/+Y5KkV0Lz7FyOqMaFZQgKNxN19OhnmAJeWF0iQnmJ
	KK1ssOLzjeGcAsf0pocERha/GFNxQwvD2XcIgt6/4gzG7GRXVh95e4Y5Wy598ttOI5zjCYvuJqx
	hSQWR69OPIdtcoGQlk2RPvU9/Tq8rxdJq2QAa00t/lwMOkFw/24ZmVFtl8RkrZHxyfOjB6KACUm
	Qu/Q+oexgOXB2UzSOf5LnCMzMazduFnb8lZdWtY07m7Sa9JHfincRlbV0LFHcrNAIlRuJKJPEbe
	RTdJVCKaETAf9MAMNlIHdBEPOISOthA7aRU+qDE2UQ7AZKestNS7z7tasefeY=
X-Received: by 2002:a17:907:9729:b0:c16:5dbd:8210 with SMTP id a640c23a62f3a-c1fa57a918fmr121790966b.44.1785413086268;
        Thu, 30 Jul 2026 05:04:46 -0700 (PDT)
Received: from krava ([173.38.220.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa857c8ecsm59796366b.26.2026.07.30.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:04:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Jul 2026 14:04:43 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	sashiko-bot@kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	qmo@kernel.org, chen.dylane@linux.dev, info@starlabs.sg,
	contact@arnaud-lcm.com, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 11/11] bpf: Clear buf on error in
 __bpf_get_task_stack
Message-ID: <ams92_qe6vejXuto@krava>
References: <20260729083807.1588544-12-jolsa@kernel.org>
 <01ae154752b68a1ae0f49bc501ec05371ac1886ec53e753afaf5ef5af9274fac@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ae154752b68a1ae0f49bc501ec05371ac1886ec53e753afaf5ef5af9274fac@mail.kernel.org>

On Wed, Jul 29, 2026 at 09:57:58AM +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: Clear buf on error in __bpf_get_task_stack
> >
> > Both bpf_get_task_stack and bpf_get_task_stack helpers that use
> > __bpf_get_task_stack have buf defined as ARG_PTR_TO_UNINIT_MEM
> > argument, and we should initialize the buf on every return path.
> 
> [ ... ]
> 
> The first sentence names the same helper twice, "Both bpf_get_task_stack
> and bpf_get_task_stack helpers".
> 
> There are two callers of __bpf_get_task_stack() in kernel/bpf/stackmap.c:
> 
>     BPF_CALL_4(bpf_get_task_stack, ...)            /* may_fault = false */
>     BPF_CALL_4(bpf_get_task_stack_sleepable, ...)  /* may_fault = true */
> 
> Should the second name be bpf_get_task_stack_sleepable?
> 
> Both of those helpers do declare .arg2_type = ARG_PTR_TO_UNINIT_MEM, so
> the rest of the sentence looks right, it just reads as "both x and x" at
> the moment.

yep, will fix

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30437558115

