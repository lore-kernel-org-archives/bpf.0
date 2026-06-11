Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32223AC0C0
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170662; cv=none; b=VzExvtiJoRezZEdUHjKWbWBLbiQib/G0ramr5TOK5XK0EitWq5whhoXtIQ46MiUdXbREYRngcFTSUC4VU30wADMCCektOC65Ztd33aN7WUzxr9fjJGFvM2whGzNf/JL4lMPAnzfWS44Zm2hbAsWbRYJZGLIcXa5mjsjNx30s0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170662; c=relaxed/simple;
	bh=PU98PknZMnvOtEXRkJ7cg9UcsU4aKjZWeVdvA+PVoXU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp8hBugq9da5Ri1zwKf57Erwc8hiQ8zxNYB3iQCdhqPXwJE792IgdDsb5bg5tuwgaBx1qa8i2mte/AUFTrOSNDL6ZeHrf4tb1f8ET1LnH/xcR2eSo7pOlOkU1AxbaD22EidJyWxRr106Ody26/3eZp+Zo4iWZCgVXYPBC3ueMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF6gOWt9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF6gOWt9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b3e03939so5816145e9.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781170659; x=1781775459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zruVWqFGgpp7NEcooTDP5im8iVaG/yBcmkbIj0gbxBg=;
        b=NF6gOWt9CTRMsaPNeyenYlkhEr/0A2yBj4B2zsERs3fUajCDKgxNosI+cPnXBFkKbw
         mk13eJRK1x4OxtGob101ngwiITGUE7NJJgeFm0AAv+Rs8UINOOk9d18clR0LFQMCZyk4
         8RHoLZX2e3NWtECrj7MGugJffDQHzx0k4Nu3LsrCJWe3RXLPKB1VDc6vHspnuDr19ulw
         B6E+8sn7x7sjP2nW2KVR9dzqqyIuASv/zphiNNAzJI0Lmv0j6duQCFEG/VvnJ0ugxtvP
         /3dJdx5Eq+98h/oFfFu1QKS28QRotNl5cbnT6J3gIG2vZ2gMGv21ftsWpgplZEYW0O9K
         p4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170659; x=1781775459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zruVWqFGgpp7NEcooTDP5im8iVaG/yBcmkbIj0gbxBg=;
        b=UvV/DrAe1HvthLyGjMhMz77LOuE148eOXO1U8UjnIY0et9NsckIXmd0YLtQ3UZbBBc
         bjgBcroTXzKwGWT1bOX6p1suApG5cEYTNAbe4QQMoCHKkQcKu8lfQHEDDj0+A+4fpA/F
         o+vfeln8AHhCAvjHR6iDNXk8eYTrLmUIXoTPQLEsRjOABi8rcL8CGwTtalBW+pO8uSqe
         ch8nxeOYihX5tcWvkgj2OKSuLFWJNLrDMxWMpkv2wcieQDVYVM0txp0+p0e0DY/7E3WB
         yaGxiJUfHlSyEKj1XpcaQO4jn/QlT3g41hmAaimVxLBhQGwZhC3XPltcI1abwlKMPkUZ
         Ning==
X-Gm-Message-State: AOJu0YzuMWofqQgKNNACHI7Jtpiz9ZFMiqlDE5e7DzyVePb9cr7IGoLA
	GlFUg2OjXUsnP7A6u7UampGJRwPjCahBC9q9EbaoVklnpzC296JkI+U1
X-Gm-Gg: Acq92OHmp1RfS6hosGkJVTj3Tsv+D2ADEsQCgJTHKRR66l6NNliXfJ23Dt6uWcLsBHU
	0tCnCgJb7CiRoi5jwOwPctueg3bYzo3PJWXa5/KwIkgneynORNasp7fBUhiucP07nAToAtxM2vg
	SNB3q7rrX/AIh5TYVZG0zmn5BBP70qYkrOPh1V7PLtVfzl1HMWvHltBidrga8sA86ezNHthA4zS
	Ym8hMwF5Es3PLp/8Stst7RaD3Z0yBMlg+RlIJUeOEa2NI7i/rw5loLoFoGMHvvGryCM8ryZybUN
	LxBGsnPFqg+x00ux1BE0iCUX72CnoiA68j4kgf1HfDdcbs6R5MKkAKO7DxIDf7vSR4tfAlFMMEe
	TtYHI+iTY25GdOTuXxX0NMryEsBeoogMyPw2jKjAaG4aNJRYzg52Nv5tpjWxGZDZFuSgXy+4edn
	311E9ImNMyqw79F1oh24inxfr83w==
X-Received: by 2002:a05:600c:4f47:b0:490:b26c:64ad with SMTP id 5b1f17b1804b1-490e52d5bfdmr20909335e9.5.1781170659085;
        Thu, 11 Jun 2026 02:37:39 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52acb98sm37556865e9.5.2026.06.11.02.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:37:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 11 Jun 2026 11:37:37 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/6] bpf: Use user_path_at for path resolution
 in uprobe_multi
Message-ID: <aiqB4eSTxR4Aw9YJ@krava>
References: <20260610143627.804790-2-jolsa@kernel.org>
 <20260610145235.CB1441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610145235.CB1441F00893@smtp.kernel.org>

On Wed, Jun 10, 2026 at 02:52:35PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Missing `access_ok()` checks before calling `__get_user()` on user-controlled arrays, leading to arbitrary kernel memory read.
> --
> 
> commit e18574361f20d4f27005e4d927610e3ce16986dd
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Use user_path_at for path resolution in uprobe_multi
> 
> Resolve the uprobe_multi user path with user_path_at() instead of copying
> the string with strndup_user() and passing it to kern_path(). This removes
> the temporary allocation and keeps the lookup logic in one helper.
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 90432f0fc2a8e..970ce7bbf99e1 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > @@ -3261,14 +3260,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >  	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
> >  	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
> >  
> > -	name = strndup_user(upath, PATH_MAX);
> > -	if (IS_ERR(name)) {
> > -		err = PTR_ERR(name);
> > -		return err;
> > -	}
> > -
> > -	err = kern_path(name, LOOKUP_FOLLOW, &path);
> > -	kfree(name);
> > +	err = user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
> >  	if (err)
> >  		return err;
> >  
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but while looking at
> bpf_uprobe_multi_link_attach(), I noticed the user-provided arrays
> uoffsets, uref_ctr_offsets, and ucookies are accessed shortly after this
> path resolution:
> 
> kernel/trace/bpf_trace.c:bpf_uprobe_multi_link_attach() {
>     ...
>     if (__get_user(uprobes[i].offset, uoffsets + i)) {
>     ...
>     if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_offset, uref_ctr_offsets + i)) {
>     ...
>     if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
>     ...
> }
> 
> Are these arrays validated with access_ok() before __get_user() is called?
> 
> Because __get_user() bypasses the access_ok() address-space bounds check
> on most architectures, could an attacker supply kernel addresses for these
> arrays, causing the kernel to read arbitrary memory and store it into the
> uprobes structures?
> 
> If an attacker retrieves these contents by querying the link info via
> bpf_obj_get_info_by_fd() (which calls bpf_uprobe_multi_link_fill_link_info()
> and copies the memory back to user space), could this act as an arbitrary
> kernel memory read primitive to bypass kernel lockdown and KASLR?

ugh right.. will include fix for this in next version

jirka
