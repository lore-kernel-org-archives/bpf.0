Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799C3CB2F1
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221443; cv=pass; b=SU/RcCfvvDFWVt73pG4i9HIZa1BCALfHrPYkdwHNrJTCYc9PsuPdhwTEGMHaczsrnMy+YG2Vs+C5MDogiBIunA8VscMqIlPjoHEzZCyzSAWgKvY7Dfho2hwOOqKsmOwfHH/dL7LbhqyxghfO/22GxisLEXXhOpKdFPKVMMX4vsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221443; c=relaxed/simple;
	bh=jePAwQx/Myt6yU3BIww6Iy8BtdAYG131T07D5srbLgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SY59AWA5tzoBgtD7Ttti/9SjBiX4fMubeHgT0HBxBHhhZ+UrTePiWgLOAYUOiWcZgdJrh3jjq1/CjuqYbxHJDTTmDBKlwPLYM8qpcH21doruskjUwVl4/5TrFYui9a1zbznIDkz30qWuVwrHkxwwTFOAMLdZYd61OlypChkK3Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJiGbDGG; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJiGbDGG"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439c4bde55cso5520317f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 02:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773221440; cv=none;
        d=google.com; s=arc-20240605;
        b=FPOpTzF1LneDRD+jhHqveqrw4AWVTKHUd2mOu9M7KbLLaCJw1PHNl2GGRkplJANyW6
         UNVppsOcI9Gib84NafkwGoWgMDKD4K5j9jDs5tmn41g5nFK85xLBDg0bF2S4fMw5pukZ
         XAJuFq2/YeWzCd8eAPDRq/YenpIo5Tyl1m/19VMWD80+eM7RmUY/9JUtRa0/j6d7+sIl
         AU8zTgUi3aJKD5NbeTE8khOZ3AD6/acPq98UxogGocw6RmROYhMyuA7B2trCvI27BZft
         sF3HWq8gN7mDCH3NmcdnUUWwPvuAo2u4fC3XcHBf/v6lF3xyr0z1F/L3E3H5wDSFPe/w
         T7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b+HR+fIjct4JSQB0drQqnH/BzJbHTpzwA3P1fT4mYIY=;
        fh=YASLqI8+VwXU4lrvu3iyKAF3aNdJh8XSWAmPtb7srd4=;
        b=PGifPtqpBVfEIjVoqUlEbk27uc0pnSJpFdntqjHSDQ2FCme+TkukXocJSHuCjB+uMF
         RS0jpruTj8/OtWT+jHar0LuU0WrjTWg4ugT73OyjKUnTLeYs0XJl3Jf3vdSqK4GJUX6X
         xc4dr3nZJ1G/ipfz8OiOunzE3KjrsuMWngTM8cvGy1edbovrYc1IuvThTAYM9tQPuXMg
         t+3UzgDBqBYLFVd319rmzous+FKDwp5+UbWXEN9BQ52mlkqLTCnbfe4Z6H54bEFMo0Wz
         4WOLoBVekxXiJKM+BpGL+qJgh1L8/3bqzTaR42XDnywUt7PVlRtCknu+qsI4bPISXLq+
         WeGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773221440; x=1773826240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+HR+fIjct4JSQB0drQqnH/BzJbHTpzwA3P1fT4mYIY=;
        b=GJiGbDGGVx8429wC8oycgTqDIf+v1JKM1aKekOFHUs2cLuVlnli1OcwJisQj0+ORcz
         acj4FWHySTqeN+1oEGfyGZY5lEIG5udtGIqKZZcBPtIr+69nBIrrEBtKrQoGFJd2noQ2
         6rUxi7HZdI2fM33ENsEorc0tCalmYpUXmXDPnLg6r+4IAPT0Ow9zuCAKauPQtZHNpxxA
         WDcvDSGTE8m9rUtEOcVxYXUO/uJGCTn6gQXBgxQXCbpzr2jyXeKn54R99Wl2p5WbUVtW
         PwNuHwPq/VuViB9A98AULZYUangv/Xfl40rOdAFwiTGaGjXnE6ZfRxjTAHff01/PmN07
         mfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773221440; x=1773826240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+HR+fIjct4JSQB0drQqnH/BzJbHTpzwA3P1fT4mYIY=;
        b=bQhmB5ufIQx3ivYmv6aETGPxe49gjcxFtTgIIIw5d/GNmuODwcUjkMVqAA6f7Bx6OY
         kANCHA3Ouvi4jYsDsQlx4RuJpp1XlrSA6+t66F6qg1HuNBKzVo8NtcN4D5XWSjIOHsdS
         gBuo5OVgz96KV4O9pbNJYt/EE8edmskIWFBOM18FDyXUb/u8vT/5TLPJkWXmU24dLiLA
         KEh/qw23X62yhQKhi9/Ud31juTBSbYjSz4t3EpNJgv1e0EeQ14CgMeIciq+84HHoR0QU
         Jl126RbrsvGxupScQae1gQszLjcELQUfMuWZ55MvOcqqN0WG/CLVLoQ1/+tKt7d6qKKG
         RmDw==
X-Forwarded-Encrypted: i=1; AJvYcCW0sWfn8kZ+BRhybuVD8okhGpbtQznwA8WakkDk56wKBu6pRn6AH8rMup0v4FI2vKbX1Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLlzZ2zfMwD5tfv+brwylhcGiGJPG/B5WkALuUux6Kb6RyQJ2
	z4hZW446eNz0QARZksaGjA6fccEzkye3VlPtjqiAt/aODBmcljN6dePRN1cN3B/rytNKKSPPLLg
	0OWnAJykt/PLDsJ15Z8pjOjR2ostonpM=
X-Gm-Gg: ATEYQzzlpI1ygKgDgMM3PdjPIoPZE/DxV6kjuCxL0A5Z050rQmx9mY04iV2R9zkrDeF
	jCdcpR2lBTKxQkboJa+KkCM7SKIUMhfkpOH0vHRDMWYPadAgsLowK1EINJLeoscvhe9IXqOazCH
	N/BfFfUICGcamLn92Q4ZRRyvErY/ofKsEQDERetlwVt8GnAAaQEwRxNxjpAQFAtZ7nEajpMGeEY
	28gqx0d1BiGuvJkbP7Uyqpz4SpC42iPnGKZRxO+O1vfIstRXkzVCOVwb+priwY4aKu4swDrzcMw
	vwvmC+ij/AObHSvGKuXCkkAfIZy/75MRKQ2gl40FzZjbjU8p7eYJOIzaEnFQKi1lSTCosbY=
X-Received: by 2002:a05:6000:2884:b0:439:c628:2228 with SMTP id
 ffacd0b85a97d-439f843125amr3545033f8f.31.1773221440326; Wed, 11 Mar 2026
 02:30:40 -0700 (PDT)
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
 <CAP01T75dDL5pud_NmCmEapw6p1cZss9LTfh6sBxdxYinVQTP5Q@mail.gmail.com> <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
In-Reply-To: <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 11 Mar 2026 10:30:02 +0100
X-Gm-Features: AaiRm523WoCT8pKvesYyJqTt-WgOvaQ9vRTXdgIPkwLNGOm2RtZv71sXh1KKyZY
Message-ID: <CAP01T741UV0TsvxxXRAT-zYjKoHwcpsr2bbMS-eFnxytcng7Kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Gregory Bell <grbell@redhat.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 at 01:20, Martin KaFai Lau <martin.lau@linux.dev> wrote=
:
>
>
> On 3/10/26 4:35 PM, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 11 Mar 2026 at 00:17, Amery Hung <ameryhung@gmail.com> wrote:
> >>
> >> On Tue, Mar 10, 2026 at 3:48=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> <memxor@gmail.com> wrote:
> >>>
> >>> On Tue, 10 Mar 2026 at 23:38, Amery Hung <ameryhung@gmail.com> wrote:
> >>>>
> >>>> On Tue, Mar 10, 2026 at 2:41=E2=80=AFPM Kumar Kartikeya Dwivedi
> >>>> <memxor@gmail.com> wrote:
> >>>>>
> >>>>> On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wrot=
e:
> >>>>>>
> >>>>>> When running BPF struct_ops tests consecutively, the second test f=
ails
> >>>>>> because BTF object references take longer to be released while the=
ir
> >>>>>> associated module is removed from btf_modules list immediately
> >>>>>> during module unload. This creates a race condition where the seco=
nd
> >>>>>> test retrieves the cached BTF object but cannot find valid module
> >>>>>> information, causing btf_try_get_module() to return NULL.
> >>>>>>
> >>>>>> Fix this by modifying MODULE_STATE_GOING handling to wait for
> >>>>>> active BTF references to be released before completing module
> >>>>>> cleanup. This ensures BTF objects are properly cleaned up from the
> >>>>>> cache before their module metadata is removed, eliminating the tim=
ing
> >>>>>> window that caused the race condition.
> >>>>>>
> >>>>>> Signed-off-by: Gregory Bell <grbell@redhat.com>
> >>>>>> ---
> >>>>>>   kernel/bpf/btf.c | 7 ++++++-
> >>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >>>>>> index 09fcbb125155..81c9f46a7bb7 100644
> >>>>>> --- a/kernel/bpf/btf.c
> >>>>>> +++ b/kernel/bpf/btf.c
> >>>>>> @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifie=
r_block *nb, unsigned long op,
> >>>>>>                  list_for_each_entry_safe(btf_mod, tmp, &btf_modul=
es, list) {
> >>>>>>                          if (btf_mod->module !=3D module)
> >>>>>>                                  continue;
> >>>>>> -
> >>>>>> +                       unsigned int timeout =3D 1000;
> >>>>>> +                       while (refcount_read(&btf_mod->btf->refcnt=
) > 1
> >>>>>> +                       && timeout > 0 ) {
> >>>>>> +                               msleep(1);
> >>>>>> +                               timeout--;
> >>>>>> +                       }
> >>>>>
> >>>>> This isn't the right way to address such issues. Your diagnosis is
> >>>>> correct but fix is just papering over real problems.
> >>>>
> >>>> Second that the fix is not right.
>
> pw-bot: cr
>
> >>>>
> >>>>>
> >>>>> The better way would be to block the discovery of such BTFs once th=
e
> >>>>> module is unloaded.
> >>>>> I.e. once we return to userspace after module unload, subsequent ca=
lls
> >>>>> to obtain an fd for such BTFs should not succeed.
> >>>>> If someone is racing to look it up while the unload happens, so be =
it,
> >>>>> they will fail anyway.
> >>>>>
> >>>>> I would use a bool flag in struct btf, set it inside the critical
> >>>>> section at this point with WRITE_ONCE, then test it early in
> >>>>> bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
> >>>>> condition.
> >>>>> Using READ_ONCE of course.
> >>>>> Also, we need to add it to btf_get_fd_by_id, so that once conversio=
ns
> >>>>> from stale IDs to FDs don't succeed.
> >>>>> Looking at load_module_btfs(), it already handles the ENOENT case w=
hen
> >>>>> id lookup succeeds, but fd lookup fails.
> >>>>> So for stale ids it should just skip over their errors if we return
> >>>>> the same ENOENT as the refcount_inc_not_zero case.
> >>>>> We will still report stale ids, but not allow their conversion.
> >>>>> We could filter id lookup too but it will penalize the common code =
and
> >>>>> we need extra radix tree lookup just for BTF case.
> >>>>>
> >>>>> For me locally, these changes seem to address the problem. I could
> >>>>> send the fix, but if you would like to take a stab at the above
> >>>>> change, please go ahead.
> >>>>>
> >>>>
> >>>> I guess this is worth a fix because it makes btf_get_fd_by_id() less
> >>>> likely to return to stale id. However, there is still a small window
> >>>> between btf_get_fd_by_id() and btf_try_get_module() so struct_ops ma=
p
> >>>> creation can still fail.
> >>>
> >>> That's fine, it means that module unload is happening in parallel, so
> >>> it's racy and non-deterministic anyway.
> >>> When the user controls the module unload though, they should not be
> >>> getting stale BTF fds once module unload has returned to user space.
> >>> At that point all associated artifacts shouldn't be discoverable.
> >>>
> >>>>
> >>>> As for the solution, there already is btf_mod->flags. So maybe inste=
ad
> >>>> of adding a bool, just test the flag?
> >>>
> >>> You mean struct btf instead of btf_mod? I don't see the flags field t=
here.
> >>> The btf_mod->flags won't work, it's already deleted and freed by this
> >>> time, and requires us to go first from the BTF to the btf_mod.
> >>> So it has to be in struct btf.
> >>>
> >>
> >> I was thinking about updating btf_module->flags when handling
> >> MODULE_STATE_GOING. Then btf_get_fd_by_id() can call
> >> btf_try_get_module() to check flags if it's module BTF. If the module
> >> is already freed then it returns -ENOENT.
> >
> > Hmm, interesting thought.
> > I guess the only downside is that it's O(n) lookup under mutex, which
> > can be costly with lots of modules, and always penalizes
> > get_fd_by_id() for handling race.
> > We also need to repeat it in bpf_core_find_cands and bpf_find_btf_id,
> > where we may repeat it multiple times in the loop, so the cost is
> > amplified.
> >
>
> Is btf->id still needed somewhere after MODULE_STATE_GOING? Otherwise,
> directly removing btf->id from btf_idr in btf_module_notify() should
> stop the discovery.

I looked at this, I think we will need to reset the btf->id too.
Otherwise while btf_free_id is idempotent (no-op on free id), the
released id can be reused and if we don't guard btf_free_id in btf_put
it will remove it for some other BTF initialized in the meantime.
We can likely set a flag or something to skip it in btf_put(). As long
as the module is holding a reference nothing else should do it.
