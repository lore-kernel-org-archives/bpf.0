Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A32F360A
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354104; cv=pass; b=ALlB/crPKZ0HU08f+PWtUxPzAzw7ZLBWk/QmM8QNKa4VyB5TUORR7hqazQCnEDhjwHtzmYn/1e59n/49mU9LnT9Ix7itSwIWfhNuRXhKvekhT7ommiOVxV55yXZi3rnY+3h/w0ZrGE80L6dLHoh3CUH+nwG/Fx1ofBSxAU+4NrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354104; c=relaxed/simple;
	bh=SqtSDl1Q6ZdFKhEVIWTLTCuTe73Pv6yPw/9YrDko77c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhiniUcbvmLMIm7BYbSYYOtWYR50tb2GGihuqS0lQO9z/UtKXvpOfAFjmJjT6CGUh4xgHhWZbknzmnJG0EEq5YKpqAjq7+YPYTf1S+DqsjuLgfxnvph1j+0DG2GtTw2qLLWOscP18Ov3csqrRITcD4BZYMxTeKQMvLzYgMSgR5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsaETlye; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsaETlye"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2dd6665a10fso3699205ad.1
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 19:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789354102; cv=none;
        d=google.com; s=arc-20260327;
        b=m1rZNTwlyB6XjXiOFrgYL3MjeObFtA/ob8PRwKgpvuBb9u4lqf6Sko05bPRzSdyu9b
         6ohkEEFuLfuF7gIGe62ciTNGhxHCWwpQyeMIPn//kOLjCsZwUZNpNsc/F/Wr42u12Bfn
         AIu/tJPslx/3SrBzjTjuxdIF+ZS9KQPdBaP+Rb+tthuOLKBMEEW8pbLZ1BC8AjtZFhsF
         genDadJF/bjqS39nObTR8xf+jUEaNH2npwG+KVZDUFqMclJLmw8ni4CV1tJcqQYpISvH
         ew9la11CXyZfhbvng5JHjioQNVMmustmVwwjSBZHJBv/BzcsX0yAirtoBGP4zF98BZ8T
         Fk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mlc3UItL87KlRfxbz8MzgjKczqV8lw7x9c6ySA+GhQc=;
        fh=ZLPGoRMgRRlDF6n3/L+wf7SDa4wbGQBZUDQeaAJzijo=;
        b=RkPr586BcMAqQHMOE0BSioMW4FlZRmRH7KzZ759NozsdyGDvhL6Ig30LtQy3bIPHVF
         ahvz85GwFvHI7tzHoHX1jz/S3v+3x0q15Z3uJ6/5vrazJlauZqCe4//4Ume0bUuSCgSL
         C53V1JJCt5zS1sRdyyzB3Li/JXlKusL5+MbaRHdnQtcJvfP4JgFKTxSZUw/u/mYlrptC
         4gVp0RLUKa42FK+dgXDCBP2qDeKbUyujhleSIGve1q75su4vB+Q0HUkPhxzc4q1L6Mgc
         D5tjcU9V95lcvkpwrZP+sR0Sc9ovG8tqQbGo2wcf1FUxc5wEN2GISlRRMc0GPMl9flVQ
         T1gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789354102; x=1789958902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mlc3UItL87KlRfxbz8MzgjKczqV8lw7x9c6ySA+GhQc=;
        b=IsaETlyeAOCwMWwJXQAYT1wT1oz6NRILU6SDAfO2WVNRTLKgES0+46WiuKeIg1zRAv
         VO3YnxYIck5/8uVMpMOvXA9TfCVh66/TsA7H/rqS08xHq8gev7yUT0AJCvbe0BEO2L1a
         L4gatPmYOwhTJhczawWUeZdkb+qHmVzy65khk2fzthUpQH1wo8WH+c8jLpZuVwOahq0M
         9PbkceeahPmpH22N+4lQ2HuZC0HWKmpMrpYt9vubz5rjXyi+3IgQiXS5tPdr1TMTUPqa
         5iaDfWKrT3Ip8sbN24XPwSKXmlnlwnwzHjr6pC8xnkQXygO62exnhhorhr/x0x+7TCH7
         tgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354102; x=1789958902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mlc3UItL87KlRfxbz8MzgjKczqV8lw7x9c6ySA+GhQc=;
        b=pccCLjn5s8lpU6YXIFPVyeXEGYP/KkEEgPF47XC+ecrKL1Fn7iuHIXWzVDYm3xKcxZ
         tqxZcrXtIaRrfZPsudTsrr0XEfxUp5lm5SLkQO15VJSh6VZkO5cD/rwu61veRWbQelQ8
         MM2njKlZNa/PdmDRDT/PZamzrwZHUGCubd/JPe6+HSLdLSt92UaC+yD5izwim0qUJXJm
         AjTA7Xdobz88/+nxtiWdwE78BHh8hHUiLg0icJoufhsls33ezoJ44/RHtJWCCBiaOEEN
         yOM48QfWwNYjRiagdxnBanAnCwG/q4T7pLDshw7nPKMGrIgAzDBxoBSGuCnxL+T0Mo/S
         gfWg==
X-Gm-Message-State: AFuF++liLbdAJAMi3wDiYrxyHfMQHQ5kmjjIzjsNNVBS9QPmuUuWALL/
	wI6YiwGfCOcXa4Gg55vTUcI9odN8VLEeGh1q32AMAyKMjWnHGaMwruQjBoW/RgDUPXFtepryWzt
	KEc7Uz4mxL9zD08LCzfI4DhoIgHBlLw0=
X-Gm-Gg: AYBFou1c5alVJUm7EXEdZWGQoRPTeob/bVwGw84sAIvie3J42+XKiwKwbmch0sTqWka
	aVlyy9gavzPXP/7f1rtxanEHDeyxOBK1Mqa8tNH+puvax6hoB9VtWbM1Vwma1BHqj6QRwTK8PKD
	f0taHzV55m1kJpVs1MIacElFfiCti96TZXDQOYWfE6c8Nfj+/b/auUu1ww81Q08RVI8SxHALIfi
	5Vyhmwc1TJjPCNuc0utO7qNb3ovZwvPSZudxbDxr/+b8uwCv23aYiUYaW9GJ2Fd0gLUZ93TALs4
	r9pM4FFa+N+fF7+43MrRzvzhbK8WzejGzrtqgsRDSV5n/pjscKMlt+3hNeNyqTLho2OydkXrurF
	K3HGnErYsbdPk3MCUTLjbVdq4ZltfXITxsWFu5I9R92Nq8p4MdW8=
X-Received: by 2002:a17:902:c409:b0:2c9:c952:6e9 with SMTP id
 d9443c01a7336-2dd6c5cc85amr14257695ad.2.1789354102405; Sun, 13 Sep 2026
 19:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905021139.4116529-1-pulehui@huaweicloud.com>
In-Reply-To: <20260905021139.4116529-1-pulehui@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Sep 2026 19:48:10 -0700
X-Gm-Features: AcwNN1WjLSzLcE_mJR0fp_rRBPZY3Y5mnlPKwAnUf9D8Yr6gIiQ87XIB69PE64Q
Message-ID: <CAADnVQJcF3=w4BXjWXuQ6Q7oYMVFDUy_iRaLygkORcc=_+FM0w@mail.gmail.com>
Subject: Re: [PATCH bpf v4] bpf: Fix UAF due to concurrent consumption of
 ttrace lists in alloc_bulk
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao@huaweicloud.com>, 
	Leon Hwang <leon.hwang@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 7:06=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.com> w=
rote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> Syzkaller repeatedly triggered UAF splats related to nodes in
> waiting_for_gp_ttrace within the bpf memalloc:
>
> BUG: KASAN: slab-use-after-free in llist_del_first+0x85/0x110 lib/llist.c=
:61
> Read of size 8 at addr ffff8881572cd080 by task syz.4.470/5112
>  ...
>  llist_del_first+0x85/0x110 lib/llist.c:61
>  alloc_bulk+0x193/0x460 kernel/bpf/memalloc.c:229
>  bpf_mem_refill+0x386/0x560 kernel/bpf/memalloc.c:436
>
> Freed by task 14:
>  ...
>  __free_rcu kernel/bpf/memalloc.c:281 [inline]
>  __free_rcu_tasks_trace+0x48/0xd0 kernel/bpf/memalloc.c:291
>  rcu_tasks_invoke_cbs+0x1ec/0x3e0 kernel/rcu/tasks.h:571
>  rcu_tasks_one_gp+0x13d/0x220 kernel/rcu/tasks.h:621
>  rcu_tasks_kthread+0xf3/0x120 kernel/rcu/tasks.h:651
>
> The reason is that the UAF occurs after the RCU Tasks Trace GP expires:
> when the __free_rcu() callback runs, there is no synchronization
> protecting llist_del_all() against concurrent alloc_bulk() operating on
> waiting_for_gp_ttrace, leading to the race condition below:
>
> CPU0                                           CPU1
>                                                __free_rcu (RCU Tasks Trac=
e callback)
> alloc_bulk
>   llist_del_first(&c->waiting_for_gp_ttrace)
>     entry =3D smp_load_acquire(&head->first);
>     do {
>       if (entry =3D=3D NULL)
>         return NULL;
>                                                free_all(llist_del_all(&c-=
>waiting_for_gp_ttrace))

Thank you both for the fix!
Took me some time to page-in all this tricky logic.

Applied.
