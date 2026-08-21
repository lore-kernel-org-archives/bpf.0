Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4CF35E1B8
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348483; cv=none; b=mWdBXrXLV6qE9mMaMn1+QLEUFzBAPvagZH+1jepJNf8mH4vv1WkvbAoMVN5qT6qd1l5hJQ51AyEsna7SjPzH+YE3VH4sZkE5jNjtGo9d/ueUD+R2yrNKEcmtr3W9BANVNs1xoBB0HhQNCZAF2obvGFYUM2jaYk43C/0AxHKdKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348483; c=relaxed/simple;
	bh=YZkNa2buCqydCCg855yF8G6LdT20LcEYEMqZ1RrmX9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FklWp+t8t/oK32x/Yo880SKIq2J9M2SuFJ/8+nDKfPs1MYqJ1YhNa7aHP5qgVJqoaAMv2rd6s9VUIFQcrhPMh+qe0EUskoeGggJ3gXgw7YEYtmeaV8lZ3pGMOistoXEJ+GAkJ5k+vIBDePBPUF6mD/5ZNgUMwTTlJscInIf/Fbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ArK5zENa; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ArK5zENa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=DpPOCWfrD71gkiB6ET7qTgzfjbj3R9h/ZjfQE7RYC8U=; b=ArK5zENazvZm4MgITCWOa4OxP2
	p8GMNW/QC1H9yh/AEiM1t8g3kFjSknG8rjQdUe+B22VP+RblqGnnychYMy+x318lq8LfTj1Wy6GNV
	VEl4U00NoyaEw4Qe9NXoehyv3zlKpj4PFM9fBp7wDgCSQcC8BKchSD5fnbOWEN1bYBJGiZ38bPLk6
	TCYbKClizqV+o0XFg456C9OXwnptF6ACqBfF/OnWKoUIlUNrGbS5tuQUSRbR82fG0CfW9yGvAXQRm
	mpYuRttdVGrzy/XpRTPvCH+XACH6cmPAL0M3NFDW0HyTefRayljWBJsM6xwNAqP1sAsC/qRzLi3Bg
	qqr5kMYQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wxWzA-000MpG-1l;
	Fri, 21 Aug 2026 23:41:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 00/11] BPF keyring and signed loader ML-DSA support
Date: Fri, 21 Aug 2026 23:41:00 +0200
Message-ID: <20260821214111.1120748-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28099/Fri Aug 21 08:26:38 2026)

Add a dedicated BPF keyring which is integrated for BPF signing. It
is modelled after the dm-verity keyring which was added in commit
033724b ("dm-verity: add dm-verity keyring") and which can eventually
be used also via systemd through the same enrollment method as in
dm-verity's case. It is selected with a new well-known keyring_id
VERIFY_USE_BPF_KEYRING and gives an operator a place to enroll a
BPF-only signing key at boot, specifically scoped to signed BPF
program loading. Next, to demonstrate that BPF signing is algorithm
agnostic, we add a few small tooling changes to support ML-DSA and
integrate everything into BPF selftest for BPF CI to ensure nothing
breaks with future changes. For more details, see individual commits.

Daniel Borkmann (11):
  bpf: Add a bpf keyring for program signature validation
  bpf: Refuse caller-supplied keyrings when the bpf one is active
  bpf: Raise the bound on a program's signature size
  bpftool: Support ML-DSA program signing
  selftests/bpf: Add a test for the sealed bpf keyring
  selftests/bpf: Rebuild signed lskels when signing key changes
  selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
  selftests/bpf: Add an end-to-end ML-DSA signed loader test
  selftests/bpf: Allow appending to guest kernel cmdline in vmtest.sh
  selftests/bpf: Add tests for bpf keyring in signed loader
  Documentation/bpf: Document the bpf keyring and improve examples

 .../admin-guide/kernel-parameters.txt         |  15 +
 Documentation/bpf/signing.rst                 | 274 +++++++--
 include/linux/bpf.h                           |  13 +
 include/linux/verification.h                  |  10 +
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/keys.c                             |  72 +++
 kernel/bpf/verifier.c                         |  42 +-
 tools/bpf/bpftool/main.h                      |   2 +-
 tools/bpf/bpftool/sign.c                      |  22 +-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/signed_loader.c  | 518 +++++++++++++++++-
 .../bpf/prog_tests/verify_pkcs7_sig.c         |   4 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  63 ++-
 tools/testing/selftests/bpf/vmtest.sh         |  16 +-
 15 files changed, 974 insertions(+), 83 deletions(-)
 create mode 100644 kernel/bpf/keys.c

-- 
2.43.0

