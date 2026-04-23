Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB829DB64
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949446; cv=pass; b=bh1lPVrQ/ICKzLYHZF9xn53kzjTZ/n+Ze3JzD60ilwwQbq3PvE8eWVUiK50gZfNzFVaeKbEFuegEfjUBs4+Gl8eYdrWgnZF25XF1aZLQpowcQYSSXvL/o218XZjUJwr+3IshFs/QahYXlVLk+LcH+gGKp4eAlDZXQ4nmeEJsfTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949446; c=relaxed/simple;
	bh=8FF26mb8E0TrtOaVeijnLuIzX+4gd+vVt030n0CwL0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbv+ROd5VA+fLbQK59mSVzQK5bu7oMLturn2pQ60uCmvBK1qnjCv1qazlET62cxeDp3vnJSnj2H1TUPlgl+LirttSw969m+ngHti3hufN9adDIj1TCkp8ib8ev/Y+pHp1bcQVwhj9fRUvgADO8L30MbGrCxYzRWSfaDbLaBN2NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEo0j4aw; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEo0j4aw"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c45281a06so8785039c88.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 06:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776949444; cv=none;
        d=google.com; s=arc-20240605;
        b=YV/hESPebZ50Y9V0bjeeRdc99fe2iE4m14rTQCzTC7nvYVgikGlUNzIhvfgxpAH1ke
         6StEqaL2CXkiGvakpz9oUzudyTgAHZibPEPVcchhD2tZuPQ1TwJnJnu2kFOYGcKnP8hS
         fNdStSqkzdCmnVqDMkQsUEjDZtBNbrphwLQYlzxFeVAWjdTbQnFxdPgtYKWn7tR1xFm1
         aDHWHWeEAVBY72McgCVktWwPFJU/UEyPJWVtDQ+tgT/hbU6aMHumXoCWfGhZWwutMUjz
         +bDgBlC7eV1HFUbBCZBEocnzThhkkgHz2JqtEEs8s26ZowQJJCFwJbOoJZFkcBkbMxQc
         Rb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/TiFSwPpA9mYVqELcqFDz1TcWtB/yHTcPJJWGTStDmM=;
        fh=9ncFnseAW7Y04S6sGHtLminLSiUE2CxLHrI7ALNAEaQ=;
        b=HKHEHJkm+KzWoNbj7+PlXBP8k/0//fkjG63Kb2R9XoB/3AH8R6Wa6u9Yjfy1Y1zi7h
         lMKYcu9H0oqFDZOL06tQv+rTPE02nRU8Wpc6P+OE1pVBa0CkkJjfIfI2DKTKS5+vaq84
         jFy5LFI0ke3x0S70drgaWNf3SpxktyHr1GxPs5w4rmqBhMTd+nQr0JDqCmPDHbWGKowt
         ZRFot0CUGQtPdz9Q+A+CqYUOrCbkMffXX1K0lI1HfOPIXKKTwO1Hf6yh0IsNmNNWDq1r
         MKnt6a1j2aC/E8iLwvAdyNvuODN4EzOC9ak25E80PzBeqzkxR6FMdnXKVsSaxWa0jjln
         psAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776949444; x=1777554244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TiFSwPpA9mYVqELcqFDz1TcWtB/yHTcPJJWGTStDmM=;
        b=PEo0j4aw5geGxJPczuStFVqxJZ4rbWINneLGpcFAV/3FLY6X/5TGcw6vNxsPz8d3oe
         +vYwLXJr3rtV2iS7xQjTy0kV424PX/ei0PCobCXm64M04MXrZFTpE5/kDQ0Lhcz71EWH
         hu2hxiC6JIo0wEqi8NzTDPWxdtE8xSLRsjvtJWcNtJDW+6NBsCR2UBen7UoKkJgreAmu
         rXwHEsVFZ0CzCV46Ha3QgCBLAVuG3aXNCswLsL2tWw9I7sH2zy3bpwElt5ukvPieIWRB
         fS3ABSuC9WLU3++BslaDkOpjZxotOzm2V10OHqeggaq8HlUoyhGACjHG3WhrvS+wS/w1
         /xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776949444; x=1777554244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TiFSwPpA9mYVqELcqFDz1TcWtB/yHTcPJJWGTStDmM=;
        b=aphtzUm7cGM/61bM1iVYLPiSK6V+B/WGM3JraCmdNbCj7Am5ZAn2eZkrg4YpScyEW5
         PBfHygSXoSgJJQN2IQ8Le6gvhehSAswPqARqzDcWBWPXSjxW7ZPVHz49+2Js0T+jSJSY
         UvryuE2S8gRL99muvdPScZuYt6QybaHOdP+T3MQ8MN1fhr0hZc9dGvt28Vi8Plq6vL4O
         77tUxalqgmzHlZ0DFWr3tn2YCQU1p4/tkcZug84SNSP5+lgL/uL3AkEQXPqBiA+YaVbm
         rJLfERvRvrlD7DLgkc+dRsJtYCgXS/GS7K3VA6IiWFAUGfdyQp64R8cEexw71IysO6PK
         75QQ==
X-Forwarded-Encrypted: i=1; AFNElJ8s0KqUtK4RtUm2893d8WfTe7QYQ5uH20co8a04MtsUuOchju/dZWAwy5GXPgIUZGnSczI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BlWoYjX3+0ABeCPjwCFUu2pM5ReqUBagn1gFNPz96yBa2tBS
	zMQTw4o37wTDcmbwa2Aw+GFje8jz9D/OqknsI7Um7XNh5S8wV1Qw7NLm6ypgowDes/D51Ng/Vfi
	M1/KRnqyLtzqC33EA3RDs2VD+CR3kzgM=
X-Gm-Gg: AeBDiesRttcZcHbblxoemPz+prBz+S+Uivu0BqDDhv/psm+FmguJb7VdKAv1aXgbJc3
	+5JrWmixsB6lOb4sIhZRb9Ky7PnzQ3SmuS9YjsUNQF1Ot0Bv1UX1b2ABFbCiMfMR1E4BGT8J/FH
	dkmslFYCNTywpe/m56Rys2tNKEGEkt8HLAa9W/gcPMkBxZdvu4yfI5xlPr+tY1m2RobjViA91SQ
	z40Z7Nln2gww2kipAM39RqS+UqJmgt1O1UmLfDcNyT7ufZIMfltp8d0NvFFa/idZD8ixCGxjmdZ
	+iN8WAfZbYZ+sDREq13jALkAYoFhQSXaNb135VUiHdITaX9DqQ==
X-Received: by 2002:a05:7301:168a:b0:2d1:815f:19c1 with SMTP id
 5a478bee46e88-2e479c0427dmr12992747eec.15.1776949444189; Thu, 23 Apr 2026
 06:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com> <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
 <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com>
 <aej+JZyYwUrRXD6e@boxer> <CAL+tcoBH9qm0Ce=vBuCResVEbC_9a1D2VofTW73Uo+t519Ui0A@mail.gmail.com>
 <f78a505b-6be1-4b4b-86f4-005d709e0253@intel.com>
In-Reply-To: <f78a505b-6be1-4b4b-86f4-005d709e0253@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 21:03:23 +0800
X-Gm-Features: AQROBzD4k1mHNI17wfn3lWtGGtS8eQLUBW2cu6UV4dKTucG_vxA1xkpjqtb1tN0
Message-ID: <CAL+tcoCmcT0PFwwFr+ZxL8qtWXmukepUChZjU78oTZpZ-j0D0Q@mail.gmail.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 8:15=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 23 Apr 2026 07:49:58 +0800
>
> > On Thu, Apr 23, 2026 at 12:58=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> >>
> >> On Thu, Apr 23, 2026 at 12:37:07AM +0800, Jason Xing wrote:
> >>> On Thu, Apr 23, 2026 at 12:10=E2=80=AFAM Alexander Lobakin
> >>> <aleksander.lobakin@intel.com> wrote:
> >>>>
> >>>> From: Jason Xing <kerneljasonxing@gmail.com>
> >>>> Date: Wed, 22 Apr 2026 11:36:50 +0800
> >>>>
> >>>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>>
> >>>>> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> >>>>> descriptor address into skb_shinfo(skb)->destructor_arg (void *) vi=
a a
> >>>>> uintptr_t cast:
> >>>>>
> >>>>>     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | =
0x1UL);
> >>>>>
> >>>>> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits =
of
> >>>>> the descriptor address are silently dropped. In XDP_ZEROCOPY unalig=
ned
> >>>>> mode the chunk offset is encoded in bits 48-63 of the descriptor
> >>>>> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset=
 is
> >>>>> lost entirely. The completion queue then returns a truncated addres=
s to
> >>>>> userspace, making buffer recycling impossible.
> >>>>
> >>>> What if we relax the restriction a bit? For example, refuse to confi=
gure
> >>>
> >>> As to the bug itself, yes, It only affects the unaligned mode.
> >>>
> >>> I wonder if we can support this after someone requires us to support
> >>> 32-bit arch and use it in the real world, then we can use the previou=
s
> >>> patch to complete the full support (which doesn't harm the path on
> >>> 64-bit arch).
> >>>
> >>> The code looks like this based on your suggestion. Just for the recor=
d.
> >>> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> >>> index 58da2f4f4397..03417b04592f 100644
> >>> --- a/net/xdp/xdp_umem.c
> >>> +++ b/net/xdp/xdp_umem.c
> >>> @@ -177,6 +177,9 @@ static int xdp_umem_reg(struct xdp_umem *umem,
> >>> struct xdp_umem_reg *mr)
> >>> if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
> >>> return -EINVAL;
> >>> + if (!IS_ENABLED(CONFIG_64BIT) && unaligned_chunks)
> >>> + return -EOPNOTSUPP;
> >>> +
> >>> if (!unaligned_chunks && !is_power_of_2(chunk_size))
> >>> return -EINVAL;
> >>>
> >>> Actually I'm fine with either of them. Right now I'm not so sure whic=
h
> >>> direction this patch should take :)
> >>
> >> Abstracting from discussion, that is not a patch we would want against
> >> -net. We should not forbid 32bit on stable kernels, maybe there is som=
eone
> >> in the 'basement' using 32bit xsk on stable kernel. Plus the fixes tag=
 vs
> >> patch's content looks weird ;)
> >
> > Sorry, I don't follow this. Any specific suggestions on how to move for=
ward?
>
> Maciej just says that if we go the first route (forbid 32-bit arches),
> then this commit should not go to the stable/LTS kernels.
> But
>
> >
> > Now we have three approaches w/o the fixes tag:
> > 1. completely forbid 32-bit arch
> > 2. only forbid unaligned mode on 32-bit arch
> > 3. completely fix/modify the allocation logic of the first frag on
> > 32-bit (see the v2-0008 patch)
> >
> > I'm wondering how to proceed with that?
>
> I've just reread the v2 thread (I realized I missed it earlier) and to
> me, the v2-0008 (route 3) solution looks good. It introduces a bit of
> overhead, but only for 32-bit arches, where the XSk performance will
> never be push-it-to-the-limit anyway (esp. given that this is skb mode).
>
> So I'd personally vote for number 3. 47 insertions(+), 7 deletions(-) is
> not a big deal. And for 64-bit arches, there won't be any object code
> changes at all (unconditional `return 0` and checking the return value
> of xsk_skb_init_misc() will be optimized out by the compiler).
>
> Number 2 is also okay-ish, if we're sure that addr is always 32-bit on
> 32-bit arches in the aligned mode. But given that you already has a
> proper fix (n. 3) which allows to not forbid anything at all, I believe
> it's more preferred to fix rather than disable.
>
> + as mentioned above, if you go route number 3, the series could be sent
> to -net and the fix would eventually hit the stable/LTS trees, but I
> don't think we can disable/forbid something in the stable kernels.

Thanks for the explanation!

I will submit solution #3 to fix this issue. And the v4-0008 should be
simpler. We'll see :)

Thanks,
Jason
