Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AA38D008
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260232; cv=pass; b=jP0V19awCXLLQJ8pIwPgK0JNTSJfnKwFbNWJMokVSRUvYMUpX2DQmTA9KFExCj05wknO2ntIuYbOF5yuJyquo61GFFFFf8M9Dwo6vHvmRpWkpaMsRteFC30dfnMw1FwEP/ArZPg577+oQgdubQfDWqeLBfTLGcECkmjTSlB3zvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260232; c=relaxed/simple;
	bh=d1eyVS+Zp9IXBT7u0kM5sa61xIBMpLOIIWtclrSsC5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKitExpt5L2V2pFCST8VHU755weIL2jVqWpmUzvgGIqVP8c5nma3IBbBZ4ye9mbllaAZEuqP9gl1PLYSzW9Oca6c+X0RaMQ2XuWT3WiYsmm7ErzMWk5X1UHPxcakZosmC90NWEE2YC3e5uhe2BSs/fYvlNvk4QR7lLZMSW8yjqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3pTjzrQ; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3pTjzrQ"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-798578e2918so2908817b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773260230; cv=none;
        d=google.com; s=arc-20240605;
        b=RlgCZg2jzgD3xQiRXTQ1O+J57jCeAIz0xTFNsg3YJ8i83Ym6SNaSbGAAR16q/Bw+yO
         VtkalhzkBFdDwfe6eKKclFN5M7eHU1kNonq9C+pWZKkNq6Vp3piHwcs3NFET7J6WWa/R
         pk5ev6mudx+jYuQEKZUD8xsZv92+v3i0pF4RW4Kjrwvs4jEDVDYHdX3P0chYH+ufwhxG
         P+HhgMNXDtN1d7Q/TVhDQGwnFE166n62f9PbHtKw026ffPY2RGuxMbJW4OSJaTperKd8
         NeG+zf5AfAMsg63V1EkkkQadkUP4M4eW2oAth0WfqWOj2CGf9N/xbH/h0hE+8bJeT/C4
         XQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KzF+cwM8huPAZ1UgnF/5+z+9CVUtm6duOXzfOITv/a0=;
        fh=6ElxuiIjr8MUw7uRyrqk6E+jhEPFMT0pHHkRrcSi3dU=;
        b=hx1zfmQCybAC/v5CD6EVqK3j1scZKOkUYyyrI5uJRmXVY3o8ishbaPr3jMlwAyYTpD
         L/tSy1rx/WchXsmSvNJpq6EI+zCAvHkl09wvMSbCJVGM0Svgmtrg9Pbtt3J9by62YkeZ
         K6Jr+MFoVeo+cD6x6WAuTrUZJvLAWeWsi1oZltyo6cMmiMksKSdW4/gVw5NysL5bTwiZ
         0JXDgtpeWR2rEUiif5dvZ/tlsoWmrnz2RlMeto0wf9OblLy+3lEO4kf1sH8jWuzENmKp
         ntkLbs7Xtp9CW2zStTLv1k1pTwo7YmXJnEbmPbT4hvRCMFBGo6WCSeLxqx94xV75+Qyc
         x9ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260230; x=1773865030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzF+cwM8huPAZ1UgnF/5+z+9CVUtm6duOXzfOITv/a0=;
        b=M3pTjzrQlGKHQZ8aKgd+y+GOH37WmJgdPU+ML9s1KfZTXbvF2JLblL3bclDT01AONh
         pWDIqLxKY+LiMcxOI77DTck8XXKd/AumLItpVYTiPBWB3A6EfGguYfC0jAxvLeOQrF1z
         UsEuQjq7qocT11f5EnhJbJr3iGU/T9rjK9Ul3SgRgddndXWhHFBNOyrjMLoGPhu2PON2
         KZPn767KINYMLmz3dmtVllXfF5yp9M5myTzRW8UyrwNLDLmS8Hv4xRNdxoICtIM8Cguq
         Da7+KQ6CA32B2I7tIVjhCGSd4xFU2pSyjIHGSPF3kZKVwxdas3WTm68a2JqUW43fLdTC
         2kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260230; x=1773865030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KzF+cwM8huPAZ1UgnF/5+z+9CVUtm6duOXzfOITv/a0=;
        b=u1YUmRykMpImX6gPJXYi0sEKrLRnhTlas+dMSilwch1VBuxwNH6004LxPgIIxiV0cP
         Kl/LpHCjRQwY52va53K0IG1qPr8YGvVXKLhYoaP104cletS/asq2Zy9guskaFjVov9OZ
         ISbnQJf5ZXEqw+X201oj9rXBY/tt6J4C0Vrivv5S4OEjGW6Shcd3It+AvB2MyTUSpwpB
         IE6ktiWd7NVm0jaPCE03fRc76Wi4v407KlfoZU3/SCBmb95qF53M8U/MttdwAsZX4yts
         iJlN1JC378pWNfNmX4woHa7YoO4Ns+yJYn5mZnQRi09EOGcB5SG0ltPqCwkuSUNN8zG3
         WpKQ==
X-Gm-Message-State: AOJu0YxJBSEApQWt0G3YzgnKnzTz8iKaozghlZRisdD8CVC5Z+edBmJN
	ihzyF7WVSgNJgd2mW3avPTcqWA3H+VRfebZUVKUAiEzaax+78r9P3U9j0t6dr9RFy1eDfNu/hxB
	cKO1EJRFMgppWmvrbVQBRE9VJ6ve9N/U=
X-Gm-Gg: ATEYQzyQ5erkJfl4DgjqMs55xvj8rF4pqfZJQhO2c1X6IIQRYiibrs/EYviDcq1sLYg
	pCVlSBYk9ysuMgObMKc1NOyMDFvBz+VrC25vg2T51Ds3aRqHWLatu7k6MwZtT7B5ACQen+8PbtY
	5GDFoW+KptptB/Iw7z1TUHufnaNjqaXfiAzB3NsqqVbTY2xf+dAowuTGhuws7ddh8BsyddczLQ7
	IpAW8sB0GyocQ3l/T4Xdo8zACvEf0g/v0oMrFqNWm59X1HembdAdYDAmgkX1OlPq0G/HtNK6xTR
	fMUoyTA=
X-Received: by 2002:a05:690c:e3c6:b0:798:78ea:f0c5 with SMTP id
 00721157ae682-79917e97d83mr38847737b3.13.1773260230066; Wed, 11 Mar 2026
 13:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-4-ameryhung@gmail.com>
 <CAEf4BzaRJ4hgMZY04=B0nnAE=MjyD4FN2L867vGCbornshOXDw@mail.gmail.com>
In-Reply-To: <CAEf4BzaRJ4hgMZY04=B0nnAE=MjyD4FN2L867vGCbornshOXDw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 13:16:58 -0700
X-Gm-Features: AaiRm50_1E906IE_5n6OlSDFA1nUlOC73HbmufmmtzwTEwEgDBcaxSIlMklfoMo
Message-ID: <CAMB2axPL07LZXAjy=FMBh2GeRkF0KQ81ixNFmX_+ZxZWm7nvSQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the verifier
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Simplify dynptr checking for helper and kfunc by unifying it. Remember
> > initialized dynptr in process_dynptr_func() so that we can easily
> > retrieve the information for verification later.
>
> it would help to call out why all those checks you are removing are
> not needed anymore

Mykyta also raised a similar question in another place. I will explain
in the commit msg if there are checks dropped in the next iteration.

>
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 179 +++++++++---------------------------------
> >  1 file changed, 36 insertions(+), 143 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0f77c4c5b510..d52780962adb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -277,8 +277,15 @@ struct bpf_map_desc {
> >         int uid;
> >  };
> >
> > +struct bpf_dynptr_desc {
> > +       enum bpf_dynptr_type type;
> > +       u32 id;
> > +       u32 ref_obj_id;
> > +};
> > +
> >  struct bpf_call_arg_meta {
> >         struct bpf_map_desc map;
> > +       struct bpf_dynptr_desc initialized_dynptr;
>
> nit: let's drop "initialized_" prefix? so verbose

Ack.

>
> [...]
>
> > @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_id =
func_id)
> >                 func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
> >  }
> >
> > -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> > -{
> > -       return func_id =3D=3D BPF_FUNC_dynptr_data;
> > -}
> > -
> >  static bool is_sync_callback_calling_kfunc(u32 btf_id);
> >  static bool is_async_callback_calling_kfunc(u32 btf_id);
> >  static bool is_callback_calling_kfunc(u32 btf_id);
> > @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_fu=
nc_id func_id,
> >                 ref_obj_uses++;
> >         if (is_acquire_function(func_id, map))
> >                 ref_obj_uses++;
> > -       if (is_dynptr_ref_function(func_id))
> > -               ref_obj_uses++;
>
> e.g., why this is fine? (because we don't use ref_obj_id for tracking
> dynptrs anymore, right? would be good to call this out in the commit
> message)

Thanks for the example.

>
> >
> >         return ref_obj_uses > 1;
> >  }
>
> [...]
>
> > @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                                 }
> >                         }
> >
> > -                       ret =3D process_dynptr_func(env, regno, insn_id=
x, dynptr_arg_type, clone_ref_obj_id);
> > +                       ret =3D process_dynptr_func(env, regno, insn_id=
x, dynptr_arg_type, clone_ref_obj_id,
> > +                                                 &meta->initialized_dy=
nptr);
> >                         if (ret < 0)
> >                                 return ret;
> > -
> > -                       if (!(dynptr_arg_type & MEM_UNINIT)) {
>
> I can't fully connect MEM_UNINIT and CONST_PTR_TO_DYNPTR, this is
> something that should be called out in commit message, IMO

Will explain in the commit message that !(dynptr_arg_type &
MEM_UNINIT) means the argument expects an initialized dynptr.

>
> > -                               int id =3D dynptr_id(env, reg);
> > -
> > -                               if (id < 0) {
> > -                                       verifier_bug(env, "failed to ob=
tain dynptr id");
> > -                                       return id;
> > -                               }
> > -                               meta->initialized_dynptr.id =3D id;
> > -                               meta->initialized_dynptr.type =3D dynpt=
r_get_type(env, reg);
> > -                               meta->initialized_dynptr.ref_obj_id =3D=
 dynptr_ref_obj_id(env, reg);
> > -                       }
> > -
> >                         break;
> >                 }
> >                 case KF_ARG_PTR_TO_ITER:
> > --
> > 2.47.3
> >
