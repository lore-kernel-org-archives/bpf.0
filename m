Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190373DD854
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689016; cv=none; b=HhZrQNxTW3pZnu53KWE8h3vE5RtoCKvhYFwuakTaJ8hufZculd3uReuQtz9td9UVzY+HZQRifDB0aeKKeS1wu9H7mYbZWTHsPbzHHuXhTMksrGtLY5WugLOTgSPJ1lIYExB7sboE8IYFTWCJVESWGNIC41OzmIe0NTrL4NLw22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689016; c=relaxed/simple;
	bh=PdBtwKgFqyMGtomh7hTUPsscrriY96d4wUo+kESMV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP4/SykK/Huxi1WscXOSM8eA8k+MA52usSoCrCIC04CcT6Wi3yeArnsc5OlfaEGFIyLsWT7VUM7+qZfcQ9x2abfD+nRUmRuoyzOhfxhlzNZdZO0MgQTBIVG+cRbLAXkIuGNQErHHyOAklDx670IpW8oCA9Pst28y5h96Uige0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2uObVUW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2uObVUW"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423f869421so4342617b3a.3
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781689012; x=1782293812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HGsJuBJyPxuBJWOZpUxJqFkb8helZpMElVirEJAoUU=;
        b=P2uObVUWQDzWZwNk/QWV/rrp23bBAIo0SmfraD9noK8JbCi5hI7Xfwfx3xgUlTr3FM
         EV+wjcIPCWnstK6iSe5US6+Ocy92HHT8Bu5M2Xw3Id1pFJkj2gAZG05WwZZ2OLBX9xmn
         rK0yINbI+f30A3e5dUgnRcOYh8VRa+mQtivTpOsD/2QHcwhP3bpXABdzj90MvpQ2l/5V
         cvwzccJKCr+kF00nPKW8Dms9R44mUHW4cc7oTaSaVUOxD2W0zMfcnEQ6lfND6w4PIrlT
         GbE+KdD/CwjzAONSCaYe8Q+VHYKIsy2q0ybc3hqoSdyxJkfAlPQEZkv1APeNFRIPkgu6
         Hw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689012; x=1782293812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HGsJuBJyPxuBJWOZpUxJqFkb8helZpMElVirEJAoUU=;
        b=BqNZF6yeHjETcmwz2YCbqzmw7Unnzpo4+GLXIiVx7WQ0pydLfsYOJTqHmZ3O/ryRkz
         MX1MivXYihxqj1aFXSui4NY2JQSFBXuRaeBGAXwDyUNbGq4I/f9NwD1X2azp/sP7QtvX
         FteofnewnfZz4hBvq00eqyx4rBR6DtxmtRyEpnmwltNw27+MVmROpDtDPjJ+zEx3MRCs
         9VqTal+6VDiXuldbpGvkQ0i1U8PVqlUQzMDiSWp22See/QQ9OaYkuQa7PvRsVL/Yko0E
         gTrkDSw8KsjbyRucvEiz0+QHV5uOT4wqf6nZaSdqERmHqzv8xYF6xEzLhVGLqus42e7F
         4lpw==
X-Gm-Message-State: AOJu0YwMP/EbKhmd1iAoXwdV0baGdaGXkudCOhEyqieYs7duimneMIuf
	vroIEF2uSVxbJRnG146c35EgyUUTgbSceCind0a/P8stVjTjuzHKATwPmMQwsetKhgo=
X-Gm-Gg: Acq92OHHf3+LZJ3eJNhTKJatFOY1nZTJHNEScO5+X4/H9x9GSQJr6e/DtEUzkh4PMyS
	bsIUZVK4mgzuKkD4LSI6HoAZyo8LH9SleCa1JwY0jMe6OpNKO8JjUK1VY64waqxsqP/q8g+yoM/
	gVwgXYNa+Dpc4+o5g8xKSLc8L6DpowGrrpJsSZHQ+vn3GoappzteaCcqol8ShDzkmQ5GTIyuYXG
	dzY8TqGy06zclpq1tl+4ejLBuyXDDIfFek64H/VuB7nCnv2+tAtjxsxuGEAnu8C0GmQHVcJhoqr
	omNBb4g2zoatdkB9Fmg/1eMuyYiaK8J5+X0VxbU7l91K0DIyiz8Pw/iL3ekAASDxgGgjaoj+4Cd
	m8J4TRiQBCnUTb1lZU97szu5k3LYEJ98EPLUvv+SReHr/2nzKW92qeD8zq38PCmqLIuwfvL9dxj
	o/xpFG6mK4iCuMQ28c6xRA5aHJdCVBla1MAY24o0dS3jPVQHGzmSJpdwvtNMnrSis=
X-Received: by 2002:a05:6a00:3697:b0:83f:250d:59c with SMTP id d2e1a72fcca58-845245b79e6mr3179862b3a.39.1781689012085;
        Wed, 17 Jun 2026 02:36:52 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::206b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0226acsm15521653b3a.48.2026.06.17.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:36:51 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	toke@redhat.com,
	lorenzo@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of non-linear test_run output
Date: Wed, 17 Jun 2026 17:35:57 +0800
Message-ID: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
References: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prog_run_opts already verifies that BPF_PROG_TEST_RUN returns -ENOSPC
for a short data_out buffer while still reporting the full output size
through data_size_out.

Add the same coverage for non-linear test_run output. Use pass-through
TC and XDP programs with a 9000-byte packet, a 64-byte linear data area,
and a 100-byte data_out buffer. The expected output spans both the linear
data and the first fragment.

Verify that test_run returns -ENOSPC, reports the full packet length
through data_size_out, and copies the packet prefix into data_out for
both non-linear skb and XDP frags paths.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/prog_run_opts.c  | 70 +++++++++++++++++++
 .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
 2 files changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
index 01f1d1b6715a..9cc898e6a9f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
@@ -4,6 +4,10 @@
 
 #include "test_pkt_access.skel.h"
 
+#define NONLINEAR_PKT_LEN 9000
+#define NONLINEAR_LINEAR_DATA_LEN 64
+#define SHORT_OUT_LEN 100
+
 static const __u32 duration;
 
 static void check_run_cnt(int prog_fd, __u64 run_cnt)
@@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
 	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
 }
 
+static void init_pkt(__u8 *pkt, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		pkt[i] = i & 0xff;
+}
+
+static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct __sk_buff skb = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
+
+	skb.data_end = NONLINEAR_LINEAR_DATA_LEN;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_out = out;
+	topts.data_size_out = sizeof(out);
+	topts.ctx_in = &skb;
+	topts.ctx_size_in = sizeof(skb);
+
+	prog_fd = bpf_program__fd(skel->progs.tc_pass_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_EQ(err, -ENOSPC, "skb_nonlinear_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_nonlinear_partial_data_out");
+}
+
+static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
+
+	ctx.data = 0;
+	ctx.data_end = NONLINEAR_LINEAR_DATA_LEN;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_out = out;
+	topts.data_size_out = sizeof(out);
+	topts.ctx_in = &ctx;
+	topts.ctx_size_in = sizeof(ctx);
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_frags_pass_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_EQ(err, -ENOSPC, "xdp_nonlinear_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_nonlinear_partial_data_out");
+}
+
 void test_prog_run_opts(void)
 {
 	struct test_pkt_access *skel;
@@ -69,6 +136,9 @@ void test_prog_run_opts(void)
 	run_cnt += topts.repeat;
 	check_run_cnt(prog_fd, run_cnt);
 
+	test_skb_nonlinear_data_out_partial(skel);
+	test_xdp_nonlinear_data_out_partial(skel);
+
 cleanup:
 	if (skel)
 		test_pkt_access__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index bce7173152c6..cd284401eebd 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
 
 	return TC_ACT_UNSPEC;
 }
+
+SEC("tc")
+int tc_pass_prog(struct __sk_buff *skb)
+{
+	return TC_ACT_OK;
+}
+
+SEC("xdp.frags")
+int xdp_frags_pass_prog(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
-- 
2.43.0

