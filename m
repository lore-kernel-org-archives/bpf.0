Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFE33F8C2
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761691; cv=none; b=qALtG5ehecNSkJ1ooXywNNSlcz+iF8YMPCNB1sR6E8g/n7UO8UgMxqTcavkZte55QMLkspsX4n0YqRdE0ZPbWyndFr8x8BUIxyFJCpZcAIFiwj2MQH3UE2eH9nkzwp8A2LNnuJseyeycTBfC+why7Uo4G0g8ebqL5M3kOgiVXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761691; c=relaxed/simple;
	bh=7xGIne/B7lQhIRzggFV9bZEPeJ5QAiX46dvSj8cMi2A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5g/EuEpg3pyDhVxbuI1dD5CjWffWeTGf6CIDHan3/vg1/C7koZ5l4iA/a8isnGzEQcE16zift3n/pzNheGIBhWXKHzFblimCEBUE2xxl3g6CymtUo1KvDiTiCvzWcl17Bcw1Wkd693XUZMLtkwHQ7PxOtEaIs7e627qFtvFpd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTbVizSy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTbVizSy"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ba840146so37402465e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761689; x=1777366489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fVWbN9Xa8VHe4NPF50cJNaRWYZta6ICN9f2+GKEM6pE=;
        b=nTbVizSyTx8TV7OqwG93yWq40zHwsEDb0djvunaV+E6uHbksxPAUJf/TFYJgr+N88A
         XxX7b6+heWr3m/GCXnfZDLmQhxdPuQkpPdDRkQJFmoy/jeyzhmKNeVawxksjkQy/bi0B
         Le02i3yNNvCPnc0+z2yILHPJ99R6t3FCzFWx63UjUivT76kLMOjRI/DEdb1Q/H6arwEQ
         eusJK7KA2Ua2l2FEXzDEFq6D9YA3SraIMtkM6jdJpd+MAHeXMmZYWr8i5YE1ngnTrZxP
         cwRSPQx0mnHmaxGKnOzJvQCq7ztgiFc7B/Q7s2UXB+kehC1FyssJWPAgLXHehXu19Ygo
         Zy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761689; x=1777366489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVWbN9Xa8VHe4NPF50cJNaRWYZta6ICN9f2+GKEM6pE=;
        b=CNqK/Jsd1xLlvHX+iYbDFElvfMWM3+1dNwLIJhX83ANpwhxQ7KO2UVpT8bICNMCaED
         WNmJnj5WquI+G6Lea/5l4yDi0MLe8PIPHfW+Cud/41FCayNGUT/6K8RByW84TPfT/vB3
         zNPSqLc8pHWobrIcLZLAMu5l68GkxeFCPqDDhRwFW1E6zrcDnl+AWP/4WzYRWV4ZaJ0c
         G+5aQGXyKxJ7POuVD1dVmUD7CjlCCcygqSSC8JjSS9QOT2CeGi232Trop3gJRe19SQb/
         WQA/camBqAYtDhIkrpsxvdDBrrhwyjlTYBAOhfl0MHZcnMVrSmK+yHi0J2pWMSdnlrds
         JBJw==
X-Gm-Message-State: AOJu0YyqxahoSKQ+VxnGiyYLgI9PeBjycrmXxsXKo59kc+UkKrklU+LB
	VLjGjP/n0pkmdgc4qFxig61IKoFU8uyDvRF2XCsA98BbClgwagW1kCpQysZ9UR4E
X-Gm-Gg: AeBDietYLcwld9fm9KLuDjk4R8hwvM88Znss6rop0xLegUVT/hcdf522ElOx57757Ak
	L5iZfDPKbx9VTkHJYSyKL9M9KzZgNy2kWA39pOzPkmDOiT+lJ11zz2zzdS0Lc+CxEKs6m8/kHPN
	yITDduA9yzpnoeAboDYdaszlONJ731oB4QG+bUiLiUGM1tVsrGkG03x57ZChnKgDPbNtbTDS0ez
	BmT2+XFVL3b+yyxkdoABMp6rKzCRS8MTnMXflgPKqqvi4CfTeGiGPcyTH4AMfuBY183+aSeaMLY
	rxuqrTcjeXhqO7yljwjW/iZLtZLavRvZRWPCk8A6Ngf2VrQgQrV+S8oi6K4pcEKPXyah1DWI2i2
	YFcAcZIdAWWPKMe8pcma63yUHl00BptpcRbJNCB6+BWpspMOPcD9zB4033wPgnNk4ykw86vxLaq
	CT0Qvy2ao=
X-Received: by 2002:a05:600c:5285:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48a53338269mr69751535e9.15.1776761688531;
        Tue, 21 Apr 2026 01:54:48 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52d232afsm26326085e9.31.2026.04.21.01.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:54:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:54:46 +0200
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 01/28] ftrace: Add ftrace_hash_count function
Message-ID: <aec7Vqu2wVDbx8QU@krava>
References: <20260417192502.194548-2-jolsa@kernel.org>
 <20260418005821.4F156C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418005821.4F156C19425@smtp.kernel.org>

On Sat, Apr 18, 2026 at 12:58:20AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Low] ftrace_hash_count() is declared under CONFIG_DYNAMIC_FTRACE but defined under CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS, leading to potential linker errors.
> --
> 
> commit 62c46ea6c0c10abc0df16b7c684809496d439e2f
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> ftrace: Add ftrace_hash_count function
> 
> This commit adds an external ftrace_hash_count function so the hash
> count can be obtained outside of the ftrace object.
> 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 28b30c6f10314..9d9ae1bc692ae 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -415,6 +415,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
> >  void free_ftrace_hash(struct ftrace_hash *hash);
> >  struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
> >  						       unsigned long ip, unsigned long direct);
> > +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> >  
> >  /* The hash used to know what functions callbacks trace */
> >  struct ftrace_ops_hash {
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index b2611de3f5943..57ab01fd00bda 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6288,11 +6288,16 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  }
> >  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
> >  
> > -static unsigned long hash_count(struct ftrace_hash *hash)
> > +static inline unsigned long hash_count(struct ftrace_hash *hash)
> >  {
> >  	return hash ? hash->count : 0;
> >  }
> >  
> > +unsigned long ftrace_hash_count(struct ftrace_hash *hash)
> > +{
> > +	return hash_count(hash);
> > +}
> > +
> 
> If a kernel is configured with CONFIG_DYNAMIC_FTRACE=y but 
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=n, will this result in a linker error?
> 
> The declaration in include/linux/ftrace.h is located under 
> CONFIG_DYNAMIC_FTRACE, but this definition in kernel/trace/ftrace.c is placed 
> inside a CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS block.
> 
> Code built-in to the kernel (like BPF or tracing extensions) that attempts 
> to use this new API could compile successfully but fail to link on 
> architectures that do not support direct ftrace calls.

right, will check the compilation for such config

jirka
