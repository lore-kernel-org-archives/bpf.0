Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1227B340
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260503; cv=none; b=pSxHoQ5XVXgofFoxYSH8ZPUIabncAMuML2IdaX+dE4KnEHmoO3jfpQJwkDoHv9NFvJJouNr/JwO6Tnl2ei+jmcsABoE09izgirg1Jc49x3pyVtfEVMUWNDUPcGHdOQy1lqcWhBN0o5AoOEB/KyKPASykmD3eytcp+Dal5LwzvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260503; c=relaxed/simple;
	bh=HqCW5FWi/KhI1cW67NbE/stnJeyQlKw/onxUBrFWXH8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWLAaV4kqU9aiV/dH5Vt0vTa7WxsQGGFNLeW+U+MsCo/h0NPFlnPvs5uHaYf3mur43tBluaA52BeQ7Zc+ySpIw37Haf9PT7s5VBCYcTaYvzA5qXcL7r2xDxD+CBm9608AUROgUvnfF0237J4/otDUidX0VKuHF2vA3lJOGgSw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n123dI8H; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n123dI8H"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so105271075e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776260500; x=1776865300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0WIxUwXvq1TJMtV2G3IY+LncqygqvlN3yKS3Eb6wD4=;
        b=n123dI8HqyQN83KD9OpwerE15GQYKLbW/vqbHH1pCW7+UmXreZRRcOkKWz57tbuMru
         RRz2JlqVEYWl7UdjKKDi6AZx0J6+ZNBU7RFaaerzzveXcwrGtkbEu4fAG4zRA17+SLHu
         IWDOGhZJD041gPYeU/ob6SRHdXFWHFmx+UZATVHvTtWzIaA1/QdfSsX+kxTwGrszXRd4
         dMyM5EEBBTJPftHE8YYJ2jIutgFVb4PvAtWV//GeKKmpNLWyYdo4F0W5gQV1cuoUoXPE
         M1WHWigTArLkA18XOxvJfJDq6A7VfKTtepons1JhIAyjGGuZLjE2+ScwpMsof3sJ951O
         J3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776260500; x=1776865300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0WIxUwXvq1TJMtV2G3IY+LncqygqvlN3yKS3Eb6wD4=;
        b=AUXEA6h/Hm1MwQ3Zs1+Y4Vo00jqGr3qOfudD2yMBRCFc5qxdlYedQk8uB4OLi66NNa
         FogJRsUc4vfs3rtSFckqRKni2Dw3/fY1ql3YhRivG5JUTGcAUz9NaiWwhiP02gdEjc+8
         3ycfSn/2FY+4JLweWUXx/MTBYmrmhBuoxKdsMaQlloGv2YOPry4B1TGawMu6deaP1Kaw
         DttGun35BU5t3qkXU/7M5yIpxse33byHXxulUGZhtjjlVzrgObojOKd65WVWtneizPQy
         9R0WjIWnJ1Nsx7a6IVrZGWGTklqEjVXDW8c8HTIW4EMoFPsCTmsYk1OciXXcjOd4Ua6/
         pTxw==
X-Forwarded-Encrypted: i=1; AFNElJ8EnjCI+YT4oU7Wb1V35fqJexglQsMJcl2Q6/Ri/4nWnJ7n3KmxLznUnLG9oe8kndnLHlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98PU2LtduZ7Eu8IX8pudGeOUnjMIeXFY+TDeCScx4VqAk7aKo
	xP0VOFJNVnrBkMdaQEyDXuit+j1zoHzyBX+lbuXAwbEexA93SXrLUTew
X-Gm-Gg: AeBDiev3w+sM6WrEUPSSFBcR/jB7UX8KsoUSUWorjf/tVwHKJPrgpoOYeuMN1EaJgYd
	fsej9qep1vdrECDVBAT6oleytdRLYh9LQrkfjsDaIwzsPbHJSyGpyYK1+hqCBsk6ydzl4MgZzZp
	xw/2eOFhiRNC6CXXTF6pTcTYOKhDmevrVOxXj5vNIeCog0tZvk1oBFxV1HixTbdht3ypqTK6GKw
	G887bvyvFSHvbkw2oGR3aamdkmGvEdj3QwEkxsxPXUnt8UpNN/iw082BkD4evci6WA4Fdq5yBsJ
	qtrm5ZVnTO7aGfUO00M63vvm0xEGVFIzJlWav54Au2vZp8ffcCl0FkgZqboJfdFtSvnylFEG0+h
	FrPKNoB/C6j8zC24iUHqKfbxcYq0B4ff49xFsCpWF6nKm7vlixU1R3vKqBnpk/6+FrSzD+Desll
	n2aSdFfj6JbbEKzhwFclJ4Mg==
X-Received: by 2002:a05:600c:4e45:b0:488:9439:881a with SMTP id 5b1f17b1804b1-488d67bf6f6mr320695235e9.2.1776260500036;
        Wed, 15 Apr 2026 06:41:40 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e63351sm26291875e9.3.2026.04.15.06.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:41:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Apr 2026 15:41:38 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCHv2 bpf] libbpf: Prevent double close of btf objects
Message-ID: <ad-VkutlSgWhW2Rj@krava>
References: <20260415082452.1489147-1-jolsa@kernel.org>
 <3cb314b6-7dd4-4a49-9d7e-5021c7773936@oracle.com>
 <ad-KltDa7xMA1EC1@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad-KltDa7xMA1EC1@krava>

On Wed, Apr 15, 2026 at 02:54:46PM +0200, Jiri Olsa wrote:
> On Wed, Apr 15, 2026 at 12:35:59PM +0100, Alan Maguire wrote:
> > On 15/04/2026 09:24, Jiri Olsa wrote:
> > > Sashiko found possible double close of btf object fd [1],
> > > which happens when strdup in load_module_btfs fails at which
> > > point the obj->btf_module_cnt is already incremented.
> > >
> > 
> > nit: maybe the subject should be something like
> > 
> > libbpf: Prevent double close, leak of btf objects
> > 
> > ...to reflect the leak fix too?
> 
> so the btf object leak is introduced by moving the obj->btf_module_cnt++
> below, because before that it was released in bpf_object_post_load_cleanup
> even when the strdup failed
> 
> now if strdup fails, obj->btf_module_cnt is not incremented yet and
> bpf_object_post_load_cleanup won't release it

nah you're right, there's the other possible btf leak when
libbpf_ensure_mem fails.. I'll mention that in next version

thanks,
jirka

> 
> >  
> > > The error path close btf fd and so does later cleanup code in
> > > bpf_object_post_load_cleanup function.
> > > 
> > > Incrementing obj->btf_module_cnt only if there's no failure
> > > and releasing btf object in error path.
> > > 
> > > Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")
> > > [1] https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > 
> > > ---
> > > v2 changes:
> > > - squashed patches together, because they depend on each other [ci]
> > > - added Fixes tag [ci]
> > > 
> > >  tools/lib/bpf/libbpf.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 8b0c3246097f..79d9607d26e2 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -5806,7 +5806,6 @@ static int load_module_btfs(struct bpf_object *obj)
> > >  {
> > >  	struct bpf_btf_info info;
> > >  	struct module_btf *mod_btf;
> > > -	struct btf *btf;
> > >  	char name[64];
> > >  	__u32 id = 0, len;
> > >  	int err, fd;
> > > @@ -5825,6 +5824,8 @@ static int load_module_btfs(struct bpf_object *obj)
> > >  		return 0;
> > >  
> > >  	while (true) {
> > > +		struct btf *btf = NULL;
> > > +
> > >  		err = bpf_btf_get_next_id(id, &id);
> > >  		if (err && errno == ENOENT)
> > >  			return 0;
> > > @@ -5878,7 +5879,7 @@ static int load_module_btfs(struct bpf_object *obj)
> > >  		if (err)
> > >  			goto err_out;
> > >  
> > > -		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
> > > +		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
> > >  
> > >  		mod_btf->btf = btf;
> > >  		mod_btf->id = id;
> > > @@ -5888,9 +5889,11 @@ static int load_module_btfs(struct bpf_object *obj)
> > >  			err = -ENOMEM;
> > >  			goto err_out;
> > >  		}
> > > +		obj->btf_module_cnt++;
> > >  		continue;
> > >  
> > >  err_out:
> > > +		btf__free(btf);
> > >  		close(fd);
> > >  		return err;
> > >  	}
> > 
> > the err_out label within the loop is a bit confusing, needed more now I guess
> > since btf is in loop scope. only way round it would be to haul btf back up
> > to global scope and explicitly NULL it at the start of each iteration. That way 
> > we could break out of the loop to do error handling. Not a big deal though.
> 
> I guess you mean something like below (untested).. looks better, will check
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8b0c3246097f..3a80a018fc7d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5852,11 +5852,12 @@ static int load_module_btfs(struct bpf_object *obj)
>  		info.name = ptr_to_u64(name);
>  		info.name_len = sizeof(name);
>  
> +		btf = NULL;
>  		err = bpf_btf_get_info_by_fd(fd, &info, &len);
>  		if (err) {
>  			err = -errno;
>  			pr_warn("failed to get BTF object #%d info: %s\n", id, errstr(err));
> -			goto err_out;
> +			break;
>  		}
>  
>  		/* ignore non-module BTFs */
> @@ -5870,15 +5871,15 @@ static int load_module_btfs(struct bpf_object *obj)
>  		if (err) {
>  			pr_warn("failed to load module [%s]'s BTF object #%d: %s\n",
>  				name, id, errstr(err));
> -			goto err_out;
> +			break;
>  		}
>  
>  		err = libbpf_ensure_mem((void **)&obj->btf_modules, &obj->btf_module_cap,
>  					sizeof(*obj->btf_modules), obj->btf_module_cnt + 1);
>  		if (err)
> -			goto err_out;
> +			break;
>  
> -		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
> +		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
>  
>  		mod_btf->btf = btf;
>  		mod_btf->id = id;
> @@ -5886,16 +5887,16 @@ static int load_module_btfs(struct bpf_object *obj)
>  		mod_btf->name = strdup(name);
>  		if (!mod_btf->name) {
>  			err = -ENOMEM;
> -			goto err_out;
> +			break;
>  		}
> -		continue;
> +		obj->btf_module_cnt++;
> +	}
>  
> -err_out:
> +	if (err) {
> +		btf__free(btf);
>  		close(fd);
> -		return err;
>  	}
> -
> -	return 0;
> +	return err;
>  }
>  
>  static struct bpf_core_cand_list *
