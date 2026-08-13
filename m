Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7FC499F39
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655815; cv=none; b=hqSkvaiZaAHjBQRgJVJ6AUor/B7K7siH+jsNUasCcJr0IukX/kgDfj7Lo9ETSKjEWSn1Aq8sqnCoPJmbosRGFc0Zlh0FqP/K+L2Dg/qQciLMzkvHhM/oGruZngKtBHPBesRVb+/5twuOCUiXQapAXfQu5n/BB5f7rb7AXF3tfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655815; c=relaxed/simple;
	bh=7l0xVe2LyVfkGorEBGaNMxELLWKDVGFFXB1DJ5Ano04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQ25qnPMOEihFsKr2sd6FT3KJPNiXWEZlgqau9HWpUh7dpLTJZ9R3KMYTeFQo8kxxP3QJecM7u+7I3sLLfeQfI7gM7JiqPYmrsJr2LyU0r6zm9vv1XvPkn9k91lZiyGkQVNQ9qUTCA4xx27CJhT0vhYaAu2BEQyEquu5hq2XXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ0Gfbs+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ0Gfbs+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3811f512167so341781a91.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786655807; x=1787260607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b35On+LZmzrHtmSn5bQB+gzqg4iokp+EtUtdHB8ERVI=;
        b=lZ0Gfbs+VyMopqbFHQm6349hOuQtkCC3yGUpMrcJORx0SpfLTDjA88A6XL55pOlpMs
         ZY+vfHEVHhDc/rS6C5KM4BOp1MCfTTc8VdeyTti8yVwi+O9PP4StUDcLYtxcOJL5tdR1
         PmWZZzOFF+Vu5Weq/xsiyXw7aG11oeQGhHL1rGsltaRi2I+vVxbes+YRgsh9PQgfRD6T
         Lg3bsyqOPZJtTxgu5QF/qtbqzaJxPfGzN+yN6gvbyHBkGo6xdsY+43IN0rLo8P5QoPu0
         dPC9bNO2MCrtKBFEI6BbpOOO0AnZgVBpXPHRDmR9Cn3Oud1ckOVHfc8qMkoGaWwUg3oE
         0EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786655807; x=1787260607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b35On+LZmzrHtmSn5bQB+gzqg4iokp+EtUtdHB8ERVI=;
        b=LwoybjBNo0yjrOZ9Haas7cYD8PF7s+OidgWsPS/G4yrlyQ8TvOqEUh1qkg631vXY2v
         4fkv6yqdpu4QUyijJSWRGtGBq+HrBiCI6u3ZCGp6NILVmz8SXOGqRxg3eOKkQG8Ny3z6
         64kZrOJ0p9h/It/spF++zUE5yks8wE+2s/VpMMNja4rFfNUtmXFGRT+AsEiF05JCQmLl
         0EFa6BN2xtudYHS0vCLVQzZIIOYV8zsY4BcUsdaKYb5xwwuqNNOvpkbM9ylyuvneCkTN
         OgAmIbjCvXk8rc/ga9p7306YbE8tb1hdyp95bmRV0RqcP67i9V4pcca4eITK5fT0IcuQ
         6JWQ==
X-Gm-Message-State: AOJu0Yw+ojnntqeHAlaCjxpB6yVnTHb11H29V075qyMlvU+TOTv9eu+k
	ZioKphF796CBYwJI2TriAemHHQAV982U/z1uI5EC+QJQt05RtsZW1iNraTKlDA==
X-Gm-Gg: AR+sD125KJMuyPOTFM+kbwJPsV63W/PGFOlXY2SXm4pIn0ZNQjDAD+0lufXSexb6fub
	5jXgX9gVLB504crWFeSRG/apJn2LHFIK2dJ/H1W7MAliDIFmWZNp2/8JAXosu9oVlPBfrHVuoVK
	KoiaLRlFMUOsiuWkq+1idyllwwqFuX0pYVIA/HcCAake/hZgbnN433/a7HErsSqol/9/oC0QJPi
	v0P0Y6c3Y+2HGofincipk9PnH9wzctYU10CGREDWU16XVY6f24YhC9n1VTIH0bIWKb4Tbhfy1br
	Q+h2C5afvzSVsYUpHT4aDuW2vhxulE0zjBIDet6zktsN8U6i1PgkUDSZ/WGedVzsWtbQmkkP93L
	FgogvYYTP7JMxEt1cUj3TGxgUVBmlQyo5taXwzNKdiNBsjavaJwfivsQ/FQkSOReIcJa44iUIBR
	LaRM4OjLcDhg6x4s1R204EE22V49tW7DNihEpw0EEFGsdMwbVcPdISeQqnZpWXeqFBYJ5BY6QX8
	0E7g5XoQm4SdsJu
X-Received: by 2002:a17:90b:5807:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-3933b958ad5mr945995a91.14.1786655806903;
        Thu, 13 Aug 2026 14:16:46 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933a03e288sm853985a91.17.2026.08.13.14.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:16:46 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	dingning04@gmail.com,
	sashiko-bot@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Kaitao Cheng <chengkaitao@kylinos.cn>,
	Viktor Malik <vmalik@redhat.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Test untrusted allocated-object pointers
Date: Thu, 13 Aug 2026 14:15:26 -0700
Message-ID: <20260813211533.290256-5-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813211533.290256-1-dingning04@gmail.com>
References: <20260813211533.290256-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier previously allowed pointers used after RCU protection ended
to reach bpf_refcount_acquire() and, for one object layout, a direct write.
If the object was freed and reused, these operations could access stale
memory.

Add tests that keep BPF_PROBE_MEM reads accepted but reject reference
acquisition and direct writes after RCU protection ends. Cover both tested
object layouts.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 .../selftests/bpf/progs/refcounted_kptr.c     | 100 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          |  27 +++++
 2 files changed, 127 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index fd35093285c0..383c5b1b7111 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -893,6 +893,106 @@ long refcount_acquire_rcu_map_kptr_null_checked(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__success
+long map_kptr_read_after_rcu_unlock(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *n;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
+	if (!mapval)
+		return 0;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+	bpf_rcu_read_unlock();
+
+	return n->key;
+}
+
+SEC("?syscall")
+__failure __msg("is neither owning or non-owning ref")
+long refcount_acquire_graph_after_rcu_unlock(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data *n, *m;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
+	if (!mapval)
+		return 0;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+	bpf_rcu_read_unlock();
+
+	m = bpf_refcount_acquire(n);
+	if (m)
+		bpf_obj_drop(m);
+
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("only read is supported")
+long graph_map_kptr_write_after_rcu_unlock(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data *n;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 2;
+	}
+	bpf_rcu_read_unlock();
+
+	n->key = 1;
+	return 0;
+}
+
+SEC("?syscall")
+__success
+long graph_map_kptr_read_after_spin_unlock(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data *n;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
+	if (!mapval)
+		return 0;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+	bpf_rcu_read_unlock();
+
+	bpf_spin_lock(&lock);
+	bpf_spin_unlock(&lock);
+
+	return n->key;
+}
+
 static long __stash_map_empty_xchg(struct node_data *n, int idx)
 {
 	struct map_value *mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index acd3e81a3916..0cc4cbd0c81b 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -127,6 +127,33 @@ long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__failure __msg("is neither owning or non-owning ref")
+long refcount_acquire_after_rcu_unlock(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *n, *m;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
+	if (!mapval)
+		return 1;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 2;
+	}
+	bpf_rcu_read_unlock();
+
+	m = bpf_refcount_acquire(n);
+	if (m)
+		bpf_obj_drop(m);
+
+	return 0;
+}
+
 SEC("?tc")
 __failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
-- 
2.43.0

