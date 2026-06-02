Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB73F1676;
	Tue,  2 Jun 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411667; cv=none; b=i8zDeVCXEFDfTUNEG02N6a0R1iDNLOXn2hX5LE6i1v3DLzz8bquMLwx7JNL65jlSsdw/QoG0q+96sw+5X3WxqOXFshFLif10aqkITUUeChGUv78sv5N3ylpgiWmn5bUYqNbVYHOSt9BNSowoc4hYtsTde8q1CQSphSHCogpbI1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411667; c=relaxed/simple;
	bh=QVECXhBfSn3HTksxV9ctf7sdfgmuzFaQvCXjb24QcOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SqeJnZ842wNRQZwmTAyt1pu2o+bQZbTa20VpNAH3H7jxQFytbsOxsIcCUgg+wO5sZoMYl8LJlCH9LaGo9UDNSlKaYJ2cDa0vFa2ziA9Q93bpFhRHZaenMNXSsCNoLdbU+3CpTcuP12C/uM5wg8j2x0Ei/dSr5JmWRCsRoMR06ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TvVe6zyk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TvVe6zyk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CA302B;
	Tue,  2 Jun 2026 07:47:41 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA5EC3F632;
	Tue,  2 Jun 2026 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411666; bh=QVECXhBfSn3HTksxV9ctf7sdfgmuzFaQvCXjb24QcOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TvVe6zykEq2a46xyCn9ktAwfarF4GDmXwb+qFv9nlLzrMo70u5jPq+wXvWbMHTt+v
	 /ETTIuRDmzNWUXCEfK0ebMCPcsLXIJV+QRRnel7nQpIzK0QWSl1zxlKwqb1I447dDm
	 D6X609R8iO7OclJzPKeo5PkLvzP1oOu41hFNJ+GM=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:47:14 +0100
Subject: [PATCH bpf-next v2 5/8] tools/bpf: build: Append extra cflags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init_bpf_only-v2-5-c76e5250ea1c@arm.com>
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Lorenz Bauer <lmb@isovalent.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411637; l=742;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=QVECXhBfSn3HTksxV9ctf7sdfgmuzFaQvCXjb24QcOs=;
 b=iMNmxLU7KuObiTWa6YHCONwQwKj+iQbXWIc5qUCcQ4QDokEUQ/rzrc9x8rgcW2wgS4TlVSvDB
 SLI8yxghZcyBhgqjSxEnsU96bGX3x5gro+hU0e1UxXsBZFQqzea9vUA
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
the compiler.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index fd2585af1252669c59228af3a77320e449e1a1ab..9c19e81f3c274767c3b9b94c907cbbe3ce9fe78c 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -11,6 +11,7 @@ INSTALL ?= install
 CFLAGS += -Wall -O2
 CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/tools/include/uapi \
 	  -I$(srctree)/tools/include
+CFLAGS += $(EXTRA_CFLAGS)
 
 # This will work when bpf is built in tools env. where srctree
 # isn't set and when invoked from selftests build, where srctree

-- 
2.34.1

