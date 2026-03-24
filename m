Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D72798EA
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 05:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329033; cv=none; b=m9zqesCnOZH5ekE54eJMnAK4jBeT3rh6L20myerwxTeqPNvMT/GEvmpK7KUG/NxLh7RtRa1zXiMJScNIDIlJRZPIb3eDJEBXYmVu4Tg+JFX2ptDyGqIG8yFfhUpmn3BLvFSHSnQA2as2gP6aY3l+ECsKDGKfppzqku2+dSM5iLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329033; c=relaxed/simple;
	bh=SxJ7/XKMOI7mUhF3X52LXE3mzRp4r+llkrylrodC3SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kth+VlxCUmQxwOMz/aAWTrkYzZdhhfBw8Uic9PQyn+Z6N94RgzfiXN2rEIS7HkT+QD2g4DlJBMSbCBPwDtZlQTjCI7JubutcbW+LYuB42F9YXAgC/t4zNFrrQCco+2mYRQbLMoCmdk7UDgNVfVVvs/Kl66os19J+makWEHiWFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UY6NsvwC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UY6NsvwC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66970715adbso4142116a12.3
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 22:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774329030; x=1774933830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pleB8pif4RkGnik+l3SEW8iROsAVdCziVzZNNQ1Nnv0=;
        b=UY6NsvwCSemj6oHqmSQZGf+qg02in6HAzmizEfIiJS9aATDej1Hs5/ydzcMxXPLdKW
         b0Km4mmYqYdcJeFaw77orxb69X1JJ8JgQK1+B75tTgJNPZe6O4aOwWssLEdPzOIQtKYA
         Xk9j4nfUIvYwUUg+gk0CxiEcq95LyoEWC/VMXbIyelkxeHGhUm2+kU+0XOOQKhvXYwyP
         VM2E97NAEai/cdTarZ45yzh+25RdpgNAneJ+UDUutg1Ix2uvc4v0Nblrx8elbjxRoiRV
         PlizZ5EBkBSSCTYHZunO8KzrtKlfkyC6rfxZQX8LkUbBr+1UndAvDdmETZzhyTp/TwKS
         ufwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329030; x=1774933830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pleB8pif4RkGnik+l3SEW8iROsAVdCziVzZNNQ1Nnv0=;
        b=qqW7bU5KA7WxWo9khZ1rFGWKYr8vdQnMWLUHl9zmjKVXdK5IJG94DLbZBkgOljxO2s
         n9Id86Xp+8SONqLBlerSY5hom8466jj9bXV523hCyTpsW4ry/5JhPMgoI2AaUiYqSbCf
         hiGGVl/dp6ZcgEf+JWpCro2Dq60tlHbuKM0m2wOioXsgbAhBdBcLaUUfc2SE5s+Z5Pg+
         ofifP5KZXN0XvOrq230khwiNm27MBRFv4b5tzL8CD6GC+9rmBH52wG/fodhvm92PDXZd
         OVvHki/l8vB6Dj1ko5a0+K5Uy9892dLtNRXh7qurj+18HoJbNFCiYFPWduIA3PKywOOE
         qaOA==
X-Forwarded-Encrypted: i=1; AJvYcCVGMXXKzvbqbPmCNV7gPz8/zpGu7uDXPxIor7n1Z1GHr+NbxewD/sCJREM653qYbehkN+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAqOH9vaucneXae595rvO7OJQZKQ2QUmX5AGJFxXjIQ12fpu2
	HhQItSEWQeNEYF+iKH1D1fisnYiH6OTGNWt0F+lJkZF/K65U1GHXxmmhWaOdJwY9/Q==
X-Gm-Gg: ATEYQzy3eYDHElub/2iLCqcm732TNIx0e0DbAVXxYdM6Y1VurF0cJokSLHWPI3af4nS
	ACgthcSlPGcnd0WnKnHrxkKacLldUCELVN8U5z/DD3y7736Qr7o81RZtvR7h4V46J0df6otB1Ry
	r3SasJyIVtnQbGPpho/Z60raDBkCmDSMFnCZ9Ps/0vFXgN9sWzqQwdYcznDNlmF8aOXA7fHBrPd
	cLWfI7bYn7g0qNb/Et2/x+D8ghbe9AtQvo331RYPORj9EBOyblD992WXDP5gdoW8V1sVlRJqZ7S
	cpe0nb8ZmaCxKNk8phCD3TD+GtFrcT3LvWQMzWCqXBui62jWxRRbMIK4zWEhPyNN3u8JnZyS6vJ
	4vLp6uPBzyv/aWsw+XcRNaXE6SLz7AYjb7Qjy9r3o+hLaidTRQF0vR4a6ln0tVou3FfpYi5vUvG
	S+B06sofxS1OzcOLhH57L7sWSOEc79SclsI51f+wdc9bND0q1KE3P0pAJJL/+I1Ak=
X-Received: by 2002:a17:907:1c84:b0:b98:33a7:d5e3 with SMTP id a640c23a62f3a-b986d8b194dmr403899866b.8.1774329029538;
        Mon, 23 Mar 2026 22:10:29 -0700 (PDT)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8da12sm597270566b.21.2026.03.23.22.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:10:28 -0700 (PDT)
Date: Tue, 24 Mar 2026 05:10:24 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>,
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
Message-ID: <acIcwCqwo6e2-EY1@google.com>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <aZz70R4zeFajNUls@google.com>
 <20260227-verallgemeinern-umgefahren-6f89a46cc30e@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-verallgemeinern-umgefahren-6f89a46cc30e@brauner>

On Fri, Feb 27, 2026 at 11:33:56AM +0100, Christian Brauner wrote:
> On Tue, Feb 24, 2026 at 01:16:01AM +0000, Matt Bobrowski wrote:
> > On Fri, Feb 20, 2026 at 01:38:29AM +0100, Christian Brauner wrote:
> > > Add the three namespace lifecycle hooks and make them available to bpf
> > > lsm program types. This allows bpf to supervise namespace creation. I'm
> > > in the process of adding various "universal truth" bpf programs to
> > > systemd that will make use of this. This e.g., allows to lock in a
> > > program into a given set of namespaces.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
> > >  kernel/bpf/bpf_lsm.c    | 25 +++++++++++++++++++++++++
> > >  kernel/nscommon.c       |  9 ++++++++-
> > >  kernel/nsproxy.c        |  7 +++++++
> > >  4 files changed, 61 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > > index 643809cc78c3..5ae438fdf567 100644
> > > --- a/include/linux/bpf_lsm.h
> > > +++ b/include/linux/bpf_lsm.h
> > > @@ -12,6 +12,9 @@
> > >  #include <linux/bpf_verifier.h>
> > >  #include <linux/lsm_hooks.h>
> > >  
> > > +struct ns_common;
> > > +struct nsset;
> > > +
> > >  #ifdef CONFIG_BPF_LSM
> > >  
> > >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> > > @@ -48,6 +51,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
> > >  
> > >  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
> > >  			     struct bpf_retval_range *range);
> > > +
> > > +int bpf_lsm_namespace_alloc(struct ns_common *ns);
> > > +void bpf_lsm_namespace_free(struct ns_common *ns);
> > > +int bpf_lsm_namespace_install(struct nsset *nsset, struct ns_common *ns);
> > > +
> > >  int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
> > >  				const struct bpf_dynptr *value_p, int flags);
> > >  int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
> > > @@ -104,6 +112,19 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
> > >  {
> > >  	return false;
> > >  }
> > > +
> > > +static inline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> > > +{
> > > +	return 0;
> > > +}
> > > +static inline void bpf_lsm_namespace_free(struct ns_common *ns)
> > > +{
> > > +}
> > > +static inline int bpf_lsm_namespace_install(struct nsset *nsset,
> > > +					    struct ns_common *ns)
> > > +{
> > > +	return 0;
> > > +}
> > >  #endif /* CONFIG_BPF_LSM */
> > >  
> > >  #endif /* _LINUX_BPF_LSM_H */
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index 0c4a0c8e6f70..f6378db46220 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -30,10 +30,32 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
> > >  #include <linux/lsm_hook_defs.h>
> > >  #undef LSM_HOOK
> > >  
> > > +__bpf_hook_start();
> > > +
> > > +__weak noinline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +__weak noinline void bpf_lsm_namespace_free(struct ns_common *ns)
> > > +{
> > > +}
> > > +
> > > +__weak noinline int bpf_lsm_namespace_install(struct nsset *nsset,
> > > +					  struct ns_common *ns)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +__bpf_hook_end();
> > 
> > Is the usage of __bpf_hook_start()/__bpf_hook_end() strictly necessary
> > here? If so, why is that? My understanding was that they're only
> > needed in situations where public function prototypes don't exist
> > (e.g., BPF kfuncs).
> 
> I don't know. I just went by other sites that added bpf specific
> functions. Seems like bpf specific functions I'm adding so I used the
> hook annotation. If unneeded I happily drop it. I just need someone to
> tell whether that's right and I can't infer from your "my understanding
> [...]" phrasing whether that's an authoritative statement or an
> expression of doubt.

Truly apologies about the delay here Christian, I've been out of
office the last few weeks.

Initially an expression of doubt, but now an authoritative
statement. You do not need your new BPF LSM specific hooks wrapped
within __bpf_hook_start() and __bpf_hook_end(). Those are technically
for BPF kfuncs which are global functions, but are often only called
from a BPF program. The default BPF LSM hook definitions provided by
the LSM_HOOK() macro also aren't wrapped in __bpf_hook_start() and
__bpf_hook_end().
