Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D22BEC5F
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782435591; cv=pass; b=thmilrmysOgYBfOLDdLcugwRJActGHkqNNmHtJQDS5fZM1J1vy+MmLt0nBnR2IfN6lFV9BH4tHWvbK+iqnB8sLFDRL7JuL3fLzCxk2qB2rGG6LPbO5DSJfW4UKhptfId9nPvNAAFsQ/yUx5DEjG8aeoPi6d0JMmtIYxNbiqwbO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782435591; c=relaxed/simple;
	bh=JAi+1cfuqW4dKgJyz8688NThgEFm8UYHA+l+AvZAdAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU+cwVZhzusfc3lsS29ZesluzVwwq/Udt7H8yrHVcCWoYeDaJmEb3feSduTS4eHDR6VaCpFrPaoEGSoIFx/t4hKHgWzkk2hmss1jPpNmIAQEQXmW+68/RfwTsNV5dmfUkufBvhDGU5M35C9up22cLNNpvKgWZe8zI11P6skvL5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RMzK65wN; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RMzK65wN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so263905a91.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435589; cv=none;
        d=google.com; s=arc-20260327;
        b=JzZIzcf7cXCyqHOQZ2eEZsMaZtscqQ1FTkGvMl5h/S3Gg5Tj8j68mVg/6R07npSV3/
         Ez+qV3sfC4Ri/DcopI32M/rO/mfNBn8Bf6/bvGAFxUUVqo3VOaeXiE1C5ui+bYIQWBX9
         cmAtNbnFOmadfwfCdLiqENVS2uzZVB7pxlYsfpmfIwlmf9sYiLc4UDu6pBplwPX+3Agl
         C88aUV/xZ+KcnFGNpFNu0JDVEamgsLTO4xA8h3uG73pSmyPUwe8IqjH6SL6gbdEo4L2d
         g03XFb2eDPD7Ocn5CeCbg10+HG42MIf0yaVJ91/DYE6dx035KipGwSyKHfPtsoRatNXs
         0WYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lil80X6nXDIY1juv7E8QctpamA+WvizoMoZwUQr02g=;
        fh=2bnGIDVy672bK8xIV8Li5mF0FJVFpfK49PslXTKOBUM=;
        b=kCgMjEjGw7PQIJkpgAS9qI5ZVt06SmM4HX+RuITcd0s3FApc7YL1JrX2kVxcyfxEd8
         yBQJIpiN2DMEQDl2unuGIo/mISG9S5FDXso1CAedv8HqUfKI9Z7I+J8A7IPxnu/lJP/E
         CG8U3dkiXDLkjKdb/9loA4elFk2QnJHXOzG+RdR1Un4Hh5iEJ7D4gUqAtMNQULcDilPC
         d9akt/knw98QWJ9Cryd+iHXZXR5Afs3tvIDyDgeSeK+1a/6sTWHXodW5n+X8amh3qhOj
         Nh6iqXGg7I4EJrOoCiRPGPZ5bYlhbiUxMyT7U+5l3YKcOh1XcRp/+6qmUM8TA8Dztwt+
         ULJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782435589; x=1783040389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lil80X6nXDIY1juv7E8QctpamA+WvizoMoZwUQr02g=;
        b=RMzK65wNUfv8QeSIO61F1M7WzoeKzMXSjxABy6DsI5j1t8BJF0d0Kz6N6XY2/FmGHR
         sKgpLh8IqgQLvdTRdSX3nRitvy4IEKg4TQIwRVjhDIvm7J4TpxNHkbBQnlR2O2QWwRHT
         mMNCjTh9vtc5sZTHKF8L4tdaR/ketkER8/L0TsXzC/41Zd9uqncHRbmMZwwtqynmnoLc
         zHV/aPp1f0TQ5CHETW/4QkIrXI2RSGC/ukQdYM+XWqx4rf1KC4Lqg3gNrMPJKqqghTA9
         Uf4CY7ytSg5ElwLtbLDOCfAPHtlN9+fFp59EoEI+nYJk6ObaVUCwblxT+PuycSODU2lK
         N3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782435589; x=1783040389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lil80X6nXDIY1juv7E8QctpamA+WvizoMoZwUQr02g=;
        b=igEHRNzoxd5BiYj7Apulfyjulba923UOXkCJ/i2YRq9s7f3AO6MgGrJ2JkNXSx5fkm
         Q50uDHIjzEti5xOZx+MQGDNNRWBDgbABRJwHtV6cU4gYok/8sLeiZl/kEfURGkyNCgx4
         yJ5u2U3El2EfhHVlwD2+Ks8iPl/NExtPerCreHRyNmEHbKqm0dj/P1TD50h09AJ1wf7q
         yR/7wjdf7Jy+IvYbPgMQDeeui3fXWECb3Pq92dZFn4an7OqZFRLYE9kuOY+gc09u6q5q
         4mUmRFe6e9kbcwRsmToAuzldkSSidW/J6QaNCaCLoT/GNgLi8vSExQeC4Oj7ZrL5nF4C
         /xSw==
X-Forwarded-Encrypted: i=1; AHgh+RomudDnyggBy/N+au4y4149bYW+rQYr6QtW7bO0ZcYhK5t9l2jtZai+HoJ+XnZ2Zzr/+fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9H0LRN4cuASWoPNnMclnDJzDE+NK7Q6+sglGj6LIfKqdBdxs
	tjv+nfRi0PsuFFd44XsR9GRuXd1nI/Ek9CXgyBxnxEFCSQwcOz+/EYgYCL2hr6NMPTeWjo62Xbq
	GuQ+thhOmZgPRt7vHcF6LPPyiUf/K8eZONovsrGiV
X-Gm-Gg: AfdE7cmGaRj4/j2i3FtUBta3kxBpip9gh02AdNe3ofnVg9DaJcVDpK/jdKnoh9SflwF
	OB316AVtwyujDO2L5oUyVSnlA3gS4cVmBHvNRORLCUtylAmA8RdZODehZAjnkkWquGCFAK4yq0w
	WiBuqgvoX7ndsXVsNbtik3/lJJvrKHpDhfs/H0QfH/IMspYW7pwNtzbDIYpYItpKTnM8xAniyVR
	jMZNqVU7iiSUcFQBU/oZEyFJmYlWdr1WLqfB/0EhiZVqi+hCAaUnK5sA1z3MJT6YjbrIPit
X-Received: by 2002:a17:90b:2243:b0:37c:8df2:9f58 with SMTP id
 98e67ed59e1d1-37dcd693795mr13202578a91.7.1782435588880; Thu, 25 Jun 2026
 17:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net> <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net>
In-Reply-To: <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 20:59:37 -0400
X-Gm-Features: AVVi8Cd4ulYvs2DKtFkdpFszV6gWiAKpbVDy2keWpfJ_3pQ-uNZ88dwUZ7P_Y9I
Message-ID: <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 4:37=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> On 6/24/26 8:42 PM, Paul Moore wrote:
> > On Wed, Jun 24, 2026 at 11:37=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >> On 6/24/26 5:12 PM, Paul Moore wrote:
> >>> On Wed, Jun 24, 2026 at 10:03=E2=80=AFAM Daniel Borkmann <daniel@ioge=
arbox.net> wrote:
> >> [...]
> >>>>    include/linux/bpf_verifier.h |   1 +
> >>>>    kernel/bpf/syscall.c         |  76 +---------------
> >>>>    kernel/bpf/verifier.c        | 163 ++++++++++++++++++++++++++++++=
++++-
> >>>>    3 files changed, 165 insertions(+), 75 deletions(-)
> >>>
> >>> ...
> >>>
> >>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>>> index b44106c8ea75..026b61d78bdb 100644
> >>>> --- a/kernel/bpf/syscall.c
> >>>> +++ b/kernel/bpf/syscall.c
> >>>> @@ -3189,10 +3121,6 @@ static int bpf_prog_load(union bpf_attr *attr=
, bpfptr_t uattr, struct bpf_log_at
> >>>>           if (err < 0)
> >>>>                   goto free_prog;
> >>>>
> >>>> -       err =3D security_bpf_prog_load(prog, attr, token, uattr.is_k=
ernel);
> >>>> -       if (err)
> >>>> -               goto free_prog;
> >>>> -
> >>>>           /* run eBPF verifier */
> >>>>           err =3D bpf_check(&prog, attr, uattr, attr_log);
> >>>>           if (err < 0)
> >>>
> >>> We must preserve the existing location of the call into the
> >>> security_bpf_prog_load() hook as some users rely on this hook being
> >>> called *before* the verifier runs.
> >>
> >> Keep in mind that the verifier /at this point/ of the new location did
> >> _not_ verify anything. So there is no heavy-duty work happening yet at
> >> security_bpf_prog_load. The work that is done before security_bpf_prog=
_load
> >> is basically setting up the env, initializing the verifier log, and do=
ing
> >> the process_fd_array which is resolving the map/BTF objects. But it di=
d
> >> not walk any instructions etc, so semantics of the security_bpf_prog_l=
oad
> >> hook did not change from a user PoV.
> >
> > There is still a reasonable amount of work between the existing and
> > new call sites, and the existing location outside of bpf_check()
> > offers an additional robustness benefit that future verifier changes
> > are less likely to impact the hook.  If I'm completely honest, I also
> > need to consider the events of the past year and a half; I'm now much
> > less inclined to support LSM hook changes in the BPF subsystem because
> > I'm very concerned about our ability to revert/modify those changes in
> > the future if needed.  That doesn't mean I won't support LSM hook
> > changes in BPF, but such changes are going to need to have a *very*
> > strong advantage from a LSM perspective to offset the risk associated
> > with the current BPF subsystem.
>
>  From where you sit with regards to LSMs that is a natural stance towards
> all kernel code, but coming back to the LSM hook, to me this is way too
> excessive that we should add *yet another* LSM hook ...

For all the reasons I gave previously, I can't support moving the
existing security_bpf_prog_load() hook at this point in time.
However, unlike Alexei, I am willing to work with you to develop a new
LSM hook to meet your new needs for enforcing signed BPF program
policies via an LSM (BPF or otherwise).  If, as you say, you are not
willing to add a new hook, you will need to find a way to make it work
with the existing hooks/placements.

> > I also have to bring up the same question I asked back in your v1
> > posting: have you discussed this signature approach with Alexei?  Your
> > patches abandon and remove KP's signature scheme in favor of what is
> > effectively Blaise's signature scheme from last fall; Alexei argued
> > very strongly against these changes in the past.  I'd hate to spend a
> > lot more time reviewing and discussing patches that Alexei is simply
> > going to NACK once again.
>
> I think last time I already stated that this is not "effectively Blaise's
> signature scheme" for couple of reasons ...

I already responded to these three points in your last patchset.  It
was sent to you directly, as well as to all of the relevant lists (it
was a reply-all), but here is a lore link if you haven't read it:

https://lore.kernel.org/linux-security-module/CAHC9VhQQKNvP1Who0DdUc0EsVYd_=
JoSneyzOHZ=3DQ0MP2qQndCw@mail.gmail.com/

>  From where you started out back then, it was the stance that while the
> original KP approach generically addresses all the use cases for loading
> BPF related to relocations via the lskel loader, Blaise proposed a parall=
el
> scheme which would only allow static programs (only insns, no maps) ...

I'm guessing you still haven't looked at Blaise's patchset from last
September.  You were CC'd on the original posting, and I sent you a
lore link in our discussion of your v1 patchset, but I guess it's easy
to get busy/distracted and lose track of things.  Regardless, here is
another link to Blaise's patchset:

https://lore.kernel.org/linux-security-module/20250929213520.1821223-1-bbos=
caccy@linux.microsoft.com/

Blaise's patchset proposed a scheme which ran the PKCS7 signature over
the lskel loader and maps in a way *very* similar to what you are
proposing.  Blaise's patchset also supported the same key selection as
KP's scheme so user and session signatures were supported without
issue.

> ... So I cannot
> directly speak for Alexei/KP, but I think this proposal should satisfy al=
l
> parties under one roof.

Considering the striking similarities between what you are proposing
and what Blaise proposed last September I *strongly* suggest getting a
basic thumbs-up or thumbs-down from Alexei on this new/old approach
on-list.  As you can see from the lore archives, he has vehemently
opposed the approach you are proposing for quite a while.  If he has
changed his mind to understand the value in Blaise's approach of
running the PKCS7 signature over both the lskel loader and maps that's
great, but I worry that will not be the case.

--=20
paul-moore.com
