Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641434;
	b=v+OyEatwIzDMTQ/Ucu76jrcPmMACP5SxWmBa2DXXxKC5/CCm0GXIkIYRgEm2wRpEMNO4
	 QpLKoTKMc7NCSxJZ8yxyLeUYdw7Ylh5BDeu9D1FDd41zyzjGEFwdNKcSBaBhe8kjkwvUk
	 oXJh332sUiJjB9yNbaZMWm53wNu0lWptviQ7Tag+34dTr9OuMTO4HAKtq6ZdpnlekaR2Y
	 jeAcUfPPZOupRLZk8PLIgs+3mRff77z/ps5KgNH7MZ1hEdT8utLWFiB2kuSAH2KH/WZiZ
	 7voR49l5Rhp7Bg5G5iUEhrh1Xswp8r2zdiFUjw0zqUavkj++tiPSHWGsSPjrJzkSM1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iwfb5sHVIqvXq9ghgAUb3lAZtJU878pLWYMA3THKAJI=;
	b=wg7bQxPQNmXsNO6Ss0oh9u6Ru5ubjkMZL3ajqElSC04vXdMYihI/QkHDKQTmbQn5MW/O
	 z3Zv5PRSRhUEwgXnnAYlzYZku/EdKGiKoWoeg4OaJu4OT0u1zCN1jsixJYacpVPzlZPyB
	 LOcSakHyd/bK3CX5Nw/xP788uZqr/dfqQ2y5zyE92ns1CJ5nHLFALHdPiM8zvMDqG9YTZ
	 v7H3dwZQhRuW7YBDVaFstfGXZTNJrvubcGUL5PZLE2eBkztdlLepo1KnNbeT5X8IMEsZQ
	 iRIjJlJdINTI8pqnky3eONCOSbSOH1ebVfJo8pPoaaHRlThA8BUN6xh0gNmPVxM9y5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tizg9VXK;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164A606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5164A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tizg9VXK
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dee593f18so5853723f8f.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641433; x=1796246233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iwfb5sHVIqvXq9ghgAUb3lAZtJU878pLWYMA3THKAJI=;
        b=Tizg9VXK5bDm3VE5gX59VRbCoEJ+KwrInRznvo2rzNaQ0yiSQ7gSbvwTgm0mLcAvyH
         TJoxcf2mpEMFoVS4o1QILCVo0PIdV8DbKZRReZoZy27wpPaSi7wnmQjk7C4ZA/FiQLw8
         n/ypNugubqHz6dU76GkgxmB/i1N+7bzLGVqDBub+4EwXNVPd4hqg6012C7A8v5HFZXCS
         hSdLXoxEF8eN4mJGTxmZkJQV6LfUoI8+6/rMLbUBXNC0eMJTKMVbA4d1IMfx0ofXdyiI
         xvF4pzKFiMWRQjtTucGjdYxMvPrB24OhdVRRHKaR7YQbYIuGkGzoKw6vbhvpByvwcEVj
         iRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641433; x=1796246233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwfb5sHVIqvXq9ghgAUb3lAZtJU878pLWYMA3THKAJI=;
        b=IJTndWI9NIaw9EV27edrZThnQvMLEvuI1dAH++mMru6b/A4w7Y5rdv+jO22dn/deXb
         ql2RYcXTElXXGSbktUzsdo5Hr3Zx+JQQ58Ajg+YCamPTpZHfT5E1rtQNHCXaL2AlesUK
         zDssLW3l3fQs0o4V7a4+9tJ6JUDmXllDbDEgiMCWzqx54xEUeOml7O7+Di0cfLpEWs10
         p40sikwbQnPBODnlGEpv8FnnTJQaK0tsMZguiiVgmepigzQ1K+oMxaIaABjRBc6T4B5k
         1GZCo7TGgv/UojyPKF9CdHZmzvJJwaEEDyBersAn44zFUwB3awkA7Uy6YNC7mE0ZkzGx
         c57A==
X-Forwarded-Encrypted: i=1; AL+hErGkqcFp8OseitRzkYAcouhtzQ+lp4/sCAeZ1qodKyzLmKhLF6Si3tOCYoTdmTCrV1iyk1c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8J3hu8pfXnxNF7+XzAPm8eUYDOsZBNKmWU3Hrbbv2D5f6HOz6d
	yQxfbq8Zu+0lnYLKZBLSiA0VOIzyyBCMLL74yfXvTCGJ6HfISjAM60Ee
X-Gm-Gg: AZFdTZffcXcf7dX1NQrZ2jVLyvdfx2r+NN5qf8E5X7vrfeW3DYdOKURxebBVdjUnIyV
	GiQCfGImawSxKdjZ14tpX0sat+HLTnVFuN3+yuatg2MOFqWbYayYRRqOs/n91JXycYu8x08VfaJ
	749ShYT7cZRliWoX8VflAZqkJjGXMu+EoqQA74iVkTKr4tAPUpKVt01mx3G3YuR63qbz/7nS8Mu
	yhd3Cr4YvTFdCGFfcWIdPnV9QhYjN0PobONN81kGMlVqK0CvnFqFqVCk2UGdkd2/I1UF1kgZ0KR
	v2tb/xOty1yunYZeBupBlPqoSH9ULlVnuUVhfcx0SyqJ4oSaICKcMMKn0lPwYMB3auIWVy8ducw
	b8vQDnG4B7LxGNLCCXus1DFJFTHoddO9Jb7mUYI4ioElQoPjmkLKQ8SJ1KgoJWvnxI9Aga6GqdF
	sSpkFNPMtknpsCwwPVfnGdrrZnm5yaZzke7gSFWPmj6mZq+9vLRjm4N7JCqTT8rPVO2S9+wK4k3
	I3E0yq8LGx4kaSq0Ki1TQu4827kyIjONJn3wRWgwoSF2eibDO6JJeYNSy4HdR2utWKNQ0wFIWpD
	C7xIVvSll4uM36jwBnma0WvBxLnmXm8iqSResl/of9M6P9aOVd6b2dbopwC1Cl/moVcC
X-Received: by 2002:a05:6000:2c13:b0:4a7:9630:7b57 with SMTP id ffacd0b85a97d-4abb43dece6mr37287206f8f.44.1795641432466;
        Wed, 25 Nov 2026 13:17:12 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm41840507f8f.24.2026.11.25.13.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:17:11 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 0/5] Do not tag selected functions as fmodret targets
Date: Wed, 25 Nov 2026 21:28:33 +0000
Message-ID: <20261125212849.868523-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
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

With CONFIG_BPF_FMODRET_SCAN=y the build tags the functions that
return errors, so that an fmod_ret program can attach to them. Among
them are functions which BPF itself relies on: the verifier, the
trampolines, kfuncs and helpers. As was suggested by Alexei in [1],
we shouldn't tag such functions.

Changes split into a few logcal pieces:

  * Patch 1 excludes the functions which use BPF types.
  * Patch 2 excludes kfuncs and helpers.
  * Patch 3 adds a static list of functions to exclude,
    which contains only 3 functions for now.
  * Patch 4 excludes the code of kernel/bpf/* and of JITs (x86 and arm).
  * Patch 5 adds a corresponding selftest.

In my arm64 vmlinux build this removes 774 tags, 13650 are left.
Precisely,

  * Patch 1, BPF types:        removes 575 targets
  * Patch 2, kfuncs, helpers:  removes another 130 targets
  * Patch 3, by name:          removes another 2 targets
  * Patch 4, kernel/bpf, JITs: removes another 67 targets

One implementation note: the llvm-nm was chosen to list names in Patch 4,
because a) it handles any object independently of how the kernel is built
b) BPF scan already requires llvm tools.

  [1] https://lore.kernel.org/bpf/DN3P7509U44I.MLLYA1W3M3X9@gmail.com/

Anton Protopopov (5):
  resolve_btfids: Do not tag functions which work on BPF objects
  resolve_btfids: Do not tag kfuncs and helpers
  resolve_btfids: Exclude a set of functions by name
  resolve_btfids: Exclude the code of kernel/bpf and of the JIT
  selftests/bpf: Test functions which must have no fmod_ret tag

 tools/bpf/resolve_btfids/Makefile             |   1 +
 tools/bpf/resolve_btfids/fmodret.c            | 164 +++++++++++++++++-
 tools/bpf/resolve_btfids/llvm-mc.sh           |   8 +-
 .../bpf/prog_tests/fmodret_untagged.c         |  61 +++++++
 4 files changed, 231 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c

-- 
2.43.0

