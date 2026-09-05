Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8B3B059C
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645710; cv=none; b=SDQwBChZcvFPm4hsan9U7npn84GIpTmM7OeqvHQtdoy+vqAeS0izuMKDTZrg5qNnA+gxqrZMlZjln5TNU88XBAR2uX1FfdgjK/ZjQ3WT4MtRLFtAQzSWPkB6HT9N1/bk8IdpUo4U/H2CRSo23o2pR/aYnpmyr86TPXKthoW53tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645710; c=relaxed/simple;
	bh=3nhG/rpeWOPIFqCVCvxLHotxELNOHUlA+yKraXzEpM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gH2m/DqHakNAH8ryGRKgY588voUAfL3njSILsjsexTdKtcgZ5rxv6jtVH+Rm8cj0s86dp+l2cpj/1v7o5aBTJ/2fhMbQGb0b9xw3631tKJ41qHZ7XqWGK7aQMMAR+g9VextMcTyqXh4k+yFLOwoacywIVZq0A+DPS6X9M5abvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiaHpIWl; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiaHpIWl"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b7b4b08d78so1353398eaf.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645708; x=1789250508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9JReNsSgAnrb6kteNCTnOq702KqLUnJ+GLt1CTpgrWc=;
        b=qiaHpIWlnXqnR1PM3fKrTOrSyUJaUpSjXgZldCzwC0/Afhz4r+TkvFYxtzdZx5mP3Q
         60T19O5Y4EjfLsJPytiPbO30fqhNBUJclV3+4p/t+wXtwe8ed7SnO5e+rhyFiPwwUrs9
         ltBe/ZXa0i6uUPvwhgW1qBqHnoy9spMeL7j/Yy5WFTRie5fSsxRPqFqda3REqVxQ+cP0
         jRckPS0FR5qOneEtqIusrwuYsYoLqg1fgXy/7JhUU1AHEwHbJJxcHyR72WYMANb33Kn6
         svlgjlN8T5H0CnGV5w4SMfTbUIgbQQEwWh4rvbcBpa2TTAVMtlQwOxHf4fJPkwcxFpth
         72Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645708; x=1789250508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9JReNsSgAnrb6kteNCTnOq702KqLUnJ+GLt1CTpgrWc=;
        b=W76QsnQZiEQ3CXNLLxuE+33ElDDAVKf8DXx3/DNVGJ5M+9wfSUvpx+T8U0BWeHOXPN
         8FX1XvAMMnhq9HHGmeBFVBzifxC8mtEgpwtHaEaovhBMZM5plXGNN4GNMFm0XJezLaMY
         6HQY/dcpotdoCURf9IFT+JdaGqDNWxQzQ6FYKIRpulCU3CrEPoaKMmHdWhCTNYQzeMRf
         s730lMXtnJaeWbVYPZ+aqjDjFS6Z3HsLgCKYCtzICjxoUp2eyY+7LWS7VWJH49mL9CFh
         Ddw10nlAFGpfYw/+8VzxTGulKOp5zeX+MbiFJPO6iNLb8QyLAN11yX4IEWXAv07itlik
         1t9w==
X-Gm-Message-State: AFuF++lqMkcgt3aY9rrMlGYfArxUY7pQwBUswGxA9I9JgrrP1IMPdsQ/
	4zootjZuoTukBTA/HZdD/mUMJ/eO3WgL1HVGXgjsvmJlL/yxQU2hIH0nsJzEXA==
X-Gm-Gg: AYBFou3tbsC04EqDw76jr9VEXfxZP5QJfYg/NM3U6THa+X5RH6pdsoIVxFAALsSi2o0
	TUuCrw0YTi3pwCUy4+iphYJh/h2kjJiL2AvotiulS8giCzC0ZL0PzGhdZP7aDb1YB3cj/TxRo5s
	L97mzpB+2IkjoDgSgxS4Hgj89iTJtYwATkADGodchAesDZPC7CKGxJwrQxazn04PgOzqQYTyjau
	XiIbAH1c7mRSHJCFnP+QzjuX4EZ1xVi80lvNPsl9eX6RaS84zBg/J/5limN+9s1Xx9egIwTXG4b
	O70QEPHG+4GKWi+hP/aBBL5CvA0Y1FQEAPAx0+ot6wdwHEHTAdA3QuAqQURFkevICsP0Agmn71W
	9wTY14Va7CubxjbFg1rwsI/O8lXahYi14kj5vvouzgzUDCvHVaxwrAmypvcmDwFajXFUkoPe4Bp
	U420BoiD+Gj2XEBtLf70OEhfsbNfBBaKMolmuqNlkwJgjPa7lKYKg=
X-Received: by 2002:a05:6820:82a:b0:6b1:4cfe:ea6 with SMTP id 006d021491bc7-6b6fd1ca1b8mr10163221eaf.32.1788645708376;
        Sat, 05 Sep 2026 15:01:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7aef680sm7492320a34.26.2026.09.05.15.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:48 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 19/22] selftests/bpf: Test kfunc packet memory direct writes
Date: Sat,  5 Sep 2026 15:01:14 -0700
Message-ID: <20260905220117.922028-20-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kfunc memory argument may be backed by packet data. Exercise this
with bpf_skb_ct_lookup(), which writes errors through its opts memory
argument. Verify that the verifier marks the program as directly
writing packet data, causing TC to emit its writable-skb prologue.

Match the semantic prologue sequence while allowing
architecture-specific zero extensions and the endian-specific
cloned-bit mask.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_kfunc_packet_access.c  | 47 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index f7f94ccebce2..b97381448248 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -54,6 +54,7 @@
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
+#include "verifier_kfunc_packet_access.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
@@ -218,6 +219,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
+void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c
new file mode 100644
index 000000000000..9ae63c9eab02
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *skb_ctx,
+				  struct bpf_sock_tuple *bpf_tuple,
+				  u32 tuple__sz, struct bpf_ct_opts *opts,
+				  u32 opts__sz) __ksym;
+void bpf_ct_release(struct nf_conn *nfct) __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("tc")
+__description("kfunc packet write requests writable skb")
+__success
+/* bpf_unclone_prologue() */
+__xlated("r6 = *(u8 *)(r1 +{{[0-9]+}})")
+__xlated("...")
+__xlated("w6 &= {{1|128}}")
+__xlated("...")
+__xlated("if r6 == 0x0 goto")
+__xlated("r6 = r1")
+__xlated("r2 ^= r2")
+__xlated("call")
+__xlated("if r0 == 0x0 goto")
+__xlated("w0 = 2")
+__xlated("...")
+__xlated("exit")
+__xlated("r1 = r6")
+int kfunc_packet_write(struct __sk_buff *skb)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *data = (void *)(long)skb->data;
+	struct bpf_sock_tuple tuple = {};
+	struct nf_conn *nfct;
+
+	if (data + sizeof(struct bpf_ct_opts) > data_end)
+		return 0;
+
+	/* An invalid tuple size makes bpf_skb_ct_lookup() write opts->error. */
+	nfct = bpf_skb_ct_lookup(skb, &tuple, 1, data, sizeof(struct bpf_ct_opts));
+	if (nfct)
+		bpf_ct_release(nfct);
+	return 0;
+}
-- 
2.52.0

