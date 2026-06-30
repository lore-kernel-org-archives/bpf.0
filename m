Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79774534A5
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852665; cv=none; b=n8gZ/cTyXsBehGh1T6THd+do0+dsLRDs6gWIOpZhtVJNO/O1QqN5qa9Kms68ZVhf3dOo1lCC/aUF/CCY4FuE95v6wqJ0ZteVVdv3rV3erkHrYNxfU8Rmr79NqWtyCoXIVuIMYuwv/Hqjyp0vt5YZt3XfAc7E/xA1nWPcir7TAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852665; c=relaxed/simple;
	bh=9eRiyZzxLrtoYjnXIPP2OfGBo8eFMn7rPbbU+dGCphY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBE9URI9yFVIi+ZOEFMsMLpGdarLlC+0ukTxtsuJY/toJpa66YEDEgCfb7w2esZ8OfNqO11vY70U56CqjN+JOLaJePlJ5/vNitfsLW1F4ved8PwKSdp1bnFVRTijkUk3Pz0vjcAaJjqA4eJUenBQ/xLD3PVtXAUdlTK98MDHR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgcD2L+h; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgcD2L+h"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-380544d00b1so640662a91.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852663; x=1783457463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ksGOdAvrWVQOc/6CEjrG1hzk2bKP0wufpP0CwkmqNo=;
        b=mgcD2L+hav2B/mkWsuviNSjca04X3W6uZ4tegXWTjbNDM0efnVGiMVgbVfKlt0VwYn
         MfYiFdgqMlYhlB6gVEfCZ3yEANbdJLUfogZDlU77xuWiE22w/Y1FB1RQabJbVCUleS/W
         JZW5KlmXNKv+wObKKyBrxGHgsePDV4OKxPSoVtHmwioalq0vUNVM+0kBEefJGsw0TmAu
         iPTl+1tJ/wObMDzu+1o6wSjj2KjDZJAZIE9Xd8lDuiEZa0T7dfeMbOpYMytWMDTzaV0o
         vYfXg3leMAID8npboUqEj2oLE6e+NdvkO0aOo6FZ3xF/H3WXubm1P6EnkhwJzyzmJ6aJ
         2ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852663; x=1783457463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ksGOdAvrWVQOc/6CEjrG1hzk2bKP0wufpP0CwkmqNo=;
        b=MSxEQmpyv4rUN+Uiw2bbAci4uxXk81s+zzQIBy2/VccOcgEPAS1Uv2EmI7TOzMAtWv
         ticGPHis73S3OMSp51kJbqy5xGmQbyYqodW3EAsG/cpTlVGci19stY/WIPm9pZR6muC1
         TxdEBTpxMGWCUqkS3HQ2e2wd0JAql+vEV6vp4BeLHossQXciHMGRLYi2h2Fv2xdP9itk
         UVMHhw9AlgiqxWHO2DP/iM2DBN8uE6UBhtd3b0PWVZScxWhDZq58akk03pART4uDE6nd
         uhAWYGCZad356NpOlU8L46ubBLE7aOJnwtIjlBWt7RBlc3H8Ti2yC1g9uRqf1m9+cc+H
         3bPw==
X-Forwarded-Encrypted: i=1; AHgh+RoAREy7+oTrpmKcv0rdHwqQogS7xR1rsNCPLCLPW5fp/vMUjqjZTGmKFqQM2JdP5nZrbaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdNmdlJL5+hxwybDJbUp2lCX7BB3T6d/Gxoy7jlm+nyLt2CyB
	VEXV4Kj4/Z42o6gxNi73VgFm3ZEIlSaseKaAp45UcDpfRivkEAIQdh9R
X-Gm-Gg: AfdE7clvDtFZDN26GV5GgRtFOeoLFY55uGpeiBKcQ3ybewPvCi54CKnS0YJtyRK2Yg6
	b0C9aqvtz5zdH37XXyaSjGA3dO+s6llBQOyiFhjPqQIlVNOqiV6hIQ9jTCoZPCpfWxkdry1QC6n
	YQ0xRlGm5TF7AErT40gdLX/pxOUlsO6YtAc8DRLd149+obWdnI/opLQy6rWeLgPTMrzLS67zMtZ
	xcWM3kmo0jMhgLbZR25ysIgY24M6iRDASK+NJghreispFEe9/l25io1U5n9lP7hx94fmXDF0x6W
	GTDpGHgFFGIrUg7aH23Cf3j2ooyhJJR2W2RwVM/wRIK+CrtLHQvLKN0BV++2P9l84iwUgu4JkPG
	VFqlAkpk6zWBSCSzG8d89dmTf3irkdOvMwohCIUrfb1zHYibPjDWxbK2gBfR/LPcj0x21tyVUKk
	30Uh02PTE/ULJtTezuOlO7D6T1r4biwWKbDLvsnXWYtKbsTiaHTxQ=
X-Received: by 2002:a17:90b:224f:b0:368:83e6:ca95 with SMTP id 98e67ed59e1d1-38052388689mr4254366a91.0.1782852662945;
        Tue, 30 Jun 2026 13:51:02 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382ba1ccsm20322305ad.66.2026.06.30.13.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:51:02 -0700 (PDT)
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
Subject: [PATCH bpf 1/2] bpf, sockmap: settle copied_seq when a stream parser is removed
Date: Tue, 30 Jun 2026 20:50:34 +0000
Message-ID: <20260630205043.184894-2-rhkrqnwk98@gmail.com>
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

tcp_bpf_strp_read_sock() rolls tp->copied_seq back by the SK_PASS bytes
parked on the psock ingress_msg queue; tcp_bpf_recvmsg_parser() repays it
as those bytes are delivered. When the socket leaves the sockmap they are
purged undelivered and nothing repays the rollback, so copied_seq is left
behind sk_receive_queue and the native tcp_recvmsg() warns:

  TCP recvmsg seq # bug: copied 66913561, seq 6691356A, rcvnxt 66913572, fl 40
  WARNING: net/ipv4/tcp.c:2733 at tcp_recvmsg_locked+0x2d0/0x1270
   tcp_recvmsg+0xba/0x340
   inet_recvmsg+0x7a/0x370
   sock_recvmsg+0xef/0x110
   __sys_recvfrom+0x132/0x1e0

Settle copied_seq to the parser's consume point as the socket leaves the
sockmap so it cannot trail the receive queue.

Fixes: 36b62df5683c ("bpf: Fix wrong copied_seq calculation")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/ipv4/tcp_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..918f8da02c39 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -715,6 +715,15 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 	}
 
 	if (restore) {
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+		/*
+		 * Settle the copied_seq rollback for the now-discarded
+		 * ingress_msg data so it cannot trail the receive queue
+		 */
+		if (sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED) &&
+		    before(tcp_sk(sk)->copied_seq, psock->copied_seq))
+			WRITE_ONCE(tcp_sk(sk)->copied_seq, psock->copied_seq);
+#endif
 		if (inet_csk_has_ulp(sk)) {
 			/* TLS does not have an unhash proto in SW cases,
 			 * but we need to ensure we stop using the sock_map
-- 
2.43.0

