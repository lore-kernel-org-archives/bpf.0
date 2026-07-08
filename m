Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379A4534B3
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519880; cv=pass; b=Kwg03ZxZG0BjHeOsUkBIbd2C0lXRumn6MOe86ykXBuRaFM4tM6elcYa5Ju3EIBeR40eEP7wwrs9LChjiD5xeV15TZI4r2rr9ZBE/vl4i39opBiWBk6fa4YVkoN3fFEYIXfk/Jp/ZpW9Bn2+ZXPJv/RnBPFeA+5BIn8ugcai9M/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519880; c=relaxed/simple;
	bh=JcmAKN11GlEZlCK3Tb7glDhGWHCZKu3R/gZN0IxBi44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3a1Hot01mGH3JrMRxSknSExkltG6YHMIw4ZlbI9t0PwzFPdQCzuttXuSlVBVIJjLJpVvZKu/jG9ffkxA1S5xNld0mEkyAFQCuxBYyjUvxrBu9bZGybHfMH8cFUY/BlapBQiOzmnB757o3QMSdKDH88peQ5GEzKWoA+coRPNtG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbjqtztN; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbjqtztN"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8114a4542b2so10243287b3.1
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 07:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783519877; cv=none;
        d=google.com; s=arc-20260327;
        b=g6aNqomYaIW9asMlWjxUGIpYop+qFljvqfLNMJIX+4rP0pcfARADVHhUBrSuNhOOaP
         SVO4Uc9cRKCnUr6kUf5JOUZx6QNqzdjKTcwfvwO0E1MLWFLVJAMTWj0Hvsi1AjEN25+M
         enbkkj8zT7kM+Y7TiWj/viFoABBJf/HYobWcDxV/rIvJMcHdq8PGcWuWujgYV+KIUsBn
         MEo9yC7zE6qKy0a7hI1QbLVn5BaUuOXlD8F8wchrBB0febO5PPhQ3fx5fk1+6ZgHUs/Z
         NEXlCNNzg6CNeGQf0tPmM144CEzefdfWeqwFXAGYoaQl4vpz2ffgUjo4JOAYbVnZJOx1
         ba0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F6iCbqiFD/hdmKTE2DrZqekV252eUYkKKpzBqjT3c4Y=;
        fh=Gb2jYWfnRE9tiVrycsLqut9UaWgVu/muX8TeT6TC36A=;
        b=CYDs7ALLSx9vGfs75yAntn3519eINKHHJqU4/L9WJ+jShRILnM+SUonkAIvTx0FWLq
         Tv9Ez+hOfuystfBKBksfBuhNF7fRiPzHZusVjNlkSA+sD7/nBPd4wyL3VqDusDDpPprK
         jQ+RrRaCHkeZ71yUxZhK/NjD65g7ZhnMLDWgHvdsjNaKbW7K136WTo3wjdMoahp0RELf
         ORdazib/MFyI662khxXHvTlchz8XGPUUPqs6i4Ofl44OS0S/U2FWxPY0ddOtIyznqYuS
         BImNMs0CkahhvMMk5wsprrwZoXxDfoNmiZ3GU3y4+GDo1wniy3kMJu5Je8zar+LYUxnt
         564Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783519877; x=1784124677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F6iCbqiFD/hdmKTE2DrZqekV252eUYkKKpzBqjT3c4Y=;
        b=gbjqtztNoCnSOFk58/N4v30ST5t6baL6hHcN50mbJl6CmU5VbccQeXjnL4PncELpl5
         UAbyoWVrI9X6UHzpSuNhqLFFA4lIHydFw/SR0nN7yw9zhXoYv6SHakpmkMxf040xssUa
         CIYTpeOzFxwjLTbtsEIwEwZ338gV/YwEBkMMVRsID1VdgawM0zAz3tShpyF5k1FOJroJ
         TPsexkiD0RHbqx8NrrnkwlNNtIRG3nAxx8Mwn+Sius47U2bY22luyBvYOC0FD18mbJO7
         N8vPYOWkh1PAPUdiu418vQGiMm29jvrF2ImYTcBi0zMR3SpLEbJmOa2nfm+JqgbYxVvr
         7sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519877; x=1784124677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6iCbqiFD/hdmKTE2DrZqekV252eUYkKKpzBqjT3c4Y=;
        b=CFg7rniPpNk3eEkU+rS5JNye9Y35UAlWCNVi8cI5eFqB0XCLJiVEIisZ46aJ0eRIe7
         PPT05LtxVOtV8IP0c3wXQHhlAeesW88UGA+eUVX2qo58rOl36MsTYh7xobh5yo6QXjL/
         jGGUZa4v0f9HLPZT0imMRpx8uJzF5azYc+jG7TMcPhqBSGZewjz36fMDjGOpvVOU8S9u
         hoPOhrKdS5TjQEeWxSrUw9mqAENlJyzrB0y1xBJRa9xkqKUQJ+1krksFgSS8JGKiBZFB
         ZHagPZRSJBiqvkWojRtH5c0wr/l4+U0DSFlHiKS0jZWMtkn+x6Y03JKcmE1Ol0vIkReU
         ZlDg==
X-Gm-Message-State: AOJu0Yx00+AUMsNYPN0Euh7vyQTKMvLmd46fTnHccDQIEFhtSMwlWuT/
	phOjGbWvJNPTZlxohG+MpDlnb7HwXr/RS867PZdY9m0krCObt4RAMJXHk2Ih/kAJLfhsT0Nc0CL
	L/wIxPMTSkpQe00Rr0BQVJJMvmHs7cdU=
X-Gm-Gg: AfdE7ckja51SycZCWOgQ8ZQEKOMg+ujlfSRu1TuocUBQ9X1xjXVm3QqZMBqcjL1ZY6l
	g09SqunaEyNMEiG03aMJ/If5ojKqPsL/JiuG/uT+95T9OS5X77ZsCOp1Oqey+O9ufHknn6c4iuk
	ewfVZrmPjbaHMVZFd3/HH5TbiHu0dqIVJHbqIuAd2eJmPlt+KSfgb9BIhSAvVx7B3bDYQGYQbrg
	ybzGhplXBx2HRfxR8YkYIu4VMjXGQLV3NNfNzrNpaRDGSnTXCriFbIwHxuv2P+RqXR7JydN84r/
	CstwKXAs4UaZ6otJZbHB8B/lTEjHxnsJN5M23HRr
X-Received: by 2002:a05:690c:9b11:b0:81c:c77b:3546 with SMTP id
 00721157ae682-81dbc7217dbmr21323267b3.21.1783519876972; Wed, 08 Jul 2026
 07:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
 <20260708090151.151729-2-sun.jian.kdev@gmail.com> <ak5HLLrYK3R_g2y_@u94a>
In-Reply-To: <ak5HLLrYK3R_g2y_@u94a>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 8 Jul 2026 22:11:01 +0800
X-Gm-Features: AVVi8Ce9tfUoastI5qlwZvx2Zc16Cxa5m1L5o1cpFV_Bz3b7ElwfOC-N99L74kg
Message-ID: <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for buffer pointers
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, mmullins@fb.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 9:13=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> On Wed, Jul 08, 2026 at 02:01:50AM -0700, Sun Jian wrote:
> [...]
> > Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for poi=
nters")
>
> Agree that above is the commit that introduced the issue.
>
> More comments below.
>
> [...]
> > @@ -5326,14 +5326,18 @@ static int check_max_stack_depth(struct bpf_ver=
ifier_env *env)
> >  static int __check_buffer_access(struct bpf_verifier_env *env,
> >                                const char *buf_info,
> >                                const struct bpf_reg_state *reg,
> > -                              argno_t argno, int off, int size)
> > +                              argno_t argno, int off, int size,
> > +                              u32 *access_end)
> >  {
> > +     s64 start, var_off;
> > +
> >       if (off < 0) {
> >               verbose(env,
> >                       "%s invalid %s buffer access: off=3D%d, size=3D%d=
\n",
> >                       reg_arg_name(env, argno), buf_info, off, size);
> >               return -EACCES;
> >       }
> > +
> >       if (!tnum_is_const(reg->var_off)) {
> >               char tn_buf[48];
> >
> > @@ -5344,6 +5348,29 @@ static int __check_buffer_access(struct bpf_veri=
fier_env *env,
> >               return -EACCES;
> >       }
> >
> > +     var_off =3D (s64)reg->var_off.value;
> > +     if (var_off >=3D BPF_MAX_VAR_OFF || var_off <=3D -BPF_MAX_VAR_OFF=
) {
> > +             verbose(env, "%s %s buffer offset %lld is not allowed\n",
> > +                     reg_arg_name(env, argno), buf_info, var_off);
> > +             return -EACCES;
> > +     }
> > +
> > +     start =3D var_off + off;
> > +     if (start < 0) {
> > +             verbose(env,
> > +                     "%s invalid negative %s buffer offset: off=3D%d, =
var_off=3D%lld\n",
> > +                     reg_arg_name(env, argno), buf_info, off, var_off)=
;
> > +             return -EACCES;
> > +     }
>
> I was thinking of suggest to just do a single unsigned check
>
>   var_off =3D reg->var_off.value;
>   if (var_off >=3D BPF_MAX_VAR_OFF) {
>     ...
>
> But looking at the code before 022ac0750883, what you have is closer
> aligned to the previous behavior, let's stick to this.
>
> > +
> > +     if (size < 0) {
> > +             verbose(env, "%s invalid %s buffer access: off=3D%lld, si=
ze=3D%d\n",
> > +                     reg_arg_name(env, argno), buf_info, start, size);
> > +             return -EACCES;
> > +     }
>
> `size` comes from bpf_size_to_bytes(bpf_size) in check_mem_access(), and
> is already checked to be not negative; plus other check_* helpers does
> not check for this, so I think it can be dropped.
>
> Otherwise, LGTM:
>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>
> > +
> > +     *access_end =3D (u32)start + (u32)size;
>
> If you want, this could use a quick one-line comments regarding the fact
> that it won't overflow, or even verifier_bug_if().
>
> > +
> >       return 0;
> >  }
> >
> [...]

Thanks for taking another look, and thanks for the Ack.

I agree that the size check is redundant given the current call path. I=E2=
=80=99ll leave
v4 as-is for now to avoid another respin unless maintainers prefer dropping=
 it
or adding a short comment around the access_end calculation.

Best Regards
Sun Jian
