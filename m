Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056143;
	b=EuEQDGUZ9W59CucvYaFNlrctqxreXN4FGgXXzPXiZ/fATZla9/T3FBBQwZzLvAkdxz5P
	 DVjUMUCbXqpj2njjmKC5N1aw+c+Vhct/72KpWRBxaQBOJQrSXTL5DlW8RqhffvN9Aggzn
	 xxEtvYJM8EwaUte1XIlknZE+dInjDzYV5qJ2RfQf5sWNgJj/mwODBoLcXVudIF5Zkvoq9
	 zCOPI8rYTCo/H19PDo6+2ofZg0JUilKh14ooH7tw51b12B+247gykUgmIGlvzbutnTtt1
	 YW6tyUiXsUV09qz0PqEBKa2u//TXr4/+zSpJC7KXVGb5X/I5V7v2O45eqIeExh5eawA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3CQPIa4o2CrpiWm8PlWKCAD284FccKFzo/5k21RIILY=;
	b=4AR1jezbGJsdiCimcBBNuyHE87SqqW4ej8mbY5Un/dKWJQVrdRzEzZokYK/Cv8gB91lA
	 OCKDM+lLUivO5jS3HxcA6KAie2LcF6p6oe493us0Y+RApzLShqvmVHi2YuJIY2kqsfwrW
	 vVJApPXP5NnHoggwynvCiX2iwg2Kb2Kg0Tl980tZlyMnLa1HZR8l1oGHcYSdpnciCuUvs
	 xIsLhzgjAAJb5fDFK7pvPiqBojjRz9NbxBXUpW58w42nGqDmOfmg+ZTzTVz1ZvqyiX39O
	 /Vn6Gh+gSwZ3WtgFOb+v+woriDZX+RlVkhyDErC60xPK8CAagewqJNiF8WvcAkZXW8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=KGjbmVBN;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2C606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 02:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB2C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=KGjbmVBN
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso846088a91.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 18:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1795056142; x=1795660942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3CQPIa4o2CrpiWm8PlWKCAD284FccKFzo/5k21RIILY=;
        b=KGjbmVBN6JsWyIEQhpzhZbTSWmnlzdpBKja0AXNa06hjBmyShYS+9jful5ShSqfJd2
         sGt69Ryt5eIGCgVYTyJk5pp6SfsFKWykwjSb51Oxngra9djaTKiBoKFBp+8T6IyQyX06
         VQUaXBDE+DvD24L1saG/Bvw0q0e3JCR7ntGeMEF7CPcxa+GjO61PWb4jg9Qkh7KujU4y
         Uo8lvqzWA56FXvOoTRPBCqi8sm9FE1akpgCzyo7ngm1Mz+hsCyNGndh4g1CLDRBOLHAG
         McbyjM5Xx3x6nwzEGyDs5NpYW/RRK/+ZRhbxeWif6I/5fSSqyLs6sLqbnNhtolq992gR
         tbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795056142; x=1795660942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3CQPIa4o2CrpiWm8PlWKCAD284FccKFzo/5k21RIILY=;
        b=ageToMnrLHg1DTmntIObpb7W3nnOYVpTZ88w22T+nqXAdDk8oQhb7kXmK3DPqoJkDk
         tJDfbGX6wpj+pcYMN8XqbH+Viih3X/Yc/fNiz30nAyk4PtjYwPzKas1wffDXrY06OnPB
         HuwP4gfJuoOMmEIGoxUmK72OqdJUTm5RYC4hBiaYbCs1OD3Cg3hBF3C+6onMYTM5TdGM
         YlQixr8AnDcpBWaK+/Juc8x0xNd0OIp5ckQVWUBXoaPptchTEi2Yfi3SF4VawxDooSWC
         NMQ6wm/sQJBWQYMUCIQXf2NX+VOjdcMu4msbKrGqdE9zf0ikGGut+cD2dliCmXh7RtSt
         WI4w==
X-Gm-Message-State: APuU4Z989AM/OTGRRb2Qcj6GUl5O4gbi0wFZ+thVNIEa9EOBCynD6ykX
	qeyEUnb2KDUNimXLGxt+tpFq1gYyrohX4pd7RlRs9gQaT5Sc0Dmy9SgFUceI/V9KqGsO3Yi4rFN
	SfkRRgg==
X-Gm-Gg: AYBFou31pkdO6j4c0dKUcMt+36NoSIWY2XF5xPyGqsDS/rPeVlWfMTu1VhQ/j7U1VyV
	kAnxpFgGVX5OiiAe7s4wFHtSvdEe6dAmUlD38KZEdtQi5/p8M9FqU3zY+gCHTYz0utUg3beEPbc
	Tlj3s1bo0WVbUo9x0hxx58ou07PoU0wHPFck7kfBcpBC6wamAqp4sXI1FGImNkU7NBtF88NwDvM
	XrEldufUrLoafxg8oWRv81QZ6yrM18cACGqnFee+NMRCimfyc0zdJjVsd0IJV77flZ02A0Pq8Hj
	Fdc7qi2UzUQOANWpUj+/6TO0N6o7958ePAtz8m+BmehF8WoErjoab4FzNfLXpZ9VKTqvAQS0tco
	Bgt3LmUvcg8PIpEyqvM1c2j0kRquLVErDgzIqJqz2+CFrzTJT5aFSuHAWkL6N+FskWZG3SCyoJd
	3nRjG+61ZSTp9OHa8+3jVwGHnhoXCVDqgQFO/RshU+V4Yrnk7PXtcIrTGZJwaQp25zEAkykH0u+
	6gMdWzOMwkWZF774tFNV96aM6FkNXA9ttf0NhfXHGcODFLgObKqUj6Bt3FJT9CtafrwmaULNL3s
	QOAHFxuOdEQb9LsVOd3midlOOmGAu54blgbZ
X-Received: by 2002:a17:90b:3943:b0:3b0:a7b5:c046 with SMTP id 98e67ed59e1d1-3b3d07e09f4mr4730277a91.54.1795056141961;
        Wed, 18 Nov 2026 18:42:21 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([74.52.12.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4028576e5sm242879a91.2.2026.11.18.18.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 18:42:21 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	revest@chromium.org,
	dingyihan@uniontech.com,
	bigeasy@linutronix.de,
	paul.chaignon@gmail.com,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH bpf 2/2] selftests/bpf: Test bpf_bprintf_prepare() scratch buffer overflow
Date: Thu, 19 Nov 2026 10:42:03 +0800
Message-ID: <ba8b1a0bd63de5eff88f73df1bec0f7f01a13ca6.1794974103.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794974103.git.rakukuip@gmail.com>
References: <cover.1794974103.git.rakukuip@gmail.com>
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

From: Luxiao Xu <rakukuip@gmail.com>

Add test cases to test_snprintf verifying that bpf_snprintf() returns
-ENOSPC instead of overflowing the per-CPU bin_args scratch buffer when
%pi4, %pI6, or %pB formatted output exceeds the remaining space.

Also cover the boundary where bin_args is completely full before %pB and
cases where a truncated %pI6 is followed by %lld.

Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 .../selftests/bpf/prog_tests/snprintf.c       |  6 ++++++
 .../selftests/bpf/progs/test_snprintf.c       | 21 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index ccfb02bd4e7c..dfcb68b36304 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -79,6 +79,12 @@ static void test_snprintf_positive(void)
 
 	ASSERT_EQ(skel->bss->nobuf_ret, EXP_NO_BUF_RET, "no_buf_ret");
 
+	ASSERT_EQ(skel->bss->ip4_ovf_ret, -ENOSPC, "ip4_ovf_ret");
+	ASSERT_EQ(skel->bss->ip6_ovf_ret, -ENOSPC, "ip6_ovf_ret");
+	ASSERT_EQ(skel->bss->sym_ovf_ret, -ENOSPC, "sym_ovf_ret");
+	ASSERT_EQ(skel->bss->sym_full_ret, -ENOSPC, "sym_full_ret");
+	ASSERT_EQ(skel->bss->ip6_tail_ovf_ret, -ENOSPC, "ip6_tail_ovf_ret");
+
 cleanup:
 	test_snprintf__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
index 48a0025cf2ca..3ef50868dced 100644
--- a/tools/testing/selftests/bpf/progs/test_snprintf.c
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -32,6 +32,14 @@ long noarg_ret = 0;
 
 long nobuf_ret = 0;
 
+char fill_511[512] = {};
+char ovf_out[64] = {};
+long ip4_ovf_ret = 0;
+long ip6_ovf_ret = 0;
+long sym_ovf_ret = 0;
+long sym_full_ret = 0;
+long ip6_tail_ovf_ret = 0;
+
 extern const void schedule __ksym;
 
 SEC("raw_tp/sys_enter")
@@ -70,6 +78,19 @@ int handler(const void *ctx)
 	noarg_ret = BPF_SNPRINTF(noarg_out, sizeof(noarg_out), "simple case");
 	/* No buffer */
 	nobuf_ret = BPF_SNPRINTF(NULL, 0, "only interested in length %d", 60);
+	/* Scratch buffer overflow checks */
+	__builtin_memset(fill_511, 'A', sizeof(fill_511) - 1);
+	ip4_ovf_ret = BPF_SNPRINTF(ovf_out, sizeof(ovf_out), "%s%pi4%pi4",
+				   fill_511 + 7, &ex_ipv4, &ex_ipv4);
+	ip6_ovf_ret = BPF_SNPRINTF(ovf_out, sizeof(ovf_out), "%s%pI6%pI6",
+				   fill_511 + 21, &ex_ipv6, &ex_ipv6);
+	sym_ovf_ret = BPF_SNPRINTF(ovf_out, sizeof(ovf_out), "%s%pB%pB",
+				   fill_511 + 7, &schedule, &schedule);
+	sym_full_ret = BPF_SNPRINTF(ovf_out, sizeof(ovf_out), "%s%pB",
+				    fill_511, &schedule);
+	ip6_tail_ovf_ret = BPF_SNPRINTF(ovf_out, sizeof(ovf_out), "%s%pI6%lld",
+					fill_511 + 21, &ex_ipv6,
+					0x123456789abcdef0ULL);
 
 	return 0;
 }
-- 
2.43.0

