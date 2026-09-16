Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC4E3DA5B4
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583449; cv=pass; b=Owo2mDE12Lc18ydf4VZ6sie3c3nvzIioQehk0vxUknwxGJ+/5ybemPyhPAvDa1FUOE/AMQWwly7RXq+/ARLsFXPnp4pyJvcRn9CjzbjuLaetYbCG+2NcccW256VD9CzCdYMGuwFMUIoHMKGnhnc9ertwf6adcbmiWsDNL27qDxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583449; c=relaxed/simple;
	bh=9cB8xedQQvj0IrSKjUMXK0LwEeN65e2heD7WX5ql/Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+rD8OomcjWYEXivqkoDN7jr+9tFXg3646SPtVZlUEswvEApoL5Ob5umrnGmoSRkdPYbYPv1LTMdaEzYChPP99VZxv388qJn2Vot/S0aWOhE5CLX2dWKtip8VZ5kQSOQ9wLsVHyZK0R3iAsTuu5pa9BxomeNJmMdNhXq62mqIps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=li5GkeEp; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li5GkeEp"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c3b639adbcso15210b6e.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789583418; cv=none;
        d=google.com; s=arc-20260327;
        b=I13YmNY6CIEDlPM28o7u2b+uZja8QMDXeDzfs2zG7FuPcEcNW0Wd2Cnu/8hAVkpKxy
         fdMcwNZkpU3qdgBLnf8MI48QPGSSTJn3X+DDVEBioJIczh4x92sGs8zdDsFxqKE33dk3
         roBQNtaXJViMUZXaxekW4qpZ04L5qQoU/0B5nlI/TyOodpk0ws5B6fS84Yl9L9eIOmw9
         mLpU/fzjsZPgwgohLbF1ej/QsYUddD4r74HwH4GkJkfAPVd6+riGat63HMaIBlnbqyjl
         co5m4TO98IRoBJrR6Nsbee4yjqv2xF2LTatPk8Of4YMmrZscm6f2GfvrZbWofyh/JoGx
         lPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9cB8xedQQvj0IrSKjUMXK0LwEeN65e2heD7WX5ql/Fk=;
        fh=uSuBk8BV45CRr5ihqW4zkkKim/r3/aTSjUF/E/rfehg=;
        b=BVWeEDw8kS1oUQRwo/IjhkeXm+7QlrF9zJKSu4wWKIwrOHVunICLrL0z3jlomfCt/g
         HUIDnKh5cQhuvCSQq4jFbxCEQXMACoHxEwyBATmOYmALC8XtmLKTcbZL8eioCqYMWvkr
         vX644j5frASRAoBp3WKfV8UX5mxL/Y80DrKxClqxQBWSFdV4MmRe/KWmcs6h+bOzg4lw
         1VyZHNwP5KrMexMUB52NsbfPZG54ZD2KPio8SLTyMa8LqzShl27Sxm+TCdnRST4b5WJg
         sHSVKOwDj+G1SByy0gB2jEJosqadHUryl97G+JP7Oaji2RjPY8LgFHOGfWQey2pMUBbn
         QyrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789583418; x=1790188218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cB8xedQQvj0IrSKjUMXK0LwEeN65e2heD7WX5ql/Fk=;
        b=li5GkeEpy0Qk4UTd3q2XUIy41WKHj2oYZ5WaNe++/18GZwPo82yHFKH5nfvnyWx8PP
         MD4/OccLaAfYGkEakYW6IUXIOwPtkjJDHw8A3zGDP4Nctwhx4c1GiX1mPXjhXWnKhb4B
         8c85LehzXTMrr/tGqtNqUWP9wLI4tn9iSjHXlcxh/fE+U9APshkDxdoHZH7mlWQgCofo
         J5WTA3TBRDnLb6eXjg0N6su6z/tiX9b3TZwz2TcHvGtcI9ty4l2vJ+BGQrogELqRtzj4
         CAMv9QSXijojrQH4zprNaQiG79PwgLcdQd3DbheIVbaTVTE7hKsJ8gaBE+LqYEWhQ8YU
         C1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583418; x=1790188218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cB8xedQQvj0IrSKjUMXK0LwEeN65e2heD7WX5ql/Fk=;
        b=RrqkojLNOU7WLiVpOhEVtECbOd+NAKX9xW4RGgySd0OQRyI93C1zsgQINcfOlCDuaj
         I4T6a8ssJg/qJ54tGFOCBBjMHcDUbkmX3ST/9GAPmB7kMGNIliM7cAvAJKC0c2d+Uyd+
         RiBPujp1x5kZYHOfFfxx6esM7hkanLDZv9Z+tV0gARjPPQ6w6yqJuupkWHr/H66gU+QF
         D0Nzc7yxY8ipxzcUfGJZC2BcooYZklPm+5Lt7/25fBppQWoSVHFzNzhUo3xjVzcIDE+1
         5C9zTVjxSPy9q9Owevxw6fgCTLP5jVnYCZZd6IHq4jE1G2rwdooO7YU6IgtPnrTdhIna
         QVEw==
X-Forwarded-Encrypted: i=1; AKwUvByn8Jm28VVJ6mWAPI/goD4t6Qvz9uY/YD6S+DRKG+RO/Fw5vZcITraK2SW+kZKep8RHmSw=@vger.kernel.org
X-Gm-Message-State: AFuF++m67arguTwGjQ0wCZDcSvc2QbXXDkZBLuid0SzMb4KF3Fmkam71
	5N/gHwzpJ610qBfTLkOAyIwiyhJGYpuRFVqWEjx79rCtdLZA0UavNB98b2QXwVHN9B2g60T00qB
	jmRCOk3a0WGJrY/AWcAmuaEBVSP8aufo=
X-Gm-Gg: AYBFou1Gn8UCcs63Tb0cwSjtji2MvSJ/TighgqAcepXyentUQHRzVd4YBuHU1Ab1UtP
	akzNqnj59x48qK7Cv33zYr86S30fBpWf3nJQiSzCwSs+9Ps7O5vg1RbCh68+/srpHRb+Hh7OYDr
	pvCy4dJXfQxL0kPB3Ne1xPnFb3zTS406Xy5BhG2RahSGLFGK3UJGhHDA1s6yZImYUyTdQL0bgzl
	Lfvg1NAoyaNHHy9+CoPQOI8rNcCmYcsm6eZnsYwNGCkKy0ytTkzxDE00RKfaRjVqKwUPkMRb45J
	lx+yedePGVWKgJHv1kpYIPFHf5v8JRp8j4yMzak0TTnfLnWjFn3qEB4=
X-Received: by 2002:a05:6808:6412:b0:4c5:7d0d:7a5f with SMTP id
 5614622812f47-4ca499cc905mr4023538b6e.6.1789583418230; Wed, 16 Sep 2026
 11:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916181001.201787-1-usama.arif@linux.dev> <DLGY7IFP8MOG.YFISSWRDGKR3@gmail.com>
In-Reply-To: <DLGY7IFP8MOG.YFISSWRDGKR3@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 16 Sep 2026 11:30:07 -0700
X-Gm-Features: AcwNN1UGPx7lnVvt3z2iap40dwD-R4LLwB6dyuaIBNTPY2xkFaNousEY7ARosjA
Message-ID: <CAMB2axOVd3jx+Gznb4mrNTBN=5oXqeDx-WfHPx5d1E7tbwoejg@mail.gmail.com>
Subject: Re: [PATCH] bpf: local_storage: avoid redundant IRQ save on bucket locks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Usama Arif <usama.arif@linux.dev>, ast@kernel.org, andrii@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	martin.lau@linux.dev, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, song@kernel.org, yonghong.song@linux.dev, 
	yatsenko@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:22=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> +Cc Amery
>
> On Wed Sep 16, 2026 at 8:10 PM CEST, Usama Arif wrote:
> > bpf_local_storage_update() takes the map bucket lock while holding
> > local_storage->lock. bpf_selem_unlink_map() does the same; its only
> > caller holds local_storage->lock. The outer lock is acquired with
> > raw_res_spin_lock_irqsave(), so interrupts are already disabled at both
> > sites.
> >
> > Using raw_res_spin_lock_irqsave() for the nested lock saves the already
> > disabled IRQ state and issues another IRQ disable. The matching unlock
> > tests that saved state before leaving interrupts disabled. On x86-64,
> > this adds a pushfq/popq/cli sequence and a test/branch around an
> > unreachable sti to each acquisition.
> >
> > Use raw_res_spin_lock() and raw_res_spin_unlock() instead. They retain
> > preemption nesting, memory ordering and resilient-lock bookkeeping. The
> > outer unlock remains responsible for restoring the caller's IRQ state.
> >
> > In the tested clang x86-64 build, this removes five executed instructio=
ns
> > from each uncontended nested acquisition. It also shrinks
> > bpf_local_storage_update() from 1732 to 1702 bytes and bpf_selem_unlink=
()
> > from 1030 to 992 bytes. The affected paths are updates that add or repl=
ace
> > an element in existing owner storage and successful unlinks.
> >
> > Document the owner-lock requirement of bpf_selem_unlink_map() and asser=
t
> > that interrupts are disabled.
> >
> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > ---
>
> Makes sense. But did you observe any measurable improvement with this cha=
nge?
>

Same question, but the change looks right to me.

> > [...]
