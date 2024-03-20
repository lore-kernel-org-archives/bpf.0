Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D33F9D2
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941571; cv=none; b=C27TiHhUYhySBmL2GfPkVAPVL7UV5BPHgeD3FOeD4iVznE1NcXKifIAtYtzuJtjawqIu3c6Pp6FHMd6mSLxoxqlgDCXpgEABPcj1bBCPitvqafCdJ+VOLFV0Lzyo+AJutMsAu54f0fEpOy0ogMCmI4XJ4GA0M2yCx2fIUqvkkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941571; c=relaxed/simple;
	bh=BvnCPYCJKGQyJu06WRoyoAIkHKSulj2oSVJw+Gv6x0o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csxWjyitgWOmIsjn7Z1OcN752reCLb7LI2e+H/miOfwLEA2apeY4ALvaCVxaEzzNtt1BpH+Q1aXLv2PIa/zQ0WBd1nte9qFktyjz6Zdnj5MVtl+o1MLVh7HkgBW4o4vVUy0n3JNSTdPi2n84nntmhqSyriK4YATXA793kmCrwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7wbrBv0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7wbrBv0"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ed6078884so558032f8f.1
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710941568; x=1711546368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUSE53uslP07QsOLGYi/Fa4k8cyZj4pZG6FKCy3K9+Q=;
        b=C7wbrBv0S32IEt8ekVfdtM1YHHh9z0HbCDGYjb7lAcoMfook2PqIUjJC3Fd8mLQukg
         N2jvvRPHP8jjdrN1Zn3oS3jaEClIK73TT/+BDbzPHQZlHvEwnlJ3Zg+yJP/gxyyXXrIW
         Kk3G9b0uyQSBXAmAD0Adr3b2JyTjSXjt73DuR3W9S7EsTnPqSdFjF/5QevrULBdSr5qa
         Uu8tJbWagGwwJsXtGyA+FcwK7W3zElPeoE4vK115zcld9KJ8VKm6+9JugHF7X3UKuG8b
         IoOc4hCvYvLaLyOUSWRsURK4I/bi+mDZSppng9ZDARXzuJudx6AFH7XjE0w0dg2miGV8
         VF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941568; x=1711546368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUSE53uslP07QsOLGYi/Fa4k8cyZj4pZG6FKCy3K9+Q=;
        b=c5iNKiw3/3MePCipAlBEyqszZhiIxy/zNaB069bS5YUFc7Oeyg5vWgksE6kuIIJ0Qc
         Q647mc4bbW/Np0SYybi5spawPQL4krGBmPhDUKy/mBO/vduWd1e8A0L0e27/U/JdJxVw
         8dSlMJrOwD9Wo1KHM6Uawmbw6bKScjogkZlQ5gSK/rbz0pZUQ+5WYxOiiBHA17f3Y5yE
         5Ht7Ui1vaFwX1lSXRBe32d1A1dP8+A6xSfS+id8tYv6krXiYgZS3Bd/7oqfInAgOwNPZ
         f3GrV3BVEmIxu9wqCZgmySClsMfLwV/3tcZKIbod9VYl++XF2WDozNQf+80RWBA2kebC
         34wA==
X-Forwarded-Encrypted: i=1; AJvYcCWRrpm+2i5y2W9oIhMUVnwZ3NtDbL2bgjF5NFDeD//wWt2JF6hMa+oTNz5wPtFJUrfMlz/PBRK2BffxX476MDE1PPp0
X-Gm-Message-State: AOJu0Yy69TSeS7DMBYiOp8he7nX5wmHovDGAiKLI0eo6FT1B5R1e778P
	NURZXTQAmldmrxOYWS20aFzBi2Y/kKjtYo60iAVxRvuRLSsHPubN
X-Google-Smtp-Source: AGHT+IGkk8GtQxOR9T8fx220Dgk0HOJXyJdEVWJU+P31yWljBOdCkpwQ/xZPQ5J3ckBwVk3727UmPg==
X-Received: by 2002:adf:eb04:0:b0:33e:cbec:e98 with SMTP id s4-20020adfeb04000000b0033ecbec0e98mr5186256wrn.13.1710941568178;
        Wed, 20 Mar 2024 06:32:48 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id k3-20020adff5c3000000b0033e7eba040dsm14874558wrp.97.2024.03.20.06.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:32:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Mar 2024 14:32:45 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, quentin@isovalent.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v5 2/2] pahole: Inject kfunc decl tags into BTF
Message-ID: <Zfrlfbe-QOWusrvl@krava>
References: <cover.1710532093.git.dxu@dxuuu.xyz>
 <088c4362fa9f080c319df7c49bc6a4e1b6ae98e7.1710532093.git.dxu@dxuuu.xyz>
 <6c178658-d5b3-4b71-b385-5ba95349c8ab@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c178658-d5b3-4b71-b385-5ba95349c8ab@oracle.com>

On Wed, Mar 20, 2024 at 12:54:11PM +0000, Alan Maguire wrote:
> On 15/03/2024 19:48, Daniel Xu wrote:
> > This commit teaches pahole to parse symbols in .BTF_ids section in
> > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > 
> > Example of encoding:
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
> >         121
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
> >         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
> >         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> > 
> > This enables downstream users and tools to dynamically discover which
> > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > available in /sys/kernel/btf.
> > 
> > This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> This is great work; a lot of steps needed to collect this info, but it's
> really valuable!
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> 
> BTW we need something like the attached patch to switch to using
> --btf_features for pahole 1.26 and later; will I send it officially or
> do you have something that does the same that you want to roll into your
> bpf-next series? Let me know what works from your side. Thanks!

SNIP

> 
> From 2ca37cfa1e9be4f4d9717fc3dc346cdd7c617e32 Mon Sep 17 00:00:00 2001
> From: Alan Maguire <alan.maguire@oracle.com>
> Date: Mon, 11 Mar 2024 10:17:47 +0000
> Subject: [PATCH bpf-next] kbuild,bpf: switch to using --btf_features for
>  pahole v1.26 and later
> 
> The btf_features list can be used for pahole v1.26 and later -
> it is useful because if a feature is not yet implemented it will
> not exit with a failure message.  This will allow us to add feature
> requests to the pahole options without having to check pahole versions
> in future; if the version of pahole supports the feature it will be
> added.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/Makefile.btf | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index 82377e470aed..9694ca3c5252 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -12,8 +12,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
>  
>  pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
>  
> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
> -
>  pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
>  
> +# Switch to using --btf_features for v1.26 and later.
> +pahole-flags-$(call test-ge, $(pahole-ver), 126)	= -j --btf_features=encode_force,var,float,emum64,decl_tag,type_tag,optimized_func,consistent_func

I was testing with '--btf_features=all' but I guess it's better to be specific, lgtm

jirka

> +
> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
> +
>  export PAHOLE_FLAGS := $(pahole-flags-y)
> -- 
> 2.39.3
> 

