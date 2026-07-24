Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA4184524
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925605; cv=pass; b=stXBsQfolc5Zyk4Bp+acwhIskeoFk/uVHh97nJ+mftIhTm9fG6R77YQ8IZv5Q0QNFLJGz7DKRldj7qGTJkmV81dPaVVm7eZPL8I8FoaApX86Wednkv1OEKu5PBvOz6Td3UGL//UV1AqSTJfEpMF1sUr0UDCe0mLBX/+yFMFIrMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925605; c=relaxed/simple;
	bh=N63mq0f6cnN9iRIbW4gRFTVClqYEzt+UclEwUQzbMHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxOXi6ZkOxPsirOLRP7GcqoTKcr2MO38jxwevBAf2DhOeoMwmq6piis4rGjnxHFnxsIxXSntcB1gSYxuVN1MIFj2zc9c0rGz5Eow5mUEZkq9p4BKZjk5WGs6p21K4z9ky+RwvoOZjhM42Zkcr7U7w0Q9A3ydFbOGiiGIWfdRNDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a//T1gzt; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a//T1gzt"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ec29f1d07so8269267b3.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 13:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784925600; cv=none;
        d=google.com; s=arc-20260327;
        b=Dy5sOCuK6GxOnuMZb2CJWyXe9JYFsNqQZjEDdn4h2c2gIISSqctCM2AKzhN3Go0zhA
         WTvRZltziLPYuE+3O+kYGbzHKFNKbq3ZBBAbHtukwc1HghX32q1PhyfsP+s2V2AdWd7W
         Kan/YECuelVOvRbBAfyMNvpjj6g6Lr/6OYRhqx8C1Q9jvN4aKagR6CC7hxQVX/WXdRdt
         7dRDdWC6plJdJW4vmuQ2RF8RiReR7B3wy+YaWO6VBDA21w+4uXXo63nU72gPy7U1u/W2
         F7Gt552WHxifm/Qq90UiJpUFksPkIdVNhj1B5/bZ9oKvYpVI2m2VA3+bK6tG1fW5IxvH
         nmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tlk8Hky2z+LvqEkdAsADCEGWr5mvcivT/kkoIf/HzMw=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=oH6AQ819Hc3gDFTWa+fXSUu3zLgHKkbrJiL8D4n0C8Mw3e+r1l669RK2wsQKr6Ga+t
         2UzuMbb6SL3pllnRaJCxZ1LbcJg5+hsY2qHT47dCKf+ETbpzIhOdYVpYm89p+Koc0fCp
         T1GK1wZNdvB9YAmnIdAvPqtzJxF1mt2saLBvhdYByRDRt0lA6OXVZ3vGNv+kstDXNCre
         tIFjhpCVHP5o1Z+w9rv+dCZgaJR6OoklxUu8cAHPqgq1xYeL3Tz4BYiOPNrpc8xGZXqN
         mCkIiD0W6UHDwtAI+nHhFtyiTpfQ5clK4EQiGuizLzOSamXLmGDlaJK5AsCS5NKI45zp
         E51Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784925600; x=1785530400; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tlk8Hky2z+LvqEkdAsADCEGWr5mvcivT/kkoIf/HzMw=;
        b=a//T1gzt54wMRoT4l/lroyGUr+uvbQXdsm6TPwEQuXsGc6YypOD4lO8VflraQB15u9
         eyXOSeyNmmuPLzz5xbsd13gXcPjFrXWXiZy4dklc3m/odciuyPKQk84I7auuhBGOdgZw
         tS4PQv2+52vq1Y0WGWg+yIZ6aHtE5kIvjAB5M4P5TfFyHPcrdRuVqh/+3QQuTZZ+S0SI
         p97R/AhIgfSl5yTNsNhY7ICfrzRxS2bIoNfKkZWV1sMklJSvlKh+hnTDG4qXNjXEuoQn
         1QjmiKF91AFErEq8MIU96GqqW/adlJETfQM/9Xci0+modftO0ecYRC09fJIYo66NGxJf
         8BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784925600; x=1785530400;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tlk8Hky2z+LvqEkdAsADCEGWr5mvcivT/kkoIf/HzMw=;
        b=ULUBmhry+FO1/BjglYROdpg6oEBNLirzxsHvEDcwZkMTOAJWK6w8u1qp1YhvLGgRda
         e3PmGMrufOg731vS0lpnqvA+y42E9tL+yyNTtATUhT7wQxcRD7tjbf5YGYkN/kIiK1Z1
         2uyQdQRxlj3mudIPeJUm7ROikA71VC11B0iCgv9TyiwvaCf9az/Yt+uyi+rmBt6chcdF
         WilTa/dyvcwfujmFQYsH7Ql9ddzbRYQFddhIZDhTET84viRH9lumY3zu8w+cHVxyLULs
         xszDi5LjD9bkdxLqzhVpeZVz+Lh2UgUinPppz8/UJ4qHmk9T+LGAPv1cWbK3br0HjCX7
         bWig==
X-Gm-Message-State: AOJu0YzAU9O4+4ckzGhJlzaiUJ5ndz/I8Ba4OylXSFzJA9RTOeBdXxsR
	WnMtKxB+t6DUzt1RYbI8LZXVoiJyWLv7voEeRAKhv7ycpu4/nMkiEBEKao6DnHglHZ6wWbL9Y19
	iNvz6m+7B1WtJLBW1v0Z6nZ2V0s/VTNcQ71bb
X-Gm-Gg: AR+sD10cWomKxCQMIRzQVowhJgUutqAE0Gzc7oc5nhPH7HUFzGoPMAp4U+1zhpOoiqw
	q6z6ObZT2qN2OxwWxlfeRhR9OKs3nuPCvL9Wosf42GJqlfECqDZEBXlcXbN2qLVtmOiphCS+9YE
	R2oMXEbFDFVAD18NgB8ccfPfHj63s2NTB465Shv0qG1/e61Ae7LMifO2PA+WBzNU++Yo3+6s9/O
	sBl1lDpDDeEVTtMXqbAy6JRXTWSze27+DnxEQ6HuHlF5C6IvCrC6wB7HsZMHw==
X-Received: by 2002:a05:690c:3505:b0:81f:4247:de16 with SMTP id
 00721157ae682-81f69d274dcmr57187b3.24.1784925599823; Fri, 24 Jul 2026
 13:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-8-ameryhung@gmail.com>
 <20260724193219.226651F000E9@smtp.kernel.org>
In-Reply-To: <20260724193219.226651F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 24 Jul 2026 13:39:48 -0700
X-Gm-Features: AUfX_myJoICi1XGoqQSWzYiND5VArQEkN6mNun7EuNNguY7wyqgjrUrxA1ww1h4
Message-ID: <CAMB2axNC68jrpxBmyjbQWAkSin1b97O049rjuPR4u1dcW9FB5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/18] bpf: Check fixed-size mem args of
 helpers and kfuncs the same way
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6965,10 +6968,12 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
> >               mark_ptr_not_null_reg(reg);
> >       }
> >
> > -     int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
> > +     size = (!helper && base_type(reg->type) == PTR_TO_STACK) ? -(int)mem_size : mem_size;
>
> [Severity: Critical]
> This is a pre-existing issue, but does the -(int)mem_size cast introduce an
> integer overflow risk for global subprograms?
>
> If a user defines a BTF struct with a size close to U32_MAX (e.g. 0xFFFFFFFC),
> -(int)mem_size evaluates to a small positive integer like 4.

This won't happen. The early "mem_size > S32_MAX" check in
check_mem_reg() will prevent this.

>
> The verifier would only validate this small 4-byte region on the caller's
> stack, while the global subprogram is verified separately with a PTR_TO_MEM
> of the original massive size.
>
> Could this allow the subprogram to read and write out-of-bounds kernel memory
> beyond the provided stack object?
>
> >
> > -     err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
> > -     err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
> > +     if (access_type & BPF_READ)
> > +             err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
> > +     if (!err && (access_type & BPF_WRITE))
> > +             err = check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
>
> [ ... ]
>
> > @@ -9251,7 +9255,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
> >                       ret = check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
> >                       if (ret < 0)
> >                               return ret;
> > -                     if (check_mem_reg(env, reg, argno, arg->mem_size, NULL))
> > +                     if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL))
> >                               return -EINVAL;
> >                       if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but is it possible for global
> subprograms to bypass nullability requirements here?
>
> When check_mem_reg() is called just above this line, it returns 0 early for
> literal NULL scalars:
>
> kernel/bpf/verifier.c:check_mem_reg() {
>     if (bpf_register_is_null(reg))
>         return 0;
>     ...
> }
>
> Because of this early return, the nullability check immediately following
> check_mem_reg() in btf_check_func_arg_match() fails to catch the NULL.
> The check relies on the PTR_MAYBE_NULL flag, which a literal NULL scalar
> (SCALAR_VALUE) does not have.

This has been fixed in bpf.
