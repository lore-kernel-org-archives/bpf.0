Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095102BEFE7
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221717; cv=pass; b=pXJg9yNqu7nwMd00f00M1p69S6fYQ2wHooT2PUJGhRJ8IweKXu/KdunzzflPqVcoLwBsJ+lhE8o5PWqZULLUlDVc3yzYLRwvS47T7WgftKpVDd6fJ1PJHcnhJMDWv+QAoO6RTgn32yE3PHhMeE0tkjuSRApiksM8q81ZVhiwxz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221717; c=relaxed/simple;
	bh=T/rPUPSo0mK3TOqyZGaQ9i3PeNV5ANPMKm8aALeacCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxjQkRM9AUCZN4LvVaptiLa3lCbvwLCZ1tpPNcaeK1Poe2DYXEvXjc3dzToiBj1dAQFg3B+OQVd0VdA17tts6mJRVnrgkPOzNChPCQCUT47dC3VKbdNR2SBoNhL114n43rYMmw7pem8p564d+7kAM53l57/G8ImH0yqcrkggKxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpOZ6qA2; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpOZ6qA2"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439f5abc829so1280070f8f.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 02:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773221714; cv=none;
        d=google.com; s=arc-20240605;
        b=D+q0ai2AN/6OwLm2SeJYaDWF+jTe8yq7eVNopgW2IWUbBQYtrWwnLOylxTP28+Zff0
         xH8SxqUBzd59PNHaKsjGvRr3/AjQ25ZGTsPRCYhyKEyF8w9i+fCUt//IdEaSgYsm0OIP
         pnhNKv6UG+oGcaMO0Rtms6UHdTA7MSC+VQatZiihkWapnjckZ05oK+fuJVRg9s291tfa
         uG1XjM9jkiuiH/lkt7Rxduc7v4ngkFCQYBSVxocdg4tQP4zn2vUUblEPUXTCRbVeuKWF
         Rpl6QUI2qa82/pS4ocw0bIa+sxiVHr66/vJjPrwU8abw5dvajYJwnzF7rI95Qo36OAYS
         dj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9sEuQu0Vm46yi0rXXt21ZUcHHW5HWLMtsGbk2fZ6eNg=;
        fh=4soNpCj+rfLnj/i4QSJRf6iXsc+vadAvtFnifOAb0oU=;
        b=JHqt5c+SNH/YCd0goWJC3+s6PO1HnjqzSmP83zvymtcEukc4RSBTnTpK397HYTUJRg
         RaZoTPWka3+zoTmbveSln2KwwJ0E4eu5V4tsR9a9mtgJq67dEKIqJUGa9d4GVu2wlO87
         EgDcq5w+Gi//fI66CwOFd5MS3WNMjNKgx+5Ih7R4zhVUGz9mechD40VRpeqXB4J/GWES
         KGQrAp2TtHSi29Dzmw7i2oH4YRLGJJ6Dg8g9YXWble1qqr9/+efcXM7pFqpr1RCXNzd1
         mJEPV/LdmOTY3PcTmhRR6h28ImwDeswi8kEBI5hiNgOBCwfY5H4Rnzn8pfeIx2golFrN
         hT4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773221714; x=1773826514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sEuQu0Vm46yi0rXXt21ZUcHHW5HWLMtsGbk2fZ6eNg=;
        b=BpOZ6qA2cEbtBSVAYTmqIfWq/7aFrC/lY+91chjoMGOVbW2auzwyG0yfaAf6DxTwQb
         HMYL2i07ZJmF/h2YDPXg1YUhniceNKa8Dm7fga5AIw+RfgmEjPUsV+43J/ycLUXKACoR
         9UEKShXXz/GVMW7SbscLFQRIm+nIbNtobYgFRAMOU+eFp1sMjSVNZ6QplngJQbJKIDF5
         hD54z7Gz1lfkMIDxzk472nDOtKVzMpY3VaZ7aJD0weVPosm5VrZ8WTgyUqgH2grum2zC
         v9CElp5Cfhlq05AqVHZLBkxzR8CYfYVYtJZEGuzg6PTISU0y59UPAZH2k9CXNHiS11TU
         H4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773221714; x=1773826514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9sEuQu0Vm46yi0rXXt21ZUcHHW5HWLMtsGbk2fZ6eNg=;
        b=udqQYdPyTgUxjfOah4R5xNN0nHGsqU+HwQJB4jKhecBJltd8LyzY9h4lzPfHt/ViDS
         f+fWsUJlVi7SZ/2nju8L0WJFy7o3fe3ebTDI99PC+inLWXDTzF9oB1yqQjzeuEiH+VL7
         v/H9Tx5bSR2vhia07KWdnsN6okIf1H7AjYfpIcnRLSFz29KYHlYpeBx95YBaCJfSL7pL
         aNSxLPA7ZT+LEWo2FQtw6w1zuzEB+RUuckqF6/TKbeJuoUWKuul4bCUS1r9jV6CGWVUQ
         Y6bTcXO3oXOes1e8x21K2KXxWGBd7S1Usif84XbfGuiJf9Gq1IBsLrIieEB7wrJuvM/n
         oInw==
X-Forwarded-Encrypted: i=1; AJvYcCXxCvVYu1c+kildWSmUV6m3d8SJijUD4XH8XXCGYjUtyJ47Dql3lN8kAev8Q62jkolh6pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrSuW9dHHIR9mAGbUns5EkEDGn8mI200SC111cKdn6YALrAw3p
	yzaaXfnPTz6txrsVA26dwaaOJ8Lu2HlnTRJCaWkdyNEOW8Y+/Dw2Icnk2Tx6nCf2VZN6TAuuatv
	si/f1lHb8voVXmR03PoOnLfteGBvvNaQ=
X-Gm-Gg: ATEYQzxN/C3NGa6JPULLGqwKZpsh6z3Zgwu+N6rQee37suQPp+ZR4gEivSfGTwANKQG
	0+HxZW5Oi0VPG2FX3W+GWKmewtWoqgBzxtQ2tYyJAXOSsOcGBZ0t7FGp2B5J8untxY87ELLWAia
	aGPgxiEmxpRvqw+QuZK7gFiO16yvHNt1P8Cl2AWZbahX98FGEpa1bGIqmBYsR/bwG8kxr6dXa+8
	e4xD+Y+gpf+z6ZxJ+yl6POnIBRsRhj1c8YhvCVgrF7AE4C+jsu76qlkLJ880J0wZgctpe4WP6ta
	WJ1r6XKxLuTiofRosmjy1ySA42wHU3OUoWOkedaTK9WL2NBYr3Ul59C5m05ZEjqqhTr580s=
X-Received: by 2002:a05:6000:2404:b0:439:b744:c5fe with SMTP id
 ffacd0b85a97d-439f842f414mr3661528f8f.52.1773221714152; Wed, 11 Mar 2026
 02:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773170190.git.grbell@redhat.com> <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
 <CAP01T75MFfp8oBrogRvm+BRh7=fvm9pP0vTvNm=RW3r3=WDB7g@mail.gmail.com>
 <CAMB2axPT8L60FGN5wben-pa73toOwLcD8cuGqbNUg6AB57ePYg@mail.gmail.com>
 <CAP01T76cPcToNwu_NMFU6QDO8qZB+n9WA0_qxSzrasZV-=G-Qw@mail.gmail.com>
 <CAMB2axMTkN5R3+JQL-2L0fWAqzOQOFOxp7+WKF4DLUF-FqgiPg@mail.gmail.com>
 <CAP01T75dDL5pud_NmCmEapw6p1cZss9LTfh6sBxdxYinVQTP5Q@mail.gmail.com>
 <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev> <CAP01T741UV0TsvxxXRAT-zYjKoHwcpsr2bbMS-eFnxytcng7Kg@mail.gmail.com>
In-Reply-To: <CAP01T741UV0TsvxxXRAT-zYjKoHwcpsr2bbMS-eFnxytcng7Kg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 11 Mar 2026 10:34:37 +0100
X-Gm-Features: AaiRm50-DuUfVQVBbtu6y0PBhqDUK2aUO1zug1JPWQU4B9QT0WXhRQMcZBIYcYg
Message-ID: <CAP01T74gnwh0_+fzYpWZ=01g_18igo1-0MG3MhTswvQW_Um1Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Gregory Bell <grbell@redhat.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 at 10:30, Kumar Kartikeya Dwivedi <memxor@gmail.com> wr=
ote:
>
> On Wed, 11 Mar 2026 at 01:20, Martin KaFai Lau <martin.lau@linux.dev> wro=
te:
> >
> >
> > On 3/10/26 4:35 PM, Kumar Kartikeya Dwivedi wrote:
> > > On Wed, 11 Mar 2026 at 00:17, Amery Hung <ameryhung@gmail.com> wrote:
> > >>
> > >> On Tue, Mar 10, 2026 at 3:48=E2=80=AFPM Kumar Kartikeya Dwivedi
> > >> <memxor@gmail.com> wrote:
> > >>>
> > >>> On Tue, 10 Mar 2026 at 23:38, Amery Hung <ameryhung@gmail.com> wrot=
e:
> > >>>>
> > >>>> On Tue, Mar 10, 2026 at 2:41=E2=80=AFPM Kumar Kartikeya Dwivedi
> > >>>> <memxor@gmail.com> wrote:
> > >>>>>
> > >>>>> On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wr=
ote:
> > >>>>>>
> > >>>>>> When running BPF struct_ops tests consecutively, the second test=
 fails
> > >>>>>> because BTF object references take longer to be released while t=
heir
> > >>>>>> associated module is removed from btf_modules list immediately
> > >>>>>> during module unload. This creates a race condition where the se=
cond
> > >>>>>> test retrieves the cached BTF object but cannot find valid modul=
e
> > >>>>>> information, causing btf_try_get_module() to return NULL.
> > >>>>>>
> > >>>>>> Fix this by modifying MODULE_STATE_GOING handling to wait for
> > >>>>>> active BTF references to be released before completing module
> > >>>>>> cleanup. This ensures BTF objects are properly cleaned up from t=
he
> > >>>>>> cache before their module metadata is removed, eliminating the t=
iming
> > >>>>>> window that caused the race condition.
> > >>>>>>
> > >>>>>> Signed-off-by: Gregory Bell <grbell@redhat.com>
> > >>>>>> ---
> > >>>>>>   kernel/bpf/btf.c | 7 ++++++-
> > >>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
> > >>>>>>
> > >>>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > >>>>>> index 09fcbb125155..81c9f46a7bb7 100644
> > >>>>>> --- a/kernel/bpf/btf.c
> > >>>>>> +++ b/kernel/bpf/btf.c
> > >>>>>> @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notif=
ier_block *nb, unsigned long op,
> > >>>>>>                  list_for_each_entry_safe(btf_mod, tmp, &btf_mod=
ules, list) {
> > >>>>>>                          if (btf_mod->module !=3D module)
> > >>>>>>                                  continue;
> > >>>>>> -
> > >>>>>> +                       unsigned int timeout =3D 1000;
> > >>>>>> +                       while (refcount_read(&btf_mod->btf->refc=
nt) > 1
> > >>>>>> +                       && timeout > 0 ) {
> > >>>>>> +                               msleep(1);
> > >>>>>> +                               timeout--;
> > >>>>>> +                       }
> > >>>>>
> > >>>>> This isn't the right way to address such issues. Your diagnosis i=
s
> > >>>>> correct but fix is just papering over real problems.
> > >>>>
> > >>>> Second that the fix is not right.
> >
> > pw-bot: cr
> >
> > >>>>
> > >>>>>
> > >>>>> The better way would be to block the discovery of such BTFs once =
the
> > >>>>> module is unloaded.
> > >>>>> I.e. once we return to userspace after module unload, subsequent =
calls
> > >>>>> to obtain an fd for such BTFs should not succeed.
> > >>>>> If someone is racing to look it up while the unload happens, so b=
e it,
> > >>>>> they will fail anyway.
> > >>>>>
> > >>>>> I would use a bool flag in struct btf, set it inside the critical
> > >>>>> section at this point with WRITE_ONCE, then test it early in
> > >>>>> bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
> > >>>>> condition.
> > >>>>> Using READ_ONCE of course.
> > >>>>> Also, we need to add it to btf_get_fd_by_id, so that once convers=
ions
> > >>>>> from stale IDs to FDs don't succeed.
> > >>>>> Looking at load_module_btfs(), it already handles the ENOENT case=
 when
> > >>>>> id lookup succeeds, but fd lookup fails.
> > >>>>> So for stale ids it should just skip over their errors if we retu=
rn
> > >>>>> the same ENOENT as the refcount_inc_not_zero case.
> > >>>>> We will still report stale ids, but not allow their conversion.
> > >>>>> We could filter id lookup too but it will penalize the common cod=
e and
> > >>>>> we need extra radix tree lookup just for BTF case.
> > >>>>>
> > >>>>> For me locally, these changes seem to address the problem. I coul=
d
> > >>>>> send the fix, but if you would like to take a stab at the above
> > >>>>> change, please go ahead.
> > >>>>>
> > >>>>
> > >>>> I guess this is worth a fix because it makes btf_get_fd_by_id() le=
ss
> > >>>> likely to return to stale id. However, there is still a small wind=
ow
> > >>>> between btf_get_fd_by_id() and btf_try_get_module() so struct_ops =
map
> > >>>> creation can still fail.
> > >>>
> > >>> That's fine, it means that module unload is happening in parallel, =
so
> > >>> it's racy and non-deterministic anyway.
> > >>> When the user controls the module unload though, they should not be
> > >>> getting stale BTF fds once module unload has returned to user space=
.
> > >>> At that point all associated artifacts shouldn't be discoverable.
> > >>>
> > >>>>
> > >>>> As for the solution, there already is btf_mod->flags. So maybe ins=
tead
> > >>>> of adding a bool, just test the flag?
> > >>>
> > >>> You mean struct btf instead of btf_mod? I don't see the flags field=
 there.
> > >>> The btf_mod->flags won't work, it's already deleted and freed by th=
is
> > >>> time, and requires us to go first from the BTF to the btf_mod.
> > >>> So it has to be in struct btf.
> > >>>
> > >>
> > >> I was thinking about updating btf_module->flags when handling
> > >> MODULE_STATE_GOING. Then btf_get_fd_by_id() can call
> > >> btf_try_get_module() to check flags if it's module BTF. If the modul=
e
> > >> is already freed then it returns -ENOENT.
> > >
> > > Hmm, interesting thought.
> > > I guess the only downside is that it's O(n) lookup under mutex, which
> > > can be costly with lots of modules, and always penalizes
> > > get_fd_by_id() for handling race.
> > > We also need to repeat it in bpf_core_find_cands and bpf_find_btf_id,
> > > where we may repeat it multiple times in the loop, so the cost is
> > > amplified.
> > >
> >
> > Is btf->id still needed somewhere after MODULE_STATE_GOING? Otherwise,
> > directly removing btf->id from btf_idr in btf_module_notify() should
> > stop the discovery.
>
> I looked at this, I think we will need to reset the btf->id too.
> Otherwise while btf_free_id is idempotent (no-op on free id), the
> released id can be reused and if we don't guard btf_free_id in btf_put
> it will remove it for some other BTF initialized in the meantime.
> We can likely set a flag or something to skip it in btf_put(). As long
> as the module is holding a reference nothing else should do it.

Another way to make the check is skip btf_free_id() in btf_put() for
btf_is_module(), and always do it in the MODULE_STATE_GOING case.
The module is always going to release its reference, and precisely at
that point we want the idr to be freed.
