Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794934315;
	b=c+gN3TI3Srr0kx+ZGVE+qKSNO15PH+T7TI1Gd0QEKpOGVjHP3zDCmXwaUtK7+HAz5Dni
	 VleFUBsY33go+dynst0SMORk5GprChx1vzWyiEZt1SbCty7K87YKcUr1h3ZqgtwkPtdZf
	 nO/LPn7SpmoR1v7ITIgSju6AxCzhSYQX+bufd1iAtG3RjFHcCTqLMH0OCI/FiIe0BS/aY
	 zNM9LmuRlFJeE42L42/SHfu4yj/FyrVcrUTeTXRdnCLD7MBfDZFAQyYVV/QT7/a08ek0D
	 Q2nW247eC20g9B1yYm+8z4XWo2rjuO13Js29XuI9YxJHo+iv8kutw2+d+BOt5CuBf6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7JRaWtwwi9S7Z5KFGKcQeTS6a+RchtYr83xPGWINYgo=;
	b=cjayjAlhBaj4c7K6D/5IyyutI5PXm0LBfzDXJWcCaQC0qRvT3mnaLJgBc46QFbydK2hr
	 /jDxLKQDe24h2Qz17xNYZxWwJUKspjnYbZtDRpgB7SHtTPG9GVNs8YVXX8v44vupekFQu
	 sj+5cGVTYrAWvIy56nKS5jF/pAW0yCD8UfLsDOK8huawTPHZJ5D3Uhbgw/i2RseNV+f8Q
	 WfopSJRLS8j7NbBxnCdJVOqzLkozIrABrvfE2lXF9lh2trqD+r6xLva+YLI35ghoea9Se
	 s+PJQ+r7xGLwj4a2nkPEBeclNtmswnpgkSy0I7hLF6mxvk3ndItXwNCPaQSGYSh5duA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cG9HEID;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538A606A330
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 16:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D538A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cG9HEID
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so701925e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:51:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794934313; cv=none;
        d=google.com; s=arc-20260327;
        b=TzmH2uwc3fMK0KSgmfCfr8+fapRIye1ELr+dWIrm6sOpYPqgwzCeTGXeoUbamqhZns
         88Fu/5cPsupth2E/I0VENmkWky4GwU7gQhSJtrp2BR+2ivq7TfDd6sVkbAc8hO+/7W7F
         Uk+TV3hq8AYg2kCtegtHYZ6RtR97N0w41zlj5E9ytXP+MkoSDRO/QM7C0kp3DgfunElw
         EGr4ZtWiFdjdSvVIi21R18K/5Mke7R/26BIxXvi6eWKiyBXHg/q2LMzct9wJ6MSo1Ls5
         hRORBl4b+aAsbOOUDWFYPHnAd78WFC08VM1bKF2ZIUS5vte4Zg+aykE00E7keP1ramSx
         fFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7JRaWtwwi9S7Z5KFGKcQeTS6a+RchtYr83xPGWINYgo=;
        fh=RsONygZfwwFuESnEHAhsSjtTtn09dQWhPM5ViHqwZtQ=;
        b=dxuYfCHPV07LQ9Qznj51zyD3dhKZY1vXQ1qMTy0eFtw8VBWbJsgHJmzP8ZbnZ5o7jX
         APJmoncEtHq82Wocl8CY5shSVJAzeksjrQXZ0PoRNAHKTqlxBtP7G67DzgNu0O5dy4dQ
         onZcMR+cjxtWZp5wEyJF45hhLU2MV7elUHSgySfjM7So5nZwIAtjAeFkNwMZPU/YpzSL
         eSljBQIV1OTnAfNNVYfchHYhv1EK9wp0i0MvbclodZW3/QmAZu/Cd0Arcy1z4J1pFQsN
         JEO1iVbXxj9AuPuzc5Qntc+kVzf+SjFCQAGTUThEe9SQ7kmL3h7/H0bVUiCMs7W6Zcnk
         NgmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794934313; x=1795539113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7JRaWtwwi9S7Z5KFGKcQeTS6a+RchtYr83xPGWINYgo=;
        b=0cG9HEIDKPN1IRLjWvhck/vln6wEcHrnV5TJWeVj5j0UGAlYiT9dy4RQ4G83AKqrBO
         wfsqNqc0iqHE8NzVxg0qUKPI8/LOLteUkakQPojwzPDBrP2C3rLnPG9CT6GwlMZEYofq
         tcqpIIhzFLtMFED//3XgkKb66wWor2VcJ8LUpV75RqG0Saq1eJdRPJqb3tku52GJg+oi
         xkk85GAhMopSY6zJmS2QPb0i9y4L/erFssmbWusTmAx2d+sIDjCFIY3R2Rxrb0aAhMkD
         KpoRygRV23IzbzvfZBw0Gt3VetYHpCk+74d5nQybBylkvNjT5fcJqhmbGpbe2s7Tu5oK
         7UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794934313; x=1795539113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JRaWtwwi9S7Z5KFGKcQeTS6a+RchtYr83xPGWINYgo=;
        b=1zyhmZsjJK2dGjaAokz24rHiLbY9e8W0qYCfDZhFuN43AiTpgt/8PLy93RZW/Tsp5W
         S8VZFYE5dO/+i1RpnmrjhXPQjrlH8ewbxTlkmYQzdfsm5v1W4tYBiVjrdg2mLKYWNIDf
         zef3Cn502Wr87M/eLysb8TnUWIugZBF+4mH5Msu47AbRwVZQ0rmu2JZcMA97M1AkNYex
         xFuhlxNm/e+jwt68LTZ3zz3E7u/6Qgr/xCCixJV+NPEGwu9DPPhvFzzz4ffZ7YSQ5Vww
         7S9uSjJumO8IHJIzxGjRu5mpHjev23yn6TcKfd9ivguWmjcr4xJX0ro1bD3VQ9n59krK
         X8Xg==
X-Forwarded-Encrypted: i=1; AL+hErHtk5Z1HPojPvJstXtadqzRM29zbnxstRlrzfhIU1TGRA2Jd/YedWs/rlQHKhFGfly/PTw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cyK1n/lcBhliozGrXBHw55Puuy4Mt0xC8kPweXdFNQ8rFD/ho
	NljZyYF6s1jFqntBoGEDkWd/S+cIRbBwuCLFg876S1gNJZOP4n3QdtZUyw3X6J+jC059bk3gEX0
	ZOimmhAFOoIc/Hf+6uVyVfwVhTLe81Yo=
X-Gm-Gg: AYBFou3bqOV8OihuTrTZj9xjr7zVTg26d/NCFeu+iAcogogu8jPyb5FfH+M/7wLZAE8
	6oj3K5Ki4zjJuw9fkrrogRnvsIc6SlWg4SdSw4tGnz/4oCNbyeqyXQcbWLr2Am/JMLIxoM2SW15
	WZmVuQlLLBrpNZ5Gz15JUi/OblY7qLx/qKo6HThRAXFFeJ0mUpU0t2A9k+rdsz7NXznnkmO80LS
	3t4L1OOFyAgHngNKNasaSLgE7Fd0kWgxheFxwXM7yv6W5KfzNnGu1+Pu0HmQwkkvyrgMkqZ5PKl
	/SCOMQIc3F9Gw56qW1ZFoZ6wGr532scTs6fHx+gz+Itw0j31xIRUny1rQsJFtjgCUbkOP8AEtfy
	zByE8/r5PodFTvYt2GbYaeeP6m2xJTWBiYRuKRmwZkzqRwh+KFduwmJM/UnqooLQcjvjhTGjXko
	YXXAl4Q0SrkWZQryyzFqUsdolu7QGegrRKhQ==
X-Received: by 2002:a05:600c:3e1a:b0:4a2:191f:7cbd with SMTP id
 5b1f17b1804b1-4bb55a3e31emr267364685e9.11.1794934312966; Tue, 17 Nov 2026
 08:51:52 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
 <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Nov 2026 08:51:40 -0800
X-Gm-Features: Aa3M54rjJelQoMCxfJbdMIri9nRD0cwaH3YE08B27J2GSDu0HswQ_b0L7fMjvps
Message-ID: <CAEf4BzZ120age2-M-a_TJ07xohb7-s=xn3e1W_-V0kopnATq6A@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: roblabla <linux@roblab.la>, Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Nov 12, 2026 at 6:00=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> wrote=
:
> > >
> > > Hi,
> > >
> > > Thanks for the replies!
> > >
> > > > LSMs that need to provide a stable API must provide an abstraction
> > > > layer between the LSM hook callbacks and their stable API.  The LSM
> > > > framework is not responsible for the stability of individual LSM AP=
Is.
> > >
> > > Understood, that lines up with my expectations. I think the biggest
> > > thing here would not necessarily be stability guarantees, but rather =
to
> > > make sure that the eBPFs fail to load when the compatibility is broke=
n.
> > > But that's probably a problem for the eBPF side, and not LSM, I assum=
e.
> > >
> > > > So, in short, would it be possible to send a follow up to Daan's
> > > > commit and move `struct mnt_idmap *idmap` to the end of LSM argumen=
t
> > > > list?
> > >
> > > If this is possible, that'd be nice so that we avoid this breakage in
> > > the short term, since the change isn't in a released kernel yet.
> >
> > can you please send a patch proposing that and we can continue
> > discussion there? please cc me so I can follow along
>
> Considering the original patch was submitted, reviewed, and merged
> with the BPF LSM being the only user (none of the existing in-tree
> LSMs use the idmap parameter at present), I'm a little surprised this
> wasn't brought up earlier.

Yeah, unfortunately this was missed. Not sure it's surprising that it
wasn't detected immediately, though, because unlikely someone tested
an unreleased kernel in production. Luckily, this was still detected
early enough before the final release and this gives us a chance to
fix a mistake.

>
> Beyond that, from a style perspective, I think I prefer the idmap at
> the front of the parameter list in most (all?) of the hooks where it
> was added.  I'm not interested in moving it at this point in time.

So on one hand we have a real user pain which is easily fixable
without burdening kernel and LSM subsystem in particular, right? On
the other hand there is a minor issue of argument ordering with
mnt_idmap preferably as a first argument. I get the preference, but I
think fixing an unnecessary (but easily fixable!) user pain should
come first, don't you agree?

Can you please reconsider?

>
> --
> paul-moore.com
