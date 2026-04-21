Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117DC3A0B28
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761826; cv=none; b=k21m5mympRWUsWzXgTvcPj+wB/tL9XZhAuzZv765UlUH3dxjNEPFoseFh3RerhewRPutLWjz6rMsj1cb4sfc/YxgOljDI44wS4obccBs8Xyyqppe+kVVYqh99rW1vXYNe1SqSAp05YRjG/Twx/cHPAdUQA83m1pl9t0UVympQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761826; c=relaxed/simple;
	bh=YhhKLVlExyHu9gTI5L3me4ZM92CjUFVISAsru3rLJ7o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG2EFe9SPIfbdcHXZiOy0t8RK9zp5wBHTt705+2TmM5MKRgQM0ts6sDEMEA7DltnUIk+OZ3hsp4X+xdT2p7z4Mj90e3APxvnhrdYqTp67ghDDjKIvM61lWZI4ueJdxZwbuIVXF/FqCvEkvz0x6MkFf9FNGdO2PCHd2klSWQ9+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc2jSmN+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc2jSmN+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso33793605e9.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761823; x=1777366623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc73l71e3hXsyQlWSmmk+NuiKjw5DN2kEURVB/luzrg=;
        b=Bc2jSmN+n+E1aZ7Trjs3K6z3fuRR5vLqri5q2JTDM8FZRqT9o91s58p5Y1DD4sLKOh
         NR51hq32pxtzpDVFI9qjN534ks8SFE83OEaIpG4ZmVHI0kdFd402wMR3V/pl1pzryPAn
         fI+vNHBBzM9E4cDziNhiBtDeVGFu7k+FvHtMx92RhNlQQU4CFR0L65KJaYQx8axXlaQR
         1eEK5Pr4JWgknI5dVeMglLHGQHcClUe9BYD19ytNsZBs4kK6knKNBXQq6lQk6nj/hbUs
         3dOo53XI4OuafD41AgKpqfgDcmrMMmA8sYtRUjEM+Xl0nWCqFuWIcV1nCY8M2kfhaUZF
         opRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761823; x=1777366623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc73l71e3hXsyQlWSmmk+NuiKjw5DN2kEURVB/luzrg=;
        b=kCHgRp3owJ6u80Q15WhgBiBvJ0Jjb9PiNbsp4BR+Z2c9+yqqx+q7axriFuF8rJg2XW
         HQo2oikkSG9frK/m/ry/ttsXGGFGq64GCCQwYBR1tSWTo1KUDjCle6IyI47rEYN6OH0I
         fqysscoy372Q/4HcIFuXvE8EMNfRohRKGGzenESIHnHuybNbJTr9MCM93ziVnkVIfZIC
         9lvD+iyj+sOeTvv1rEAhbUq4fS3KV0c+FKdlDvL+zCOZ9aTwdN/JXXRX/o+/PkYokgdq
         sXyCr0iP46cEI/2+kRsZq+JPKs2/IPkV5matFRwAqYHFXdRgkZ2XzE0z04fgx5tekpD6
         xo1w==
X-Forwarded-Encrypted: i=1; AFNElJ8zc0I8PME6h1vw20VKWuoNabAY57suKBJOPoY4x+m0JouqKUrb2/XJ7UjAvtQ5IwJEBDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LK1N0efEBIgaSV7LzUVnCJbjPuEqB2Z2ES6l1Ndrh1vYJGoV
	qctlnuhLzTnqIXnsJXTzpUGm1Qv6YGj4OM4LyDTNPINBEGAGTJm5gQbq
X-Gm-Gg: AeBDietORVfa2E1HBZ89dQgpdIJ+xJgTtFTxc5lFu1TmBN+m/u08UDewE1n73ardb5Y
	1Z98bh+gAlJ1CA/7dFFNnc0TMHCkbKwSlX6KFYg6yxCikS5FaijSpefslyJt9hETvd/2+9sTeI6
	k4ewlH5v63oTfNsZwrMt5dK1G/IhVw1L3ED9pZLiwvi385oL6lxiRD0AiaCI4ffHS2CFwsXhWen
	RX7BFKrQ89NykKAVlx0IAzfpqyDZxm/dy38/ERmxlZSoPqWu7rbD968LUZwQLNjm78Ww5OHv4Tb
	76VuWPS+MUTdxXx//FcXetnavEK+H3xnqH9LP34FkbHEyORmH0UhuCoLOnA3YfBeRMqDE2MRKdp
	OBjzaK2vZAqYI7QFSzfwThJnTDT/uWhRkyTEgcXkU8m1SLIBZbFXswkytr1NT+ZYT9t61s/hJV0
	BbclpPPuRINqRobRubHQ==
X-Received: by 2002:a05:600c:5285:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48a53338269mr69880745e9.15.1776761823397;
        Tue, 21 Apr 2026 01:57:03 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891bb3d121sm243294425e9.14.2026.04.21.01.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:57:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:57:01 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 20/28] libbpf: Add support to create tracing
 multi link
Message-ID: <aec73QrMf0gGzjk4@krava>
References: <20260417192502.194548-21-jolsa@kernel.org>
 <658609fdf8d0b9ee59a5a516fd7dd2460ef7cb52b9fca779094dfb761e43aa82@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658609fdf8d0b9ee59a5a516fd7dd2460ef7cb52b9fca779094dfb761e43aa82@mail.kernel.org>

On Sat, Apr 18, 2026 at 06:10:58AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 49368ee161b1..9bf7e8754c7b 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > @@ -12510,6 +12592,197 @@ bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t
> >  	return true;
> >  }
> >
> > +static int collect_func_ids_by_glob(const struct bpf_program *prog, const char *pattern, __u32 **ids)
> > +{
> > +	struct bpf_object *obj = prog->obj;
> > +	const struct module_btf *mod;
> > +	struct btf *btf = NULL;
> > +	const char *sep;
> > +	int err;
> > +
> > +	err = bpf_object__load_vmlinux_btf(obj, true);
> > +	if (err)
> > +		return err;
> > +
> > +	/* In case we have module specified, we will find its btf and use that. */
> > +	sep = strchr(pattern, ':');
> > +	if (sep) {
> > +		mod = find_attach_module(obj, pattern);
> > +		if (!mod) {
> > +			err = -EINVAL;
> > +			goto cleanup;
> > +		}
> > +		btf = mod->btf;
> > +		pattern = sep + 1;
> > +	} else {
> > +		/* Program is loaded for kernel module. */
> > +		if (prog->attach_btf_obj_fd)
> > +			return -EINVAL;
> > +		btf = obj->btf_vmlinux;
> > +	}
> > +
> > +	err = collect_btf_func_ids_by_glob(btf, pattern, ids);
> > +
> > +cleanup:
> > +	bpf_object_cleanup_btf(obj);
> > +	return err;
> > +}
> 
> Does this function leak the vmlinux BTF when prog->attach_btf_obj_fd is
> set? The early return bypasses the cleanup label that calls
> bpf_object_cleanup_btf(obj). Every other error path goes through
> cleanup, which suggests the BTF loaded by bpf_object__load_vmlinux_btf()
> needs to be cleaned up before returning.
> 
> The design pattern here is that bpf_object__load_vmlinux_btf(obj, true)
> is called specifically at attach-time (after the object has already been
> post-load-cleaned), so obj->btf_vmlinux is freshly loaded. Skipping the
> cleanup leaves that freshly-loaded btf_vmlinux attached to the bpf_object
> until bpf_object__close().
> 
> Should this be 'err = -EINVAL; goto cleanup;' to match the other error
> paths?

yea, should be 'goto cleanup', will fix

jirka
