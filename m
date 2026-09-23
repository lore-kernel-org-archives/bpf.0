Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3FF475358
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199447; cv=none; b=Zqm/THjzLkHpcCeaatK9pVjmMxn2xjOPNItLrkRn/Ny2H7BJfF1EfA91HW/qZGMV3Yop7F38OD7w7koTqE2jYfV6h64gmzlAmGUtOL2Tlz1LfdJU4WwpUILe7I+xTb424N/LN0ZTPln0rMLOqeseZVFWghT5W9r+sGlPeORVerA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199447; c=relaxed/simple;
	bh=bs9GzRJZuVWAJwdO169nNTQ+eyFwlSv4C20n+ekBwyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c/2PbTjP1BsMTHTvaFdsFq4nQf8RZeAP+mZM+FxUvQULWusiMUOE8ZqRl6SkMHpJGGzKPHW68OKLuOU1qDqRF++3YZtwczq+SrXHxNwSwxcj0Uxde1NkAjOKDzIfWG2NztBxRtZxCpMI3WNDO+n/Jt8LrdBzTvOkObSKpEB8rzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vH1XELuV; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vH1XELuV"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8696b921ac0so987019b3a.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199444; x=1790804244; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WGXfmEWkq3/HHuasNWZ53w5Ago5oUb+2kjKFTNmi4jc=;
        b=vH1XELuVEbn5apgZ4MKW19BlX/Rru2sJN5R82KsWWBF/H0n3F82CtSPLbdgNHA1WK2
         DC9WPK9/w4G9d6ztgkeRRXNIDgdENuGeWcPSG9rs53cDGzD1GNx9RmG7cVgH87iFSh/k
         NzbGhrJLOGkZJGXPJLx5eRUL0Lt7Vm579s+BSHHaDMnis8z0pEHoqnqjfDFGN+0+8GYl
         E843tBJ4OS2QBWdqMbk8Bny2hrUFalq5bWA4pVk7Aa/fQtTZYEHgVZTAKaAfVE7J5a63
         IHJ1dVTWCJ99m7zGdTK/b0Zy9gw/FujqGkyPZUEvTHMualf7SWZ4kCXXQGgshpRdN1AQ
         r5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199444; x=1790804244;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGXfmEWkq3/HHuasNWZ53w5Ago5oUb+2kjKFTNmi4jc=;
        b=eJ+yW+jByX5QZ7fsZjkEWlb8JyMCcZaTxnohJcOU5Ar0o0i2y8Tp9wow2jTyFeq3ZF
         ahtfUQmC1Qc4nCS20bHSriqix6WNwdyL+9zSxi/nMguuN414kSnUAknII8ky+0KCiQcB
         GAAGFFQoL0tU4sJn7z6N+jAgFRb6fNX6ZwM+mMj8N2JexHXLhuIw843eu1chZyeE9prf
         wfvapflzU74PULecEQeuU9Nm7Einyzsyo1yp5UQMhF+d5SQMdypej7Twe+SxfxmaWyd7
         FGnSjTc7KYJsfJaxuOB5u+E0m4qdewiFhZ4tFJBuQuDEQIECcVlGQ3L52GqYftJOGmS8
         iuew==
X-Forwarded-Encrypted: i=1; AKwUvBznEU1rBDpBQ8WU511ABy0fHbdtSheB2Al+SFqWZLTuGHJdEMoq2QDAb56ge0Q6MNaYCfk=@vger.kernel.org
X-Gm-Message-State: AFuF++m4nw3zwAql87iv2y9xu8+xxZR1+Wifnc4rftQg4flvVRxQkRFn
	LdjMVTlk5BX4um1Wnn42T4XmyLMWhNmyvXwTjwfD8Z1b8yECA0m9FgtGJKWL8WOzJW+RC/aniw/
	sSdCs0A==
X-Received: from pfbna15.prod.google.com ([2002:a05:6a00:3e0f:b0:87d:6399:223f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad02:b0:87d:e633:72fd
 with SMTP id d2e1a72fcca58-87e9f824499mr329534b3a.51.1790199443883; Wed, 23
 Sep 2026 14:37:23 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:32 +0000
In-Reply-To: <20260923213719.224838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-3-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 2/8] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS
 + 1 for bad_cb_test_rv.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Once bpf_sock_ops_cb_flags_set() supports a new flag,
tcpbpf_user.c fails due to the hard-coded max value, 0x80.

Let's replace 0x80 with BPF_SOCK_OPS_ALL_CB_FLAGS + 1.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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
2.56.0.rc1.315.gc6ed9934b7-goog

