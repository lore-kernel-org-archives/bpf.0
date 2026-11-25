Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641440;
	b=Np7t2VlvkSkcpxduhLYoIDvdJhbZb8twp5ngL83meJCFXCJ3lkoWX5ToPZrb4GeQzrUz
	 DFbhDDgjS92jm6d453URf/vi0zhGBXl8Rg3NUDp5nNiytJ4RqLdybu7aMjWt70QeSv3hw
	 5PmpHvorCTL10cuYUHIwCkYfpnwfmon85ddpE3Xd3D0XmWHo7bLJQ4icm81sxryW1R05F
	 03eY8alkwdzwCPm6aER8ZHwii39B3PZCzbhE+7BtCTp72cjf1/2WlMCoNhwK1i/y9pFEv
	 Qxgdm9mNx0DPwMUDhJUvtgbxrbee3dpzH0RbHJjcpVLBHfF/um2H1TTQWv/kPbR2lSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2Aj8pKXRexLnII6etA3MQvP44ipeYWKng7vwOIf45jg=;
	b=ni7F0EdjZkda4TWSdKhNM50GyNX6vaTy59bavfw/aylJpkUwp9kVQQ9m9xuoq8IMWU56
	 Uka53/NJK0S2mP7ygqxV7Rqk0AXXV1jmsrBBjbrVZul9PCAMS4sxu63xc7oGgChQ3h5hi
	 SMtTTGTiuHY+l2FYYAhP1FT5nQ2Nz+FlkgKIGaJ0eMxrqUoW6mgzTGHFhrCwiTLByychM
	 xbG16mhF15F1r9JMH41HCxJFYWb4sRAN1HRzEq5a2C1GhNiZuEzlAA1A01RCpw7iDePWO
	 VAv6Nr/AHdDitTGdYrMfuADRe1ehtgY5JDLS7jWkX6Ts4nxaO2MlQLmjybb0g7xPuqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPGj9Xci;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA3C606A33C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA3C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPGj9Xci
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso3614879f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641438; x=1796246238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Aj8pKXRexLnII6etA3MQvP44ipeYWKng7vwOIf45jg=;
        b=hPGj9XciMA9vuiktexNbjiv0ZEiruT97VefrVG5CrCH8i/SKEDYQjO3aptIJkpxw3P
         pd856y/KBbGFgBemz1LAVm5bkAV/PDz7JOCQKNbb3LlHS6D3EtBd1KKYwX1je/9ZoVnW
         T+n3B4S371Zce4Ii4wZ+o700doprv7nUiOf/i8f9mYzO+OpH/HFRsRUbzU+HZG7xWnyb
         VlE7B5ql019btj6VRWbNb3fNikAW6T0oMwXVjJZCjPLXS98nvdlp4JjGSLM2Aj4+jv+V
         HIOOG9UYMjhwUWarkoIK3KWz4SaqwJA+iKks0AHLkxQ0ykEDBSVBjp2RGHMpIOu3xXME
         SLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641438; x=1796246238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Aj8pKXRexLnII6etA3MQvP44ipeYWKng7vwOIf45jg=;
        b=dwPzRONaP4R/XFI9y6t9zuezRjNBLs4Fp+H5fv5IcUG2DTKBUBDVE8PA7oCwnLW0LP
         OVu5rQduGeV+CkNAQyb+nS0QldCoUz9mMFxuEOk4iohYHGRoVwcI9pk/gj/EZUN5jFNQ
         lWvhqzvQa2iQfCkDCgzpwXOEhPsImkXgBdSs3uwl+4YIucESTP5jxi7mCC0vSig3MW2x
         Xxu6vqFBskwdjSQ/0un4rgubFdrlEG22GCdZKjkCjz1H3c1+rJE9gGiMiOEzoCerg3+M
         I1VjkYtj6rlWtiPSiIZP5FkBtbPYwZPfmkSj/O2MfOgS1XWUpczftIoJrpbYNky0IIfc
         ziAA==
X-Forwarded-Encrypted: i=1; AL+hErEfxnE9Jkwv0unx6Vdfd/J2NGFpwA0phTQe2WMBtRA7FwGEoltmChSMP8NkbM8eAdePJ6c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iYwjTwyWSilKiLJ5k6QFaZVWiGDsLwp2B2nMU3gTjUkoW0Guu
	XyixtKzKKvyqLvOgEbv7XuoPenzOnSKx1Sk4nsYX/Zg27myvLxoMMK0w
X-Gm-Gg: AZFdTZebohd9BFxkNK+TNfNnIOnIijUL2xMBGvO65AYzS6h9x3GZAuJYiYK4CZB91W9
	1nYMqgaF7JiTTHoco7DMH5+UG+qD/usTqd9ZvLjmUq8Ggsk/AGTHpGK4LOV6EVRVlvezPPU0VGr
	mRsi5LBsjrCTE/8uyhe0Iw/pSAB+aDe8aacoiiBQgcNOCSqj5m3ITaEgG60+ZstI53iTpbabugv
	82grJm0Wo2lLBFPJl4sDERy9Tln5fwfLuSx7dHgkK49SW+UGFz82XNToynKQsqoBhVQvhKoag6b
	7bvb0cVsw2BsGYdpkMMhK07a2+3ECNeBSbt0yMBLndKWo3WRhEXIDXmTFl8zJ7ueCG/soav72Da
	l341jldBrPyyyZunEiW+v6Utj/jBc9qZzHw1ZUBYG0MrMBXU5fiUPcqwbe61OEYs9uWh8RrGG8t
	1Jz8tPUyOOStdSrNkmPjk9VL6z2jChXrOrYPw54U9HvK3Q2m6OKySOmNrwiGE1lb9lRkBpPXLTM
	0TMOY1WRWCDyOgs5/xiZXO6XMRAKrxmj0ynBS4I17iSkWH0DoEd5QfmSaJLyxNPgl4aaWJAAiGm
	PmRoMOO5nMcRfT1oUa30TUU6OdNdI7w/w5dyUnOHjK96azc=
X-Received: by 2002:a05:6000:4616:b0:4a8:cf12:6f34 with SMTP id ffacd0b85a97d-4abaab6318fmr36906963f8f.4.1795641438188;
        Wed, 25 Nov 2026 13:17:18 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm41840507f8f.24.2026.11.25.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:17:17 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 5/5] selftests/bpf: Test functions which must have no fmod_ret tag
Date: Wed, 25 Nov 2026 21:28:38 +0000
Message-ID: <20261125212849.868523-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125212849.868523-1-a.s.protopopov@gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com>
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
functions which return errors: ones which work on BPF objects, a
kfunc, a helper, one of kernel/bpf, and those which are excluded by
name.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../bpf/prog_tests/fmodret_untagged.c         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c b/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c
new file mode 100644
index 000000000000..59347f9b4e78
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c
@@ -0,0 +1,60 @@
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
+	"btf_kfunc_check_flag",
+	"bpf_mprog_detach",
+	/* A kfunc and a helper */
+	"bpf_sock_destroy",
+	"bpf_skb_load_bytes",
+	/* Of kernel/bpf */
+	"bpf_tramp_ftrace_ops_func",
+	/* By name */
+	"copy_from_kernel_nofault",
+	"bpf_set_dentry_xattr_locked",
+	"bpf_remove_dentry_xattr_locked",
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

