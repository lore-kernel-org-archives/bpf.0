Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323163;
	b=HCxrclYsoaMVyyNP7Hgh+74tnnhQG/mPAd1ASbKVqltunJ/MoHDHj8sFdjKvYe9aHIlJ
	 pAYPws6DNjTiKjS/0HXKjJFbNQhPGF6o8bpdlWQ1p+RbKS9p213hB9tcyHKK2rwI8Z2Y4
	 Cpd90AgCEkq+QQUehOkRh1JLaQSrHGrRexkjIVisQUMzPp+EYKbQHFKDKyKwyu7Iy0YHU
	 4X8zCwbv/QZD7N9W9lzJ8vSGa2gCxKOGp1X8uVGfQSgS2cFwEO1qNaUI/orUEX8p7MQ2d
	 cVpftvh0rWQLwDgUrEvgeAqYSFO/46UoVnDbQ8PPdkBOHXEzPba6+dV5SkcwZEi85Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3saG5HUhHWIluByVMXbKrM1wtI4RFxTnUgkKyi8UGJA=;
	b=Ys1UH+1deIunxZY4wRwQdqrYIc+cp4dIa0ja76+r9WCxt4sRFPakWIQU2WH0KZPP5i8Q
	 zEf50i1qF7SViicj7c0EJ2vaFdBKNgxa+3GQx4GmfDW3uftctCA9wjczU/YnfeoWaCkqB
	 /t4xIgBCxJvAzJY2JwE9aGyztPkAExyzkOajBNPFb7Xd/vDoosC4KzKtB8A+mbTU17+3Q
	 wzyesU/nDnSIdIqzzyfx98upNX9/pZyRq7a9S/o5jiL8ZxYxWnhriieKOtyyOvZnDNv6B
	 M4e8jWvnq9KS/ie4uyRWSF3Qz33aqLU8VK2glweT7Ta62ysL58FwfNHhKtnfSOXVKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rH6iUK0m;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F026606A320
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 15:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F026606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rH6iUK0m
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so19761215e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 07:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323162; x=1794927962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3saG5HUhHWIluByVMXbKrM1wtI4RFxTnUgkKyi8UGJA=;
        b=rH6iUK0mFxC5SYg41GzhxuYBZQ8ZRWjcSicU/E/P8m8aSt+h7sTRxPQlU8JTL0Htoa
         famV4KvT7Ya1jaQwHxAvdsh11CRH8Q/XH9JO5juaj5mz2Evq6ZMk9IgIxAihrMea3Asq
         sCvgCbdDSpSGwKnDNF3CMg+Tm2RTXJL9oRW1ygHosdHUd2qPHC7/FTPQsMVS7Vy9HBpV
         0vQrH6aVsOxYbV+Fkt/NuCfarezXqfwaaQhGGv8rqo5fRR23K+6KON7mge4K4FLeSQdd
         LoGA3Zjxrc95B1/SBVbXyxNmZimu6JyjE5oguXnc0LmmkSOsHCZc/isFlW5A/KyfRF83
         vvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323162; x=1794927962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3saG5HUhHWIluByVMXbKrM1wtI4RFxTnUgkKyi8UGJA=;
        b=OeKcyW1pHP8oSYjUXd6KBCZd1XOt0YJP9owoFv1UP42TvQJVfr8CyuQNaY/VQcNoOY
         02Caa/saSjBCbcDqqinoeUSXapFHweALRbm3AwA6emPuCD/otlVK4RTSntBhNkp+Kn4L
         Dpji3MF+iBTiY6FoAiFwCsSC3yTMpSgQgBv3MjY4pihAGISNGMWB7Wb3l+88PBRivmIc
         +Y6P7bydtiDlYlPaw219yHlUKmyQu+xLBokXaf3dULa2InOkyrlR1cXDGX+7sQxdiMdy
         C+Aqod0Qy/VmkPQCJwi0wQhtUL3PfSR9wJa7Hx9neENza30cmF0JTKhxUnzt5qP0A09G
         Hbww==
X-Forwarded-Encrypted: i=1; AL+hErE3txHe3RWYZUO7Rv2Fy7qscOQz1Z24IpoO58MpagWinQtDvYxVeEvfeLXNNjBS9uMSCYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cvjMas0KKnwkKIatef6/lRulFdUMmwYam0JyRwa51bWrhl23M
	Sy1u3a7zEYqTj7OycY6wyUDGOsKvw+hLGWQqfIuraLucqY60jS7JTxiz
X-Gm-Gg: AYBFou1afLLXtPGae+0xclzD3GZTz0QELBeer/HUyDSkQxA+5JRz2dzHwA80FTNQH1u
	SuMcvF/smEhlqX3QTLeYIl7lhYyR61Va0Yv1jDU6hRezLba32QroNrMxUsQYvfm0rPXEa3kTlaG
	oMmCo8ylYIkD8TABcGFygS8BLizezw7xYaj8w8/S/N8wfpLqlu1qxgskFPnrBMgP7VAq7RQSP+P
	l5OXb827rIXta17rPPijRoWj59bFINSYbQ86mG8Lqh61UVVN6eEcHJrOXzwP08gRYC+GR/pUOOJ
	RQOFqJJwf5qBI+QOIIrP7SV1UvLfQQvrC4Tq1vmUg/hHfzZ9pC5BaKDl75Luv+8ci42hg1/bXl5
	Q5dz2moDPZax2lxiSu6ZEewQ55nM+4dL+tXLNfjL2zRFY2NikCcCbSpQbV27niOyRXDf+F02zYJ
	jtYxDGut1JoUGqWSU2Bnvn5Tb1tuvd5n9almpsLZSMDHjirnHhTlTr3OXQDRXLfIJ2x/mTafRW/
	hBzG7/lG+zSgrcuUMfGjYRTpG6jBxlwkUsvkozzHyMKuddOQavOQYINT1nKLAkO6iaGUtBwazWG
	5SepTzQWVgaq0+qtgidvwinmICuJpoVn/93vGw==
X-Received: by 2002:a05:600c:a013:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4ba0234a040mr51183875e9.11.1794323161530;
        Tue, 10 Nov 2026 07:06:01 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204342asm80488225e9.6.2026.11.10.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:06:00 -0800 (PST)
Date: Tue, 10 Nov 2026 15:17:30 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, almagui@kernel.org,
	john.fastabend@gmail.com, qmo@kernel.org, brauner@kernel.org,
	kpsingh@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, sashal@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v2 bpf-next 15/18] resolve_btfids: Tag fmod_ret
 candidates as targets
Message-ID: <avM1isGoXgAv47ml@mail.gmail.com>
References: <20261109170550.141443-16-a.s.protopopov@gmail.com>
 <069d59babf1ed531e1a5c1bd4ec0a943f7e8f12fc1e18f0ccc8b4edd032974a0@mail.kernel.org>
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
In-Reply-To: <069d59babf1ed531e1a5c1bd4ec0a943f7e8f12fc1e18f0ccc8b4edd032974a0@mail.kernel.org>

On 26/11/09 05:42PM, bot+bpf-ci@kernel.org wrote:
> > resolve_btfids: Tag fmod_ret candidates as targets
> 
> TL;DR: resolve_btfids may tag KF_IMPLICIT_ARGS kfuncs (e.g.
> bpf_wq_set_callback) as fmod_ret targets; the trampoline may then clobber the
> implicit argument, and the kfunc could dereference a garbage pointer.
> 
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> 
> [ ... ]
> 
> > @@ -1841,6 +1888,16 @@ static int btf2btf(struct object *obj)
> >  		}
> >  	}
> >  
> > +	for (size_t i = 0; i < obj->fmodret_retvals.cnt; i++) {
> > +		const struct fmodret_retval *retval = &obj->fmodret_retvals.retvals[i];
> > +
> > +		if (has_set_func(&ctx.fmodrets, retval->btf_id))
> > +			continue;
> > +		err = add_fmodret_retval_tags(&ctx, retval);
> > +		if (err)
> > +			goto out;
> > +	}
> > +
> 
> Can this loop tag a kfunc with KF_IMPLICIT_ARGS as an fmod_ret target?

Yes, looks like you're right, thanks. Will be fixed.

> 
> The kfunc loop earlier in btf2btf() has already rewritten the BTF
> prototype of such a kfunc through process_kfunc_with_implicit_args():
> 
> 	t = (struct btf_type *)btf__type_by_id(btf, kfunc->btf_id);
> 	t->type = new_proto_id;
> 
> so the BTF FUNC no longer lists the implicit arguments.  fmodret_collect()
> ran before btf2btf() and compared only the return type
> (btf_func_int_return_size()), never the argument count.  The only check
> here is has_set_func(&ctx.fmodrets, ...), which does not consult
> ctx.kfuncs, so the same btf_id still gets "bpf_fmodret" and
> "bpf_fmodret_retval:...".
> 
> bpf_wq_set_callback() looks like a concrete case.  It is built with the
> plugin, has an ftrace call site, and starts with a side-effect free
> error return:
> 
> 	if (flags)
> 		return -EINVAL;
> 	return __bpf_async_set_callback(async, callback_fn, aux->prog);
> 
> so it would get "bpf_fmodret_retval:-22".  The kernel then adds it to
> BTF_KFUNC_HOOK_FMODRET, and bpf_check_attach_target() accepts
> BPF_MODIFY_RETURN through btf_kfunc_is_modify_return().
> 
> The trampoline model is built from the 3-argument prototype.  On x86,
> __arch_prepare_bpf_trampoline() runs the fmod_ret programs and then calls:
> 
> 	restore_regs(&prog, pos_of_slot, nr_regs, regs_off)
> 
> with nr_regs = 3 before calling the original function.  rcx (aux) is
> caller-saved, so __bpf_prog_enter(), the program and __bpf_prog_exit()
> may have overwritten it.  If the program returns 0, which the verifier
> allows, bpf_wq_set_callback() dereferences a garbage aux->prog.
> 
> The same seems to apply to the other KF_IMPLICIT_ARGS kfuncs that return
> int (bpf_task_work_schedule_*, bpf_list_push_*, scx_bpf_*) whenever the
> analysis finds an error path for them.
> 
> Would it make sense to skip retvals whose btf_id is a kfunc with
> KF_IMPLICIT_ARGS in ctx.kfuncs, or any kfunc whose prototype was
> rewritten?  No later commit in the series changes resolve_btfids.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554

