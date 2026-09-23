Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998963CD8A4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190882; cv=pass; b=RLLFsXLwvzpQyzpQZMo+dxqcja9R4jN1wmMQx6L4W5XCR0Ec5Smlp0dZnfmSJaPkYiJa2p+3rfkkfQiNfN9us9ZQEm+f3YoukwxtYMzdYvDWpE4GT6y490+RgHg/n+llWMgR4opvGNXWoUT12l+dlcgsap06Gq979a3tMY/3Xd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190882; c=relaxed/simple;
	bh=7gPCH1FawZYUr4HVUW56LhKmqq4sdZ/hZDa7tEp9rEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UK5gJtu5tW8JJL7At9o5QXRzdIq3YrldpihEzx1+w88CwD8fL+coO8XvKhkZe0EOmL72vVx/6L7bSB9FWIe4GLBPh7edFJ+mHmx6x8vxhPOQ/N8A3In85KvaE7nrCTkPgOIlRGfvnUPDt9OCNO89qwEVoxRXNfMOl6L/puuu1fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN6/y9qs; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN6/y9qs"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5306abbdccbso1595911cf.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790190880; cv=none;
        d=google.com; s=arc-20260327;
        b=k3sMsMj8I/9P1LEf6EIq/HomcrI6ieAJY9o9f3IMwG0jcSW8KkbUTjuPvqDazNIf4r
         rgLut8E4eeZLUqZpzLOMG7cBjQLBqUrQe8ASnUKxuugHSW1tt8GD60WPDeRB6ldBL5dh
         skNgn6toL0RPBsa8EXxUhlTHntPolrQEjX+8FxBohA4FqYjiVYIG1dyjIg2YdZ8oz7DI
         XoZ3ks7PjHwmZ0FTUuYZx0biCq/Y85fFKuOmZQ5E3J/A1QsK0kfnZNhID1a0wRGTyI2j
         QVyPEdOO3EwID/gFjAw5tFtqVzMRYU1XTZRrVJl5Y6jq4hfa0+ZueEttKu3JIwUndKRX
         6vVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7gPCH1FawZYUr4HVUW56LhKmqq4sdZ/hZDa7tEp9rEU=;
        fh=afU8Q8rM4+zAUWTAX0qgO5nIamLDFu3Mi2GPf+5Toxk=;
        b=fH2XExsb9OxLFktqCYUnXEXNaXQfutKvwVnKD92i8qBBavPbVLHiP9EzZnIkfp58FI
         WXSHMdxvFNaAr7Gv7wwZoev9DO66wiyNMHHz0RQFgcQDiEnca2ka12QJtZmjuzyla/18
         EGPN7MKddR04956yrYlillaAUgAKg8ktVueRX8eTG9BAGuKa4ulVQNSAYhrZEBNsnvPp
         G3xdctBi0oIcYp6OPXVvEPNU2gHPE8KRh1UnUrCrUv84Lv/Hkkm9uf47HwrcgsC8huDg
         a+pjHz+Q73Dqm4IFHRVxVAt057jJqvtF9P2+hFoLNsPsRtS09kv1ZtnpWBDpwxyLGfSC
         nEJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190880; x=1790795680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7gPCH1FawZYUr4HVUW56LhKmqq4sdZ/hZDa7tEp9rEU=;
        b=PN6/y9qsQJrB4EqOwn8c1Bbz7EoraFGwL3VZnlCG8TVJ4sZ+uCfICKKOORm0DRvGzf
         zdrNOTG7UKDaQ7Kt6fR0tKYcqpbgMj6DxubsD+KX+saUnnMtJzc4KLceNgspEQUWge9a
         vzyRWiAuFBNM4dRsHw/HBH3XF6vtiWoGtFLKhb2yFaSwyZ7w9rsqgqXJ3eyaIRoQ2I88
         kr7uSVLlgUZMGBtRD+O18htCpxTdNl/w/hwyeqRP4qF4XJ+GcZfVFGsbtiv/RbYcT8It
         WP/e0q2gGoRQ+Oj3EFOrvY4Z3tG60yOf8/IS8K+/orOvEo/a51h6ZE9dE4Yx8Fc0Wu0q
         ph1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190880; x=1790795680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gPCH1FawZYUr4HVUW56LhKmqq4sdZ/hZDa7tEp9rEU=;
        b=gu/FSqeKKPo+L7bcYzVSu5QkETbQ+i4WUF/gmqTbSdoMu/HNchdqyEs+tbjd4Jxg+C
         km4v9h1uG/tKW5qB2X6ZPIRZGHwXl9MxKP1XBLgpZ5vnnMYsJomvrOiNds4GufP00hcZ
         a0oIrJyvCkWGzMZ83ywasnWyYRPABx7o2PY9O67q40xQhj+BkkTFkWey1/tQvSavgGiU
         tcYBIByra7czkTjces1qaEr0rejlJvcwmA+vdd34qtpkmOaRNdYx3wlHTPcc2PaXq811
         XAaNIG/k5i9zLUGYI56BNHw0wGJZbT0PmZKPhasuUpvHEK/7+RdE7Ro/31iz4FmtjBab
         IFzA==
X-Forwarded-Encrypted: i=1; AKwUvByhLcAVy2oY+dQUOKTe6ozB+uY1JYF+z79rTSPpWoGu8bSwWJ6d6BeIljY0zKmMa4VlKuE=@vger.kernel.org
X-Gm-Message-State: AFuF++lhxiriV1sJlkNLSDuhKcJePXIIc0Z3WHUm3WlMNVVOQBslR1x3
	eXfvrCBtf5gbANgZRElweMokbGyA0x4hp/7keyP4mLnNz3EhKOYgNwvnqEjUE9MIyMEeETYgEZV
	7wRTsDGfZZ/jXu6I1yHlQWUzjB4dbpE0=
X-Gm-Gg: AYBFou1u6o8wQpIhHNFPycJ0OrlCWSAvBJpc7D++iiTp6+eWX87Bc8H68HrKOVaFXTO
	pA0Dgv1JhaQkVuM1vaqIGMd2ulrDEW3IOc3u4HO3mBAkKH6oWFF1OTwsPishi5D75SKroBiV5v+
	uYUzVscFfqER9ip7igefHZJKeZGnUCcWvc2BRAFvjadRO1CLrOwYTytZwQhB22v1Dwat4YEfFtP
	dIm03cXCsx+H/mmmw61rV4Cgiwd65KdppP4exxvAR89oEG665duvL5T7XfTgHMVGNjIMuzTQHpk
	2JzCiqGKtWhr4TJUSOXLO52NOn169QHSSgfe/r4MdVYh0NV6m/6o5obYgmYFgiYjy/EKfZeLPA9
	4wcmkRZppowIAMyrhPNpaTfcghyA0rTI=
X-Received: by 2002:a05:622a:408c:b0:531:2087:63a7 with SMTP id
 d75a77b69052e-532fb7485afmr1858331cf.19.1790190880383; Wed, 23 Sep 2026
 12:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
In-Reply-To: <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 23 Sep 2026 15:14:28 -0400
X-Gm-Features: AclHuK9d5OdaJO5Ll7iOJ6jpvdM_SUqGbTaoCVRmfsl2t7C9t_IuciwujiuXmkw
Message-ID: <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, alexei.starovoitov@gmail.com, brauner@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> @David, simply for my own understanding, did you ask Daniel to do
> this, or was Daniel operating on his own with this patchset?
>

Daniel and I work together and both have things written on top of this
kfunc. He reached out to collaborate, I agreed. We're also going to
send bpf_set_file_xattr shortly.

This implementation was chosen due to its immediate mergeability (it
only touches security/bpf), but was actually suggested by Kumar in v1
or so of my original series.

That said, sorry for any confusion about this appearing as a new
series rather than as v7 of my previous one.
