Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3B13C3D8
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268360; cv=none; b=Q6rOqMv4Lp7LaQJibMnnbPYe//ivYNbCs38Qt+F+JgZORnOHIYULzfpks7pgsHjqHyjSyMbls5N/AVQ2dCNFDTJ91wDTlYzvqXDhIz+XNHAwLi/3H8W7yVuLYYYEYzETeemp8KXMbZ+ZQ8DBJrbrm3CFzkVEPuqhFRg9c9BjiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268360; c=relaxed/simple;
	bh=/YCrvUVi3FfZ6n1dW3Z0hITZDaCm+91duASfT/plgC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FaxjduXWFEopl02YkhKRpgQtAtGgVxJHxCipSsJ5vU0Pef8ebXjsTI3b7Wa3mjMmtjcZU+jl+wUuYqmWzHLBAjQUq59NkKC2/tkPW3IiIQ3M+G2EJ8Pzfgy+tDI4YDl/efwc3KzZLBbPEdb5ZOPDawnarb/zFOqdpIdHE5WW+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2G56v8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2G56v8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A83C433C7;
	Thu,  4 Apr 2024 22:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712268360;
	bh=/YCrvUVi3FfZ6n1dW3Z0hITZDaCm+91duASfT/plgC0=;
	h=From:To:Cc:Subject:Date:From;
	b=r2G56v8ydNH/PKI4dCR1CCLe7caw3KN2U5lM9T+CigVSN2HfOmfIDNb6etKhR6lFO
	 hhZobNlGP8d/GOI8CePoWP2WTP1VGkIYRg4g7VJLji5h6iqdlQjz8OQuOFTetxjOW3
	 RFxHNuq3K6aw5sJRfZyh7+/MLo/2iCWvV36I6woLjajerHbtays3nvQURpJ0GerS8g
	 BPB4AKRZsLndqVZ1blo6TbL2KbiITnBUmufhnDcBLIfC5LZWDQQzU2Qn0cwnFTEHxh
	 X2bIbN/3rSu7U0hHXIJm2p/bXJxzBqaMWRs7KLnpXG8n1J6vkAaVacM5NnWXa9xXMf
	 9gzTcgHkgu+kA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Vincent Li <vincent.mc.li@gmail.com>
Subject: [PATCH bpf] bpf,kconfig: fix DEBUG_INFO_BTF_MODULES Kconfig definition
Date: Thu,  4 Apr 2024 15:03:44 -0700
Message-ID: <20240404220344.3879270-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turns out that due to CONFIG_DEBUG_INFO_BTF_MODULES not having an
explicitly specified "menu item name" in Kconfig, it's basically
impossible to turn it off (see [0]).

This patch fixes the issue by defining menu name for
CONFIG_DEBUG_INFO_BTF_MODULES, which makes it actually adjustable and
independent of CONFIG_DEBUG_INFO_BTF, in the sense that one can have
DEBUG_INFO_BTF=y and DEBUG_INFO_BTF_MODULES=n.

We still keep it as defaulting to Y, of course.

  [0] https://lore.kernel.org/bpf/CAK3+h2xiFfzQ9UXf56nrRRP=p1+iUxGoEP5B+aq9MDT5jLXDSg@mail.gmail.com/

Reported-by: Vincent Li <vincent.mc.li@gmail.com>
Fixes: 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled and pahole supports it")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/Kconfig.debug | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c63a5fbf1f1c..291185f54ee4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -375,7 +375,7 @@ config DEBUG_INFO_SPLIT
 	  Incompatible with older versions of ccache.
 
 config DEBUG_INFO_BTF
-	bool "Generate BTF typeinfo"
+	bool "Generate BTF type information"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
@@ -408,7 +408,8 @@ config PAHOLE_HAS_LANG_EXCLUDE
 	  using DEBUG_INFO_BTF_MODULES.
 
 config DEBUG_INFO_BTF_MODULES
-	def_bool y
+	bool "Generate BTF type information for kernel modules"
+	default y
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
 	help
 	  Generate compact split BTF type information for kernel modules.
-- 
2.43.0

