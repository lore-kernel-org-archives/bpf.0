Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F132D452;
	Wed, 11 Feb 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799757; cv=none; b=OogBKQXKd3HGgSaiuY0KJuT5pFv9Cc7Rfmft6FFwoprdbpEyDvHZWGE3vKhjSwWKH600KUAsIPFv1yEr8vlDFfrDls0W1VuTHzMDlIhgX4XC9vD8uTmlhZ6MmKAXV4APjdt3kowqNyB7NeSFPThQU0+/jKXfKibjDwOpBw9R6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799757; c=relaxed/simple;
	bh=DQxx4sQpSRlmKFD8OqooGbohxZ8Wbb2yF5Xw1ruqRyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYqe0r7XZsw0YEtrJK5sa5l0MorAmJB+dIy+i7XDnBcphNWH9IX6h/o5aBaMGknTs6y6W22ISFSMJlKjzanRNIIL8VjlJZpx1fM5NWzPSCbzTTfVwa/pZThG7SZnQrqQ5QPQk2PmAgqMAsKHoZWyQ2lbu0AGd8AjRGuQ+rJH+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtEoCmEu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtEoCmEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33168C19424;
	Wed, 11 Feb 2026 08:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770799757;
	bh=DQxx4sQpSRlmKFD8OqooGbohxZ8Wbb2yF5Xw1ruqRyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CtEoCmEuIQYkf44CTRIYkvvBx+oRL9t4k8OhMF0fiZQ2ZrtJIoaQO79zQVL2yzl7d
	 YRpPNBf4NEJlNkaEJI5CHzHxVEEiqXDuwPjsD78GBozOBkeWq6J09Pop2UnAAgylxd
	 kOGh8OGo5i1KvYHHyZ3ipVAyZfH6Y8k6nudQEoj9Tari74h0sKVMJ2fx97MAVMfJXN
	 FXWtgt7LCZfQD/21QgAdRGZnQYbEFzRCNkIfzEvVjpHnODFXzk2Fgn5fgJo9R1IgUa
	 T0ypFr7osDA20BKtEaZzLMs9Lbp0U3pncTIEfpTG+g60YPvqrM5nSnYL95apiab/hx
	 ++6Y+WUDAkMRQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv3 bpf-next 1/5] selftests/bpf: Emit nop,nop5 instructions combo for x86_64 arch
Date: Wed, 11 Feb 2026 09:48:54 +0100
Message-ID: <20260211084858.750950-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211084858.750950-1-jolsa@kernel.org>
References: <20260211084858.750950-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syncing latest usdt.h change [1].

Now that we have nop5 optimization support in kernel, let's emit
nop,nop5 for usdt probe. We leave it up to the library to use
desirable nop instruction.

[1] https://github.com/libbpf/usdt/commit/c9865d158984fb2b73e3cbbdcdfb4f583ad36a73
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/usdt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
index 549d1f774810..c71e21df38b3 100644
--- a/tools/testing/selftests/bpf/usdt.h
+++ b/tools/testing/selftests/bpf/usdt.h
@@ -312,6 +312,8 @@ struct usdt_sema { volatile unsigned short active; };
 #ifndef USDT_NOP
 #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
 #define USDT_NOP			nop 0
+#elif defined(__x86_64__)
+#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
 #else
 #define USDT_NOP			nop
 #endif
-- 
2.53.0

