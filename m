Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794003546;
	b=TmfcMNhK0o6SBVfnQbsSfWS1StCXvUV0DtyitOGVK16J0aTr0s/6U7y3YohaB5vBfHh0
	 UkH9eoMARrwPsdX65uYu7cWKt3byat5fGbBRg04bsw7A8ZlVX3/UC4l8sS40w58JDZfHM
	 ObTvKUWCP7tgNnLanGt9RodPlic0WKhKuth4fLylTzA443wIhr27tJANkgANI17unLAOv
	 lvTdQR3U2Rz4inGXKOWDsgEMfnMpZs0ppE6+IEj30tXiorqoRZh8jEFpLTabDvLHHxWfS
	 IUtsrDrKJEJr8mC5du3DQaqrXLScuxMjTkhZssD5RsmYhiUB6G3XyZ6eH/QBir+RuIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NNajVt+0M0PzjiwueKiARTrUiAHd31zL0sfh+MHCcug=;
	b=ZDmdSUmqwmrxeV/pG7BzRZL/4O0tzirZtLHDdZzkIRAzTv/SlzjJaxTD/69/+ahOG95J
	 1PPNarTwRKKvOwuNP2qd9vkbMnBnkD9h/39fxEvrJBfpRV49X2u9GTY8D1ZL6gVUHIq1c
	 /6fbvBWIGnz6veuwmeMvSrrGffzHfrCHLrASyu7TiZsc7YXaFLgmE2qV+uagbyhYMURdi
	 WWdSNTbwG7sNK/sU5Buh+hQvF4KEsUf4rCOozSKMye9q40NOaR85nPDRowB0FaK1NN2wf
	 tad8L+IPIGg8/3aDHXRYzxRNjIAgfE6Bcv1V9Qan6mM3a27SxbRT+xKRO039LyjDY7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=q+zAZUHw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEF606A331
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 22:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDDEF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=q+zAZUHw
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6774639a8a4so1070692d50.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 14:19:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794003545; cv=none;
        d=google.com; s=arc-20260327;
        b=TR4lV2cju6ZdivUC1UfagwAyPzkuO/bsF5anjPG8nzMs/0O0TK6joeadbKbp8WunIn
         BOfLMMn4T1Pcd4AZ6rFpDSDlAad1zbixI1IOjytqDGRIpw0ioQtwpbZNJwrZ/XusXRMM
         LMz+S7/7qmYfkOlU1FwWdBV28A3lwYkaNqeU/EqfEMUBhDybA5/d+FBz0t1erfLJ1JRO
         hwx0vtE2/iPn/g7GHmJM5wHyxyt336sRDUGNtKK+2BK4ZYwcWKDD8PjBYbXnMO7NvaKm
         Y8UAH0yVcSsfyb9v0H+MQbHdHTZfZLjDxmxOOco6MN3BKbgC5vhKiboILfVqqpBg7Akk
         JHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NNajVt+0M0PzjiwueKiARTrUiAHd31zL0sfh+MHCcug=;
        fh=rBgo+NZkEDlI/mj5sFFe2AhXFLUrO82xK7AtsziifKY=;
        b=O/d6dd6GqCtQ204matDVsTuLEzyOZfZdei+5wpxzWa2U6gmFpXFDn8v+LQxkApNCbl
         UKD82CpeBcqQWHaE+RgP3FcE7lPmwnYV6hMeG3ImJcOcWr1MSldTklHPL6VzdXqDXkL4
         EZwdvytsPImqEeEglUojuQdbD9AiLWh7VXT8kKQ1qXAVtfx7hgPCLoF5++u9oktYkifs
         i6YRir+vdpfb7szIB/qiYUg7C3w06SC1lu9grLlsBBExAFTYBAjBEmV4IVzFps2ywES0
         KkLxCU1P9NBEFxARFw1BZxGGSbsNNmhdyFPaSsw2G4kJozijKq+ol/1ULOpNLUEuYPtA
         P4dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794003545; x=1794608345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NNajVt+0M0PzjiwueKiARTrUiAHd31zL0sfh+MHCcug=;
        b=q+zAZUHwqrdjdzzP2qNR+3qD7gfpn/01ThEMJOr0HcNhH2VkYTAxHLkXYMYHY7727C
         nP6pbGfH2oWou9dNntm5s7XxGdRujN2Mfb6y7mZM9w/RjsceyEFllnGh8ezqdN/1c6zq
         HsEMnJ9x7kVdMifTfVBz1VN0G6ay4jsNtxNrExUTev4/Ds9z4fXq5xfPqkKJcflcbJDy
         HiEKDdmU4OWinHisTJlkaLip+mS9hyCySSWCCe72n1m+eQKSpzxIWUnoZgN9ThPK106f
         Hx+D5y6eSINkBHjBjtcAu/1MPI6iSWEd+nsh+W4qn1TRS9HqvVbuBqwFa/i5MbcE8Sk5
         M/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794003545; x=1794608345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNajVt+0M0PzjiwueKiARTrUiAHd31zL0sfh+MHCcug=;
        b=Zt3LW0yGJu1BR4Cnk6/ZKoTx/jIiMrUjiFZW4gMZvTV+AtK2Jsql1aShu+VbdFrJqz
         YdvpS5+F5ub6nDg7DwvEljLwyN+w9QHbmfGKvcZ2Jfdn7F9OAlFKMAmpqJiflx1Qw7R7
         ATcDQiWHgDFCVA4gZKmoJp9IrqsSPWzNNNwN4eJkfghkZ9FK7tJNRx3yCYJecxe3GqMv
         GPVYJRQwr0+KGpNpozleT95JWDr94Q9bwKckVTO2VuyOB6l4s5Fsmy4sVLuaE6Y7gPza
         XRE9btEnj4r0WLm5EAhwp5xuQilcbpUyXiEjlU0tuiXGgDgRWM25tmdbpofCTWdZSpVB
         /eEQ==
X-Gm-Message-State: APuU4Z/0wblH9vNw3MyIBDg4hywblx8ZLeB1C6HJIDIuvq1j72vgP3S3
	Nid0lO9O26qyzJNkD+PNVNQLa4ldBgEcjuMY70bZu1OfdEQgmReWdIN9mtBmQn41dXB0L0V9Pk+
	I2xRqhIeXCFZmNNutXXsuJ/ib1c8sTW3ngRkTEyC7oA==
X-Gm-Gg: AYBFou0mJ9JMbII3kdl7KxyIN0dkcvSACY5I4/nycBrvGslIkjzlwqkwGnvDfiscqd5
	wWHBJ/PPjASmKPQ6+W9Sdm6PQVmE8RpHcljmRbuPj1mGmmpt7iCuwaPQGZMbCn4j1tW3W6AxQ/4
	ay5DcEMdYbpxDMjkOAujzrV39735ZdGdWsH4uc17WkdUATyPC2wRIV0FIkZcakAEelXT4KhMSnJ
	sVWKxnRcXqfg3ryoBiQMeNDiMrf1fbCLrIt3ejIGhuHjmCDjfrGYUP7aKYjLeY4YnvPxb1+Yyr9
	xPMs7UbGjDi/gbYNGl0dkDOyWmTGFx38KWxm98ecrp8M1+mZ8JmQjzhgL8u4dBtGkH3gQZ7YSkB
	mzb/0vfy4weqEtcOvt4hpep9SHYTRvohK8itNBW/oS85tFgksQljO0UV7Lddo8+FOSLn/EIBu1b
	sDv03OYKQya5S0
X-Received: by 2002:a05:690c:e3ce:b0:89a:63da:fa8b with SMTP id
 00721157ae682-8b3419af93cmr18261487b3.70.1794003544651; Fri, 06 Nov 2026
 14:19:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105184411.29248-1-emil@etsalapatis.com> <9b551f0d5966ca8c834e49751d89d574b949086aff27c8031f8e30c558659b10@mail.kernel.org>
In-Reply-To: <9b551f0d5966ca8c834e49751d89d574b949086aff27c8031f8e30c558659b10@mail.kernel.org>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 6 Nov 2026 22:18:51 +0000
X-Gm-Features: AclHuK_8CwsNKDHv1nik7iZ1fpSn4qelK0TDPqZP_rQL59BE4HDCZZtooxXxzYQ
Message-ID: <CABFh=a4UX7O8SPnfuQk7PjBzDxo1joGdtVBQxNPz02ZbLctRsQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Use dedicated workqueue for freeing BPF programs
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 7:32=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Use dedicated workqueue for freeing BPF programs
>
> TL;DR: Design question: the new bpf_prog_free workqueue uses max_active=
=3D1, so
> slow frees (rtnl_lock, cgroup_lock) may block all other BPF frees, delayi=
ng
> memory release. Would the default or WQ_PERCPU fit better?
>
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
>
> [ ... ]
>
> > @@ -3143,6 +3144,17 @@ static void bpf_free_used_btfs(struct bpf_prog_a=
ux *aux)
> >       kfree(aux->used_btfs);
> >  }
> >
> > +struct workqueue_struct *bpf_prog_free_wq __ro_after_init;
> > +
> > +static int __init bpf_prog_free_wq_init(void)
> > +{
> > +     bpf_prog_free_wq =3D alloc_workqueue("bpf_prog_free", WQ_UNBOUND,=
 1);
>
> Is max_active=3D1 intended here?  With WQ_UNBOUND, max_active is split ac=
ross
> NUMA nodes, with a per-node minimum of 1, so a single-node machine runs
> exactly one queued item at a time.
>
> Before this patch these items ran on system_percpu_wq with up to
> WQ_DFL_ACTIVE (1024) active items per CPU.  Several of the work functions
> sleep on locks unrelated to pack_mutex:
>
> bpf_prog_free_deferred()
>   bpf_prog_dev_bound_destroy()
>     rtnl_lock()
>
> bpf_prog_free_deferred()
>   bpf_cgroup_atype_put()
>     cgroup_lock()
>
> __bpf_tramp_image_put_deferred()
>   trampoline_lock(tr)
>
> bpf_prog_pack_free()
>   __purge_vmap_area_lazy()
>     flush_work()
>
> While one of these sleeps, every other queued free waits behind it,
> including the cBPF frees done on process exit with a seccomp filter
> (seccomp_filter_free() -> bpf_prog_destroy() -> bpf_prog_free()) and
> socket/tun/cls_bpf filter frees.  The memory, map/BTF/module references
> and JIT charge are only released once the queue drains.
>
> The vmalloc purge helpers are queued with schedule_work_on() on
> system_percpu_wq, not on bpf_prog_free_wq, so a default max_active of 0
> would also avoid the deadlock.  The cgroup_bpf_destroy_wq in
> kernel/bpf/cgroup.c uses alloc_workqueue(..., WQ_PERCPU, 1), which keeps
> one active item per CPU rather than one per node.
>
> The commit message doesn't say why system-wide serialization was chosen.
> Would 0 (the default) or WQ_PERCPU be a better fit here?
>

I think WQ_PERCPU is a valid tradeoff between 0 and WQ_UNBOUND/1. We don't
want unnecessary contention, but we also don't want spurious implicit conte=
ntion
between unrelated tasks (e.g., some work item waiting on the RTNL lock
is blocking
unrelated free operations). The fact that the items get queued to the
CPU queueing
the item is also fine and an improvement over sending it to a per-NUMA queu=
e.

@Alexei wdyt?

> >       if (!bpf_prog_free_wq)
> >               panic("Failed to allocate BPF program free workqueue\n");
> >       return 0;
> >  }
> >  early_initcall(bpf_prog_free_wq_init);
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
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/420896=
27629
