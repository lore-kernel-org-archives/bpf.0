Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702671;
	b=mBbJ7+KOcvV/oqMDcbW4Zp37PPp75nXmdDzMaTfczfghyeRE/GUrrCnb1/AooYqH8pWi
	 uXtIoWyLxkOGOqA9Cvs7Wsb8LwMLrk1Yi5AxkwYGeAzwDL5+0iM1+eyCvt4iVEjawfS7v
	 20WO18/c0SwyUabynW8l+JEx9GxbvQtPq2p30BAjvZv8V2hdngbKNC+cv7v9gSfxZu3sq
	 zTWVtYrJ3zPa+TuqZ/AbtnZCKId+aD3BcSWhd9sxg+KxoEE2sNNAXxuP31njDbPrcTjCN
	 uiSeTbTVO6zKffOLEcUBt8mkbQRgIV15TTCG5C8cArGYRljfMhJ9zgPdHANEy5G+NSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oV/YZvAPPD4x2ZRTI3Kd9pP1YA8dQ8j+9fbE8hmXl5w=;
	b=Wr7SKEAp85JCcpNooSFy7idrgwMoS1+h6NvXdbBmfzVoqqX9PUMGiY+qsq4nB83gArmB
	 wB59HzV4ofWNtViDSRbucGWDVnFkOMqXABX++DY612TvOcslXYQWyJVS6N4SajrJK+kdm
	 Pir1Y23wAU/4bQArtHkoaTFLV8c6WsT62p8mcKAcg3NI0ojThYEMi9glidHevba41m/Fy
	 HH/30uALTPR13AXOMMmBd0gwK6wiru63Qm7y5hDYC7xsPYu4jnzyyroCNwz8znk94GO4K
	 LSsPMg0MV/XJkU8nHLEF0/c5mrFMDPVv7pTWRg0gQ5ZowAjA2xAnYyy1fFlmNsVtCqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y1EeXWaf;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E7606A327
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE5E7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y1EeXWaf
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso51376305e9.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702669; x=1796307469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oV/YZvAPPD4x2ZRTI3Kd9pP1YA8dQ8j+9fbE8hmXl5w=;
        b=y1EeXWafux11LzpLCDzwhu1uIWpYqq9MEvrA56oRXh5Meg3akUFK2L+NoMvZd8kY49
         sq2eDvIi6FyzoWFkZ9mjgaMrG0h1XtFR3MMI92Lu0Nl2eVE3RJY37gBB8+5v4PhcYzhI
         yboN8ZLFU33DfEAhY9MY1Qvr4BIpW6r2zK98jxKoWdegZQ9Kr7AHv9W+GrxrGh3lMs5K
         B9QrmxuqQ30PYq6ETNddSC7LBp61uhg6VCLcRV1zPjooFAQ+4Sz9iWUgHhZo9GgZ35ej
         jZsuCViznEyt6ynZPHjRroyMdjRQr9bxdO0nX0u7Yq8YYzJVSBJF/q2oCuMRLxBjUeHq
         rkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702669; x=1796307469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oV/YZvAPPD4x2ZRTI3Kd9pP1YA8dQ8j+9fbE8hmXl5w=;
        b=Nn+hi4KokXRae1BlGcdYn5dVMoXXTnGPDb2/BBMhgJzEXUfeUH2Z6aKWl8ynJufGlW
         kHp/odWGQUux7uYfbxHvomhiQ8xIBFk9/4Iql9SFWIHGg/LPi+kPqotzBCnqm6SGjPcB
         BFLFytALfThvcFddEEdQiGFuDx5J0bomYKPvzh6KrLNpKGl/S6Z8i8xSlEUZFn4RllhX
         cOpbGVmkdo4ltsiAm/gy2eFelz2Epm6B6eaiU4/T6L1ZxOsG6mZD4nKr/Kol/+J8cQqH
         tDRgK1vCiYRd2oM6P2cXFPiC0Dg0VS6z6JerP7Gf2T5KnMRegN3HK0e3VuG9fMRPKp0b
         LJGA==
X-Forwarded-Encrypted: i=1; AL+hErFgUclk8ZW6UklnAYHbrhd+w/MSHypPKlsB9a8f9pwFewYQ4U+k1ASsOrMBwODnSkL5jPA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ua9JpNfIi+eBjD82uUQnPGz5iAj2CVf5doPGq2CBC/Ei+nqQG
	DWfG/HLJ++6uSg2dlCXSvQekKaX+zmn2IMGJT50vgSnlZFTB8zeUmEUs
X-Gm-Gg: AZFdTZcLw4lvFDLD6YaT1bNHsbspC//p67JXWycbEmKOE2DxUmFIqcDoWWunbTPd+O/
	/Qq+1aud7NJsVXPh/Gm+w7xqtY0Km9G8fsO+UJa1RyDwbdtp42+nQQgQ9BkSCHk+uXoBIH9+L8Q
	NBHN0EFQSqUQcSBF48UfpZTnD995cVPibwZffc15wdZTYQmFNHoVxXI1TiV+QFaA/fGFvHoPqnN
	b13mKHon5d2tdGRhLnZThH9C7LV5zlGrIOaNgZ5NArEJiOgiMY3nVc6+88Cv1TRS0dTa0jm5Z2l
	114uCoD3/5K8b46/s0+xyT8WUWQFCi6u9C3o+rLiTP/f7RrZawh5bex2usC8n6EoNPsj30hpATz
	bg0X5lkVBMmzMhynW4cKRSvrQ4qYwn+z78cq0herA+rznfPdOo/2+RdGWGc3ndkimcstC4WCz8G
	nCXAt/gF+XNaKlym76nbkkPoNfrzIo9+kzKIeRzPSXGjEuwYHUla9K+Q/Vfjo8OgBqqi3ILZVeu
	U+gWhOFpHgDrgPU8iXD9ne00eRZ9n6IgE3USSXY0S8ehLL156IkeMkRS+2SwPkGztOj+YbuyTeV
	p2LVn2djJBvt+YxF2tv4BlPjRJ1JQK7R1G8V66sBbLzFz40=
X-Received: by 2002:a05:600c:1549:b0:4bb:741d:ea8 with SMTP id 5b1f17b1804b1-4bb8880ad4amr406670045e9.7.1795702669199;
        Thu, 26 Nov 2026 06:17:49 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm596496575e9.5.2026.11.26.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:17:48 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 7/7] selftests/bpf: Test functions which must have no fmod_ret tag
Date: Thu, 26 Nov 2026 14:29:13 +0000
Message-ID: <20261126142915.1106330-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
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

Check in the BTF of vmlinux that the build has not tagged a few
functions which return errors. Each of them loses its tag by one rule
only: two which work on BPF objects, a helper, one which is excluded
by name, one by prefix, and one of kernel/bpf.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../bpf/prog_tests/fmodret_untagged.c         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c b/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c
new file mode 100644
index 000000000000..9f4b0586fe8f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Functions which return errors, but which the build must not tag as fmod_ret targets */
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#define TAG "bpf_fmodret_retval:"
+
+static const char * const funcs[] = {
+	/* They work on BPF objects */
+	"tracing_iter_filter",
+	"sock_map_delete_elem",
+	/* A helper */
+	"sk_skb_adjust_room",
+	/* By name */
+	"copy_from_kernel_nofault",
+	/* By prefix */
+	"bpf_sk_storage_clone",
+	/* Of kernel/bpf */
+	"range_tree_set",
+};
+
+/* Has the build tagged the function FUNC_ID, or any function if FUNC_ID is 0? */
+static bool tagged(const struct btf *btf, int func_id)
+{
+	int id;
+
+	for (id = 1; id < btf__type_cnt(btf); id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const char *name = btf__name_by_offset(btf, t->name_off);
+
+		if (btf_is_decl_tag(t) && (!func_id || t->type == func_id) &&
+		    !strncmp(name, TAG, strlen(TAG)))
+			return true;
+	}
+	return false;
+}
+
+void test_fmodret_untagged(void)
+{
+	struct btf *btf;
+	int i, id;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return;
+	if (!tagged(btf, 0)) {
+		printf("%s:SKIP:no CONFIG_BPF_FMODRET_SCAN\n", __func__);
+		test__skip();
+		goto out;
+	}
+	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
+		id = btf__find_by_name_kind(btf, funcs[i], BTF_KIND_FUNC);
+		if (ASSERT_GT(id, 0, funcs[i]))
+			ASSERT_FALSE(tagged(btf, id), funcs[i]);
+	}
+out:
+	btf__free(btf);
+}
-- 
2.43.0

