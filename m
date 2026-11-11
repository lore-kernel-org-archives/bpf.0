Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401213;
	b=2GVdtBuBfb5ZrhHrcIeXf53zKSyJy3t2pFHbz+XJD+KYPbUUcPsWxJH27xw1t1OK9JvX
	 nQdAIdRej7JQmJm5S3LwsjsIuBTt95SaKQl7g7dRJOspbpu/Ze89Fdozl/bdZesLKoISy
	 tWJXdQjUwtL54I16PvKGVoVFb3Kn8FN78LfEJNjQwBUJVtmkMmkqz8NYwLxHZrSNIw52q
	 4uXOGsI7+kNGzFO5+Q7JEQ4nJk0Pvbkbam+IXhjyJ7JwnXhfj5S9Mwt1D2xsa+zBJOuiH
	 FtubxC6g4yPTiqIZk8m1Ll1GEuYZrkd4HorergnZMU93D2ZfczV6NQ5Y5Qua/80+7fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QhJOCa+1Qe6960YUiR0AbRg7kmwlsf759Ceo5CeH5Lk=;
	b=jIjO3nRgjiawcS0Pw5xVzYj/SMtaTN8PcMt+ApICC4QArTG6k8KLLDXk7458kmFYRyJr
	 UHm0HRj77mXUcTreKrThk5TcEzXTIDMjrtkBLhBcStQdXH3mHkORluppe0d1qPQh1UL1c
	 4UJ99zqvXvssaDlyR4yzogVHBbfxKsaOebgAzgW1E7gVxqgExwFBffDxtCPAX1QrNvBWs
	 /GwsYD4aYLd8xLuSMIsb6TNqZ6mhYzUrkOCykblVS/yhCW9Kg58D9Fpyds99jhWhtAhFT
	 U8gLBExFuYln6KlDnuFUyICI8zFADbOjNvYy8uwRq1qxRLf0fK5/mpBihfwdDFb7qgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKweV1n+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F4606A326;
	Wed, 11 Nov 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKweV1n+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2261F00A05;
	Wed, 11 Nov 2026 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401212;
	bh=QhJOCa+1Qe6960YUiR0AbRg7kmwlsf759Ceo5CeH5Lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YKweV1n+wEoSOFAcA4aE4ZYKKkCUQnhobZwiXjd9vyVkrfy35gBsHTONezyf5Rcd1
	 LDuN+oENDnBgRjL2NiiRWsnblVFQFj34Xo0BQ47CHsXupU7gm4i6DdrMUi0w99xTUq
	 5NQSBg6QWzNybwZomxztXLDeDfNG9fkl6IwLOCDcJ58SXKlfD+yuFRlzslahTPLEnm
	 CVquY4ui83ndXkLYaGGJNuaHyTgbLB7K1OktWcEoYoANKedX9GF4w1GH5Z2zsiULN8
	 vsuOlJT1ZJYmKZujmJiz6ZkpwFuXXmaylNvZgx75ano2Od+yWWbwFVCo3GHSd3nSBH
	 bfUqpQALbSC9Q==
Message-ID: <sashiko-outbox-209009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 next 07/13] kallsyms: Match compressed tokens on the
 fly during binary search
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel
 Wu" <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261111115911.1142000-8-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
 <20261111115911.1142000-8-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:46:51 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] kallsyms: duplicated paragraph in commit message description
--

commit 997bbc0ca13e8295f645bd1de808235b97a9b662
Author: Jim Cromie <jim.cromie@gmail.com>

kallsyms: Match compressed tokens on the fly during binary search

This commit introduces kallsyms_strcmp_symbol() to compare ASCII symbol
names against compressed symbol tokens on the fly during binary search in
kallsyms_lookup_names(), avoiding full symbol decompression on the stack.

> However, full string expansion at every step is equally wasteful: of
> the ~17 strcmps in the binary search, only the last needs to check
> all N chars in both strings, earlier steps will know +/- outcome at
> char 0,1,2..N-1.
>
> However, full string expansion at every step is equally wasteful: of
> the ~17 strcmp()s in the binary search, only the final matching step
> needs to test all characters.  Earlier non-matching steps diverge at
> the first differing character (0..N-1), but the baseline expands every
> candidate symbol to the stack unconditionally, before comparing.

[Severity: Low]
This isn't a bug, but the commit message duplicates this paragraph, where
the first version looks like an earlier draft of the second.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111115911.1142=
000-1-david.laight.linux@gmail.com?part=3D7
