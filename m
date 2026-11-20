Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795140444;
	b=xNUoiud0YtkTQs8XMZYHCHbGuQ7W8nL7VK2KnAQJgxT8ApCqT2Kle+NfvhuPMXILvGYb
	 7naUebxGNp39ngNX3igAq4Q5qBGlKl/aTBp/Wi5TvzC9VnnJbWH2MmG/9lVBcGyO+wb8B
	 IzNJ9VAhfs6BBl46NkHOtOI/2sVaV4J9oMRgiMGKY/fsxg5NKNYPSth/d5dk0dHeP89lm
	 GDtRl31IB+YQAdDqSZAJIfiAY3pOPdpMW1zFKF8PIVclE5pjYCUBhrXKT/dM+roLWX0Ny
	 Uz2hHur1GwPT3CVhd3OEKE0NDC2CVWQ5be2p8w5YPwGpmTc1usy5JH286qZhWZj6Llg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795140444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hDx+3ef29Cqeb19P1wrP4Jxu4NbJSoAn5O0Zy1TjVKI=;
	b=Z+Z0WFYIS7zfb2diWy5Gyih1P1GJH+4q9KLPx1cOyjH/a2ouFlOOZMWpIM8T//NLDi+5
	 v9Ry1dqxGqQ/6V6ABaRJJGsmZYXMpJqtyt2iCpUqL+eirVKoVlwyMIasKk7TlLDp0zOhJ
	 5/b26Jzpb2Aj/yDpwH6Qzqaw2Xs1yfgzIU8ug5RqRDD1fGWqIKVAOv3zH68e2tt3MLp+C
	 J4oXIVWC0598j8+haRXMQxxjhnrDyES+S1v6BxVI4igvvuGXa2qXosqvdc4DsKMu/tIDk
	 ANO1zi73lXpiuCs+JzzyjPTt15i8xVZpQue8jKvcfjuxOyVd5GAR+AUtXP0MN0DCytA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zr8fkb5i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A339606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 02:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A339606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zr8fkb5i
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-949657a20d7so52059485a.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 18:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795140442; cv=none;
        d=google.com; s=arc-20260327;
        b=L19S8c5K7Gl7Kep9njB5DtzsdTj0IrJEH97LVH1srb64nZbUOPOxtHr6CUiMiqa633
         A5x9AtGMYY3W7HZgrQnBSQLHR7ieb/ZNgW0+uWnZ58hscufiCwHhREgKktxyS6mRlEr5
         qhruBh23PzkJoN3Q9MVvH7qdxxCD3sONIW8rkTHXwr4Sc5OvZw2zU0GbDGpDnUt3oS0r
         ZEBWRXcPTLncivOmqJcgwzIA4ARkV7pjZ35ZbviUgrHd1XsCJyrql9ExqFcwFI/oKK2t
         DrAR6M0UivEKu/XA35lI7b9RVz+IIYfpHgWCd/Djkdt/THBrXj7aGu1+G7vwUMwGTiYW
         B1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hDx+3ef29Cqeb19P1wrP4Jxu4NbJSoAn5O0Zy1TjVKI=;
        fh=WfRBuvcimzC0dvQwoyCfDRlUgP3HRPoA0PtGDrOBsXE=;
        b=VqtQB01+g5KvhYbKd0uGtTcfSdMJOr//RiEm9UKYPqUGHaiLhRkfrmU/DGr7pYcLCY
         i/30eNQW7rck+VJR7w2UJI0hymBjuF9OpsfM25/VzKtZyOeSK2WhSacTAE2Sq/8G20Fm
         npWlbSWVCieT6FgtdfsjG7afGlQ0p0vGWRr/gkxTR+8JdzvL4EWWW0UsvAs55cO566JD
         qlM1jYAsS0QTmflKhgzPr/49MqOULS7DaqpMybch21gyUYCeE0HMYFmhnVZaD2x4K4b/
         WV0A89QuRiOtfST4Zw6lQXULvmRHJwYGB7vxqry9GvdrRJixQbbYVf1zGIQBUHdwtJmZ
         SWMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795140442; x=1795745242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hDx+3ef29Cqeb19P1wrP4Jxu4NbJSoAn5O0Zy1TjVKI=;
        b=zr8fkb5iFA5tOJKD9Rew/fwEuZfwcr9/wKTLaYKfTTh0zX5puG9AMdSy4nbvreen8f
         PZF9j8+mXU0kJLn+dFvSPZfAAjrhr9R5xC1v+ezAYo+zc56GgxP4+kr0jG+/VTTeP0jQ
         Mv3mP7HEzX86vYpUnoe5pM2UYL4juFbShSXgY00xGI9B9Ws8044ZhnGF2arKdYoBnTK6
         8OwAANa61uOQv862Ofu4zX6lhsUpr0mE8dhIiUu4fhULv6cY+uiKMiRNC/Cm84Y2BtyP
         N7YT8MgnsWJuRUqTv9Kdni+uEs7w4UnmHzqu1LsUxqqvF+l2TK5kPXphpSb0Iu/6NVSF
         exYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795140442; x=1795745242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDx+3ef29Cqeb19P1wrP4Jxu4NbJSoAn5O0Zy1TjVKI=;
        b=cQH8thrsP1i5EAgtrmlClvCcTzub9SMXbfMzJ4yzEfwhfzosYQDBBlPHHLZQsa7xck
         8Xcfpk2vcv72hFeMbD/HjZA+xHq+QikU3UtbYIb3x5omTJtVMIAmWby5qX7h14uHESq6
         c9HLA4nXJax+TVl7qSybNgn3IsWjJigXVaEO7/Q2XavnOl+gjAymmx0Y6jACnG2n8OVf
         YanbSU9JzFvJ1qrXae1b0sdbzPaWnu9DELi0xF6AvL0hrZmcs/4H9UryCzh76LvaAgZb
         pQJb3UE68/8/P2jkZ1kKZtWzfWa1JEzTWnOjP+FuZagwBnZyabaCunu1kb5FpWsX/8Uy
         /4Mg==
X-Gm-Message-State: APuU4Z+rMoUWO0FfvNpTV6EotRj/6K/Ixbh/FCvxmBPfQdjlhbxcDUAZ
	IlO8gxS6pyVn+/pSCJCgkvx/Rf/xu+GKOmjBZMJi54BOr4tmfMkarP8yoZdV/VSKdWf59LsG9ew
	NL/9IKv9eFQn+NTX0HI2RcM6o7BD8g29IiUIRzKjwmg==
X-Gm-Gg: AZFdTZdIgCUol9JzFAyC/7WSeALfw4y4GX0/yRhYEWa+mRtS5j0Mcdve6/WCcBHTZ7X
	UeORhvbR0waKNFbwTCwau818ETsxPbcNw0uZbJHAWAtwD/pw0vK/lYEPHUBU1fOcGxVpi7tsWBR
	dSWTmrLQzrLnagwDOeA5+AGMl70tGDwkMsdDW/GqA0lhBlx/YAVPry/a9c3SzSViAt1vZ8J++i6
	pnAYfXPnpo3bn24A4OhfWNI5o2PvA13y4eePEyjOr0coTesK2Q2ObrigplKSAQsWiURBv/qaRLt
	sPEMTZ2V4OI6eEYQZlzTrZHXQqF4VIE+KBb7R8vknUMPeH7A8Fe7tDjuxMGvV7INAzhl7eai0yS
	E8nEgSVcl+NbQ5wh9Wj24G9KbMCAG8MlGyVviooMuf2DTtWCrTIplMQvQFCRIrhuctS880Zk9Oc
	6bLouDW58ZfC+DYUnEuA==
X-Received: by 2002:a05:6214:8605:b0:91f:808:3ca3 with SMTP id
 6a1803df08f44-9213497c81fmr31805746d6.1.1795140442286; Thu, 19 Nov 2026
 18:07:22 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMcAce-ytH2Xt_0+1fKXzxy+a8fi0Md-4SSoLZ1RQxKQoLq-tw@mail.gmail.com>
 <av9Wm6HQ-DIgFhfw@krava>
In-Reply-To: <av9Wm6HQ-DIgFhfw@krava>
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 21:07:10 -0500
X-Gm-Features: Aa3M54pd38stwrQ1r38JPH4RJjMwQ2y84tlYNALUI9495C_JMN3Wxjb92Ofc62I
Message-ID: <CAMcAce-LRjmaKoQcsvkU4L+JHWfoGNKx8xFsxiwEADcgQ1m6dA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Replace DECLARE_EVENT_CLASS names in raw_tp_null_args[]
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, 
	linux-nfs@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review and corrections, Jiri.

Dropping patches 2 and 3 as requested.

(Note: Patch 1 [bpf_lsm_release_secctx] was re-submitted as a
standalone v3 and has passed CI.)

Thanks,
Yingke

Jiri Olsa <olsajiri@gmail.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=8819=E6=97=A5=
=E5=91=A8=E5=9B=9B 15:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 19, 2026 at 02:18:29AM -0500, Yingke Xiao wrote:
> > btf_ctx_access() strips the "btf_trace_" prefix from attach_btf_id
> > and matches tname with strcmp(tname, raw_tp_null_args[i].func). Because
> > each attachable tracepoint typedef corresponds to a DEFINE_EVENT() name
> > rather than its DECLARE_EVENT_CLASS() template, three existing entries
> > in raw_tp_null_args[] never match any program:
> >
> >   1. "nfs4_inode_callback_event" and "nfs4_inode_stateid_callback_event=
"
> >      are DECLARE_EVENT_CLASS templates in fs/nfs/nfs4trace.h whose
> >      DEFINE_EVENT instances are nfs4_cb_getattr (:1455) and
> >      nfs4_cb_recall (:1518). fs/nfs/callback_proc.c:50,106 pass literal
> >      NULL for arg 2 (const struct inode *inode), and TP_fast_assign
> >      (:1424, :1481) checks !IS_ERR_OR_NULL(inode). Keeping 0x200
> >      (0x2ULL << (2 * 4)) sets ptr_err_raw_tp =3D true so btf_ctx_access=
()
> >      assigns SCALAR_VALUE to ctx[2], rejecting any pointer dereference
> >      even under if (inode) and matching existing raw_tp_null_args[]
> >      0x2-nibble convention (0x300 yields the identical SCALAR_VALUE).
> >
> >   2. "iptfs_ingress_postq_event" is the DECLARE_EVENT_CLASS template in
> >      net/xfrm/trace_iptfs.h:108 whose DEFINE_EVENT instances (:130-148)
> >      are iptfs_first_dequeue, iptfs_first_fragmenting,
> >      iptfs_first_final_fragment, and iptfs_first_toobig.
> >      net/xfrm/xfrm_iptfs.c:2025 and :2051 pass literal NULL for arg 3
> >      (struct iphdr *iph), requiring mask 0x1000 (PTR_MAYBE_NULL).
> >
> > Replace these dead template names with their DEFINE_EVENT tracepoints.
> > Verified in QEMU on x86_64 7.4.0-rc3 (iptfs_first_{fragmenting,
> > final_fragment} and nfs4_cb_{getattr,recall} flip from LOADED to
> > REJECTED) and 6.12.118 (nfs4_cb_{getattr,recall} flip from LOADED to
> > REJECTED; iptfs_first_* absent in 6.12).
> >
> > Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
> > Cc: stable@vger.kernel.org # 6.12+ (nfs4_cb_*)
> > Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
> > ---
> > v1 -> v2:
> >   - Correct sender identity and Signed-off-by with real legal name per =
DCO.
> >   - Remove drafting notes.
> >   - No functional code changes.
> >
> >  kernel/bpf/btf.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
>
> patch is mangled/broken, can't apply it (check Documentation/process/emai=
l-clients.rst)
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index a123456..b234567 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6605,10 +6605,13 @@ static const struct bpf_raw_tp_null_args
> > raw_tp_null_args[] =3D {
> >   { "bcache_journal_entry_close", 0x20 },
> >   { "bch2_journal_entry_close", 0x20 },
> >   { "fsnotify_bump_event_seq", 0x20 },
> > - { "nfs4_inode_callback_event", 0x200 },
> > - { "nfs4_inode_stateid_callback_event", 0x200 },
> > + { "nfs4_cb_getattr", 0x200 },
> > + { "nfs4_cb_recall", 0x200 },
>
> seems correct
>
> >   { "nilfs2_transaction_entry", 0x4 },
> > - { "iptfs_ingress_postq_event", 0x1000 },
> > + { "iptfs_first_dequeue", 0x1000 },
> > + { "iptfs_first_fragmenting", 0x1000 },
> > + { "iptfs_first_final_fragment", 0x1000 },
> > + { "iptfs_first_toobig", 0x1000 },
>
> llm says:
>
>   =E2=96=8E Only iptfs_first_fragmenting and iptfs_first_final_fragment p=
ass NULL
>   =E2=96=8E for iph (net/xfrm/xfrm_iptfs.c:2024, :2050). iptfs_first_dequ=
eue and
>   =E2=96=8E iptfs_first_toobig always pass ip_hdr(skb). Since the old cla=
ss entry
>   =E2=96=8E never matched, adding those two would start rejecting existin=
g
>   =E2=96=8E programs that use iph without a NULL check, even though it ca=
n't be
>   =E2=96=8E NULL there. Should we add only the two NULL-passing events?
>
> jirka
>
> >  };
> >
> >  static bool is_raw_tp_null_arg(const struct bpf_raw_tp_null_args *entr=
y,
> > --
> > 2.43.0
> >
