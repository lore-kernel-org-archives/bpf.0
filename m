Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBF47A0AF
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003696; cv=none; b=a6mgXtM8sLW8HQHtv2B03wbg6geErHpjiB6g/LTuD/32OPOltCMwyTRgjazCVeTl4joUmOMTMTcqCMLQMwWUQvvSPu+iIg7kMwR00YJhYi2v5tPSR7wsqoYQPpcVDjtm5EK4YQC+1spK3R7cKaaVX7PCn3daAMpdmkolzPWBUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003696; c=relaxed/simple;
	bh=yoO4GnQHmT15ZT5Z911rNKC8G4iPmPMaowqHtqqnEuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M/S+rwbW87c0dXT1AFVtlG0lKuOYlLR0eyFPEWRvieJnvjj72qSwgGLkuX1y9ZdOW1TejDhrKXTFC/lYdA91V3EfEe0U6jDbt1hYv2V9kfheDQVclv/f5G7RcC3Z/LT0Eg+a1CDc5OMIgN1lkn5cGJpXbqMtUSuN4mnEzFYKl7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zsgnYEnd; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zsgnYEnd"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6539bfdd9easo10217412a12.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769003690; x=1769608490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7KtuztvTCVJE6kooK5KtWMzDYHN8HwXc7vg244+QJk=;
        b=zsgnYEndp4F+S321QbJtLF72Ml8tu334GWiHYdpTZn11z9l/ht1pHvxZ7nfHmC6Qdy
         Q5PVwQ3a8kbn1E/0UMn76y7KPJAelLioEXlmTxoZsLVjcW8hFzqPqnDCc5gZz51NHf1o
         RUIQJq8Ig8JRNTAErusASGmNYP1g4z7UCBsWbu5DXMwHvNqSWYX0+2HyQXRBms5h85M/
         LOqpB3eRgw8gpPOENUvOfv5lGedfQFE8mmgIFs5hBUoxXbG/HWUiZPeCeTvj/WrMMzlN
         NJ20A+1KaVeUNsxDMxVue5xQ8p296g1Dz9wiI0Fi6nmv6/VwXJbVVlQX5w3lb3y2C6nB
         ERCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003690; x=1769608490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7KtuztvTCVJE6kooK5KtWMzDYHN8HwXc7vg244+QJk=;
        b=FbYCSeih5OcJONnA3kgyTSY8RopWFooi6LXvpGmHQNjW56v2y/oA6MAQn/X2o+lwUO
         ExVvurAkyzCHW7J9dskvI+chwYBAus3zZPzf1CFOiYax/aE8X4IEn1Gttol6wL6Rcpzx
         hgOl5movS8bo36wsJSFN9d380gfz/5piZ+Csx9qGQoBL7i+7DHsdkiQY+KxzvP9EVIFY
         Qm73CD3wv189jq4S6p7bxtmvJhNPO10Whej41Ji9YnVMUHTj/A/UHG6J4ZgkUWPGd4CL
         ixFbhku8UUQFPlNCmfeNslnfv/2x33wSqExOXWX92H6U4Hs9EX/6F8m9Ui7dSHvYf3XC
         1nEA==
X-Gm-Message-State: AOJu0YzG/tG8As4QgtnO3Te5SVl/diBBvmQmKTtsS6A5Q9uQ7YNEyaVC
	jI2Tz9X09D6/hQjDd8Znc77DQxxlmEzagIY8Gofx/+WtESOuminh52xmqfdXebcVaKSsxesfHEJ
	3eAg+pAn2XrP15FTMhIWhBUZknLbFjAdnfivhaQjANfCbqpRrXf+tT8HvrZIX4YcC4HkTQmhIqP
	7mBoN3AC7+7gq0QW/Cef4qrG70+2yua44dtCgXnyGf27WBqRU/hw1KlmZ7OaVZsPVR3q2nKg==
X-Received: from edcl14.prod.google.com ([2002:a05:6402:344e:b0:650:98d9:a16e])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5248:b0:64b:a1e6:800e with SMTP id 4fb4d7f45d1cf-654525cba2dmr12854444a12.8.1769003689687;
 Wed, 21 Jan 2026 05:54:49 -0800 (PST)
Date: Wed, 21 Jan 2026 13:54:44 +0000
In-Reply-To: <20260121135444.187001-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121135444.187001-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121135444.187001-2-mattbobrowski@google.com>
Subject: [PATCH bpf-next 2/2] bpf/selftests: cover BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	Tejun Heo <tj@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend some of the existing CSS iterator selftests such that they
cover the newly introduced BPF_CGROUP_ITER_CHILDREN_ONLY iterator
control option.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_iter.c | 12 ++++++++++++
 tools/testing/selftests/bpf/prog_tests/iters.c       |  8 +++++++-
 tools/testing/selftests/bpf/progs/iters_css.c        |  9 ++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
index 574d9a0cdc8e..07c85c0cc204 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
@@ -190,6 +190,16 @@ static void test_walk_self_only(struct cgroup_iter *skel)
 			      BPF_CGROUP_ITER_SELF_ONLY, "self_only");
 }
 
+static void test_walk_children_only(struct cgroup_iter *skel)
+{
+	snprintf(expected_output, sizeof(expected_output),
+		 PROLOGUE "%8llu\n%8llu\n" EPILOGUE, cg_id[CHILD1],
+		 cg_id[CHILD2]);
+
+	read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[PARENT],
+			      BPF_CGROUP_ITER_CHILDREN_ONLY, "children");
+}
+
 static void test_walk_dead_self_only(struct cgroup_iter *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
@@ -325,6 +335,8 @@ void test_cgroup_iter(void)
 		test_walk_dead_self_only(skel);
 	if (test__start_subtest("cgroup_iter__self_only_css_task"))
 		test_walk_self_only_css_task();
+	if (test__start_subtest("cgroup_iter__children_only"))
+		test_walk_children_only(skel);
 
 out:
 	cgroup_iter__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 3cea71f9c500..a539980a2fbe 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -253,6 +253,11 @@ static void subtest_css_iters(void)
 		{ "/cg1/cg2" },
 		{ "/cg1/cg2/cg3" },
 		{ "/cg1/cg2/cg3/cg4" },
+		{ "/cg1/cg5" },
+		{ "/cg1/cg5/cg6" },
+		{ "/cg1/cg7" },
+		{ "/cg1/cg7/cg8" },
+		{ "/cg1/cg7/cg8/cg9" },
 	};
 	int err, cg_nr = ARRAY_SIZE(cgs);
 	int i;
@@ -284,7 +289,8 @@ static void subtest_css_iters(void)
 
 	ASSERT_EQ(skel->bss->post_order_cnt, cg_nr, "post_order_cnt");
 	ASSERT_EQ(skel->bss->last_cg_id, get_cgroup_id(cgs[0].path), "last_cg_id");
-	ASSERT_EQ(skel->bss->tree_high, cg_nr - 1, "tree_high");
+	ASSERT_EQ(skel->bss->children_cnt, 3, "children_cnt");
+	ASSERT_EQ(skel->bss->tree_high, 3, "tree_high");
 	iters_css__detach(skel);
 cleanup:
 	cleanup_cgroup_environment();
diff --git a/tools/testing/selftests/bpf/progs/iters_css.c b/tools/testing/selftests/bpf/progs/iters_css.c
index ec1f6c2f590b..c74d3075ccdc 100644
--- a/tools/testing/selftests/bpf/progs/iters_css.c
+++ b/tools/testing/selftests/bpf/progs/iters_css.c
@@ -12,8 +12,7 @@ char _license[] SEC("license") = "GPL";
 pid_t target_pid;
 u64 root_cg_id, leaf_cg_id;
 u64 first_cg_id, last_cg_id;
-
-int pre_order_cnt, post_order_cnt, tree_high;
+int pre_order_cnt, post_order_cnt, children_cnt, tree_high;
 
 struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
 void bpf_cgroup_release(struct cgroup *p) __ksym;
@@ -43,7 +42,7 @@ int iter_css_for_each(const void *ctx)
 	}
 	root_css = &root_cgrp->self;
 	leaf_css = &leaf_cgrp->self;
-	pre_order_cnt = post_order_cnt = tree_high = 0;
+	pre_order_cnt = post_order_cnt = children_cnt = tree_high = 0;
 	first_cg_id = last_cg_id = 0;
 
 	bpf_rcu_read_lock();
@@ -60,6 +59,10 @@ int iter_css_for_each(const void *ctx)
 			first_cg_id = cur_cgrp->kn->id;
 	}
 
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_CHILDREN_ONLY) {
+		children_cnt++;
+	}
+
 	bpf_for_each(css, pos, leaf_css, BPF_CGROUP_ITER_ANCESTORS_UP)
 		tree_high++;
 
-- 
2.52.0.457.g6b5491de43-goog

