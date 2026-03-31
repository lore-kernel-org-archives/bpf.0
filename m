Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6E38F95A
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999129; cv=pass; b=qHCv4CklIiGat4+bXLBABx0A/2y4WrYTnVt0RF0vmq1FPMFzKQGGCfrE5HYifvJ/6f7AOzfxV2YquUAFL9j4dHokCBVQ8OLW4XPr9qKZIKP7lYaZds1xVxqzrKI8htg1bLslqCjvGB/9YGRP/XJL2w3rcfIaUexOrQeST44dnzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999129; c=relaxed/simple;
	bh=Ep3aRbiHaV/UYMBBrDbliRfaZKtkwhs5HbkU3sXRBUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNdyS6O800//+q3uTgWsnCKkxT+Y9nCjwuK7g3xjQ6A5kq5dypyvjgFjXjpUQvrzrO4fqZLv0MkhsfmggNhNxpBGyCT5ap9hpxtif8x8yJFllbT2L/MAnLl8ZM6LHNaH2BDT5ru8u7lgh+7cDTut+V4gOamcNeiqLPt05kgzTAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sM9WTPwR; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sM9WTPwR"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a80c36350so6727549c88.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774999128; cv=none;
        d=google.com; s=arc-20240605;
        b=eQgZZJq2LarPQexB6aqjMVpdGpeSpm644usMLoryIBhSnYHTvREmx9DHMGXM8GwXS1
         08Fmynz51f67lmZ2Eq+4BoTDds7vWz8G81m2rMatE7jELdYruFOiZxyYI6uLB19SpbR+
         cfUsj91JBflt1TG5qG6+wu1tieOHS5nwwue80j6RiRDn8C/q0+BqvgqZgbmY5ftJVWuD
         sq0WiMImSCRrhq9MFjph4Y20J2ly29SpvyMwy3eC9dMEXzauTaO5opsdumIvGRfR3w9p
         b7c/wfBNfgOKr290g/U/OygwlhScwvzNfefnneL/KcTvnC7dgKMmY0tfIwQTUacMLyQ2
         s9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ep3aRbiHaV/UYMBBrDbliRfaZKtkwhs5HbkU3sXRBUc=;
        fh=fpx/vQ7gPU8cUcS99HF35FSuPB3uHtZS/IX22ZLmRoU=;
        b=eYaaNelcRAOwwpLCCtINcf42kSP3z25ZebFUdhME/5Wfr0bfMliVGDsWWpE8RZD5T4
         OhdYzBCz0l5Re45HarpTVBsz9iUsouOF83A7QS4aV5mGIizlLC7GAQZmbDs+FiyJbe+i
         NktxWpdXdj+ixNo0PDq8+EtZH9I3EoruxlPVdGTjwdRTC6dLvyGpv9y18lgg198Kq4N2
         Yhuu2bdg5hAJGIJ4LXMn7zU7L+OxGyvzPehSevy5NN7WcCCGWOiKdftnC+cU77PSBS/+
         nc45e1kloKw7+GQPwq8yfzmI6HkZdrd/FReHVZKc/8J5IKQlSbz2qHP7Wn/oCn8qO0MA
         eoEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774999128; x=1775603928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep3aRbiHaV/UYMBBrDbliRfaZKtkwhs5HbkU3sXRBUc=;
        b=sM9WTPwR8ZW59p85JIBE/PXoq8GU2RQvqR9xuKr2+K/a+r9tqFu9l50/WINrVwQpms
         7z1+esNp99YQzU7O5xr2p9XwGv6cWrjfM17zR1Hk+uCmJlCftdqm/qDCXU+MMElxxLAi
         BJ2XrR7s/2MjcFCInuxZ2hWdtpmH8KaggSL/b+/QL91rWBb2bSBNmGqEm6gtvomfDd4w
         7fWPWBJjSHtHoNDvAwocY0UMw/sNH1Xf7kUxa/ymYRV1mNqgPtt1Fni9akWwE7Pre3Qp
         HjhO37lsUiRCazywKbVFyZU8GavRyUEJ2BLCGya/syjtEJcChX2Kuw9DjGItPhzpcGh3
         QfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774999128; x=1775603928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ep3aRbiHaV/UYMBBrDbliRfaZKtkwhs5HbkU3sXRBUc=;
        b=jH5N+oZ6FqH/2UBTxl+IDaSnr0YP06Yu1b6VJ2u1iAJXbGGj0hG1H4q6vL4QnALklO
         jduYYch/w4XZ7LLtxrJglE31zFmTmN6R+BmosaSn0b+cQGNqx4GYm2P/3cKcf8Vq7WBh
         gi1RgIpMP3HX9jN5ENGbOp8B3vEpgpTyxi8TdF6JCOhlpfQLX79A2vlsi/1aiG6Dtooz
         2jWfmsq6a7IF+nK2GGjMkTIU59bj55VNiWhchdzO7y6w3RrGtxhssH2QxSUJps+Z5OaP
         2VGKT65LcfURNK6Z3Ar1KjP+IeYUzYb8S2higwiIlmOR0nbT4IerNd8pKzIVfaGz7UkM
         +G+g==
X-Forwarded-Encrypted: i=1; AJvYcCX4fx+Gp6CNRwNbHJGytTqcZH6FRVYtJ75HQf2BDADwYuNpzkCqbmHR49OSD4+DBQW/Cgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZyAPzTOqtZ4oLjDFTJqTQHI1tip+JD1MpHDadkIwpNmOXSSFR
	BqFdIEh/d8JE9ZFyD9bk83LEMTCC26VxsWYGMPkjsw7fZcCahm7j1Zti/XFXVFQe+17cQtz91WF
	grs8pT5YSaEcdLxpLpsxJNK+S2wa3K3/lQesNwz/u
X-Gm-Gg: ATEYQzz8qqxxL/S5yxOz1SSk+bumMV9hqVSU+H+j9trt0rC7K2PZthtebvorPS773PJ
	oQHCaSqqgnUNtBtf+PlYS/hrKQHHXb8pvVc7vOVeotdDRWn7qusu6JqAdzxdRVQvULg6t3ckwl4
	DfEynY5q/7pwYjc1drdAqjZRebFsdSH5wNFKxKh8MOtc9dJw4Tm1nuhKDTwiKMld1ETfpCknSRS
	wD+fsqZ4fS5MBh2qwjUFmOzio5xOFukV26+e4w9/mIJpupMKU6uiveRNuQZEzyE4AQQqUzdUXI3
	BQeiM37jFW36dNhciYUguwhAyndTUBHKihF0/VqTKmlt8W6y4N8FQEOD6A+9v7dOB8tX5A==
X-Received: by 2002:a05:7022:b8c:b0:12a:6fb7:8801 with SMTP id
 a92af1059eb24-12be643827bmr836648c88.14.1774999126972; Tue, 31 Mar 2026
 16:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
 <2192e9ef-894f-4826-b296-4f90e973a31b@163.com> <b9a956dd-ebb2-47ca-8b49-ccbba6ff9b26@rbox.co>
 <b21fac4e-891b-481c-9734-e95290e49097@linux.dev> <fa818820-c0c9-48dc-8ebc-661cb3349935@rbox.co>
 <dd043c69-4d03-46fe-8325-8f97101435cf@linux.dev> <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
 <CAAVpQUAtF29CPDAdEUchYOP=oy8D2-B3GH3fWs2pwTmnYoTu=w@mail.gmail.com> <48bad987-a130-4fb0-b4de-e39deac80ab9@rbox.co>
In-Reply-To: <48bad987-a130-4fb0-b4de-e39deac80ab9@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 31 Mar 2026 16:18:36 -0700
X-Gm-Features: AQROBzBDc0n1-_f0-_wUbzS_nTN6WPvIo3JBShn86M-8Oos7kh40q0Zqbff_Ie0
Message-ID: <CAAVpQUAHijOMext28Gi10dSLuMzGYh+jK61Ujn+fZ-wvcODR2A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
To: Michal Luczaj <mhal@rbox.co>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Jiayuan Chen <mrpre@163.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:44=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 3/31/26 01:27, Kuniyuki Iwashima wrote:
> > On Mon, Mar 30, 2026 at 4:04=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wr=
ote:
> >> On 3/26/26 07:26, Martin KaFai Lau wrote:
> >>> On 3/15/26 4:58 PM, Michal Luczaj wrote:
> >>>>> Beside, from looking at the may_update_sockmap(), I don't know if i=
t is
> >>>>> even doable (or useful) to bpf_map_update_elem(unix_sk) in
> >>>>> tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when lo=
oking
> >>>>> at unix_dgram_sendmsg() =3D> sk_filter(). It was not the original u=
se case
> >>>>> when the bpf_map_update_elem(sockmap) support was added iirc.
> >>>>
> >>>> What about a situation when unix_sk is stored in a sockmap, then tc =
prog
> >>>> looks it up and invokes bpf_map_update_elem(unix_sk)? I'm not sure i=
t's
> >>>> useful, but seems doable.
> >>>
> >>> [ Sorry for the late reply ]
> >>>
> >>> It is a bummer that the bpf_map_update_elem(unix_sk) path is possible
> >>> from tc :(
> >>>
> >>> Then unix_state_lock() in its current form cannot be safely acquired =
in
> >>> sock_map_update_elem(). It is currently a spin_lock() instead of
> >>> spin_lock_bh().
> >>
> >> Is there a specific deadlock you have in your mind?
> >
> > lockdep would complain if we used the same lock from
> > different contexts.
> >
> > e.g.)
> > Process context holding unix_state_lock() with the normal spin_lock()
> > -> BH interrupt
> > -> tc prog trying to hold the same lock with spin_lock(). (_bh())
> > -> deadlock
>
> OK, I get it, thanks.
>
> So here's one more idea: the null-ptr-deref issue is connect() racing
> against sock_map_update_elem_*SYS*() coming from user-space, not the
> can-be-called-from-BH sock_map_update_elem() variant. So can't we assume
> that for any sock_map_update_elem(unix_sk) invoked by a tc prog, unix_sk
> will always be "stable", i.e. in a state that cannot lead to that
> null-ptr-deref?
>
> IOW, if for a tc prog the only way to get hold of unix_sk is look it up i=
n
> a sockmap, then (by the fact that unix_sk _is_ in the sockmap) unix_sk wi=
ll
> be already safe to use by sock_map_update_elem() without taking the af_un=
ix
> state lock.
>
> Long story short: take the unix state lock in sock_map_update_elem_sys(),
> don't bother in sock_map_update_elem()?

but it will prevents bpf iter from taking unix_state_lock().

I don't see a good reason to introduce a new locking rule by unnecessarily
wrapping the entire sockmap update with unix_state_lock() even though
the root bug can be avoided by a simple null check in a leaf function.


>
> >> ...
> >> And sock_{map,hash}_seq_show() (being a part of bpf iter machinery) ne=
eds
> >> to take lock_sock() just as well? Would that require a special-casing
> >> (unix_state_lock()) for af_unix?
> >
> > Right, lock_sock() + unix_state_lock() + SOCK_DEAD check
> > should be best.
>
> OK, got it.
>
