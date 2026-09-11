Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4EF486406
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164293; cv=none; b=Jdx3/VlVZk62+KVe9sYP6v+Gt5PRSJ6W/s/hLSsqeiPcPaazgnCiinXuOJS8Qu56+lYNhNhm5Dwn3f5sk7IFINRx96I3taEmxcgLwOSkFJK6er7js15kVkEtNmqsxjTkvNw7/WUtzxHn/Bci/yf6+qPk2JWOkxyxhVqLvgvsyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164293; c=relaxed/simple;
	bh=m2IxA+6k2DxYHLhV4oxkGqFYmvkEIuGnWemNsTR/mw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIbDQ5m4MtdXZu+jStOgx+GhNU2YErClQycyQ2bAjrX1kW2c6C70F6VVzImKTtUFyj5C21W1UdcRINaKhWf0BJf88IzuJdrWGBOo63B/zMy1klJNWF0+7nrxlCBrij8qjxWUk4WvkdVUI9ozKBeGrAq/rIBI+aK321QQYV8UPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+DttIy/; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+DttIy/"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-804f7045f3eso30127a34.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164286; x=1789769086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ncZr99YgLiYlWDUfW8Thh9YR1tc0WqyDiQTwGwD7apg=;
        b=c+DttIy/8WLhVQRFxymxIg7kKKtItkxq5CdbO8/o4ZPJGdFi9a8KwIIYFY9fLCD6cI
         o/3GsBHSF6BpL9SjljV0iUppgizD7loE9IZm8fv4KSvq+QLbYlUwo1D8FOPhf6MXwMsm
         b0LrMwxug/YLdOh0dtigjHDQCS1SjXrSZXEAe6W8wGsnfllzQqR9Og5GvXNuVyH1xaQp
         gZ78mssBUXJ04IbUzlgOfxG1oOr2U3ld52jS0xHVhXdXgKSXV6eduVkF55sFxNUAPpQX
         XB747zJ0m2ZRolKbfh2GAqIcx1yAVXOzs7oVS+3/TN67E5Eho6vEd2h3BinEsJmqtAD0
         SUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164286; x=1789769086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ncZr99YgLiYlWDUfW8Thh9YR1tc0WqyDiQTwGwD7apg=;
        b=nEiBedlm5MrvwzLLidc5MV2n2pYALk/pYs10+UNOr79rVl6o7TPs4B+m1jI6oSWWfj
         43ZSHUGcOa7yT+0bbw0IQ+KXEbtAj7D4w4EpfrMI78ni7Kt6sVz3r72c1n1XguXV4EKA
         tuQ2iOYklJPu1A1L6PGQhvq/JEhysqqASDpkntLwAcxR8B2t6IFpYhG/x5g397aoSNG/
         tiPWj2Q4D7H73SxJu1hIxbwwrmQnEHHCj9ybXOLZYcJ6hRxG2R+ieJfrF/KRQ94Rxe8L
         JdT/O4VfpMuOEkzCLfPby6PnsFPocPYT5E45QnnKDEit1Om/78qZREk/EKkHhKnWMoje
         +9BQ==
X-Gm-Message-State: AFuF++kgwPrXala0Y3sm/FYBEgMcw4391jn+wTKO0SeZ3rX/6GDr5N0G
	doa/pmoCJaEgLyKTLfgW1Qv0v4lpnysphRwApRAT/QEU/y6DZexfcpCRT/fw0g==
X-Gm-Gg: AYBFou0tfPQ//RBQC41GeHyjVX3chnbPr5fRK6yvkZbkDALBcvRx+AbUGiK4Vaz/5Z0
	8VzQpTr+ttLKTTJsJ8qz+djSt10RE8FrpOXmmNak8N1PvewMfKilwcZyqpWQxcT7lNFzdDtdWZF
	sBODNlAMMOWvifxBwOxuUeFT8CcDw4da06qqxVgJ1mF8BMjLVkQ955nfqXjQoUMqwxD38VU2yll
	TXUPK2isGXhUZejn7J8nlTZqq5/iqGH4+j8gajB9Ex/PPOdQy30A4ci6IMPzjZOyej+FS1fg+Pk
	s7ObZg3tCg7lqtbAPnXzw3/AFdn/VSgfGIMX6HMIIxSEyL+dPu5AdJbtwFcaGjJaVOOQumpavOw
	h1A3sZWOStbVR3So5iHaE4c33XAO+PoBPOA/AKgBK4ffnfJ6RVAwnWvZVBcVkeo+PJ5Fbt5LMWy
	Qvja/949x9amH2HwrLX5+QDn0EupkQwVXbRy9F2RtO0oMQ+1EfquMQahNu9iDkthx6rc95mUyK
X-Received: by 2002:a05:6830:2b20:b0:7f4:e011:6b2b with SMTP id 46e09a7af769-8059e84fcd0mr195531a34.1.1789164286064;
        Fri, 11 Sep 2026 15:04:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f0cfa5c9sm3623600a34.0.2026.09.11.15.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:45 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 20/23] selftests/bpf: Test kfunc packet memory direct writes
Date: Fri, 11 Sep 2026 15:04:12 -0700
Message-ID: <20260911220415.1396439-21-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
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
index 000000000000..88009566d92f
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
+__xlated("w6 &= {{(1|128)}}")
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

