Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380A3CBE7C;
	Tue, 28 Jul 2026 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222950; cv=none; b=Fnu0/XOZvnIIutS6zuVaoUG6nOWoPm9ki2giTm5SUt07RxFDpspxm+aV+DtYULSRgv0pk5W5KlJHyJQ/uTObUyoR270Pp30zC/C6gjAgqsD1J5BW1U4m5tzYXOwsPeJnlOU32Ed3b2n7gnO5wxwHjvb+LTvQX0FJPbJgg2bYo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222950; c=relaxed/simple;
	bh=3bRn9QdiNFALb300Vgyehoi112zCnIKSmNcTYPB2wWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPElj40GJkCOJ3xhoG+fk6qUXZtBw2Yf332015M9OwDdbf9tPm4KBiP4A4wY9AECNaCq4ylDzXGITdHgO6q1eIPtVErxzYv5s3eLlhw+BTnvJc1FdotvIqvM/ABJ/xWvITDnVo4uhTALa1Ja9iHBkzm7V6zRmXObsv7fYBZcTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1woc2E-000000019Yd-2DNb;
	Tue, 28 Jul 2026 09:15:30 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin Kaiser <martin@kaiser.cx>,
	Florian Schmaus <flo@geekplace.eu>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: don't preserve ownership during install
Date: Tue, 28 Jul 2026 09:14:32 +0200
Message-ID: <20260728071516.2706695-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a libbpf build is integrated into build systems like Yocto, the
source tree might be owned by a non-root developer user.

The install_lib target in libbpf's Makefile uses cp -p to copy libraries
and preserve ownership. This leaks the UID of the source tree owner into
the root filesystem where the libraries are installed.

Update the cp command to preserve only mode and timestamps. The copied
files will then be owned by the installing user.

Suggested-by: Florian Schmaus <flo@geekplace.eu>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 tools/lib/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index eca584fb061e..0a344ca4e108 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -231,7 +231,7 @@ endef
 install_lib: all_cmd
 	$(call QUIET_INSTALL, $(LIB_TARGET)) \
 		$(call do_install_mkdir,$(libdir_SQ)); \
-		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
+		cp -fR --preserve=mode,timestamps $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
 
 SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h	     \
 	    bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h	     \
-- 
2.43.7

