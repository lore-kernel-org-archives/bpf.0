Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013676;
	b=jsvGv/tWp92w1GyPdXElMifQNZYsprxDDHcRTDhdz1KroLC4pkrDhAg145ZTCONkVIwC
	 ao7FUBc/CIwAgM29iyOn9ajPyzb/ufWeZBM+tA70O/pDsSDY2azzC50f+tjJNi2l3Sstz
	 qHA0jPaMPSA+4UMQI3Oh9haO+YtLvhkJ2FNlVjuXJSOiyGSjeJCiNeVoXRzQsdiiiyJPa
	 +pcbEUTq3yPFYHKtqGGLHgWXpHnSx1gRnWMMOVP8w/iroXWfPn0H2sEKn50EVZFWJ82yu
	 2mTS7Zyld9fIPdyYS2vsUQQGmDmyHAyK+PBOouu3RU7xDJLc6LNMlF7WaF25/DDx3Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013676;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=QoNIQRmDnruBFm+8ezpcjoTWVmatcu6wXQo/1X8jjy4=;
	b=oSNCon6D8MR/uoghcdPUzXsLKjl1A9yqNdxBjVxa2WNf6pHeIrG93t8tN3uEMwEZc7R5
	 58QnsV+NeLJqCJOapcxJM7JNn//qGrobo8cdRbJojXFVtg4FW5ql5A93mQQnPZyyJjDZp
	 nJ4ZYvebYqVHtdhrCSMNgyI09s8/C2JiOd0iHzp54+GM/Hxi1D1bU9XjWpbPYq4JFH6dN
	 TmccuEi38RpEvVF5SxM4UTAZY8Wmw18ZzUJBRk3R6NqdUjP7RMII8qVH1wsnjrfBIWAG5
	 kE6L5CBWvjm8gwt7yH/c+YR1Sy+mkV04CRW9c/Qy3nk61/2wNCUcoFGER+n5t5ucJpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=czhPXa6I;
	arc=none smtp.remote-ip=83.166.143.168
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB62606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB62606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=czhPXa6I
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV4Pj3L6bzDfy;
	Wed, 18 Nov 2026 15:54:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795013673;
	bh=QoNIQRmDnruBFm+8ezpcjoTWVmatcu6wXQo/1X8jjy4=;
	h=From:To:Cc:Subject:Date:From;
	b=czhPXa6INRdnjumg6b5EconJzZT0hvLz2X94E+LQVPB7Io7QwQT/60psmG6LevnGD
	 oeW6LwCU2EQPDN0F7tf3FqRci7xZ4X+UXg6M0p4gR++gjhzhslSAntx6F0a/pUIoOb
	 GcnUJRt1rHT4M6tJnx1Agl7TJRZniWCjPXCG+j2Q=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV4Ph1YTzzdLF;
	Wed, 18 Nov 2026 15:54:32 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>
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
Subject: [PATCH v3 0/2] Fix LSM mediation of PR_SET_SECUREBITS
Date: Wed, 18 Nov 2026 15:54:27 +0100
Message-ID: <20261118145431.2551578-1-mic@digikod.net>
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
https://patch.msgid.link/20261118145217.2551053-1-mic@digikod.net

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

Paul, John, Stephen, KP and Matt, please check the AppArmor, SELinux and
BPF LSM implications of exposing this CAP_SETPCAP check to the capable
hook.

Changes since v2:
https://patch.msgid.link/20261117101738.2523492-1-mic@digikod.net
- Apply on top of series 1 v3.
- Use ASSERT_EQ() in the test before checking errno (suggested by
  Günther Noack).
- Shorten the commit message of patch 2.

Changes since v1:
https://patch.msgid.link/20261110202811.2409395-1-mic@digikod.net
- Shorten the commit message of patch 1 and check the non-change case
  separately (suggested by Serge Hallyn).
- Add Serge Hallyn's Reviewed-by.

Regards,

Mickaël Salaün (2):
  capabilities: Check PR_SET_SECUREBITS with ns_capable()
  selftests/landlock: Test PR_SET_SECUREBITS mediation

 security/commoncap.c                        | 45 +++++++-------
 tools/testing/selftests/landlock/cap_test.c | 69 +++++++++++++++++++++
 2 files changed, 92 insertions(+), 22 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
prerequisite-patch-id: 365071039dd2be439f67707944d12edbe1422d60
prerequisite-patch-id: 021705fb5147cdc8edcac9dbe53c06b854cf976a
prerequisite-patch-id: ddc6687ae87f8f782ed8ad5b005834f242aec2fb
prerequisite-patch-id: 0bf745b08b99168d266461ef5b0b943a2b71eceb
prerequisite-patch-id: 03ec09be2416d4cc932b07dfb0e7450f15c22804
prerequisite-patch-id: 383fa2ce8a4ed44e4b5c828c99c5be5ee75048af
-- 
2.56.0

