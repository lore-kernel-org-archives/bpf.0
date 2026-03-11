Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86363285CA2
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234353; cv=pass; b=WGUAKVbcy6thJV6UDeJGlYLeKSBNCfz78CovEFBOC0UMy+SyCDFe2RuchngR+vuer6h7ZnEGVtRpPiHVV5fnNdBVzc2us7I97atwhsAYImsiy5+ZsPg5aPtewaYefGmg/GVflZPwMacjbH2ZNz91o8pplK9XM0PrGehnh6/0gOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234353; c=relaxed/simple;
	bh=3bzwQvQNbNdjpKlkbe91BQtvTMpe5tvkxTqgSSp0cBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj6XlMEkKSuoaPLWNA8vyUTE/6kZ5BCgGf9s1UVa5YLxATQ7D7iYI+/GXWxIVSKozwkLo4creF9m7YoDftLklkhP2QghKaO97l3pjEzTi3YKiqZ+QAC/e/xF9ibmqoHlmzDrknzuMuvBTH+QuTGBVKq1zFlYHBnFN6/3pH6egqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmjsnKzR; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmjsnKzR"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439afc58ac7so11425195f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 06:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773234350; cv=none;
        d=google.com; s=arc-20240605;
        b=a4Rv8v3EgaZQvTop/VWRahUbiR9Sr8OiSoqb/2qmKmIp+gpP5WN/jPMD6qGWH2tlcL
         xnPmetM/rLMksuwNA3/OtVn+wdsViw6fJm54c0xxYsxkSF7BjTVbd0NHOQ1n0QqM91o/
         ze+oc5SHHGwEVJAqQOTnpIwWtD+QAysBK+y5wxNJy1JnjUDCdhjkYYxJtCJO7VVrfHuF
         3eTuxRr+SWrHgeoKW7ddfH5b2vmztmqAu7F8/O0Ptov8B1zmivQQjT1bYMxk5NcdexW2
         HarbDNtBvJ5RcMyhufU2zkXJ4yRCEyqQuhs3cf8nX7UYNLghZDKOMW+nNlVmHXoLdhE3
         OVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zrh5nPFE38opBfMzcqqOLjEeog1IuM1EQ1JN98MnH90=;
        fh=MVAHrx+iXeDGlibv9RdHmOQ5PDQuKCSvjw4pj79k9y8=;
        b=c3L7gO1qA+tv39IAVp5a1jUQfo7uJbQcXMgp9TM3UGR9O0pvNZMTefVwVeY26nds7w
         RnwJxku0TQ5PsIfBhmcbKm6EU+x5rAd++Ljl1YTvQBMnmwA/8pOb7oqfjfcmdoBJs3+d
         1OUvYZT4yw9TUtTZYJPZP8OiCWXvKnVXuZXGqQanAXlukpLvukXsg+caGtB0qyBGmPjO
         iQoQPWFecotj7UvxBu/9kPCHc56XRvHHIupBwIBjrgSLPLZO4bPxsK8zg53995AcR9xo
         PEZtjrqMtyGl3O84o5e0meCU9vaEFjOR1R4qGaX4QJl0xujfx0LLuSs6Z2DJPOe8+KYY
         j4tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773234350; x=1773839150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrh5nPFE38opBfMzcqqOLjEeog1IuM1EQ1JN98MnH90=;
        b=BmjsnKzRE71uEdf1nHcqXkp+224yNoAVw1vrTr0cETrZr2FGKcN/z8MiqFPRlkp2D6
         Fa8RufsnONWQtqEFnRTS9yR46SW4Fob/5iopR3wjy8SZmA9elbGm/Lqk33MCOEeZa8lX
         S2PJ2L5WXwjV8S9S6XnpP/yY5HpFqnyEEXJWTfer7vgrqY/x2mvZeUqu9ujXHr7zXF7M
         Ma0eIq4chKag1r/d7uTX/DW0uq42u1iudhXivQsmMHL3Eprmg76LdIcLarNrcu44ikPn
         nv5/bA3Hg6yqy9ym1u4kPdDN0ctv46cD4coGQXOWqDvrNqZ9ihxxMJrY3JnrVGQRnBDd
         NMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234350; x=1773839150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zrh5nPFE38opBfMzcqqOLjEeog1IuM1EQ1JN98MnH90=;
        b=Sz7TOlqiYNgoGRw+VUSD67kU8TAe6d+2I4MwXUl9WSt4m+gSi19hr6mqCd4PfjpKtJ
         QiTxZFQnFUJSa6TwJDt8+xq981lI0fUJ10UxMeNQD72pDdwmjryv+Irf95k+7768X4xN
         irGH97ZRGtrN/RW+UpdmJ6nO2pxq7Y1hOUwzKm3GuQ3n5WN1qMOKfbyuhl8D/vU5Z0RC
         qHUmPw6ymXdJwPWrCTX8fLbFt+afb0M7ry245N0sS5YGf+eKZk405QAZMw31Nz/D9mag
         MWePyUXzXU/BlnY3ZS2Moa+KREBCS04NYfO+BBurCYCD9AJmE3ncjl47yzt/SVQty2XR
         HwqA==
X-Forwarded-Encrypted: i=1; AJvYcCWOfitefoeO3vtALzhYqrmT94Vh3H88auH9kHjIJjSpW6rplZq0BuhAGlQHchCz8IjbMIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6bk9XJLUpfEZCL75lVh75C6VyCXbQ6bRIbFLhdWXO8FqS+kG
	/h4fbuLUeM3wO46J9cT5fKbbQZCKN1D0CRZWrxGgPcSipqzZgK2CdMF6HDphsueKz6B6bhjSDuO
	qwYpE/jOSgO1z8+SWK6c1JiH+KMFcfug=
X-Gm-Gg: ATEYQzxj+K1RPKunqcyTqjipy38kYkELPqm1lX4SkUqnBNmIZlw2clS6+TBtYjrXKIY
	5MY4+wJ1BttnGI+uHATH1RKms/RDLG0BQlTo9ixbKpj+88R+gp9ZHZYK3AiU8nWcfYm/JsnLVch
	HfZ5yuF2H9Lq2SOO6yywmK4VOE8VrWBKm2+wTTnY1r+A9LjyZ9JjBtSZp8uLotmWQ2agdfSQJKx
	cGI1Wjb2403tjcWsbcjpdiKOUIGiyrq0bdt1aFgqtsQf8c6Mby5wSyvs09WrBrVjT0S6po79RIE
	+xty7A8Gk02ZYRqNQ2j5PPyuveo8BtGGaYWT4/sHseq14IB7X829BaXgrZvT
X-Received: by 2002:a05:6000:613:b0:439:f612:e6b4 with SMTP id
 ffacd0b85a97d-439f8227b4amr4707667f8f.55.1773234349614; Wed, 11 Mar 2026
 06:05:49 -0700 (PDT)
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
 <c04a0697-393d-41ec-ba2b-6b90f66097ae@oracle.com>
In-Reply-To: <c04a0697-393d-41ec-ba2b-6b90f66097ae@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 11 Mar 2026 14:05:13 +0100
X-Gm-Features: AaiRm52X_G1XSTHNbjhRz9jQrxVd_-sc7R2chbt3NJlMRu-UpEOgMOJ5srV7i7E
Message-ID: <CAP01T77dE2podOUxuyF-9cOi-upv9qDWO1e67gGqs=g2F6X8+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
	Gregory Bell <grbell@redhat.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 at 13:22, Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 11/03/2026 09:30, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 11 Mar 2026 at 01:20, Martin KaFai Lau <martin.lau@linux.dev> w=
rote:
> >>
> >>
> >> On 3/10/26 4:35 PM, Kumar Kartikeya Dwivedi wrote:
> >>> On Wed, 11 Mar 2026 at 00:17, Amery Hung <ameryhung@gmail.com> wrote:
> >>>>
> >>>> On Tue, Mar 10, 2026 at 3:48=E2=80=AFPM Kumar Kartikeya Dwivedi
> >>>> <memxor@gmail.com> wrote:
> >>>>>
> >>>>> On Tue, 10 Mar 2026 at 23:38, Amery Hung <ameryhung@gmail.com> wrot=
e:
> >>>>>>
> >>>>>> On Tue, Mar 10, 2026 at 2:41=E2=80=AFPM Kumar Kartikeya Dwivedi
> >>>>>> <memxor@gmail.com> wrote:
> >>>>>>>
> >>>>>>> On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wr=
ote:
> >>>>>>>>
> >>>>>>>> When running BPF struct_ops tests consecutively, the second test=
 fails
> >>>>>>>> because BTF object references take longer to be released while t=
heir
> >>>>>>>> associated module is removed from btf_modules list immediately
> >>>>>>>> during module unload. This creates a race condition where the se=
cond
> >>>>>>>> test retrieves the cached BTF object but cannot find valid modul=
e
> >>>>>>>> information, causing btf_try_get_module() to return NULL.
> >>>>>>>>
> >>>>>>>> Fix this by modifying MODULE_STATE_GOING handling to wait for
> >>>>>>>> active BTF references to be released before completing module
> >>>>>>>> cleanup. This ensures BTF objects are properly cleaned up from t=
he
> >>>>>>>> cache before their module metadata is removed, eliminating the t=
iming
> >>>>>>>> window that caused the race condition.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Gregory Bell <grbell@redhat.com>
> >>>>>>>> ---
> >>>>>>>>   kernel/bpf/btf.c | 7 ++++++-
> >>>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >>>>>>>> index 09fcbb125155..81c9f46a7bb7 100644
> >>>>>>>> --- a/kernel/bpf/btf.c
> >>>>>>>> +++ b/kernel/bpf/btf.c
> >>>>>>>> @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notif=
ier_block *nb, unsigned long op,
> >>>>>>>>                  list_for_each_entry_safe(btf_mod, tmp, &btf_mod=
ules, list) {
> >>>>>>>>                          if (btf_mod->module !=3D module)
> >>>>>>>>                                  continue;
> >>>>>>>> -
> >>>>>>>> +                       unsigned int timeout =3D 1000;
> >>>>>>>> +                       while (refcount_read(&btf_mod->btf->refc=
nt) > 1
> >>>>>>>> +                       && timeout > 0 ) {
> >>>>>>>> +                               msleep(1);
> >>>>>>>> +                               timeout--;
> >>>>>>>> +                       }
> >>>>>>>
> >>>>>>> This isn't the right way to address such issues. Your diagnosis i=
s
> >>>>>>> correct but fix is just papering over real problems.
> >>>>>>
> >>>>>> Second that the fix is not right.
> >>
> >> pw-bot: cr
> >>
> >>>>>>
> >>>>>>>
> >>>>>>> The better way would be to block the discovery of such BTFs once =
the
> >>>>>>> module is unloaded.
> >>>>>>> I.e. once we return to userspace after module unload, subsequent =
calls
> >>>>>>> to obtain an fd for such BTFs should not succeed.
> >>>>>>> If someone is racing to look it up while the unload happens, so b=
e it,
> >>>>>>> they will fail anyway.
> >>>>>>>
> >>>>>>> I would use a bool flag in struct btf, set it inside the critical
> >>>>>>> section at this point with WRITE_ONCE, then test it early in
> >>>>>>> bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
> >>>>>>> condition.
> >>>>>>> Using READ_ONCE of course.
> >>>>>>> Also, we need to add it to btf_get_fd_by_id, so that once convers=
ions
> >>>>>>> from stale IDs to FDs don't succeed.
> >>>>>>> Looking at load_module_btfs(), it already handles the ENOENT case=
 when
> >>>>>>> id lookup succeeds, but fd lookup fails.
> >>>>>>> So for stale ids it should just skip over their errors if we retu=
rn
> >>>>>>> the same ENOENT as the refcount_inc_not_zero case.
> >>>>>>> We will still report stale ids, but not allow their conversion.
> >>>>>>> We could filter id lookup too but it will penalize the common cod=
e and
> >>>>>>> we need extra radix tree lookup just for BTF case.
> >>>>>>>
> >>>>>>> For me locally, these changes seem to address the problem. I coul=
d
> >>>>>>> send the fix, but if you would like to take a stab at the above
> >>>>>>> change, please go ahead.
> >>>>>>>
> >>>>>>
> >>>>>> I guess this is worth a fix because it makes btf_get_fd_by_id() le=
ss
> >>>>>> likely to return to stale id. However, there is still a small wind=
ow
> >>>>>> between btf_get_fd_by_id() and btf_try_get_module() so struct_ops =
map
> >>>>>> creation can still fail.
> >>>>>
> >>>>> That's fine, it means that module unload is happening in parallel, =
so
> >>>>> it's racy and non-deterministic anyway.
> >>>>> When the user controls the module unload though, they should not be
> >>>>> getting stale BTF fds once module unload has returned to user space=
.
> >>>>> At that point all associated artifacts shouldn't be discoverable.
> >>>>>
> >>>>>>
> >>>>>> As for the solution, there already is btf_mod->flags. So maybe ins=
tead
> >>>>>> of adding a bool, just test the flag?
> >>>>>
> >>>>> You mean struct btf instead of btf_mod? I don't see the flags field=
 there.
> >>>>> The btf_mod->flags won't work, it's already deleted and freed by th=
is
> >>>>> time, and requires us to go first from the BTF to the btf_mod.
> >>>>> So it has to be in struct btf.
> >>>>>
> >>>>
> >>>> I was thinking about updating btf_module->flags when handling
> >>>> MODULE_STATE_GOING. Then btf_get_fd_by_id() can call
> >>>> btf_try_get_module() to check flags if it's module BTF. If the modul=
e
> >>>> is already freed then it returns -ENOENT.
> >>>
> >>> Hmm, interesting thought.
> >>> I guess the only downside is that it's O(n) lookup under mutex, which
> >>> can be costly with lots of modules, and always penalizes
> >>> get_fd_by_id() for handling race.
> >>> We also need to repeat it in bpf_core_find_cands and bpf_find_btf_id,
> >>> where we may repeat it multiple times in the loop, so the cost is
> >>> amplified.
> >>>
> >>
> >> Is btf->id still needed somewhere after MODULE_STATE_GOING? Otherwise,
> >> directly removing btf->id from btf_idr in btf_module_notify() should
> >> stop the discovery.
> >
> > I looked at this, I think we will need to reset the btf->id too.
> > Otherwise while btf_free_id is idempotent (no-op on free id), the
> > released id can be reused and if we don't guard btf_free_id in btf_put
> > it will remove it for some other BTF initialized in the meantime.
> > We can likely set a flag or something to skip it in btf_put(). As long
> > as the module is holding a reference nothing else should do it.
> >
>
> I wonder if it'd make sense to reduce the cost of btf -> module lookup so=
 that
> we could check the flag in contexts like btf_get_fd_by_id()? AI suggested=
 reworking
> btf_module lookup from a linked list to a pair of xarrays keyed by struct=
 module *
> and struct btf *, and it seems reasonable (testing it now). An easy win m=
ight be
> to get rid of the strcmp() to vmlinux in btf_is_module(), replacing it wi=
th the
> simpler predicate
>
>         btf->kernel_btf && btf->base_btf;
>
> to reduce overhead of lots of btf_is_module() lookups. What do you think?

That is probably worth doing if btf_module lookup is taking up
significant CPU time, but I think as a fix it would be too much churn,
and be harder to backport.
I shared a diff trying out Martin's idea and it seems to fix the issue.
