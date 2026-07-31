Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3833C18E
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512005; cv=pass; b=Z480S1BRXznM1dei1L2B8AwdWTf4qFOrLBAptcZfUoiUJJ7HHNtjWXBgQ25T5OrIJoGfuDEzyxMbQ+ht7+G5mV5qfDwVUt1cPUQjCpo9yt1iCLlV0yLF18xFHH0OWgOb2/greRnd93f6bmOkj016dz1GhWhRxsKHT2qWjGy0TGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512005; c=relaxed/simple;
	bh=VuFNcnIpHKuBE9TqXe/JfxuxV9DEEfYcH5BhOui7Tz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEE+THOcHyMiqSiYNaX6WdEdeju5C+Ru6L3sQtFJ+ouhCUolgkeUxvJ02G3j6g3Ir3XBZUtLSbbtM8dVGcAqOjL3Fp6HfNnSkbTjEB30iKdFm0i3oCrnSeltVjSvowb6sVPMIZJBiJutOXKn4TlMcuz9bO+0bcTbi7WGpNaVnQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WlLS7APe; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WlLS7APe"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so866643a91.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 08:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512001; cv=none;
        d=google.com; s=arc-20260327;
        b=BuxkCHdFhDs/RHNGOr9Mp3E6gK6IEOhSKSfsDcbyZJfN+XRiRZYieu+PS/7p8nxObB
         xCfFATTt7+231qL30JF3xB+bqqX5D9vidb8SAj4oWMkhMBVWeUjtk4/eKnQIsOODsqlX
         5hKI+Z4EqThszKFTLswOCzCzkLg0TjMpf3j6ZvGr+elrpcnPDvpNMUoYh6/XgtAxcIbq
         fIi6HgJRu7cOt3C6wWXHTMJvRXvQgB2+zRxbD0QzGgyHre1llk0b17DxnzpXbRinGPSY
         hcmnth5PKOSEcGjtGlB9FmkwaQXk5ceaGMem9giqJuhKVLfvQDZwhxQO8o7e/5GRCT3N
         ot3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        fh=E78bBgVWFMFXQT+nF+e4MGPOyinImo2iNnMCcJwI7LQ=;
        b=pNomiVNpyDvFMNQAgDSiaXr1GeYpEuk2idkr3Jpi6Xe8LudcGxvwdUtr2ThszqHgv+
         W+SFZIKzDIuduqkbI0npyflEn2U9NIP0Dqamhy5syfjQSJPlGNofgNqbuZIANZR6FH0A
         sevmmFIFJrifzNpUxLJ6XCmkzPNnkp6cFjZK7gldYeJbL+2dGqiwufjOnDHNKk8YP9JU
         MORn95HyD9eIl1O92woJrt+qJYCpA3NONRBIX7/rLE+KRjkTpuqwQ3x+HhXgr9SHvx3E
         T99OSPkuWKG6CRkvHeGGf/BerUc4CgMEtxBQ8pztb8KzLSxJx55Pwd0Jre/IRKUI3zA2
         Qp6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785512001; x=1786116801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=WlLS7APeX/hA7NEpMaOEESuBOy9fewR9hgrNZhDweuEfsAh/zoyTHKGTJF9U9J5tq/
         s847tazcBtQqqpEIPCZXBYyQ3TC7humVlzydKPbO8qx9opWFdjz7TCnoMEGa4QIO2Wi+
         Ahj5xFgBiGOukwhXTPUjJYDHwXCGm1hXlbLknTbkVQvxbQqL2OkPbu3WWjJxOCfQoua4
         v0rgXyVwMwKBUiPTrtFyuoJ3JH1JQYPFRfSarLn5gtHHWLOZnhRsC/r1ro+0psVHAY3z
         /saiuR+VjYl9I0MSElkym7L/BAmicvjWjbB3CcOZUS1cwve44tpIhC2lftzsyegxt5Ww
         Z7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512001; x=1786116801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=SzccGdXCuoN8Ifb/qt6kUMWib0baCe9l3hpiyxb/4qs1TQGqzIwgTOt7Asc6Vb4YSi
         G4horhWGFs8vH5PvxUx1qVVLDYnRv/c/8gEpODIEIAtOKO9inVh9avH++tk6J6x7Hpm3
         cSqQFBCyOw+Nz6sLFmvdX4Q/BMJ+cbnLDbHjh6WO6DvH59oRHLueFvJoGtn7F6RJGuYD
         ata8suYZ4VhZpEEPPbM+ppbTCkqIkafpMt64vzr8EiBS1MgApHRSM8O0UdaD38Juu4L9
         EeQBkMizMFPqVRkvu3vwAaWEhtwjepUFfD2whhEuuJS/xbzNHfFT0G9B8tEKQ4GESjSm
         Siqg==
X-Forwarded-Encrypted: i=1; AHgh+Rq84jU+Wf997XUimBCAPARZoQH6MHGed9od2FCNx8h1DvWDU8zoz0N3uGw6NhG0ygKPSbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGJLEs3jljJt5gwYBDf7fGfaR7MtAVg5bim3aXlahrFvWx9t7O
	1cRPxvM2HdmVo5GhrdPeCcb5asz5YQG4CN64Npc7oP3DLyYR2d84hnNAXWmyiaMtmNNLpC9t5AK
	22C5GVvOUOeoGjZQX7Yis4YuRNjFH1ZXgw0FuOJd/
X-Gm-Gg: AR+sD11edwLv9jtanw6zJMH7uBgwjm9KNnsfDq3Rl/FNjwm7AQKa9K17DUS+g8UWAAo
	1LHGkK733BvjTYtCmDo9CYfqguIqSzIvhDT9nS4Sg7cXKCTrCZeviuPx3hwSyq5UDVDzA3pRYLV
	walq8qtDtlCjdZKpvoCRUNRpWmq4oSfFexTk+SlNg5nI3lP6kqGpDIikxKjmYdPh3nIo0exAlwG
	RRuiI7/Ml6Q/4Y25yBR8qnvtutumf9+bPXu5aXBH9BFrex4em12Solpr3dUYXoJAicAYfpSU7v4
	TheJImqESUeUd0zJ+w+NNUdtwgOe27CBqh3Etu7J9OK+
X-Received: by 2002:a17:90a:dfd0:b0:387:e0db:bc24 with SMTP id
 98e67ed59e1d1-38fbc5225dbmr287131a91.36.1785512001460; Fri, 31 Jul 2026
 08:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com> <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
In-Reply-To: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 11:33:09 -0400
X-Gm-Features: AUfX_myWZz1m6PowWXy7WcdAAbaku2QnixOSUt9yTgIUfLpwiNvXahY7xKnDbwo
Message-ID: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:30=E2=80=AFAM David Windsor <dwindsor@gmail.com>=
 wrote:
> On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> >
> > Okay, it looks like there was some confusion/misunderstanding.
> >
> > My understanding of Kumar's comments was that he was referring to the
> > exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> > not necessarily the new kfunc you are proposing in this patchset.
> > Kumar is welcome to correct either one or both of us, if we read that
> > wrong :)
> >
>
> Yes, after another reading, that does appear to be the case =3D).
>
> We'll need v7 anyway to fix the ocfs-related UAF the bot found.
>
> > However, regardless of Kumar's intent, speaking as the LSM maintainer,
> > my stance on this is that the kfunc you are proposing must live in
> > security/bpf_lsm_kfuncs.c to be acceptable.
> >
>
> Ack, will do this in v7.
>
> The Landlock series currently up for discussion [1] is proposing
> placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
> go there?

Nope.  That patchset has its own issues, one of which is the location
of the kfuncs outside of security/; I simply haven't had the time to
review that in full and reply.

--=20
paul-moore.com
