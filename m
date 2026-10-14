Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019F37BE81
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959098; cv=none; b=a2kQksN+gqffDQkWdBCpJ9sU6Kjb8fIC1rMUqBI3FFx/I9ZDSu3IRM3p0rpLlEkOkvB2Tdp+TgWvX2RVR8/90/xRb823JmeZohUoRrePlb1ywAMBKepcShrYOD28PU+kiekJrT/47cOZvAyBxp9l4iRqJjaWXwsfcYyW+BawYkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959098; c=relaxed/simple;
	bh=GeN5HfsOZ0YhBvtCtM85XCULZjJ0izFrO2P824Pi0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqPctzPskLSa0em6N45LxGj4MOD3DZn19zDQh/YCevGHcpy9sCvQQ6dRIuhLKvnYGiv1bU4zaxB6eHUEAPsQqwvezRkR06knOCf3z3ipcB9ShIaaKTrDw8FGTZfV0tCSwOtNbSff7KbkJMrB9BR5nb+2WaTu/u2+tUToA/cWPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoV2eLRf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoV2eLRf"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso287197a12.3
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959097; x=1792563897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8DSP2N/a61a8Xd/LK2XwQoroQeJQVJ5U02uGaDkv9lA=;
        b=IoV2eLRf6z2onK4XZkxBX+jcoO6oYla7VyQygb1gyzNp2njQ0ecZDPW2FXZPx33xxL
         xf7lb+ffBiJf7Q4bb9gW0nEsHZhxCSqlunoEIjJxmS8+mUg2Y+1H+udiDzV+EVtM93q+
         nlVV5/ncIeZp37gX+9mWIEw8ELHL2xtQGml/snYzfsxISh/ll7i+1iktrbF6eX16Z/it
         3RmKKgIEUb2vqEh4Jj9B5RZ8BUe8bugcNT9fIFOUVUpb4//MQUl7sypXf/4SEKVRHwE0
         SkZuNEerR05gBGueN4YT38Xracq/jI1htvAyXswX6cxrQGrIHOgGjMvMUVPBmB1TY37z
         DAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959097; x=1792563897;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8DSP2N/a61a8Xd/LK2XwQoroQeJQVJ5U02uGaDkv9lA=;
        b=HzFzT0UDBFZpG8uXs8TvYNNKoBDv81eqby4S+NRQ/g5KGXvImhQxg00qcLiUzxsyqr
         i/UmEJqqm9O3mFwLfy/7MMVO3m4LDTVg9cQueKcZYYE2r4EMvcbERDU+0MwCKb/BxACt
         e6sJQtMZAbx8t2KLKSzgYJhCCQ89DO3WTDE2zql1JltQ0RhVOq3gaEtACH5pjw3tMdjH
         /Uqc15eADmT1wtoxg/61tkNzVZk07+mBtZSo2C7ukaDQYKsl91t/HncCY9m4cttX9WDA
         jF5C94ObTMYwafkpKF3rtplQ0ZvWE6eZOQTlSBMsrG9cjeEcHjpX9JS77+Chx0ezfZYL
         Zcsg==
X-Gm-Message-State: AFq9FYIZuzDCkkHFuJPTQQx72qP/DABkMsAnV3Xs3A4O6ogkRqWJsXLy
	bPIDwxoksb7PVodb1q9PMuotwtWZy2nzfVEIfhpdcRYb79geBWKBhTmBxQCdYQ==
X-Gm-Gg: AYBFou3Pd+tXlfHIMG66Z1GqQ7Eidciwzfo0G0wygUxudHe8BM3GvJJKim7cypocyuP
	ci2qSgkgpfgghcYEpJnOfkv+olaG2EsfalMN9hWpPjDWsYwXJjDbLNzT8Rm1VdgFuH+0zNKaHUC
	mcKRHsrZRhNOk1DaHvKdmdlZm42RQSI09pjqbHmQbpbe9SspzZqVw5B5XMVM0rpIxFENgvszk41
	x+4XSZnB1Fy+ktnQpbukRhZVk3eA7KsLucSFB35OM58bnncfKxk9cuZUt967RGNqVG9vsvYiiAL
	4H6EEacKawjWBInR56ENYjj/2Qiwy//Cqt+FQqfVBiySQ+07T/3/2WO+3GYbmNVcaOGQ8E4GHwQ
	UXHhQ02s87kFtR6445gQA7GGOeNICRdBRlPNcyJjGpu7k+qHJVOR4eEfdMnnosCxsE4KWFnnwHe
	kEHOWd6u/aI6K0VR3okE4izL68TKFsXGUseOkOu/j5lTfiKEyUfuJTT3p1w5sNPtTuhiELIojhs
	81EATfmCjcC9MI=
X-Received: by 2002:a17:90b:2681:b0:3ab:189b:6981 with SMTP id 98e67ed59e1d1-3ab3a92f9f3mr11822624a91.48.1791959096863;
        Tue, 13 Oct 2026 23:24:56 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e41126sm6614238a12.23.2026.10.13.23.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:24:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 6/7] selftests/bpf: harden __msg patterns for step_movsx_bounds_on_line
Date: Tue, 13 Oct 2026 23:24:41 -0700
Message-ID: <20261013-scev-minimal-v3-followups-v2-6-6d9d61965486@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
References: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The `{{.*}}` in the pattern for R5 below might hide the `step=...`
logging from the __no_step annotation. Replace it with full expected
log instead. Also drop __no_step for R3 above, where it is
unnecessary.

Fixes: 2db5837f9ada ("selftests/bpf: Tests for register base/step arithmetic")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bounds_step.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
index c9ee1c7efcbb..d824a5d48a39 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -338,9 +338,9 @@ SEC("socket")
 __success __log_level(2)
 __msg("r1 = (s16)r0 {{.*}}R1=scalar(id={{[0-9]+}},smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
 __msg("r2 = (s16)r0 {{.*}}R2=scalar(smin=smin32=-24,smax=smax32=144,{{.*}}step=0+24)")
-__msg("r3 = (s8)r0 {{.*}}R3=scalar(smin=smin32=-128,smax=smax32=127)") __no_step
+__msg("r3 = (s8)r0 {{.*}}R3=scalar(smin=smin32=-128,smax=smax32=127)")
 __msg("w4 = (s16)w1 {{.*}}R4=scalar(id={{[0-9]+}},smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
-__msg("w5 = (s8)w1 {{.*}}R5=scalar({{.*}}smin32=-128,smax32=127,{{.*}})") __no_step
+__msg("w5 = (s8)w1 {{.*}}R5=scalar({{.*}}smin32=-128,smax32=127,var_off=(0x0; 0xffffffff))")
 __naked void step_movsx_bounds_on_line(void)
 {
 	asm volatile ("					\

-- 
2.53.0
