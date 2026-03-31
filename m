Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED93D7D70
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991425; cv=none; b=nA7ru7mjLSAJ6vAv2RwqYwQ+HAMoaHHGtzV+lq3x/18mWjYxpHKvOZfNTGd6lx2aw/2/NZDFKMsMc3UXQG7mwzf42Msp1kwx4HhxMFygn7sT4PaeeRKnsErkw4NnM5zZeqTtAyaZvkE6WsgnzGl3UTPmQ4j83ydiQv7p1vPbnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991425; c=relaxed/simple;
	bh=OY70uoc7RiFOagx405ZXT7InMeMHtzx91SLAYdqX1WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMWWdGZ6gqoyerV8l5eBcxcQoIofo8O8DgzVUDFE6GQ+9UrgX6coFRSeeb3f5uECAYdeRvBLbc2ryNHdlPdWa4c7WAebXjos76XI1F9HgZq9dN4cOM2859K4nlwJnGfJGLH+eYpTf76mSrw3XrwyEIejCrG2bzLPf1MpkMOjXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPM1Kjoo; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPM1Kjoo"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-40438e0cba6so3864706fac.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991423; x=1775596223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1sAj8CCT/s5ggL6zXt8KmHXWQeiRdVvo39huaDJ85c=;
        b=bPM1KjooBiNhPB8a/4bjLiyUCX//nVJ509rORrEfydNTG4Kpq2NGmt6SED+kJXMGY0
         3FXURzZC87CJEUTsoQrhi5A+6lADj4dr86KO0z+3x0eJIvVLUnaMMk4efZY9oNvxqGR4
         P+MglTBK2XBluUBZOu5X/ibv1Zgb5s2yTZsWNwJbpIfuWqgtlJSrAHRd97kqNjkcumY+
         DpFJPNm/zCNLhpied6ypLAGDPrw+4NlhDyorT0iJTL34T/atJJL04ZhmjOcccZ5ei99D
         wPsP6/+b2Ra9JDMf462jLP6F1lS/sk1SEnPLrFARGSFLGwb5OOeTGoFURTiuIQpeh9w2
         zTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991423; x=1775596223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1sAj8CCT/s5ggL6zXt8KmHXWQeiRdVvo39huaDJ85c=;
        b=sreEfXcGlphStHaBTvB3ghJUz4vfTHBk6imJpV0FlZiuN/xR0EUwexHcaGdnwKDNtp
         iLudYq+Z58jK3wpJpv81vFa+VDaABp1/2xlzhkr3/c63P4d3zJfvcHulDo3ZET6jfceT
         bEoAmh5v7zRV10VA2abqmoRTTyqNYrHi5jeS4PM9pbZmHUqyWigf7UkFsNeT0ZtLrQaL
         Fio3ypj1Ex535ZxjXt44WTmm7E8u2B7JCHo9DwjzcE84s559FLxOphBE7ZjweCh5xDPh
         el6xoYCGz8RmnOpq+MHnLKDrslekTpGMgB443Leskf37vn7VKxkFZDWkqP0MdoHrk7/u
         xU2A==
X-Gm-Message-State: AOJu0YzNUJ+j9177AUEjzaT1m3zdc0zQBeEWTysXRDXc8V5pwMQLE7Pc
	FP9MdjN2ZULiJcXU7GGTFnYXlYHhyeu6SMhtpgM31Thxs3ymK3IkE3tL/pk8Sk4JiZU=
X-Gm-Gg: ATEYQzzTt+efAGG7sJTjplZAVHnYOlQjJ65VMtbF5r/vngLLqQ4hGVLWQYfjfdnih3c
	2Q2mf8dRQWd6bddaBAthCVwhk/x6ypnCGYLtlJvJYfQW4GSVEQ31N+A1MedhwfImnK0VA+sG/LC
	iccwC3ff/YIEIRePrxDQRwSO4oR/RduNsz7SFUCFJACKsYTuQviyXnfxv6TOD0/aImbS6YRUnx2
	TsRt8QVdBRInXuOS73l/vnGeHxcos6LCpxDuTDPEv245q1GzCpmkkDMFKi58YSsGGREKrRrIaqM
	N188n5cVeSVBq0mZoCrveFsbOkP4zzCxhoOYt97O4Sf0VrlgaYTnauJbEMZpqyu1KTzjiRJ0jZU
	3o27WNusMEjf+G5JMr7POn8qVjSPjnFpaUWFekd40c+0+B6+kKfUZeVGAdhLyPsogcu4DYgdOlI
	DRgAAKUYNrOFzBKe8ccZIpXsCorpP4WOODXr7c22/iv1o=
X-Received: by 2002:a05:6870:9599:b0:417:565d:e3e with SMTP id 586e51a60fabf-422cfbf1a5fmr789753fac.1.1774991422762;
        Tue, 31 Mar 2026 14:10:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d0494be33sm8027334fac.5.2026.03.31.14.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:10:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 0/1] Fix bpf_link grace period wait for tracepoints
Date: Tue, 31 Mar 2026 23:10:19 +0200
Message-ID: <20260331211021.1632902-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; h=from:subject; bh=OY70uoc7RiFOagx405ZXT7InMeMHtzx91SLAYdqX1WI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfOM+f9ZniFNfJ+Nlhwzv/Lz4pekRTumOTKpqJSqtpVkH3sk o/W1o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPhVWT4X6jycC5jxoWqnEZTJZOZPB wGLDG3ZsqoXn7IOuPzPK/Hsgx/RbbHCe5al/PDf0UJ3/mj66eXJatr7NaY63leSqZEcMMLRgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A recent change to non-faultable tracepoints switched from
preempt-disabled critical sections to SRCU-fast, which breaks
assumptions in the bpf_link_free() path. Use call_srcu() to fix the
breakage.

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20260331005215.2813492-1-memxor@gmail.com

 * Introduce call_tracepoint_unregister_{atomic,syscall} instead. (Alexei, Steven)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260330143102.1265391-1-memxor@gmail.com

 * Introduce and switch to call_tracepoint_unregister_non_faultable(). (Steven)
 * Address Andrii's comment and add Acked-by. (Andrii)
 * Drop rcu_trace_implies_rcu_gp() conversion. (Alexei)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260330032124.3141001-1-memxor@gmail.com

 * Add Reviewed-by tags. (Paul, Puranjay)
 * Adjust commit descriptions and comments to clarify intent. (Puranjay)

Kumar Kartikeya Dwivedi (1):
  bpf: Fix grace period wait for tracepoint bpf_link

 include/linux/bpf.h        |  4 ++++
 include/linux/tracepoint.h | 20 ++++++++++++++++++++
 kernel/bpf/syscall.c       | 25 +++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.52.0

