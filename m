Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7C2FE579
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095052; cv=none; b=ZC7J0Yq3X5Sw3MNNUjTd3LNuy/1hXJVGqdL/VURDONehj1J1mUT6LP/+Jd1hUFhyT5GkPMwkoqibGDUvgdp2SjacbZjALBGbNoDnvgieTfjuOvXgNwOp6/Y0IldSt4z5EL8MpEWhQxNGn7Yk34NBcJZnDlaB1xNtEtezZAZ3aeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095052; c=relaxed/simple;
	bh=Q8GbrG+ClCg94DgU9vxRlD70lv5DVCRruYHFaOZIxRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CeV5aztfqhEUwnT6YzKYX+u9ikDUxOISyD7wIKGlclQLyihQTCwMeoJxJDVBqZfCdZRJBgUHVU7vYWhMV+jKOUxkuIkjxkN5Cp8fCrTb8OW41hE2DOu8eUwy06NKkJWSWEPhTxD2IvLjqPCHXwlQ5aumbf9MCCIyMzz69HtiF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rxBNZk5s; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxBNZk5s"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44e5624c053so1080532f8f.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095049; x=1779699849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQsc42ku8RRwWOrN3cIN44IoeSXVQzXA3f6OA5chCWI=;
        b=rxBNZk5syvkO/IJ+yrA1ptcHiceBicKPbbTvXglLWndNUAMDvW5TFkLAfWkXPfQD5i
         Gm6m76otuwBrINsMN5/nd89drWEogOVRiwROzV5RZIHs4YTYU07W0SE9sFbE12CT9khH
         hS3ePx4wivzdvbVPFcCD3IRru8p9kL/3ofy32TSejawd1e9euq65oesnkbI5awAc4bJZ
         JKj4oVWKPNswTS9zwiTLll6efUGhuQbDfwLZljs3caykCWdFZk9Tbkk4Qtrwt1gEsF4G
         0/jLXXbpcdgi87OxO5zS2k03H39ZzQDtACh449ipI1IC4O/KNsPxwJv69L9+XtbkW6lu
         Ypqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095049; x=1779699849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQsc42ku8RRwWOrN3cIN44IoeSXVQzXA3f6OA5chCWI=;
        b=SEtgOG0sWs+rNttZYE1WwjViarR+anHyzC4YqvOfLq62VnEja3DXfBj7kg4SIDmKJU
         Zz71fomw1msrKOPUGlXgRp54zr7QyT49qQ/vxZqZnkVVx/NlbU5a8qn8hDJUqV03Nzo5
         G1kyzjAVvY6qiFbkFlJ3XmAZK57WOkADiMcTtCe6SWMyhxjxXTIVN/L0cfRfeErG3zeJ
         o4T+ToJNWk9oyiBNjQI73zubSJWKo0lAvP9J5wDzPItFk77sn3bF1BDJXENxNaT6KaGo
         vtM0SDmxvwjdHEyvNB13efC5IYreFbpF+OfD42laONio1UoRtt1n7iS+6l5nJE9jxFHp
         AYkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Kcm5SiUqYBDQVQcIr8nswv6WwO2uZ2vOblgK0bqU4WYSNLlWAUns/FQBtn0ItCAzQJKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHI2nY8WVgYPA0nWimg7Xe7W4Ux/18yKzkB9ENOavAOwCUL6Wg
	dR8ab2CjdXTqUcrOdXg0bjd3Qx7H4ZzjgYzlAg48kcyyPRZf7E/qwniKoIaclgHonDs=
X-Gm-Gg: Acq92OFMJ2ELoYw0jz9eM+C+qpnrpR4zRQesvU7ridt+rWDdbQt47M0/OniDiXwAdmT
	JsZqpf57ElZT5LTDfk5g8u6X9CN/Ar/AOLDKM8WX/nWh6Vb6itSCJBW/oNBFAsu2uuN9Nwl9fSc
	QbtyAIcMTn9gKYlm8gh/mMcp4cM25+TbEGrxAM3lNqFHYcZ9eGw/9IEiYSvez6RtC0hNxkJVVG/
	HfZNo8BCHyCS07r0X3fHaxH4SnqqaUJGQ0mzPn/miBSNWjDS3/3Dv5aTgj3bBGF1YwmqBLaHwWT
	x5Y0LfU8sDf9xWNhmMI7lND12UtZQcL4YhGX/6rgRza+7voULfFSCYKVX7/FcBwqfftzBXPFclw
	U/xBhADuT5IsiDiodvwdInw3oTQSq5nYYgaB+ElRnEymvuTslYfiBx6Vco+udMeeJDz53uhM0eH
	QhhIJ/WeOcb1rlYuKR8C7P8dMlHvOK+Jal
X-Received: by 2002:a05:6000:2902:b0:43e:a81d:c475 with SMTP id ffacd0b85a97d-45e5c58fbf9mr21710267f8f.6.1779095048668;
        Mon, 18 May 2026 02:04:08 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35084436f8f.5.2026.05.18.02.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:08 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/6] tools/build: Allow versioning of all LLVM tools
Date: Mon, 18 May 2026 10:03:06 +0100
Message-Id: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMvVCmoC/3WNSw6CQBAFr0J6bRsGAT8r72FYNEMDbYAhPWaiI
 dzdgcSly3pJ1VvAswp7uCULKAfx4qYI2SEB29PUMUoTGbI0K9PCGHzSyB5n1haHIYwYWDcH8xP
 VxtZFbc8NRHtWbuW9lx9V5F78y+lnPwpmW3/N/G8zGEyxtGQNXSm3l+Y+yETqjk47qNZ1/QLV3
 2IAvwAAAA==
To: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

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
Changes in v2:
- Fix selftests/bpf build. LLD needs to take the full path to be used
  with -fuse-ld=
- Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org

---
James Clark (6):
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      tools/build: Indent if else blocks
      selftests: Remove unused LLD variable
      tools/build: Allow versioning LLVM readelf
      tools/build: selftests: Allow versioning LLVM lld
      tools/build: selftests: Remove some duplicate toolchain definitions

 tools/bpf/resolve_btfids/Makefile    |  3 --
 tools/lib/api/Makefile               |  4 --
 tools/lib/bpf/Makefile               |  8 ++--
 tools/lib/subcmd/Makefile            |  4 --
 tools/lib/symbol/Makefile            |  4 --
 tools/perf/Makefile.perf             |  7 ----
 tools/scripts/Makefile.include       | 77 ++++++++++++++++++++----------------
 tools/testing/selftests/bpf/Makefile |  9 ++---
 tools/testing/selftests/hid/Makefile |  7 ----
 9 files changed, 50 insertions(+), 73 deletions(-)
---
base-commit: 09d355618f7ccc27ffc7fc668b2e232872962079
change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d

Best regards,
-- 
James Clark <james.clark@linaro.org>

