Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569F3AA4EB
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597277; cv=none; b=YVLHrtAbqPz9J26GxoRFzQP5SPcPqtyfp4LhOV51mUDN0bmEaeazyNA0QHAk4HJpDzy77/m/FVEMfy9SxDkDFrSkHn9s039VDxCcNQVUF8e7NXA2RWyofgDsv2ukcarZMfmpZJHk3FcvLWHQlKk3gS2VOorVcdimQCipKmUOtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597277; c=relaxed/simple;
	bh=kkyMGD+86PiPtJ8E6ybxbOpixaxcp+ysK/uiZCwBb1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxcgQVGZgHyB4wJruvsN5s5jJcmQluXOkkkx4jTFolUu83Ul3c3OpbUC2mMLpb9sk7NMxuSBm2ki2t4NY2lS/sA7axchVhjGeYljZ38CLPPlI4w2wjP29JWkb3Uqn561Qk8FX98Tv0w2JZGj/1tZQIoSlKoCZJkLyfS4GQShgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPD9kg0v; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPD9kg0v"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4843147998cso346097f8f.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 01:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597271; x=1789202071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cgdmPoEtdaa11KXx2hicq6za959aKkgERPF71+sX6lA=;
        b=hPD9kg0v1yMHjfRkoKmlcWZW2NundAPcG/qYk+oqsv52nOd2NgIjBBMT9LY7939OiW
         njW9Vn5kymIoqAG5CYwCR2qCIGMBiM7i3ClUMZWtxz6mvAgM0tDjgCghIB92RTUYlzDF
         HRJ7AhPuaw7gxlGa4bR46219BZvVcbQoLqp7kSBvP/qSefEBuizbhuBYv6LB524DqWqX
         BEHx9u2fYQHWyVNsooGi89R247Diw3UlFtPsyUgs+R+nX5o65Ygkyg5Qsm+2wU9OIcKs
         ZQnqeDPifqDe/WSxP17pmKYLvDS+3UsW6XHrSjhUKqhTepIEsSkf5MHQO6DZ2DO7k3bo
         2xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597271; x=1789202071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cgdmPoEtdaa11KXx2hicq6za959aKkgERPF71+sX6lA=;
        b=D4YRU84+AGKFWU4787RfH0IZSMLnh5fONaLcLpHMnjv9RZKOgftsC+slTuCmDTPCHA
         8GVSPiRqsA8OQTBSx26EhL/MgvksDtSTrfcz/qL6sUlB7Ague7eRqCFiEpg6OC4K1zur
         KCWIlYnq+sVblLhCos215COehhqP3ZXbdhJUvy8QbXrBd9i6XZLVZZmNDUxxIqTKLO/u
         bZK578iVFxO4mzk3HU5UIrmJ0cOxJy9H0g85fbhnwwYsSmsxq2hkPRiZ8EaY2TVj9w8I
         Jr822/44OkN+dFgLlaQCuK5clJLurjB2nbQHxG0TJnQ1C2SRvzV8/4tk9po9pwWAEenP
         GmNw==
X-Gm-Message-State: AFuF++l9e3i0MUZIYd+2WYqwfumGuo720Rr8NZcz4HorRocCXecHNG73
	E+k8PAnOsWr+q+kMwzyEZzzErEv/6oFtvDY8zzxz0GOohnnnseNRB8DWgR5XK5Yu
X-Gm-Gg: AYBFou19VXjwvExKD8IyvWCwYKPc/K5ejFUlpN0T6Y9hj4yXNhikk5EwOaAigGqMMFv
	W+gsFvg/Kp0Xuc2OynqlWqOFd9gRdV3nEISKIrIxEn40s332CmXkyZKEHsaP5Zt+GSnX9o+QF7l
	yddfy3isnfKwXLvzJF4e7h1aDobynNaXubMiYDkZyxOrvv2iMblkAfw7AEI8rVjRUsrBHiBAlNq
	HAvjoo+B750FR29OKwKCNoIbkV1TYchWXpW4/ZPbZuY5oVH5+tyRdXKwQHKyMQPLN0z9tcJytFA
	DIvkVcfhCtsBUdE1MMXJdvfjQYAvaRdSNOfHmXmMCLGChMp/TPAVjLu6COt73XMIZ/AwWAmzL04
	QR/gdWfDL3oraI/meUKOX3EnQAbzn/VCgCwOjOLif1AUsN2tbjZUFY3T51Lu1m/lOFKKhowYwCp
	z1eNHlpu+gsE7LkZyQXHF4x5smPPJ2OuGD6G3BMy5LqllxO8Kgprtd8L7sIXAeaJ3nGqrehfOQp
	pfxdw/OqnMUkjgD3PeVbSPnrCgDz5fuIp9SFWkCkGs6/D5gu1g74+l6JD3Cn8lNWvq3TnbWdfDC
	VkSqpydsnVnW168BVtG+2EEm0CM=
X-Received: by 2002:a05:600c:5247:b0:49c:ee3b:723d with SMTP id 5b1f17b1804b1-49cf81f69ddmr96238595e9.0.1788597271416;
        Sat, 05 Sep 2026 01:34:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm42131725e9.13.2026.09.05.01.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:34:31 -0700 (PDT)
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
Subject: [PATCH bpf v2 7/7] selftests/bpf: Check callback map value lock identity
Date: Sat,  5 Sep 2026 10:34:15 +0200
Message-ID: <20260905083418.3723623-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905083418.3723623-1-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5736; i=memxor@gmail.com; h=from:subject; bh=kkyMGD+86PiPtJ8E6ybxbOpixaxcp+ysK/uiZCwBb1s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2pULGwl3n7iVd0Th+MuaSbFv62d9iJ4I2bWG+8f/31 DlC55sudpSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAiwg8Y/spt57HxX3vZ5PoL 31T/xoA7KV936c6e+PTOAv5DZrXm5hqMDBPVP+xJVT3/asLJXQoff+R+8Hq980tz93tR+3OzOx7 +lmQBAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a verifier test which retains a map value from an outer callback and
then acquires a lock through an inner callback value before attempting to
release the outer callback value. Both values can denote different elements,
so the verifier must reject the mismatched unlock.

Also exercise two distinct one-element inner arrays. Their concrete map
instances share inner-map metadata, but their callback values must retain
distinct lock identities.

Keep a nested same-element lock/unlock program as a positive control. This
ensures assigning fresh identities to callback map values does not reject
balanced locking through one callback argument.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_callback_lock.c        | 121 ++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callback_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 64ac49ad67e6..5c572dd725e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -25,6 +25,7 @@
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_btf_unreliable_prog.skel.h"
 #include "verifier_call_large_imm.skel.h"
+#include "verifier_callback_lock.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
@@ -188,6 +189,7 @@ void test_verifier_bswap(void)                { RUN(verifier_bswap); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
+void test_verifier_callback_lock(void)        { RUN(verifier_callback_lock); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_callback_lock.c b/tools/testing/selftests/bpf/progs/verifier_callback_lock.c
new file mode 100644
index 000000000000..d23e13908ceb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_callback_lock.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct bpf_map;
+
+struct lock_value {
+	struct bpf_spin_lock lock;
+};
+
+struct inner_lock_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct lock_value);
+} inner_lock_map_a SEC(".maps"), inner_lock_map_b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__array(values, struct inner_lock_map);
+} lock_map_of_maps SEC(".maps") = {
+	.values = {
+		[0] = &inner_lock_map_a,
+		[1] = &inner_lock_map_b,
+	},
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, struct lock_value);
+} lock_map SEC(".maps");
+
+struct callback_ctx {
+	struct lock_value *value;
+};
+
+static long lock_different_value(struct bpf_map *map, int *key,
+				 struct lock_value *value, struct callback_ctx *ctx)
+{
+	bpf_spin_lock(&value->lock);
+	bpf_spin_unlock(&ctx->value->lock);
+	return 0;
+}
+
+static long nest_lock_different_value(struct bpf_map *map, int *key,
+				      struct lock_value *value, void *data)
+{
+	struct callback_ctx ctx = { .value = value };
+
+	bpf_for_each_map_elem(&lock_map, lock_different_value, &ctx, 0);
+	return 0;
+}
+
+SEC("?tc")
+__description("callback map value has a distinct lock identity")
+__failure __msg("bpf_spin_unlock of different lock")
+int callback_value_lock_identity(void *ctx)
+{
+	bpf_for_each_map_elem(&lock_map, nest_lock_different_value, NULL, 0);
+	return 0;
+}
+
+static long nest_lock_different_inner_value(struct bpf_map *map, int *key,
+					    struct lock_value *value, void *data)
+{
+	struct callback_ctx ctx = { .value = value };
+	int inner_key = 1;
+	void *inner_map;
+
+	inner_map = bpf_map_lookup_elem(&lock_map_of_maps, &inner_key);
+	if (!inner_map)
+		return 0;
+	bpf_for_each_map_elem(inner_map, lock_different_value, &ctx, 0);
+	return 0;
+}
+
+SEC("?tc")
+__description("distinct one-element inner maps have distinct lock identities")
+__failure __msg("bpf_spin_unlock of different lock")
+int callback_inner_map_value_lock_identity(void *ctx)
+{
+	int inner_key = 0;
+	void *inner_map;
+
+	inner_map = bpf_map_lookup_elem(&lock_map_of_maps, &inner_key);
+	if (!inner_map)
+		return 0;
+	bpf_for_each_map_elem(inner_map, nest_lock_different_inner_value, NULL, 0);
+	return 0;
+}
+
+static long lock_same_value(struct bpf_map *map, int *key,
+			    struct lock_value *value, void *data)
+{
+	bpf_spin_lock(&value->lock);
+	bpf_spin_unlock(&value->lock);
+	return 0;
+}
+
+static long nest_lock_same_value(struct bpf_map *map, int *key,
+				 struct lock_value *value, void *data)
+{
+	bpf_for_each_map_elem(&lock_map, lock_same_value, NULL, 0);
+	return 0;
+}
+
+SEC("?tc")
+__description("nested callback can lock its own map value")
+__success
+int callback_value_lock_identity_same(void *ctx)
+{
+	bpf_for_each_map_elem(&lock_map, nest_lock_same_value, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

