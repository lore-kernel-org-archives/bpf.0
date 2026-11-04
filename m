Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766633;
	b=oFyO/JjD88ttQZ5o9rRKfhcbtB2usBe5bNf0X+0phdJDGmHU1I3d2LkhmoKR1U92g7dn
	 nt/rhA0W4Wb9IcwkUEw6QEA9BJAUIO+QZOhxfseUt3qx8e+ECEXLTLHLxIVy9CmFNhalR
	 5KBD8H8nsOZXovYIAANkL/WyUboChYSa0zwYiONI+Y3wYhpBRNKr/Sds2p6NOR/2c/aZr
	 2hhR8biwMXdPm4HlKVyRpJoXjjfQYFa6W1lPPnDdEGkNSpVHRs2UESs0W3of0KvCYddzS
	 F5/hI/copdbRenGuJiDWW/dBIDWJVSsuScSOvPwSZmYRLzaAG1nF4kKNrXUbuaCaAvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=R5o2Iu/yXeZ9yHPfDZ7BM2KCdl6HYBb6HRzd5rwljxg=;
	b=JlFewK8l0PP+iH5zwHxhlIjfEGG8nQgIaC9+g16hqDriRQ5fWEhvnPup+5y41dgNee6f
	 TQ76Z/vgZw7E3YP17FETB4y1L9qXrI9KEobaRInR3AL1MBgER33nPFZYixTt7RYcjMoPH
	 HvVB1utXL3qESBaUFhLuvLV697RAy7ZDRqEsPJF8th5/IIog2FZThtAKQaxVLLZO9CPXy
	 wGysIB/byUGEpPM/a6Ccf2urU6Ldd0AufB1uCC9fh6gMuIIqfsVnkAKQOhARQSS5njZ+p
	 AB7NLPLnF4YUaCpCZSXB3r1mrRLSS07SLOyDFhDsIS5M1jEiWMzSByBCI2Jq190824g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pcsCcJhB;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB71C606D809
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB71C606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pcsCcJhB
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1acbaf81bebso489256c88.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 20:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766629; x=1794371429; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R5o2Iu/yXeZ9yHPfDZ7BM2KCdl6HYBb6HRzd5rwljxg=;
        b=pcsCcJhBlyEVAlZIjz24DMsOqMTLI+S6yqIyeHhH/ox7IE8tNDJXktryoAzWfDY4pz
         ok+BMCsqxm/4pSyyypPHPDChfclKFCVOKGNj/Z7W+I00U4zDusHLzWJpj2CtQnot+bIx
         mBZ9WjO6VbPFARe+SC6DbI3ywJsSFnB0M3z+Quxvb7BdqD00wndXpjbPUv7Sl+ViyhYa
         tgWWRmS58PYLa5U/US3ZUR4syBkmNwA5LvgMxCax/vupI2/Gr55X2aPl+eEO7U8xzoDt
         DGYhTFdi0Xb7LZzElpC0kWM3YMyiAkSCZLVQaibyFBlGTz04Fgha6Br3VV3cXE0FBTgz
         Y3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766629; x=1794371429;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R5o2Iu/yXeZ9yHPfDZ7BM2KCdl6HYBb6HRzd5rwljxg=;
        b=HeJGL3iU1auaisCpCQDeZsMsu5cvhUdkvt9+udtSB8gIDMWvoMamM/8gZEJM3xll+X
         ekKwOuvMR9Xk4bYYVwKfwmGAyzUNhXGqRrd5hru4MiyalYCI/k02QQAGmkoiyIuPqR0K
         JA1LaVMVwrp/htWl+HdVBDAI9PVYEAVYG29HVz+3/YEkU3kR2os3iyDd/ohrHXjNN+7m
         WVYENviTcJTHWjCaRSp0EFmd6MAfxseZwjMbn12GiQmCdV/Llu/mr7S2xTA21Ebl06AN
         vWhvQTVQCRlvGJStMsxfVvUZlXK22ZF9bF8738nnXC5oCVg8Y2MAXqmwZIegNfxZdzhb
         vMIg==
X-Forwarded-Encrypted: i=1; AKwUvBxsU25uY48A4jcNl3JNQEDPnMlhU7qPOGAbWR/GgY5WYTAmaqaVDkGyY9ax3z1e1KBJOSg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jbwqvBjb07ZC5pcB9fAB+FUTM4m6p0UgS7LyJJIMucXrT49Qs
	RWHcjpGTz/LOBzf4pGbWXIGrbwWhaBulqgjcHy+LItqmL3wF79HgagCr3kcQ5ew7Sr6gAObHxZN
	B2hRimwQv8Q==
X-Received: from dlai3.prod.google.com ([2002:a05:701b:2703:b0:1a7:6a69:e56b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2097:b0:1a0:b650:5c93
 with SMTP id a92af1059eb24-1ac5e8e1e16mr21701234c88.41.1793766628690; Tue, 03
 Nov 2026 20:30:28 -0800 (PST)
Date: Tue,  3 Nov 2026 20:30:06 -0800
In-Reply-To: <20261104043006.1199857-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104043006.1199857-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104043006.1199857-5-irogers@google.com>
Subject: [PATCH v3 4/4] objtool: Add explicitly sequenced -lzstd to libopcodes fallback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Quentin Monnet <qmo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Distributions like Fedora ship a statically compiled binutils libbfd (an
intrinsic dependency of libopcodes) that uses zstd to decompress
sections.

Because objtool resolves host dependencies sequentially via a manual
HOSTCC shell loop, linking against static binutils fails with undefined
references to 'ZSTD_decompress' unless the loop probes for -lzstd.

Add the '-lopcodes -lbfd -liberty -lz -lzstd' combination to the
LIBOPCODES_LIBS fallback chain.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/objtool/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index db99c4759b2c..238da6fd277f 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -81,14 +81,15 @@ HOST_OVERRIDES := CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)"
 #
 # When using shared libraries, -lopcodes is sufficient as dependencies are
 # resolved automatically. With static libraries, we must explicitly link
-# against libopcodes' dependencies: libbfd, libiberty, and sometimes libz.
-# Try each combination and use the first one that succeeds.
+# against libopcodes' dependencies: libbfd, libiberty, and sometimes libz
+# and libzstd. Try each combination and use the first one that succeeds.
 #
 LIBOPCODES_LIBS := $(shell \
 	for libs in "-lopcodes" \
 		    "-lopcodes -lbfd" \
 		    "-lopcodes -lbfd -liberty" \
-		    "-lopcodes -lbfd -liberty -lz"; do \
+		    "-lopcodes -lbfd -liberty -lz" \
+		    "-lopcodes -lbfd -liberty -lz -lzstd"; do \
 		printf '%s\n' \
 		       '$(pound)include <bfd.h>' \
 		       '$(pound)include <dis-asm.h>' \
-- 
2.56.0.385.gac671c819a-goog

