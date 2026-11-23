Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465298;
	b=i2rPQuk2RR/pn5fqm/axE9BAQWny4uV+m8rlnebwn25NQzsom5fPmHjwxBgaCnVXWf9f
	 9NDAnxaTWiIX/k4znnXwcEPCIUXblzscv8oB46KqfOkCXkmcvkOyn56d/WpC1FQYsKy0k
	 VjxwjvNy145lSShz4Cu/SG/pSpLDivZqeBgS5lIG29NN0ol5ZNpJmaparMNwpw2WBQqJa
	 wdoJKhwa0UdT6nFFOA1mtn3VIK437Cw4KweeZ/+ym9q1UuxEyxViVw+52b9w6Q8YgVgJA
	 WES6H/pSNsQYz0YmualTHFzMRSt7iAYWDBXK/61JbBQBSF+z56POSrBxtqgc0DwmbIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LEUZIAOLddGL7x7aQvXVvqPgmEr8lXGuohw1ryERaEI=;
	b=x1lWDIgtWlzi/zPWbgnbyBg2rMUaeinskyFdblJDorEA6vvOJjgMkgDDbi/qNDkj++T+
	 JVM0u9gJClPKjRwwsychQLPbAi4c7OGCMW0OrypM11fap1J7kq/XpKt0KFyllRtfOWLCs
	 OaEAKgGIYswJ7IK3NS+TrH5DUVYA6UkSdHwPC2ao4XfnoXBEgYPP5o6fVuetU8Zb7mDq7
	 h678f3Lz2V26gknGLttb40GgaQKuJx4TwmxXINfNd3FBJa7OHfwyYvFq/r0Y5hkhmmsWI
	 +XccsmBpXVpAMYdMxtg7LZRb77AL8df+OTbl5X8f74o++ItK/k6cUiyBgtoI9xR0CLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=c2gq+laq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CDC606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 20:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9CDC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=c2gq+laq
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb684859cbso2104868a12.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:21:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795465297; cv=none;
        d=google.com; s=arc-20260327;
        b=EpPwS7dmaxFubQSxFxJXlYQYUf9scmwvgi+NC0WvqfzHrY1VATHz/eRTO/M/zffT9s
         9DRCfOe/heYBK23PeDpXzPpZ4DEwzx8jMcgsYWDLrbE3+TN4GFTckpegbSUu3uHSDJRr
         pHuovs79UeSKi5KWgr4+gMU+GJHr6S81JMkudRJ1qkc80iLQq+qFs2Jl6I/dCD+upRLP
         OM0twQFETLirZeiuPdSKDSuLImekUtPuLyFVQl6CTJmeoXxmeWy7sfpDoT1s81yVS0g0
         nnwgF4I7df0us3xQkpMmOpG75LKAo45n/utW56i+lyWwrgapiS0IXsQFSA0hEJHNLjRK
         nCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LEUZIAOLddGL7x7aQvXVvqPgmEr8lXGuohw1ryERaEI=;
        fh=Ixo51c5Mjlcv+KXZUOvMmRu8rBk13gSwsJWpCwzJ1M8=;
        b=R/c/WwiTFROjWX/sLos3CVhdj9I2B5O8w+ctjHlrCnV8bNuf5srxv0D1WMeUWkicGv
         ZSgv3eSZF/xIiWqO0iMSJQ0d1duqG/2SDjQAMY/6WfA+co+mkZM6HGDg4ASYoWmzPaLL
         cow8pcIsOiCLzAPqHeSbWUmAqWmpJmXrTmepQ4mx6/9QyIhj/3XmSElY637gHRPAFktT
         H1TdKpDGHlXe1yOINLnb49+1MaxoN3/qAFA67Qvky9CB1Pq+OKHGeiFxPQhcnltKjBIe
         Fa9wztf9r2IZw4xNQtGveP6XNrdoWBgx0XEHK6RcXL3wWpC2Dj1p/95YPRVFmQWRDTg0
         mIYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795465297; x=1796070097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LEUZIAOLddGL7x7aQvXVvqPgmEr8lXGuohw1ryERaEI=;
        b=c2gq+laq0yhqp6FF1Vf947qPiE0Z5VfoHe+mggi5Ga9ubu4f4hV81J96iQAbuIZq1L
         3JHWBPlWzOPhLjMRN+Q168fHx8VZQwUSN20XWFGjhVlrtlDFTQpPy/JQOmNK6mqkCM4b
         4xerMMl5+iUABeqLcepD5C/uOmfg/WsJbin9q5Oo3YZv/Y50wEt74u2cZmcPrw1UpOEJ
         GvJ6MU5HF0KnwUevXCTb0SqNtPCuLh53gxMDkKmycj2psn1X6Z/3dxtC3DRm8Q/+eqYm
         WQZCzYcpGWw9wMUrBdZgmMmYcAW3hURjuvmeUGtZnNtaDQaLQoATrhyDTFpjwjrcMA5c
         ZOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465297; x=1796070097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEUZIAOLddGL7x7aQvXVvqPgmEr8lXGuohw1ryERaEI=;
        b=ywOMbnM4iEqdnS924iHLJCWxFJggNehaI6IMt1jdENJohTkC936GCVZPK9Dcrxwnq8
         2/ec1YOA4oCT91PngaTxwXZLlDS8OB1Mxe4+n/9NsgULpn5SAwrDS4CmZGIHdrI4Qjxe
         R+RsxnPKXaTWg7rVipX439qU4luyXAmVQQJqA1dGodJf04/7DivcrTEPD7dQez0TKwf2
         PvzPILmZupWSJFYLthHbGEE2wilrE5sOadliM0q3DhLZNOjFx3j5kjLCci3UAI9KR726
         h5Ac5NJ7ONPsJF+AMJa8DNly7yIruiElvH3NDxbDtjz16Y3L0fZtcvPyVTJ49UdRO6i8
         LJKw==
X-Forwarded-Encrypted: i=1; AL+hErGnZQGU2LrLEY0gh/6FwOf+x1yvpV8c+zPWI2Ig2MsTUcdcP36mrahk7Fjb6j0qFch0i5A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9v0V9fT8L7pgf9HGu9kYebyAlbolToBOQ53eHB+dCsIRgdduBo
	oeV5Jw1M+LHuHj2uR584qSdEudjz18ocDvMO3oxWzaoS2SQ9cJZloMCfVEloydOIWqw71ADfeq7
	9eaWAhHj1JB+wiGaJL2xzIETY1ZSRJ+OLA3Bk+mRh
X-Gm-Gg: AZFdTZdhaxxG2VVY60NIREgJbyuZTM750WZeSroL+bkvE8k+lNwQ4qfPkdhzrSRaPOx
	B6p3DXnEMlL/+vn0p+cu5AvWWeYfJxVL5a1piBg4dEv9lWtUqtvtPqdR6ioVH8J7wrQ1P1aM+Qm
	cF17zLAhKvFuNhQDBgyNmu1GlTeavv5llvvhOvmqxKVhPDmE1FLVabpgZkHQjucrCh8ngkEj1yd
	dmmFgI9u2lE3o8ueuHSLtnpWeNTvS6BPQilwmmnmsm/lXhvnWxiu/rqfDydc8zg/6D7a6wfeeRd
	4vZ4PouqkgDgTFD3B1VV05frjFh2YT6iwZ9S7Z/D7wQJ3lspNgD3gSgPrwEY3/BsnS9e14LwdDp
	NMdleR41f5jXSUbbJwUwHLR4zTrBVt2sEVNgdxB5XQxdw3F7YzWxagf2ZjiANUMySCa6Itw==
X-Received: by 2002:a17:90b:2e8c:b0:3b3:b373:6a6a with SMTP id
 98e67ed59e1d1-3b41c9e45c3mr11852486a91.28.1795465297053; Mon, 23 Nov 2026
 12:21:37 -0800 (PST)
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
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
 <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com>
 <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
 <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com>
 <CAHC9VhSFvOiP5Tyt=rOFMwg=Ro1jRw+hfcw4AdCkEyftZJHQCQ@mail.gmail.com> <CAEf4BzZqjiWR4EzBFdV-czH-GnxqOeOAsMLgXtQ6TwN2ZiiT8w@mail.gmail.com>
In-Reply-To: <CAEf4BzZqjiWR4EzBFdV-czH-GnxqOeOAsMLgXtQ6TwN2ZiiT8w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 15:21:24 -0500
X-Gm-Features: Aa3M54qJwPl-ABfK7B5B7-sJCPY_acwvpvVOTnL9PsRVe-QdqJj1wCPpuoy-tHw
Message-ID: <CAHC9VhSOz-ThxXL+5MkScd6Yj2thCqE565zXg80K_cWHkViH0g@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Paul Mabileau <paul.mabileau@harfanglab.fr>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daan De Meyer <daan@amutable.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, roblabla <linux@roblab.la>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:55=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Thu, Nov 19, 2026 at 11:37=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Thu, Nov 19, 2026 at 12:59=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Wed, Nov 18, 2026 at 7:14=E2=80=AFAM Paul Mabileau
> > > <paul.mabileau@harfanglab.fr> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On our end, we also have already merged code to adapt our eBPFs to =
the argument order change. However, we would still prefer if this easily-av=
oidable breakage could be fixed by moving the argument to the end, even if =
it means having to revert our fix.
> > > >
> > > > This is motivated by the fact that such a change is not made in pla=
ce on our end because we ship our software to environments we don't control=
, meaning that any and potentially all versions ranging from 4.11 to the ve=
ry latest should be supported, so the change is made by compiling and shipp=
ing a new variant of the concerned eBPFs for the version interval it is val=
id for (7.4+ in this case). And that has to be done every time there is an =
upstream change like this, so the total installation size and overall compl=
exity grows accordingly.
> > > >
> > > > If we could avoid that, especially for such trivial root causes, it=
 would be nice.
> > > >
> > >
> > > I agree, and that's why I'm asking Paul to accept the patch reorderin=
g
> > > the newly added argument before 7.4 final is released.
> > >
> > > I do not think that the maintainer's personal preference for argument
> > > ordering beats real user pain.
> >
> > As stated several times in the past, the problem lies not with the LSM
> > framework but with the lack of an abstraction layer in the BPF LSM
> > providing a stable API.  As far as I can tell the lack of an
>
> I think the problem lies neither in the LSM framework itself nor in
> the BPF LSM in particular. Neither have any abstractions built on top
> of LSM hook prototypes to guard against argument reshuffling. And
> that's fine and basically inevitable. If you change LSM hook
> prototype, you'd need to adjust source code of all LSM frameworks
> relying on that LSM hook (which is easy for in-tree source code, of
> course). For BPF LSM, if argument is added at the end, that pain can
> be avoided completely.

We're both repeating ourselves at this point, so I'll refer you back
to my previous comments about the LSM framework not being a stable
API.  If there is an expectation of API stability or specific
extensibility in an individual LSM it is up to that LSM to provide
those guarantees, not the LSM framework.  Considering the current
design of the BPF LSM, any breakage caused by this change with
existing BPF LSM programs is solely the BPF LSM's responsibility, as
far as I'm concerned.

> > abstraction layer in the BPF LSM is by design, and while that does
> > provide some advantages, one of the notable disadvantages is that the
> > API is unstable.  If you want to be upset at anyone, direct your
> > frustrations towards the design and current implementation of the BPF
> > LSM.
>
> What upsets me is that your personal grudges against BPF community
> (or, perhaps, just particular members of it, doesn't matter) gets in
> the way of doing the right thing as a maintainer and putting Linux
> users' pain above your personal preferences and/or dislikes. And
> hiding this behind "I like this specific order of arguments" or "BPF
> LSM should have better architecture" is just petty.

What upsets me is your assumptions.  Try to be better next time Andrii.

--=20
paul-moore.com
