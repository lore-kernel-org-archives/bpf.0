Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070EB2C0F8C
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223058; cv=none; b=SJginSaJw2QVpgFuH5PxKFKdrq88ufqG0jjygdUind6cZF32ORr7pleNOIKnebCsHsa/C3tMlz14/z5uJgKeJO4p1FLxoaiESBn24FqYHbKR3oYW3Pl0XvVMkgD57s1fzGJwdMMfnhILbxTLndfVDXnOaLWeP8SNx+e7aBk40Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223058; c=relaxed/simple;
	bh=NBAa8KvnhLAyM5tCDtL3eb8ZnD/4h9/mUW9crObTVAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjPZn+zMXlH6yXkoZtG/Iw0Hr+wm/QInnE5J9xZnyNGuJL2ZKjozcrQxJTjE/M07d6p5k0tj1JUJNDivQdURzucsnuBGe+IitSWOuCpwBrAwvJEMmbY1TK/3IKkEBiRuO1ULX4yJzT/Sd42z/wH7/eSJMXzRCVGbe2ifH/kkE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVxYjgld; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVxYjgld"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad9a9be502so12489415ad.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 06:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775223055; x=1775827855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akaUaIjxJ8vFNIqWVod+KFW2az/YZHbrHCjTme00AdI=;
        b=QVxYjgldWEaDBD/795nAuVLwBcnbbO1MQ+ZIGNAaNqO9UP30A7nuI0A/pikjJW7k7S
         QItGCEKJQG/b0K4A56eKl+jUY97aXrGe1SENW4TjbDrkdmt7Ry/GZXmLAgxg6jwidHhr
         P29ppE8679jsRbyEJQe25ysJdGZnAQzJAmd0SJW4F8yvPj7+GQwd9IFSTP3GM/G+UqI0
         14EsPWn+Xh9dTAylLHm2hLCv0veqzTS8e2nfsAg0slx47b/OZTk/+s6vPseH7d/40wdM
         JpkP4D4pnjW22kAWe4mN4L4XgyPVottnIRmWsvu6SPL+W1UBx2RNcVyBk/Agx91pFUgz
         gS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775223055; x=1775827855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akaUaIjxJ8vFNIqWVod+KFW2az/YZHbrHCjTme00AdI=;
        b=tJ0fXoJGxNgwjY3KHi8iTyX56T4+KCQHT2NirYwGK/r6RQDsdLJLS/e3tlY6rsKWsG
         IV+0xKizf5vZymUGieJj9MmJu3Itdmo0kpjD56pObDe6Uuq//Rz7e4UkT34ZrMqAnqMp
         QV9gOI1wjms9p7h9zCFL/WUgYv6xIFqIi0/i5AZdF377jEFpyV8Y2vLxqYPIMV6wWzsl
         TnGvu/qu5KSb0nB65w9lqVr6McoXwyjzPdqVcbUO727buFAZdEtnd7miu/ETpvrsEiWi
         ZDju0PFcOgzUeP7pYg8JaAb5i+cUQQIOaSxfXpf8XduY2IJMQzTatuEXbH5S74mAovcd
         JXjA==
X-Forwarded-Encrypted: i=1; AJvYcCW0S/QdQ71q8/XvMUT3lINjk++FGJMf6t8GFoofu265Aj1Kcb60Spg56cj/Whd/L5JhvF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWGeL0g7mIAUn1+eunxORxNXobHCEoXoWzBh5KpbLEnZ68/zg
	YMTMhqDMPDJeH1Y6Ec8WY/1pDGnrbniSUB2dbJPd9btz6d14ZNEAEDP0
X-Gm-Gg: AeBDievuyRZBkvTSITPFhx8Aa6y5J/KCQaQf+NRU1Clwnpf4xGuHifXJh46YwKsh8b3
	p1yQZV1bSyo3y0b7aTp3kXv/mjTlnbNw/h7/eYmJCOJa3XIAVzm8m4UfdZpiUwNMmIiQic7ZxT1
	9X+xu7/v/B4j0VNqQd9YqHIi4Z4HojIgXSK9t5iLkiEiW0ipHNWGPwEP3eVw7qfFx5SXBQxOelO
	A0eC1U+dBtBlDvCifr1pCoHvKGd1w1qlnPKdyC7D9nBZCAMw+ay+2opOmr1rGuKj7Zz98k3rnUh
	5boHp3Pb3VbJXA6HRUyuDnVL9U+xowBNehWJbgPtSOFDVE/VtrfGSP7MoaUM7bJcyGLiBJXWN2p
	cP/0aOYxGoCQKuYNCCXkkp/SURTwVAiXMdqIYHUx2L+QBSjVrPRvTe89bz+M1wiKiguHM/taYSk
	FiBIYy12XFjLB6gkjgPNK+AypMEnelfB2qtja4amVNjdkwFtAR1XeEIEKGg21z3Dyfh66/u03UV
	stD1LWwedpc
X-Received: by 2002:a17:902:f611:b0:2b2:470d:6d0d with SMTP id d9443c01a7336-2b281706f78mr35349155ad.9.1775223055210;
        Fri, 03 Apr 2026 06:30:55 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm64221225ad.55.2026.04.03.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:30:54 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: add get_next_key boundary test for cgroup_storage
Date: Fri,  3 Apr 2026 21:29:51 +0800
Message-ID: <20260403132951.43533-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403132951.43533-1-bestswngs@gmail.com>
References: <20260403132951.43533-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that bpf_map__get_next_key() correctly returns -ENOENT when
called on the last (and only) key in a cgroup_storage map. Before the
fix in the previous patch, this would succeed with bogus key data
instead of failing.

Suggested-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_storage.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
index cf395715ced47..5451a43b3563e 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
@@ -86,6 +86,11 @@ void test_cgroup_storage(void)
 	err = SYS_NOFAIL(PING_CMD);
 	ASSERT_OK(err, "sixth ping");
 
+	err = bpf_map__get_next_key(skel->maps.cgroup_storage, &key, &key,
+				    sizeof(key));
+	ASSERT_ERR(err, "bpf_map__get_next_key should fail");
+	ASSERT_EQ(errno, ENOENT, "no second key");
+
 cleanup_progs:
 	cgroup_storage__destroy(skel);
 cleanup_network:
-- 
2.43.0

