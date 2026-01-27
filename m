Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E24322B6F
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503884; cv=none; b=Dar/qEYLm7cQ3OY+/XsYxjUwOFNJqRW8p7v3FKxuEFUpdsheemXWZMjckIFv3WJGRasoMYvQ+99T8c5/ZycfYgbHxJ+5PDcUc2IzKDkrH/5qNyrrPNbO962lgPPCwpecggjoopt1N3/IdBYDOg98v6lkeQn0U08LXPGFKXR2cA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503884; c=relaxed/simple;
	bh=G68Dq5uotXDDmF6W/yUF/Wv/YrPOkH5kD41ucZGh8s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Psnlduspy+7lUtmVKB3lU5vbHB9QvkSsIWu+lvRCKvXGcxghW7BVtKESS+nn4Z8Hnv81WyhtGs12ufjOyrdQo2JdJIOnROXNd/85oJoABa5edEkcFB4uOU7FX5LMnmSdgofHke8DbnWiaY9e89V7EgVSgL+/lMPwXvXMWltpkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/CaGy4r; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/CaGy4r"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-658188b600aso5498753a12.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 00:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769503881; x=1770108681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+IJJCyyVImDStJfGM6t/TK2Ts9pULEJzvxZsUw9TPc=;
        b=x/CaGy4rOfVyqKnnAAsk2ts/d0TEweXf58Wc7Pd832oA+zZBDuGEaemmf2Yq3MkKZV
         uk/b4EgQSnLYAE89YlC3NB3LsvKq2sq69Qk/1boogplrRYzaliAshAWbJ3fn1wMicQSr
         jm2N3VjxhdVB7KhNeLC5rJOTpy/DYHpZ/Q0VfCD6dA6aWLWaxjIY9721/A9ZeWWfsNN7
         cqLAFvAJRJSOwioRG7pdi4/+xsjc0TBIDx8bLYZ6S3sJVQn93wX5oG7xjIacgytq4KIH
         /ceWOCWAsKGJrANl7LO1bcTF+6tlvv2UULmKNct1atCiFpiF3edOdkvoLl2pSz6gatlf
         JF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769503881; x=1770108681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+IJJCyyVImDStJfGM6t/TK2Ts9pULEJzvxZsUw9TPc=;
        b=cA265RDXZf7fuqPG1YCaVxuEjgLRacFRCRdKYUM6DXNo6OZ6eMpYqCc+fAqlema818
         hZbQ1WWDcgLWsKKOHfrX0jZZQsAsovj7ISpywdPpdFnRZuEoG0H21Ealjsi95cYv7lTP
         Fk22CvKw1kfxWePqeuzHcvcZjbxm3qF2pFZJbIMTU91un2xCejHxGquumJpmfpEX/j99
         p2+pBlt2tMsCSLl0XgOIEx01nh957xoYa91fvkj5rvw2RtPwJqic10QYP40acEAbmXxn
         U2CSBPZEjmp5aURntz85M0LMPHYDHMKYwuD6ko6Oay49qHgXzu1jXSgRYxJMI4pVWZ+h
         RxBA==
X-Gm-Message-State: AOJu0Yzvgu5773rBWspA4bibqwZ+X6tWBJ9w5s4HXsGrxez8Re3IYQwm
	0NQQqkO3ulegQs9VU7zDjvj1hsjLjLF+R0kzYYJzH78xJHNzZKP9kFOrgYxPhy8jg9ttcT19+Sr
	UGhJvyicl+1q8Bn1ABoeRpyGsSydot0+2wqil6DF6rKv1EVId8jl/7WRmlyJqK6uvbC71QZ/OUn
	x2I2Y5bFRccaoSvSZmZhxiO2SUvJCchm7w2Q6LDpC37Ac+/hDXMn+eewK38oyyc8nlmhmYRg==
X-Received: from edbbf24.prod.google.com ([2002:a05:6402:1a58:b0:64b:b4ca:3957])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:234b:b0:649:815e:3f9b with SMTP id 4fb4d7f45d1cf-658a6015982mr752942a12.3.1769503880654;
 Tue, 27 Jan 2026 00:51:20 -0800 (PST)
Date: Tue, 27 Jan 2026 08:51:11 +0000
In-Reply-To: <20260127085112.3608687-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127085112.3608687-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127085112.3608687-2-mattbobrowski@google.com>
Subject: [PATCH bpf-next v2 2/2] bpf/selftests: cover BPF_CGROUP_ITER_CHILDREN
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
cover the newly introduced BPF_CGROUP_ITER_CHILDREN iterator control
option.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
v2:
 - Renamed the new bpf_cgroup_iter_order enum entry from
   BPF_CGROUP_ITER_CHILDREN_ONLY to BPF_CGROUP_ITER_CHILDREN, as per
   recommendation from Alexei.
 
 tools/testing/selftests/bpf/prog_tests/cgroup_iter.c | 12 ++++++++++++
 tools/testing/selftests/bpf/prog_tests/iters.c       |  8 +++++++-
 tools/testing/selftests/bpf/progs/iters_css.c        |  9 ++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
index 574d9a0cdc8e..0f88a9d00a22 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
@@ -190,6 +190,16 @@ static void test_walk_self_only(struct cgroup_iter *skel)
 			      BPF_CGROUP_ITER_SELF_ONLY, "self_only");
 }
 
+static void test_walk_children(struct cgroup_iter *skel)
+{
+	snprintf(expected_output, sizeof(expected_output),
+		 PROLOGUE "%8llu\n%8llu\n" EPILOGUE, cg_id[CHILD1],
+		 cg_id[CHILD2]);
+
+	read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[PARENT],
+			      BPF_CGROUP_ITER_CHILDREN, "children");
+}
+
 static void test_walk_dead_self_only(struct cgroup_iter *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
@@ -325,6 +335,8 @@ void test_cgroup_iter(void)
 		test_walk_dead_self_only(skel);
 	if (test__start_subtest("cgroup_iter__self_only_css_task"))
 		test_walk_self_only_css_task();
+	if (test__start_subtest("cgroup_iter__children"))
+		test_walk_children(skel);
 
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
index ec1f6c2f590b..5a1d87d186a9 100644
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
 
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_CHILDREN) {
+		children_cnt++;
+	}
+
 	bpf_for_each(css, pos, leaf_css, BPF_CGROUP_ITER_ANCESTORS_UP)
 		tree_high++;
 
-- 
2.53.0.rc1.217.geba53bf80e-goog

