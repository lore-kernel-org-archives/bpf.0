Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488403;
	b=y2bPhZ+UpU/eoHYxcEtj1z9ASy2lxY3BChupFXeX4RABPPWDuY+16sqGVQVqiJh9P8Sf
	 6ef2Zw7CLmkdmbjvHgYM2jmWy2limtHIum+0iQyQ6BfzVL9+Edy3K2Rspo19joAXgFYYY
	 1E3zlfh7YPydZ0vcV4J24PjD42CCiEdL19lSytA/+GqlBa4B4Qc20xHXh2DKlBJ0fWvrF
	 TqFcH2BiGUJMIw2D/VBKy5PHRW+b6L+OgG6A2DWviCmwji2P1kcDt2gZSx6xH9MkP3tuo
	 0KNXjDToGih4kRIx0IEoWXFPxgL+b+AcGoqM4VbPWNLeSuFsq3lbg5dRBYqgofyMXiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488403;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WWuWOPWF5v/D6LxchUsn2pQgYRVn9PWk33rSZSA+gPg=;
	b=0+N2Lcmj3enaSuyRKYg7A0V/3ErTVv+Cr263twrrLo+uOpx9MoohushTgrn+matJA0cB
	 DkXMbziq9ou4/8pV4LFoz49Hdb1yRzGFc8+tW4pmjISGKELvysnD/4uA9/tAVNwkTkgzm
	 dnVyi6XfNdWBrJEdyObvW6rZlP9IYs8UwyI3QabPhQEta3HzOhww5d1LxsVcOKU9cyaxV
	 PoUismaBN64QDOVNHhQbgAnPhgNKlm19Pmu9u31PWXqx/UbyOchRZYkT4+WDFDJjiVLkb
	 7wGlD/nLeJowBm0GnmkYS30qHdVKlt9Amm7+KE/uJ7o8LKE3un1Dyu1GVNxf33phfdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.180
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A763606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 02:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A763606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 1577759991955; Mon, 23 Nov 2026 18:46:29 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 0/2] Set the minimum required pahole version to v1.24
Date: Mon, 23 Nov 2026 18:46:29 -0800
Message-ID: <20261124024629.3871056-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The requirements table in Documentation/process/changes.rst lists pahole
v1.26 as the minimal version, for kfuncs with KF_IMPLICIT_ARGS, which
resolve_btfids now handles without pahole. CONFIG_DEBUG_INFO_BTF, on the
other hand, still accepts pahole v1.22.

Patch 1 sets the minimal version to v1.24 in Kconfig and changes.rst, so
that the kflag of an enum in vmlinux and module BTF is meaningful: 0 for
an unsigned enum and 1 for a signed enum. Patch 2 removes
CONFIG_PAHOLE_HAS_LANG_EXCLUDE, which is always set with
CONFIG_DEBUG_INFO_BTF now.

Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20261123231053.2538168-1-yonghong.s=
ong@linux.dev/
    - Keep CONFIG_PAHOLE_HAS_BTF_TAG unchanged, since its pahole version
      check still matters without CONFIG_DEBUG_INFO_BTF, so that the
      resulting config stays the same (patch 2).

Yonghong Song (2):
  lib/Kconfig.debug: Set the minimum required pahole version to v1.24
  kbuild, bpf: Remove CONFIG_PAHOLE_HAS_LANG_EXCLUDE

 Documentation/process/changes.rst |  4 ++--
 init/Kconfig                      |  2 +-
 lib/Kconfig.debug                 | 13 ++-----------
 scripts/Makefile.btf              |  2 +-
 4 files changed, 6 insertions(+), 15 deletions(-)

--=20
2.53.1-Meta

