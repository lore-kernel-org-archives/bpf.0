Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE914C58A
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162635; cv=none; b=PONlRwebOoTGv+DxrUfXET1u+GMKpTy2zwPDJWB6YXsd6xLt40KIb2qJlU1MWIOEUb827kNa4muMN0Liqpye9C3p5Sv9IpSN9xSVcBaBbrJDVs/pr2Nly0K10MSBdiYZDd/kdeiEgIz9iClt/fm+GSa9l5N/KF6SD7ZEOX4/P6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162635; c=relaxed/simple;
	bh=jACUHapW8PMfuuaXjoFQ1kdZAAiQjDy7YdWyxXFd0BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkR4bXzESrGXKu04/7cDfYuj3cetduRfkhCJHbKtMvFftRDO/5sp2hNGTA7kWMlhXVwIe89/IPbB1mA2vYC5sR2VynsGqS4vUv328zSoXfWUhpUkY0TD47Q3d3jSuTmRmAQEYBZO8l4qZL+MQdIRKjrGvdiVA78F0OcpMyotEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeslVzjP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeslVzjP"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso59274a12.2
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712162633; x=1712767433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaZBsw+QRqEcUvheGyx7e+VMS3CvLvPjb0aHRd/qMPY=;
        b=BeslVzjPue/iS15d6FXXZoDw6+0Fi/ezbq0UV+3ySs/tq5OpE1PMHl2ZrTtJPaLEOV
         B84WAD3nsUVj/hMs0ABpngT5EaKBvgzUHchZw8fVbB08vXTkp73Vf6+ML3tY8NmxfcgH
         pLWF5ZtWCO2iK5mSuG9wOVuzZjvnEU8ILi3Rnp89sqneIwaSs36rnEyoSISxKFhhve4E
         HPXdpyBaKh9m1GXCEeO6MkEX7tq3s/Tta1blDg08neEbjl/0NH5vfJJyi7401tHfMruZ
         xZPov8HHYhq6EIxIQZ5OyeMeyjo6LY+2z9WIFAGnjtyBpL3NGmCVUBojUThZMudCXOEI
         a7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162633; x=1712767433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaZBsw+QRqEcUvheGyx7e+VMS3CvLvPjb0aHRd/qMPY=;
        b=Q8czIEFk6jNNXt/z27t+8DTFtw0Lqgr0Ro+WmmxVVbSBgGgStknOS11jYLzDI5Ucrh
         t/nqtcxyYx6mETC75Ri7do0TtfUvpBo4waGtCq86EJdHQ2clKSjKC2CxkHfA/tSlHopp
         9rulNT3uXWHnlJX0+L1lmHtBrS6pvtlQbPtdvhD12pL7DsOfmRQIpg8px69BObUIsoRW
         /9MoIs1PeDJPe0g1gZjh61cCLD1FNY2vQru6FgecXypsAVaTtgf8NB9zI3KAl8CVmsan
         f6qQqzZqiQBgSb0JhxgEag340EVSrkyoA7rNx12/8Iw+qDwg+Tar3m9KqGPzUr8uGedx
         +lOw==
X-Gm-Message-State: AOJu0Yyo7AQVyArzN7bkpl6IA69MhHexA4mD34P3egcBY+wn/iNOdj9f
	9Ps0TN+Om2MZaHRb2mxPX3vU62kSKgku33/C9eFnwvkJ0CgPKZL8CJ/B4mVQn11MTIih0/zYmOM
	jTNAaU3CGGsSwpkLkBq1kBO1/8Ck=
X-Google-Smtp-Source: AGHT+IEKR38dLUfMNk81bfyMxBpezuQrzhgCCMS/BFSPAD5OztoS0QE6T5jn1LhUxxiYaxY/BP3o1zSOrnL8Wqq7nik=
X-Received: by 2002:a17:90a:fe0e:b0:2a2:50ef:ece2 with SMTP id
 ck14-20020a17090afe0e00b002a250efece2mr55874pjb.17.1712162633179; Wed, 03 Apr
 2024 09:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev> <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
 <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
In-Reply-To: <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 09:43:41 -0700
Message-ID: <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 6:08=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 4/2/24 10:45 AM, Andrii Nakryiko wrote:
> > On Mon, Mar 25, 2024 at 7:22=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Add bpf_link support for sk_msg and sk_skb programs. We have an
> >> internal request to support bpf_link for sk_msg programs so user
> >> space can have a uniform handling with bpf_link based libbpf
> >> APIs. Using bpf_link based libbpf API also has a benefit which
> >> makes system robust by decoupling prog life cycle and
> >> attachment life cycle.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   include/linux/bpf.h            |   6 +
> >>   include/linux/skmsg.h          |   4 +
> >>   include/uapi/linux/bpf.h       |   5 +
> >>   kernel/bpf/syscall.c           |   4 +
> >>   net/core/sock_map.c            | 263 +++++++++++++++++++++++++++++++=
+-
> >>   tools/include/uapi/linux/bpf.h |   5 +
> >>   6 files changed, 279 insertions(+), 8 deletions(-)
> >>

[...]

> >>          psock_set_prog(pprog, prog);
> >> -       return 0;
> >> +       if (link)
> >> +               *plink =3D link;
> >> +
> >> +out:
> >> +       mutex_unlock(&sockmap_prog_update_mutex);
> > why this mutex is not per-sockmap?
>
> My thinking is the system probably won't have lots of sockmaps and
> sockmap attach/detach/update_prog should not be that frequent. But
> I could be wrong.
>

That seems like an even more of an argument to keep mutex per sockmap.
It won't add a lot of memory, but it is conceptually cleaner, as each
sockmap instance (and corresponding links) are completely independent,
even from a locking perspective.

But I can't say I feel very strongly about this.

> >
> >> +       return ret;
> >>   }
> >>

[...]

> >
> >> +
> >> +static void sock_map_link_release(struct bpf_link *link)
> >> +{
> >> +       struct sockmap_link *sockmap_link =3D get_sockmap_link(link);
> >> +
> >> +       mutex_lock(&sockmap_link_mutex);
> > similar to the above, why is this mutex not sockmap-specific? And I'd
> > just combine sockmap_link_mutex and sockmap_prog_update_mutex in this
> > case to keep it simple.
>
> This is to protect sockmap_link->map. They could share the same lock.
> Let me double check...

If you keep that global sockmap_prog_update_mutex then I'd probably
reuse that one here for simplicity (and named it a bit more
generically, "sockmap_mutex" or something like that, just like we have
global "cgroup_mutex").

[...]

> >> +       if (old && link->prog !=3D old) {
> > hm.. even if old matches link->prog, we should unset old and set new
> > link (link overrides prog attachment, basically), it shouldn't matter
> > if old =3D=3D link->prog, unless I'm missing something?
>
> In xdp link (net/core/dev.c), we have
>
>          cur_prog =3D dev_xdp_prog(dev, mode);
>          /* can't replace attached prog with link */
>          if (link && cur_prog) {
>                  NL_SET_ERR_MSG(extack, "Can't replace active XDP
> program with BPF link");
>                  return -EBUSY;
>          }
>          if ((flags & XDP_FLAGS_REPLACE) && cur_prog !=3D old_prog) {
>                  NL_SET_ERR_MSG(extack, "Active program does not match
> expected");
>                  return -EEXIST;
>          }
>
> if flags has XDP_FLAGS_REPLACE, link saved prog must be equal to old_prog
> in order to do prog update.
> for sockmap prog update, in link_update (syscall.c), the only way
> we can get a non-NULL old_prog is with the following:
>
>          if (flags & BPF_F_REPLACE) {
>                  old_prog =3D bpf_prog_get(attr->link_update.old_prog_fd)=
;
>                  if (IS_ERR(old_prog)) {
>                          ret =3D PTR_ERR(old_prog);
>                          old_prog =3D NULL;
>                          goto out_put_progs;
>                  }
>          } else if (attr->link_update.old_prog_fd) {
>                  ret =3D -EINVAL;
>                  goto out_put_progs;
>          }
> Basically, we have BPF_F_REPLACE here.
> So similar to xdp link, I think we should check old_prog to
> be equal to link->prog in order to do link update_prog.

ah, ok, that's BPF_F_REPLACE case. See, it's confusing that we have
this logic split between multiple places, in dev_xdp_attach() it's a
bit more centralized.

>
> >
> >> +               ret =3D -EINVAL;
> >> +               goto out;
> >> +       }

[...]

> >> +
> >> +       ret =3D sock_map_prog_update(map, prog, NULL, &sockmap_link->l=
ink, attach_type);
> >> +       if (ret) {
> >> +               bpf_link_cleanup(&link_primer);
> >> +               goto out;
> >> +       }
> >> +
> >> +       bpf_prog_inc(prog);
> > if link was created successfully, it "inherits" prog's refcnt, so you
> > shouldn't do another bpf_prog_inc()? generic link_create() logic puts
> > prog only if this function returns error
>
> The reason I did this is due to
>
> static inline void psock_set_prog(struct bpf_prog **pprog,
>                                    struct bpf_prog *prog)
> {
>          prog =3D xchg(pprog, prog);
>          if (prog)
>                  bpf_prog_put(prog);
> }
>
> You can see when the prog is swapped due to link_update or prog_attach,
> its reference count is decremented by 1. This is necessary for prog_attac=
h,
> but as you mentioned, indeed, it is not necessary for link-based approach=
.
> Let me see whether I can refactor code to make it easy not to increase
> reference count of prog here.
>

ah, ok, its another sockmap-specific convention, np

>
> >
> >> +
> >> +       return bpf_link_settle(&link_primer);
> >> +
> >> +out:
> >> +       bpf_map_put_with_uref(map);
> >> +       return ret;
> >> +}
> >> +
> >>   static int sock_map_iter_attach_target(struct bpf_prog *prog,
> >>                                         union bpf_iter_link_info *linf=
o,
> >>                                         struct bpf_iter_aux_info *aux)
> >> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux=
/bpf.h
> >> index 9585f5345353..31660c3ffc01 100644
> >> --- a/tools/include/uapi/linux/bpf.h
> >> +++ b/tools/include/uapi/linux/bpf.h
> >> @@ -1135,6 +1135,7 @@ enum bpf_link_type {
> >>          BPF_LINK_TYPE_TCX =3D 11,
> >>          BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
> >>          BPF_LINK_TYPE_NETKIT =3D 13,
> >> +       BPF_LINK_TYPE_SOCKMAP =3D 14,
> >>          __MAX_BPF_LINK_TYPE,
> >>   };
> >>
> >> @@ -6720,6 +6721,10 @@ struct bpf_link_info {
> >>                          __u32 ifindex;
> >>                          __u32 attach_type;
> >>                  } netkit;
> >> +               struct {
> >> +                       __u32 map_id;
> >> +                       __u32 attach_type;
> >> +               } sockmap;
> >>          };
> >>   } __attribute__((aligned(8)));
> >>
> >> --
> >> 2.43.0
> >>
