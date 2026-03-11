Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088F30276A
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256664; cv=pass; b=EvNWGnyu4uMIWBXN280Q5+yLyPlLFko9q2JXBm2R54z4jnL3V63Jd8jZlaZB4SWRaFa07gqRXFfFYY2KsxJhGXVpUEHWEjTHCIPOn0p1S/M+p0cynMLPzVmcuWPxpiruZtquumZIuIkOd7UNAzlRYUoNAGD8uyBEUXXLXQbPa8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256664; c=relaxed/simple;
	bh=/uUmggfY2CUHiqAaH0R0z+H13zc5qb3LxZdLKCUPVtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fag9rC6OjiWqrCjHUOqzZV+Rvmodrxph3nF1SJK+L13Trbehs+SFRaGbYQT+llxAxKlqFqq3vt2ZSXT8DgZiLkhhSDx3AuJC6CspJpTA/K5y6EZ/wN6Li0x65hy5poePqqEj2FYa5KuWilnlK5Y1shdXF66p/ZQX0P4fSBqJYSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEms9Fbu; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEms9Fbu"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82418b0178cso144876b3a.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773256662; cv=none;
        d=google.com; s=arc-20240605;
        b=Qic9zpdOSoJcuAXBiC/bZeMzZRkZr1Q68OlbDDjeeOpg/C+E4NwU4mv3WLGSVwsuuW
         MrwsNQ16IiyN+vUdZ5aLp1zQBvxCqsjIPO6e5valk0b6CulIO2Zb0RYdgB9K/nFKafyO
         LdMfrWGfKIfl/uuyrssUYG161nRX0HHQzLzLSXJ2p/NoZ/3xYJ+SWgplXOltwZZghyFC
         +fSUnwnKlTmEXtI6JBJs58sFptP6wJLHuSPna2Je++GP0Bha76zSgvBzSH+as0PkXLu6
         z0A3/vcK67B6p3tkIKYUZf3i1/udGr0cFQq57e3jxIyHd8kPp3QcvU3yaJO2pEeg05jw
         I3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VRmJNSJ3qZ2Eng7Vqt6hsR5JdtYM6RjGEdDsdmytJPg=;
        fh=DA+NUWykgqWgE857rlbgwbEK1AMJ9pie2eJpGyUVAO0=;
        b=F6luNs4ryU4cpribeSO+vmk84L5rwmF3jPEhaMpLEF3RYMlZz4IHBy54SEi7R993CT
         NpmDbLspEnGdq+8ipOrjSAu/pjf3AsgEx4y0upktNfnnAW7UfyeERw4zoROnsb/xvmuK
         /SGd17yZTecH08VOORTJ6Nmoz/LZ191enXwpwlzVSsA3LQbtQcq1D1uYB0Z3Odw75U0b
         rX4nPvG9KuASIhtfeLs6AMwMPbdIC2J0fIoAY07obuJZ1XcNskdd7m3bqIS/Nixwz8NF
         eITsNjmj/d5ctX+0COuZ104TTe8v4SSBMYJN592kWUTkhrys9JC43/YHK89veFTnNdeM
         S17A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256662; x=1773861462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRmJNSJ3qZ2Eng7Vqt6hsR5JdtYM6RjGEdDsdmytJPg=;
        b=TEms9Fbu8HDoS6UwIp7U9PIh/Mu8IIanCeOoThD1me3hSWlCu2KOx2r2TkemNJYdUV
         A9bowucPlosCxCtCVwoTaoSD19kMcFzYGjsM1cUEyhPQcv6PI/TwfTHWymyX1up+hBxV
         HpAtz4oZIE+h7NnWoMwvsi6LNlJ8hZbtQ3BdV00sTUv2GgqwNjtW3L95cydSN5gQ0Rzx
         ljRvRYfXR2st59jTRO+EqTXwZIXqL6OJ/et80s3uX1AywlCb93qqw999dy9PxM5YmtiP
         ZwswwPmrycxnObTiEHP5nWHngRf1doYB+lMaHu9u6SdcyczXqNCOyAKQ9LGUJHiMN8XL
         Ofcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256662; x=1773861462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRmJNSJ3qZ2Eng7Vqt6hsR5JdtYM6RjGEdDsdmytJPg=;
        b=nOdhosOTF18cQ9IckNCd7o/IddI2f/1pmWH5PYRr0Cnc3pSXjXcosxNzefVbXzxqul
         gmxW160vY+KooY+4ZYol8x4q2gAKg3rD/re5S9OyIWTXy3B5cJNuIkPk9fjluQPG0Lhn
         n2U7cCbufNTBPgyHPiLsWZezi5yJwyXT0pwqj0nYMCtaWxGb9YX8yshST0KrdCdNPx1T
         hTISRc4YjiXip9HAXaYv+4vl5Jts/9tyGn2LTPHIJZqYtBEuD9AVKTp5vSWGAVWo08VP
         hNzGi2NbbZaH3CXT8WbRDOOyez/p2SBP54lc5bnzmEVtPazRHpbVm4ZTrcwfH0/AvOyl
         5e+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtnV+u9UQMEdJWPWIDriz3+SvI3U2YhMhowSn33F2kw5nnhtkTa6PQ4zB13tnK9d64CJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJ5sUkW7lzDf19iQsN5T2UE0fFRocNUx1B5Oh0kg99RaiAw0T
	+3GjRtdyaKbWjRHNb4Bs53petIdnXm12hyvr+XxSAKyGnM2tSMfnWwssSFR1Pn75ZRn0I7eMuR9
	LQhikOP5tA80sbOjS7Mg0CGwgPH26wXw=
X-Gm-Gg: ATEYQzw9h9tJbPqmWCE1WuZGMs4F+1U0+c9xdcQAcNNlqN9eiAK757n1Mc9uZO4uNln
	jeFn3NKUAMnTt7frlMA+juJ41Ipgla/LzuIHiJCCFJzORv1WOGtfqiWp0upqo9QwdAcTgncJW40
	6hcKGOwPKZ4E9tZjruhwHbaFVE8ZCH4CIs2FRYHsjkoZlYCmQYIFc1jvh2frwe0+R0n/W5oR2pe
	+N7YHtQN1Jer27qdy0gC1ywx3QjRCIK0Vd79GXwsQ4PG2/d5EzD9QDrA96tIhthi5QdVdF/TUoS
	lkG3BaE=
X-Received: by 2002:a05:6a00:ab83:b0:81c:92ec:ccf3 with SMTP id
 d2e1a72fcca58-829f6f2122emr3542157b3a.19.1773256662284; Wed, 11 Mar 2026
 12:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
 <20260311130321.1055808-1-memxor@gmail.com> <65de5cff-4675-4f56-8e2e-fae68ece4865@linux.dev>
In-Reply-To: <65de5cff-4675-4f56-8e2e-fae68ece4865@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:17:27 -0700
X-Gm-Features: AaiRm53dDGjVNWPwVEH8f36ipYwrEtPj87ejSNTTtugxI7PCStzj6j7lP39bDuM
Message-ID: <CAEf4BzaHWs1hhkhcFJRoza98R+zB8LnhSi4_00SXNgan+rAB0Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: Release module BTF IDR before module unload
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, ameryhung@gmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	grbell@redhat.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:10=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
>
>
> On 3/11/26 6:03 AM, Kumar Kartikeya Dwivedi wrote:

Commit message is missing?...

> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   kernel/bpf/btf.c | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 09fcbb125155..d18e218049ed 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
> >       refcount_inc(&btf->refcnt);
> >   }
> >
> > +static bool btf_is_module(const struct btf *btf);
> > +
> >   void btf_put(struct btf *btf)
> >   {
> >       if (btf && refcount_dec_and_test(&btf->refcnt)) {
> > -             btf_free_id(btf);
> > +             /*
> > +              * IDR for module BTFs is freed when module's BTF referen=
ce is
> > +              * dropped, which may happen before the final put.
> > +              */
> > +             if (!btf_is_module(btf))
> > +                     btf_free_id(btf);
> >               call_rcu(&btf->rcu, btf_free_rcu);
> >       }
> >   }
> > @@ -8383,6 +8390,12 @@ static int btf_module_notify(struct notifier_blo=
ck *nb, unsigned long op,
> >                       if (btf_mod->module !=3D module)
> >                               continue;
> >
> > +                     /*
> > +                      * For modules, we do the freeing of BTF IDR as s=
oon as
> > +                      * module goes away to disable BTF discovery, sin=
ce the
> > +                      * btf_try_get_module() on such BTFs will fail.
> > +                      */
> > +                     btf_free_id(btf_mod->btf);
> >                       list_del(&btf_mod->list);
>
> The change makes sense.
>
> I looked up a bit because I am interested in who will use the module's
> btf->id without holding the module's refcount. fwiw, here is what I read.
>
> For non struct_ops prog, the module refcount is held in prog->aux->mod
> after commit 31bf1dbccfb0, so should be fine on the
> bpf_trampoline_compute_key() and bpf_prog_get_info_by_fd().
>
> For struct_ops prog, the module refcount is not held in prog->aux->mod.
> I don't think it has to since it is not directly attached to the module.

If we have something referencing a module, we should probably get and
keep refcnt on it, no? Why would we have a pointer to a module we
cannot be sure is still alive when we access it, sounds too
error-prone to me.

> The only downside is the bpf_prog_get_info_by_fd() may report an
> out-dated info.attach_btf_obj_id. If it is an issue, maybe just hold the
> module refcount also.
>
> For struct_ops map, it attaches the struct_ops prog to the module, so
> the module refcount is held. It should be fine.
>
