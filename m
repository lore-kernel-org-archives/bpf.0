Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168122;
	b=sBoFRmCh2feB3FMQ+YTmwVWtsCjNaE5mW1qqIIiGYK58+wK4LHhRKThcDEhfP8yLzeUi
	 hTEFu8r/T8bOw4P+9sl+rL3Mzr8mQnftKP0I2a92RwgvAYkLKAZCeOsH4vpHQYFsHGI0Y
	 rQfuXtBBlS0XM2t8yjJ4Fd8RPNUrCOvP7n5FZzIP33Ryzbk2TayTrzmXF4/0DWIW17H+Q
	 bR9eK1mZbozLktK66Y4cVMcWxRjWiGgahXzZnR9v0RJ7dez83aRjesHc7PTEscuohsKb6
	 3XjCkPUFYygo32XzggSWwdmYJax/D9U8eAb7qvfjAwLttIXLmfOBFSH91GA5OwEi8ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LrQEkt8HXk1ed1syfHwtkDqVdWgo9sprdy8k9nccOT4=;
	b=Ua4opyXl1F0b+tBMVt2s1bdUzjbxtqOdpQS0VDq2+pEWHCQtt+fQbciI3HJENBIIXl+x
	 3CbaYgOZF0kxaB3DgoE3dwi3tTysB66X6nPQoCTAFth0BqYZruaz4qFw6S6265vxSaljP
	 hZuhk2t+b+OjVhu4cuMY0WHLQEpBb8bZ0mpPuFauyyPtAIhsSzDVn8JbE4mkWCzMm+orY
	 KMJAI+Oehw+x0W3/2Ca19UnUdoCdvo/uYpfh6Hc/NMy9vMVWXJVMMnRkZ4j1+6abiDl1I
	 Tl3DZQmgvvKa5E+FutVAlKkuc8yzkUwyYG8ZBbyoaXdfK9fStYpEJGMWlHR4YPbPT0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxSXBoWw;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B9606A32C
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 09:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 770B9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxSXBoWw
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so6157815e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 01:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168120; x=1795772920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrQEkt8HXk1ed1syfHwtkDqVdWgo9sprdy8k9nccOT4=;
        b=QxSXBoWwFNgSQtDk7FgcCwW7Iu7sNYfShCcuyAaffjRYinW70R31yZM+yPr6wrXjjt
         Bf4ypvCIuYxbTCzsUWJFeRf8AEu0GkpIeBMjk838RaohymTeJ++xhTBHw1EGTGpu9XMz
         KXgyco+DZVAyVTUlpBQv65z13lX7OxIRmbehC1C7HySWbZUnk+JvFvoOo+RW/RhbZuXT
         LJEU4DHn35FBs0y7+1rXo6NntmSmoLsAwh/KcXyBPBt6Rm8I14A6JYeYi/6dOtC8/ig/
         /z56iB3LRlXa9yM8UWdWuNHaZ+ijxWjp2HKs7NWwO7xKLQzFisYDnwLFhf9tfVPaeW4W
         ICMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168120; x=1795772920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrQEkt8HXk1ed1syfHwtkDqVdWgo9sprdy8k9nccOT4=;
        b=VYbmEH3d8UcYCG7pETvQpb62xeZrFPYKL+tfiOTBxk5Nlzo02M1nO/vCuRwb7JT+1q
         qpswG7g3KxA+9tCdgLdikt1IckzWuc/JJf3FKFmIjPZBnFRWXNEY0DSiKGYQh824nyku
         xcPzD5Hs3emNitUKDdbOZW4wQXcPUp9UFPNPYZynSNcoJGofOLH67KQ2dm4Aj4SAJxST
         UhViNvyjcekYCi2jDHQcsSSSxZGePSFR3gsSzGhz5qfxg+8QIaQ/99Y2KAaY0QlL9NXu
         7cJ3uzE9FzTSk4ztsS2Vg0Ez2ZEtKIS+FCInvdG8R1KJMsoEsN6+NR2rcQGYKj2V1ajg
         SYUw==
X-Gm-Message-State: APuU4Z+3+FtFZME3xUFQFOxvxc9nl/RZ5eA0hh2OoWWDJgxlumD22bea
	NTCB9GlH9DBhmpNwPxicBb7R8AL4tn5uFmk831miwPDYOQkjiCfwU0/7
X-Gm-Gg: AYBFou1xYMZCyOs3gnhPi8E50HhiVLCvH71mXTwJTLM/HJMTCf2NFtVj4gcWZd8blbI
	6tsQmyJWrI7Qz5erKox4GqmXPvJR1A4lIdJNUF3mkANszSSnvMpWafhdYvoMwa6bx2QceWrffz2
	k4TCZoDbJtkmaKcRUWqFCOIppR11y+fb4JGaYFbrFRhMyR0t/mo2Kw+6TBL6VzvzjFeUNG9tCJG
	+NrZqTEQH544SxsHdcmMLVYz5gcHn+G8pZDsuPX9DpBFtcdT7hGs9D71eNvupMme3cd+ar9ThIZ
	tOA2wZ2QlHjL0uVSnSSC0flMCKaXevcTs3d3tc8GM0L+BuHX14UjXcjHk30s+mu1qD0ftOO/o7V
	xzT3FXt1mwEPiSTZNuFIz7Kom3QFjNm4a326ZF5Oyztzqcc31F3o5cBul8JpmYWk0kQFwB3so08
	H0WlyhCQbBFwkDcWoni6ouvG0jjd3oey+v5LJlt6rS/i1WtNCcxcgs9ahwf1Lm7HCUz13zAQZ5e
	16MIlSqcJqaqLgBpJ45DLyJfJXfuneUBDiUtTFibD7A6Rn6naJAFYh7lqhpS2djC66gTclGeozZ
	oBU6r2cBWHnNIUfcbfKvE1o+juX7Mu360019nwNym8A=
X-Received: by 2002:a05:600c:4e87:b0:4a7:6bc7:f778 with SMTP id 5b1f17b1804b1-4bb88938d38mr55542695e9.30.1795168119561;
        Fri, 20 Nov 2026 01:48:39 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f635ffsm45137535e9.4.2026.11.20.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:48:39 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	eddyz87@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [RFC PATCH 0/2] security: Add pre-lookup pathname open check
Date: Fri, 20 Nov 2026 11:48:18 +0200
Message-ID: <20261120094820.11929-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some security policies need to inspect the original open pathname, for
example to report or block suspected path traversal attempts. A resolved
pathname no longer preserves components such as "..", and requests that
fail lookup may never reach a hook exposing the resolved target.

Today, in Tetragon[1] we capture kernel-copied names through
getname/getname_flags probes and correlates them with open
results. Enforcement additionally probes do_open and passes decisions
through BPF maps to the file_open LSM hook. This requires correlating
state across several internal probes and the enforcement hook.

This series proposes security_file_open_name(), an LSM hook exposing
the kernel-copied pathname, the VFS-selected starting path, effective
open flags, creation mode and lookup flags before pathname traversal.
BPF LSM programs can inspect these arguments and reject requests before
file creation or truncation. Existing checks on the resolved object
continue to apply.

This is submitted as an RFC in order to get feedback on whether the
proposed LSM hook is a reasonable addition.

[1] https://github.com/cilium/tetragon

Anastasios Papagiannis (2):
  security: Add hook for unresolved pathname opens
  selftests/bpf: Test pathname open enforcement

 fs/namei.c                                    |  15 ++-
 include/linux/lsm_hook_defs.h                 |   2 +
 include/linux/security.h                      |  10 ++
 security/security.c                           |  27 +++++
 .../selftests/bpf/prog_tests/file_open_name.c | 103 ++++++++++++++++++
 .../selftests/bpf/progs/file_open_name.c      |  56 ++++++++++
 6 files changed, 211 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_open_name.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_open_name.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

