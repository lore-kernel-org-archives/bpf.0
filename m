Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0627A916;
	Sat, 14 Mar 2026 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773521314; cv=none; b=uWfbYFPczrM6srBPN4RTaGCf3NJ0Gjzq/uOjLYCoSLKBAnheb2bNVtbPUOnYmUkuKHfwFhdAm8xwhkQl24Tv+f7PByMY3DvuaW2ECRKeE2TP1BicDkMkR5xpwBtIGiUEaytuA8m0K1qFT/a8gS3YVE3ZL/TcfLS72RqWJEDeiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773521314; c=relaxed/simple;
	bh=566j+opjh6kIWw86a7s2WVkmcHeNSeGSrU//p5vjg9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZUk7DazzOs5mDOCDS/cfdEqKjQRMnmrbuv21j99Oj0aCA7LyGSLRR3XsHLlrZ5/yACLt9njjI9ocZhGWnAbn6oHnfzpaBTQWUyd4BbUWML0I96ih0j6AUAncq6X7biCzDt+fZNTPgqoB5A1UHzWT0wFw69lsC9yeOKYHYzRW+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk0PLOYF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk0PLOYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69746C116C6;
	Sat, 14 Mar 2026 20:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773521314;
	bh=566j+opjh6kIWw86a7s2WVkmcHeNSeGSrU//p5vjg9U=;
	h=From:To:Cc:Subject:Date:From;
	b=Wk0PLOYF8f8hduTvgIu+1kIHq+g2nI2BeJFoFets8Jg+lS2R+CSQFSggAnZLD/Yv/
	 xBTg/5JFp8FMCsDVvk5uSDYMt5DWpQTYqZr6z/KdUeiaYGnKoBCAvKXjrP0+6nJ8dc
	 lXp9mwAwbTaAPg52T26DiFGySBEoqZVaYiYe+M4uF+qj1/WH3wFIqmBJZ3Hb3LQyXt
	 LfKicObKE0q9l4wV/i2KSRU6lzYUPi1uCUzCPiEBUPX8V6kDUZbEShg2wsOPT9SBPN
	 FW4H5JUiZHfVi+OhfarztYSmQKA2lcW/8UT6pAvadwy+ubz9VYvGjhvK/eYayANSMS
	 1ZWvW+i+kMzzg==
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
Subject: [PATCH bpf-next] bpf: Remove inclusion of crypto/sha1.h
Date: Sat, 14 Mar 2026 13:47:34 -0700
Message-ID: <20260314204734.46111-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use
SHA256") made kernel/bpf/core.c use only SHA-256 and not SHA-1, the
header <crypto/sha1.h> no longer needs to be included.  Remove the
inclusion so that it no longer unnecessarily comes up in searches for
which kernel code is still using the obsolete SHA-1 algorithm.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 kernel/bpf/core.c | 1 -
 1 file changed, 1 deletion(-)

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

