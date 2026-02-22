Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B61A23B1
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770793; cv=none; b=fCxA6nmTLPYhSA3P4eZQO/B84GnHBRaD5NPfTnoKgJMuda+4ygBLPGjMeGv/iAu2/w6HQ0wo6m7uadHb3ea4VML7gwaeZ9A4mXAyd2//j5+FdLfJh3llxQpLpetr1DpuuZ6UOgU6CPcSlg+b8iuzHhDzK++ZWcDOYJexTk9XwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770793; c=relaxed/simple;
	bh=czVHbnoAPhj+wxT7p2LEcTixzxrEOSy0xW85qyu9Ko8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEU1LpE5icjvb5wLJ4NgZ4ArfIH6SOG/EXC4qa+aOrSd6jMwElWE3hlHY+ePhKn0ZQiYOU8otFPpg3RLLIDzSOrRC/AUsu2X+yIyGer3BMyOUdFh5W8+PT6GxAuDk212YorSGgZcsPou1BuMQwpfXZHM3fvAKlJUIESAsq859FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNn5xRH2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNn5xRH2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso26316965e9.3
        for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 06:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771770790; x=1772375590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFV/yKqgozlTVDw9n+tXH1WNqCj3KoDrgyjsea85h+8=;
        b=BNn5xRH2rqLFVdRTw91ILK/DNVpjYAuad/MSp8e/HMK5YgxQwV4srPxJcx8oO3yuG3
         JOlb3O+mThBXtKyonw4XfzU/DQDo73yoMjPPDzAM9e2Xj/G8SOic9o5DEsAP8SDzoxOW
         tDCGbtt5T85I4swi9mf6Cq1VKXJOTGgvTgNXit311mi8Rn41papMaHEkQQ2T/1GGq/2v
         iQVIVi8Si7zZ8z9BZ4JtNtoIGF70HU+axcunTRyYue7hq9GjvirD7hlkJIdZ5CygSqpu
         XiHlGowQm9XT3NKtEfBG7p0lvPTjIzO1IM5J+HHckRUTL0nn5uGiurIGEiWFLHuva6HC
         aCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771770790; x=1772375590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFV/yKqgozlTVDw9n+tXH1WNqCj3KoDrgyjsea85h+8=;
        b=kwFAPqILRDVLsqqoUUVLR8Tj7suOWeCEUxeQj/WXRfo7uDRrmYIjc2WX2T6zuURPpn
         1NcHbdyLO9UKWcLmfKLZOVzb13hvvRHARUN0wSbV8ktlOZhSmQvthcrNfDJRXjapYAjW
         4ETgh3ttFspYiilEaFld4QcvrAFeBSOVdJyJV0Tx2+iGlxhcs4rhvW97R00v34j/BEmu
         Ic5Pa37ARWLEFZHxwQw0ET5OcZr05qPimYzP/m0ggyOoBavGJIXJm3o839TMKx+2x7h2
         e0lxTrwET0sYQsJDWnOeqOsTBDfR1H5+hU82seyBwatVNrdlpNKkGZiwQq6mCrTdPRBf
         3qSw==
X-Forwarded-Encrypted: i=1; AJvYcCXLJfG9/XZJagDGHOCITGgtvX49Pp28hqP68A2jPe89hEmWlj2s312PoZO+KwwCcDUz5dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLx8zXv7F41XFa3qFVoc+PG11UJrbwyulHvaiJVSY2IRPpy4q
	zuJkMr28aEuC2GFYd9jGi1jgKZAiXDYexeuhH0VpmfXOEdZMRyKxhiSh
X-Gm-Gg: AZuq6aJdk8iXNKVDmAWg8RmNtvEqZvrVNNp2PhrkCMPrWj8UrIlbARPdKvCDqmQWRHY
	TqDvQoRT/L6IQV17f5SKoxBWTGH4AKY3GRFE3LO8tvipHuyeF/tMPsLyEyMs6R6tkuePPkXNJMM
	UL4rlLkVf7/aCmtJTxNz+15sQYnUVmTSXSo2kcCyv7YF8P8fgHKamkzpyAT2pBSE0rJ56+0lEEd
	B9RT8cvcK7oBQsW/SeI/4xOomfi6qvMeUbgcS2HoJJrilEwZ58elk0+pgSPS3fR0OXMzc6FSN7F
	AMPl7XG2oX7fTgAYJva/hEY8iOLoSjN171V8PRM8Mqsw5zCdcbeL1sMvZBflhSmL5PAkWtgDuqM
	ydfvTL7g951LxIDKlq+cn+QbY7pxnoDi7ER8dPMJB9bFiYfW24Rh725O7JZvhk6WRyh63sshQrb
	TLn49DsVU=
X-Received: by 2002:a05:600c:4749:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-483a95e5ab8mr98760325e9.24.1771770790322;
        Sun, 22 Feb 2026 06:33:10 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b75e63sm211947645e9.6.2026.02.22.06.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:33:10 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 15:33:08 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <aZsTpDAaSnDzxNTL@krava>
References: <20260220100649.628307-3-jolsa@kernel.org>
 <aa8d95a4f3b4fa59b0cca8b65faa300ab18d956d32443985e8e09f506a8cb1ad@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8d95a4f3b4fa59b0cca8b65faa300ab18d956d32443985e8e09f506a8cb1ad@mail.kernel.org>

On Fri, Feb 20, 2026 at 10:57:51AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> 
> [ ... ]
> 
> > @@ -71,7 +110,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
> >  		/* This is called inside register_ftrace_direct_multi(), so
> >  		 * tr->mutex is already locked.
> >  		 */
> > -		lockdep_assert_held_once(&tr->mutex);
> > +		lockdep_assert_held_once(trampoline_locks_lookup(tr));
> 
> This comment still references tr->mutex, but the field was removed from
> struct bpf_trampoline by this patch. Should the comment say the
> trampoline pool lock is already held instead?

yes, I overlooked the comments..

> 
> [ ... ]
> 
> > @@ -102,7 +141,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
> >  	/* The normal locking order is
> >  	 *    tr->mutex => direct_mutex (ftrace.c) => ftrace_lock (ftrace.c)
> >  	 *
> >  	 * The following two commands are called from
> >  	 *
> >  	 *   prepare_direct_functions_for_ipmodify
> >  	 *   cleanup_direct_functions_after_ipmodify
> >  	 *
> >  	 * In both cases, direct_mutex is already locked. Use
> >  	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
> >  	 * (something else is making changes to this same trampoline).
> >  	 */
> > -	if (!mutex_trylock(&tr->mutex)) {
> > +	if (!mutex_trylock(trampoline_locks_lookup(tr))) {
> >  		/* sleep 1 ms to make sure whatever holding tr->mutex makes
> >  		 * some progress.
> >  		 */
> 
> The locking order comment and the two references to tr->mutex in this
> block also appear to need updating. The locking order is now pool lock
> rather than tr->mutex, and the trylock and sleep comments still name the
> removed field.

yes, will fix

> 
> [ ... ]
> 
> > @@ -1026,11 +1065,11 @@ struct bpf_attach_target_info tgt_info = {};
> >  	/* note, we're still holding tr refcnt from above */
> >
> > -	mutex_unlock(&tr->mutex);
> > +	trampoline_unlock(tr);
> >
> >  	return 0;
> >  err:
> > -	mutex_unlock(&tr->mutex);
> > +	trampoline_unlock(tr);
> >
> >  	if (shim_link)
> >  		bpf_link_put(&shim_link->link.link);
> >
> >  	/* have to release tr while _not_ holding its mutex */
> >  	bpf_trampoline_put(tr); /* bpf_trampoline_get above */
> 
> Similarly, this comment in bpf_trampoline_link_cgroup_shim() references
> "its mutex" which no longer exists as a per-trampoline field.

right, will fix

thanks,
jirka
