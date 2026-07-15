Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA34508F8
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119189; cv=none; b=rLAXRFbyUK5h9Ul1rTKeuwbJOwR9Gv0m4rGSapZfprm2ji5hHeAcXg3qjAqawSuYg5DA0suRaaRXPeKqvngZsxoorA+dX8nX2cXGdpOaWQ3lN8TS59xuERFJVs5GpC87TtQPDr7wuwBTzbpO8I0HWN/bihhTCKextAqlgmaEBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119189; c=relaxed/simple;
	bh=455wlYCUNnMcrIdVi41A5Y7HIm5ipb4kz3mpabm/Y0w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MzZfz3mwyoWkWGRMQISy479h4WqHPqxIYqg3ZkWW9z+SP+bc78QXvV3ZfCbxBdPitadwKn5ZDrAuKKKohCZC+4uwfqIPGYAA0SAxXHfrwjY0+XRG3MRGCZ6Z3QyTohkm9UgnEPhnA5PfrLYJCdRUHybTcZtnHCwlAkEJLyAS6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kgncm9lg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kgncm9lg"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4728c12ba97so2504653f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 05:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784119186; x=1784723986; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pqmS0wGyyzISZUi2iZDsoqebuB59CdpacRLQw8zIRIw=;
        b=Kgncm9lgIzJm83nbLcjcEhzgHLFSmNh6ygNjhvozc40NOySKqDv5qn7pAzvri0uATH
         IbW/OhHugTXmzO7HNKN5clCWay4yXnzcdUYvjna7Q717ytkcZLEtBPX0ZEvum+ta3PpO
         Fm0uN+JaUr1gNI238ZSeVwmEUAg6e2QWILnnyFzRI+mh8U6OJY/9I8PXJTWtBMQSNE86
         Yo3x+AOH8bqQxITN+xzks4nO3wjg+c0nBQ8xb4OEbAWAcPXZon8BjF6e9h9ae1HvUNdB
         Z0/Hj27+ntGUDHg5cUB93Y7/q/1G7X4ar7k4Bay/jG97b9f8p6QsUwuBvUuncIwm1MwQ
         7F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119186; x=1784723986;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pqmS0wGyyzISZUi2iZDsoqebuB59CdpacRLQw8zIRIw=;
        b=apMy5M3y8g2CxlZzf49/9hAnNxSPu9mzPGfqwEUlkvP83LZdxkBBajR5mHWheQgn+H
         kxy7UtxbP/tefJN7c4+kGeilD6w7Pp2UJP0ZB0lUgte8SaxXHisX2nhDvRoKObHfECcm
         EBBV2JiOGNHqn/2BrlaseyJy9m7d0BU8Wd9+CAd4/VEnLtb/ddFwwSxplsOF3/5Jt6WT
         uUcci0p5uWuIkOB0v0FFDnIsG5i/bhVwdsTx34io9uhbPawrCwWypCMglcSFvB1tm40T
         WolIkpnrHy8EV0qOmN2hHyCh/IbJfCfjubblDJNDwFsgHW4Ej5856JNoJrOiOFyT4+TX
         bKzw==
X-Forwarded-Encrypted: i=1; AHgh+RpclBG7uUVW0T6zG5s38XZygSWFj0oHs8p5FW6azS8iK0Lxd67CL0ncXGdfmry7xklpAiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEFlRvAoDUKxhHnHJE/jo5fNeWOgtnRqzq+BZCFscR+ioBVrx
	Sbobe1suc1M34QqTZam1q1zzE2facp0Iq24phGRSmdGG62y3nRVUJ50L3mQ8oUN0DR4=
X-Gm-Gg: AfdE7cmCl52lP96m4XmtBT3PF7GwnybJp2rUD5u9FUDypRFPzfvNNvYMxtPih9lYWDK
	AoVSZreUIsfZKKnfMnhIOO0u1kwj/CdKzr0r8+CcKUN19sVk2jwM5N+ohKgNnRdA9BgZ7Ee28Ig
	/YpsklSmE5dPPKfahqVfBnrzGpMN21+ELRHd4PtpsU/KcDBIH0rZ9XPobXQfIyFaOhioYLBRw4V
	zYuv+dtkL3RJCtfEb7ma5+8Kl1/OsLS27YuVSrGDK33yXMfPcYNzeNwgVSKbySpnXiOA5l/whNL
	zheBE2g1Zr4NeLC2jHOo1XJu9sOTZUBuIZf3+xrgO4nC/8k07uQGk5mr3rZp5ZA5KvznM9Ln4nG
	RSSyWqjywfCLWbu6MVc3kvJTX+rsO7ofXq2/6TLfjia2TbW8lNi02jwwvGM0o4HZ4GrSgOY44xy
	cJ7GYqZzqv/Ye2lSMvf/9rE/l3SbIne2Vs
X-Received: by 2002:a05:600c:6a0b:b0:493:d2b1:48c8 with SMTP id 5b1f17b1804b1-4953c28b6e7mr23273595e9.33.1784119186462;
        Wed, 15 Jul 2026 05:39:46 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c710facsm32360695e9.2.2026.07.15.05.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:39:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v3 0/5] tools/build: Allow versioning of all LLVM tools
Date: Wed, 15 Jul 2026 13:39:16 +0100
Message-Id: <20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHR/V2oC/3XNQQ6CMBCF4auQrq3plILoynsYF2VaoAYomZpGQ
 7i7hcREFyz/Sd43MwuWnA3sks2MbHTB+TFFfsgYdnpsLXcmNZNClqIA4A892MAnSw3v+zjwaGn
 dcJXrGrAuajwZltYT2ca9Nvl2T9258PT03h5FWK9fU+2aEbjgJWoEfdYKK3Pt3ajJHz21bEWj/
 IWqfUgmqAGJqBqRg6n+oGVZPneZK28IAQAA
X-Change-ID: 20260511-james-perf-llvm-version-43ab1cb5bc7d
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.2

I ran into the build issue mentioned in the first commit, because using
an option like LLVM=-15 is a documented way to build [1], but only
some of the LLVM tools defined in tools/ support this.

After fixing that, a lot of other tidyups fell out. I didn't go too far,
for example some selftests include tools/testing/selftests/lib.mk which
reimplements some of the LLVM_SUFFIX stuff, but other selftests include
tools/scripts/Makefile.include and I stopped before touching the former.
Some other non build scripts hard code toolchains and I didn't touch
those either, this change is only focused on things that already
include Makefile.include.

[1]: Documentation/kbuild/llvm.rst

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v3:
- Add warning for empty $USE_LD
- Use $HOSTREADELF in bpf Makefile
- Rebase on v7.2-rc3
- Link to v2: https://lore.kernel.org/r/20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org

Changes in v2:
- Fix selftests/bpf build. LLD needs to take the full path to be used
  with -fuse-ld=
- Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org

---
James Clark (5):
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      tools/build: Indent if else blocks
      tools/build: Allow versioning LLVM readelf
      tools/build: selftests: Allow versioning LLVM lld
      tools/build: selftests: Remove some duplicate toolchain definitions

 tools/bpf/resolve_btfids/Makefile    |  3 --
 tools/lib/api/Makefile               |  4 --
 tools/lib/bpf/Makefile               |  8 ++--
 tools/lib/subcmd/Makefile            |  4 --
 tools/lib/symbol/Makefile            |  4 --
 tools/perf/Makefile.perf             |  7 ----
 tools/scripts/Makefile.include       | 79 ++++++++++++++++++++----------------
 tools/testing/selftests/bpf/Makefile | 13 +++---
 8 files changed, 56 insertions(+), 66 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d

Best regards,
-- 
James Clark <james.clark@linaro.org>

