Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B7325494
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225657; cv=none; b=jLbSx1mIw4AOZkSLIMTvcgmpxmgBob42bAUs3q+rx/xNqD/PsHTWY+qc2uLNDoWmFmsoL5vA+DWSipxKMQnPpCMR5HcWfFHlD69b7BoDgNph2ObXGhPedaqBOMgYttuzie9AIv5SvcDbaqltWTfpavmBFwyAr8mHI/5mto18qBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225657; c=relaxed/simple;
	bh=x+hbrbyxh8joU7zc8IYkaGrVUNZLZ+DVxD9Vg9WJp2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=goR9L8MCbeDNvjV2CS/p4ZAvFw1gabWiBlPfuSXTkCWnwXx36MMkWolwNxGNFD3HYbv1hrhct9Kmro7URzW4YDOQ8JS+kzw6VrgSz6QHvyE5vkPow1HP3KVLFTAzXG766EJzTJ2rzf4CyB2zTYCeS+KWlhzbP6QNaMne11eist8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkhAYxGp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkhAYxGp"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c44bf176so2190000a91.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225656; x=1778830456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXogNOnQ/1dLBNgOdNOlxajjGjfgFFP8vSw38H8BBHg=;
        b=fkhAYxGpZQX1whqRFXcdeKp+5v20Cl5m2F2abokNmcZijArf52aOs0oXWQscyCeAaU
         NoFvC99MpQortJw330wVhUXcwOU9pUYqeY0fXeJ+IPdaFx0ScyVYyq6CJ+B7YQEau1j/
         MF+1wBAFPWF/NDS9m2JNC6C9XmAbx/vTw0qdetIQt7DH1S5oJU0/l22tc52DZDk40YJ1
         6+cx3PVda5IkyGJr+m4Uj5XbuMKjlDo2Sed13K1N8cy8qaox+pnSdizCrt02YabDd7jm
         ysPJZ15hO7hapfqitT2xhbb9Yxn6itmdsrbsd35Lc74PdKKxlyP7vXt+jpVOj5d6HkpR
         jUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225656; x=1778830456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXogNOnQ/1dLBNgOdNOlxajjGjfgFFP8vSw38H8BBHg=;
        b=AsavPenlmm4tFGWs5777aOl5WevWLZGzCp4DH+MMnWdg4WvnEiTmQIC2/c7ySE1GUl
         DC/UuJ2YcKhGBvQfVNGnZEsFA+hE2HO1izNKA3CUzW8zO/W68mDRQ893aZLvyDK9G18y
         6ihqHoltaWw+sg1w7g/znTT1joQx/GOa3kfJxDGi3i3lLv8Q2VN3UtiZirRkOmJUmJb4
         8tnH/MzUlZKsZtcMNE7S2QWSvk6t/Z5Ne0DNXpuNnhSTGHOUKdj+k8WhvdgujjxxdXAY
         VBWxJwD0UKk+6W9Y7mkw3XlUB0bnybcntfyJfTNR2X6ijbt3QnrbEnrg94yEzpcCCxUg
         6+MA==
X-Forwarded-Encrypted: i=1; AFNElJ8J+oNlX4A5DXrQuNs9q58AP+s2KsItGzjzXXL7s/g02HGqshcoCid3nz6rCx5aAvEJcYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+SQiomohq/mmQyH3mdeQgMt1bM4sDbg7qaundD34GSPqPe8S
	cKSqTsPa/6vIC1dGNupLvMLocw0jFJesSoMUka8pCX3k0xid/KjRJHinJmrvZobDeyE5ttEHLs1
	BBtWOgA==
X-Received: from pghp4.prod.google.com ([2002:a63:fe04:0:b0:c79:738f:74ef])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d004:b0:364:edd2:812
 with SMTP id 98e67ed59e1d1-365ac7a440fmr11832911a91.25.1778225655765; Fri, 08
 May 2026 00:34:15 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:22 +0000
In-Reply-To: <20260508073355.3916746-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-2-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 1/8] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS
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
2.54.0.563.g4f69b47b94-goog

