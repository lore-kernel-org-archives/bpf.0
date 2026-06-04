Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17C2D6409
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559969; cv=none; b=ovBf2fvjcKyfX06qRJrBN2QYxMsUYaN9wIuFkpfN37D0PDSbjAOXVR6M+6QjKp2qs+UMorec8mHB2RuAURgwEwktWvSJ6UZQaIBR8TbsP75ITE1EuQMV55UUIGSWp/jxUDufz31042qcRMdZ+cSkEbPndR83a/gv1QNflLAMe4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559969; c=relaxed/simple;
	bh=CnhMj81FkK5riQbmtkpJCB21rHzxFk+nB0anZX/jsjM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCob/+2OlpfHeawiRdDlCzcanbryNklXUIlwKuCqx30Kge4+shzUv0YYvz27Iojy+JA5oUeAVcpE77JvawWgSRH3cRPBCJhlnP4OGIU/PSHx3OI5bPOMVn4JpiAj06RolXKDlLfVPXhZEIpAZ1H0ATv4dzmbD16FJlq9h41UzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEMn0ocx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEMn0ocx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b613a17bso3579595e9.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559966; x=1781164766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlSlkzihrQLsWLGFxnsYvqE+OsF/acsWFa5H1/cLFIk=;
        b=CEMn0ocx63AFb3KgB19KcU8urYb3K1F/a/k1hsXkAOtZ5kyV9Bz0Pnhqh21jme/q7Z
         /s/rDnYyzOC8vyv1A9cJ1wLtt8f3lgwKru2laTRIoKs6XE3pJ3LHcTFt8JwCTXdlfBPC
         0bVie09gZt7TFXe5eccZGNJNPMPAIHXEYNeuMrdXCR/ufi0pnZHuR9FlFsllCLcGHeJq
         dDcwpv1bXrPZzinz+zDfIIK/yMf3Dn2miW8wIOagaHl534YbJ8Gp2x1fB2NSZ6mg4NZH
         q1aJLvRCm9qovawh4Uybw7yUr+CiFddnX3I1lNF7teXz+GLuYhRQ2ACXUDgl3K+Mbhvo
         D3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559966; x=1781164766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlSlkzihrQLsWLGFxnsYvqE+OsF/acsWFa5H1/cLFIk=;
        b=PMtZVZHF1v6pO4p/68wTI19CaeLlNJhv+3KILHCj2sk7hHnCeQaz/LNjHnvWws4UH8
         brDzPZO689iHVIYXezDcxfpzFLo9mjp8k4oWBtUGq19GlIEEWp6tBZF/dK6JBk6p1qjJ
         /836IXBOL4DXO0MmGIahm0DhMGHLWdHbED8xQ3uiH+FJS7JyE++2qCssdjacICqfqS9M
         oxmqdHfkZah88F8h3Jw6KKSoW4rZdH9RXqgFnUzZm/Z31ykJWDbD1FqQWIxRaJ3uqsQg
         xJwMy2xCnNJ3gPsR2xAX6SKKeGwDcg+mqh4zPwtlFPvHURJKZqNMiT8Y/FLxBSetwW3O
         KANw==
X-Gm-Message-State: AOJu0Yy3NccDNDI+l7VtqJaPPYPoF29C0sUuxTWe413xSPua4Cekqxg+
	ti23gGmEgQ0HXq4/QCf3Fa9mtJC5QWCf3fMoVdjl/ToBkZEGtGnc3CCd
X-Gm-Gg: Acq92OFmOh00potGmkOcUW0AdveGBnmMHwjj5SUr4MxUN9b2KkwxG/5/DbpC3dA9r3v
	9KoL+Deyfex3Iopp+WTAacKYxUbIMQhUKDV80WTV508SiMStJpAjdoaVXIglV0B10BvyQz3Lw0Q
	UUhrt9uanO0U7GiRVeQNkxatObL4OhDURTktrdecBnRsKkExln2UmDJ0FpvtfHs61a9hNAFW85S
	vGLO09pJ7fW6C98Wx/sXBscR2RBdZs4/rpxZ1ttfv1ioFzVk9wL0CoNUzaPbXVggzffRBQg+iqK
	hGCQbdpimR6GtQ8WXY2V8XE+kBlk+4xgj7vkbR1f3RF4HOFkJx959hJZcDYLTijJemZKpfkFPFz
	PRzpo4Lca8pfEIif22pEgyru3aPKIuzFDb2kEreCh7Yoj2yqVPR4OTb62JHwEEKQwI+CBtAK0Xz
	pVvApqml2DJNTrITWg0THGETdImQ==
X-Received: by 2002:a05:600c:444c:b0:490:b58b:a4a5 with SMTP id 5b1f17b1804b1-490b60e0a19mr106863165e9.31.1780559965940;
        Thu, 04 Jun 2026 00:59:25 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7d6b990sm71476955e9.2.2026.06.04.00.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:59:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 09:59:23 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv7 bpf-next 04/29] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <aiEwW3-dzi8Y5d0n@krava>
References: <20260603110554.29590-5-jolsa@kernel.org>
 <20260603112900.318991F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603112900.318991F00893@smtp.kernel.org>

On Wed, Jun 03, 2026 at 11:28:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Multi-line comments modified by the patch do not follow the mandatory BPF subsystem comment style.
> --
> 
> commit 107ed36e35d617129f1228fd0db67188b4ce4a98
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Use mutex lock pool for bpf trampolines
> 
> This commit replaces the per-trampoline mutex with a mutex pool to
> prevent lockdep warnings when attaching multiple trampolines during
> tracing_multi link. Trampolines are hashed to one of 32 pool locks,
> keeping the maximum simultaneous locks below the 48 lock limit.
> 
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index a4298a25d4bae..c0b4732627bef 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> [ ... ]
> > @@ -99,12 +128,12 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
> [ ... ]
> > -	if (!mutex_trylock(&tr->mutex)) {
> > -		/* sleep 1 ms to make sure whatever holding tr->mutex makes
> > -		 * some progress.
> > +	if (!mutex_trylock(select_trampoline_lock(tr))) {
> > +		/* sleep 1 ms to make sure whatever holding select_trampoline_lock(tr)
> > +		 * makes some progress.
> >  		 */
> 
> [Severity: Low]
> This isn't a bug, but since this multi-line comment in
> bpf_tramp_ftrace_ops_func() is being modified, should it be updated to
> follow the BPF subsystem comment style, with the opening /* on its own line?

already answered in here: https://lore.kernel.org/bpf/ahg_YFpqlTGYQUay@krava/

jirka
