Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400564;
	b=1rRWMsEY7Hs/t1q9YFEes4nicjupm7HtkokZdQQ2+gjSHQ+Z7/642P8NsFHFD1ind9at
	 E5bSmMeLAeADuZOL5GL4EV/JscWP/4zbocMhhWyB5nKGJLpLknzEbh+2HmjB3CKjanTLj
	 vCwtgahnjpEonTPwter/kKKFDc7eH4Y7CPiYDS8q8eMTNYycZWGjViDStC+jyu0nwCxwE
	 ASibkmf0XXQ7sYqhgMIrYQ/7hCOH3NMZOQqO+hl/P3vfxw9omCmeUO6AO4jzyN1AoPJoB
	 iItJ/wfHNxrykfW2JiYeUS5ZKG7LRb5pGgqjLp0WziVZMVxCKtbxyrR7qEuYX+NTbBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dupzLpkceFuWrFi/LEBVfl9CMIVn2NyAFtg6ujtOZ7E=;
	b=lw9p++1GO9r+PIpgUBLpPK5k8fBJPKc5RHfhVlUuz42KjYDcqafpt9Fv/RUEZePZRQcl
	 2EvgQWTq1T4hNSh6HyATf7/3eItDu3R53SZrhOidfzBJ8X4XPI2IQEes/+Tvkf5tk8rCV
	 vaFMBzvf0dtKkGdyJvRiBVH0LCps3WX+Yk3K3cAZgnV+az0X4e5BAArcbEpDY+7L/edUc
	 HZ1b+RamN0AtvsCEYepFIZXxvJuwzeN5lMMk09PCvYAbd5paxi29uUXo2jkVSVlk1GPfZ
	 drZqc/H8bdy/BsDdYtoUVNwye6lZkvq1jS+ug1OX/iRyEplRxDGZ5lBxVGqTsbKz12g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lazi7o8p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96247606A31C;
	Wed, 11 Nov 2026 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lazi7o8p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE551F00A05;
	Wed, 11 Nov 2026 12:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400564;
	bh=dupzLpkceFuWrFi/LEBVfl9CMIVn2NyAFtg6ujtOZ7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lazi7o8pPGGOczPlJvzY6/mkl6nAE+dqvizkgYLQGq9FmY0H51Ycc5tGNfLUFJrxY
	 4Biu9OUvhiMuPLmLbWvxVeBsg/uW6cKaX6KprFsAFNxLkUce91mvOEDYINaVcc09Xg
	 z5Qvv9rEcQdsD3He1ZqNsB+XgEvgslzYSCcH065Cn0NTOQTbDdEKMJy4ko/TH17EXl
	 uFXQ6xQaSHNhrC1iod46Dyl5Mq6loVxnp3sCkhPW+UUDqvFBG3qay3KdVsxPOHS2zf
	 e8ndeQ7JWuBwVALhuLRSc6E6vlj2y6jiBMILQHsIkre9+P0zdNS9yOGypDE4cbzEAV
	 KUETqOCJLqF4Q==
Message-ID: <sashiko-outbox-208986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 next 05/13] kallsyms: Fix selftest startup delay
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel
 Wu" <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261111115911.1142000-6-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
 <20261111115911.1142000-6-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:36:03 +0000
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
- [Low] kallsyms: missing Fixes trailer on selftest startup delay fix
--

commit 06f0c3fe023ccc28da9c2bd9798921899fb0ec63
Author: David Laight <david.laight.linux@gmail.com>

> kallsyms: Fix selftest startup delay
>
> The kallsym_selftest code clearly intends to sleep until initialisation
> is complete in order to get more reproducable timings.
>
> Replace the schedule_timeout() calls with schedule_timeout_idle()
> so that the thread actually sleeps.
> Poll every second (not every 5) for SYSTEM_RUNNING and then wait
> another 10 seconds before starting the tests, otherwise the tests
> start as soon an init is executed.
>
> This code is in the initial 2022 import of the tests.
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

[Severity: Low]
Since this fixes the broken schedule_timeout() call from the initial
selftest import, should it include:

  Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111115911.1142=
000-1-david.laight.linux@gmail.com?part=3D5
