Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795549848;
	b=eIt0IZt9V2l4eKhz0Hh6oBR5zg8AhAUis47Z1UzNtVK8K7JF9pSHiQDPDw8HabvuSETk
	 qPCdDDFjjNdIa8lvxy4vunuzxMljud1+F95JBgSAHEy7z90JdwS95VVSXWBB8EGoPKmXJ
	 FEG3cMRp8pz+jqPlrAE2EuKeakLblbBqVUyLe7wA7NeZNEne1aSBmkL4nL0dXlW3FqWqR
	 lOwSUK+7PV8Qneac3fsSM7wFMfAXEimbcTj2aR5KjZR53heu9HhcRcofLvr2Y24qusFs1
	 jHmnrub9sXavRmf3xgfZAmGno3P5QOiEGzNuMJj3AvjFOUU9TyQLX4ssc4J7x5ITIoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3ejMk2zRgFOOyw6ckBtMeAZcQUDvOcKxQ+UDAWVFhz8=;
	b=ZqEjd/zFLfYXCh0JB9uSligZi0YVzJIJcTu21IAcpcBEfIwV51k3FHFfnsyN8nDj4cse
	 iH8wJNcgfLaZ2Q9MxJMAGIRYOR2txsYX6Ubt99ZGqRZLPiaMrk1wyPiDOs/s0BGj8ahey
	 MIRo3j7l5k8cQ7H+hrK4TgQITVQgEgmOofy9BgbZhKLP6imcr4OP9LwR2Hg1FNX3+Fphm
	 8sx74TO0BOoamyW91S+Ryag+0ZeUqZ6WiKwwgb1RcDEG/EyzKf0GMEEhPjDy4O4aBTvuP
	 u9IJboO0fj9Qv3ZnNztgwxbdrC3OPmo2iN45oeitSHh81LDTgNMWx6v4h/YSGN0WYkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lRO65MPU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995E606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D995E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lRO65MPU
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so5870971d50.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 11:50:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795549847; cv=none;
        d=google.com; s=arc-20260327;
        b=KqUPSscBTW2PJnBAdys1HYmQckgVeY6lbheG/uWFC9PXofPUAMYxHaxKcxQ2VEnhhi
         qFHcxTdF4ugEYIhTHuovsqzNYhqEbuLXQExofcxTux7lmby7xp4hD/LniuR4JfDZxZD0
         E5SOrPuEmqParPrmgPnejmMubkWwF4kThMVxzzJv7nxaps2CInTJbtbdOkut8lBNdCp+
         4fP2pUKRa5bJyQWrJ/satyKucbJxQdpjSKJOGHLoYxIeQMrUOTAxc92L0SuudGyS9Q6X
         JgOfSAjaJaYwLMqoDVdzqPCAO5P9P+fchjDOXciBDHVzilG0bjdVfV4rrBE91pLFuUXL
         y3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ejMk2zRgFOOyw6ckBtMeAZcQUDvOcKxQ+UDAWVFhz8=;
        fh=aCnleFqWvgmMPvgbUVPmqTiIsmyY7p9gdOhqG8Gz49I=;
        b=ZQ6RDOUDJVTkHObwBPL9Hs2ZzX8E+NpPHEJFavqvzZZptT1J5agpnIy4aefo6WdbYP
         CCme6BSWb8pCfAUJ5BQ28XkE3iUz0yIilzFqGQu/w7Nb0IUmniUIKw7r4R4MRqETB1rb
         1ykSAd1CDc5d+NZiVZFz1JLg503dXPASeTfwSVSt1O3+ZxoH4hLoEfIhCGWCJhlmxv4U
         woRSL3YbjuZfJVVmLjGaEY2QkPneJZL6zNJILm7XPbCHePY1ZBH/e98fT0jY0I8a5S0s
         JR4wxLe3e++6Mwtm7ojtLZJe7fvt5PqG0jdJ8uPmyZrqxwPhCX63sdLqdu0cwWkJfAJ8
         5wzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795549847; x=1796154647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ejMk2zRgFOOyw6ckBtMeAZcQUDvOcKxQ+UDAWVFhz8=;
        b=lRO65MPU4INOkz0i6uJFQ820za1yWTA72Q3EvmIYfmBiX7lCOQXyhVyR6CGz3Fu/Bt
         xEVT7pQwkh+zx8wLAHFFHk58asDtPjUcezCrpNatNOML2tb563QxdyfeFteIoRlN0zFw
         /op8wR9qAP4wc9fdqw+GJdpeBc01El83WPmR+kbk17QHf/ao0xApWBdLiXbNG2GriHD1
         zbS9uSryofjZKUflb6pzt7fYpN9ObmtRMebvFFdEEvCRH0iUSz9SDK08gm3hPnQWTjZF
         MNU8AiS4bqad0TntYuFBXYnt0pIT1olgXpjl0SXRNf4qzEr3o2v2u0pwz6U3wrZ+hrD+
         xmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549847; x=1796154647;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ejMk2zRgFOOyw6ckBtMeAZcQUDvOcKxQ+UDAWVFhz8=;
        b=iXmnN2TXGLfPoMw+V2v1iWXHTuA+FOFah9w6hUZKE3vGd65b890DOruXsggWSoWwWV
         60XdACwUTSfJ8Ko0Gutu1bgwnJJEv12KDpaXBrdTGUVTRkg3oyY/mgfw073Y4WNxAhfg
         1yrwK7YJZy+tr/zY0rk5u/ohOfyb2yEx3uvEeq0CvKoVsON5eCPFmJoDrOG+yMQ68Hst
         n//dCPq4CHYEHGXOu5vK1Y/7csFG7hBvaCM9Nko0+hRM6LjrPxj+gpoe1P1taiXMVVAJ
         mg15+ChNqgCQAN8+mC1VevqCgawq3KfseyFx+5w3zkfUYXO98e3AcHa/5qreUTwbbsQz
         Bncw==
X-Forwarded-Encrypted: i=1; AL+hErEbjSRd9dscZN3WCN3P4FYUYQckVzjOLaaTRKYWRO+kPTpR5sxfVA3FVPEmRjas1mo8Uf8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MdQOGKRJQdU26u1NUNlxd2VRRijknz0Y58skdvxKh85hqi9i2
	piVBO0zwevrZMrZKqi+5vLi6EEqTBAldwsuRn3aqDhQLNnTaGvQxd+S+bgyOebLoMSj6NyhG5QG
	A4fvSbuteT7VGCG8ckYrWt31NFw/lPEKafSuX
X-Gm-Gg: AZFdTZdAg3XtK6QPWriDEFrStpY7yUJl6HJ1Vb+j8P+qfqmZF12z+H9NhzVJoTexcnF
	wvc+pTKMTkOV83Es38GmMQDfqY55Gr5NSXoxAj19lXeBmbIfLXsy4EuVL20zSpyiZJ/a3W/+XKA
	Yez1mYaCliGZRzrwGg18VTDiQzNCWMpzcsmiCYuwt7KUGnAOLWYkRz6oXxEqOrr3vGM/f3H/1Bl
	pOj9VD4uDacoGUsGY+/JNWH/DAmukPq1GvzeazhyKX8t5SA/CdbunAj5fROPtWEX9XCINHBrx/O
	xYG+zeWug6bJkCX57CroRZe9esrXszlViEK9Vnw8mkqKh8aP3u58tQO7qMAx+G4iS4KMhzbYh/2
	KvgDov9V1gyR5N7LJKijEhPPEezMI7ReUgFaj0G5LOzkfy1mxjAVEcKhO4VtM648VfvE=
X-Received: by 2002:a05:690e:14c7:b0:679:a2c3:b2dc with SMTP id
 956f58d0204a3-67df44d7f6amr5086626d50.92.1795549846818; Tue, 24 Nov 2026
 11:50:46 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev>
 <DN30L7T6638S.3GDFKZBDTI1CN@gmail.com> <CAGn_itxav5uLkQXCzgkqzgff+ZsFZrhO6rofZJJSqk7K7JPGWw@mail.gmail.com>
 <DN3P7509U44I.MLLYA1W3M3X9@gmail.com>
In-Reply-To: <DN3P7509U44I.MLLYA1W3M3X9@gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Tue, 24 Nov 2026 20:50:35 +0100
X-Gm-Features: Aa3M54pfCWBL5H4KNWzbrUPjg5AkdTbHjniQsUOCG90ncmIlIV7OyPHRCbEG_kc
Message-ID: <CAGn_itzgy4o_hbCP-4QU65CVtdfn54PH2hi24jmNN91TX2=Chg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, lsm: Make bpf_lsm_get_retval_range() return void
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 8:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 24, 2026 at 06:15 AM Anton Protopopov <a.s.protopopov@gmail.c=
om> wrote:
> > I think that this makes sense to not list helpers, kfuncs, and
> > verifier (and jits), they're building blocks for BPF programs
> > themselves. I've checked that most of external functions called by
> > verifier (~20 files) are not in the tagged list, five are, but look
> > legitimate or "harmless" (security_bpf_prog_load,
> > get_callchain_buffers, copy_from_kernel_nofault,
> > bpf_set_dentry_xattr_locked, bpf_remove_dentry_xattr_locked).
>
> For the verifier, yes. But copy_from_kernel_nofault() breaks ftrace.
> A prog on it returns -EFAULT, and fentry on foo() detaches on x86:
>
>   unregister_fentry()
>     update_ftrace_direct_del()    returns 0
>       ftrace_replace_code()       ftrace_bug(), no text poke
>         ftrace_verify_code()      -EFAULT
>     bpf_tramp_image_put()         foo() still calls the freed image
>
> Let's deny it by name.
> The two *_locked() are kfuncs without bpf_kfunc tag.
> See specialize_kfunc().
>
> The verifier also calls kfunc filters via a pointer. In visit_insn():
>
>         if (ret =3D=3D 0 && bpf_is_throw_kfunc(insn))
>                 sub->might_throw =3D true;
>
> A prog on tracing_iter_filter() makes ret -EACCES for this one call.
> Then check_func_call() skips the exception path of a global subprog.
> That undoes commit 3d562d35a044.
> This filter is in net/core/filter.c and has no "bpf_" prefix.
> So funcs that take 'bpf_*' types have to go too.
>
> > Blacklisting these removes about 200 hooks. (Blacklisting all
> > kernel/bpf/* removes around 600 hooks. I wonder, maybe this make sense
> > to do this, after all?)
>
> Yes. All of kernel/bpf/*. btf_*() cannot stay either.
> By the rules in fmodret.c these get tags too:
>
>   target                  error    after the skip
>   ----------------------  -------  --------------------------------------=
-
>   btf_kfunc_check_flag()  -ENOENT  fentry/bpf_wq_set_callback saves 3 arg=
s
>                                    of 4. aux is garbage. That undoes
>                                    commit 3917b1012ee2
>   bpf_mprog_detach()      -ENOENT  tcx_link_release() only warns.
>                                    tcx_run() runs the freed prog
>
> security_bpf*() and the bpf syscall entry need no tag. They stay.
> So a prog can still block a bad bpf command.
>
> Could you send a patch for the above?

Yes, will do tomorrow.

>
> > (Just in case, I am preparing patch for "fmodret -> functions
> > returning pointers", so numbers can be a bit different later.)
>
> Nice. Looking forward.

Will send out tomorrow as well.
