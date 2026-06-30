Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4563B3C19
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852671; cv=none; b=IqT+j6lQHjiKSURhvLxRjDzso8iv29J0fV15E17xJUJHXWsy5NqNJyxBO1lXYhkLfWI/aMHUAkaKO/Cus7M/217YkPanYZf3Y7wslk3pp+gM1RQ/fyN77MwojB7NkUoS03DD462uIZNm4IuyEyOcmpZdopd1sJohefZJJU27Rv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852671; c=relaxed/simple;
	bh=vIZVPtoekYXA97ar0f3RVpNBTUnPvEkA2N5XD+HOG7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnCDN4g/WvhYIWOBINUACzq5GIi8x5X3ZMEa3CgcqPe5jX+cN4cbnEq5Y3ltAszue+M3TG28DZqFfPne7sKOhqEeVMIqtTTTGnDeII6gJsgXwg2/V4RXlGrf8wM6AzPofwzqc9nfg7SHfqfzaUPrjkNiZHg7hXHulTjgUhKjFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0hIWX4p; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0hIWX4p"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c9cb97e178so29710115ad.3
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852669; x=1783457469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+9mrYL3HnxDWYVBXM/qgCi1xc+LI25f9+ZzQtFcgdQ=;
        b=k0hIWX4pvkl2yOfEqWeywoYdPHqAdSHQYqwJT7PGfZ7lxZwb2N/nD/tkBHHZgbjNv2
         TK2B/Zj1UHEvtRpuBtnREbHJnA92RKNFpYAXgM7T6HoSoyLmj7uosYMbi7PBNg56KfSr
         mvbkrKHo0PgBpVNMUH7+zd4nuH97Y1J3biLUCeKtPJ/tsr0BemKev+gP4YDOxZLRc25l
         +PeWHc0Xdi6O1QzaTBeCuWAmW64EX3OuEzyty8m5bW8tsUbcWN8Q526fRe1uF0CjWKTK
         PSEEGGGqpVKe05nkEJ0wjqJ0nM7Q2AyVbq749RYRDLu/Q0nuhK8kIcItYSlvH30Chrs8
         9x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852669; x=1783457469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+9mrYL3HnxDWYVBXM/qgCi1xc+LI25f9+ZzQtFcgdQ=;
        b=X6k3e8fHDQGlMW6rlst14vqN27iThrQ+Rtht78RfG/yCEtM/7IrdQOZ7oXP1W3SyQF
         +wasPzChFMDyjfqevkGtgSb64hA1dxU/H8EHwPMFuBDSs+n3Wg+LMTf0tkLnqvFbtH+h
         WeZ40nkV3AxhTJ4jUzlYl23HNHCz8jZDuqU/ovcfK452DAXcPnqraHiMdVCbN+8ntI7g
         tdVfurvcagyy2gZFHx9lXMGucixFefNPYSxODsei/HiH9xAMDdTM9SkG9WiQW/iM0MMJ
         AxbY1HxdFCzHbeYWY+/m6evX7KY484FX3Psv/Q53i3vM60EayUOu8g5Wj8uftWQ/6UcJ
         1Khg==
X-Forwarded-Encrypted: i=1; AHgh+RpX4qbTySW5jPq2lXpn4elD+1mUrtMH9gHVj+C83tKvzd1MCQrPx53Vga/ca4+SVmf658A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5S9vy2Mjsie1ld5NgQ3SzMjkABRhDt9cO4LQYFF/sq27hKO5
	rqO64upUX1vTfVBAgc/cyBn6N/kqa8SwjksBBuLfRbVdcgN8dhkAag9x
X-Gm-Gg: AfdE7cn06dUuUcza6s2dSSN38XwU1KPGmuNH1Q3orQcELhIL86iWl+oyG43vCXOhFTl
	IZh7dWYuK6Ir9KH/Mbjah9rJcfUeF4chZR8qgmEAjaOSypOK5+YBpXJ9vAkpvw7v32p0wBkJJfy
	SdUHAprzLYKvBhjIfwcaJBkUB78AHZYQirf4mPoL9rMZZ8NC+5/nhBs8KSzWb+exnh8BV+Gcjyz
	tnEoaQZuyHIVfYsbV6wQ5UlMLJYXj3s5OohGpOqrCop1Sqyf7PXthMkuvIjDYsSG+SvXNxdhkMx
	yMcrYOHA0BG3GoauDHbpjnPRADF30ZOgfxxnpigOZO2pk4eP2F1lcfXoxJNZ5n/KcRK9DXS+NSz
	5EOzb4ltxdrrEDTBckjstA5qrIhPtrEXNbJIsXtskJ1iu+6cCkigDgVO2fo1SwH9Ad7u2Lp6tSz
	Qkk5Io2Vat2Am5QN97H23W89PIV7IypIkFaqc2QXLyHgZmiM/LiWY=
X-Received: by 2002:a17:903:1b03:b0:2c8:1c05:16bb with SMTP id d9443c01a7336-2ca2e71bf72mr41313975ad.24.1782852669354;
        Tue, 30 Jun 2026 13:51:09 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382ba1ccsm20322305ad.66.2026.06.30.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:51:08 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: test sockmap strparser recover with undelivered ingress
Date: Tue, 30 Jun 2026 20:50:35 +0000
Message-ID: <20260630205043.184894-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
References: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Park SK_PASS data on a stream-parser socket's ingress_msg queue, drop the
socket from the sockmap without reading it, then check the native stack
still delivers data queued afterwards. Without the fix copied_seq is left
behind sk_receive_queue and tcp_recvmsg_locked() warns instead of
delivering.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..86b584f5491e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1292,6 +1292,63 @@ static int wait_for_fionread(int fd, int expected, unsigned int timeout_ms)
 	return avail;
 }
 
+static void test_sockmap_strp_recover_undelivered(void)
+{
+	struct test_sockmap_pass_prog *skel = NULL;
+	int c0 = -1, p0 = -1, c1 = -1, p1 = -1;
+	char buf[10] = "0123456789", rcv[11];
+	int err, map, verdict, parser, sent, recvd, avail, zero = 0;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1))
+		goto out;
+
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	parser = bpf_program__fd(skel->progs.prog_skb_verdict_ingress_strp);
+	err = bpf_prog_attach(parser, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &p1, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update(p1)"))
+		goto out;
+
+	sent = xsend(c1, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c1) bpf"))
+		goto out;
+
+	avail = wait_for_fionread(p1, sizeof(buf), 1000);
+	if (!ASSERT_EQ(avail, sizeof(buf), "fionread"))
+		goto out;
+
+	err = bpf_map_delete_elem(map, &zero);
+	if (!ASSERT_OK(err, "map_delete(p1)"))
+		goto out;
+
+	sent = xsend(c1, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c1) native"))
+		goto out;
+	recvd = recv_timeout(p1, rcv, sizeof(buf), MSG_DONTWAIT, 1);
+	ASSERT_EQ(recvd, sent, "recv(p1) native after drop");
+
+out:
+	close(c0);
+	close(p0);
+	close(c1);
+	close(p1);
+
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 /* it is used to send data to via native stack and BPF redirecting */
 static void test_sockmap_multi_channels(int sotype)
 {
@@ -1447,6 +1504,8 @@ void test_sockmap_basic(void)
 		test_sockmap_copied_seq(false);
 	if (test__start_subtest("sockmap recover with strp"))
 		test_sockmap_copied_seq(true);
+	if (test__start_subtest("sockmap strp recover undelivered"))
+		test_sockmap_strp_recover_undelivered();
 	if (test__start_subtest("sockmap tcp multi channels"))
 		test_sockmap_multi_channels(SOCK_STREAM);
 	if (test__start_subtest("sockmap udp multi channels"))
-- 
2.43.0

