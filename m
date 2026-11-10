Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342501;
	b=sdIa0vitBRV9gGAdc/8Aqqezmrarws/UjN6CBgn4GD1ay5casMH87HqyLu8KEywW8bmv
	 XYiG1Fns3Rsu8dVTxg386IjkDbcmoOoCo0TYtTy4crTDRjLOXya+2hCk/duIPyiiB8Vlp
	 RnhFvaOLFv3m28kh3sucnyuTcky1SS0IGtOBiutHSk3fGceilcwvbdT0GMBX/K0IgVFW5
	 orV8bnVTumr9ADVl67ci7NzilXAOw5Uz6NkPse4/P/tkP3oZDr+pgbbkoLgFxnPnzgfLz
	 Oam4WUllCAt5hHl7ah5Pxk+4IIJ9OmId0OjSxmsM/PsAu0ayy/xdXV9NxXLJemxNAfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342501;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=18Upaku51TXF7f7RVBOgnNL6ZM9H8UnRIpYKn77kd8I=;
	b=Z70tZ605Z/Y/WgkAk1ol+DM2gko5ko+mchLPMfQA6nQ4+XAAEb4cnAWLnH0wkGu+sDBa
	 0Mkuc3BiiyrEOL0Peh/2QGfgoFPT7nxDYO/6eQAJY77oKj572GhTZAsotAnqYo83DCfNr
	 ECHwTvr4Z+Pkx0AEGHjhDKOY8xgo0yAETZyoou3mpntnRicSuWk2jjJHv1R4QCsNInYWS
	 dKJapkX0NaVgGm5Xim/7ZNbOgsWgtGZAVccwpEv7jZI+RCqRAzLDm6uWZlRC5IGciimQL
	 qZA0v1kSHFY43TgZKSIIvidSMwgc2KU+F3X9O95jowsDASSsCoBXRvLQDUDJDv4wINg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=aaKjNMAc;
	arc=none smtp.remote-ip=45.157.188.12
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC005606A881
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 20:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC005606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=aaKjNMAc
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJBT1gXtzKxK;
	Tue, 10 Nov 2026 21:28:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342496;
	bh=18Upaku51TXF7f7RVBOgnNL6ZM9H8UnRIpYKn77kd8I=;
	h=From:To:Cc:Subject:Date:From;
	b=aaKjNMAcjUMpcK3Mi2cc1oWepPvafda5NnJXtg4O67fC0qezloWSeXBCwTQo0WHod
	 VC2xEceHUnvqQ15niSn2lfLoGJkZ5OVFgGqdite6eSyhFX/IBQERJ5Q7Ds/Au3mHUw
	 YBSMt3oTb34+vZdnzm8povctJdtPpHh8Mch1uiJU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJBR50kBztWR;
	Tue, 10 Nov 2026 21:28:15 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	John Johansen <john.johansen@canonical.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 0/2] Fix LSM mediation of PR_SET_SECUREBITS
Date: Tue, 10 Nov 2026 21:28:05 +0100
Message-ID: <20261110202811.2409395-1-mic@digikod.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This is series 2 of 3:

  1. fix Landlock mediation of commoncap's capability checks;
* 2. fix PR_SET_SECUREBITS mediation and add focused Landlock tests;
  3. fix Landlock mediation of capabilities guarding LSM policies.

This series applies on top of series 1:
https://patch.msgid.link/20261110202436.2408244-1-mic@digikod.net

Since per-process securebits were introduced, PR_SET_SECUREBITS checks
CAP_SETPCAP with cap_capable() instead of ns_capable(), so LSMs
restricting capabilities through the capable hook (SELinux, AppArmor,
Landlock and BPF LSM programs) cannot deny it.  A task with CAP_SETPCAP
can therefore change privileged securebits, and thus how its
capabilities evolve across UID changes and execve(), without the
expected denial or audit record.

Patch 1 uses ns_capable(), as PR_CAPBSET_DROP already does, for the
changes that require CAP_SETPCAP; changes limited to the unprivileged
securebits still do not check a capability.  It applies cleanly to the
6.18 and 7.2 stable branches; older ones need a simpler adapted
backport.  Patch 2 adds a Landlock audit test that fails without patch
1.  It shares cap_test.c with series 1, which is the only reason for the
ordering.

Serge and Paul, a review of the commoncap fix and an Acked-by for taking
both patches through the Landlock tree would be welcome.

John, Stephen, KP and Matt, please check the AppArmor, SELinux and BPF
LSM implications of exposing this CAP_SETPCAP check to the capable hook.

Regards,

Mickaël Salaün (2):
  capabilities: Check PR_SET_SECUREBITS with ns_capable()
  selftests/landlock: Test PR_SET_SECUREBITS mediation

 security/commoncap.c                        | 42 ++++++-------
 tools/testing/selftests/landlock/cap_test.c | 69 +++++++++++++++++++++
 2 files changed, 89 insertions(+), 22 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
prerequisite-patch-id: 365071039dd2be439f67707944d12edbe1422d60
prerequisite-patch-id: 021705fb5147cdc8edcac9dbe53c06b854cf976a
prerequisite-patch-id: 1dfd782b28feeac47423e702764778031b850d6c
prerequisite-patch-id: 0bf745b08b99168d266461ef5b0b943a2b71eceb
prerequisite-patch-id: 542fe806b611c7cc8e2ded656b62731d25dcba9b
prerequisite-patch-id: 39d6ce2bdfc170b545eb2d275ab781e15c9e887a
-- 
2.56.0

