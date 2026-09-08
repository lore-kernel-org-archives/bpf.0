Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE1550DCA
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877675; cv=none; b=LZTw2WGU62MInHJySK8bB0+MVrzJZ9DfM27mrWysiMlunqp+COQiA5CR+ZvQcGbu+vYbzLaW7uheORdQb1KWuY+mB7OiFsSoTi5WpaKGMj03cbZ5N4d18bGMn6jgNb5IDQybIQQF9V7Hs9kzyeF9jU/kwp8ZxSgCLuMw/uSrLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877675; c=relaxed/simple;
	bh=WnQ+Z0gy9/vom7bLICY7QAUZMnIQQ88mgXh69HnVY/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5NUIIX5kcK02VMhR2rMYnsXhuPPXEdVdLDCJ53M9kh6eBpqVUcwseOUOBWLbv6vUIEmaurtp76aXEGIwt91OYv6xvsFFSdGUBGlV2oPqbxCoaJg5qTeeliPRRysG3WFyS1H5/61aI4sFmWB9o/QYSKSKPYe93tuKeRTMJXjAi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kctL5Gbk; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kctL5Gbk"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-46adfc80ff6so2795147fac.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788877657; x=1789482457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nHouJOlSoZUfZv7zUbhzGiE/gfL4Xv2l7AIt3pitCpk=;
        b=kctL5GbkQYL27v9CzPuSdyPJ2xsO3ms3i0BQNHXWQ8yZr8Mc5A4glwPzPd5KYDGsMP
         3cfafUZAYJ7gUZhd7kSPXeUOddLbEU+sWnr2MTJ9X3NXeAsbHUOZi/kZmf5/9rvmkMqh
         Y84GXem96UNE1J84N+p4SvD2j63k/ElEUb0Upkr+IRz554r9QuTRZo8Wj0PtExkDVyD6
         tiBlIYuX70ZQ/Jdf4ut/1ZiyqkbY6c6/KLdRstB4HM77ceE85SBm5fsIfeQeaGJil9Nh
         8gP11pgnx7m2XVXOrUrT+ite5IKtybvodoWVOkvWqxzXK3mAUbXg5a0+1XGZE7Ib0FQ/
         hlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788877657; x=1789482457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHouJOlSoZUfZv7zUbhzGiE/gfL4Xv2l7AIt3pitCpk=;
        b=ruhYQtdSj5fDXKvwERhPKrWi46FXh66QFy6aBNHmzXNKw//iSl6KDBYsmXHqn+G3Gm
         w6irLH62wKpbrGpR2jtgFjAI63xErVl/SFTfQUaRynWmORaSYYWhSc1RTlp1pWW6dBJF
         /YGdGP4oueUwl0BvNkH24mcux/QCIMYJTK16eFrqVPBr7II4vhwZ5csv4AsgE9HM+6zj
         TSCHVSbAxQiMjyPC0auX+XBkGyid4FrD+JqDmvzWKZ6zx+TAv7wq9SNQD8ooGXizIODP
         kW2ocvgh/+RE+gvW5dgsIrWvbxCnIzSYRpAtnvvX051ld35i1EDdYvmNIaiHZWJqRZcv
         0cdA==
X-Gm-Message-State: AFuF++lx/f3yCdq7D5Syr5GTattEsxYuA4jq4np0lxVVIlaVO0bN8RUb
	rVptOP+3xrajEkMgAvUupILz/VnJ+5+FPqzg6awEyKT4kxuxATJj5FZl
X-Gm-Gg: AYBFou0Vg36U0p22aTvXjopJXhV/roKF1gr1q1vwptCFh9oYnQcHcxg2W8G98nivlDo
	1SdH45wyVXAjGb5Ide4YkPbNCN9BtjU9KzMFqDVPkrxI1Ix/l+Ptd/nn7Vpml6C+ldQOqW0brNQ
	y5D14vp2BZA3Ky6ac3Fh1Ws6TNkT20O2t9ZJcNugilh1pD79nXp5UtwHZPinZdRD+iKCdmRBYme
	Ae3ScQXzp0/VwA42KS4Os7dkY7NsUr/pEyO58KIJJgtUHDhL/ootTH7bO6aJFgtvzCSHgbaX24i
	jmlebuPDXBMMQOIzOmnLLpCkB0sw4THnKJDQIsYBX+3CcG4rjUrS4WzWF5LmBq/C/+hus075qYP
	xftY3wtfN+XX86HRtJ7i3XwcSXyZHRYLAmYC/VgRCY6wdG5gYmWhKnzGdk8tnTUbrP6pQwTAoad
	KoY42GnLqtosVTDNkfEkwPTvQHllxZzAhJw46JfC3bqoHi5wuMXA==
X-Received: by 2002:a05:6820:221c:b0:6b7:46fc:1ca with SMTP id 006d021491bc7-6b746fc0324mr15352994eaf.41.1788877657300;
        Tue, 08 Sep 2026 07:27:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6bac11fc29bsm6801366eaf.6.2026.09.08.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:27:36 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 08 Sep 2026 07:27:11 -0700
Subject: [PATCH bpf-next v3 2/3] perf bpf_counter: Track valid BPF counter
 snapshots
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-bpftool_cyles_per_run-v3-2-60e86f325c35@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
 acme@kernel.org, namhyung@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788877648; l=3080;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=KUgAp3zrDL0Ul2DZZ97zOXAHhN25dAHzINWnDWmOBHo=;
 b=1RRXxxLIlVz9Z4Zcl8UgsDcmOTADnf1YlicHSxVFnlDUFWDS/WtYIO4ShRHhkv6gmGFVotr7z
 E5aRYUnesgZDKgjqn1Yv6+4R6LLKU0Nxd8L6kgP0yezA72EoZxGrGYM
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

The perf profiler uses a zero counter value to reject an invalid entry
snapshot. However, zero is valid when the PMU has not scheduled the event.

To reproduce the issue, fill the PMU with other events and profile a
long-running BPF program for iTLB misses. In this test, the entry read
returned 0.

Use an armed flag to track successful entry reads. Reset the flag before
each new read. The fexit path clears the flag when it consumes the
snapshot.

Fixes: fa853c4b839e ("perf stat: Enable counting events for BPF programs")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c | 26 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
index 97037d3b3d9f..7bc0db26e005 100644
--- a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
+++ b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
@@ -4,6 +4,11 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+struct profile_reading {
+	struct bpf_perf_event_value value;
+	bool armed;
+};
+
 /* map of perf event fds, num_cpu * num_metric entries */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -15,7 +20,7 @@ struct {
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(value_size, sizeof(struct profile_reading));
 	__uint(max_entries, 1);
 } fentry_readings SEC(".maps");
 
@@ -33,7 +38,7 @@ SEC("fentry/XXX")
 int BPF_PROG(fentry_XXX)
 {
 	__u32 key = bpf_get_smp_processor_id();
-	struct bpf_perf_event_value *ptr;
+	struct profile_reading *ptr;
 	__u32 zero = 0;
 	long err;
 
@@ -42,9 +47,12 @@ int BPF_PROG(fentry_XXX)
 	if (!ptr)
 		return 0;
 
-	err = bpf_perf_event_read_value(&events, key, ptr, sizeof(*ptr));
+	ptr->armed = false;
+	err = bpf_perf_event_read_value(&events, key, &ptr->value,
+					sizeof(ptr->value));
 	if (err)
 		return 0;
+	ptr->armed = true;
 
 	return 0;
 }
@@ -52,17 +60,19 @@ int BPF_PROG(fentry_XXX)
 static inline void
 fexit_update_maps(struct bpf_perf_event_value *after)
 {
-	struct bpf_perf_event_value *before, diff;
+	struct profile_reading *before;
+	struct bpf_perf_event_value diff;
 	__u32 zero = 0;
 
 	before = bpf_map_lookup_elem(&fentry_readings, &zero);
 	/* only account samples with a valid fentry_reading */
-	if (before && before->counter) {
+	if (before && before->armed) {
 		struct bpf_perf_event_value *accum;
 
-		diff.counter = after->counter - before->counter;
-		diff.enabled = after->enabled - before->enabled;
-		diff.running = after->running - before->running;
+		before->armed = false;
+		diff.counter = after->counter - before->value.counter;
+		diff.enabled = after->enabled - before->value.enabled;
+		diff.running = after->running - before->value.running;
 
 		accum = bpf_map_lookup_elem(&accum_readings, &zero);
 		if (accum) {

-- 
2.53.0-Meta

