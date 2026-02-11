Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA633F38D
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833572; cv=none; b=f0PCLDq/bZhyKUWdY7/14aKXj58C54qZP6UngoRxrJsmDqSfcZ9UOhW0PkbjeJULl4EnfTmZ/+c2cIPenhgjlaFFxw0YAvJmEHWHDJrV/MLw76MyqOdNzmBO4tCXgovPoh6LO0xh4gWmhQ2I24+cfPajuU07jKoQCZigYuB/v+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833572; c=relaxed/simple;
	bh=+FImT2JqL5MF2aTFK+gy7xnXT3pLCCaWkicQk8bsRdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6Uto2AUeS8TsjYweP0qlteNCiU0I8EIvz92V6qoD9V7VV8YWwppuCL1pcZhcS+zzuol5axFJ3anvasMFyL3B+0iZ3VWa7z5H98pJoi4kvBw7ZMRbx/A7/2kUg1/n7Q30zqA5KH56wZWWtGb15JW1/iNCdRa6H5NxZHLr53CYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OojrPqEd; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OojrPqEd"
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-6726f320b4fso1545069eaf.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770833569; x=1771438369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/bC2N65B/RP/RDL60qo+MBcjz1FPAv0fayDtbaHq8U=;
        b=OojrPqEdChLYU48SxvFaMO609I7oK2YGSNyy6ZUGuQnynjtV+votEbWGcbhFfMWGTX
         ulFBL3WaKJ7D2SWzRuefHh8jnCOUOHaY/l8XaQdgS8nVUOVBCEHHUbrtU+Ysihtm1kdi
         g9OSlW+C4TEwoFBVn/IBTm2yqchxZVg4Ibwx/gpWCetYlkDnum+GtmRCIZb5KQvUS1wq
         r+7NAsKK29VLZredRh0onJ9HswMZLPqgBfLd88DMnNhyxatoDGeInBvLl0SX+wFaUehr
         KY8RTHL/p0Bj6S5Wb/nqLTTQySiW72OnOEf6PqjdnF6wNWt0Hle+fRFOsgpZOC9+Yoy3
         abMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770833569; x=1771438369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/bC2N65B/RP/RDL60qo+MBcjz1FPAv0fayDtbaHq8U=;
        b=u9CgQRUxoFysolOb9zFsXZJjDyWHOGr/c72MoqUHSZJo1HCaQicOdV+p3us/rN8Cke
         b5oXIjd8gGJjnIxiHMxfUCOftojz7P5El7KDRf2HLlmSs2pbf484PjcIzuhFTU27YnIn
         /sR2synvHVUW+SxsUv7CfTxUge3eGEQ+yLqb5gcjhTXAroucveJZQCeTiw8Zb9sU5/NF
         uTe2ssYcVlbNil6/KFamrip8fkcFzIp3lvXIIrgzKzKf0tOi1LwZIheOxo+9BjAtS1WL
         84yN7obGNwl9mIBCy55ZmP+FMvlQV8BPVUnkVakBo4Pyb5QjbPUIvci94ySwTsTRRyAA
         uOmA==
X-Gm-Message-State: AOJu0Yz1sIHVEY43Pn96uzpKEyPzE6et0DDghO4PMpG5JUpDFwgecN39
	TvrTP0B+Wt0nBxK+XRfgelV9xSvR/RGx1q18lfAbSAkaJTzfLBZjcudzr3TiYMKi
X-Gm-Gg: AZuq6aJ59w6Gq2vY8Q/CqlAyDJraMtJsoxdhvQbvExPPxm6qri00D9jjoE/4MC/4Qij
	qmwCXcIgR6cNBT6dA+2MSMxCReD0/in1WJIN7kL1QKgHz9ZiXzvpTw/TCoocyq7awCuIGT48JcD
	DqI3T9aj1W9YgoJ45L9KzEl6bnPRaQhDzhrMoa+sse9wChFGFOYs8kPPyYF83/YKWi0iMdHjXK4
	oNuMoWeTYdqlfdaFlcxB76LOaPrmj30CEb4sYR6Noo/1+i3S7FatAbrDLs9DHflFo67aUfA6Iop
	KZXYRK0wqycjmYhkRthF/JTS3kOoxssHC1BZBNGq7UCrxbnjnWeWWdrjwR/uT8y/AuwCS972NxB
	HIuS/FV14Af4e7LmtTfyBcKzxh/0Oi1cp0SyaP4dYJ9gCP0V0Wk1inAfCYbI9xs1WF1X7Yzlb/T
	A/aeso47uxGGzH1PW6uNjBqGGQCl1jB07sf5CoP5Xb1QHXQPBiXNiAnBc=
X-Received: by 2002:a05:6820:987:b0:663:c86:e9e2 with SMTP id 006d021491bc7-67598a3d443mr46947eaf.35.1770833569354;
        Wed, 11 Feb 2026 10:12:49 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6746fa59538sm1146330eaf.0.2026.02.11.10.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:12:48 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 0/6] Concurrency Testing
Date: Wed, 11 Feb 2026 10:12:40 -0800
Message-ID: <20260211181248.3040142-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; h=from:subject; bh=+FImT2JqL5MF2aTFK+gy7xnXT3pLCCaWkicQk8bsRdU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpjMUeaCOTry/q4Rc/4C9GEq2nkJ/Yn8H5pWKtI2Zu B8ftcbqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYzFHgAKCRBM4MiGSL8Ryo1OD/ kBoc3VukS9uFyL1oi7lsV7u1LWl+0OG8y4AnrZxEP8R92VDyRqiS4Sz3aiLXa9K2sp36CY1CGjsPrG mFYyGAr5ZUjen/jV4xIkZefyChcIDSvGxWoMMzNqMDR3wXjBSZABBKgScz1N+tIcbFH/dJWFiEaqE4 OGjfccgO09YvgXKj8FE55PFGpncXxk/GTfNaL9D++Pfz5QKC0ybscG8iHx9E/OuGYwRI7iyfs2dQth N1KADm1EwfFe8NqvDA1qnIzcgYW9cXT8FDeFGjN6QnAaBKdBtDh1oT15hM/9vYghoiiSBh7NO04eBA qQ3mB9CZIT8oJBq6sUWVrX0EIueA1RH2FNGyfJn2Z/M31V218Byfj9pgLDgRxvUcgxlt8bjPRrMZuw PjkCvJiAUJl5rtCCVdXhXZNcFTsR/0LNgdgUQV1vR71pAwPAh8BdxCF2v+apO8xfvEehRHP7qy7vyv BhXiaTHU1LcGtkZhpqRI21SJgsiZqMDW2c6msffujP+7Cjfpg3VGJ0d7kznlR5udw/0y4K8CxTuYwb OHyXhWB/kIq6x8yu5u3Yv/B7WJDvX56m3HjAN/inMT1KFB0zxpG49R3XiyYDov+ILaCljdxcjYAEmh v9jcFqdgZD141tJDjBGsR9IWcrH2wHoC582B/g49utSRK8me4i8AsrGwDxbw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set introduces basic tooling to generate more exhaustive test cases
for task<->NMI reentrancy and parallel invocation of various operations
associated with rqspinlock, timer, wq, and task_work. For now, the
approach is simple: test cases are generated up to a maximum specified
level of parallelism for the operations to be invoked vertically against
each other (on the same CPU, in different contexts), and horizontally
(in parallel). To cut down test time, similar cases are pruned out after
generation (e.g. start vs cancel and cancel vs start in parallel on two
CPUs are similar, thus only one combination should be tested).

More details are in the commit log.

Kumar Kartikeya Dwivedi (6):
  bpf: Support repeat, duration fields for syscall prog runs
  bpf: Allow timing functions in lock critical sections
  bpf: Enable rqspinlock in tracing progs
  selftests/bpf: Introduce concurrency testing tool
  selftests/bpf: Generate various conctest permutations
  selftests/bpf: Extend conctest to wq and task_work

 kernel/bpf/verifier.c                        |    9 +-
 net/bpf/test_run.c                           |   92 +-
 tools/testing/selftests/bpf/Makefile         |    6 +
 tools/testing/selftests/bpf/conctest.c       | 1110 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/conctest.c |  758 ++++++++++++
 5 files changed, 1955 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/conctest.c
 create mode 100644 tools/testing/selftests/bpf/progs/conctest.c


base-commit: dc855b77719fe452d670cae2cf64da1eb51f16cc
-- 
2.47.3

