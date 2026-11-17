Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912039;
	b=4jybgfIDwImqcktqr5a+v7g5Ic3VMbyjXxvYTUU6QE4br8Wjf/KkbC0mc25pJbIfYh0Q
	 UqTI//MVSOE/T5RkK7OII4nbhxVJkXQzZ3xpiBKqxpzEDrPYToSHReT3VyfZXvyxI2UbZ
	 1YJ5msdDHnhXRS+1Kz9RKbNtaQIhlo8UfU8sYmq732kCQKYWprJiuHZkNEi9X7F+AQDX+
	 yl05q8nqpF7tR54+SC7bVj/vhSWLNLLDemUaiD/+Gwxr5Yf+PH1JMmm8DDxfsjo6mygad
	 4styL7cJvGpvF8Z+7GN4HYDEraSX7M56MDdPXDz2JmQ77teb8uEVwD7HIG3Co8nP7Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912039;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PeTh1qCqb0MkvMG77i0jjRwce6VjDTaRKIoXFiiZrt0=;
	b=G/CsSaY71//1Qhx5mwe3VfhoypLLhNK8vqPAUk0LUDgr+BP520ydKxNVI7CcvRxMNP76
	 EyXB3AvGm52lXjkzYHOAz3tuLLVfMB3v1bKSgRRROlBCMFdkG9jd52ceGUu+LzBUbaMIA
	 jS1VrefDCNZCgnQZfU5uWBorQgp0mb3pmpBKjtZLOAlKFBz+PsutnSA1wMBUpz9N8Dcx2
	 qtXU6Kre8oNlmK5c/B+g9vJl8gL1pf+3ak/sH9dMOh2VRh7nHNqqyabOPV2E4zk3v4uqe
	 Mcyc3gCDtvqRitG84tbGgU8psouK5ZjIOm0mK4+8fGwBrbvMGSfYGVo8h8voto44SsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPmBpshx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF3606A31C;
	Tue, 17 Nov 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPmBpshx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7C61F000C4;
	Tue, 17 Nov 2026 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794912039;
	bh=PeTh1qCqb0MkvMG77i0jjRwce6VjDTaRKIoXFiiZrt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iPmBpshxgp0ABX60wKuI300Nv0oOyeFkotG7nbkGsiPNnkn6cOTi+pFLDDLxqBdb/
	 PdOuJ48uSp1h4CY41Q2n0/wgI8u69FcuMPYQFSexz1j87iUlBCe5+T+yGlWaHVs3PT
	 XfmW94lwRJyDzCP++RM4yngRENg/yQPXPAIB1wfdo6huJyGF1O9NIs1Z56fI1Va7m8
	 krc0kgVfcWa9dv7p2MgbjygLAz5N5PMfkC4gLPsWLsfdTBrFYK5QEKGXMHxhfnT3ZO
	 XYZwPkCmySz2vT+iTcHZnXnKai+AczHDg7tRQUeiclTsXlS9NA4aRWgoriz4rRG3V4
	 NzpChoWCgIKtg==
Message-ID: <sashiko-outbox-218653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 next 05/13] kallsyms: Fix selftest startup delay
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel
 Wu" <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261117103352.1244657-6-david.laight.linux@gmail.com>
References: <20261117103352.1244657-1-david.laight.linux@gmail.com>
 <20261117103352.1244657-6-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:40:36 +0000
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
- [Low] kallsyms: missing Fixes trailer for schedule_timeout() bug in
  test_entry()
--

commit e7ea6257d7756e16690d0150d840ede1f6384772
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
Since this fixes test_entry() calling schedule_timeout() in TASK_RUNNING
state and busy-looping instead of sleeping, should this include:

  Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117103352.1244=
657-1-david.laight.linux@gmail.com?part=3D5
