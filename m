Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587022;
	b=Ck4aicSJlATFrhWFbXL5+iK3sIkDyIjWbtIx9v6vu5dhUIq4W9z1nVauGwhXvhKSk6tC
	 XreaqWbKZumAOh4x48kBLmP4L+RTWMH0q0wzPQmfwGZzR4hNsA6vKxO8atshXjYgJ1MWZ
	 4Mbed/GdzB1lQW57fYFdsOdE288qkOcjCP0tFAZurLF+pyel9KtLMzrWIuAbhfbc1wvOf
	 AfLHU115A+EOx7BuKfzi1Q3XF/OhRSbk+7J7SjPivo5bChJlReZgFzgQiyE3j+63LbLhy
	 i2sHBhYFmTai5vGJYixYzMlInoAusJI2Eb/+snbfZNkI3gNrPblU6JrALTM2H6WQ9vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587022;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MxQRI3Kt0yUFkvg8lt4ycJwOdj1jWMLnHkDm0fz34to=;
	b=UOs3IvPj+81tRObUZLx5RSqa7fw8z63vSAJMMEhs8ReGnezn+NgYWZDNDjJs6utgjofF
	 BxjWJ8i2B0v1HemFeF6TYXtUMpUbP+2u0mZYYMc5tvXnUEIfAG8vnR4dyupyEcKI9My/i
	 vF63FasgWkUj0yezu+Mpv4HwnphRtkoCi2/s2/vPC5G8Lagf9xik7j1jQWNgDw5heRXrq
	 MNV5p72T8dnxUN9L0h5HxUovUoA/64VVeVID9DQ4nafZgNQ34F7BUnkoMnDsHoOqMrXKv
	 fDMTr2wdJttecQ9u2tTQJKo+PCx+CejJ8tYstSk1nEabxcrY87XPynK1VKE+iRhel/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut8vxLgG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F1606A331;
	Mon,  2 Nov 2026 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut8vxLgG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F651F0093A;
	Mon,  2 Nov 2026 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793587021;
	bh=MxQRI3Kt0yUFkvg8lt4ycJwOdj1jWMLnHkDm0fz34to=;
	h=From:To:Cc:Subject:Date;
	b=Ut8vxLgGG1cbXn9k8x0yxABLoptmCMR0jMkR+1bYJ4bGbU7P+GIQ4ArZFZ9M3aGtf
	 9gKcmGLcHLWjxBdeXDf90lfHbcC/yHs65MIfbI3SOXeS6x/cVYFVFrX98XbyCgjXat
	 kb2Wu2dhUVmSNCXTCFhE1GxnGWKnJVgzermLT3nyBzOp+LqVoGVq0AXh7Aj/tOwOwd
	 SJ2QWrSwk6FTE+m2sgachVctyP4y0+0QlL/0UG2OXfeSLy3IhJHSDsQwgXCEuAIGQn
	 TnQbCV2rbdiAd1/WPAg+zenDtPKZg8pbiao7NHNw35tEZc9dwq4XKlDnfXu7pUFcmZ
	 rKQnaGgZ19inA==
From: Vineet Gupta <vgupta@kernel.org>
To: bpf@vger.kernel.org,
	linux-snps-arc@lists.infradead.org
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH] lib/Kconfig.debug: disable CONFIG_DEBUG_INFO_BTF for ARCompact
Date: Sun,  1 Nov 2026 18:36:37 -0800
Message-ID: <20261102023638.1621622-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.53.0
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

When testing Sasha's commit ca201ad6e92a "(ARC: Strip libgcc debug
information when generating BTF)" ran into build failure for ARCompact
builds.

pahole, uses elfutils to read DWARF for generating BTF for kernel
modules. These are relocatable files so elfutils has to apply the
relocations in their .debug sections and it turns out it only handles
EM_ARCV2 (so ARCv2 relocations), not EM_ARC_COMPACT (ARC700) which is
silently ignored to produce bogus module binaries which can ultimately
lead to following errors:

  Complex, interval and imaginary float types are not supported
  Error while encoding BTF.
  FAILED: load BTF from drivers/gpu/drm/drm_panel_orientation_quirks.ko.BTF.1: No such file or directory

As for Hexagon in commit aaa2c9a97c22 ("lib/Kconfig.debug: disable
CONFIG_DEBUG_INFO_BTF for Hexagon"), don't allow DEBUG_INFO_BTF on
ARCompact. BTF is unlikely to be wanted on these older cores anyway.

Tested with elfutils 0.194 and pahole 1.31.

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
Assisted-by: Claude:claude-opus-5
---
 lib/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..5331c3649228 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -403,6 +403,8 @@ config DEBUG_INFO_BTF
 	depends on PAHOLE_VERSION >= 122
 	# pahole uses elfutils, which does not have support for Hexagon relocations
 	depends on !HEXAGON
+	# elfutils only handles ARCv2 relocations, not ARCompact ones
+	depends on !ISA_ARCOMPACT
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on requires pahole v1.22 or later, which will convert
-- 
2.53.0

