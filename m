Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937F320A0B
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112616; cv=none; b=Ig7EZ8LxVtneAxHhAZ/ABnQOuhjHH9/nKSsErCsBr9hlYQbrGnKvg55Uy2nVkXJApIeoGS26yWrMS9cAXc5LXqxq+ESGm0l5nkuiF4jsVFN7qzoLteI/6VdV9KtVs5IVmc3MmAZYrPHohZCCSIYay6OjtOdD3N6t0fMFaXle/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112616; c=relaxed/simple;
	bh=3rSHWn7UoamPGnUOn51s/hOG15hAjXMkfMfbj1N50IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFC14nU+P7MxZ1iPQrKaCp/7DDvq93w5qwWs4vrmNPhjT8sD2blbeQFr+2DfHGAWGuNLg5UNoG66dSKGSD9aIJ6BlHM5pX12P7WNuoPWeztMoWcx+KGdqGPbEP7jQyG+NeA4zPu97AAySAUbd4n9UPv3QQWZjOslQZK2/p15aYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEJGuH3n; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEJGuH3n"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so196167a12.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775112615; x=1775717415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3ehP84OFtuI6XEmihAzRt+4hndxck44CHm2feI8rsU=;
        b=gEJGuH3nWvM1JPG+nVXnOlJl1RB9KwUWRVs3oO4CW9cFjS7E3MR+Rq4fsE4eq3137S
         jyLy2IyC+8rdUovoHOXXS410Rq2xvMlTUhWXr3eYazy439sPn1qASiwEE5NzLs3YZQIQ
         JEW2LjfroqvG6AUEZs7Vqi2cY+rltsZZheRVg3e99VEFvY/jKxz3MZQginXP7YNofgzx
         g04BHd9A1pFhhpqznJ4Isq703LTtaKm8Vl9WI6kS8MtlkfZBWbrjZQ42QGI+t1T/aGDD
         5Nv9YLCYBsJVHRbxEC0eJ0Xn0zC96+kNhfOdr3cfDaVbwEpGzwIcw9nNshSTnwfvPU1q
         FeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775112615; x=1775717415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3ehP84OFtuI6XEmihAzRt+4hndxck44CHm2feI8rsU=;
        b=Qxg8MbDMSbeHyolnecEl9gGe+m3mF6o0M+P24htivLbOlEyw/FuZspgLoOMWSR6zNC
         Q4+0BKCm2UWeq8jQ9C0CXw3fpNn/oqOByV9W8WBjvdyv+gftfU+DdaKwkA2WRBYsRCzH
         1x+kFm7Z7yj6q8bAobwUFL7kxsbILzAAWVrWi50CQ/OGwnt5Bjky2m9SiW86/5ZxmBS1
         y2oGRnKa2Q9oIwgH8zDR0YQOStSODLRJhDFgjDZr95anS4mogzKOchX1bMWPvOJ18IA5
         y184wIQmL1DJteP14BdazH7+/rqDlOF1izbzplVX7GXWl/UZ4GUaaVYOPvEOecxSQvoV
         YXhQ==
X-Gm-Message-State: AOJu0YwkNHriQSFIstz43+lZi4SGYxAd8KkzClT5rF5WTtQjvCkcAJIU
	Sz4fAiuC1fZp8mIOlAkMn92Vei72qg49Tqu32eY3do3O0E+2hsP2176I9fWOaw==
X-Gm-Gg: ATEYQzxkB9h3cI9noPKi73Il7VqgikN852vBHUTSQZV9QEagfNE5IdOS3hHZQktqdg8
	0Gc3/1uZMac+AKx3wNolbsqGALerU5cEcubJK9qiG7UJmhBRMX9blSVx6MD+yl77b0/+YHTGCj2
	C4Duawc6WjUMV8BapVU6/1PiV63GkD5zUJZlRiPGRd3I0S4+y11cyKphSVRQI2gJb3DFWF2mV2B
	QrvSjbiZ/88V665tpkaeCE7f6Vxmsdr4Wq/Py00PIxr8gcvaMLWYwITIBRXbIjxrAOcTdBnWFZ1
	1TH1MLHXzWfTMcK6qS4lFAY87Mi2U14ybUaxm6TTWbMB8ynA3gW/2mUNXB3XqaOJ//HNwYA80kc
	g/AXMWDrimryZxBQU6XRfIeYzFbAq6S3WIq+gn9Scbs3CVZlbqXwO+Z4P/owgEJku5pnnMKhYK9
	4pHKbwCNQr32mvxQeOgcV25Mhj
X-Received: by 2002:a05:6a20:430e:b0:398:9fc9:e077 with SMTP id adf61e73a8af0-39ef76b219dmr6945402637.29.1775112614563;
        Wed, 01 Apr 2026 23:50:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm2444820b3a.41.2026.04.01.23.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 23:50:14 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	eddyz87@gmail.com,
	yatsenko@meta.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/1] Refactor dynptr mutability tracking
Date: Wed,  1 Apr 2026 23:50:12 -0700
Message-ID: <20260402065013.884228-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A heads up that this independent patch is separated from the object
relation tracking refactor patchset [0] to breakup the larger patchset
and make the review easier.

[0] https://lore.kernel.org/bpf/20260307064439.3247440-1-ameryhung@gmail.com/

v1 -> v2
 - Change the definition of the mutatbility of bpf_dynptr
   to only bpf_dynptr->data instead of the whole structure. Basically,
   only care about preventing passing CONST_PTR_TO_DYNPTR to arguments
   tagged with OBJ_RELEASE or MEM_UNINT
 - Drop MEM_RDONLY annotation as now we dont care
 - Drop passing CONST_PTR_TO_DYNPTR to MEM_RDONLY kfunc selftest
   

Amery Hung (1):
  bpf: Refactor dynptr mutability tracking

 fs/verity/measure.c                           |  2 +-
 include/linux/bpf.h                           |  8 +--
 kernel/bpf/btf.c                              |  2 +-
 kernel/bpf/helpers.c                          | 18 ++---
 kernel/bpf/verifier.c                         | 68 +++++--------------
 kernel/trace/bpf_trace.c                      | 18 ++---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 +--
 .../selftests/bpf/progs/dynptr_success.c      |  6 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  9 +--
 9 files changed, 51 insertions(+), 88 deletions(-)

-- 
2.52.0

