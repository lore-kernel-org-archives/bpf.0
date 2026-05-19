Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214334167B
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214422; cv=none; b=YW7KVfyIRrMTF+iGzt1+fCPu0Db4BzxmQl8qG+sqUEDNavW46xOkcMko3FKM6aE9IQ8y2MJVtIfHXSJ2m0PT3DDuzSUAqtuiXqXWTvkrbu5G/WH0qz3VLElXvtgtfZ1MdGRsQ0AXnmNiZeyb71Isgn4GWzQhJL4GxKilAqvbhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214422; c=relaxed/simple;
	bh=YuyvY6lR4seLVkjZlpLKISV+5zAbgi9YvwGKD3oZZtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJ4Unwe2mJ71ZSm6UfXgJGmQx+qPclWroF1MTs5OHCwRKeUOzJtlSY3+Pp3wOorMvob2/FpkTyHJqfMpoFJmEr04yHB1hFN6sWIWjSvYE2KSd0LLNnK0Z3mm4R5uhrves+SITbPaVZUt1HPdnr8USjG9nGFQNx8IZhlyA7OhWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXpyePLz; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXpyePLz"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65e39d1dd38so3353445d50.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214416; x=1779819216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK9UDeebClR71GiLjHRDE0WHrjlQxfeEp/nIlqA3ZAA=;
        b=RXpyePLzTz8/zoJcTlYL943yi0/WFUu5Goh+jnaP4G88ItwlcVqt9Q22l+Uh6liPa2
         HtcG04Gva4sWhlwbgNj+HueaQeX494DspJjZCXk7T3Zom80amrm9Ulhq3RzZZRpipH9C
         48ym+sNBMik0b7Y/XsQgoUy9otfpO1UPghxOP/qK5nLEcAAFUJAuETp5L3FwD3RLE855
         IB8Vs3yBSPoS220If/lgpGGGw9aNMfTHe1Q7fS3FwrCQBH6jmkN8amLs5dPjrj7RuVG0
         1iw30pLw3hk4GLbESOxUYoLxXZEivq2ko6eKEf1YDkQ/+IPvfcDTxo1oTcQCbFLg1tS9
         +/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214416; x=1779819216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sK9UDeebClR71GiLjHRDE0WHrjlQxfeEp/nIlqA3ZAA=;
        b=fzcUP7C4S+aFBLy/nxS4D5oMf0Y/gdU5B2dWOXo/3fGfif2CbMJoeUKR2zQ4Y9KFbW
         uCo+x95yqUGj//eDTMZmlj20+wq69Jzm2GdX2MUdLniFnprz3qPdWYJ1ylk4Kc6HdBnA
         xTBg3xdELxA4W1o7suaRxua7eZXNSVw/nX/oObwgJ7AUqs94Mm/W5KCA402EoZtlI14E
         5Gwf32lEaFUKYbBDsWEN3pVBLoXiyeSfkgR0sx11MuxNws1aRrWUoS8/8BlOkCiLr+ff
         efRP6F4ToK2v7k2Xz+Iiyy2MDkKAuGTJdodWsHW/EmeRL/WRWsW9YCDXQeZrsxSsJiC5
         cY5w==
X-Gm-Message-State: AOJu0YyLaqqZny7g8Z2gPClxGknJkfJnIWF1IsxlXpevn7IuTN+xmCyK
	xpvOLiKY0JsfPddLrJcuC1NW+fONQPFNmIuPYoKGzLb/L/BJsN/LPrtpAUdx1g==
X-Gm-Gg: Acq92OGpLoo7zs/gnLfut3Eoo8Wjoutxqn1xiirI+mCJtBzam5HA4/LHw1tFb3pjQcD
	NgJmOoNdKcG8XC5Js45yqvQCqNc2Bg20jnrj5/58u9TljjPBQm+ZRnqDZrh3J740WM6hfRtKaa0
	fo2r0C0gQQAqFeIA0fDa8my0CcClwD1uelQQJYcqHScM2XYgoPyDAecAARffZ3MpE09kDOQA9KL
	LaPYO33y2lRZMVdiAhmv4iIHZrreqDaKt0PB/U8qJErOQ85h5z7hxd3OP+04oSMaqm4XzMAhS/7
	Z2+282cmA7LgiN5k4bv7oYIr8rpdjtsam1xTYZec6J+KrO/HHOSrRyMNWUVOYeREj6JfeRQ903j
	ghIdNzQC646cHUprSXeyP08Inzpo49UYrLNapepX/iSdTB3aeBUO36Padh6B6yK1B/yIEMSye4z
	kE7MaIvtjjRHMvgg==
X-Received: by 2002:a05:690e:4409:10b0:65e:d38:aca9 with SMTP id 956f58d0204a3-65e22895bf1mr17448042d50.63.1779214416089;
        Tue, 19 May 2026 11:13:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d878cf2sm8359429d50.2.2026.05.19.11.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:35 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 13/14] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Tue, 19 May 2026 11:13:11 -0700
Message-ID: <20260519181314.2731658-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parent object of a cloned dynptr is skb not the original dynptr.
Invalidate the original dynptr should not prevent the program from
using the slice derived from the cloned dynptr.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ..._qdisc_dynptr_use_after_invalidate_clone.c | 74 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 65277c8fc887..77f1c0550c9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -11,6 +11,7 @@
 #include "bpf_qdisc_fail__invalid_dynptr.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
+#include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -229,6 +230,7 @@ void test_ns_bpf_qdisc(void)
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
+	RUN_TESTS(bpf_qdisc_dynptr_use_after_invalidate_clone);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
new file mode 100644
index 000000000000..ac626cfa2a98
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+__success
+int BPF_PROG(dynptr_use_after_invalidate_clone, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr, ptr_clone;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &ptr_clone);
+
+	hdr = bpf_dynptr_slice(&ptr_clone, 0, NULL, sizeof(*hdr));
+	if (!hdr) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	*(int *)&ptr = 0;
+
+	proto = hdr->h_proto;
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+__auxiliary
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)dynptr_use_after_invalidate_clone,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
-- 
2.53.0-Meta

