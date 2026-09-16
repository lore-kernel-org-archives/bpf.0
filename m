Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09674C1505;
	Tue, 15 Sep 2026 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500452; cv=none; b=hpU7drOZp1Vzq79+hBOnTFP2YbL44ep8c9KgnYgSK7f6tp1p24uX2TFVEDFgtecEgROoRDR31QyyqfKupYCNU6HOua3kNhIdBRPvD3msF2jjp3qg3WEg70rvEHv/npPKmKC08GJY8Qp/F6urxCBhPmhgP/VQutciPyn5X48ZxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500452; c=relaxed/simple;
	bh=tfLtN7emaScceSendHcvj4vevvhH9YU4i43q4QRnbSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTS3rBdWZHFRHFBHTgd6OTJxupsdxQ4CSIHx4bdYzbzzpwwboh3ukpOW3fkFb92Eh8IAGzxchy6/bh0E4BeB/AXIyV3p/EZW+P2U3NiDHH1SkCtRPrD6t2t/4u+KnIUwxERDhcL3QzcsYoJeE6d9WJJBlxZQFC6KXPBJv7EmRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oAV9jrzp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oAV9jrzp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83D6F1E2F;
	Tue, 15 Sep 2026 12:27:26 -0700 (PDT)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 822263F7B4;
	Tue, 15 Sep 2026 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789500450; bh=tfLtN7emaScceSendHcvj4vevvhH9YU4i43q4QRnbSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAV9jrzpv61i9XqlwyK8Tr35madnlcmJOkQwiz3LOIJO+KTlXB6DejNIpBKw2IAiJ
	 AcDYpZeJkmkLcuWJOZzsladM9o00MM52VNSplnGP8KDcxDS38wlxaB2Ir0/SWW3ZT3
	 n6WzHH7veUMQlahO3iyuNMb7e3ARx13bjGMEdhwQ=
From: Bill Roberts <bill.roberts@arm.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	rick.p.edgecombe@intel.com,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Bill Roberts <bill.roberts@arm.com>
Subject: [PATCH v4 5/6] selftests/x86: support header files in extra-files
Date: Wed, 16 Sep 2026 04:52:23 -0500
Message-ID: <20260916095224.1533971-6-bill.roberts@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916095224.1533971-1-bill.roberts@arm.com>
References: <20260916095224.1533971-1-bill.roberts@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile dependencies do not include header files, and adding header
files to extra-files calls will cause the header to be passed to the
compiler to compile, which is not what we want. So filter out .h files
from EXTRA_FILES but keep them for the target's prerequisites.

Signed-off-by: Bill Roberts <bill.roberts@arm.com>
---
 tools/testing/selftests/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 75315f1190d6..ac181b065f37 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -114,7 +114,7 @@ endif
 # the dependencies ("header3.h"), because clang, unlike gcc, will not accept
 # header files as an input to the compiler invocation.
 define extra-files
-$(OUTPUT)/$(1): EXTRA_FILES := $(2)
+$(OUTPUT)/$(1): EXTRA_FILES := $(filter-out %.h,$(2))
 $(OUTPUT)/$(1): $(2)
 endef
 
-- 
2.55.0

