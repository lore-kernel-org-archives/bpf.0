Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8678455173
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090783; cv=none; b=doBEf8ma6Li7ajrvb6CLyaorKaimf+prsdN0p67TCGazykMqA/Et72LUC/8c5OJ9AtN4KJ4bW4IR0uvBnWK59uQ8eMhQ9DAW5ZKFZvH56Rn+VtAL303mZX9PY5gYBbVLBCim9SuAJulm2eLexkq3T33WQaBgjlcwSTqmaQKhC20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090783; c=relaxed/simple;
	bh=8lyBm9Wm93qDz42hxXXkdlccFQmsPzGQYDQhxrJxKW8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTfUvHsAW1Mtk78XM4nePAJOfYbRH9Sd9dK7oyKw8HmtJ7mkuiK10DFwsxE9+tpXTB1pkIWvfRXMGfdUqhZ+D75jZOEwvm+bCitgattambv3ich8ii/3/Ca2h8Bh2u0OH18WIAuwy+UVUXoQ5bta91JxYWPCU3TjR9iKZSPK4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4Q6zPW0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4Q6zPW0"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-471eeac43bfso2612066f8f.3
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090780; x=1786695580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qieJb84NY/DGIyJFPREzT33jCTD11yTCdeI153UvP3Y=;
        b=C4Q6zPW0imL8i+4ZlJv8dhtubAV51gfBrV2vd706K2DAbnOsomN0GtqGFA4s/FceEw
         sHlSirW4x+NQfKSx0mZEL/yd73PSEQNRVrwF9vUZTECVdrryZNkK8q8KVbQai6SWE2/+
         YwMU+vFWdhnEjQagl5OitKNjq7qyOPX2wJhg3aK1TT65cc0BN1BDKsmlSgMWXZtTpVH/
         HUmS++JlBE/iYeGSprKPHGrkOsLHx/TjRwYPGnmm8aCI8d0W/Dj+mb8loWvzhQ5PLUa0
         ZW33++s3IVnxYW28T9nEYgXIB1sYl7cdG6wutO2pUpsgalH0XapHR68jL3lasTDHzzTB
         Lr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090780; x=1786695580;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qieJb84NY/DGIyJFPREzT33jCTD11yTCdeI153UvP3Y=;
        b=k//aULeknZ/D/YJDQpxu/LJOmJKLKRkeuRZYblKQzAQ7vqn2+mblzGDxRVkfbf7IdF
         9ljp9/MHuqiKfWLjD1FzXh7v9YXa1oZqDWjzBQ6R3eAeYPn1MusRbMCOP6sczcYOid38
         1geGqk+0ZvyO3gswxZQWbmbB2swfk6GLh7VKdlrYetJrD6F5ocBJIhmZ7/4KtHSc/i36
         q72LLEHXCXhDQ32G0JxrAcf/a1wkksP+xMyOZ2zqiGK/Ib37AjjnGfBrqO4Wjs4xyzka
         gcn/eiD//lvZcWGDDU6b3lf5VwU3cOKJqvgopCsqQ26NbFC+MDrqL3DXCI6+g2nlWHou
         DQtQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQrKAUbJRxt8BEhB8q6/k4AIQUHd4y8rV99+4oFJDbK7XsKg9iGDo9GmGUlq3fcCpp1oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86XoH89nADxvDcIVQYU+1GxujnvnVa7HIf1Mk9dTH3jB9pAbr
	G+zsOGnhTNc/q1tyNyjyK2o2g4Z+YX51IZg8kHdTFe90yUiAT62Jx2J8
X-Gm-Gg: AR+sD12Lj991UCPdalSnGHLNcVVdLCAoFPOMyhxt88XRUR78Dn7jlldcVe7Pyj3jWEv
	oS0+DlkxqyVGJYthzGZf2rvXaKozLObqnjrQiFpI/ewemSPtAXbIQ1uo9DVEwsmUoLG9hnpRRJ5
	awPq5cRdUSdkhzrsqs7M2XMPAhIA8fCmSQarfVtqMOyKJrMMWKjHNeXmkPfdtbIIkvIdNFJ6DyS
	MhVrAk0xK2/kahtOlqETGtKqvQu5L5v+pv+1tnAVs2dFWStghDvG8b/By0V3+PGHs7HXfVc1gPL
	E5wLScvroA0hzLwmqPQcCrdxMaWHW46qtjcICxtKEyisTNwfi/pQ8EyD3+ld72+k7rVf/9VCpM5
	20Odemi7SJBWf89QgvjAQjzNQRXrvDYiH0TKaovMuDvm1utaR6ODvR7AHVMZwXwrliq4yw5qiFa
	RsfJp0EuZetoMR6ic85Ff/ha8cXvHCtw/kzA==
X-Received: by 2002:adf:e001:0:20b0:47f:e721:1f77 with SMTP id ffacd0b85a97d-47fec51f260mr26165338f8f.13.1786090779619;
        Fri, 07 Aug 2026 01:19:39 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::cded])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002150952sm3057648f8f.15.2026.08.07.01.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:19:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 7 Aug 2026 10:19:37 +0200
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Fix UAF in
 bpf_trampoline_multi_attach/detach on update failure
Message-ID: <anWVGT_M1H49a0HX@krava>
References: <cover.1785902527.git.zhuhui@kylinos.cn>
 <anRE9L9HgOIYVCtj@krava>
 <4a6ee31b46b732eaad76b955d95c8cc261941894@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a6ee31b46b732eaad76b955d95c8cc261941894@linux.dev>

On Fri, Aug 07, 2026 at 02:00:11AM +0000, Hui Zhu wrote:
> > 
> > On Wed, Aug 05, 2026 at 12:04:05PM +0800, Hui Zhu wrote:
> > 
> > > 
> > > From: Hui Zhu <zhuhui@kylinos.cn>
> > >  
> > >  This series fixes several use-after-free issues in the BPF trampoline
> > >  multi-attach/detach error paths, where ftrace direct-call updates can
> > >  fail and leave ftrace pointing at freed memory.
> > > 
> > hi,
> > I need to stare at it bit more, but tbh I'm not sure the benefit of
> > preventing hypothetical crash is worth the extra complexity on the
> > detach side
> > 
> > IIUC we can't reproduce this error without instrumenting the code, right?
> > 
> > jirka
> 
> Hi Jiri,
> 
> You're right. I went through the failure paths and the realistic
> triggers basically don't exist for a normal user:
> 
> The allocations are all GFP_KERNEL (reclaim + OOM handle them),
> and bpf_jit_charge_modmem() lets CAP_BPF callers exceed the JIT
> limit, so ENOMEM doesn't get there.
> -E2BIG is attach-time, before cur_image is set, so no UAF.
> SHARE_IPMODIFY -EAGAIN needs livepatch on the same function and
> is retried in bpf_trampoline_update(); the multi path where it
> could escape needs a second failure on the undo del, which doesn't
> do ipmodify negotiation, so it doesn't reach the UAF either.
> The rest is bugs or not user-driven.
> 
> So this is fault-injection territory, and I won't claim it's
> a customer bug.
> 
> I'd like to drop patches 2 and 3 and the prog-side machinery
> (pinned_prog + rollback + the trampoline leak).
> And keep only the one-line image-side fix in patch 1: only free
> old_image when it differs from cur_image.

right, that one looks good

> It's obviously correct: if cur_image == old_image, ftrace is still
> calling into it, so freeing it is wrong. And it costs almost nothing.
> 
> Would you prefer I proceed with just this single patch,
> or drop the entire series instead?

also we can change bpf_trampoline_multi_detach to return void
and drop the WARN_ON_ONCE on that call

thanks,
jirka
