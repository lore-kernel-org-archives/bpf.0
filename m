Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D1387571
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888250; cv=pass; b=NQQqsRpbS2+s6Zumh0P7RV8ICw8VjoD1vve9vkTS8s2WxBEpah4S5UDVIM6fTzm9IW7kU+E4mm5EUUTP0q6+VOMB9U8UvPfZgFPV9XMpSx6J3ddU5GIj4EldLU5vHu7T3O0hYOHaQ5TyuhND6Zp1+tR4e6uAGSGVTQsa1Epwa8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888250; c=relaxed/simple;
	bh=hhYA3Qk9AJQjGHr/wDfk2kd13bQ2p5OpoedeB9VSxQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlFYhjYhJf8pVaoQSxDr78OSAuU+AtarerqTwyuOgSBBeG9fMPyXYMzB9XIPY+5HVS0/O+3iijw3IUQZIMB1XPDJMvF//L5XQmCHNrCmzlhDzTuhzKXcYxWZbiDTz8CTGUzJFLlKBgQeiUyMCWCL+VrL4lrZEgIkpeDz9Xvj/RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiW0E87j; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiW0E87j"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ae222d87dso546081d50.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 19:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773888248; cv=none;
        d=google.com; s=arc-20240605;
        b=ilXep6NFw1gTNUakRs52HsPLu1xHzLUubgIdyN97bYCNPr49HSSwKhTKhJxLnYTi1A
         9/ZCLSi1OXtrsbd4CzxnwwPFdIpDsPyd02obkb3gBfgqtfiY5onvmWkK90xJ+bQcw4a6
         RB4uY7C5IKtKONJSJKpjwXQOpNxrntGNZgOLiQTnEvaSk5AcpmY+/2n3nQJRSYJ1d8gd
         Smy0MX5CB8KFO6gxLKYmfUCMmVf3EzEwV9bSCLIW50d8Y4SwBPNZgSCEHG7oDmMR4N/n
         JEkzkGjnmczc5j+eM2QAVNxTTZprrSsoi1XsD7vHeTwAaArIvY0OMTKC62v001eqhM9m
         Rrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GDIr7bhVl/dQalky2YepYk9/G4xyIPiN0Mg6FRWogEU=;
        fh=uTd4W6WqI8kcj8Q/Qxxw5uhIHAYQE7B2/fcxqXJmcFM=;
        b=fIO6FAZXnIqSnH8GLBb0V6GL9QOR1i6jrBCUp6QwvhuxRxnRLo5igvDBJ2m7KxKROp
         oPDXw8lf3LgYSnAR6+EpBWTVcg2E4mOzeT38vuuJq2L0wdG/rZy2yAZ00y3qUIRTvbCS
         rP/wRKsKp9ylsOL0EU4jAHiXiBBrlbB28lcUsYq6SZJD5giGYe66doNnF0TJ6iYd7nKf
         RV2ildQYSj5B/KBBYNj/gTA1hsmoBWZH3pMBIiRwnp7tpkhl3TdROE2n+lkhNotFLQAg
         TqMKS30jZATScv5Az44Ih98Y759FEsLKGrijvff5nQicRdkARBRehO3/o7zQNDgC+d6f
         35XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773888248; x=1774493048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDIr7bhVl/dQalky2YepYk9/G4xyIPiN0Mg6FRWogEU=;
        b=QiW0E87jivKKg1RX0BbVysJsXHbrptG4qt2Qh91D8biclvhWH6EWWPuEj+sRVl5IN/
         TUmigEyBGkThMmesfCWtr1j/0MHFJHvQhUdSjYDdE6LeUeFBKzcfq1bFjmg6PE+YVwGl
         9uGEMZogJ/Qhfs9RRMP+pPr3wbjMlHAzlpKHWAnNwHvzcWJqYf5w5XHziX63Qaxy9qa0
         or9W7+0D/hBx9FiYT0le68Cqcm1oJVUGIsp67zvjagUzwze7dgsDS66wC6Fyo0k3hti/
         TNQnvtMo49Ctjt/FpCjodVugBsu4OTqaKU12RqlfQMRxNOBnuK5ETcpUz7uhJzkqOnPg
         31og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773888248; x=1774493048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDIr7bhVl/dQalky2YepYk9/G4xyIPiN0Mg6FRWogEU=;
        b=Dg4T63f1wX6zzA8fH2z+aeGvsptU24KehAeGkymKFuF/cDMQJX+C8MgKGI1qoMf8fC
         Zr/ZOnLPy30AwAvGHzaRZsCsvjMpyHa0avpqrJFDM1mqRTpj6MfaLK2n3aif3Z5cRGOA
         ELHMKaHUPjJcS+orlhxrLNTwVPTLH4jFzXJ0ow4M30w2R5TFks8jR7ONVtf/f53RcLu5
         wEBQESv5zAROb3NLEDDkcGZcOzKucdrq1SzjYEL/C65IKY9SDx9Z7r7OGNo69ltyN7Ht
         HOVDyZsPtfKEdDXYgBhlLjlWmPalS4iSoSud+HISr/qDdil6qsH2dviRR4NIWvieUlPt
         pUOQ==
X-Gm-Message-State: AOJu0Yxhk3wzgL4E070U+mUMPvny3Z5UdjBYBwhvLqByFBOMIOrJP0wN
	kwJuZYuIG2ZrxSpf3+ssF6Y9I7ulTblcjvDrzZdKlxsGq7clag+4OV8Iibqjhr2FddSwOCnyyL8
	9gTYXy38a/xTyefU3SL9BAuwl/s40Dzo=
X-Gm-Gg: ATEYQzw6lSIxJTJ5MgsRAH5t5j4Atf0TB9LNyCmMnss2p7TnVe4u/B7cOYdI4qOMMkk
	A5LhFOp2Iv27SewK4AMA8p110EtWcMeFBhsHDVPlAABb+LIyD0Nqdh0+ewp5XtaIrIIanNoAvre
	k4pEQ2SzAeLQLLhoKFadeD2aXZX6j+DDnWNzqeNpUwcTndIA/NwyCNMVGXeM0sk+Qba6SrEanqL
	pCY4hKCp8NKytt8r5IrYLJRf8Lal8SDH4sVg9rWEMPz/xFZUgsrEZDx0LykY0QbxRWtDEm3iX4B
	EaVAvBk=
X-Received: by 2002:a05:690c:b06:b0:798:715a:c9c1 with SMTP id
 00721157ae682-79a7183094fmr60182907b3.10.1773888248212; Wed, 18 Mar 2026
 19:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318224008.602158-1-ameryhung@gmail.com> <CAP01T76xUCrDH4G2XikNvhPTn6ZbNTgQH59qt2Q_o0c9uudd8w@mail.gmail.com>
In-Reply-To: <CAP01T76xUCrDH4G2XikNvhPTn6ZbNTgQH59qt2Q_o0c9uudd8w@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 18 Mar 2026 19:43:57 -0700
X-Gm-Features: AaiRm53MDvsZWtDNwifJbaixuXv55JTZ4b4oztz3WlITv-sSZ_0UCvVCgieB6EU
Message-ID: <CAMB2axPTGwORirRscXLbnV=QMQZudG_JHG05nZHg4BM2hR=j7Q@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/1] bpf: Do not allow deleting local storage in NMI
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, paulmck@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 5:32=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 18 Mar 2026 at 23:40, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > Currently, local storage may deadlock when deferring freeing selem or
> > local storage through kfree_rcu(), call_rcu() or call_rcu_tasks_trace()
> > in NMI or reentrant. kfree_rcu() and call_rcu() have always been unsafe
> > in NMI. call_rcu_tasks_trace() only became unsafe when it switched to
>
> It has also always been unsafe in NMI, so the commit log needs an
> update. We should also note that the correct solution is
> irqs_disabled() to completely close the same context reentrancy, but
> it is too coarse-grained for this case, and we can revisit it once we
> convert to the _nolock() variant.

Thanks for the clarification on the call_rcu_tasks_trace(). I will
adjust the commit msg and send v2.

>
> > call_srcu(). Since deleting selem in NMI is an unlikely use case,
> > partially mitigate it by returning error when calling from
> > bpf_xxx_storage_delete() helpers in NMI. The check is only added to
> > bpf_selem_unlink(), which is used by helpers and syscalls.
> > bpf_selem_unlink_nofail() is fine as it is called during map and owner
> > tear down that never run in NMI or reentrant.
> >
> > The long-term solution requires _nolock versions of call_rcu. Another
> > possible solution is to defer the free through irq_work, but it would
> > grow the size of selem, which is non-ideal.
> >
> > Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing progra=
ms")
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> >  kernel/bpf/bpf_local_storage.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index 69bb2a7a71bc..cad17ca8552f 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -393,6 +393,9 @@ int bpf_selem_unlink(struct bpf_local_storage_elem =
*selem)
> >         unsigned long flags;
> >         int err;
> >
> > +       if (in_nmi())
> > +               return -EOPNOTSUPP;
> > +
> >         if (unlikely(!selem_linked_to_storage_lockless(selem)))
> >                 /* selem has already been unlinked from sk */
> >                 return 0;
> > --
> > 2.52.0
> >
