Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E136A03E
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986010; cv=none; b=JLdTo5Qn6aK5WJ0bI6DjFZmIXLQTYbxeuOZR4cY9nws6IrKTI11sgHvcqE6BizHQo7VjLw6nolRxmaLAiJEFdMwr+d5DRFVgDJjXZ3C4HEghTd2yFAViS6bdEO6fw672VZ27970DihtgyGVCVEIY+3eRkuL6FC+6HvHfsEUm4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986010; c=relaxed/simple;
	bh=S6n/neKISCSzM29NHj/63iqM5/qKiEnr5ropUVMdgsU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jJmARM7gpie/LR9DphyDpYBj2ug3YcsKdm+heBlOn1+24NsqCJGuMXoV9WhrBHBJOT2g0gctxWm8Fr1K2U1ZxLsOCQkoOJdyBrbeAiCelZ460cICKnNtK/5UGRq2C8/GfRAepu7dS5b35oWfypgQUjdcuwIZrDYfFyBQXyjK9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQjfnxbK; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQjfnxbK"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8704795d25so648413466b.2
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768986006; x=1769590806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wWMq94oL7IhIJcL33R09pLkjLgUCc6fGcwJGq/npn/s=;
        b=hQjfnxbKyEUikPqZPwAD4djStAjeruudN6IWsFt2b2IWBdq1kKKnS3NRh90ORG7+H3
         9iJzuNu/14dQU5JmVpFBpzB79Tv5TwSd+fm/mIu0XjHlzd6NgEEOEmfC7JElP79Fdtgh
         1pTJimpUsL2l279Xuu4IduaU6gsVLan6dZ/2O1jeEefnqfsYcsE+Rv10kO+FL35aWvsh
         SEIlG9AYHaPYBr0rT11/DP+AfXbLhJwPqkbfUONzTzwMyCG6bUCxGpA50ihN0Qlarx1Q
         e2QwMa/g07vQz3iTBEHRmhrzPGnDjcF8Svzn0KojI1XSVaLmXvwGsvYZeer27T4D/qvD
         /orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768986006; x=1769590806;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWMq94oL7IhIJcL33R09pLkjLgUCc6fGcwJGq/npn/s=;
        b=uNTGwpCC0UrYOXAWPRYUioB1CxQ+CG/+F3wsDxqvBQiT5eaF7ZdQCIlC5MsGM9wcPJ
         kO9PBncTC7Zvn8ZJInhOK4hWv/B/A+lj2+bHET0OaPSqDcoFBH0QASLzwzC8UsoeDDqI
         1BAthkpMK615XQn4Zyh+9fjrGM1WCMG+MEFGwkzeUk6TnUl6c3ft9QP8oodNSSN+LwXE
         yCEwSuqwcO7h9F47QuDBftfn6ZPIAxtQRdmmJsazHJyVt6ZhUUuJ2a3MYsndkBrAPRw2
         DOMdkld63eTkXZq2jHtNcjTff4THR9+dQ4sH4+Ly/AzNMi08bJNTVuVXHxiEUlLtC/sb
         z55A==
X-Gm-Message-State: AOJu0YyOULRNWIuGeJK9hX7J9DLdSX1qJxUN/FPJXfGq9wT5tEnXOXC6
	bLgBnfVOaK6+qdm+L8cI6B9vpnjX1M06r9juwkqHwLF6Znn21+b55zqDeBBI4E529zUqD1+SZhM
	M/4D6vvpbFZf+O4xJNGul8OEQgFY2MQPfhL51mwmlh1TjcpvIfyKZi3uVwX+warTdfx50clMH8s
	aUfKNzLfG7e67xTjkC8FPfaecgWnxtBlLJctBQ/7CwjqDC/T3gPpewv5HrB6KpYlKLkotz4g==
X-Received: from edca11.prod.google.com ([2002:a05:6402:33cb:b0:658:115d:b7d4])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a50:c8cd:0:b0:658:12bd:4905 with SMTP id 4fb4d7f45d1cf-65812bd4af1mr1125985a12.8.1768986005568;
 Wed, 21 Jan 2026 01:00:05 -0800 (PST)
Date: Wed, 21 Jan 2026 09:00:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121090001.240166-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] bpf: Revert "bpf: drop KF_ACQUIRE flag on BPF kfunc bpf_get_root_mem_cgroup()"
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit e463b6de9da1 ("bpf: drop KF_ACQUIRE flag on BPF
kfunc bpf_get_root_mem_cgroup()").

The original commit removed the KF_ACQUIRE flag from
bpf_get_root_mem_cgroup() under the assumption that it resulted in
simplified usage. This stemmed from the fact that
bpf_get_root_mem_cgroup() inherently returns a reference to an object
which technically isn't reference counted, therefore there is no
strong requirement to call a matching bpf_put_mem_cgroup() on the
returned reference.

Although technically correct, as per the arguments in the thread [0],
dropping the KF_ACQUIRE flag and losing reference tracking semantics
negatively impacted the usability of bpf_get_root_mem_cgroup() in
practice.

[0] https://lore.kernel.org/bpf/878qdx6yut.fsf@linux.dev/

Link: https://lore.kernel.org/bpf/CAADnVQ+6d1Lj4dteAv8u62d7kj3Ze5io6bqM0xeQd-UPk9ZgJQ@mail.gmail.com/
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 mm/bpf_memcontrol.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index f95cd5d16f4c..716df49d7647 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -13,12 +13,12 @@ __bpf_kfunc_start_defs();
 /**
  * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
  *
- * Return: A pointer to the root memory cgroup. Notably, the pointer to the
- * returned struct mem_cgroup is trusted by default, so it's perfectably
- * acceptable to also pass this pointer into other BPF kfuncs (e.g.,
- * bpf_mem_cgroup_usage()). Additionally, this BPF kfunc does not make use of
- * KF_ACQUIRE semantics, so there's no requirement for the BPF program to call
- * bpf_put_mem_cgroup() on the pointer returned by this BPF kfunc.
+ * The function has KF_ACQUIRE semantics, even though the root memory
+ * cgroup is never destroyed after being created and doesn't require
+ * reference counting. And it's perfectly safe to pass it to
+ * bpf_put_mem_cgroup()
+ *
+ * Return: A pointer to the root memory cgroup.
  */
 __bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
 {
@@ -162,7 +162,7 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
-BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
 
-- 
2.52.0.457.g6b5491de43-goog

