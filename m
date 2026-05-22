Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1D346E7D
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435968; cv=none; b=s1uYxAJPJEIW9VKgbUBWCrTkXkLHS+0c6xds9BzsNgQZwZmX9ONTp3O0ztjq0fbI2ItoPEFxijA0HWJOOmrqwoPyPzW0mtTxTDhvvNZG6KUCP5PEZaiowXK6ZWDtbyC1P9R0zVoRRKytdAIq0n/yGaFWkUuUf73ALNKa6M9d6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435968; c=relaxed/simple;
	bh=FB8BdshNY2JvwdUff0sSUOvQHItNoEdNwVHNGfCfVzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=swhpUfl/64a9sIRxIz9uIF3q38KZk/O7yqi2iIq1BciRLe8E3l7sA4RB8bKd2GfvQvGVtOwdVO0TypULmEepSw6AExJzjgA6AgcAon1qHcZIezEbbw2rXsUh+HaXxcwzurFt8SHqbWmwwWI1+SGRz+4HSqUNo2GXQX3NH7hSEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndcbHXC5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndcbHXC5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso4056038a12.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435966; x=1780040766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFyeIDodzT0E9+qWs37vNutpmSr8SonxGWSSL1/SHpY=;
        b=ndcbHXC50sZ9O82dBqcKJxrqNOnY8xnoflZDaLG2Jr+3RxeCRHs4g1atRSx3T1KJ4s
         FEgUhM7vuVSAUYgId+aUBls2iavDa953FAwd9kNsc7IhQQphFeJaKX+VIGL3O7+LOPIa
         h5elkK3YUDlcEYn1InaQGHU7w5+NVO4YOOz9B3aM7x8Ub42f6DsldWIchoLRCzZx90Yj
         UWe4womiyXcyQROjxgDbiZihWlKHyHo87W8UCFD2+piSRrXepj9rls6C9qwPKAegZfMd
         zNXMoAhji0A3TnjJu+sey8XJMK7BDOBgMFaYBbseJpkM9+o5NhoaywXlX4sISKIYkiGh
         6Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435966; x=1780040766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFyeIDodzT0E9+qWs37vNutpmSr8SonxGWSSL1/SHpY=;
        b=cfz/xKGAx0ImDAQcG4g5eUNDbQ08hDn4IAIW+pQX9ZtXA/MjXHcn9pbk2Ay8D9VmBi
         fscYkpCR8Tfyj0pyGP5qxaESIYwDYBmLU55xVG448tYDv5vkGot7c3cqcV1oCG1dXW2E
         b150Mt447FsZx0EhGGCnwYdiwaxP1b+zZlNgspotlYGHC0YTrkJ/F2mW/VBl4Ly0i8wY
         xhKufmkptECQespfi55q24mxQEzCJwhg5BuIX1NAoMZK1zb0358Jcw6DwCo7RYoNeKpp
         qjMdIzO5m29K2XxeuOq29P2Df0C4UAAJNWOqy+miWkUl4/rFhxIHbmGRao64+0WeMyve
         6LGg==
X-Forwarded-Encrypted: i=1; AFNElJ+UFtTnSmUuh+sYHsqzlY5j3nB3dK22Y3oLeSxl2RQhkbQpcyGWsVc2enl5xl5eAlkqVmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+K4Fb6SdgVKAiZbs4lbxbEniQxpgMWaL30TLFJTI4sP/MOOk
	mlFRjfVqgXxzcUPPF1KaUfHQvPwNFdf80/MUbxhdlr7Nmob66wXgt4+Z+xQTQS4dGqQMQRqN6hL
	iHheuEA==
X-Received: from pgdd7.prod.google.com ([2002:a63:1d07:0:b0:c82:283f:132f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cd:b0:3b2:8675:47fc
 with SMTP id adf61e73a8af0-3b328e7427dmr2585870637.25.1779435965954; Fri, 22
 May 2026 00:46:05 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:52 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-2-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 01/11] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS
 + 1 for bad_cb_test_rv.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Once bpf_sock_ops_cb_flags_set() supports a new flag,
tcpbpf_user.c fails due to the hard-coded max value, 0x80.

Let's replace 0x80 with BPF_SOCK_OPS_ALL_CB_FLAGS + 1.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c | 3 ++-
 tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
index 7e8fe1bad03f..e4849d2a2956 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
@@ -26,7 +26,8 @@ static void verify_result(struct tcpbpf_globals *result)
 	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
 	ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
 	ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
-	ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
+	ASSERT_EQ(result->bad_cb_test_rv, BPF_SOCK_OPS_ALL_CB_FLAGS + 1,
+		  "bad_cb_test_rv");
 	ASSERT_EQ(result->good_cb_test_rv, 0, "good_cb_test_rv");
 	ASSERT_EQ(result->num_listen, 1, "num_listen");
 
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index 6935f32eeb8f..e30cb1fab079 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -92,7 +92,8 @@ int bpf_testcb(struct bpf_sock_ops *skops)
 		break;
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
 		/* Test failure to set largest cb flag (assumes not defined) */
-		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops, 0x80);
+		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
+								  BPF_SOCK_OPS_ALL_CB_FLAGS + 1);
 		/* Set callback */
 		global.good_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
 						 BPF_SOCK_OPS_STATE_CB_FLAG);
-- 
2.54.0.746.g67dd491aae-goog

