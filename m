Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77536897F;
	Mon, 24 Aug 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587558; cv=none; b=Tn9Pk8auMwiKjqOt/oIvkYM48pYeWJE/ajcsp3KN9fy+Xa5GyFa3ZmcuwJJhVcQlqU1vEsvnqUYB9bSF3QfFoEIqV3+gfsl6SyOpDeSWoaSOBXy4kSfXVy+4GhOcCLXwB5GLYjKEH5KYF3m9qc5CkzPYWVcDnn8gh8vcO+51BLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587558; c=relaxed/simple;
	bh=mAnn8lCC8CIaJdHDU1rhT42Z2WA5jMjaMEMo8Y0pB/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxPYlkVbPwRFxn1MEQVHPAPLkqn2aMEi8IH+Ebq8xx351sjK7Va2qe+Hqv0MaFqBCo7AfqMqh3c/YgbuS00BAmL1OW+6oxYXTfdKUjOZSutjz/eZRg3DS5ip6VWJbx1NkVUHa3fb+RCbbKJh0dwNfsEcu9WTxT27BRcJysiWINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KXcATGYi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KXcATGYi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57321176C;
	Mon, 24 Aug 2026 09:05:50 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E50133F85F;
	Mon, 24 Aug 2026 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787587554; bh=mAnn8lCC8CIaJdHDU1rhT42Z2WA5jMjaMEMo8Y0pB/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXcATGYiblCFLHpkpJ3dWLchgVGcO9Fkn7aLt+0hDsnP3bpXXPHFXftjmt7pR58vR
	 2bXx6QlmsEr8OZamAZdP5OCw7v/hT+jfDQRoSou7GvXm1ImM5oCovGMfQyOGW9P/Gn
	 em69FAcrIUlVaiYSuADP1SL6CUzdUrdZlVbQffZ4=
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
Subject: [PATCH 2/7] uaccess: Add scope guard for bare kernel nofault regions
Date: Mon, 24 Aug 2026 17:04:47 +0100
Message-ID: <20260824160523.3907021-3-usama.anjum@arm.com>
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

A batched nofault region must run its end hook on every exit. Pairing the
hooks by hand makes early returns and error paths easy to get wrong.

Add a scope guard that starts the region on entry and ends it when the
scope is left. Callers can keep their natural control flow while the
architecture state remains balanced on success and failure.

No functional change until a caller uses the guard.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 7ae1854673471..b25e778ddc38a 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -653,6 +653,10 @@ do {							\
 #define __end_kernel_nofault_bare()	do {} while (0)
 #endif
 
+DEFINE_LOCK_GUARD_0(__kernel_nofault_bare,
+		    __begin_kernel_nofault_bare(),
+		    __end_kernel_nofault_bare())
+
 /**
  * get_kernel_nofault(): safely attempt to read from a location
  * @val: read into this variable
-- 
2.47.3

