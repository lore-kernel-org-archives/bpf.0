Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6D2C030E
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 05:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778908523; cv=pass; b=Bcqvl3yHRPbzHQQli46O9l5pOZYyrAwhfylvEVyH1Rs9DB3asTQDuMABvRLLVQnFg7vig1cX9Uq8m39rkBHCu49jMsuwTZufcQWBdiJ6vCUd40QEgDkLYrYCdYjY2etcJCRuDzfYtKOzUfXnY1S2krnixVG0j0hKoLU5a1fHlKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778908523; c=relaxed/simple;
	bh=gnA+FyKYQpwFkrmRTianUAGvoNMOp7VWotoDlh4ymhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPyG0nLGcMGDFHkSNZkdNitAzr53ZnsQe4fA4F32XA015hJd9V+1iTDSp3Ne+A5I1okKKf/RiiI64dWfaqubScMaSOGVNubr8lEkzTjLbLAMMwAbfWXjSDO9A4Yo2X4+CLQ5dvzjbnXTPTWi+ac0v8ZmDGllsi598SEsWAuB2wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbUBwrny; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbUBwrny"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so582162e87.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778908520; cv=none;
        d=google.com; s=arc-20240605;
        b=BQpW5lOcRplMHu+Ssh1nkUdilBbLn79yBbQlAsVAuHedunjNiNHRamdMEWfJs+NAoE
         dgz0NVQcClASCcMcL3WA2f1FcwBgKY7G4FyaznoY6q7luByyuNTFcSm0FR+nB5YOxtyV
         7A3tqslf8lPuUzzO2uacfX1fJcwa3ZlvqCJjjNfKLuwDfesnwgB+2uM1a54iUMf1YRLE
         nAPR+H0D4wqygIBgP55Pd4Pfue4TSR41DiXNCwLT++5oQQYnjtF2p4buPLj8phmV2wve
         g6cX0YHxui7yLpd1hGt8TFMqi5pI+rECYNmTnLNtAg0UVM+jz9k0g/11Hmk65dXSeQcM
         SEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mXx4yeLCNSASPhX7mJjRFot0w+sBHWQk71/FDmK+uKY=;
        fh=TlCx33484fFqfcvCoe6qmyVK38r3VSt5KFQYY/qQacc=;
        b=COQ3rcnC5YGf1cXnwt0jqgX/p6FshEgp5TQ+fu1BjEaQ+/QN2n2wGDZ+W47AFD3545
         +7BasuaoylQy4UBRngZRTKzmzG89JBfSO1Qyciglj47ooqM06JLv/cUsLcpb3pPxVOF8
         CSLctauKss92E/6tjMOqelPFncM9QGoQPLKkSFqnDicHe4w37z3Rgs2AEQ8IPWS5Wax6
         uZj91Cr/XjiE18MclBSpslzVouUKynHZIhrRZkO4xKy+Nhbb0Kqvr3RtncqFOvVofEvH
         6HjjFnvEzJl8U0byponCwDJF+ilsoGDmor/VUh8sqIYrtou0LwC45Fs/YRzM/6Zn1YKO
         0Kcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778908520; x=1779513320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mXx4yeLCNSASPhX7mJjRFot0w+sBHWQk71/FDmK+uKY=;
        b=WbUBwrnybpJZf/vcyg/r1h/p1YILQOIGfiBI98oJYhKgjIXij9m+NSmCY0uBReGHbL
         8jz2tB/luC/CkRp+EmZ/jDW7kLyTpJsg32bgvRd1HwtLfD+h9URZdoh8L+5Ecj1n6NPr
         KCtXZEk57Q/nmczjkzt//fa/hp6zmyiw0DVL6ILLvLbR46jE/nIlckHnqRTZksgKomj7
         PEi/4U0MSUAGhHB7SLIJY28CN5PXQ2zVIE7UlXNuAn8JojtomXmHe3e9wvvZoFpl48pn
         n27SEQgl4C/U1Otxq6wKZc+xtlwQeh6BSW7ytBNYKe+TizIMf+M1QlrSafIHcuZjlFQw
         iWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778908520; x=1779513320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXx4yeLCNSASPhX7mJjRFot0w+sBHWQk71/FDmK+uKY=;
        b=DK75IRSqUxju6dCTFg92qr0Z1kVV+I7fxvSi+mzkFewvidrBG5+/afA/YWavwwzhsQ
         3sUB15A3f7xYtKJGlwB8aTGS/pw07q4wMSnft/iFJTkqOF+aeLvjY0VLRfCMaDNg1pU7
         e9bfGBY3BXeMKh06YE5Rzi7x/0TZJfj2sH3WJQimmT5vS6axnScjjd7QQxRHkEanEbtE
         +BfUKJ+G0eILjaJ2akWxEh+/A7hhAsI1x9D0lpJw85S9Ach44qaKMTclCahuYqu2VZjq
         YT+qXlDBb6t6hFUUsjYSWIclM2tsf2blv6fUIoi9U5g3ZVl/4PpgDesS9iioytFiLLAS
         OIjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vPSYx2FuLtXuh/fL6DjEp287vaL6lm07NItB8jfGi/qpLhceokHsmth5M2T/YvfLIR4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YytSXGnbqKWbNuFvuDRhBHc12RhrYpy5tUsjz9zEhxGtp8dnKlo
	kNAbrNv8UX07OLH6DtG4PL/lPeGO5yTCO18pn5JmHmMrIm6THaBbZLruXY9LO6VYhvWGjz58nR5
	pe1EQpArgZr1OivMNZ6eVuRVvT65s4DVyhFxwk+eo
X-Gm-Gg: Acq92OE5Vd8u2o5LsK/hSAQDY9SkQeWIWxwFi5l3eQz5BBA8/Q1eF+YHmezXnmx/lL1
	UfYpi695qtOUavMKl7VtF2L3FUwiQE1E7igW7JiiLvyDK3dCOGnZU9FIj3Oj3tm804rh6nwE+3/
	20aJZJx1oW5hIQfMtGmlznD+08vjvxoVdrRx3QXUM4kFMpW5iCu2hMXpCOqQFgkP+DsK93YO1KU
	9bah3GcyaeWfJiX6uPThNdNB9CmXzoNDQmnLxJG5crc54Gau48B2T1xHXoOuiivA3r3H6DnZMTt
	O8cUVoO57ASHK/M+Yr+74eUxYke8XQMyMYIi/CgPrRDItYpZb0py76hYqt1zT7FQ6NtzQCZK6Oc
	3+7IwTOk=
X-Received: by 2002:a05:6512:401f:b0:5a8:88f8:9eeb with SMTP id
 2adb3069b0e04-5aa0e611301mr1919041e87.11.1778908519147; Fri, 15 May 2026
 22:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axOZeGGXiO-6uXOa0HUefDjoU+7_287K3au0EMLxnWu=4g@mail.gmail.com>
 <20251231072919.1018961-1-buaajxlj@163.com>
In-Reply-To: <20251231072919.1018961-1-buaajxlj@163.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 16 May 2026 07:15:06 +0200
X-Gm-Features: AVHnY4I5zIU-vGEIWUijBZKYvPJYnAryxQWqoWVhvMR2mRfFc8mrk5dQ8fwAQaw
Message-ID: <CACT4Y+b00++5Qys9hkZjMFEViLEnyt=wWt1rTNDkBT_OpXEygw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_get_local_storage (2)
To: Liang Jie <buaajxlj@163.com>
Cc: ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, liangjie@lixiang.com, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org, 
	syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: multipart/mixed; boundary="0000000000006032990651e86a8d"

--0000000000006032990651e86a8d
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Dec 2025 at 08:31, Liang Jie <buaajxlj@163.com> wrote:
>
> On Tue, 30 Dec 2025 22:18:00 -0800, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3f0e9c8cefa9
> > >
> > > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > > index 69988af44b37..2bc27ece5cc5 100644
> > > --- a/kernel/bpf/cgroup.c
> > > +++ b/kernel/bpf/cgroup.c
> > > @@ -1768,6 +1768,9 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
> > >         ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> > >         storage = ctx->prog_item->cgroup_storage[stype];
> > >
> > > +       if (unlikely(!storage))
> > > +               return (unsigned long)NULL;
> > > +
> > >         if (stype == BPF_CGROUP_STORAGE_SHARED)
> > >                 ptr = &READ_ONCE(storage->buf)->data[0];
> > >
> > >
> >
> > Hi Liang,
> >
> > I don't think we can do this here due to backward compatibility. The
> > return type of the helper is RET_PTR_TO_MAP_VALUE. Your proposed fix
> > would require adding a PTR_MAYBE_NULL and existing BPF programs would
> > no longer pass the verifier.
> >
> > Did you look into why the storage pointer is NULL in the first place?
> >
> > BTW, there is also another similar report and a work-in-progress fix
> > [1]. Do you think this is a separate issue from that?
>
> Hi Amery,
>
> Thanks for pointing this out.
>
> Sorry, I initially missed your earlier WIP fix. Looking at it now, this
> does seem to be addressing the same class of issues where
> bpf_get_local_storage() can observe a NULL storage pointer.
>
> I'm interested in this area and will take a closer look to see whether
> your patch also covers the syzbot report.

Hi Liang,

Have you had any progress on this?

syzbot performed AI debugging and generated a patch for this:
https://syzbot.org/ai_job?id=8b1e4143-642b-4b3e-8be9-194c7a66e24a

It came to a similar conclusion regarding storage allocation:

"""
The root cause is a bug in __cgroup_bpf_replace() which handles
BPF_LINK_UPDATE for cgroup links. When replacing a program that does not
use cgroup storage with one that does, __cgroup_bpf_replace() fails to
allocate the new cgroup storage.
"""

But the patch is very convoluted and is likely incorrect (though,
passed testing on this reproducer).

Let's try testing the other patch on this repro.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
v7.1-rc3

--0000000000006032990651e86a8d
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mp7w2hbw0>
X-Attachment-Id: f_mp7w2hbw0

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvY29yZS5jIGIva2VybmVsL2JwZi9jb3JlLmMKaW5kZXgg
YzhhZTZhYjMxNjUxLi5lMjQ5ZWE5OGY1NWQgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9icGYvY29yZS5j
CisrKyBiL2tlcm5lbC9icGYvY29yZS5jCkBAIC0yNDAzLDggKzI0MDMsNyBAQCBzdGF0aWMgYm9v
bCBfX2JwZl9wcm9nX21hcF9jb21wYXRpYmxlKHN0cnVjdCBicGZfbWFwICptYXAsCiAJCQkJYnJl
YWs7CiAJCQljb29raWUgPSBhdXgtPmNncm91cF9zdG9yYWdlW2ldID8KIAkJCQkgYXV4LT5jZ3Jv
dXBfc3RvcmFnZVtpXS0+Y29va2llIDogMDsKLQkJCXJldCA9IG1hcC0+b3duZXItPnN0b3JhZ2Vf
Y29va2llW2ldID09IGNvb2tpZSB8fAotCQkJICAgICAgIWNvb2tpZTsKKwkJCXJldCA9IG1hcC0+
b3duZXItPnN0b3JhZ2VfY29va2llW2ldID09IGNvb2tpZTsKIAkJfQogCQlpZiAocmV0ICYmCiAJ
CSAgICBtYXAtPm93bmVyLT5hdHRhY2hfZnVuY19wcm90byAhPSBhdXgtPmF0dGFjaF9mdW5jX3By
b3RvKSB7Cgo=
--0000000000006032990651e86a8d--
