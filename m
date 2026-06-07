Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BF2E7369
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852231; cv=none; b=jSZT7l0vzsbgH9wX5yn6rDTgPMWIuxUfQ/0MIqtw3AHaerxKgZHwyqwxnczCrf8cOE/5yTgnd6Jf/uNwVZy4xJa6vgY03TO18trdvvHal6tO880rc3joc6SWHXuYv3CINl0sVL7pdKg9089wdEMgLGT6jl5NWeB3Ea6XtxWNgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852231; c=relaxed/simple;
	bh=POr7Ix06Wp1uWzM/s/uHnlsY2+YTVLr9bOr1tz902ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHo2MNEUprKFpHmZl/QDlW6YbDk11OLKjMGp4Wy6ABYZh/Gzvo7iaud5g84pQ9eeeyDjy2timtZ1MvYhnOv7JZDxeImqZgxQDVdVD4A5cqFwvOyTsZRHBQr8/PxjdyJzxFnyzMK7Tu2sE9tlaqSsdI9RXd5UcMs3UvjqbQpKhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOnqxaAQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOnqxaAQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf237e1433so40784685ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780852229; x=1781457029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTfbPBlxFmhjxsli3uFXWEfIKIHGvct1qlkSlFL8qW4=;
        b=GOnqxaAQGzQVjv888xjQFkCye5CGOIV+20umJK1IzH5A4zf4/fbK7of3ePnQhItiMx
         9C/rDthzXWuRA0H6mWLZ2sorIAqRbbjUgUzcRhsjIbs0oZ1luD/smsD00xAaY4OzACLl
         zivDjLU09inS7/B6LEfy8AuhLwV0vG0yV3FkVQ8xyNMqISLIcRhyiXZNbRtz2lC1uDXe
         a+5TLg7SgMEss/QL2NSKkESL+T03UyF+JwIBn2WgPAi0T0Z3aO7vk8bimoOSQCqr6sal
         IXIrjWTpWTIiWDPao/oR3BfvOatxLkmuCuhGHy+eUERJODWpIlTGL2RoiyVrEYWm+0s2
         KSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780852229; x=1781457029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTfbPBlxFmhjxsli3uFXWEfIKIHGvct1qlkSlFL8qW4=;
        b=PbweslGo5ScaOHFSanEiDgWnRzQ9pzMIqAl4xWCqiw2Bf6uqd8PjQT/GPeXis+OTpx
         ONayzL9ow3695T9UBWJleXXVeFLB2iX++jE+tJOg7SVWCOkRD+TDEIqWR1lKaejSlj1N
         V69kJl4Dl6qncs6p9mf3HJgNstViu4ZBqLluiiZyPIPefrWFHhnpkktMbE3AeyrLsNiC
         86qq/YxHgRgY5Tr7az0xMvfZUjPnkZmkVhBm1rhoiMTh9wLo1WdETZSZHxYQieA1WuMx
         dPgICzq3AyPYFzOfo3jjeNc9Pv4CvX2oMsa30tD71fSNsdflIBTBWe6pEHy98yU9BiUf
         oApQ==
X-Gm-Message-State: AOJu0YztWfM1diSxJvSwEwzY8mD7EtuTrm58bkd0+zWZ4iWWPje5Vn2S
	FAKg5B1Md3Jj1Qo3tndouVYi4dXLDrXeNYaQeWzIxXJd8kxm9AXEy8q3xhi+P+7tFEs=
X-Gm-Gg: Acq92OFjuSkdSNoLjEd01swGd/8j3YT17Zp+tih6t2oTebDYJnOYx6J7QoGo/K8zx7L
	yDMRIucSUXlKz3MuhtCNtLDLrE8V/M0VBpAVSgT/wSg2my1/FvU1RdddvKF2aeJMO+T4kekeZWG
	wj4VWsoNiHfPRgqNLr5LOvxohJHVmRCxvdb46kmRk0vqxvJlIYeAeY8cSPwHi5It3Zw9Beok4XY
	cn/TCUTL8G7dPObv5QQUnzVVvJe+5pCl7Y1itrE4rLocO2oldLDyOYcTVmaIBQOcCQA+Td/X3vQ
	agvVe7HZ9VMxn3cxtwxDDzHVMb+ZVO/dA6MAdopfVJrlSImkERbTg+VvM/j/Xz9dixCkpyrqyMR
	TbQa4/PwZ0SMZgUpjEsmJMxpM7SfHSSH/sSu1vTcDGxIOWtP8iiZgDWC2ZmSclSy5eFo590iDiN
	eKUppoxIwbg6lcMN00JQF2gECmErqEL2GvELW+8jPtuA==
X-Received: by 2002:a17:902:ef08:b0:2b9:6458:1a2c with SMTP id d9443c01a7336-2c1e820e30bmr150565325ad.13.1780852229364;
        Sun, 07 Jun 2026 10:10:29 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm155375265ad.31.2026.06.07.10.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:10:28 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v2 3/3] selftests/bpf: add helper retval linked scalar pruning test
Date: Mon,  8 Jun 2026 01:09:58 +0800
Message-ID: <20260607170959.823755-4-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607170959.823755-1-jt26wzz@gmail.com>
References: <20260607170959.823755-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a verifier test case covering a pruning bug where a helper return
value and another scalar become linked by scalar id on one path. A later
branch can then let the verifier explore an impossible continuation and
prune the real success path.

The test uses bpf_skb_load_bytes() to create a helper return value in R0
and a scalar derived from the tc test packet length. It then links the two
scalars on one path and checks that the later branch keeps the reachable
success path.

Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../selftests/bpf/progs/verifier_reg_equal.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
index dc1d8c30f..269b2af50 100644
--- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bpf.h>
+#include <stddef.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -55,4 +56,38 @@ l1_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("helper retval linked scalar pruning")
+__success __retval(0)
+__naked void helper_retval_linked_scalar_pruning(void)
+{
+	asm volatile ("					\
+	r7 = *(u32 *)(r1 + %[__sk_buff_data_end]);	\
+	r5 = *(u32 *)(r1 + %[__sk_buff_data]);		\
+	r7 -= r5;					\
+	r2 = 0;						\
+	r3 = r10;					\
+	r3 += -8;					\
+	r4 = 1;						\
+	call %[bpf_skb_load_bytes];			\
+	r6 = 1;						\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+l0_%=:	if r0 != 0 goto l1_%=;				\
+	r7 <<= 32;					\
+	r7 >>= 32;					\
+	r6 = 1;						\
+	if r7 != %[test_data_len] goto l1_%=;		\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(test_data_len, TEST_DATA_LEN)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0
