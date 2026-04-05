Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D0370D47
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775425599; cv=pass; b=MY668IPNjjINKyy0gPLpS9OGKEPG0fB3J8jnmhhzcOfvMZy150hBLIZYko2pRh1LkpWHcb7p83mrxvwBPjW0PLRX84GhbYf3bgFP+oLnAv2aFe8DjIAjC/G7u9ersMakjCRVS6UdYbeXcCoRppjl1O2uaITBc2twGfFvmccw1zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775425599; c=relaxed/simple;
	bh=ZIl0tjWdKfz5/gPAta0Lu8cS5krI8bnBYXnLZGwMrFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EySzODsOAXydVJRbt4qnaIns+YYmsCtv7VH7lKeAd3lQhphUCm309f+RSBMzm65aeljp+1ooqQ9Ss78SofKnwUH6O3NObp7WaiHzJmwQ/Uy5B6wzTvokkFdw3iOFoETEPwBu0xXc/sKmlxqtcDYnu5etAlTSDyrFi0riDfkyc3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlVEPEC1; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlVEPEC1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d864c23bdso337341cf.1
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 14:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775425597; cv=none;
        d=google.com; s=arc-20240605;
        b=f+j/wWvAONIHLuDJdBen72RdL1wXHRrbjwG2xSJGEgiiRetsqKMzYY8Pwf4aQeZ85H
         RWF71LzuWXHHNALFJ5P7hFmPbFETK5lyxo9TG0nt72Df/o0oe8gMzzO11J7gb32IGcJC
         /3RA397hq2ZuMpBdcbelCNmOfxs7mHVBysenLHgP0hD56EuXa8UfaPSBqDJqLFeJADNo
         Bijbpt0VPiuvKt4hVM//bkPCXlSZGkwfBFzVUpCtiaARLItxwh9dGE2I4fOvaXwIKNaZ
         L4e7jW4ip+1ok30SYs5/bdw97J8prD/bbmadAZP0EoMAb4kldEGVjx9NxbxJWFkKtB7I
         s5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nnP0iQcB2MD7ORxXgNkjVO5V55ipHvEI4mt+zPt40Yo=;
        fh=PTqpzMGsfOoR86C43XmZgD5GJuVw3+j44myt/C3Uuuo=;
        b=CkfL4TzwvqAD37qJ0xZ97sTCoT5nZNSq+WqlIhJcVFYSjjBOfGrg6h/dPjbZneOGfd
         FRBQ1ugQ3oW4q1ikI72ouckC6YO/u9F36VqjIe2LT2rkwEh47mgizsnjNBK/1FtG6xgz
         6hVYPlKxPlbYXxiH2zZKQHAGFL+rfKswIGHCJ+siIIsBWlMStbqOEduK8rioThCb1vBQ
         xIoegxBwSSR5+2ZSQGyxUJC3mCV3hVm1/9FfxRsS0UyYBnYe3J0VY49FCU8Kfd+bG9j5
         N9ZdvDhkK/I4Ce+2Q+zjlFfBJjAwHJRDXFjH3w+98v6OK37UxFK8ww5OHjTn0gNjaCJN
         g3fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775425597; x=1776030397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnP0iQcB2MD7ORxXgNkjVO5V55ipHvEI4mt+zPt40Yo=;
        b=IlVEPEC1KRW46bJqmYObrF8MGCFBRZy9Nc7WGloOHjgxJe+luMoU0HwvH/XGUDsbCE
         9WYp6YwD6/vb5rFCTE7f0gCjmrWt975gU13lZX7zNgcJRqLcyEVrbyYGY77sSBKVbsZh
         Z/LSR9kiTICPdELp9hsuZe6APmrPtwk31kg4VtQn7hS7bn1To4IkTaftRLVxLOpteC7Q
         RoSICLHgZszbT7Ogi3iIgNh422nTvAN44DNCvpcNoLYo+5Sc8pusfz1r56pw9Kgz07/7
         iStIaGDjL2k3ZgquX4G3uv2hdU/zKNS7+w0WV1IWQQ9FSy/UXdpbGGW4sDMaEerkG1X6
         JXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775425597; x=1776030397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nnP0iQcB2MD7ORxXgNkjVO5V55ipHvEI4mt+zPt40Yo=;
        b=dQaMncoeI+XbLyrE6DTx5PKfvvQBJcl62bMErP8hq0BjUiSw81aHktLvJwcSqlOlWt
         ZuInEvNXGKQUHJM4DTTD03ALAVyBhAD6ct5gbT50JRvGodcoKXpS3moewl0W1R+0AvfJ
         Hya4BjnSQM89mtdt9hPdNfrisJeucjq1e5ql7/y9VRFwRczZWGo8rkDc5C7pWxEFy4mR
         ++bQMuP4i5x49rFByEwD2RQ2irLS2/bLTn6XdcY6FsAifgJS4lXmwa6nBTl3Tiphc/YV
         PN2LjW77OFGEy25IkB2wnP//nBrLLPPrmIq2xVE/3Bg0rJI0D3Lym+lwP9Ut/PNNgKSU
         H0fg==
X-Gm-Message-State: AOJu0YxNbAHXZW+Bn71yXfKTKfQHwIIdgDIAHZG6dcxpHY6H2rYXJt6w
	b4zjWS37S9Z2yDa2Lt5mMo3pOygwlj73SQ17WnxFLCnm4HJ+/YRMZdYvtJBKhBOWs7PbZr8RL/m
	+AHW+isXW7tLn/7WhYj3/p9+ATnU89gZaoA8J5Udf
X-Gm-Gg: AeBDievP2skPIk15qkTwq0KKTU4ncTxWOphPT/h+blicrltXGtFCqmwSnOXUtjATCo2
	sOBgNX6pBKdUOHfBQdb6raFIbCP7DYEVwA/fKzJX6AeSBcZx0s8Pl2gKIw6zjeqHOLoZBjPspHT
	jShCjtnBgX2WP5KOvpkq3bclIW8BvemUZsfYdj4Wm9Aqz7dlFqmPTPmZTc9hAsEv5lVCo+qqeeE
	HC+mkN7IuBn6EWLhvWBKGmHuXQFFgsBgoGIc8b/4SRcmvQ5ntF0rHb0+ApopPKqiiiMleoIbV6K
	RRSE/RIHBvNQAS+NuGnTEevjfg2jkPyAy7wmzg==
X-Received: by 2002:a05:622a:1826:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-50d63fcfdcamr14900871cf.12.1775425596709; Sun, 05 Apr 2026
 14:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGcL+LFNBk-+9Z5W+8Nyj1+rxCkgR=EiQiLdHW22dSKvgg@mail.gmail.com>
 <230953f5-f64d-4f58-ad2e-f3ea9358aff0@linux.dev>
In-Reply-To: <230953f5-f64d-4f58-ad2e-f3ea9358aff0@linux.dev>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sun, 5 Apr 2026 14:46:24 -0700
X-Gm-Features: AQROBzCprxc1jEW54CymfEhtg-f9lEWEPo_-6aOcUoHGX0YHNZkIgxe5NSVzFEg
Message-ID: <CANP3RGdf0ESYZBqrhjbZjQMQzTtms61M4DBdixP09h+EG6LP_g@mail.gmail.com>
Subject: Re: bpf() system call writes out of bounds of user supplied buffer
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, KP Singh <kpsingh@google.com>, 
	Neill Kapron <nkapron@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 3:29=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 4/3/26 4:22 PM, Maciej =C5=BBenczykowski wrote:
> > Took a *while* to track this down, as it then results in random
> > memory/heap/stack corruption and segfaults, but:
> >
> > kernel/bpf/cgroup.c -- __cgroup_bpf_query()
> >
> >         if (copy_to_user(&uattr->query.revision, &revision, sizeof(revi=
sion)))
> >
> > doesn't verify this is in bounds of the uattr + length passed in from u=
serspace.
>
> If the uattr indeed has less than needed space, then for
>          if (copy_to_user(&uattr->query.revision, &revision, sizeof(revis=
ion)))
>                  return -EFAULT;
> the kernel will return -EFAULT to user space.
>
> Maybe userspace didn't handle the return code properly and causing
> user space corruption and segfaults. This shouldn't be a kernel issue.
> Maybe I missed something?

That's not how that works at all.

copy_to_user() will only fail and thus EFAULT will only be returned if
the memory area copy_to_user() is trying to copy into isn't
owned/mapped by the user (or perhaps is read-only protected, not sure
about this last one).

Because memory is mapped in (at least) 4K pages, the memory after a
user buffer is almost always still valid memory.  It might be unused,
or it might be something on the stack - like a return address, or it
might be on the heap - metadata tracking, or a different memory
allocation perhaps entirely.

> > I *think* there's likely lots of other such copy_to_user() problems,
> > but this is the one that bit us on upgrade from 6.16 to 6.17
> >
> > It was added in:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/kernel/bpf/cgroup.c?h=3D1209339844601ec1766f4ff430673fbcfe42bb51
> > bpf: Implement mprog API on top of existing cgroup progs
> >
> > But it seems to be just generically bad style...
>

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
