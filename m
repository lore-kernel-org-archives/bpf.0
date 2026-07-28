Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8D19D07E
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265724; cv=pass; b=EIEbJGsYE+XMxd5EN6UgsheLIN+QFcW062zchugQSDeneqj+DhUm0cvebeQt7SI8rZjwOsuj9GTvUmecJlCfYERFqM4q542fEq5TVoVDyZXvhwB2xSdpvP1wdwS7Xx8pGbOseqZF+Ed2LE5Go2gv4IR90eDH8tEHdkoj0133p0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265724; c=relaxed/simple;
	bh=JFS8OHLnCBdW/ftXcyBMnJwvLWny4v0JrWQyys5DM+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XT8zClA+2Q94CX30oKkwX24tJOXTAqocVQrORqHqyBsW4cOiDLVk9BXV+fL/i3eMmWvxtCPY9zDNrYG3v6ajHvaE0RrfXKtHQnI4mbGrl1BkMohIwKmjDavmUgJ/jun/3G9h86WeDsle97jCGNHR1XI++2LhmHXTslFmyFmuBKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOyokgyA; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOyokgyA"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7ff05e5d009so2817697b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 12:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785265722; cv=none;
        d=google.com; s=arc-20260327;
        b=MLLopgAeG4VxYvm2Z9oi2yszIDHKDY+NvdK7txKs9t1PdRDzcAZWXg5maPzePHcRxS
         J1db05KrhJqh0REU8cE8L0lZH04aq3P61y4vIjyrVKiQTt4axs6sVazJXHWHoiaEYcGa
         V49FPiYB2dx5HIdluYWLJi5bTPrIOq4ym7e8thfnI4EMfajDpSj2/sQkrkJoqqfGkamr
         LIau2GDNbQCyKfSslhL3vtnFhfRdPlphuFvZrGWQ7OgWx+lvcYtxkmbnbvkGxpZIG7Li
         Cplknu3b4dZ80wCGU6e4OkjcoDGu1x3j2wjh8RRNXusPRolmojtItQ2moBlE76fIqUoQ
         2zBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HYKDi0sVO9rfrsXmhiYCGIat7mLw5+5Pec6v2cIleP0=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=JBHWggzJwnyDb8FpHemcnr7TLa48Cf+OUPPOXbZkzusr8oQH3Rfb362NftCn8kMeTx
         D/71muD3FflPBwbqjjZSf9mOQKUbjcxNfcRfXP7oVHQEmT5MU1jte/Rv5eys+gF1pDSS
         Js7oZD0xPug3v+zNtP1DBe1MHUVbxgsjlutWxmJYG6cKcyzIgGqgL9vmOzpX+7Ck+ZWQ
         obpbbxD2IW1W1/ms56QJaOYorL5Xo12caAoQYCkedlCuLeHH4eu8iL97lWuzE2LNzjgm
         uB4zG3eoSnMPIDLir8mGV1FHM8p/gv56F4Ul6DaC4EAu27mDG0lxJeHgpJAgP5B0dBlJ
         NycA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785265722; x=1785870522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HYKDi0sVO9rfrsXmhiYCGIat7mLw5+5Pec6v2cIleP0=;
        b=iOyokgyAvdnTu9s6n+20KoTrUUJdfIQkpL31slk7Z8fHygdWD4YGFy7X45D+nTQL0Q
         MtPUkYKQxSethdwVK8ps9H5J7pPiw4ZWUdwRRAUh8Mu0liES2+5GpgBeAk9uRJNsTFUR
         brba8Wa5m4lJQ1+CfShcZK6wUl/c8ldXp+884Ecm/2HEyrDbHDd0SahJE9XMhOdIjv7Y
         TRrunhrG19+v4S1LFdehRbrkFsuJc2Y5JunkCAHouJq7HjetIoYTkf2XQ0jWqXPOaZ4o
         i7SJsxXDqc+VWzO1yquiVhcXahSGf5WowXUUkM2kQTEYvUsHAVzY/2vF6bYAxpL6SwoM
         cxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265722; x=1785870522;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HYKDi0sVO9rfrsXmhiYCGIat7mLw5+5Pec6v2cIleP0=;
        b=jNoyC4TUwxWrUWK1Gacd7TpzIREMf8pjCg5qKeSXi67n+0AXa2R94bL6NrAKxQLXl6
         YPklRqSXhZN+TUke8Oq7YiyYSQ5JJz5bYn3jY+DzWAUozq/sYfPxNCOFMpscnVLCnCYP
         MogME7Oo8KiYkyx+Ya9wDwBr+4cIg7X/EJRlJcGqtCzQRqHiVDDqwqpe6oY7hSyl9MHw
         oQZkMniRIQTds44tTof93kE+j21VH0j1Gz2HqeEriWzxEC6LA2jWEh0aRji7Lg+A5ifA
         3xBnL61TPZjeRr/STWgNiDJoKQFJzHk/Le5I0H6XOk+2GGpZ6O6qhxEycZmhJGL1wXHY
         1aqA==
X-Gm-Message-State: AOJu0Ywb42RcJNiToViKL6qNKEsLOJimgcNYqOVkqDdIUq40A/xA8086
	9Zj9kE7r2KbC8Pq0PrXtk1XX5H3E3xxuJxhqufSBeSCXiCCHkvDiJ0G0D4G+q6H1QGqd2/KJOyV
	VGbNYJjdMl+g8Yq6WsR7jePg5WSjtTx0=
X-Gm-Gg: AR+sD12UEsiTyI3M+QL5H9EAg0HzUm5zFchh27E+todGmR8mDQSebLKr8NzR60ztNLA
	G6L4P1fDAPHDUfb+MDA5wjToXXqPZr19lzw6jK5rslkKe2UjSGWnQ6a++E3lA5vgfNVRe5mRTFi
	dxuRJVPvhbZ0n6DmFAtPPdY+I7CDqtv8You4U/QGi92xKu4btWiEdpSBeSDYYLCqZDhyKn74cSR
	q9dlnL70ZNpp82kx8KuP3lv91JHKfJSAFLNgStFeBhPkuGZvpnkNWHNWUjM1w==
X-Received: by 2002:a05:690c:7308:b0:81f:653a:dc25 with SMTP id
 00721157ae682-81f9932eaa3mr15606107b3.49.1785265722253; Tue, 28 Jul 2026
 12:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-8-ameryhung@gmail.com>
 <4b93853207b6b02761af2fc75222ab8b349d7157.camel@gmail.com>
In-Reply-To: <4b93853207b6b02761af2fc75222ab8b349d7157.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 28 Jul 2026 12:08:31 -0700
X-Gm-Features: AUfX_mztfceYrjn6om7PMjjAl2vn2dP0mmEaQEP0NtbEevMp7XocisFvcELEykI
Message-ID: <CAMB2axPD=BYzQ1O9thnHHE+TqfVTE_YgMRRTpeSkg0-O3C0zcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/18] bpf: Check fixed-size mem args of
 helpers and kfuncs the same way
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 2:17=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
>
> ...
>
> > @@ -6965,10 +6968,12 @@ static int check_mem_reg(struct bpf_verifier_en=
v *env, struct bpf_reg_state *reg
> >               mark_ptr_not_null_reg(reg);
> >       }
> >
> > -     int size =3D base_type(reg->type) =3D=3D PTR_TO_STACK ? -(int)mem=
_size : mem_size;
> > +     size =3D (!helper && base_type(reg->type) =3D=3D PTR_TO_STACK) ? =
-(int)mem_size : mem_size;
>                                                    ^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^
> When is this negation necessary?

This was introduced recently in 2cb27158adb3 ("bpf: poison dead stack slots=
")

The negative size signals check_stack_range_initialized() to accept
STACK_POISON slots (allow_poison). That is only safe for global
subprogs since a finer-grain stack slot liveness analysis proves the
callee body doesn't read those slots.

> Is there a way to get rid of it?

I think this is needed. However, after reading the commit again, I
think this should only apply to global subprogs. Current code allows
kfunc by mistake. The line should be fixed:

size =3D (!meta && base_type(reg->type) =3D=3D PTR_TO_STACK) ?
-(int)mem_size : mem_size;

>
> >
> > -     err =3D check_helper_mem_access(env, reg, argno, size, BPF_READ, =
true, meta);
> > -     err =3D err ?: check_helper_mem_access(env, reg, argno, size, BPF=
_WRITE, true, meta);
> > +     if (access_type & BPF_READ)
> > +             err =3D check_helper_mem_access(env, reg, argno, size, BP=
F_READ, true, meta);
> > +     if (!err && (access_type & BPF_WRITE))
> > +             err =3D check_helper_mem_access(env, reg, argno, size, BP=
F_WRITE, true, meta);
> >
> >       if (may_be_null)
> >               *reg =3D saved_reg;
>
> ...
