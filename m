Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668637DE8E
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512276; cv=none; b=uBxm9yoq6f2oTa/OqTkbmhk8N8hBzMhBf6lSaEvQLCcftz6keIhnoJSIvtjRnhZxmGWVksSnk38vC3yzmymVNGJkUttfCIq71Cwogv0GkdVTyP5yQrRc+5KFLCi9Nof4QMtaWyiVESxPb3IWcp5gl5Bd2IUmC3kuIH2GDy4CuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512276; c=relaxed/simple;
	bh=X1Q3PMwv53e9lLsaHRZbWssllqr/4RkmepUV3wjgX5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEEWt6X85C5BqMYibvMozImo07pKOxBRyLjjR9WcwxzG0DWerDweoZPG6CCBsPUt53YJUuoSJkwT3dX4mE2BTbXzJ2CEvO8fnf0Sjo8p8+oNwetC9axOX6ATJVAd3u7HCFUQ47mN98LNSID/upi/gAe/zEx6i5Oee8dHhv2YqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=s28rHQwq; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="s28rHQwq"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3dfb3461so524526385a.3
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 20:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772512273; x=1773117073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgtmeZTz/bf+RuOqRV/B8UIFv2zI3oG85FOGRkaUgJg=;
        b=s28rHQwqSxcVBtGD4Gk2iLmDYfj6HAwX4FdxEyriBjQjqx/aJL+8vFYIcVyFh/03he
         RKWAMg7yoLtwP3o8GO7QzP6u5TT1aogK7aCi6B7i68QrBPgAHXUW3KFCix8DMuIzmGPv
         S9OmAbE4VxCXr+1oBH0/HNCoX+mrauzocZELBcghepv6m3xrfKS/gVkEk116kjKLqJRT
         4+QuuegHXfoPTqI2U5oSOvuIIMw44uAKJJJDPM2SdhSnhn50MnpBJcn0f/qflsb2AuYe
         6IPfhSiUvnnDxOJALSiHo134nYAvrjNUMqBG4OUtuJyf53i2OCJz0I2nfTD9iEQygyR+
         PjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772512273; x=1773117073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgtmeZTz/bf+RuOqRV/B8UIFv2zI3oG85FOGRkaUgJg=;
        b=IIX/L1/np7Lzl+XJ/+m+Mp3z6q/5rwwB/V5thRxqb7M7i1pIhccB0UB8PMU1bp3YUq
         CL7O78G//W5IgZEQPnKRi+J71o7SAxOfz+aqJv9U6fuKFXOFuchreM2b9hnGE5Ts5GlF
         OLERnotOVa9xsX9RXEpqVHq5GOHenzg81Gb6kzVkS+yFS90LjgimUSooFvTPUaZE0r6d
         83l+Y47yS0mKbN5XpteeptlH48cqK/E0GsvbSKU0jrwZTd2ygFg2qOOIPgfPBliw1pow
         rLkiIPSoBofi1IVIhtbok9rnarVJVaV+Q3R7I1xkLPDPzilnRIVpm/+P/Hs3olStfeRa
         hSLQ==
X-Gm-Message-State: AOJu0YxGmMu4ycIvGDz5gpl43IknLUv5neRTkqEzoD+SZivxDYlWAVc1
	zVFneLVzlsATGSr21e4XmjrPnijO5zvHJalIRQ4rnfHIfzgl+n2XpETxvwhwdI58VU4/lXYBPDF
	cnqcWZ5w=
X-Gm-Gg: ATEYQzx7Y5adek8RUbEPuD36K0lsjvks7rGnWFfZ2/T/ziLXWdxDLfQMz+/Rp9YBLsj
	hWCuoNDLek8NEuuBd65NHLu97L5DcJoGrKlrHzSaUivBWfyCwOtLWVb7ubUqg8Byh/TuA14Bic+
	ZVD7g2FAFFooqaDsXQbWQl0qK//4xf00hDExgq8H8MnRged8nAIN4JpG+86fLl7aw14vHi0vAnp
	0Vjg1TZeLhQ+vNHTHcnjOVydFJ7dkTznHZuCz0kv2HU6AHh5+fNZbIMDmHPeAhjmIYYVW8zULTW
	33RBReL0h6g6rk7gwAuW/w6hjxLmWmLxOb4irLrN/xxAYJAL03NkO0R+aH/i7LvWVla3aXSYJmH
	IhmSCA55AKq320/R58WFfsngD/e/tOO8W29KjvwFJ5O6JgL3/NH010p4HjJxcBI2WTjQ54LOpj0
	T1ZA+XaOBRPL0EYIUzNmN+oQEs3Oxq7DPi
X-Received: by 2002:a05:620a:2697:b0:8cb:51e7:411a with SMTP id af79cd13be357-8cbc8d99933mr1645442085a.25.1772512273333;
        Mon, 02 Mar 2026 20:31:13 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a04849cb3sm20876966d6.6.2026.03.02.20.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:31:12 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Relax 8 frame limitation for global subprogs
Date: Mon,  2 Mar 2026 23:31:04 -0500
Message-ID: <20260303043106.406099-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier currently limits the maximum runtime call stack to
8 frames. Larger BPF programs like sched-ext schedulers routinely
fail verification because they exceed this limit, even as they use
very little actual stack space for each frame.

Relax the verifier to permit call stacks > 8 frames deep when the
call stacks include global subprogs. The old 8 stack frame limit now
only applies to call stacks composed entirely of static function calls.
This works because global functions are each verified in isolation, so
the verifier does not need to cross-reference verification state across
the function call boundary, which has been the reason for limiting the
call stack size in the first place.

This patch does not change the verification time limit of 8 stack
frames. Static functions that are inlined for verification purposes
still only go 8 frames deep to avoid changing the verifier's internal
data structures used for verification. These data structures only
support holding information on up to 8 stack frames.

This patch also does not adjust the actual maximum stack size of 512.

CHANGELOG
=========
v2 -> v3 (https://lore.kernel.org/bpf/20260210213606.475415-1-emil@etsalapatis.com/)
- Change logic to remove arbitrary limit on call depth (Eduard)
- Add additional selftests (Eduard)

v1 -> v2 (https://lore.kernel.org/bpf/20260202233716.835638-1-emil@etsalapatis.com)
- Adjust patch to only increase the runtime stack depth, leaving the
verification-time stack depth unchanged (Alexei)

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: Only enforce 8 frame call stack limit for all-static stacks
  bpf: Add deep call stack selftests

 include/linux/bpf_verifier.h                  |  6 ++
 kernel/bpf/verifier.c                         | 43 ++++++----
 .../bpf/prog_tests/test_global_funcs.c        |  2 +
 .../selftests/bpf/progs/test_global_func3.c   | 18 ++---
 .../bpf/progs/test_global_func_deep_stack.c   | 79 +++++++++++++++++++
 5 files changed, 123 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c

-- 
2.49.0

