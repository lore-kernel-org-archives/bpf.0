Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88143466B77
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391968; cv=none; b=UwL7GU74TY+sYuNzLVvAbCDWMXa7+n0IiDtgtrS5rr2DmqucfE7zSNWX9Af217NQH9sOM0ZkNguL90JprmlO+UI6x47PtUttJfJkaWmUTmJIspTLQ+f00FfmX18iRkdrPbhHHUrjTM3Skpd8qwdoeUkavjaey2MSwisaTy+svIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391968; c=relaxed/simple;
	bh=KUF+2FjOLnZjYyYKTHb2juBImvxdiFT0+7hPIACs+WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TC+cnVNAE6FfpuTsXr6XUipXwewSTxpwipj3JUrH8ZUR0QylOeAN0v+NcHwrFZ1lRMU0gpg2EU25Ve+UtrH3hQs2qBDnBbyk6UcPc3MbzOOr4x+l+Qji33Z5E8YX5qynUubJGY2qJiXrnq9bPPpH/2ivLA9jEsWKxF4f44YLQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5M//Zh1; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5M//Zh1"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so568489f8f.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391964; x=1789996764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bLtKGUqLM64vsxDthIoH3LqT8XG9FpddVjeyv1jvn7g=;
        b=k5M//Zh129KNatTeaPJtHrYRoYeaEkutWKjwows8t7Dd4qTGFzVQ8sPfssEuH3tG+0
         5tQ2DifVC84ydedZEY1XPa7wkqTNQLEM8O22CJNwLah7Yl5AbrrYwxqyY0v5z4wVruT0
         vqzKbRsH8Atq2PMvOsp1Qg0ElYDvfRQMbaqByONvMMKNxFlR60JK0HBCmpuK2aaTOwk1
         an2uaghLp/D3Pg1GiPNSEkEaAvss0GzPrF0+o4D1Ilz9DcceefMQD3HsHQLhxqkRlq4O
         5IJZ/B5M/CIcNBODMRVxHQsb1l0VU9UcSgR4LrexhVteBgl7nijTFQDCByiskjcteFLu
         GWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391964; x=1789996764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bLtKGUqLM64vsxDthIoH3LqT8XG9FpddVjeyv1jvn7g=;
        b=c77+Im3zCgtGphYaWgNBWoGGbwrhPHpdgbR7hfAXvuNW5t1xt7+1x1Rt+3YyBACnEr
         IY4dreSz9v7RL1FA6X7DFVQbBRQ2nulyf/AGjKygHtcIlb4d8J0g6UdmZmTQpZ+0mZLl
         8fBnDdEOM5kjAmshb+qwG31flRgn6fJEtVe4eldq0ULRh/l5ggUJ2GJ6336xYUSN0GrY
         dRobTqK21V9JJI063LrQTXzElq6Z7/Rvo1EaK6BmWPDvTaNwWgwrPtlQIrcqd96CzZi8
         YDp3VErVSntLa963YkGwGW0ALpNN6r6MF5edYK5Y1yqXIcJGxI00Q6PuvgmvSHceow4F
         aZkA==
X-Gm-Message-State: AFuF++nEKfKstkmeigPeVHQtcYbx9llwWNpiimoxQxU5A6Xju41Ig6T6
	CzdZCbZkxGN1x8T58mUcMW18czu0XNO+unxG3gL6nQuGdN4t4YwQUNj8CA+txlhg
X-Gm-Gg: AYBFou0tBZNkQ4ztJsv9Iepni+n45hOidQvnqdVsK6TG9LL0HrZxbh1NvEUsuyfGeDX
	zBAHtLYHUa3BLQObtAafCiACfTQeuXgBsdmCG9ZjJdzohku1wx/GqWGf9jaLj3k9CSeVvxjCT4s
	en+DyJ6dD0sxqh/43/cbNHdfntuL3g1+eMMpiD9qHRzK/M2DY9k7Xcxk77L8dUhH9yfkgB/E1r0
	mEomehZu3Jb6QEvyJkb5RTHg1LMgpUW9ozZjdYDivPGqhNjo4dcYBKKLmr78XhoYyCGMhlKbhVt
	mmyBKtowuq4keUWG6fvQmRfWjkl/UXFk5M8Mnpi94WEFtpwFVD0bfYtPudkPoLddy+uRhEqd8HR
	GEnS/cbCkRVtxttyU5+3CI4IeIE1nONI2JPjJJecbiFt4jfedVhg8Tx/NxJcEdBeEj0M77Pwwgg
	ybSatruLM/Tchh81DMUPbP2uTTkpPdnqkoipRWiECdVjHEieI8TIAgPPpcTpXAEtoepJnBWHErc
	iOvn+SrnEB0TiGQeSpu2svHgzw4bH1ppZinr1cMKfoitbgrXyouIdEQJLUAfSAkbK9sH/Ui6MZl
	MCRepLVL3KP7VASjSjmQwxpw9oP9UJUquLsJaA==
X-Received: by 2002:a05:6000:2504:b0:485:8a47:5b9a with SMTP id ffacd0b85a97d-48702b3c7f4mr2575482f8f.55.1789391964226;
        Mon, 14 Sep 2026 06:19:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb36e4a6sm28531919f8f.37.2026.09.14.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:19:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 0/2] Fix global subprog verification context
Date: Mon, 14 Sep 2026 15:19:19 +0200
Message-ID: <20260914131923.2544250-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2168; i=memxor@gmail.com; h=from:subject; bh=KUF+2FjOLnZjYyYKTHb2juBImvxdiFT0+7hPIACs+WE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv5F+83RqXxSgdfVLoe1KudfFhSPq3t121Bt6epC6Xc9 xU1ybV0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKPvjIyHOny5zPttL73L2TX tHLV+49zy+YcTNyRdK59ruT56uCkVQz/s6S4J3GdFqr4naTE3uR5xvzhacf65W6WvvYBxxplHgc zAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Global subprogs can be invoked in both sleepable and non-sleepable
contexts, but are verified based on context assumptions for the program
type as a whole and not the precise context in which they are invoked.
Nicholas identified that this can violate verifier safety assumptions.
Verify global subprogs once for each observed sleepability context and add
workqueue callback regression tests.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20260905051224.2325381-1-memxor@gmail.com

 * Clarify that globals are checked only in contexts from which they are
   reached, with two passes only when both contexts occur. (Alexei)
 * Implement in_sleepable_context() as !in_rcu_cs(). (Alexei, Eduard)
 * Keep the original subprogram traversal order and repeat until all
   called contexts have been verified. (Eduard)
 * Explain why instruction accounting needs the saved total and why the
   exception callback uses the main program's context. (Eduard)
 * Rename the do_check_common() parameter to is_sleepable. (BPF CI)
 * Preserve the harmless global calls with __weak __noinline and check
   their instruction totals across both contexts. Drop the redundant
   task-work global RCU test and retain the review acknowledgment. (Eduard)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260905034018.2095649-1-memxor@gmail.com

 * Preserve the harmless global subprog calls in the positive test with
   barrier() so LLVM cannot eliminate the intended coverage.
 * Return zero explicitly from workqueue callbacks after global subprog calls.
 * Document cumulative instruction accounting across verification contexts.
 * Fix BPF multi-line comment formatting.

Kumar Kartikeya Dwivedi (2):
  bpf: Verify global subprogs in each sleepability context
  selftests/bpf: Test global subprog callback contexts

 include/linux/bpf.h                           |   5 +-
 kernel/bpf/verifier.c                         |  71 ++++++------
 .../bpf/progs/verifier_async_cb_context.c     | 106 ++++++++++++++++++
 3 files changed, 146 insertions(+), 36 deletions(-)


base-commit: 29fcf9ce4bbdf4cc339def776860e1c0095bca98
-- 
2.53.0

