Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FD352028
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525006; cv=none; b=i3l7lT8dcDekBbOtnL29eC8T0Fd2dVzMDquV3QU7S8vY6voB+P8KM0ddhaE7NpRqyBGC+KwrA9ZXdBKu59cIJToD6FieiPDbkJ99Iy/R+9h3lxNVZcsuTuXP3MdClhg8NhvpVPxK4WEkt1NmEGrEOgfWnX1M+HDYAirCRvACei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525006; c=relaxed/simple;
	bh=FB8BdshNY2JvwdUff0sSUOvQHItNoEdNwVHNGfCfVzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihAFO66E/ZyueYAKAoqVoI32mxIyKvO+joP6XkrCGYveDij4isJD7PjE5PEsX2jUDTeEVbs8kOMugNo8HBvaNkhS/0UH7Uz6ON1pMB4DmCqlJRtCRTCU7d7yMkjBF+kfE5L3n+ptFR5Pak9zAHtvZXylM1AzwYVdrJX8mynI11M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnzM8RUk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnzM8RUk"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8276c91addso4476307a12.2
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525005; x=1780129805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFyeIDodzT0E9+qWs37vNutpmSr8SonxGWSSL1/SHpY=;
        b=KnzM8RUk6007DmSamaU/QZCq2G3jfBfWpmOvZDHJheYZT9wLsaaLPW+tt0FMvtobxb
         bd4MvcQ9QW9uLYIfu7wnqBobC9U4JTKYLTfC8qS2X7LJK1gFky3PsL3pQZH2f0CssDgn
         RVD3d9Z/Vl9ZRnLkSNdsBYHmTdL+SedxyCWHqJJQ+srB+k1ghgbrmAM+Jb3ZkekUILi4
         ZyiV5HbiXQMnNCZLIy8/0xcpSJrJFRnfA3JpMW/GcDFF6FX8uv22ayW8KlHlhhWO9HKU
         g25ZEt/2VYfYHR5Kgky0Z5gEL+DGqOaBrXpGcXGWLMSp9hyR1aRCU9iEU73e5go9wkPH
         lW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525005; x=1780129805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFyeIDodzT0E9+qWs37vNutpmSr8SonxGWSSL1/SHpY=;
        b=k7LsYpwLWpuvaSbSXHUhcsI4hGmzQZC/RpCiHYQ0oCsHQPodrGroxXi+AzJO/Ubn6z
         I1ctQQNlXE3rCTw2ssC9atlOJjv2qiaqQZ7UtSEJFKuF6wnu3vAwYuCNO2bxyRlyPXKi
         75snwHhnFjO1SqwKQSUwIAUIZgXxfGMrTD2zxdpP+iiC7usI4eURdYgQhM932ycohU9c
         O+Ux1VYQje1TpKM9C0OCLhGtAO863cKo7QTamehvI5X/s8T/NyJtaFrTEXj4d/ibwHmF
         jCahhHGFF5g42yiCLNLQa2wiT39qrZjzyYQ3jfbjZroAZM1TWzhO37BxyZUMqxVMrnyM
         B9nQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RfwxwKAQcvmyMphqpiR4fObvgTA1UNv8GKhvJar2OY88pbdtP9UMfgeb9s4QWacFP/M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfUoMXO02a4gySj9MHALIkCQE9lWTDPEjGkneDaHXH/usLwsP
	sC4R30/qRdDy4ntRTKe7GRJkLR4X64KTfQ/bvSD90rUb45AbycsPojAAa70FRl3hh3s5nH1KWef
	dcFv0pQ==
X-Received: from pgwg15.prod.google.com ([2002:a65:6ccf:0:b0:c79:81df:117c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a123:b0:3a0:bc61:62e6
 with SMTP id adf61e73a8af0-3b328caba1bmr7745952637.8.1779525004866; Sat, 23
 May 2026 01:30:04 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:30 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-2-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 01/11] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS
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

