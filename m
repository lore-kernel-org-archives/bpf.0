Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D644C51B;
	Mon, 24 Aug 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587575; cv=none; b=SbxLg7cRSJxYd1NXXxbRJgyl0Tp5xSxUsm2WHw2Twt2kdO8JBpOYrtDQPLYpuHWdoYioYb3VSKaOyUP75rNOEfuhVPZdpwWTuhw8Eib8f4+Yjc2Ndtz9dBPd4maieZUZ/lpZQewHfFxmBC5WE0l+otwBqX3QJ81+Vefll9vUDNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587575; c=relaxed/simple;
	bh=Rwi4AzekxF8PcB6UHH8vOzSHeIKlfPuKVBoBNngyqjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBIBQ4Lzu7SlXueWSUf22JY/FovrComPqm1eVKMNzrxj3V1R1dF4Pk2JBcq6bkd3itX/3UkucAT1h4/LJ2zgH8IHGi2ujWUTzNdFqlPE5Et7JTwF65KFrmLX7uK6uNR3CJORWP1kKvXkbz1Muz+M214WEeoBScZ39w+RBue9kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dJsvLuXE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dJsvLuXE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E38FB176C;
	Mon, 24 Aug 2026 09:06:07 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 885403F85F;
	Mon, 24 Aug 2026 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787587571; bh=Rwi4AzekxF8PcB6UHH8vOzSHeIKlfPuKVBoBNngyqjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJsvLuXExRZfSJVbv3K6HCiW3BR7TJXaVrPv1IYrS8GDrZipSySzPSoKX1sDg/TLi
	 rcgwUtzijkwFuJ82JRFRbQoUfk2VhTL8yreQOzRe8wWaiRJ4JRUZTANWfRepEescVY
	 U3NBHGGKRha8TpysreQuCpCiYPx/pdEPgbg4PJ+s=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - CORE)
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Subject: [PATCH 6/7] bpf: Skip setup for zero-length string kfunc operations
Date: Mon, 24 Aug 2026 17:04:52 +0100
Message-ID: <20260824160523.3907021-8-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824160523.3907021-1-usama.anjum@arm.com>
References: <20260824160523.3907021-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A zero limit is valid for several length-bounded BPF string operations.
Their loops perform no load in that case, but they still enter and leave a
page-fault-disabled region.

Return the existing empty result before changing page-fault state. Keep
address validation first so an invalid pointer continues to return
-ERANGE.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc8756..3574a9a5721ec 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3738,6 +3738,8 @@ static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, s
 	    !copy_from_kernel_nofault_allowed(s2, 1)) {
 		return -ERANGE;
 	}
+	if (!len)
+		return 0;
 
 	guard(pagefault)();
 	for (i = 0; i < len && i < XATTR_SIZE_MAX; i++) {
@@ -3837,6 +3839,8 @@ __bpf_kfunc int bpf_strnchr(const char *s__ign, size_t count, char c)
 
 	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
 		return -ERANGE;
+	if (!count)
+		return -ENOENT;
 
 	guard(pagefault)();
 	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
@@ -3956,6 +3960,8 @@ __bpf_kfunc int bpf_strnlen(const char *s__ign, size_t count)
 
 	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
 		return -ERANGE;
+	if (!count)
+		return 0;
 
 	guard(pagefault)();
 	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
-- 
2.47.3

