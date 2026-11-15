Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794725117;
	b=t+lbEA8lio/A82PGhp8suAsdtbVwiOSZuPz7F3X6UFzvxkyJbD5syd73bjqPOQKlaOdW
	 Kmq2xFKom8dwujnd3WxQRTejgeSbQfGQKbZwZdepFf0b6pPGjVYgB/cw8OgebMDIxI6GS
	 /Jn0+hwFAn0vp0cuYp9DZkfGvcZzE3uXTUSJjiIu6FFPiCqxJSFt/j0njaUUgWxd9SIOp
	 IOFiFNKF/tAHwXnqWrduLJil9N7soR6uRulrxqZCu/VJ8/mEMnfrOOapgusf6BNSlOm+y
	 U4DVPI4ZrPPtSqNDWzBDdWUXmgzjFvTeQMOxkqOybGXaNLw0+6WWCaeh9WvFdUA/VSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794725117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lfkn0hN6QzrTX68Z1qKlGmMDFllEj1OBByMdOUCrOIQ=;
	b=A5+kMrsVpPb3/UF8h8k3UeaIQTBY6XC5x8pXEdyPVLsgcxhKv0WltG4AAf8Tm5Hztk2o
	 1YcoALycndnt3PnJFRATj99PDiDayUiZ+gCR/qsp+s+KtYiPall6efbEiGusPKyw8p71J
	 3Ga8uVRzcMpOfweDbJIjDWflPRbB5zh7CnrueZTcJkcdy9xpF49tNfI1r2Vz6Ljv4pJcc
	 LKDOPmIXruHaWT1+b5LiGL1iMZntjTIyqu8AY0iBRrZ9p0a3YsCHhXtclvz4lOpRiDfWD
	 UZV+y1iFIcSRJZUYSu6h6HBMiMbDgJved/WiSJktvcioa0ivaYJJQIBOlIZJIPaxoIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uFgv0V9Q;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D98606A32C
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 06:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D98606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uFgv0V9Q
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso27629295e9.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 22:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794725115; x=1795329915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lfkn0hN6QzrTX68Z1qKlGmMDFllEj1OBByMdOUCrOIQ=;
        b=uFgv0V9Q+o4d+jQ9KvS95fh9NqdqYnK3mCuLWDTl4MlebLKKEduac76HxZ4sLldpgS
         r+qAuHiKKwtUrPO+Pno70R+lgWhyguc2hOkmIQ8n7ySIF+IfmYy2Q5EZWJkWCkYVHDEF
         g0uw0AgBVLMGuIvgeYisDXeCPiq2c1+MycL6Fowr/dhvs4X07Ql29JODthdYjp2Mf72w
         0eVtKp63U4rWpOPgJf2Q4L9+aXQg57gFpKGq1BJmDQHZaHPg2D0QVQgn1zxddk3VWltq
         hAMUjgXQ6EbRl8z0Lv02U3erSqkK2SVitv75qT+g0HqUyIBwjYaoDqj41gvtZb2MXC66
         6dUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794725115; x=1795329915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lfkn0hN6QzrTX68Z1qKlGmMDFllEj1OBByMdOUCrOIQ=;
        b=XSjYxCnpdNqAv5ysfkgmOh5W34C4fArJeFpJjX+s2y10Hv0VLDfjeAcXfWyP6UogbA
         FnCE+dMECrNQidNaqNcZU+OWQ1wNjLt0dg1gqDIUHXybaMRrrGjcvsFUc9XWAlqsOkFp
         hoBvi37TowoYKCSqoLQztC406anyMTOfp0szfSRHFOfVfiDQ+pz7EDKMGF0r5R2rvymI
         7PLGPaEXwJzoqExIrwfplDBfBvj8W/X+TBMk/nbGld3lzOZTvk1UI+TB5nUCbHHub8Ho
         /c5vgNMnPHDrX/JCCUXaMFPV6fAShrZu5A02CyisY5MWeGQwstW0Jag0akz7/i7cPvm5
         o6SA==
X-Gm-Message-State: APuU4Z9P4NfNP7FgjclFQlFEfBG5RLMK7ADy+MSIa7KqJejHeHZyMo7C
	jb4ox0/x/R4giIK4n/pxiR+5VsAIJ4uGtMzHR+oTW+r4EdXAygU3nMBCzQoRHg==
X-Gm-Gg: AYBFou1uFfM/5414nUkG5ql9hoYFKaTJORf6KuSjY/Xk9Yc0LPZTksV4Gn2TZrfqhef
	WmjVN+orw3Z20HG5RWpyj0jpjuwRN7ct7OYLxhjjGL4Z6sh8SuHPUjADVO1OFomw+EUvPg8XUK+
	27mZtA4RGxRszExtm5MZ/ACuCyAAOVOLyHXmHY1/wWu27p2//L/JvVTCXRifvi6z85XdHrW5GC8
	cTqWsllV5EYvyxoiISZP9/j3g/9a54KZDy9ybegttgEK+ZEePWMuWK5Ka7GMik4wMc7fhvIAgqS
	k0j12tdLEcSg4TgTvc7+nQpPr4gzQdIwLm/FF3WCYsfYB56lNT+Rpih0Z3V945pYMiELyvvWwGI
	dGLrhFA4NSQczxO7t0KGwl0KK/fRIpX1oGs9VuhbLIRm0IIF0t9KPGW45ELpv7hB8C94oSl6GYI
	luy+MYwBRLSiDV3jwQGrX4mf/ODTZjYI5rKS80zRd7fYZx2/rbjsoKhmq52+7AknWbL/e1nnp4a
	/gTUXUrBvP6ZmueF+2sz5ZMH3LrvKBVl/PFoz0d1An0OPLIyniwsuiSFHIt4/0A3BdIjVoF1fY8
	cTl06fWFXPMx1QUzAg/cLXWoWtBsct4wDwda
X-Received: by 2002:a05:600c:698d:b0:4bb:5de1:e92c with SMTP id 5b1f17b1804b1-4bb5de1f262mr97635105e9.26.1794725114755;
        Sat, 14 Nov 2026 22:45:14 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:474b:1700:dc0a:bc51:e26f:5cf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c6020bb0fsm14073284f8f.34.2026.11.14.22.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 22:45:13 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	emil@etsalapatis.com,
	houtao1@huawei.com,
	linux-kselftest@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH bpf 0/2] bpf: Clear invalid cpumask bits after population
Date: Sun, 15 Nov 2026 08:45:10 +0200
Message-ID: <cover.1794724099.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

bpf_cpumask_populate() copies the final bitmap word without clearing
bits beyond nr_cpu_ids. On configurations where cpumask operations
scan a whole word, those bits can inflate the reported mask weight.

Patch 1 clears the unused tail bits. Patch 2 checks the resulting
weight in the existing populate selftest.

Tested on 97d73c825122 (x86_64, CONFIG_NR_CPUS=64, 4 possible CPUs):
- Unpatched: cpumask/test_populate FAIL (err=5).
- Patched: cpumask/test_populate PASS.
- Patched: cpumask selftests 36/36 subtests PASS.

Not run: allmodconfig, allyesconfig, the full BPF selftest suite,
cross-architecture builds or a dedicated performance benchmark.
The changes have not been rebuilt on top of the target BPF fixes tip.

Avi Weiss (2):
  bpf: Clear invalid tail bits when populating a cpumask
  selftests/bpf: Check cpumask weight after population

 kernel/bpf/cpumask.c                                | 2 +-
 tools/testing/selftests/bpf/progs/cpumask_success.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)


base-commit: 4b4eb7f44ee05754339d07e9df649809f45d14c5
-- 
2.43.0

