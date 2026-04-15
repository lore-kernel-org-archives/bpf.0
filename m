Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD681DE894
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257692; cv=none; b=g/XBZBQ3+UkImzHxg7SCwX9RJBosT0jOGmNfbAzNVgMB70q8A+tKjUg8VO6jy1QhVJ85Jtjed1eN7M9wz8Xe7hjeMayYbQUmymFGnVTCSFMdwDUApQyh25UpMx8z9X70BkRnODFNOFhyb8Djl+0pv1ZfyCIucoaNWfC3bcf1jV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257692; c=relaxed/simple;
	bh=UBm5duZotiH1dCT+9iLudUQTbkbjRpMAtnKj/RNYO7o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8AgbpXmb8lIglIBFDi/Pph9tpHTOZsTm3u61oXlV6F4SUdwRJu4eW+0gtTkPNL6SyJX2N2KoI8PjB/wlJo2pJUK+uv3zeG8Yb/4AH6Mm8gBcYtmzK/CQKJMa7eOEgkprrTYWhW+GIpow51TeYGb8Xk2OGxGV6nEJyXDdCzAOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d62NeO5z; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d62NeO5z"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfce3a195so4205502f8f.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776257689; x=1776862489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnE/seawMs4tAhMl+l9eM5XewVHij4Y86ci6Osr1d/Q=;
        b=d62NeO5zBAz5WOCvofEJRyWuoxo4wKeVQ6TJrX89YC3QzDEVXBz3hKPX7VJSUZfCwr
         xI2MK7NeX8r0iB4lVhpYmDykCtqMymJob1elUgSedQ412azfLjzIanHMm82qq1bWEdJg
         vOKv8BzqtOfUJCbuapAOcjcsTUggJ9YnGwS10REtajD6LXTnNhKJ5l/BvCqM6d9sgiyO
         ssPU/GIKca/bw8HX8VL4fp8HKLr3sVnFNjee6tJbNlqkdf3OmeFjGWMMTqTAdltkw9rc
         0/GJWMVs9L5GiLujEZmjoqTi+qAgjHmo9ufFrG6OSDpdDkkV2oKPS5vXuwbQUlLTpAqU
         vWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776257689; x=1776862489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnE/seawMs4tAhMl+l9eM5XewVHij4Y86ci6Osr1d/Q=;
        b=qsJw/YH5zjQ4SsPlKYFDIlOJjM7chgiUMzdW6SbIJQfUTkUhgyM55Z4QPkRj+kXyfR
         XHk2VXAVrQZlQZyd97BI0i8UMgivdUdWZJYxv9HIvmIi7jy8IdSa2mW026R3tltFFG1E
         UYsaFula+dtmog8uBcvGi8MkK9RQJKjuD1rUhRmvXwyUZKzwbwTs1Mgvr/PL6r+iWpCz
         d8bxlhDtmFI89G5HngEBqt/yCD5it8SIcApxxf1fSPZ6V9vJgoakRUIjeI/vqSPMcZD9
         dOZ2hzQDbs7PZ7VrSBaDRK6WhXn8G+1yqPe/tAo2LK1i/gQLHHwEGcpBNrvTmqMNUw8o
         /XGA==
X-Forwarded-Encrypted: i=1; AFNElJ+9mUyLF+rTRY4ue6Er2Dial4dLVLIHoC5+vjWZukmagMNsfcYezYmiWibmOAeesfJc+t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVx6SYTVsoWF353FO+iIs2kw5cMmtrrh3lOt8BF4jobddoBwuJ
	+QRS+8pf+XcP1GrGFtWG1bSZQdYQQKW/ILpS58mza1Son1bu0c5EN68A
X-Gm-Gg: AeBDietAtRRtzbWAJXnDpEc76Qbeh1Iub03tlgvgd0/fKKCbQGaWKRLw3Ap8RdaD8j9
	moM78y63ERZjCWZIf5Tt2ueyG5NK/WEDbQANv1KxIGhIj69CkrbBjUsKyV+aLz6A+QfS/4sWE44
	wdSIA7W5gasXkpLXegwnx8bynLyaVXqeT2UbxIX/WFyCcoDT5fk8pb3zZSykZZOqfB7pIf6BQl+
	doVCa6dlmSmkwMMYvsxdRZGfnH4NFqkHd1xGbYpyCFJGohpJPPz95FqhX6DinyEzEw/AjFHBeXT
	9I6gd4a1GbBPg7JTFgR9mfHKgtXziPJTmOK7wPzue9UJmIR63yjgxHSGAdEs9UeUrKuGEZnZ8kd
	cZ498FmV0ISdTI/QxRavSIFq31eWthTu3UQFRF/4EWzEYsgFMlTasqbPhbmXCuIGSn5EJqlVlTY
	E5LdxeOzE=
X-Received: by 2002:a05:6000:2c06:b0:439:a95b:3c43 with SMTP id ffacd0b85a97d-43d6426b475mr32714440f8f.21.1776257688798;
        Wed, 15 Apr 2026 05:54:48 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3564d8sm5581124f8f.10.2026.04.15.05.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 05:54:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Apr 2026 14:54:46 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCHv2 bpf] libbpf: Prevent double close of btf objects
Message-ID: <ad-KltDa7xMA1EC1@krava>
References: <20260415082452.1489147-1-jolsa@kernel.org>
 <3cb314b6-7dd4-4a49-9d7e-5021c7773936@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cb314b6-7dd4-4a49-9d7e-5021c7773936@oracle.com>

On Wed, Apr 15, 2026 at 12:35:59PM +0100, Alan Maguire wrote:
> On 15/04/2026 09:24, Jiri Olsa wrote:
> > Sashiko found possible double close of btf object fd [1],
> > which happens when strdup in load_module_btfs fails at which
> > point the obj->btf_module_cnt is already incremented.
> >
> 
> nit: maybe the subject should be something like
> 
> libbpf: Prevent double close, leak of btf objects
> 
> ...to reflect the leak fix too?

so the btf object leak is introduced by moving the obj->btf_module_cnt++
below, because before that it was released in bpf_object_post_load_cleanup
even when the strdup failed

now if strdup fails, obj->btf_module_cnt is not incremented yet and
bpf_object_post_load_cleanup won't release it

>  
> > The error path close btf fd and so does later cleanup code in
> > bpf_object_post_load_cleanup function.
> > 
> > Incrementing obj->btf_module_cnt only if there's no failure
> > and releasing btf object in error path.
> > 
> > Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")
> > [1] https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> > ---
> > v2 changes:
> > - squashed patches together, because they depend on each other [ci]
> > - added Fixes tag [ci]
> > 
> >  tools/lib/bpf/libbpf.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 8b0c3246097f..79d9607d26e2 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -5806,7 +5806,6 @@ static int load_module_btfs(struct bpf_object *obj)
> >  {
> >  	struct bpf_btf_info info;
> >  	struct module_btf *mod_btf;
> > -	struct btf *btf;
> >  	char name[64];
> >  	__u32 id = 0, len;
> >  	int err, fd;
> > @@ -5825,6 +5824,8 @@ static int load_module_btfs(struct bpf_object *obj)
> >  		return 0;
> >  
> >  	while (true) {
> > +		struct btf *btf = NULL;
> > +
> >  		err = bpf_btf_get_next_id(id, &id);
> >  		if (err && errno == ENOENT)
> >  			return 0;
> > @@ -5878,7 +5879,7 @@ static int load_module_btfs(struct bpf_object *obj)
> >  		if (err)
> >  			goto err_out;
> >  
> > -		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
> > +		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
> >  
> >  		mod_btf->btf = btf;
> >  		mod_btf->id = id;
> > @@ -5888,9 +5889,11 @@ static int load_module_btfs(struct bpf_object *obj)
> >  			err = -ENOMEM;
> >  			goto err_out;
> >  		}
> > +		obj->btf_module_cnt++;
> >  		continue;
> >  
> >  err_out:
> > +		btf__free(btf);
> >  		close(fd);
> >  		return err;
> >  	}
> 
> the err_out label within the loop is a bit confusing, needed more now I guess
> since btf is in loop scope. only way round it would be to haul btf back up
> to global scope and explicitly NULL it at the start of each iteration. That way 
> we could break out of the loop to do error handling. Not a big deal though.

I guess you mean something like below (untested).. looks better, will check

thanks,
jirka


---
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8b0c3246097f..3a80a018fc7d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5852,11 +5852,12 @@ static int load_module_btfs(struct bpf_object *obj)
 		info.name = ptr_to_u64(name);
 		info.name_len = sizeof(name);
 
+		btf = NULL;
 		err = bpf_btf_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			err = -errno;
 			pr_warn("failed to get BTF object #%d info: %s\n", id, errstr(err));
-			goto err_out;
+			break;
 		}
 
 		/* ignore non-module BTFs */
@@ -5870,15 +5871,15 @@ static int load_module_btfs(struct bpf_object *obj)
 		if (err) {
 			pr_warn("failed to load module [%s]'s BTF object #%d: %s\n",
 				name, id, errstr(err));
-			goto err_out;
+			break;
 		}
 
 		err = libbpf_ensure_mem((void **)&obj->btf_modules, &obj->btf_module_cap,
 					sizeof(*obj->btf_modules), obj->btf_module_cnt + 1);
 		if (err)
-			goto err_out;
+			break;
 
-		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
+		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
 
 		mod_btf->btf = btf;
 		mod_btf->id = id;
@@ -5886,16 +5887,16 @@ static int load_module_btfs(struct bpf_object *obj)
 		mod_btf->name = strdup(name);
 		if (!mod_btf->name) {
 			err = -ENOMEM;
-			goto err_out;
+			break;
 		}
-		continue;
+		obj->btf_module_cnt++;
+	}
 
-err_out:
+	if (err) {
+		btf__free(btf);
 		close(fd);
-		return err;
 	}
-
-	return 0;
+	return err;
 }
 
 static struct bpf_core_cand_list *
