Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3AD38945D
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608559; cv=none; b=LtHI/qdMMqS44F9PNFN7fyjxakXEANtYTCOxQ451uoKvgUE8AR09v4qB+ki4B7N6hsEWnV52UnE0pOpI648XMK1Yf2E60niiu67paf69ZiwQuMlhYaN5S/kJ1jOIkUjJOLORCUb5FD0Hvai2LmddGpoXZyG/AB8n7BalUGVof78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608559; c=relaxed/simple;
	bh=EitmCVy+LU3Q5DzsSwudd+EqxxFPElWArb9moAc+YuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpXN/ycZIS2/Jcp9D9EPqzzzZ2ObEwz9R0t9WciApJ+agiFPe6UADwJEU0VLwyB/2yLOAB1c4G5X+UxHfYDIc5T38zCYc/7joBc/Cl0P5WCR/XYkVSDuDHSEu0691qIvR/tdAX80+OZvlzLC+MAXzu8KbRlAWjnsMS+CuvOUrsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ6gLnSz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ6gLnSz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493ba701891so14737095e9.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608556; x=1784213356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OTlVbX3QZZA0ufld2LOVNvKjP7TAMS4JRgxjqJ7SLM=;
        b=iZ6gLnSzT+ii7VcuiR7LyTh6aF5dqS8TFuz7w6jCrdhv4joYaGlSci/7IH1Vw0v0bM
         MUZdOiUfWF2KgHxFoRil+gd5DPQrS9amHLd7uEQXOIPvP9alJS4khfOTsO20KOjO3TwK
         71VoKcw9b41oPNiZIFFXuoanEySQcTvGnKd9qteLTjQIToeQ7aUzUga5C6yEM47UkO7o
         Td7LqXoGua4Z87e4PyBFtR3B78sVe4QLrBaWRzI6uWFtxtTv8E5ZiI80BH1R2/CSvDy2
         GdD0fn98KKnrv4HB1r9quHXKx9qDHHzu9jB5chfeWAJw/xgKQFfHlegpMkUfrhqj1dtg
         icqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608556; x=1784213356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OTlVbX3QZZA0ufld2LOVNvKjP7TAMS4JRgxjqJ7SLM=;
        b=D4WlNGDURvHZEl2xbm3EbwsSxayLwwjb3erRt86BqYR/wQWnE416A75DE+0s0ONV1r
         QvKZnbmHVrQgDrLLzzcSRrQYfE6yU5oV+q5wAlzObyYvogc8m9JnNHFUt8g5yBPXK+as
         z8PiBihQQ/NL2IeJ6sMUYgQVT1FsBGMWl2XcupRvKLcifkaazw7mMZsZsfLYriqs1QSB
         Hzj3okjwXp8BnVGUFn/SU6VOHFx7gg6NQmb4SXKHr2g5XhQnG0YsCHauI5+ikBrLzRH/
         lmssvI+TjHONgK/mpjsSbkLzxLpaGheeGI4YL5EScgi0UVdvByZAsCNIxTHOhH/gx/+v
         vFIQ==
X-Gm-Message-State: AOJu0YzDdbbQ3cgm62BEF9r4faNWwG4VCBjDzilMEc6/KRnvbWkk+AiU
	zxCvbdsdwdU7mEZG9tkIN8QJExmwMvBEXbi+XvFNKBAorvqFpjqaCGT9YZMy/siXLR8=
X-Gm-Gg: AfdE7cnu8nRBiAATNCaFFp5aUaOok7d8DGNrd68hC39G8K/+2Hr742JFtgycNhoL0jV
	Qv2OSb/4lZ+LAbLb687GPXucAE4y7T59eA1iadn5Va+HMBaWRHk7o5mdfnACIPUXYAPIqU6h9T4
	4M89bfibN4IXDIAIdVpURG7dLxmneLa1jlnDCW1ZKAB/eOxkBUmiXOA9/zmJQJgrx4CmzAjczdY
	ei/iWwWOduiqxpTblxJV5XTKLtp3H+8rQ3/WcPljVo1E/hiztDyxJG08lgXLrKPnwwKHqf+peQv
	L8T/Dec+lendmrgQxdpfDxqlMD3/wPWb1nH+aDAZ1s3GInZn8Td3kWt/uFwKdPSTeUsINNirNq4
	E3aQyS3u4RRKp9GVlPlrQqZIxtych7Rxd48a6dvs3cG4raO7l5icmy/6JiwGPB5FM4krKEQ/4IV
	VXDRLbRqHvUxYkbiFtaB4EHB3wKFCnUEQFlezTXvJ17WAX5LkpKKSqqMN79zyb7rhrKkhW
X-Received: by 2002:a05:600c:c8a:b0:493:c3f9:65a2 with SMTP id 5b1f17b1804b1-493e688cf81mr79336805e9.5.1783608555943;
        Thu, 09 Jul 2026 07:49:15 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm64357595e9.6.2026.07.09.07.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:15 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	sdf.kernel@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v11 5/5] selftests/bpf: add bpf_icmp_send no route test
Date: Thu,  9 Jul 2026 14:49:00 +0000
Message-Id: <20260709144900.245904-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709144900.245904-1-mahe.tardy@gmail.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For normal live cgroup_skb paths, the skb should already be routed. The
exception is for test run via BPF_PROG_TEST_RUN with packets created
via bpf_prog_test_run_skb. Those lack dst route and thus the icmp_send
would quietly fail by returning early.

This test exercises this and makes sure the kfunc returns -ENETUNREACH.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index bb532aa0d158..9318d4bc7ce8 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -169,6 +169,49 @@ static void run_icmp_test(struct icmp_send *skel, int af, const char *ip,
 	}
 }

+static void run_icmp_no_route_test(struct icmp_send *skel, int af)
+{
+	union {
+		struct ipv4_packet v4;
+		struct ipv6_packet v6;
+	} pkt;
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt,
+	);
+	int err;
+
+	switch (af) {
+	case AF_INET:
+		pkt.v4 = pkt_v4;
+		pkt.v4.iph.version = 4;
+		pkt.v4.iph.daddr = htonl(INADDR_LOOPBACK);
+		pkt.v4.tcp.dest = htons(80);
+		opts.data_size_in = sizeof(pkt.v4);
+		skel->bss->unreach_type = ICMP_DEST_UNREACH;
+		break;
+	case AF_INET6:
+		pkt.v6 = pkt_v6;
+		pkt.v6.iph.version = 6;
+		pkt.v6.iph.daddr = in6addr_loopback;
+		pkt.v6.tcp.dest = htons(80);
+		opts.data_size_in = sizeof(pkt.v6);
+		skel->bss->unreach_type = ICMPV6_DEST_UNREACH;
+		break;
+	default:
+		ASSERT_FAIL("af_not_supported");
+		return;
+	}
+
+	skel->bss->server_port = 80;
+	skel->data->kfunc_ret = KFUNC_RET_UNSET;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.egress), &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		return;
+
+	ASSERT_EQ(skel->data->kfunc_ret, -ENETUNREACH, "kfunc_ret_no_route");
+}
+
 void test_icmp_send_unreach_cgroup(void)
 {
 	struct icmp_send *skel;
@@ -193,6 +236,12 @@ void test_icmp_send_unreach_cgroup(void)
 	if (test__start_subtest("ipv6"))
 		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);

+	if (test__start_subtest("no_route_ipv4"))
+		run_icmp_no_route_test(skel, AF_INET);
+
+	if (test__start_subtest("no_route_ipv6"))
+		run_icmp_no_route_test(skel, AF_INET6);
+
 cleanup:
 	icmp_send__destroy(skel);
 	if (cgroup_fd >= 0)
--
2.34.1

