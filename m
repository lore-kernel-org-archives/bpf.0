Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3057C9F
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167185; cv=pass; b=rDIlC43YyCsPg57aCkc0Rg4HkraubQFlqVJWEkELZ7fp4jSaPRctnzBAtdmz/+yprsCxMV+vVuSY94Jj5PgXS+rmYqxyiI7A2Vmba9exco1luJfLPC2O2AtiXncMhBkjkBAelpGNuhn44R0BHE22B9PuPchD4QxPNP+jOSwwQLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167185; c=relaxed/simple;
	bh=i1udP5JdElmv9I0wfKbC5G03xGkgFOds89EiSJKHx7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/xyR1wj9HzA9O8LQZRIugKdg8Uwjrv4IVyUnlI8/9Lyk2ecZl2562pPZvDFLt6ehcu9yxesS2XQOdvgmvfwxfwquh5OnNbag7rgZ7L4No1F8z6mmExK6V4nyZV7fnQfKHj+qVZMaeLoD0jOCia6/8LazPdnAKoFu/jVqu9FCqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bsw7AjYb; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bsw7AjYb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb2314f52so3699538f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 17:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770167183; cv=none;
        d=google.com; s=arc-20240605;
        b=gLRkQk8/WidV61H3ZvDNSQPSbyjJ4XbG8BeMMM/yD/FSyE9e4Sg3M3cnPM2yODDC7W
         uYlSoHJQ23dTzaQpQ3vYI3BH1yYzxZatOyjtBrn6a7ZyzEmMwaeOdNPiR+Xm8zzE6LqO
         jsA39ufE+JQKwdjA6tay122SBPPCltKGk0IaX4AfCPCrhzpT5PqvsCcxV0UBwZ1vlyWv
         i4fy4qFucNK5olJ38FZ5B+h3SWop9JqhGhKaZ874G84lFkhhbIPsas017T6rRWpio5NF
         ikqfUQ3z9pQa9t5tqO5/pQ/MkMvJFz/ngKUEes3tSgmFL6gKJPaZPh4FP0Ik9f9KQBK1
         r0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AXQDI+Kc9gYbK7/144RC/v7pTj3iItN3DkjMUdjCmbo=;
        fh=R264n4Uifn02N9URrOdN2ZfOKqMzWxrNKqSr2B4Q2yg=;
        b=B8JEayn8JZThgPSt/DC2U9nILpIdrby7jru0R/PvWCatJorCSuYsF6hFLa6FOzqO7O
         8r+dKqrVLqjVA1it5rXdqYa0wskHqbYMHf6Nav/We+M9bWKSH6+AwUhujyAraBbu0O9U
         OzLQk+/cZYP8SQ+ZXsnVePTbfgLfuCowXsVcjF2FeEzBkArGX0ZNus3WaOleV8/7e1Xg
         C5VxShHaswL03LqtM+i+qpsxh40bq78tRcie/1pJh2+oFaR1UF4IJqbLWqOFKiVvnzP3
         /Wkz4L3B8PdUt9NZuhmIsEMVi52pl3dgQrTzlJ2Deu3XWgiWrVKwu6gwgJGnsRXpTeMV
         Uv/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770167183; x=1770771983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXQDI+Kc9gYbK7/144RC/v7pTj3iItN3DkjMUdjCmbo=;
        b=Bsw7AjYb9Kl2IWzetOQOJEij1OXoxRFHBWvX81FCv9eXqZg2gMGCYKftFcX4bpfheM
         KDDtIMAMhdn4tLW5rlRq/Du0Fv6SEmtjTeTT9H8u2cZBZu1ySpH58h3JYTpiyZojSvMG
         SS/RD3LlyhKKbL0aBhLAgus3pN2m7SaJY4xdbqMmJlXqsMvr/IzxHzyQF2JNWjevosVr
         J4dSZLR5XVNQ+mCOWcpd8OZ5hXFPgWqsfAv1u4UOJDob9Q1NxD0CX005HPUhgm64lSBa
         rGfVJZKU7qD7pIcZYW6kbLDR8/23BRAUX3lgs144IVIVMV+zbBEZe6Putvtj8FQeFwVA
         W7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167183; x=1770771983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AXQDI+Kc9gYbK7/144RC/v7pTj3iItN3DkjMUdjCmbo=;
        b=Q9F4430umyjyGKtM7vPN7LQ0QvYJ/RP2t0pYmx9LpLiXqnmSAHE5bg6+U95v3EMLnc
         kmtBFwfzDdUFYj8LgFY4K6Z82nRwnz7XA+lrXP2TDMXG9fsclYNj+E6xcNMG0Ov5Z4LD
         mGq21jDvx3whyG0ljxVm/Yn/QyPLPcA45CERGIuzgu88GN/n8juzs6HnkYzh0zzmbjjZ
         4NZfSfNNphY82+Uj5h/3q9AwZJzN+8+S6eGDCkSsZh+oyiie9FkaDyqWUJXBFF2TLzT2
         jW6RNeYCbPSS+nFH2J7DpHlKePQVjxe/XB5PBcE+5+sE/1qgOMAwF+DBZ+yhqVjEVmAE
         JWIg==
X-Forwarded-Encrypted: i=1; AJvYcCWEK5njh6pKPZHikUETuG8Sicm050dsLV3GFBnURkGQD8v9ejvBhZqnrHm81Hu1kCLj8MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmCwReBomrppLujM1NDaPNzRoDa9fOr1v1X+LEV0ZG+P3l7hV
	0pp0BoDC2OyPpbJrkllHBdi3EOrxLA2vPcV6CrI8fuGv7TPaL2dWe9aMQGeopj6kM4msbraKwRj
	mYwBfMtZt9uZ0AqYdqASCFDa30BdLZZI=
X-Gm-Gg: AZuq6aK9nsuko5SgMx4YD8VtjpBfRNSIZ/A4gLjiYyJopcSW5SGTGEmNQjYaKB412PT
	sWit5GEGEpMA8GtV/IkvSfbCDF23YTTDCLaab0PJmFufxKC8oKkAnE5YGVTLcC8830C49xq+6YU
	pRhkOpXXKz6uNXjc3sDmhbxB4FlxLpuXb7s+kM/928OC2rZv8Xqj9J6r5FGgg+ZHzGzY9w9GLSt
	AOlnx+KyFSLCKW968Q6e3SGvNHTVz9C/Ol4c4mNiM2EFNCxtIhrTLeQ/WKdqMId8Y/fctR0rT6q
	pxt3CyiGfpiCWdXWXb8ZxqqRCavxpsLmsNEeAtwmg0IF8TrRtBhgIgY/wfrgKkmVZq520moyqyX
	7S04Nue/5sWeVOA==
X-Received: by 2002:a05:6000:26cc:b0:435:e47b:e746 with SMTP id
 ffacd0b85a97d-436180572fcmr1755723f8f.36.1770167182529; Tue, 03 Feb 2026
 17:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6982985a.a00a0220.37c87e.0018.GAE@google.com>
In-Reply-To: <6982985a.a00a0220.37c87e.0018.GAE@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 17:06:11 -0800
X-Gm-Features: AZwV_Qh5EOQzcFaWo70rMUA9z7aqD3PQgiRqzc41wi1nY5QIFTdvX072wwWIiPs
Message-ID: <CAADnVQ+OujsQGaOcUxP3yGpn-e0KcQuO1SN0B_KKmfO1LtZf-A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING: refcount bug in __add_used_btf
To: syzbot <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 4:52=E2=80=AFPM syzbot
<syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com> wrote:
>
> refcount_t: addition on 0; use-after-free.
> WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/refco=
unt.c:25, CPU#0: syz.1.44/6186
> Modules linked in:
> CPU: 0 UID: 0 PID: 6186 Comm: syz.1.44 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/24/2026
> RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
> Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 2b 5b 23 fd 48 8d 3d 04 7d 58 0=
b 67 48 0f b9 3a eb 4a e8 18 5b 23 fd 48 8d 3d 01 7d 58 0b <67> 48 0f b9 3a=
 eb 37 e8 05 5b 23 fd 48 8d 3d fe 7c 58 0b 67 48 0f
> RSP: 0018:ffffc90003337380 EFLAGS: 00010293
> RAX: ffffffff84a11b58 RBX: 0000000000000002 RCX: ffff88802f648000
> RDX: 0000000000000000 RSI: ffffffff8ece7f00 RDI: ffffffff8ff99860
> RBP: 0000000000000000 R08: ffff88802f648000 R09: 0000000000000005
> R10: 0000000000000004 R11: 0000000000000000 R12: ffff8880762d8854
> R13: 1ffff9200078f60c R14: ffff888079bc6258 R15: ffff888079bc6200
> FS:  00007fb9d62266c0(0000) GS:ffff8881256f8000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb9d53e8600 CR3: 00000000329a6000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __add_used_btf+0x152/0x2e0 kernel/bpf/verifier.c:21107
>  check_pseudo_btf_id+0x764/0xbb0 kernel/bpf/verifier.c:21238
>  resolve_pseudo_ldimm64+0x3f4/0xc90 kernel/bpf/verifier.c:21489
>  bpf_check+0x1d82/0x1ce00 kernel/bpf/verifier.c:25715
>  bpf_prog_load+0x1484/0x1ae0 kernel/bpf/syscall.c:3081
>  __sys_bpf+0x618/0x950 kernel/bpf/syscall.c:6218
>  __do_sys_bpf kernel/bpf/syscall.c:6331 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6329 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6329
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Anton,

commit 76145f725532 ("bpf: Refactor check_pseudo_btf_id")
looks buggy and I think syzbot spotted it correctly.

This chunk of code:
        if (btf_fd) {
                CLASS(fd, f)(btf_fd);

                btf =3D __btf_get_by_fd(f);
                if (IS_ERR(btf)) {
                        verbose(env, "invalid module BTF object FD
specified.\n");
                        return -EINVAL;
                }
        } else {


doesn't hold btf.
As soon as FD gets out of scope btf->refcnt can be zero.
Either btf_get_by_fd() is needed or CLASS(fd, f) needs to span
the whole function which is harder.

Note add_fd_from_fd_array() is using __btf_get_by_fd() correctly.
