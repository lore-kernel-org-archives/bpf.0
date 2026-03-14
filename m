Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978F35949;
	Sat, 14 Mar 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773522501; cv=none; b=NpW8YU8Vq5dlkUo2UQJQZrfKK5fz2ceBuC8MzPmg/imzgVJatLfNczLfwRoKtM16rwSIXaJFNpMk/VWt8Sf9EP4L8EGraoBtf30WuVumvuuWWITIu/2IfwoJHpgOy1Yhac2Aq8f1YiGdg2Q7m3PadOHFagWO2WNVtkwIfgxMQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773522501; c=relaxed/simple;
	bh=8/j9ajuYdLm/E8MQFklQ9p97rX8NzSS8Jg5V1exd1CU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ieyAW5X2QKCQqUjcwzzEMq7U1QGe8zarx2niBzM/PykqzNmpXxEVt7ctbCq8XYkGhHuAvfHYIvyZ/bpFd8KhF3N3e7OBtg2Sdtm7bSQCPGjJ+pAjm+d1ouDkdnGF8u41A1UW69LC42zraqSbvOIwtUFJQXXBX6izIAp9SdKkm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrRQWf36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrRQWf36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAB2C116C6;
	Sat, 14 Mar 2026 21:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773522500;
	bh=8/j9ajuYdLm/E8MQFklQ9p97rX8NzSS8Jg5V1exd1CU=;
	h=From:To:Cc:Subject:Date:From;
	b=FrRQWf362mtt53DdhAxOzwpi4LY7YhuKWvU9acI11/Gj1mguFUBl62+PY1B+IT97r
	 WfaxkH/tifbpWI1SaC4OTwnAJYJhhgKMkQfg2dLAnJFgBk8DXITg9AH20V7nIAR6R7
	 kdZTPz0oS7qYLhtbS4jgnZUlKjMVNZM/thOhxZzhMgs94glyGlLI9zRvc3QBkkK8R9
	 rv/MDB+HRtDuvoAIoZHChpYOQuQF6xcIFtot2pgywKPUqvT80PWWccPcBT3NVD4rhF
	 p/Sbkpn+z4AqMMfqHPTXvIqRxre/JZSrBdnKiLZUgoTpV+h04zfOA/91xp9XRk/sc+
	 1IqMnD9/4GKbA==
From: Eric Biggers <ebiggers@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH bpf-next v2] bpf: Remove inclusions of crypto/sha1.h
Date: Sat, 14 Mar 2026 14:08:10 -0700
Message-ID: <20260314210810.67348-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use
SHA256") made BPF program tags use SHA-256 instead of SHA-1, the header
<crypto/sha1.h> no longer needs to be included.  Remove the relevant
inclusions so that they no longer unnecessarily come up in searches for
which kernel code is still using the obsolete SHA-1 algorithm.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

v2: also update include/linux/filter.h

 include/linux/filter.h | 1 -
 kernel/bpf/core.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 44d7ae95ddbcc..e40d4071a3455 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -19,11 +19,10 @@
 #include <linux/set_memory.h>
 #include <linux/kallsyms.h>
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
-#include <crypto/sha1.h>
 #include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
 
 #include <asm/byteorder.h>
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55625c..f11ab6f354e2e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -16,11 +16,10 @@
  * Andi Kleen - Fix a few bad bugs and races.
  * Kris Katterjohn - Added many additional checks in bpf_check_classic()
  */
 
 #include <uapi/linux/btf.h>
-#include <crypto/sha1.h>
 #include <linux/filter.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
 #include <linux/prandom.h>
 #include <linux/bpf.h>

base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
-- 
2.53.0

