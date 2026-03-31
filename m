Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7436920D
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977990; cv=none; b=ZFlxNj1lxaqJ1USUlO2OpF49eGDetW4nKIWyftd0g7whGVoEyy+gE/A+OUOuAx/BY9v7yoEGo5iBLaezknmTjAgoClyWHUL3qGGWtsRBYOVky4dWS+IyFBxzoKDluHhPb+cv3LBGjifg28K1Wx7GKRpQhe4qamFjEQz8UYv4ZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977990; c=relaxed/simple;
	bh=YtfmmfLG+2ewgvxH/fOf0OZ5F/moXk2qM02zecPoPos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LR6E2jKx6whwmkkbpuesi1jgX8+4E9+64C+N4PpAvjAz35kdXoKU8UZ7Ae/0dMs6eA8JfSPLTr7UVAXNdCwGxubP3lP4nQ/LCKwJqN94HGneqbvLThFheWRRyMTHuqVkFcOBxHmyol0iF2je6OMqyo9EnCJdack9zJpDUxcSYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbaJccQ8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbaJccQ8"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82c4b5dfe6cso2683362b3a.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774977988; x=1775582788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAM63G5G1UjPIWDKeBHJagpPv+eQOKOnpgALnZmbm30=;
        b=ZbaJccQ8kWVR37U5qH6S6XEthXmghtYEgfRT/NMM0lZZP/Y6FBug9R87MYOtlnjoyR
         eetZqwaHXGbHSRv+hSL0gQOkiPzxBJVJAYIR3sHHW5mhxp1p5RWrf4I8FcjbWz7pAMfr
         y1qw7w5/aA52vVoFan1m+kj2Rdts9G2hmXazjExCRqWf2TAIks1oKEObKhM0HrZIh0Af
         1HrBYqggPncIm+v6hWUBbgolEfF8/gcw/nOXxTeJTjKDHPUYrQVDL36Ps9cmaiCs+M9d
         wXM71TDJUG5GMqM43H6LuBqxwdQwVX7YJMOB+x+e3wIMEdhk/ChJ8p1e6f0QPYLFi9u9
         6qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977988; x=1775582788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAM63G5G1UjPIWDKeBHJagpPv+eQOKOnpgALnZmbm30=;
        b=AuRUpRYWj3LYcF74Dn2F0trlg/t+hQNyDnmCFbNmDuqLyRbaiAM9ulDsAPxyLsMduA
         u7yb5Nsp5L6B8UE6ZDc2ZArzs5aE1ZON5BMkaEhlISOm35rPzAMPg/V7UH09wHnyOyHZ
         A3G85U9xkjV996geWpsC2bGuoHp1Wpxzj0PSdpc9ZKVoyu31III4ci3VXxNrWrdrPwNY
         CXuTjD4wBIFVg+gnYSKAUntmBPi/nqw/TzvX3UYxSP7DCgmSqXgZQVQUz5EqtK/CFglj
         Wrfhjb5LHyWXx4XB7EuV0JV+Co4lGErwCJAPbIJYdq4eIK6jr578ryRyT5bXMhDYEPag
         S/LA==
X-Forwarded-Encrypted: i=1; AJvYcCXm1Uo5msRDFFiwEUrLtxGuk+uN1aZKPBp4xTb/5TZ0M8FYGSDFY3s+D4hGWzIneAxFl3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWBLCA+N/J25VH+svYG5WPFOTa0vkNop9OR4yimNeOCiDrE07
	CYG1LKCRNU2ssMBr+i/zYme9hEVHPvDIPB/TDW1orHYJRlPX33LchpP/8No7B1au6ms=
X-Gm-Gg: ATEYQzwiL8DkkAkjq/PbWc0jNWXcorm0KO93JLCudormKZ/zKm7bhbltc2Vi+/RZ/YR
	Sm7zIZsW7pSaR1hW39HVouYBngEDUcdohhao9+fbtVvjhmKQRf/dZ4zTTBdLQ057g9QI2/kkyHn
	j3fTmK90k0f0LUqYpNeypc4yCf/n6rX3l7Nej/zyYBxjr6tb+SfEabIHz/uauhPYPEpplz1XIOi
	I+1+jJDayZ+pN7OZNFBN08nQtyUWH4eF2s1/SpQ8Zz2UQndnKdMUDgWzPmv9CAR8iVk6rUAfw2c
	am6te0pMHu3DThoRMVayVifG9Pv2JEAHrRAwCLSr0mBbNdsO0rg2MORjdhcqpirpk3sGf02HJlF
	XzMaaco8icVB5CWHFWw5PS5Us770HOsPHTWKOCIHfq94US0E6iQfbCH7M9+CntUD55Yfk7GEzMw
	OY2EmutRCRhohuL+3YrntypLHm6uBFwrdkgvI=
X-Received: by 2002:a05:6a00:3c84:b0:82c:d7c4:4c6b with SMTP id d2e1a72fcca58-82ce88d81f8mr464631b3a.11.1774977988167;
        Tue, 31 Mar 2026 10:26:28 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ce713cf2fsm595026b3a.60.2026.03.31.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:26:27 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH] bpf: propagate ref_obj_id for dynptr slices of refcounted dynptrs
Date: Wed,  1 Apr 2026 01:26:19 +0800
Message-ID: <20260331172619.29837-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_dynptr_slice() and bpf_dynptr_slice_rdwr() return PTR_TO_MEM
slices that carry only dynptr_id but not ref_obj_id.  When a
refcounted dynptr (ringbuf, file) is released via submit or discard,
unmark_stack_slots_dynptr() invalidates state through
release_reference(ref_obj_id).  Because the slice has no ref_obj_id,
it survives the release and remains usable as live PTR_TO_MEM.

This allows post-release reads and writes through the stale slice.
A BPF program can reserve a ringbuf dynptr, obtain a slice, submit
the dynptr, then continue writing through the slice into the
already-submitted ringbuf entry.

Set ref_obj_id on the returned slice register when the source dynptr
is refcounted, so release_reference() properly invalidates it.

The original comment stated "packet slices are not refcounted" which
was correct for the initial packet-only use case, but
bpf_dynptr_slice is a generic kfunc also used with refcounted ringbuf
and file dynptrs.

  BPF verifier incorrectly accepts post-release slice access:
    19: (85) call bpf_ringbuf_discard_dynptr  ; dynptr released
    20: (15) if r6 == 0x0 goto pc+6  ; R6=rdonly_mem(sz=64) ← stale
    21: (71) r1 = *(u8 *)(r6 +0)     ← reads freed memory

Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 kernel/bpf/verifier.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f108c01ff6d0..937c9adf1b3d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14071,11 +14071,8 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 			return -EFAULT;
 		}
 		regs[BPF_REG_0].dynptr_id = meta->initialized_dynptr.id;
-
-		/* we don't need to set BPF_REG_0's ref obj id
-		 * because packet slices are not refcounted (see
-		 * dynptr_type_refcounted)
-		 */
+		if (dynptr_type_refcounted(meta->initialized_dynptr.type))
+			regs[BPF_REG_0].ref_obj_id = meta->initialized_dynptr.ref_obj_id;
 	} else {
 		return 0;
 	}
-- 
2.43.0

