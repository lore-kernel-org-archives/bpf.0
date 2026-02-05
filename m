Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F7226CF7
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269957; cv=pass; b=NKlJqkf9+wjJL3nc2gbsrw2nQfNuvyYjDTkdmG6YkPKYgi51yUgevzUnjn6iNIJkSM+Uo2ASnNmrfU3xwYpT/dbb5xQGRsSJt3f1jav30f0dnFjnnuh1KjIkNfcl5fPxnTacIrxv9k/vP9WpWrX2qX0+sH1Qyq9vepJ8HBSMmPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269957; c=relaxed/simple;
	bh=EyqUe0+SutsI4NQnIIPjQmdDtSE0qjrbdBhLyEtfLfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sw6jKWzG9PGjQOkcsxnVZUkOKtN48rK/quwN/yPlTK5p+AuwuoCQdCJ+zEfxUBJd5nIiYwTLT5Hc7twwoKdtMirm36ISUlNbIPQof4xU44ZHAoOugSQ+VCi9kGwSWEu/EY6sG/ytngE+sBk4vkli0YLGfdB+EZwokuRVgoB6nPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL56avjz; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL56avjz"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-794f281eb04so5463957b3.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 21:39:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770269956; cv=none;
        d=google.com; s=arc-20240605;
        b=W4R1+TVUdb0sxabvRAtcIU/pd0FgJN1WctSt4MpwzIxd+T/CdK7OBIUl9eUBHkj3a6
         9zT9RThE0sghdjX6MFAU0LTCulRho7OcRJua/gQv3g1JNd5T3tqZ96cQRH2RANUkZZB+
         I/rARDHHyunCGUNU6Mgq7TKQXS7+ZWAbYZ32TBeOT4FO6v3H64sqgfW7I49tLYajmok5
         aFHDHtpFopfJ/YLZ+rlSANr7/DzFcO6kDTjg7nw2S5P5k1Ms81g9Pb2sbolunOFBPA63
         h0OS29bpdFPpBbwI8hkbr8wmebF4xcAlAPQqOkjw8f8Xh3IFFw1EButFWtnipJJVrxZx
         C5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PMsEOTaBBZEjoFKATr3E5W6cn/EGHtCQMDk79facobU=;
        fh=yR/4JgESdGR80u62PGy2SawE5apeL4/XoiM8NM/WhkE=;
        b=JR7eIDTwG/I/zAPjZwSIppifjxtumXVmfuDR4cbx6edITY/ORnzeuwjvut1KROkLP/
         6ELdRWO1hp1XsNPbEq9hporhxdzJA+TvzC81+SwSXFmETyyPvvC/epT3XhFoNgI3Tv6l
         GB7sWHywRlwFNpQKgly3xas2p18unk9FdZF9iBzLkCuHBH4eIxhYfpIqh9OMAkAufqOP
         etZpv4MzQmnPiK4lO2AOg5V9rubOk9CT/wB4s/u2ZTVpGYW9gXIjQfRYKsM/4gJsWVWS
         eU5FCesWxu5zNsZshdTQ6fOBAvpOgnN7WWhKHQvUGEY3LCu5dgNIhNMtFAjVRhIPp6rH
         5TOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770269956; x=1770874756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMsEOTaBBZEjoFKATr3E5W6cn/EGHtCQMDk79facobU=;
        b=GL56avjzVyz3Yx998OyjZSY6cQmrFMjsevVjIwY4Gu+/5QlK4KGcZKcnIwoAnI0zlp
         1Y9Vi2oTdjurwIlXgB9XtZUonPz7B/k2xzOj738wfdMNMG/zMHzTM+b8HfDyXt27MJae
         gdW7gQWtpCeWBPMxikLsAlIz3Ccd2k33EYNAeABXnmo48s+ZrzNPzUJ+OO7W8WDNyojH
         k+95XOD9rRTMl3cGYXqGMUR5EBnNFQiX5UYjTVy4fw6+/tG2iKmccEdob02U/yLBNz5M
         WJTeO2uqOQE1JxqpDZNXrLDNb94kmbXdbCkjcY15yRk1XMQwS9oq4B1IytrgjRuH3X8j
         NK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770269956; x=1770874756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PMsEOTaBBZEjoFKATr3E5W6cn/EGHtCQMDk79facobU=;
        b=jZo7Rv9+7V2HmsJ7ojiFjHXE2sqKicaMxtwBc2ui8nZJpDHtZajon9Wsz+8lwr3oEB
         56SRdRdVQEmgciBYCN8O/OAbW9GmFaZcWxceFhyNQ4iQdpgAXbwn8erGuMDlqTP4IsIi
         lRWcF41+g55NMlXub47zeI9gKx+ZyKN6d1YGaj9DrgkHMkcXV3lG0HJhN24laggaCUab
         Xv2WIf1Sb+iHyElT7qWiniWgtnLAeBCtL1rI0UKSDnAIWNKWombcf/0BiZfNSFRRXqJa
         ix9KweYRXbJcbj0ukyO6g0kW8dFUxvR6HOxeG+zdhxc7mxRO2vqxswZy1yazJJVUAPin
         tatQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtJYn6A77khX1UAYhqR4UcTNQyVarnIpVJlTLcIgYKaP3jRDoErvzjJ22ABecHb03NQjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM04PhZjM4u2+jN6sRKT/NcZm7KOdh9mdoTLdYC0exHo1Sk9Ra
	Ki0DLLipyh93Ryapk83vtIjhVLPNFtqw9MhiMsFweNK4I71VhODbaS89xfL7SZMT7G3FUjGAGRS
	EaBsrVWYnLJhWezM7OEPvh1ugy6e88fU=
X-Gm-Gg: AZuq6aItbQ6R9yiBcH0QQlZ+VysHe0uWZOSMSVpVQOD2vuBevQ0KVBvmnwpb/7WmE8N
	xA1vvbeN+QZYruofhfo68cVFqo9jCUb0tl5d7sSjIz1/sXZBuB+nYWzTaqY8qJdxMdrAXLD4nnl
	wGZt2YTtTLf09V/IO0iRfKNXeMkg55dzE8cPqSVZL1Xlj9s5+aVjN8lcTd8R8/Q3D+zAQXTBf3u
	Xluie++TFJTjkb92uH7xTWxr0EzxXf+VnWB1TLoD1Uxe7taPf84Cfp3aUJg3r1Dx9ubgGTK43ZX
	akZq8J3VvFWwX2pmqyJImLhfF9ls
X-Received: by 2002:a05:690c:387:b0:794:e08a:9196 with SMTP id
 00721157ae682-794fe739166mr103469597b3.34.1770269956227; Wed, 04 Feb 2026
 21:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6982985a.a00a0220.37c87e.0018.GAE@google.com> <CAADnVQ+OujsQGaOcUxP3yGpn-e0KcQuO1SN0B_KKmfO1LtZf-A@mail.gmail.com>
 <aYMDEa87sU/7LXrD@mail.gmail.com>
In-Reply-To: <aYMDEa87sU/7LXrD@mail.gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Thu, 5 Feb 2026 06:39:03 +0100
X-Gm-Features: AZwV_Qj1jN728G2sXUrrkUesIphfgo1Eb5aGsIqmAFykZQ0PK8CP81wbgdjwdXs
Message-ID: <CAGn_ityekaJpFNnaYHS==PcfDdeXY87w50s9VmeiN4r4EyD__g@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING: refcount bug in __add_used_btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 9:20=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 26/02/03 05:06PM, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 4:52=E2=80=AFPM syzbot
> > <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com> wrote:
> > >
> > > refcount_t: addition on 0; use-after-free.
> > > WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/r=
efcount.c:25, CPU#0: syz.1.44/6186
> > > Modules linked in:
> > > CPU: 0 UID: 0 PID: 6186 Comm: syz.1.44 Not tainted syzkaller #0 PREEM=
PT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 01/24/2026
> > > RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
> > > Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 2b 5b 23 fd 48 8d 3d 04 7d =
58 0b 67 48 0f b9 3a eb 4a e8 18 5b 23 fd 48 8d 3d 01 7d 58 0b <67> 48 0f b=
9 3a eb 37 e8 05 5b 23 fd 48 8d 3d fe 7c 58 0b 67 48 0f
> > > RSP: 0018:ffffc90003337380 EFLAGS: 00010293
> > > RAX: ffffffff84a11b58 RBX: 0000000000000002 RCX: ffff88802f648000
> > > RDX: 0000000000000000 RSI: ffffffff8ece7f00 RDI: ffffffff8ff99860
> > > RBP: 0000000000000000 R08: ffff88802f648000 R09: 0000000000000005
> > > R10: 0000000000000004 R11: 0000000000000000 R12: ffff8880762d8854
> > > R13: 1ffff9200078f60c R14: ffff888079bc6258 R15: ffff888079bc6200
> > > FS:  00007fb9d62266c0(0000) GS:ffff8881256f8000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007fb9d53e8600 CR3: 00000000329a6000 CR4: 00000000003526f0
> > > Call Trace:
> > >  <TASK>
> > >  __add_used_btf+0x152/0x2e0 kernel/bpf/verifier.c:21107
> > >  check_pseudo_btf_id+0x764/0xbb0 kernel/bpf/verifier.c:21238
> > >  resolve_pseudo_ldimm64+0x3f4/0xc90 kernel/bpf/verifier.c:21489
> > >  bpf_check+0x1d82/0x1ce00 kernel/bpf/verifier.c:25715
> > >  bpf_prog_load+0x1484/0x1ae0 kernel/bpf/syscall.c:3081
> > >  __sys_bpf+0x618/0x950 kernel/bpf/syscall.c:6218
> > >  __do_sys_bpf kernel/bpf/syscall.c:6331 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:6329 [inline]
> > >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6329
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Anton,
> >
> > commit 76145f725532 ("bpf: Refactor check_pseudo_btf_id")
> > looks buggy and I think syzbot spotted it correctly.
> >
> > This chunk of code:
> >         if (btf_fd) {
> >                 CLASS(fd, f)(btf_fd);
> >
> >                 btf =3D __btf_get_by_fd(f);
> >                 if (IS_ERR(btf)) {
> >                         verbose(env, "invalid module BTF object FD
> > specified.\n");
> >                         return -EINVAL;
> >                 }
> >         } else {
> >
> >
> > doesn't hold btf.
> > As soon as FD gets out of scope btf->refcnt can be zero.
> > Either btf_get_by_fd() is needed or CLASS(fd, f) needs to span
> > the whole function which is harder.
> >
> > Note add_fd_from_fd_array() is using __btf_get_by_fd() correctly.
>
> Thanks Alexei! I will send a fix.

#syz test: https://github.com/aspsk/bpf-next.git fix-btf-refcount
