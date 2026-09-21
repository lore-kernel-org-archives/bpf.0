Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F44BE447
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017214; cv=none; b=qJo3CRS6h7uLxs7/VqDtaD/DyKEh7Cv0kX+kESX/A9IUGfHyNeBGBmpOeXghRJ2A8VHEoe/KzeFxV39nIMcJgrnPQ9rjMfm8abaPkCtOYbWO0mHmwvjk5HtqmA2NW6bxT2PP/MhJx2Q4Wh+IIjl1a1J68neWfNL0OrtSWFKrv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017214; c=relaxed/simple;
	bh=LaPGXWGgQcjKnfjO3z793iuW2xLAXRbHYoryZVBZqbs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=copr0kITwx+rM1c5mrBjZWq0i8XZSWIdJmYzzYLCSyuj3ugo2V2pWkWyFo0adLWLwCMaW/BVKi0W5hnh4zAzI8J54mPo3d1MPRmheBuOAJt3lztQk6XPTVLh+GBNpVqDcRw7Klih0VZ3FMeJytlS2GE6yCIoILASd+yFD2vC2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMNuEFEd; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMNuEFEd"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b355ffso2011615b3a.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790017211; x=1790622011; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bYun8S0nOqfarXTLSlvVxpXRKSkf8eIDnC2ra5er6xM=;
        b=KMNuEFEdErmfKyLOL46+Qq1fyKO6x4Zkkt4CFtYF/OVRL22H8X1wssRLuCcL9sKt7/
         fIOp1+eXD6ksjP8KlX3YnQISM0IPyi83o2oDjhgk3ic9fB94/qNcSxUmFGsD+aqDKk3G
         CFnaSvZxEW8cj+XM9JZ78zaJ+r6wrAZbWNlk1PCFcIjLc0FRBxidYz54fZvpP0GSV5Vy
         kIfT2qCulGjuTKI4CbI9geX8eGshoyyBfYCTeLsUKJQyeftCbNAyoBr7rZJBMGFz2Nb9
         CMdVnad2/bkKxXU9SyuqYofK+UgWrZOuRD7/ukB6dYLdt263xsgntfmj+kXJPALRcUVE
         VoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790017211; x=1790622011;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYun8S0nOqfarXTLSlvVxpXRKSkf8eIDnC2ra5er6xM=;
        b=D2uybOKpyo/5SJPIOHjXOaC6VqS14lRMSFz0iygztRgdXf8qqqPJMCqIU6s5qNYZyz
         gc7AGl8ayUbiVndNE9tbQBono+KXV2vj96kjXiB/cLid5ngOhu1Mucy+YNGzydgSdAlH
         26xv5IntHJjMXGxYtMmg+bRO+jHS7Gk9nTK+BJGf0l4E0+8kF6WKc9gupldQnCzaURlx
         Ddq3Yl6uHrbVb2DAtyNaDAVhzXvV2XDd7Zoh8inZ4TxaP2L/chRw/XZvKNFWpIzb3xFa
         0DKbqvsabWh+XX1NPHQlKOH65Rg1qDVxGAjY8/PQqMJ1ypFwJEROreaZDQyUly3hrls/
         ya8g==
X-Forwarded-Encrypted: i=1; AKwUvBysDUyurZedsv5JWwGRY9nnq4en/va5YiWYJj1wIQ6QmjBVqBleZgqUB6pvmsGNsoEe22Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nVy1tQwIwat8V11Poa3b39SHmY1wc/FEn+UOKvlpp2AC/5O92a
	W0avCvSVP6h/+osJVEZETK5rwYH/LkBHWOwY4tBa2o7VQQ02mXfCfEq2
X-Gm-Gg: AYBFou2aXlf2EzXeKVz3c23nVf0KDOQtjrLN4iy5QeBhYJTT6DYGXj7VASIFLk3B/GS
	13muE9BDlN09itqtdXAgKZEWAS57LjESEqmPW1OXCJb4QX+kWxn41ep12SpjRH+soDm7KzvEIZP
	fgiBg5Ghl/S8s+L3vlPEt85/fX/6WojlGytNpO+pIYe3z+C48IDUK/hPsnxgWS9Rkf4xmu0tC2M
	uQiKWIKP2GCDth4NChSzGHfJrTMJgWOHhyHgEN8CsZ+Qj5SIKmUZ3srFipPEeWdfWq0ulxmo601
	wfUyq5loLF/k/K7cLLsII4p49j5psOzCIzrHfRtNUOs9r9tq6+jnR675S/GDH9svHbNO1t57KX5
	nJXu35F+U0o4MjHkXDUifvItrd36U8RNWETAa+cSoII4aHAk+ixRD35pZogDGFMGE1813NXFTh4
	9/GnbgkfEvzmdJ6hpbr+MyxMglivbDn0zdw6zbQBjypiQtWb/4XDm7Q+vxP7PAZDaNPrJNTeMWP
	wQxffWMitS/VChKpxTd9u9RSjN8kzHvMUepaaeyiLY0y3WHiUk/7O0HhdINTbXvgIHgrAmmgot3
	atajpNhAxFYf1A==
X-Received: by 2002:a05:6a21:482:b0:3dd:a195:dd62 with SMTP id adf61e73a8af0-3dda195e456mr13391303637.68.1790017211192;
        Mon, 21 Sep 2026 12:00:11 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aead0casm3912480a12.20.2026.09.21.12.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 12:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 19:00:10 +0000
Message-Id: <DLL8564LZU8N.16W933Z547TYI@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: add diagnostics for rejected memory and map
 accesses
X-Mailer: aerc 0.17.0
References: <20260921154650.130677-1-suchitkarunakaran@gmail.com>
 <DLL5PFJLT64M.1W82K71YXNT3A@gmail.com>
 <CAO9wTFjK+oRT-maca6A1UDBrgYTGB0Zr48UiLm2Ees835POOFg@mail.gmail.com>
In-Reply-To: <CAO9wTFjK+oRT-maca6A1UDBrgYTGB0Zr48UiLm2Ees835POOFg@mail.gmail.com>

On Mon Sep 21, 2026 at 5:38 PM UTC, Suchit Karunakaran wrote:
> On Mon, 21 Sept 2026 at 22:35, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Sep 21, 2026 at 09:16 PM Suchit Karunakaran <suchitkarunakaran@=
gmail.com> wrote:
> > >                                       verbose(env, "sign extending lo=
ads from arena are not supported yet\n");
> > > +                                     bpf_diag_policy(
> > > +                                             env, i + delta, "sign-e=
xtending arena load",
> > > +                                             "the current JIT does n=
ot support this load instruction for arena memory",
> > > +                                             "Use a kernel and archi=
tecture with JIT support for this arena load.");
> >
> > Did you read what AI generated for you?
> > "Use a kernel and architecture with JIT support for this arena load."
> > ?!?!
> >
> > Please apply human filter to every single line of "your" patches.
> >
> > pw-bot: cr
>
> Hi Alexei. I'm sorry for the oversight. I somehow misinterpreted it as
> "Use a kernel and architecture with JIT that supports this arena
> load." Is the following diagnostic message fine? If yes I'll correct
> it in v2.
> bpf_diag_policy(env, i + delta,
> "sign-extending arena load", "the current JIT backend doesn't
> implement sign-extending loads from arena memory",
>  "Use a kernel and architecture where the BPF JIT supports
> sign-extending loads from arena memory.");

No. That is still wrong. Put yourself in user's shoes.
How would you react to this message?

