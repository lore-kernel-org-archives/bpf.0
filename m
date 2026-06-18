Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985F33F5A3
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823065; cv=pass; b=l7VBVE0jXFgJFSQPPTOoKk8fsE1gx5aNCbZYB3wVIr+wOY71TEfy1YlIgVuEr4byRQEz9fav/tls0DwfU68y1C9NJN3pnDa23/HqO041+Afrf7Q53AHyRS9SZUu2ggjbsXuvm5IKCrL+ZaHB9Vu/S2Bn5Gfikijqle7klWoz0+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823065; c=relaxed/simple;
	bh=EMYr1F+PpGtSmTpfHsTm52f8sshX1D1zHOemelGKRHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUXJJgsPih11ph87fySmrAUT1E8V6ySWjpLLSQKdh7MjP+U/kkb9z5BPu3jSKK2176BNY7ZgGls9AkmIEH51QbYpg0zvhM+xFolH9rNwYrEfnpduRlYa2/KDOr3/0/f4qjCp0rsiJOI+B8n1+D7tF+xnjzcTfFdWqq9b1SWR7S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ2E6C7p; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ2E6C7p"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9159da9bba5so118358885a.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 15:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781823063; cv=none;
        d=google.com; s=arc-20240605;
        b=ekqv31n6xYsPKgMnjGHGdygfypACBI8n5p/nkiwk+ibllOe0BitGIusAd/uDko7bKO
         CXocKhSU8ndpwrFh1Wr+o5UChqRSKtxJu3oHemu1I/Z7Bu4Z4YbW2yGeP7/yDGJOprva
         NPoRQdhmY6jMFJAbvOnPxzE8/1Wcbt3fj6MWV7fMsHiMe0m67nDO1iiP0quhFxePdCey
         riifii999SMz2KhbaW1z5k3FJLrtQ3HKwma5gkuXaxMl1vrhKucRQ5YlEpE0NSXBcxnV
         agVbJ6MTH8Ffxb7UAQM5/08fqy6Q2wE2HWI4j+AV1kxl09J7hJ6mFa4XZqXCkTT7JsBR
         UsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        fh=NnZ/0uFghiIgx7CIpUaFM/Cs6XnImRQsc5ocEn+XYx8=;
        b=B0b05NtMQd2WS3OrbkunQZTXVQHLeNNPwS4wKo541i2vDQSU5ImU518TSvArVklcGJ
         RtsXK0WWcQIuIhvJYgp768wh095amCMJNnlkrOkUJ9suMlKM+9eL4ie3YdD+dlAzblL1
         +xYIl579w0Fo3wEm0KN8AdlqukIwmvi8kDkRprY09xGzhljBFX/L49Hj3XB64nwdlKMH
         5rBIIws3kUQZl7vLogYlkosCsI5DoBcDRZ3YWGFoWP6MLxZh2aBAVmPmcBRu92Uk9T75
         haAy9gxbh+izLqayt3f5KXre0axpOIn2vcfU8I/ri5UNfveBAEL7DENwLzwxWiUFosNw
         2HYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781823063; x=1782427863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        b=CZ2E6C7prhTojmgoHGdNe7OileXPbl3IdhXRahO17zU0p7sydgNazhp1YHE4kV/6eg
         /iLvrxYKEmWLRXuKoolRzvba4DUUKfRHLyiBgYpuqOcdWtg82BbySEy4qLx6HhHXP7dS
         PthIZYz4hSquO4gFZ3URQSYFja1vdkH+gSP3b9b2UHQAe+pCO5lsOGswbMvzZJQaVr3J
         LMfxXi93vOcsvLFfsN8zLILywVKhEiv9aH7ub2Wr26pPk6HXp1A+vN3Q1qU+OaSnl3td
         B+79jtylayY9plF1MJRE+jSxSw56SZl4UEYadYOtdVYwiErhIjX8wLS2AjK/RQ+xbQeP
         KzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781823063; x=1782427863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        b=gjL4XAjqOQ7FBryiHon+w2rApcQs9czwCvwsLYKohm54oReaAOqZf2HtxzwkUkIvoB
         y89i9gCX/l1TkRfRmBsRZkF6XJIyNeY26FLJu1MYn/mTJCYr/S9d/c9DcslFU9RFThcC
         U05iDzcqho4JGBDvZJotEdjTD1XGsAu7AhQX68chzULZPjXr7yeURSzF3iMt3UwXJw5U
         VJkxYuDPVNCVIxEAURIrthjkzSdpkQJfLzzhBe5JxW8Koq0Jt0vTj8IfID3oN6YzYEYa
         fHJI1QhzbvKVq4pu1yJgyP4dK8fTTSMqwGoMiBuqfCytFm7cToYXGhZmO5LdiNvjNhiI
         okYA==
X-Forwarded-Encrypted: i=1; AFNElJ/oMmXtyEKD65mExV7evfuzcMsyawE0Atdj36CgmN2RGKy0Tq7KhLtNoU4iUjLbT5DPUhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkyF0pCONk+iw7tYuCBZbOd1MKvmqgOu8yce20XifdqJMHjXQV
	G+taxGboBU/+44tzkIfXoO63scwVPYN60VivGOOI0j/cobsfcY1ZDGryrButOazMWK2meNK3r74
	F7cuRAnVEpb/n3e4WuklNK+ObtTfqtDE=
X-Gm-Gg: AfdE7cnqNpl+8kMMci55PfP0+xUB1n+vDnq9BX/tqCdnvcFn553mXNnhMKtGPxCRgBC
	x0DIOu2CeoBGhRj8LN3SAWn/nszIKTiRGF4sZAPESXv1mEt7I9+6neM5GzVO2eAo2xloAhwLPUw
	zrZFVjbNlFfRbUgoTj3utrxv2I7/+YvtnDDQ6UmaGQPfO3DTELucXqaxGxVDppUiPsyAi7PNzsJ
	56UAQdd0cqJjjpeIKJ8IoCBpeZOHu7gAwUKHYyetAI+tZPH1XDMDN4dDYhl2RR3qIEyF1aV4ha7
	miNmifb2MvCmaZm7vCXu8+nwkUs=
X-Received: by 2002:a05:620a:19a7:b0:915:6504:2a11 with SMTP id
 af79cd13be357-9208d2f42f5mr171322285a.44.1781823063019; Thu, 18 Jun 2026
 15:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <e9ec622a8a49be299cbbfd459e2fc10693bcd65c6dbf00c9e2645281564e5579@mail.kernel.org>
In-Reply-To: <e9ec622a8a49be299cbbfd459e2fc10693bcd65c6dbf00c9e2645281564e5579@mail.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 18 Jun 2026 18:50:50 -0400
X-Gm-Features: AVVi8Ceqq7GMU3vGf90S537LLM-Tkad05xeAgBh-3i_pTCiFmecE5-lsBfct2HY
Message-ID: <CAEXv5_hDJyZ=nY6JaSL=17Mtw+e_m1doj=KReWSNmgo6ULFKpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: bot+bpf-ci@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:22=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> [ ... ]
> >
> > +struct xattr_ctx {
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +};
> > +
>
> Paul Moore suggested in v2 renaming this to 'struct lsm_xattrs' to avoid
> overloading the term 'ctx' in the LSM space. The struct was renamed from
> 'lsm_xattr_ctx' to 'xattr_ctx' in v3, but 'ctx' is still in the name. Was
> there a reason to keep 'ctx' in the name, or would renaming to 'lsm_xattr=
s'
> as Paul suggested be preferable?
>

Indeed he did; I mistakenly inverted his original request.

Will send a fix for this, as well as converting GFP_KERNEL to GFP_NOFS
in the allocation in __bpf_init_inode_xattr.


> >  /* Default (no) options for the capable function */
> >  #define CAP_OPT_NONE 0x0
> >  /* If capable should audit the security request */
>
> [ ... ]
>
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 564071a92d7d..86a8e188b900 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -113,6 +113,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog=
 *prog,
> >  }
> >  #endif
> >
> > +BTF_ID_LIST_SINGLE(bpf_lsm_inode_init_security_btf_ids, func,
> > +                bpf_lsm_inode_init_security)
> > +
> >  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >                       const struct bpf_prog *prog)
> >  {
> > @@ -137,6 +140,12 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *v=
log,
> >               return -EINVAL;
> >       }
> >
> > +     /* bpf reserves a fixed number of xattr slots for itself.
> > +      * Set the attach limit so the trampoline rejects excess attaches=
.
> > +      */
>
> This isn't a bug, but a subsystem pattern flags this as potentially
> concerning: the BPF subsystem comment-style rule for files under kernel/b=
pf/
> requires multi-line comments to have the opening /* on its own line, with
> comment text starting on the next line. The preferred form would be:
>
>         /*
>          * bpf reserves a fixed number of xattr slots for itself.
>          * Set the attach limit so the trampoline rejects excess attaches=
.
>          */
>
> > +     if (btf_id =3D=3D bpf_lsm_inode_init_security_btf_ids[0])
> > +             prog->aux->attach_limit =3D BPF_LSM_INODE_INIT_XATTRS;
> > +
> >       return 0;
> >  }
> >
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/277886=
16397
