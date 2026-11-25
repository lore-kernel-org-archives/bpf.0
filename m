Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577483;
	b=yITom8JyC38F16f5+wIuIJtINb8L+VSXsipJfdco5ocD74Ljo+1SDGyqeoROq1qme2T0
	 ouX7k6sGO5Hzj+qoXsI4srN/Pf982TSjlZJIUqySO04OiIQptNqJpZfu3kewsGqTZlS8V
	 GgSSWc8Oa3rwW/yfJOLLRtKpCRZws0IVJ99s9zKmk0yJisDheuYFWilsTRmURdbW6VrIE
	 tb+wKEWrjFlwTVbs1piQYk9XJlrzSioI0YbApoTBlpOkdf03JGgRADcNsus9hlrBO1nZl
	 lnyw9dAbsTrr6e/1DRmEiWc2KS5bUiZNS4c+Fyfva8g/rLX0FC9kyMQYt0HeGu7BS9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CJBd6GA9VRbmE/pS2LIOZH+b/VEe3xKqdy3lDw3es/o=;
	b=WfUpHDVffqWjcWkCG+4LxEjwfJ1K+3W20Kn8cVn3V2N8tRzfW87Y3f+1M8wif1uwxHcr
	 DUl5bRZGcTnXB9NtgBw21qqOuFaWn9igyOi0BqsQWuHsLjtGTdNPR7NiE3NEMg4LkpY1E
	 qwtTHvRfS5DC5TfD1Obda78P/iizKeb9m2xHCERAFZ2g9+7c5q57vu4KRsy44MYKB/dMn
	 ptJhdZHG6xzf25oghtr5k/18jIZI3URY5ahPlnsvZCAl9cVQaymYL1F5b6X/JH4uK3XsM
	 Yix97gtchkwkqX+SlltVjBAOSg16B0y85RMtsLlHYv9T0UtTD50502k1ObpE60sal3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMnqRfCo;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0A606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB0A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMnqRfCo
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06e79e152so2556333b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577483; x=1796182283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJBd6GA9VRbmE/pS2LIOZH+b/VEe3xKqdy3lDw3es/o=;
        b=XMnqRfCo9LvKNBHRsrvk7nLGvPXvWtsFenE4Tf6DfszawYaswMtrtzM1T3kKPUbgo4
         LX4Kf3xHHH7G/TOMi17UXfixx+gliWugppCDQMJEj1a4U2PN61z/CtmU/n7JkFySXHJI
         w08yRtdYA6Z50S0CZ46OuoJDjNoxGE+XFjj+KIMmGeLG4VzWSm3aoAiVIv8BR6BW4pm5
         /rLUPWgzi/ivaqC03Ab/7Dba8EZlcpdpyH9ZTWThnyDYPUC5aZ9SaC+y6WZFczQdK8Vd
         f7evF5HYcF4aZRLoSztUjBx2vyHJORgq+PJzXT5WQ7dltvVCrmM5mp+W6DPtMHCKIAvy
         uQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577483; x=1796182283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJBd6GA9VRbmE/pS2LIOZH+b/VEe3xKqdy3lDw3es/o=;
        b=u0LduGkS5+8D4z5rGHu1miZ+PeLSZI6RMrm6NNwup6Vuf8cEEyXrpxuHiMbaHrkIGS
         GtJ0/J+iSYmiTXS9yoYf11h8CwKtxAjAy6r60UzIjfz2P3a5YEBYrxHAjGoTlYVc0I/z
         Hgi5RG3h+F8N1ph/0fuPH0lgr2XTvvIu0/yj+eA8CzAribxxcSzjZnl/fOfx/NCHEWU1
         NMZ1mLscpfG84YFAE1715/zEMMwXCMaZRubSGgMwQIDBd9HCOEhxe8EjRwW37WS8FPLG
         cINqE6aMXgDJT4SHXXYSTFf3Y4WWQOiOryVQXzFNPYcyqeephUEtxCIGlinkGJUo+VoJ
         l3ow==
X-Gm-Message-State: APuU4Z9ApCAV2/enoowJOQCpyu9JmTMuS19AH7DJMpqgC5EhZbahUa+m
	Gsd7NvEcwVMKKIdeJQudgwrIbolN/zjNtYQyF7g7ctjTBNhi04iyent6K7eVyVMi
X-Gm-Gg: AZFdTZd32csgd//KvEuQwzHBCeF/4O3x0u6U6+BjPTHD9+gJxe9EZajwowDsBboMFNV
	193xBscqbtX5BnLWLJUCwgTfOjfbTMV3z7i4YiLtJtQtoSMlMgqmU5QVr8PqSSw99foiGzvOUON
	t3+h8z0W4ArgtPfRv5uSwlxktRaz2spFHEbJMq6i3U7+l5ElzdCqCHt76gO8l1vCp8imlIwc9d+
	T7cIQQDytigpD1PgAwl5+ptig2TVkKLX+pjWhSLXH3M8riSqSYhp7wvxbQ+Iiw32sCoYyP17xrK
	pzxEeyAGIoW0JNYaDOggOgyxabCXzvSlZ3y9YVZ/5QDu/2Hpz048/dnX0hGEFTaJzOHyp8mYB/J
	vOEf7mQmJvaNC6IjCvWlAVxsJVvVfhpEMIx/3h2E83rBYYgWAmSFlRM0yB/p7hY14ta9I/YyFxD
	DOOMPZpiJAgUHpoOsrcax5hNbsP9NAjh7aM1T1dNl1D4Br09txqYkUi1lpC3RU9uN7YLC9Y1Q9Y
	SANAO+HS0aq7Ku6S/ZnH54NBsz/OaUxLc5jed2v+Jim1plqZKssKJ5EcPo1QKN/gjBPzqlRh/Ip
	PzmU4YoFMao/lF76vlDENzTbF/sIXcStDe12A/jNyGjlhMcNpmSqt76n/XHi76ubyzw5pEk5PMy
	RzOWT1ozyWk/hXPvBfGI3jsWpv41FRzrJkYCy+zMgQyMjfnI28lRwrywptoQPtAxqfRKFMWslf2
	c=
X-Received: by 2002:aa7:914b:0:b0:89f:1b32:29b3 with SMTP id d2e1a72fcca58-8c8792a498bmr13278699b3a.5.1795577482556;
        Tue, 24 Nov 2026 19:31:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4af1fsm8158691b3a.28.2026.11.24.19.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:22 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 17/47] bpf: Check the attach type when a cgroup link gets another program
Date: Wed, 25 Nov 2026 03:29:08 +0000
Message-ID: <20261125032938.670542-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

BPF_LINK_UPDATE compares only the type of the program. A program that is
verified for one hook runs in another one. In setsockopt the result of
bpf_get_retval() is an errno, in getsockopt it is any int.

Check expected_attach_type, as the attach does.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cgroup.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 88b49238931a..4e388d994d80 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1248,6 +1248,24 @@ static bool cgroup_bpf_storages_compatible(struct bpf_prog *old_prog,
 	return true;
 }
 
+/* See bpf_prog_attach_check_attach_type() */
+static bool prog_is_for_attach_type(const struct bpf_prog *prog, enum bpf_attach_type type)
+{
+	switch (prog->type) {
+	case BPF_PROG_TYPE_CGROUP_SKB:
+		if (!prog->enforce_expected_attach_type)
+			return true;
+		fallthrough;
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_LSM:
+		return prog->expected_attach_type == type;
+	default:
+		return true;
+	}
+}
+
 /**
  * __cgroup_bpf_replace() - Replace link's program and propagate the change
  *                          to descendants
@@ -1274,7 +1292,8 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 
 	progs = &cgrp->bpf.progs[atype];
 
-	if (link->link.prog->type != new_prog->type)
+	if (link->link.prog->type != new_prog->type ||
+	    !prog_is_for_attach_type(new_prog, link->link.attach_type))
 		return -EINVAL;
 
 	hlist_for_each_entry(pl, progs, node) {
-- 
2.55.0

