Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C501632DD
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782634673; cv=none; b=svO0wuKtkfB81pgHItu4qoLVyPZBN/sYK+TkrBxNoWdFCm9Bgq+7URgYMtzY/vAVuEb1LypdzUE/Ekn6NVavo1w8t3Lke07z/lmovnlGio6H9npSuIwuePZyybPBsn3DTkXSblpAJI7f5ifsrZgmbzT4yoqbAV1muagfgpjv3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782634673; c=relaxed/simple;
	bh=A5u4LAzVAFK4HP13JmQ/QCon/EhAKEfkFBJqMIm3bi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBECyK4AzUlVgT3EZ4wodOjcF2BuT3evSuouwPalotU+EK5F/7pJpD3rRMg48IQiHfvN3j+VP4Tz67L8DHUC3PPuuqy2u3v+Y/qj8HD1063vUo7HLyMZo4E9jqw3xM/wUxYvLvdv6zIXnsjxqTATx55JQdcuCDhv1aNNlDxeNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfgqFSxw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfgqFSxw"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37de961d1bfso1931530a91.0
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782634672; x=1783239472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIbWUZbf4PMs4YBadVfF+7ZfJ1yqBeFq4gfTDljCk2k=;
        b=JfgqFSxw0eTSs3vnGzu/+Nv/3SK40lDU0QrM3Vd9Xs/GssvnnjamGwct0oSVW8KFj0
         x4fR3kAo8lBxlI3VpY+DNebQaxeA5sr6Ld5t57LnQbieFRuc2o+HUbWJ3Wxm8ReArXcT
         EV08868WYtzMxDWExcG9LCCDiaZ6BjOy0vPrTaohsrXHsB3vjINxF8ajgf/i7c9JDKLa
         ZCneZiJDN5ZhaqZxOpraH6ZqRaGpBTjPwRB2gLu1bv0HlZBeJTVWbifW2Q/zVdiUKGdD
         /A/FPiQQZ9kJbKdpkAQc3LGw9MeOPRziDvtMOiiRfmSDsS6JRR4zy5gLEVr/6LazhHjB
         XOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782634672; x=1783239472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wIbWUZbf4PMs4YBadVfF+7ZfJ1yqBeFq4gfTDljCk2k=;
        b=SWKduV7/N2G03QgYb+koqyFcrwSeAX/cOlQ7lPvF6URnu4LaNLFvHFTY6GCWS+0OKR
         66wbIffYtT5Wecn9h28C4Rn3xiCfY8W97HQ9XmrG9Y7sbL6+RnEw6kPQF3ndKzPdl/sy
         1jm0yqzKi3gkRG0zBSuFJ6N9WJTGOKKo67JT4Vw5sW5+K8+s6eJuGr/Ci8tnAOgVurAS
         3rQUvvlSXvbjkgGwjqAI7WR0+f2CoXfVh2dZg6ai8hCv1nTu6Vsrv4vexQI6azACQH0P
         6LFd4pael5QWixnOusgUwiJQLuFMGeYbpo+QbSnjHlM84BbakeJd8TqLmLDKqNRGZC3i
         1W/w==
X-Forwarded-Encrypted: i=1; AHgh+RqVEkNy2JIAFUGgaaWVPd3VwXvZ5U781xM1du7Cg8ItD2RDYF3NgPPIxEq2Zl8WEAjC+uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYnw0xa03KFY/tb8NT5rPcHz933OuJJDGfKJcZ2xTrrgi1BfA
	ZZcNbYbM0G6ouuLfd0v2dKB12fS+OjcNbbSUvJ7m1AIDzTv2yh+EVGns
X-Gm-Gg: AfdE7cnOBF/2iRy0h7zSr5N1jYd0dLgtvMcQ5Eh2EXvVFaq13FBEo3igrEmob2j1rB9
	GRyc3rPVi0OHVxXPprWCwtWSpDRuE0OUCOtc+RIp39sA6ZYGHmGOa3MMRnaV6aZbLPb+ekH3JIh
	FprZ8l0IPzR7o80Fbr8dF6Jv6TxMthRrb0nZaJIHpHax4KXQb9cD81Y23rA8o53Z+bQ0JKIJdCF
	0NQx/fDC1knq8CfSchcoDpOWQGTfstTdGi/Ofmy/nnq5fPKbvsfKeUJ2btOH319ZV99FHHURY0T
	QJLAie54E/K6JeGKjDLzPU+/E2X97+FLO9UzD1aYhZ1XL4TQqiMAVRtZ2czYJktnvQNwZH88eXC
	ALxBoNsTkvwWqaUvNmleT7ptAXWGbST8oumC9IuqpKZKu6FC1GiCbHKe6xnCsxpX2O1a96l6TuQ
	SV3HisokfBt9zBnMMiD6r8O5YPh1cGKvboyYVLR8fS91eiiDcf56BV+PI=
X-Received: by 2002:a17:90b:1647:b0:37f:d70a:9605 with SMTP id 98e67ed59e1d1-37fd70ab29fmr2995751a91.9.1782634672198;
        Sun, 28 Jun 2026 01:17:52 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:3b4a:8aa::dd:15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bd55985asm6020434a12.31.2026.06.28.01.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:17:51 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org,
	pulehui@huawei.com
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	shuah@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v2 3/3] riscv, bpf: Remove BPF exceptions from BPF CI denylist
Date: Sun, 28 Jun 2026 13:47:10 +0530
Message-ID: <20260628081710.113333-4-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628081710.113333-1-varunrmallya@gmail.com>
References: <20260628081710.113333-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes BPF exceptions from riscv64 denylist on
BPF selftests since support for exceptions has been added now.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/DENYLIST.riscv64 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing/selftests/bpf/DENYLIST.riscv64
index 4fc4dfdde293..9268351ce4c1 100644
--- a/tools/testing/selftests/bpf/DENYLIST.riscv64
+++ b/tools/testing/selftests/bpf/DENYLIST.riscv64
@@ -1,3 +1,2 @@
 # riscv64 deny list for BPF CI and local vmtest
-exceptions					# JIT does not support exceptions
 tailcalls/tailcall_bpf2bpf*			# JIT does not support mixing bpf2bpf and tailcalls
-- 
2.54.0

