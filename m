Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973171;
	b=uR0p+UpQhVvwjI5zFwFvotCPK48XT+VD/zVRthV8ohCQgkdLDfr4ENoQKLNTA6pvU+ch
	 sdfv0CYAnanI1WTLM5s55Y/I6JyFpwvq3bA5JH4JniSthnFWhZ7QK1Q7saTcmp32lRYQi
	 Jw9nwy/Hh2s33i6AgXfky66M0pj86+hzFZPRsMYTJPKTsw8RCe3oaG0CCNtoLW86TEKoE
	 Vvgv9yT/LtwjiACyK7FXCh8MkZG0fXC+kglh+nxalCOCT/QEp4tUMgCjFQTgPhp2LvAje
	 rBdhQZrGb2hJ+d3+F88zn71H2hHtGzf+qpWhUWWc6fUyPai4xGt6Tu/ILJK12z0qmiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PcC4IPdf1ihtWsu+EfJlFBQAiBAyUnEQfCqCotWg6Gc=;
	b=jXpKtjtusn+/HxiZm6dKvcOxHiRd2UUZ1iV9QRByouEOBYVSwwtieH7F10qD2Yk7AvBQ
	 v1PXZUa2tM0U/Jsgi90uNzCKdXkZzMzdp6o7YF3l5J9m7RcqJyQmMwcMzJzrF07nIrKVE
	 TJcLdJxt43zvGsNEiAXMPxxTA4FCPAxGnIwjwTte9JwpgfrRc0Gqo/CUR8fCtpOnMviN8
	 yaTgRR1AVlKTXSKuVbYQC2CV6LGH+mHqhVYAMSiu2ggwGMCvg1AbKX0T2zuckDNfH0x4g
	 2uwluJb9LCRS7KNgiY42rZ5rAwm7p14Fn38RAdbajKNaCN3yK8UjVixz+i7ta9nafAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBFEJUKL;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C22606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 13:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C22606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBFEJUKL
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e47347279so393308f8f.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 05:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793973169; x=1794577969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PcC4IPdf1ihtWsu+EfJlFBQAiBAyUnEQfCqCotWg6Gc=;
        b=PBFEJUKLxuXricYMj+U3UnG32j5Rcsp+vdhlY7xQsRhRCxbtroD4ZRIQlFUlf1NPHF
         dlDcKVVAPMzdgq2Eo/WlMzDXZW6RU7bRf2ibrb3bGlTeqPz0tcXV013Dn4hNVTbo5SJ4
         w8Ap/n+Bic5T3iQigUadZTY1GNVhmZtUa5Oe+JSMUsJyRk19AhXLpcDTSlQJSs+4zoSd
         G6Ko3lYcnXg28xVZIYzq3fMD/sziWcCvOKZ0eQCJ/6HGx+wzCpcoiuZ4mIFhjbyJuHtV
         o+2jQnkqlk6KVMcjjDeCtlJmrKCNsLe1XY4kyLULXirx3i/NBqCZs3Iyx/2s693deZot
         b90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973169; x=1794577969;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PcC4IPdf1ihtWsu+EfJlFBQAiBAyUnEQfCqCotWg6Gc=;
        b=2mu2oKQv3HXUvs7T7S7blgKYi7OMgupxQnoqPhW3gLKSs5sY/Bn5/FNMD18F4BRtaK
         tZlWDW9qI3KCLtspPAceDTnH4PGMFv+/gLAkD2yMud7nNGTkNoAAOrqahzd94Ops3En1
         Q/uZ/QHn39cY3ixKYwAiYGmVbkHb1Cp67bm6h9mwApCTBdp03IRuew8dDUykYAXxJRUA
         TRi/CWU5mdda/L+5tPdmfxvgBgxUA1VADtIuwf1eLvf2AoK4D0k/8Jq74pBEQxk41XmI
         Cdch307DRIAuOzjh8rw2+H57LXk08P2GkRz/Wz3kw290UQK+dIZUFdOoSb2RnnjM+NC3
         711g==
X-Forwarded-Encrypted: i=1; AL+hErGMNjpYq/aixiqtgS1o1CHG1VWW/vQGkRXCKfDTAHoBMTkBH3nXK2I7WTTO+qVBFIGH7qk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PZZrNhMK/BxwLZ3XXFlaaNGU4QBDCAUgoH7Qb/bOywcmzhhT5
	XGBdHzQ0u3oNHHprPotDv9O91q2vIDBvssueXr/Wz5IjQvftRHEMHUkw
X-Gm-Gg: AYBFou13ZxaKZMc9uz/I0NCHd4VIbO80xlJ5HXJxzgKdP7aySdS7lVOvaC/biTAUwK8
	aH+pQPqre2SFa4ItsNQZOboSDGf759Bveoo51tDgcGby+op4+xkvYwlcjpesoAOoU8+Q3+6avRJ
	hsXftMN57c93K0iZA7a/VJhYFrUjIZXlVh3ALjDT/f7811Z8RZ4jp/f4D9dkFyF0jAFw3+JApa1
	thlqkSS1LaexpKf9qsO8KAmXNBNdX6lNryg0hIwENhDK70b2TQ22Sp1j/ZU/8MiioUS3cftypZs
	51kh5nlxEKpAQa4AXPg5+K56It36fP+TRaViKvQOY00AAYwb7jrsly00D9hKTDyewO+KDfNtW6Y
	2tc3e3BaLEEd0ye5kDMX2tsR/pL1wlPEroOjK3Jx4AbeG7oebMHPqqVjfgFWzfEfPy7Sh/RMnt2
	2Pb5qb8+RnhPGo2g+UshUkd8khpgbI4wRTvp9rOqijCKxpOXRJiIFL0TtQ4GTwM6zU0n5MZkfz8
	bqPCK5k/mqfrPt3GEJgLZURU78QeaEeixSeHgCmByoLacVOD/ihCjKYJqWjFkmlBOhFQPOis6lY
	yvTkA/yAnWpVwL0=
X-Received: by 2002:a5d:5c84:0:b0:48c:7386:af18 with SMTP id ffacd0b85a97d-4927b092b8bmr5141147f8f.8.1793973168740;
        Fri, 06 Nov 2026 05:52:48 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7701bfasm3877363f8f.40.2026.11.06.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:52:48 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Nov 2026 14:52:46 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/8] bpf: Honor const on generic kfunc memory
 arguments
Message-ID: <au3brpNZG2nANnha@krava>
References: <20261105102343.311331-1-jolsa@kernel.org>
 <20261105102343.311331-2-jolsa@kernel.org>
 <CAEf4BzbdBLb1cBeF0an386k=CmMYKdz=Or5mSjzy_F5SFOwsxg@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbdBLb1cBeF0an386k=CmMYKdz=Or5mSjzy_F5SFOwsxg@mail.gmail.com>

On Thu, Nov 05, 2026 at 04:34:44PM -0800, Andrii Nakryiko wrote:

SNIP

> > +/* A kfunc only reads through 'const T *arg'. The compiler enforces it. */
> > +static enum bpf_type_flag kfunc_arg_mem_flag(const struct btf *btf,
> > +                                            const struct btf_param *arg)
> > +{
> > +       const struct btf_type *t = btf_type_skip_modifiers(btf, arg->type, NULL);
> > +       u32 id, ref_id;
> > +
> > +       btf_type_skip_modifiers(btf, t->type, &ref_id);
> > +       for (id = t->type; id != ref_id; id = t->type) {
> > +               t = btf_type_by_id(btf, id);
> > +               if (btf_kind(t) == BTF_KIND_CONST)
> > +                       return MEM_RDONLY;
> > +       }
> 
> quite weird implementation, skip modifier, and then re-walk
> modifiers... while not have a loop from t->type while
> btf_type_is_modifier() and if you find btf_kind(t) == BTF_KIND_CONST
> -> return true?

the intention was not to introduce another helper with modifier
classification, the tradeoff is 2 loops [1]

jirka


[1] https://lore.kernel.org/bpf/DMLRV3E28SC8.3FJZXLBLZI4DD@gmail.com/

> 
> 
> > +       return MEM_WRITE;
> > +}
> > +
> >  static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
> >  {
> >         return btf_param_match_suffix(btf, arg, "__k");
> > @@ -13618,7 +13634,8 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
> >                         PTR_ERR(resolve_ret));
> >                 return -EINVAL;
> >         }
> > -       *arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
> > +       *arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
> > +                   kfunc_arg_mem_flag(meta->btf, &args[arg]) |
> >                     (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
> >
> >         return 0;
> > @@ -14170,7 +14187,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
> >                                 reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
> >                         return -EINVAL;
> >                 }
> > -               arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
> > +               arg_type = ARG_PTR_TO_MEM | kfunc_arg_mem_flag(meta->btf, &args[arg]);
> >         } else if (btf_type_is_struct(ref_t))
> >                 /* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
> >                 arg_type = ARG_PTR_TO_BTF_ID;
> > @@ -14195,7 +14212,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
> >                         return -EINVAL;
> >                 }
> >                 proto->arg_size[arg] = type_size;
> > -               arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
> > +               arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
> > +                          kfunc_arg_mem_flag(meta->btf, &args[arg]);
> >         }
> >
> >         if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
> > --
> > 2.43.0
> >
