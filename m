Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028AF3E49EE
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753629; cv=none; b=PQzXtZ+Yz7QpO1wgIq5EuKQ6V9pVMd+LCeDfrux5XlVB0ncjcvrpQC8/CWPv37Th4I1X502h677q16Y2zL6DZh2cQ3YVtbPY3+qjdhkon2A1roJTWBesci9Ma0Kgl7dxjT/B0Z+ysqUCwkwc0L+p/JAL4bNOntNA9+VXvuiT3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753629; c=relaxed/simple;
	bh=f42dMciCrW1J0Mcy+QEp7Bb81fgEDJ3RV9ZJ2fzxP40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/fp+sC18abl2GAIhYoDfSbPBUyOhWIrQIyDYCdBXfNgilvIaf0TCW2bdGAJIfk4zxNUr4d8ncjw8/jA+5XrG9+bQQVNH1oVxtnM/U7Oy7R0M8uUPD6XoJnxutASh+QJ8yOAHbz/HaICyo1SgnMa2/wOufBq28R95uu1Wwka1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk5xGLn3; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk5xGLn3"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed1368so13975135ad.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789753620; x=1790358420; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GZvh9frVpT1nHhEQKPyuEwEyEjCXAqjHGVMbR0ccXvE=;
        b=Sk5xGLn3PoB4C7c0tFUyJXeeYerz8/EgGUrK/qPlyfbFvEPDteK/UMerP4GjUyzkdO
         3fHXG8Z3fHAkUay5gP8hDSDhKl41eLu87XBb7HgDcFFs/lp27DENUFPDLA12n0SGV3QO
         wI9hswjshBnUqBr3A8RlIympaHOSet8vi3Ml4BZQ/A98nyXLM/B1v/qgcs5P1pBe4Y0B
         P/7+Np5YjEOLFFWGjuGVwjG4F+g5o2d7C1ukSJ0zFpOXPu7f3ppJzYLOmSa8h0ft5RbK
         yWaIUXfTFOSI0EKpq5rd/9SXeHbrj/Su89X3KsnMtIyG6hA/BDdgY9CT1W5ki9Z3SG/r
         fhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753620; x=1790358420;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZvh9frVpT1nHhEQKPyuEwEyEjCXAqjHGVMbR0ccXvE=;
        b=yQjZGuzFEAWWJ3iq1Jz7/ybW7wi67H040XZiTKEHWWc4Yf8MLCSZ2HhRNVf0vJlLmy
         swp8cjUvpWasjMwY8+HffpFbbQ6TwVpFrNe7bTSyOTOt23knCSm5Vw708mSH7ge0EZb8
         yLoYdO1fGSWLfXFN/1asflENAAugsXGm1c1tGYBdnYwl8EeXulw8jqWxBKI6jEotRRMW
         NjHyGfNaHee/UTU8um1m8dfq3pWq7uXaldQoyScE77D3py7fbcmNWYT1D3GvSLMwY5Xv
         UA8Gy4i5IHh+GGS9VrPDPI8VjK8LSTMUatpz3aKUW9MHftFVpe40np2d7dh52q/3K7NV
         ftWQ==
X-Gm-Message-State: AFuF++kB+sNAA+1VQvA4YWoWta5qJUQtv9ClEeY/6xuaKlzpBZq/cbyt
	xffVTyCMwmQWZprN7fKYjaamdgejrnBW3vkOFZ7yM6kGH6Cm7XZJ1oKVfkP5rcOA
X-Gm-Gg: AYBFou2CJcuEepoiJmZ3KCLXJ9tHdWpzfVJ9OzhIEXJpGImuOZookjuCATkLA9dygt9
	ZcZ2W7mvcQkierxhu/+1h4r4UvZrUtPn5QIcJ3FFyiI5iheNrEptll4R9ao5uhrfIAHtEfLLA2L
	UmyxCAUjXKi4dY7HbGwW7ycLNddUEnzy20COdvsp6/BSv8yNkpY9A6h+vVfk3J6RkJWjc/ZT7Cz
	ZWaH4EcNtUFldtHxPIY1zLcWvWfGmS82LWzfet7UyLIF47L6rrVoQ3VAPo1pFYI8qne6MTIhoPn
	2qqoVHWCaWBJ/274JgF5NrR470A8hKKeQEjqTMAtuTI1aSKQA+f4WvPVVUSSrrrbRZZ8Ujpe3cv
	RZjgk26mByU7vipegshCKH43RMsYM38N/PQGC0yxi6x/uUeOtkw2DuL+TJODO+odpIKOdTGVCYB
	wNpTf4JT27V9GALkbYNTng06NjStqTCLQCvL7zKalfB8ogFYSbt3TbpfST1npGXTO9OOysQpaAg
	QR0s0hDMkrVZQCMhbIfmaAf5VeYYXGkVRsyJdBFu1S4TPuwWMhUQnZK2w==
X-Received: by 2002:a17:902:c948:b0:2c8:248a:5dbb with SMTP id d9443c01a7336-2ddb1add3cbmr62250255ad.7.1789753620314;
        Fri, 18 Sep 2026 10:47:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17e17e0sm364765ad.70.2026.09.18.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:47:00 -0700 (PDT)
Message-ID: <962a73fd049d797d27f8e51e8a14dc011d21415c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] bpf: Check read access for initialized
 writable memory arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Date: Fri, 18 Sep 2026 10:46:58 -0700
In-Reply-To: <20260918055038.1D4AE1F000FF@smtp.kernel.org>
References: <20260918052906.12226-1-memxor@gmail.com>
	 <20260918052906.12226-4-memxor@gmail.com>
	 <20260918055038.1D4AE1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-18 at 05:50 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] bpf: MEM_WRITE without MEM_UNINIT enforces BPF_READ breaking=
 output helpers
> --
>=20
> commit aebadfb01a3b32540321fe2b60bcb6fb1c8673be
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: Check read access for initialized writable memory arguments
>=20
> This commit updates the BPF verifier to derive memory access types based =
on
> argument flags, correctly enforcing read access for writable memory argum=
ents
> that are already initialized. The change addresses an issue where helper
> argument checking previously omitted read permission checks on map values=
. It
> adds a generic func_arg_access_type() helper to replace the kfunc-specifi=
c
> access overrides.
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1d5e4ee64fc00..21eb806b1351c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8886,6 +8886,15 @@ static int process_map_ptr_arg(struct bpf_verifi=
er_env *env, struct bpf_reg_stat
> >  	return 0;
> >  }
> > =20
> > +static enum bpf_access_type func_arg_access_type(enum bpf_arg_type arg=
_type)
> > +{
> > +	if (!(arg_type & MEM_WRITE))
> > +		return BPF_READ;
> > +	if (arg_type & MEM_UNINIT)
> > +		return BPF_WRITE;
> > +	return BPF_READ | BPF_WRITE;
> > +}
>=20
> [Severity: Critical]
> Does this regression break pure output helpers that lack the MEM_UNINIT f=
lag?
>=20
> For example, bpf_snprintf() is defined as an output helper:
>=20
> kernel/bpf/helpers.c:
> const struct bpf_func_proto bpf_snprintf_proto =3D {
>     ...
>     .arg1_type  =3D ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
>     ...
> };
>=20
> Because bpf_snprintf() does not guarantee full buffer initialization, it
> cannot be safely marked with MEM_UNINIT. However, with this change, the l=
ack
> of MEM_UNINIT means func_arg_access_type() will return BPF_READ | BPF_WRI=
TE
> instead of just BPF_WRITE.
>=20
> Will this inadvertently force check_helper_mem_access() to reject valid
> write-only maps (BPF_F_WRONLY_PROG) when passed to such output helpers, c=
ausing
> valid BPF programs to fail verification?

I think it should be safe to relax MEM_UNINIT interpretation for priv
and not to require full buffer initialization. That would be only a
documentation change, as far as I understand. Then it would be fine to
put MEM_UNINIT for snprintf. For unpriv and MEM_UNINIT buffer we can
scratch the buffer as a combination of BPF_MISC (for previously filled part=
s) /
BPF_INVALID (for previously invalid parts) instead of requiring full initia=
lization.
Kartikeya, could you please take a look if this requires any code changes?

> Additionally, for unprivileged programs lacking CAP_PERFMON, won't this
> erroneously enforce stack buffer pre-initialization by enforcing a read c=
heck
> requiring stack initialization in check_stack_range_initialized()?

But that's not an error. If the helper reads the memory, there is no
MEM_UNINIT annotation and we pass a pointer to uninitiated memory
buffer to the program, then such a program should be rejected.
