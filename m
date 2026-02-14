Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E181FC7FB
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771070080; cv=none; b=AhVKJiUEFbxyubgX1l1g5ZJRM9DXgmn1e5A+kPta0n04bE85l1TNadLrZD9w/wxWrWAgaLY5nuMd4NtcfTaotqqufFxiHepM/HkrqqZ2aYJ6oEsmypFZRQI/BoIUHkoAWfRBzlZIxwtPbWT1Brw2/Mqn5ABmVXRhlG6HjhrR3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771070080; c=relaxed/simple;
	bh=ETwWE2zGiCyxqLrpfs5oEAad45Yec1pEQzZLq/vFMNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/MZMu5l2f136QaE8Pj+IKdEqNVGA7l5izJny/bt3Zhr/JnSbP+3+JMMLXrwmTWvzGWfhIyAuSKFmI9aoadmoMHjpRtAGK1tkvL5BrOSJOsbyi0v5b3AydLYJlm6GKAS9OS6EuyF7EIyP8hxwzibs9lJzXUS4+hmDsvxRBPiGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh0Q6U1w; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh0Q6U1w"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so1265394a12.2
        for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 03:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771070078; x=1771674878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdOBKkhf8j9XMo1theBb8rs2ln4eW0jY+4jxw6Dwd1g=;
        b=Uh0Q6U1wTR60WUhGfT+4lm7N1ZvVYlXmykYFiVW/O/T1P6AY7vsgHKQAPdzXJVYHMO
         g+fbKzWVe/QkCj1qZgE8JEWwriUnT6WHyUeXo1eqK85HevSUu6DPchMHwmXaRtTXisRt
         Glh8jUiI7gXUxziHel9FIk3JNfkfKjfGbsNLOX+ISahf/sSyZod0jUTRMGPxOYDVR8iD
         qWEZ/WplSiC8clT3QIvQvNPhu7P+u51GHKNOUhJraXelhZre/hMRbD30VEoV1taXeV4d
         bgTKNOd6BMLIaQfyPz9vHzWAZ9seR3gBt24uc+gn3NY5on+9CNZtI1v01SYM5V1QdeGB
         9Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771070078; x=1771674878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdOBKkhf8j9XMo1theBb8rs2ln4eW0jY+4jxw6Dwd1g=;
        b=J1olI4DNsef6+mUA8vRIV8UwRtDayTzP2Rz0zVT62StA0fp4pYQUOg18v0qpHf58oq
         OVpJb1l/vRN/fMTm3T9ef1pkvgqRn+aLmGDeuCt+oYSmqYw11ULwIRVK0uvZofsIVAZt
         tn63ysbvGsYMtvIzoNhv/lVuQoqVRNek4Ns2S0lzbwddeBNXdu7EEcjFjpAbuP5VWOuy
         GDQEj/s2B3J/V0Ro78MLvebezpejkGzyvj1MrUXmJZx80Ve6oG8Ls30FV2EurCp+VhSF
         hT3BYGg0Za+AXYX2v8nMrCDjeS2FOKNMj4CljD6eo9VF1VNby8ItN4SAz+xIL9k/rgoa
         DfJw==
X-Gm-Message-State: AOJu0YxvXnq3tSDrA3ybPn12SSiNKsf5BQXkBLj+KatwFMC5f1IoQlwz
	gce0U1hQ/1WOvFPsAXukQ5WpvOOCJMagVhXf6vV4zJmHWrgmtKC06rwQ1CZ2p+1s
X-Gm-Gg: AZuq6aLIz88Ne3sXCY3g0woMqaE+lEVSY9UPJR+n2o3yBcZZ+lQiJPbRAe5ozTGyaes
	8fHKIHaKI50imuZpvxHGPHwRy6IKw5HYdl87biV8aGsDRUSAPkUgIMSf+r+z6oQEgFQiwYEPLew
	6Qn7DE8/9uyup3S69xdgEjB/Os2zWMuUfTLheOi7nedx8DFxAliDb0NXGaAaw1SzFiUEtq4JGp5
	GbJ6ZNs6Nt7GQW67qyW9+OFP21zrHMds7fMNdQ68dz69jchdwVvXR57RQ6UbYk5fWLXtEYbkdAB
	YRE41Vzt0ntK4KmPYUWiKXpA66lmaqC/lRQqSjYx0KWfckJ/7VT4dnoQRV8SDSsJwNIrKuRnpMI
	J0NqZCvUQbTyRJO2RH7qFoSuItK40mw0WfV5X+QEUU9Hxd1MoBS64F44sf6G3TkxVLynCWzJd/d
	J1lvsA87pkAStn+HoJbDxvZBdc/PFO4h1uUpG8qDcSkJrOCIKK01W+8QtRakcoULsc2kuPfje3v
	Ho1nMCjYWHEEYAOBl4=
X-Received: by 2002:a05:6a20:cf88:b0:361:28dd:a9ff with SMTP id adf61e73a8af0-39483a5a85dmr2075763637.38.1771070077690;
        Sat, 14 Feb 2026 03:54:37 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b95278sm6444760b3a.53.2026.02.14.03.54.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Feb 2026 03:54:37 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH] bpf: expose original requested max_entries in bpf_map_info
Date: Sat, 14 Feb 2026 17:24:31 +0530
Message-Id: <20260214115431.55574-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating LRU hash maps with BPF_F_NO_COMMON_LRU, the kernel
silently rounds max_entries up to a multiple of num_possible_cpus()
in htab_map_alloc() to ensure each per-CPU LRU list has at least one
element. However, the original value requested by the caller is lost --
map->max_entries is overwritten with the rounded value.

This creates a problem for userspace map managers (e.g., Cilium) that
reconcile map parameters against their configured values. When the
kernel-reported max_entries differs from the originally requested value,
the reconciliation logic detects a "mismatch" and may enter an infinite
delete-recreate loop, as seen in production incidents where non-power-
of-2 CPU counts caused small but persistent rounding differences.

Add a new 'requested_max_entries' field to struct bpf_map (kernel-
internal) and struct bpf_map_info (UAPI) that preserves the caller's
original max_entries value. The field is set in bpf_map_init_from_attr()
before any map-type-specific adjustments, and exposed to userspace
via BPF_OBJ_GET_INFO_BY_FD.

This is a purely additive, backward-compatible change:
- Old callers that don't know about the new field see it zeroed (via
  memset in bpf_map_get_info_by_fd) and can safely ignore it.
- New callers can compare requested_max_entries vs max_entries to detect
  kernel adjustments and avoid false reconciliation mismatches.

The new field is placed between max_entries (u32) and map_extra (u64)
in struct bpf_map, filling the existing alignment padding hole -- no
increase in struct size.

Also update the BPF_F_NO_COMMON_LRU documentation to describe the
rounding behavior and the new field.

Selftests are included covering LRU hash maps with and without
BPF_F_NO_COMMON_LRU, LRU per-CPU hash maps with BPF_F_NO_COMMON_LRU,
and regular hash maps.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  12 ++
 kernel/bpf/syscall.c                          |   2 +
 tools/include/uapi/linux/bpf.h                |  12 ++
 .../prog_tests/map_requested_max_entries.c    | 134 ++++++++++++++++++
 5 files changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_requested_max_entries.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd9b96434..8606b2c40 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -304,6 +304,7 @@ struct bpf_map {
 	u32 key_size;
 	u32 value_size;
 	u32 max_entries;
+	u32 requested_max_entries; /* original max_entries before kernel adjustment */
 	u64 map_extra; /* any per-map-type extra fields */
 	u32 map_flags;
 	u32 id;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b76..39cd781c2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1405,6 +1405,12 @@ enum {
  * which can scale and perform better.
  * Note, the LRU nodes (including free nodes) cannot be moved
  * across different LRU lists.
+ *
+ * When this flag is set, the kernel rounds max_entries up to a multiple
+ * of num_possible_cpus() so that each per-CPU LRU list has at least one
+ * element. The actual (possibly adjusted) value is reported via
+ * bpf_map_info.max_entries, while the original requested value is
+ * preserved in bpf_map_info.requested_max_entries.
  */
 	BPF_F_NO_COMMON_LRU	= (1U << 1),
 /* Specify numa node during map creation */
@@ -6717,6 +6723,12 @@ struct bpf_map_info {
 	__u64 map_extra;
 	__aligned_u64 hash;
 	__u32 hash_size;
+	/* Original max_entries as requested by the caller. May differ from
+	 * max_entries if the kernel adjusted it (e.g., rounded up to a
+	 * multiple of num_possible_cpus() for per-CPU LRU hash maps when
+	 * BPF_F_NO_COMMON_LRU is set).
+	 */
+	__u32 requested_max_entries;
 } __attribute__((aligned(8)));
 
 struct bpf_btf_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dd89bf809..66a518f3a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -439,6 +439,7 @@ void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr)
 	map->key_size = attr->key_size;
 	map->value_size = attr->value_size;
 	map->max_entries = attr->max_entries;
+	map->requested_max_entries = attr->max_entries;
 	map->map_flags = bpf_map_flags_retain_permanent(attr->map_flags);
 	map->numa_node = bpf_map_attr_numa_node(attr);
 	map->map_extra = attr->map_extra;
@@ -5301,6 +5302,7 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	info.key_size = map->key_size;
 	info.value_size = map->value_size;
 	info.max_entries = map->max_entries;
+	info.requested_max_entries = map->requested_max_entries;
 	info.map_flags = map->map_flags;
 	info.map_extra = map->map_extra;
 	memcpy(info.name, map->name, sizeof(map->name));
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887..bea369e10 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1405,6 +1405,12 @@ enum {
  * which can scale and perform better.
  * Note, the LRU nodes (including free nodes) cannot be moved
  * across different LRU lists.
+ *
+ * When this flag is set, the kernel rounds max_entries up to a multiple
+ * of num_possible_cpus() so that each per-CPU LRU list has at least one
+ * element. The actual (possibly adjusted) value is reported via
+ * bpf_map_info.max_entries, while the original requested value is
+ * preserved in bpf_map_info.requested_max_entries.
  */
 	BPF_F_NO_COMMON_LRU	= (1U << 1),
 /* Specify numa node during map creation */
@@ -6717,6 +6723,12 @@ struct bpf_map_info {
 	__u64 map_extra;
 	__aligned_u64 hash;
 	__u32 hash_size;
+	/* Original max_entries as requested by the caller. May differ from
+	 * max_entries if the kernel adjusted it (e.g., rounded up to a
+	 * multiple of num_possible_cpus() for per-CPU LRU hash maps when
+	 * BPF_F_NO_COMMON_LRU is set).
+	 */
+	__u32 requested_max_entries;
 } __attribute__((aligned(8)));
 
 struct bpf_btf_info {
diff --git a/tools/testing/selftests/bpf/prog_tests/map_requested_max_entries.c b/tools/testing/selftests/bpf/prog_tests/map_requested_max_entries.c
new file mode 100644
index 000000000..e54e88326
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_requested_max_entries.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Test that bpf_map_info.requested_max_entries correctly reports the
+ * original max_entries value requested by the caller, even when the
+ * kernel adjusts max_entries internally (e.g., rounding up for per-CPU
+ * LRU hash maps with BPF_F_NO_COMMON_LRU).
+ */
+#include <test_progs.h>
+#include <bpf/bpf.h>
+
+static void test_lru_hash_no_common_lru(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	/* Use a prime number to guarantee rounding on any SMP system */
+	__u32 requested = 997;
+	int map_fd, err;
+
+	opts.map_flags = BPF_F_NO_COMMON_LRU;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_LRU_HASH, "test_lru_pcpu",
+				sizeof(__u32), sizeof(__u32),
+				requested, &opts);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return;
+
+	err = bpf_map_get_info_by_fd(map_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
+		goto out;
+
+	ASSERT_EQ(info.requested_max_entries, requested,
+		  "requested_max_entries");
+	ASSERT_GE(info.max_entries, requested,
+		  "max_entries >= requested");
+
+out:
+	close(map_fd);
+}
+
+static void test_lru_percpu_hash_no_common_lru(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 requested = 997;
+	int map_fd, err;
+
+	opts.map_flags = BPF_F_NO_COMMON_LRU;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_LRU_PERCPU_HASH,
+				"test_lru_pcpu_v",
+				sizeof(__u32), sizeof(__u32),
+				requested, &opts);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return;
+
+	err = bpf_map_get_info_by_fd(map_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
+		goto out;
+
+	ASSERT_EQ(info.requested_max_entries, requested,
+		  "requested_max_entries");
+	ASSERT_GE(info.max_entries, requested,
+		  "max_entries >= requested");
+
+out:
+	close(map_fd);
+}
+
+static void test_lru_hash_common_lru(void)
+{
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 requested = 997;
+	int map_fd, err;
+
+	/* Without BPF_F_NO_COMMON_LRU, max_entries should not be rounded */
+	map_fd = bpf_map_create(BPF_MAP_TYPE_LRU_HASH, "test_lru_common",
+				sizeof(__u32), sizeof(__u32),
+				requested, NULL);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return;
+
+	err = bpf_map_get_info_by_fd(map_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
+		goto out;
+
+	ASSERT_EQ(info.requested_max_entries, requested,
+		  "requested_max_entries");
+	ASSERT_EQ(info.max_entries, requested,
+		  "max_entries == requested (no rounding)");
+
+out:
+	close(map_fd);
+}
+
+static void test_hash_map(void)
+{
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 requested = 256;
+	int map_fd, err;
+
+	/* Regular hash map: max_entries should equal requested */
+	map_fd = bpf_map_create(BPF_MAP_TYPE_HASH, "test_hash",
+				sizeof(__u32), sizeof(__u32),
+				requested, NULL);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return;
+
+	err = bpf_map_get_info_by_fd(map_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
+		goto out;
+
+	ASSERT_EQ(info.requested_max_entries, requested,
+		  "requested_max_entries");
+	ASSERT_EQ(info.max_entries, requested,
+		  "max_entries == requested");
+
+out:
+	close(map_fd);
+}
+
+void test_map_requested_max_entries(void)
+{
+	if (test__start_subtest("lru_hash_no_common_lru"))
+		test_lru_hash_no_common_lru();
+	if (test__start_subtest("lru_percpu_hash_no_common_lru"))
+		test_lru_percpu_hash_no_common_lru();
+	if (test__start_subtest("lru_hash_common_lru"))
+		test_lru_hash_common_lru();
+	if (test__start_subtest("hash_map"))
+		test_hash_map();
+}
-- 
2.39.5 (Apple Git-154)

