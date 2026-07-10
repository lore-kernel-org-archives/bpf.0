Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289C30B517
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670442; cv=none; b=Y7cYGTcOy/mQQmDDFFU5mvcDtF1+h3XHcQJmkCM4lvzVF74QO8DBPEpFgcMSUEi25MMuqm43hv+ITL7N/eNEDenKgVZnlKXiMGMv/5Bbbvihkit93KLYy+8QYdOc5Bq3/nn8TjXuBoy+zbJ6MuOMqWxeobSWV0YYybwku1EJVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670442; c=relaxed/simple;
	bh=pUv5EBpxAawNlfz6TfnjQheGLcQNgrCAdjNiETQ0vk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjHuTM4M7FVR2esZ/19wLxmJp9pD+rSl4fhanEui6f4HDiD6iT1o5Nl7eDInY913Kv+8rhh2tWdo+TDJepnLDON9W4fYoEpezYqCET0MAZAslcDeBpMjb3Og69bU+Jk6HCnkRss5lS7HA6Cg8gRMk/A3aM/0DOqI0vFVa2KXBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IxqafOfA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IxqafOfA"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15f6de6cdfso101014766b.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783670439; x=1784275239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7NAnOHyxoVPYpVNY9WSaqu/dYx79TRxCODHHV36sDoU=;
        b=IxqafOfA/N/hHWXo+zgtXGrWDCI4I3NG0MxoJxFEGrJufNpZSsnHBObPaMiiyj9AZR
         FOnuDybmGNgRs50gsMIatM5RyTYOWhUS+/MCJacUwsJSUdtxUjp5e8mhVO3GTUYna5o8
         WpMWFUypAmcsx/XVlcYl72mE9QadR20R+upDxs/6+L6yx46W8ZxD9eKiWXI66xuTVFTr
         tAnQtMj1+ta0QngmU24L6k8IZgzUQ6+i8vFAk/IK1vNlq1DptpCA1lnO9Baat2PywGVP
         /lb9XfMm94Dz5nsQXDY38p5BqZdTPhWo1Jj4WP6x3PKcWj+ZJBmnPXtzmkThmyRCn7ik
         FILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670439; x=1784275239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7NAnOHyxoVPYpVNY9WSaqu/dYx79TRxCODHHV36sDoU=;
        b=ikwYTLiKMwqEv/J9/YIFrACweE/QBeIJcAkX6lF9haRG6WTiE0uawuypbcVUX/Ub/z
         eKDMUL3KexeBDozuhUjOVeEHFpMgROsAXof21GljIFgSYAphocrE6bW/GFATE7td0aLE
         gAUETXL1CNUgufC/Qp1pGt5Vl8M7u6HDmi5W1HZLug5YostmTg3ibAfcdGE6gm1wPnza
         MH9V4C4DncCHOy78iGjnlLWpr7dr2QjOWZwGA+qfAm/aZ6NGHrIaelGHTPrpZkLAm13s
         76b8WgYSEkihKTNgNfeL3ofIWXPM0f9IBqUMV1DsamIz+iDh/U2FwedHQ7TVXEauBJuB
         n/3g==
X-Gm-Message-State: AOJu0Ywc6kLCmus9JBOiUOHyl7rJSOYllCkESHI/+kD5ACM0ZiRhwB8b
	36YsH8G+FZxZdWiYvLKdQMMoiN2qwD79Ffjz6qoYnXpeDCxlA5tRCAC4uyRNNGXQGCw=
X-Gm-Gg: AfdE7ckH0fptPEoC0Q4hmMevjGHsYLuAynqg33H+rws0ohKs1KM6Xuxyo808Vk3fye2
	cWUS/f0QncKl/ITv8n0QmtkMSLPcViEc/RIIE8dQOxRb+rFLY8JQzaUSbjRCVwY/j90Ai/gFZsZ
	k5u1g7koQat3/idy8g8qICdDM0rcNcNd2Ehi6/g1qyVLBYlxTkJ+IBmZywCNvydjK5FgPLRFNxk
	WBztyzNQj9ZNru4IVg0FlIt46r28DREsH2/Map5SaFNvPluXiDWMeiUlDN4jhpWIGj6gTb4wBkF
	DHwh+6/4DosrMaXyema/nKEUHCrSbryF2v1CYSCKsoMIes5JzBz1mujjdBVYt6Cys8SpfiarK9Y
	SgTRAs50XND2TNVaXPAM4NIpWKhe4lQMk0GYQbjITtNd59Ni6IfHC6i/N2Qh6FB51YQfxTwvht9
	Eb8iRv/lPVhoYXAj22ox+LE6mXtzIwujLGLmA=
X-Received: by 2002:a17:907:6093:b0:c15:d5f0:dbfd with SMTP id a640c23a62f3a-c15d5f0e8afmr428879566b.62.1783670438684;
        Fri, 10 Jul 2026 01:00:38 -0700 (PDT)
Received: from u94a (27-53-185-121.adsl.fetnet.net. [27.53.185.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8f26sm56534285ad.27.2026.07.10.01.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:00:37 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:00:27 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: sun jian <sun.jian.kdev@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, mmullins@fb.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for buffer
 pointers
Message-ID: <alCgmxFh9q-vjE0O@u94a>
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
 <20260708090151.151729-2-sun.jian.kdev@gmail.com>
 <ak5HLLrYK3R_g2y_@u94a>
 <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com>
 <ak8XSRiLKx5WcIQw@u94a>
 <1f8aad47f61fbf85eb55276e4bb01bfcff61393e.camel@gmail.com>
 <CABFUUZEXYduca34g22YZ1ESyYe3Yc3kYQrTEWLMxB5X0ZmYn8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZEXYduca34g22YZ1ESyYe3Yc3kYQrTEWLMxB5X0ZmYn8w@mail.gmail.com>

On Fri, Jul 10, 2026 at 01:52:26PM +0800, sun jian wrote:
> On Fri, Jul 10, 2026 at 2:21 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > On Thu, 2026-07-09 at 14:47 +0800, Shung-Hsi Yu wrote:
> > > On Wed, Jul 08, 2026 at 10:11:01PM +0800, sun jian wrote:
[...]
> > > Actually looking again at 022ac0750883, moving the `off < 0` after
> > > tnum_is_const() and bringing back the `off += reg->off` removed from
> > > check_mem_access() is perhaps the more faithful restoration of the
> > > original behavior.
> > >
> > > Though reg->off no longer exists, we have to use reg->var_off.value
> > > instead. IIUC any register of pointer type should already have its
> > > var_off bounded to +-BPF_MAX_VAR_OFF by adjust_ptr_min_max_vals() in
> > > theory, and thus shouldn't overflow `int off`.
> > >
> > > See the diff below.
[...]
> >
> > I don't understand what this patch is attempting to fix.
> > If you run the selftests from patch #2 against current bpf-next both
> > would be rejected. If you extend these test cases to exercise a truly
> > negative offset, that would be rejected as well.

I tried to exercise a truly negative offset, and it was indeed rejected
on bpf-next. I had thought it would pass.

But more below.

> Thanks for pushing on this. I rechecked the issue more carefully.
> 
> This series targets the bpf tree, with base 12091470c6b4. On that base,
> with only the selftest change applied, the negative-offset verifier case
> is not rejected at load time. The test fails with an unexpected load
> success:
> 
> #664/2 verifier_raw_tp_writable/raw_tracepoint_writable: reject
> negative const offset:FAIL
> run_subtest:FAIL:unexpected_load_success unexpected success: 0
> 
> It is possible that current bpf-next rejects this earlier through another
> path, but on the target bpf base it does not.

So I think I now have a better picture of what's going on. Before
022ac0750883, negative const offset is rejected at *load* time because
the const offset is accumulated into `off` before the negative check:

    // check_mem_access()
    off += reg->off
	// __check_buffer_access()
	if (off < 0) return return -EACCES;
	if (!tnum_is_const(reg->var_off) || reg->var_off.value) return -EACCES;

After 022ac0750883 the const offset accumulation does not happen, and
thus now negative const offset is no longer rejected at load time.

	// __check_buffer_access()
	if (off < 0) return return -EACCES;
	if (!tnum_is_const(reg->var_off)) return -EACCES;

> > And this does not rely on UB.
> > Consider the current code:
> >
> >         env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
> >                                             env->prog->aux->max_tp_access);
> >
> >
> > The types of the expressions involved:
> >
> >   reg->var_off.value + off + size
> >   u64                  int   int
> >
> > The promotion/conversion rules:
> >
> >   u64 + (u64)(s64)int -> u64
> >
> > In other words, 'off' and 'size' would be sign extended to s64 and
> > then treated as u64. Hence any negative offset would be represented
> > as a large unsigned value in max_tp_access.

I entirely missed that, yes, the attached-time check does prevented the
negative offset going through. So there isn't a bug, but the behavior
has changed, and it seems better to restore to the one where we
straightout reject negative offset during load time.

That can be done by reordering `off < 0` check after tnum_is_const(),
similar to how check_ptr_to_btf_access() was update in commit
022ac0750883.

[...]
