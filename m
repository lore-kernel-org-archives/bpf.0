Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD0273D6D
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785580024; cv=none; b=HCstSWfQ6Vs17XQ+2RpyT3fXvYZzJ3ajM4AWU+f8bjuGD0EHOw1iuMKMaiQk74bXB4QM4CVYK+ME9k10A45Zr8IA7xPNrDSpGfTW9LyhY8AkQzeE2EKSk3ZAGsLtjciURS/QNYnWCuUwKxRvjg2S215vqzXDxmst7y/1BT/2L8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785580024; c=relaxed/simple;
	bh=UGaXKViydcNHgiIYJqkogJCCwyxdJr51ddIZCkZf78c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnAZlhcwUjyvZkybpcQzVFHOfwncS0LXV2a2TN+TLbxhTTPgbpcjBW6KX2xeS9C739P2GXZ0dVspSpC9gpBhSfrMMkgUk0+F3eCR+MNY/NIRN6/FouympFDDwjcjm7I04Dq8F4ek81dhZARdLAI3aFDLbAu1U2fyvxNGUYV9lXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQU4W2wn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQU4W2wn"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84864086bfeso2038624b3a.1
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785580022; x=1786184822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bm6tU6uRMhMFMi+BnhXh/n8qQcLZIiln365T8/pycxA=;
        b=pQU4W2wn02nUIRwKm+okywFas6jfqzAZV/KNEQDXKeTQvJgYn4wOsjvrv3wUyJCniI
         zCTDGX//qMlZrNeEzcXz03rrKPfteFNZq88nvlEvkStc5lxJna6sByDwItCqg4w6Vdvr
         NmiiCDO2nMlEm/w7Ckgh9BERs15k0F8tuq9RSnwG8Uh1hlvpGdZSLZF4zvKIWYudsW0F
         A2eKeJlRyOSmIDTisWccc3NWEk9vDlI0n5s4eY5WwLc8Vk/sh/d1bxeHHHN9BxwctyFy
         dpDavudRRjqoKRaS+adJSxnMtTVtjQRtO1w7PlBRkl6qHw52/ZhVSKNAEkESmijy9x/Y
         6CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785580022; x=1786184822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bm6tU6uRMhMFMi+BnhXh/n8qQcLZIiln365T8/pycxA=;
        b=GCwENDbS81Ge+zWjLWt6xrhM8nhh9eWArmQ5VGn9TH7qWcPd5+l13TaRoFCMqKPJdl
         t2wx0RmnY/VBAICKixq1rDDpYAw0qDh+3RHiOBjvPBAe47msMkKdK/6n+Ha19L7QjH7t
         39hvLn+qoGvk1q3rNqgbIS3KGagSsMWMzivqfRDZ4M6Lj7IxofJ/7pSilRzWDSgg57V3
         GdNO+kKsW9qcSDV2A773yL+bw02so/BD9FuVIshMOZUHhNHHupqnv8zOMVecOlyvVowx
         2gRVjrz2WjE8gR6nxt9QNUHMgtmpb8OLD4cxq06wgU0ZFokRr0/USVhlCtFYmGlP6IF2
         cp3g==
X-Forwarded-Encrypted: i=1; AHgh+RrC9bwFglGu/saM49pB5FMXbbkT+V/2c7Q89zE8Tp7cM4zuIzX4ZbazsJPZPSNIYtWqS3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtydeoiXTHDqgLLkVxIyA/OttvmjCo3HSF/Vl8T7ZFzr4gk+w
	vP/fKcIiDtHCfVRrMrQArYDX4BLAINITsrH5p9h9uCE+nKhzB19qpby6
X-Gm-Gg: AR+sD11+qxgKwQzNWw1H/WykYtHVf3jUWiosVYNCH3RUF4qdmUdLRku9Yh3Sdc9y+zP
	Ds2q/AeOlXvFkGXjUR+QAii1Rj+ir+fKPLfRZlK1CAs/th9Nva6JZu5mkh1dNkYpEc7KwqVHc00
	uLxs7GS69hU44nFwb9j8aRpQgXrT/eWkjSVmrKRGiTZIsDkkgtqtrp8ukUTGMY1ecUaFTwjepJz
	3nrVxe42xrnADzI4zadfzll4MDKes1qMFX6xKrD9qQNpYMEC/Si9vuvS8Pg63hHEIfsg4d/n1hn
	2kwo5TGgEiSDj5o4iwwIRSw+YogbCAYE3L87KqjeG9GX3GID7nfM5yNkxAuljMKix40QorZwFXz
	t9TYoRPTic/Qbt5vaYVSL35mVdKZjaEaG3LWM6qVRILCkF8SuKsehs2mwr1YhttQ9MqVZ0+X6q+
	oxMWyHoanNHgPaaqlAOUXDfb/oaYdAUDe+9q7mgzt7voLe6TTVkdX/Gdw=
X-Received: by 2002:a05:6a00:410a:b0:848:2f84:739 with SMTP id d2e1a72fcca58-84ee4960de6mr2519444b3a.76.1785580021850;
        Sat, 01 Aug 2026 03:27:01 -0700 (PDT)
Received: from omen-arch ([147.46.174.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc51cca2sm1526886b3a.61.2026.08.01.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 03:27:01 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Junseo Lim <zirajs7@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover strparser self-pass forward allocation
Date: Sat,  1 Aug 2026 19:26:33 +0900
Message-ID: <20260801102633.1872012-3-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801102633.1872012-1-zirajs7@gmail.com>
References: <20260801102633.1872012-1-zirajs7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sockmap_strp regression test for strparser SK_PASS delivery to the
same socket. A one-byte stream parser splits a single write into many
messages, repeatedly exercising receive ownership transitions while the
skbs remain queued.

Verify through INET_DIAG_MEMINFO that sk_forward_alloc does not become
negative after the self-pass path is exercised.

Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 171 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |   6 +
 2 files changed, 177 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
index 1d7231728eaf..c7ad21d0bbf4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <error.h>
+#include <linux/inet_diag.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/sock_diag.h>
 #include <netinet/tcp.h>
 #include <test_progs.h>
 #include "sockmap_helpers.h"
@@ -460,6 +464,171 @@ static void test_sockmap_strp_parser_reject(void)
 	test_sockmap_strp__destroy(strp);
 }
 
+/* Read sk_forward_alloc through inet_diag meminfo. */
+static int sockmap_strp_get_fwd_alloc(int sock, int *fwd_alloc)
+{
+	struct sockaddr_storage local = {}, peer = {};
+	struct sockaddr_in *local_in, *peer_in;
+	socklen_t addr_len = sizeof(local);
+	char buf[1024];
+	struct {
+		struct nlmsghdr nlh;
+		struct inet_diag_req_v2 req;
+	} req = {
+		.nlh = {
+			.nlmsg_len = sizeof(req),
+			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
+			.nlmsg_flags = NLM_F_REQUEST,
+			.nlmsg_seq = 1,
+		},
+		.req = {
+			.sdiag_family = AF_INET,
+			.sdiag_protocol = IPPROTO_TCP,
+			.idiag_ext = 1 << (INET_DIAG_MEMINFO - 1),
+			.idiag_states = ~0U,
+			.id.idiag_cookie = {
+				INET_DIAG_NOCOOKIE,
+				INET_DIAG_NOCOOKIE,
+			},
+		},
+	};
+	int diag_fd, ret, err = -ENOENT;
+
+	if (getsockname(sock, (struct sockaddr *)&local, &addr_len))
+		return -errno;
+	addr_len = sizeof(peer);
+	if (getpeername(sock, (struct sockaddr *)&peer, &addr_len))
+		return -errno;
+
+	local_in = (struct sockaddr_in *)&local;
+	peer_in = (struct sockaddr_in *)&peer;
+	req.req.id.idiag_sport = local_in->sin_port;
+	req.req.id.idiag_dport = peer_in->sin_port;
+	req.req.id.idiag_src[0] = local_in->sin_addr.s_addr;
+	req.req.id.idiag_dst[0] = peer_in->sin_addr.s_addr;
+
+	diag_fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC,
+			 NETLINK_SOCK_DIAG);
+	if (diag_fd < 0)
+		return -errno;
+
+	ret = send(diag_fd, &req, sizeof(req), 0);
+	if (ret < 0) {
+		err = -errno;
+		goto out;
+	}
+	if (ret != sizeof(req)) {
+		err = -EIO;
+		goto out;
+	}
+
+	ret = recv(diag_fd, buf, sizeof(buf), 0);
+	if (ret < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	for (struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
+	     NLMSG_OK(nlh, ret); nlh = NLMSG_NEXT(nlh, ret)) {
+		struct inet_diag_msg *msg = NLMSG_DATA(nlh);
+		struct rtattr *attr;
+		int len;
+
+		if (nlh->nlmsg_type == NLMSG_ERROR) {
+			err = -EINVAL;
+			goto out;
+		}
+		if (nlh->nlmsg_type == NLMSG_DONE)
+			break;
+
+		len = nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*msg));
+		for (attr = (struct rtattr *)(msg + 1); RTA_OK(attr, len);
+		     attr = RTA_NEXT(attr, len)) {
+			struct inet_diag_meminfo *minfo;
+
+			if (attr->rta_type != INET_DIAG_MEMINFO)
+				continue;
+			minfo = RTA_DATA(attr);
+			*fwd_alloc = (__s32)minfo->idiag_fmem;
+			err = 0;
+			goto out;
+		}
+	}
+
+out:
+	close(diag_fd);
+	return err;
+}
+
+/* Test strparser SK_PASS delivery to the same socket. */
+static void test_sockmap_strp_self_pass_fwd_alloc(void)
+{
+	struct test_sockmap_strp *strp = NULL;
+	char snd[4 * 1024];
+	int c = -1, p = -1;
+	int fwd_alloc;
+	int sndbuf = sizeof(snd);
+	int zero = 0;
+	char rcv;
+	int sent, recvd;
+	int map;
+	int err;
+
+	memset(snd, 0xa5, sizeof(snd));
+
+	strp = test_sockmap_strp__open_and_load();
+	if (!ASSERT_OK_PTR(strp, "test_sockmap_strp__open_and_load"))
+		return;
+
+	map = bpf_map__fd(strp->maps.sock_map);
+	err = xbpf_prog_attach(bpf_program__fd(strp->progs.prog_skb_parser_one),
+			       map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (err)
+		goto out_destroy;
+
+	err = xbpf_prog_attach(bpf_program__fd(strp->progs.prog_skb_verdict_pass),
+			       map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (err)
+		goto out_destroy;
+
+	err = create_pair(AF_INET, SOCK_STREAM, &c, &p);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out_destroy;
+
+	err = xsetsockopt(c, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf));
+	if (err)
+		goto out_destroy;
+
+	err = xsetsockopt(p, SOL_SOCKET, SO_RCVBUF, &sndbuf, sizeof(sndbuf));
+	if (err)
+		goto out_destroy;
+
+	err = xbpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	if (err)
+		goto out_destroy;
+
+	sent = send(c, snd, sizeof(snd), MSG_DONTWAIT);
+	if (!ASSERT_EQ(sent, sizeof(snd), "send"))
+		goto out_destroy;
+
+	recvd = recv_timeout(p, &rcv, sizeof(rcv), MSG_DONTWAIT,
+			     IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, sizeof(rcv), "recv_timeout") ||
+	    !ASSERT_EQ(rcv, snd[0], "data mismatch"))
+		goto out_destroy;
+
+	err = sockmap_strp_get_fwd_alloc(p, &fwd_alloc);
+	if (!ASSERT_OK(err, "sockmap_strp_get_fwd_alloc") ||
+	    !ASSERT_GE(fwd_alloc, 0, "sk_forward_alloc"))
+		goto out_destroy;
+out_destroy:
+	test_sockmap_strp__destroy(strp);
+	if (c >= 0)
+		close(c);
+	if (p >= 0)
+		close(p);
+}
+
 void test_sockmap_strp(void)
 {
 	if (test__start_subtest("sockmap strp tcp pass"))
@@ -482,4 +651,6 @@ void test_sockmap_strp(void)
 		test_sockmap_strp_dispatch_pkt(AF_INET, SOCK_STREAM);
 	if (test__start_subtest("sockmap strp parser reject pkt mod"))
 		test_sockmap_strp_parser_reject();
+	if (test__start_subtest("sockmap strp self pass fwd alloc"))
+		test_sockmap_strp_self_pass_fwd_alloc();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
index fe88fa6d40bc..682e53d40751 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
@@ -50,6 +50,12 @@ int prog_skb_parser_partial(struct __sk_buff *skb)
 	return 10;
 }
 
+SEC("sk_skb/stream_parser")
+int prog_skb_parser_one(struct __sk_buff *skb)
+{
+	return 1;
+}
+
 SEC("sk_skb/stream_parser")
 int prog_skb_parser_resize(struct __sk_buff *skb)
 {
-- 
2.55.0

