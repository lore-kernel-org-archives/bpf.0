Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559981;
	b=o+EsJFOFx/LGGitPlRyHUE459NyVOkcVTz0RGDMsLuCQIyg0ivljjTNqRsnGV8HUCJ80
	 tEuNNDbvSiGpRT4U90r19hnbFnVF2BBuZ8b8JHw84vMI8uKK5KaQFcUhAnBCy4nN+umTP
	 MesJzPLVXotQ/Ufmku9dKdBlwuDfI2Tizg1RW8nEWPtUUmtd+YutbdodLcZMfEGZdGhgx
	 MKMWB3Ke92E3t9y5KiShZ/C9HIGgjgpGTFzIooh1OsaSpmqew7k14unj7XiFuTpfR45aX
	 uIMYr4LDXc9XCfXtfeMo8v6iuAmWDZrYw+MEhZnj0FuNkmU+JEXf02INC6EJMn6TukA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mvlvzZkY/CNvY0j+z0KoFyGNkiFOfrqgD//AP1mAZr0=;
	b=DUm5sZw6akB/6sDKW8KRrUPi1kfMNmvQkaQ+zdx6oR+4dbnwbNVorwe7M9s2HrQZlXbK
	 XYVdjJOxbz+rW44yVV5LX7HIZCn7zY7+GzN7BePwKfKvIi6L2AHawsKjjgmu2Pf+G/YmV
	 ela6twqS4qhKxrEhm0a6Hlnck55wVf/gN0zUCGrtsbP0tlaXIXQTOlQIDk/t7wdxW1pgp
	 Q8m5dW8KQKLBtAcblxgkjT8ADpji3UvzCR05XMIvqbrmJ8CmvXNbulmgntmo4FRWDvJ1N
	 lzzYZEXYOv5yKlDJZw4CDqmFTqonQdUcBvmgHV3amsGrb8Q2Bs/nd1Ilv5Tzik4qrwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gKEufhZQ;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D665606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D665606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gKEufhZQ
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae486f8a27so1289697a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559981; x=1794164781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvlvzZkY/CNvY0j+z0KoFyGNkiFOfrqgD//AP1mAZr0=;
        b=gKEufhZQXSAdF+H7S8/mTBOuULmkCfwmGpPFcFz9NTlkD47KgdlkguGm856NJBv6U7
         0aQchCaorMqc0xDRX9fxt/+7PZ1XaaP2JPAGtODTjP7a8BKzOcixBK7hO8vCMEqw34aV
         ApDBjsSlppeuTZySgY+kS4dxh7HmEixFGg0KzxG405duO4D0nhiGg4vkseLK0QlWnrkL
         rvTNAYzM5GaW40sPfmIZmt5SQ4RqBC1rJt+PKDLnzysFM7D3eo84CKBLBaR7fR0EFSv9
         2JU4QWonqAwAdFRtv5wsD9PFuQW2be6EZuH7NDLXLiEtXt8kXQiyztPsX21k28G4VBlG
         qX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559981; x=1794164781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvlvzZkY/CNvY0j+z0KoFyGNkiFOfrqgD//AP1mAZr0=;
        b=flcVcziEIgh+D+bcC+YopOl1ol+o8At9dGHflkqzYUWyVzn11JF7A0+Zcu7IIzLKAd
         c6vQX7cS27ZfW0/ARTEfzSqXQCaWRQx0/60Jm6NwsUt67AN+hlmmclbbBPP6elXWzLjj
         8bRyrvlWvNm+6xhp2OL6dp9Ld/f6mUVzQ9bsjEdK0usmPscfCQ97dc5xfWCJK8TAemuX
         1nTLqk+y8hWiriPLbAIz/shGmSyJXLH/HC9D04R76jEionj4JIoN0OzmU4qoVI1LIP/G
         3mx8j1V4QN7mAG1ehAaD/nYp9aYsid+Bypn/vsxf65dn36ZZ/HHDXYReKsZntC0fRxKJ
         FLcg==
X-Gm-Message-State: APuU4Z+Fgom9+BCzE9uFk412AxO2r7K0HlIgAVa+nE7Mp8Mx39gKn8gw
	qHVq0n6pzBoFWt/D0awZm64hVk6Abs8WzZO5Ni9ptKKsJOpBtfcitV/Rm8ctHA==
X-Gm-Gg: AYBFou3E4/VY3t82X/rtrIQ8yzICCJJPNTPXa2jqLdkkPsFmPcyXR3cjdmBJ/mw+Aum
	uh/uRHRJp8bBFaS2lz70nOQoqvM+8fBIlq3WvblcyNYZOezHNMW2eA1utF5xSOTMimD/WbRnfdx
	Q9JX7aMA9RQHNlLw8lorK8D0sD67DHPCG4LZlmoR9tKrFqFvgfeNiplfyIBDerPj5Nvw4yNGzpi
	E2k/D4/jeZWK1ElSZok3mXHCZuk0R3LRbA9HAhCAFnGd8cjxM6th4/QwV+Bg1HUPw7HJaAcjHx+
	slUKWQGonjnFHALZCQoElOPrA9vgzwZb1B8HPnuR2oPeFwJ900XsOQEaJIKeAWpPPjsa9k8jFu6
	AuF85Hq0MUsAbrd2UvUOpd+PtmDeSlvyVyIKe1TZEGya9pEVqj0eLwJNzwJhUTqLQM1HBSO6ijQ
	kh4v8IknIJfWZJcDxXUe60S2fUK+OVHwZ95jaa6ANe4RT40qqi4gD5aXZkQqrAQc/F2d1KLN8dS
	pQt9FasnHTV2hhm1HxPf3rLz5zaFojrP07vIB1AZuBMAiB4kqygOeKto1VuKhZpTGe6wjLleYs5
	6GcgRW2P1IOcahrp8NrVAOl7mL76WTql8KJ0brwhwmbwzu0R8gxuWxuOhl68DGH2mtLUlxJsiJO
	PULe2F7fnMFowhKIlajugAqbbxAStguGbEp+Qph7GmDqMH/wUGpWpJtVFQizYkCjb6G4d3hl0mA
	==
X-Received: by 2002:a17:90b:53c7:b0:3ac:7e3a:1033 with SMTP id 98e67ed59e1d1-3ae897c5e5dmr6828231a91.59.1793559980461;
        Sun, 01 Nov 2026 11:06:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f3e087sm6502723a91.1.2026.11.01.11.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 07/27] selftests/bpf: Test the length and the address of an arena mmap()
Date: Sun,  1 Nov 2026 19:05:15 +0000
Message-ID: <20261101190535.1454146-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

libbpf maps all max_entries pages of an arena and never maps it at
address 0. No test maps an arena differently. Thus the checks from
"bpf: Refuse an arena mmap() longer than max_entries pages" and
"bpf: Refuse to map an arena at address 0" have no test. Test that a longer
mmap() fails with E2BIG, and that an mmap() at address 0 fails with EINVAL.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_mmap.c     | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_mmap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_mmap.c b/tools/testing/selftests/bpf/prog_tests/arena_mmap.c
new file mode 100644
index 000000000000..2babc9ecf182
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_mmap.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <sys/mman.h>
+
+#define ARENA_PAGES 8
+
+static void test_refused(int pages, int flags, int err)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	void *area;
+	int fd;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena", 0, 0, ARENA_PAGES, &opts);
+	if (fd == -EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
+	if (!ASSERT_GE(fd, 0, "bpf_map_create"))
+		return;
+
+	area = mmap(NULL, pages * getpagesize(), PROT_READ | PROT_WRITE,
+		    MAP_SHARED | flags, fd, 0);
+	if (ASSERT_EQ(area, MAP_FAILED, "mmap"))
+		ASSERT_EQ(errno, err, "errno");
+	else
+		munmap(area, pages * getpagesize());
+	close(fd);
+}
+
+void test_arena_mmap(void)
+{
+	if (test__start_subtest("long"))
+		test_refused(ARENA_PAGES + 1, 0, E2BIG);
+	if (test__start_subtest("address_0"))
+		test_refused(ARENA_PAGES, MAP_FIXED, EINVAL);
+}
-- 
2.55.0

