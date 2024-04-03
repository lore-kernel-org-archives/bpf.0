Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E888153501
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166478; cv=none; b=cCYiTNjNW2AnWzczOV56RvOuit6UGQvEAMlUEwkBsQVxIhUlagF93PBHa5Z+uRpA9lu4kocoaaSCETUkyx95va+OxEwB+COXRu42bp3QmtknRdZ9D3vTq85cAUVRle23G35RccIiIu3ijSJLyqO/4R24ozmw1Uvp+kEpG5p0B2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166478; c=relaxed/simple;
	bh=L1oNMWi8496oHVpVAEjPdDKtXKWhpu2B5rOdB9Z2blA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UR2Hw397/Uy6pX22kbisU6UvYyzDOAzue9/OQi+2sQ+XSc+RkKRK68kdjk4E6kHjldZXVa/SGYBulBRHKgUoDEGSbFixMp+Nify0P/7hxsrYB+6v9G55hU3U/i7XkCrAJnf+uvRzW6g0+SwMBo18055Lk7fKkIXm23sCQ/5fHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlmlzwzK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlmlzwzK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a074187a42so53232a91.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712166475; x=1712771275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hro2wgTSXWd+ztmR3WfayRwTMaRXM/TQ8KEUtIc2iVU=;
        b=WlmlzwzKylfw8Z1pwHHfkl47kQ5tV1Xl6kUoQvsGpCP3Btm23cV9z87v13IBuQNnN9
         kaiQy2zrktfxhVPL0WDDDwU4DDwYDInLPnBDR67jL405/yVzF0bLnEcWK2ODvAcgNX96
         5GHwlBw57lYWqfzo6wS3X1W6vshFdMC6G16KtiYfx6S5Cs34G+x8+4Q5+J5+zUx7c8jm
         9D9C+wnu6O05rpIAWf2D0mFkcJkqeYPJwbJKlsf4y8mpPZciIyu1+Cxa93tmTUn0+Z0s
         veHshfVUzGvkHHNUq0Pjdp/JvHRMQlOZ8th31oEStoJuzNSx4F+Nyqg+ADb5sj/9X2XP
         OV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166475; x=1712771275;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hro2wgTSXWd+ztmR3WfayRwTMaRXM/TQ8KEUtIc2iVU=;
        b=QLbMn+/LKMVZAEs00ZttKorr1tLNGugncqCutZEchA4jFpVH6Pt9DZfoeH7DFqu4F5
         BgrPXf2+tDq3MokuZ7l5lTE6P/wNz7OB5zFOUPMKHbDHR0P81AQWVaoITIyrLem/tik4
         pl0xnxgBXoa9l6vXcK5zEoQp1pWaEmVxs+tSdJI1sAyG/9jOoeW8qmx1Oql/Tcy64+sB
         F8nxCAt92UhfWqPy67MkoFeJge4tDrbLgV9EQksdMm5xbF24qtYrk6hy5X8Z4SvkmO0h
         QQv9I0PkvUzrtmYVCDnX70ns5NMS/z5+5FjE3Le70goLhGzXBNpsYMAdWxp2Hij+chkG
         Oc0g==
X-Gm-Message-State: AOJu0YxVTGFtmKVDFbo75RYD91fyEUHqjUjieRCZrvp/Z8DFCz+v1aRr
	p++YopDxmiI0uHN2pi0UpX0wvHPyhDVDEFksyZKHRg1S95rZec2MrhTkYSOP
X-Google-Smtp-Source: AGHT+IF8NPcBw/KWdpKDzC7l+zsWXJOdJygfDqAYvoiOXGvGjWjl/TiE1POm1gW0/SAeJppj4/+niA==
X-Received: by 2002:a17:90b:30cb:b0:2a2:5ef8:ae81 with SMTP id hi11-20020a17090b30cb00b002a25ef8ae81mr219043pjb.3.1712166475484;
        Wed, 03 Apr 2024 10:47:55 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090a178c00b002a017e2c24fsm15174925pja.37.2024.04.03.10.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 10:47:55 -0700 (PDT)
Date: Wed, 03 Apr 2024 10:47:54 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <660d964a1444b_1cf6b20885@john.notmuch>
In-Reply-To: <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
 <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
 <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko wrote:
> On Tue, Apr 2, 2024 at 6:08=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >
> >
> > On 4/2/24 10:45 AM, Andrii Nakryiko wrote:
> > > On Mon, Mar 25, 2024 at 7:22=E2=80=AFPM Yonghong Song <yonghong.son=
g@linux.dev> wrote:
> > >> Add bpf_link support for sk_msg and sk_skb programs. We have an
> > >> internal request to support bpf_link for sk_msg programs so user
> > >> space can have a uniform handling with bpf_link based libbpf
> > >> APIs. Using bpf_link based libbpf API also has a benefit which
> > >> makes system robust by decoupling prog life cycle and
> > >> attachment life cycle.
> > >>

Thanks again for working on it.

> > >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > >> ---
> > >>   include/linux/bpf.h            |   6 +
> > >>   include/linux/skmsg.h          |   4 +
> > >>   include/uapi/linux/bpf.h       |   5 +
> > >>   kernel/bpf/syscall.c           |   4 +
> > >>   net/core/sock_map.c            | 263 +++++++++++++++++++++++++++=
+++++-
> > >>   tools/include/uapi/linux/bpf.h |   5 +
> > >>   6 files changed, 279 insertions(+), 8 deletions(-)
> > >>
> =

> [...]
> =

> > >>          psock_set_prog(pprog, prog);
> > >> -       return 0;
> > >> +       if (link)
> > >> +               *plink =3D link;
> > >> +
> > >> +out:
> > >> +       mutex_unlock(&sockmap_prog_update_mutex);
> > > why this mutex is not per-sockmap?
> >
> > My thinking is the system probably won't have lots of sockmaps and
> > sockmap attach/detach/update_prog should not be that frequent. But
> > I could be wrong.
> >

For my use case at least we have a map per protocol we want to inspect.
So its rather small set <10 I would say. Also they are created once
when the agent starts and when config changes from operator (user decides=

to remove/add a parser). Config changing is rather rare. I don't think
this would be paticularly painful in practice now to have a global
lock.

> =

> That seems like an even more of an argument to keep mutex per sockmap.
> It won't add a lot of memory, but it is conceptually cleaner, as each
> sockmap instance (and corresponding links) are completely independent,
> even from a locking perspective.
> =

> But I can't say I feel very strongly about this.
> =

> > >
> > >> +       return ret;
> > >>   }
> > >>
> =

> [...]
> =

> > >
> > >> +
> > >> +static void sock_map_link_release(struct bpf_link *link)
> > >> +{
> > >> +       struct sockmap_link *sockmap_link =3D get_sockmap_link(lin=
k);
> > >> +
> > >> +       mutex_lock(&sockmap_link_mutex);
> > > similar to the above, why is this mutex not sockmap-specific? And I=
'd
> > > just combine sockmap_link_mutex and sockmap_prog_update_mutex in th=
is
> > > case to keep it simple.
> >
> > This is to protect sockmap_link->map. They could share the same lock.=

> > Let me double check...
> =

> If you keep that global sockmap_prog_update_mutex then I'd probably
> reuse that one here for simplicity (and named it a bit more
> generically, "sockmap_mutex" or something like that, just like we have
> global "cgroup_mutex").

I was leaning to a per map lock, but because a global lock simplifies thi=
s
part a bunch I would agree just use a single sockmap_mutex throughout.

If someone has a use case where they want to add/remove maps dynamically
maybe they can let us know what that is. For us, on my todo list, I want
to just remove the map notion and bind progs to socks directly. The
original map idea was for a L7 load balancer, but other than quick hacks
I've never built such a thing nor ran it in production. Maybe someday
I'll find the time.

> =

> [...]
> =

> > >> +       if (old && link->prog !=3D old) {
> > > hm.. even if old matches link->prog, we should unset old and set ne=
w
> > > link (link overrides prog attachment, basically), it shouldn't matt=
er
> > > if old =3D=3D link->prog, unless I'm missing something?
> >
> > In xdp link (net/core/dev.c), we have
> >
> >          cur_prog =3D dev_xdp_prog(dev, mode);
> >          /* can't replace attached prog with link */
> >          if (link && cur_prog) {
> >                  NL_SET_ERR_MSG(extack, "Can't replace active XDP
> > program with BPF link");
> >                  return -EBUSY;
> >          }
> >          if ((flags & XDP_FLAGS_REPLACE) && cur_prog !=3D old_prog) {=

> >                  NL_SET_ERR_MSG(extack, "Active program does not matc=
h
> > expected");
> >                  return -EEXIST;
> >          }
> >
> > if flags has XDP_FLAGS_REPLACE, link saved prog must be equal to old_=
prog
> > in order to do prog update.
> > for sockmap prog update, in link_update (syscall.c), the only way
> > we can get a non-NULL old_prog is with the following:
> >
> >          if (flags & BPF_F_REPLACE) {
> >                  old_prog =3D bpf_prog_get(attr->link_update.old_prog=
_fd);
> >                  if (IS_ERR(old_prog)) {
> >                          ret =3D PTR_ERR(old_prog);
> >                          old_prog =3D NULL;
> >                          goto out_put_progs;
> >                  }
> >          } else if (attr->link_update.old_prog_fd) {
> >                  ret =3D -EINVAL;
> >                  goto out_put_progs;
> >          }
> > Basically, we have BPF_F_REPLACE here.
> > So similar to xdp link, I think we should check old_prog to
> > be equal to link->prog in order to do link update_prog.
> =

> ah, ok, that's BPF_F_REPLACE case. See, it's confusing that we have
> this logic split between multiple places, in dev_xdp_attach() it's a
> bit more centralized.
> =

> >
> > >
> > >> +               ret =3D -EINVAL;
> > >> +               goto out;
> > >> +       }
> =

> [...]
> =

> > >> +
> > >> +       ret =3D sock_map_prog_update(map, prog, NULL, &sockmap_lin=
k->link, attach_type);
> > >> +       if (ret) {
> > >> +               bpf_link_cleanup(&link_primer);
> > >> +               goto out;
> > >> +       }
> > >> +
> > >> +       bpf_prog_inc(prog);
> > > if link was created successfully, it "inherits" prog's refcnt, so y=
ou
> > > shouldn't do another bpf_prog_inc()? generic link_create() logic pu=
ts
> > > prog only if this function returns error
> >
> > The reason I did this is due to
> >
> > static inline void psock_set_prog(struct bpf_prog **pprog,
> >                                    struct bpf_prog *prog)
> > {
> >          prog =3D xchg(pprog, prog);
> >          if (prog)
> >                  bpf_prog_put(prog);
> > }
> >
> > You can see when the prog is swapped due to link_update or prog_attac=
h,
> > its reference count is decremented by 1. This is necessary for prog_a=
ttach,
> > but as you mentioned, indeed, it is not necessary for link-based appr=
oach.
> > Let me see whether I can refactor code to make it easy not to increas=
e
> > reference count of prog here.
> >
> =

> ah, ok, its another sockmap-specific convention, np
> =

> >
> > >
> > >> +
> > >> +       return bpf_link_settle(&link_primer);
> > >> +
> > >> +out:
> > >> +       bpf_map_put_with_uref(map);
> > >> +       return ret;
> > >> +}
> > >> +
> > >>   static int sock_map_iter_attach_target(struct bpf_prog *prog,
> > >>                                         union bpf_iter_link_info *=
linfo,
> > >>                                         struct bpf_iter_aux_info *=
aux)
> > >> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/l=
inux/bpf.h
> > >> index 9585f5345353..31660c3ffc01 100644
> > >> --- a/tools/include/uapi/linux/bpf.h
> > >> +++ b/tools/include/uapi/linux/bpf.h
> > >> @@ -1135,6 +1135,7 @@ enum bpf_link_type {
> > >>          BPF_LINK_TYPE_TCX =3D 11,
> > >>          BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
> > >>          BPF_LINK_TYPE_NETKIT =3D 13,
> > >> +       BPF_LINK_TYPE_SOCKMAP =3D 14,
> > >>          __MAX_BPF_LINK_TYPE,
> > >>   };
> > >>
> > >> @@ -6720,6 +6721,10 @@ struct bpf_link_info {
> > >>                          __u32 ifindex;
> > >>                          __u32 attach_type;
> > >>                  } netkit;
> > >> +               struct {
> > >> +                       __u32 map_id;
> > >> +                       __u32 attach_type;
> > >> +               } sockmap;
> > >>          };
> > >>   } __attribute__((aligned(8)));
> > >>
> > >> --
> > >> 2.43.0
> > >>


