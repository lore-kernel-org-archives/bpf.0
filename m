Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8C33B6D9
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934198; cv=none; b=qLOYeyrltlWtHwtdwEQRTSgqE7A1ZxoaEWNmtnn1XIHqSFYwAxJJvrQ2O3yewrrp8D5/XE7FNpkdaIVz0NK6aqEXCz531jwNbEa2LgOVHQGLm5oiDWE6pPgIMKZs/cZQgLExqZCICUnupfJ6Qhl4h2ovhxmHYkA4PSSOS5p4IRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934198; c=relaxed/simple;
	bh=KNZRFOZlKS3k/6j+Jn6MrH6VV305HMZu9ozPlFqIxlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HwgKeXMZJXcnVuEA1j1FzdVc/IQoNcbTpvnnOKrCKh/3o+VSsrh7znw/CytFjPD2olLX91DLwp7QX4/RTCNeN+QoxJmO9jesmd9fPtvR3AjfdJ62v6nI85FH40rjdwdpd3OkisqWbVBKMucEQbEWj2vlmxyHfdxHng58whNjWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s61Iy2br; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s61Iy2br"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfc52ddc55so32949795ad.3
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789934196; x=1790538996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+TZlQpugj+c9MJLWRaRFzFuVXJdi5re21PKY0fPg3A=;
        b=s61Iy2brCjZgpruTNmy+hW4Ap+b2tAvm7LD9rE7s8u+wSRiIRv9dx/Wa7H4y3aF6o1
         uh53JdZ+uHIaIIq08MtDAWSuj+ZOgT4jXFmn+dZspE75pQLNqVeGxlDmdbz3AgqDnK38
         3syS86zamFAqCjTegsHLeyw/Z/aZw4TZz4e9bCF17H4ea4urg57hoJdE57JYKPz+mpew
         tYBQIpwEu/FDZCXE6E//PqnJ8xrOa+4QHuULiXsFmc5cx3ix6hZhzm2Hr+vCojKV9pGW
         ebjK9c34BQukoetq+SmKTGgwOIzRY+2uSrhZGCyaqtao80drHj/n3kyFpuzaxOkj/k+g
         Ik+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789934196; x=1790538996;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+TZlQpugj+c9MJLWRaRFzFuVXJdi5re21PKY0fPg3A=;
        b=n8uW4CkRh1u+hrUywe1+z/B1LVSDg+IeySxCH6+wC8upBXMDN8DQpJ/81ioVYTN3J9
         4KPCR9JVSK5uTmdwZpqooVoBVZVquAUdYljNkxSZ5PM6mukmKpquS7TOP57giWCiio7C
         JUAp6yhSJangGYl8hHMxD9Ygy9zXZuEBuoaAS5FDpNa+n3hSMFCrKywdTXnUhdTzrWGc
         EPsHfN/uNeZ3nSAlgWZyAf7NVHE3yFyvbWdTYxHUSolThCr5JZKay/GaqX5Hh4h8kY25
         YHWRFCfuj1f66yTAbjL+ipY5NbVk6LiwNQ7GPHOpPMuYSZgVOz1A06+1F+deNENy29+E
         aOcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR8Bky6Qdt+ukjrrR1iyVBmgFhPQ8aprK6jBCPHQ4sJ+LBr9geMrr9A9wD0dwy2F5CXAM=@vger.kernel.org
X-Gm-Message-State: AFuF++n/8q0cqZCboMllnmvZYaflY4r/3dNw/HOhJvQvYpshJTP10OCk
	RpFq0+FWR9RVjQ5zzs9OPNHw+j5dA+5fc3Sv0iBtoctccQd/7E/WtrZDLnTOj7uNJ2uH7/waPd5
	ftYbipA==
X-Received: from plat4.prod.google.com ([2002:a17:902:e1c4:b0:2dd:bf24:7d3a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e751:b0:2c8:2808:3ec9
 with SMTP id d9443c01a7336-2ddb1ae69b7mr134287945ad.12.1789934195949; Sun, 20
 Sep 2026 12:56:35 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:56:10 +0000
In-Reply-To: <20260920195633.3033620-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260920195633.3033620-2-kuniyu@google.com>
Subject: [PATCH bpf-next 1/7] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1
 for bad_cb_test_rv.
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
2.55.0.1082.g2b9226bbc0-goog

