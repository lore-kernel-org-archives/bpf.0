Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC99463
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711913528; cv=none; b=lnUcOCnNiyczl0Gm6iETgySPXMNLI29byI2Nq7hG3yYZwsskdAF+azTmMYxRMh+z8XtXNWR+DvnaUwA1gJkA7tp1VWYCvFtrRMgOL7QtpQ8P6pcfOMNnEZTjgDTR02cQZov/7WT6wCAY9KEXh75ZNpn3KXudaZLwiV1sIwJtB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711913528; c=relaxed/simple;
	bh=DR4PdXf6v6kIt30HN4ScBj02IhwqckXL6wI5NRXnhq8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAs37FtpB2H2y9OgpSOGPjz+49LW2r6k4b9iSF8v0USmVDPlOjKwrDAxm9uyqkFf1+FAhVHli0IbwXZMepLyGAPEN7l0wKTAxtLXlVv9xIHYks35FKPjqRa/mlyXgJ4K9SmZedPJDA6By1k29ajPrNNr2DRbDWvR85IAV7Ax87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Voy+CZSS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Voy+CZSS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-415649984c6so2027265e9.3
        for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711913525; x=1712518325; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bStw9VC/7dF2VsZNDTWp+aPn1A9Np+5C/xD4gM3V0JY=;
        b=Voy+CZSS2dC3yo7P1+8a2w+WINm6esdoJGIj3XGjW5xxYx4yUyJRvCvwJPejcpnA4j
         PyjQVAFtPeL6LxOOmC8uBnPwyMdvkBOUb1Ku15ZoZ4/7sR8nzbTcyj/nO4lxCl/QPz/U
         ag3ohh3uq8SoI4ybLIRJw8IQYWQS3iglbj+3Pdbp8s+QVDIXaRtezeYdDEx6Xg8C5OXa
         GesdWwn9EJwpeuoGbBsrDdzMuvBpWF6Cj+t0SUGx6UkhD0bZ5WLHnzzvwPXArA3iVpH/
         KSCZ8bht6BzYrpFC9tjVlwmFfPXk9KD01VE2e/PLbmU2TvRNPdr4XDnNnUg+JMeNidQ+
         o8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711913525; x=1712518325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bStw9VC/7dF2VsZNDTWp+aPn1A9Np+5C/xD4gM3V0JY=;
        b=O8h/GuiW0lgl+xhVwE7UODM2I4FBvA9zW5l+6t+QhEggnZL2Xh3N6TDCbp1FosmOrn
         49yqMFHT4TJssvWmZUT4w0zSsU4efUDpgAiTbWgmZEjNUbkbdZDj/ipONuKF6fV1572Z
         ZPKJPMjcJ9i6SIgibR+mOLhAhZKEEz+YAj6ckQhVV/Zo3ZOqXAyPpJvETIkjA+BUGWC4
         tRxDScdUz+VzifpJQhSWwddYN1xDFasSB9WVVRFoZD7rlR8Hu+8Iq0eNzW0JwHJ8cb/T
         bmBHnXjR12Q7GDDBKJznuaBA8qSlNwcb4F6lahVIua3viz937nFwgsPLm6ruDjcUy88Y
         uCtg==
X-Forwarded-Encrypted: i=1; AJvYcCUTKLMsZYpdqpcsbSZUOEeGFu1N9Vqx8gL5Ka6crck/oA7uPkl2wzbT2SolJxzMoW+6d7tRLF67JfaCPYrT1Q6Voz9A
X-Gm-Message-State: AOJu0Yxf/l0TYgJTZfcEWWqYpM5VKv1q14TVW5f/467wafqhHUwX8gbN
	4qfUD6ypLYoVTPFnFRrBjjQOhPEonmQFZHDYqcfFz8pIQbuBc3dA
X-Google-Smtp-Source: AGHT+IEs9D9yRpz/GxVwYv/UPTNOxaf2niaV7ysphXDXSPoQn43A8A+eBOIgSiBIukVYQeLypc1NCw==
X-Received: by 2002:a05:600c:1f94:b0:415:540e:74e7 with SMTP id je20-20020a05600c1f9400b00415540e74e7mr3872650wmb.16.1711913525287;
        Sun, 31 Mar 2024 12:32:05 -0700 (PDT)
Received: from krava ([83.240.62.118])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b004147b824b08sm12481400wmo.7.2024.03.31.12.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 12:32:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 31 Mar 2024 21:32:02 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add uretprobe syscall test
 for regs changes
Message-ID: <Zgm6Mjg0Ke8BaEBA@krava>
References: <20240327102036.543283-1-jolsa@kernel.org>
 <20240327102036.543283-4-jolsa@kernel.org>
 <CAEf4BzYXFX3Mx+3Z2BLHrUw5dG7qaz7R2Tfc82R+OMhT14rDBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYXFX3Mx+3Z2BLHrUw5dG7qaz7R2Tfc82R+OMhT14rDBg@mail.gmail.com>

On Fri, Mar 29, 2024 at 03:34:00PM -0700, Andrii Nakryiko wrote:
> On Wed, Mar 27, 2024 at 3:21 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test that creates uprobe consumer on uretprobe which changes some
> > of the registers. Making sure the changed registers are propagated to the
> > user space when the ureptobe syscall trampoline is used on x86_64.
> >
> > To be able to do this, adding support to bpf_testmod to create uprobe via
> > new attribute file:
> >   /sys/kernel/bpf_testmod_uprobe
> >
> > This file is expecting file offset and creates related uprobe on current
> > process exe file and removes existing uprobe if offset is 0. The can be
> > only single uprobe at any time.
> >
> > The uprobe has specific consumer that changes registers used in ureprobe
> > syscall trampoline and which are later checked in the test.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 119 +++++++++++++++++-
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c |  67 ++++++++++
> >  2 files changed, 185 insertions(+), 1 deletion(-)
> >
> 
> LGTM:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]
> 
> >  BTF_KFUNCS_START(bpf_testmod_common_kfunc_ids)
> >  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
> >  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
> > @@ -650,7 +763,10 @@ static int bpf_testmod_init(void)
> >                 return ret;
> >         if (bpf_fentry_test1(0) < 0)
> >                 return -EINVAL;
> > -       return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
> > +       ret = sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
> > +       if (ret < 0)
> > +               return ret;
> > +       return register_bpf_testmod_uprobe();
> 
> nit: keep using the same pattern to make adding more actions easier in
> the future:
> 
> ret = register_bpf_testmod_uprobe();
> if (ret < 0)
>     return ret;
> return 0;

ok, will change 

thanks,
jirka

> 
> >  }
> >
> >  static void bpf_testmod_exit(void)
> > @@ -664,6 +780,7 @@ static void bpf_testmod_exit(void)
> >                 msleep(20);
> >
> >         sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
> > +       unregister_bpf_testmod_uprobe();
> >  }
> >
> 
> [...]
