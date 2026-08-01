Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF22F532F
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785592813; cv=none; b=J9QNVA6YVKNYAUuEUXeY1fZvr6yi9yo79rWghCX3tq5+3a1ewoWM+hLkklY124J5W7DUosr81qBe9YnoQwD56tKWTITfPyDHKHrvENrrlKHae15nquy2R3PrLt+GzoBn0Vj8bc11v0OMxCduOlHzbuKyEShQ+8sa5Y6oQHinq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785592813; c=relaxed/simple;
	bh=TLKVpsxTAiz0l4w695xmNw52fMhFEdpB6KuSW5hRE8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFnN60vbw1FZ7JlIXsIq5CNeliwwcvJEVJ3V1oEOVcME6Bvs3NS4lBjPyQryLZKZHVFjgXfhU0nImz0UfRvRqYt4E3AGvCx3A6ssss2EtOWKuVGADT1N0HOdJQ4qyAPLdleWtPWGnQmf3B98GLsKCF8CZxJrk7vsF6vP4tNaZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIKytPfP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIKytPfP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1820155a12.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785592811; x=1786197611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ij3qVcBl3D2Fgt+3IhYwcypP53Zfir6uLkrmNSB7KuM=;
        b=oIKytPfPAA/MZzThAOOrAmJkD0GUP+KNVecpl2wbbTsnbzrAhYmXp/EqKrZUKIhgfS
         A2lje6Mv2IoauukNtQAL6M0cRVigs7m7/wHbsz1t+ngXPGb6w+5PYV0Q80bXz1356T45
         4qCWnXyyGZUDmDEcX4Fwie5tmBDk46O9tWP+aINPZqKzssRjvn/zbK8jOzd/FEqK1t5t
         u4i/sso7t5LojjXlZ4qWi84fQGZyaBS+HO4AkCzWYrsR7Kp4EAjEiKx4JkhXFQ/LmuCb
         FVFHon3VXCuOhV8U6PfkYVn8Ff2rGGqjKaWpEqWT6PQTzbuG93TQeH8pzvxdQCvEMrz5
         vqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785592811; x=1786197611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ij3qVcBl3D2Fgt+3IhYwcypP53Zfir6uLkrmNSB7KuM=;
        b=b7NQxHZx0a94dPlWJVVhfw9wpccKkmyIs88vWDlwQyRlDdk5cXPn/w+n8oZswFGkv8
         7kvpoG0Vtt1Iqwzjvt7uS01vlJyvpA8ZAiNkaorygEmiT/+UjbVipTM6Qc+/UPn09BMT
         MGHeN7y+Fn6BJgrJ2IhORr4ckDspkuBO3aDUqZZJUh4XO2JeeXkISqhaxBQdkirqa4L5
         rGWvSZiyn6oRdoO6mhYKq6w05fwLI1ArKZLyPUqerQmHLxWf+WywP4zBOtdFOPE+nksv
         LkGGjaVTzycXZtJr7jj1tsKuzKemKYCqUtNiko7xYPCAUe8PmVNXsKKBlwCmupHtCzV8
         6U/A==
X-Gm-Message-State: AOJu0Yz2Jsm7213qPiyL4fVatSdO6RIBSSKTBGm55uB87VqnggeM23ft
	+5kJi2wxnh2eOIVlnPMG1xOMBeESURz5RkNTR8tmOZKL6y94RMz0mZm8nUND/0C7
X-Gm-Gg: AR+sD13t47/LYtwfdLxIQmbUsOx6QHHCbPmFNumO78q1aNYnXJD9ZnQrxbKwCprsVHz
	FncusTCqZ/CYbxbuBJXav6YoGKnbLpcrmFNoKQ2RN7jTb2N3NIYHOSbu8FwMAi4DG+cyNGi26tl
	X4XZtubUTzHl3BQuDZ6M2uA1KQLwnRsvGhF+LqOCBZJo8ptlYD3N+w/ZWs/T5XfJFJ8ggiMm6m9
	hmStp9h5XZH6jpLmH2XFLth9gpTyXM/Zkf2ar/TOVK1ivD+MMh7tFHIjInCY/wXZqTE72inXN3V
	FA9qztNoEfAYWVsmJAiaKF1jlL4677Rg/eT28n5DaBcJ290sBhOFscXqaEVgoPZykefLbFLVcm6
	xShP6C12r5gXHROCkjwmYlZwnS565kWOpnYFQUvrT/LBVPe8KYxwQkUk4qwG1fYzsMpJcMlt8Hr
	+enzpcdq5zcctmvZa9gOPwBde2raEvaLRc+eoq4hL/d5plY/n8U0XpUskYRjC5a684Evi6ET3uM
	7q9
X-Received: by 2002:a05:6a21:6112:b0:3c3:a3fd:db0a with SMTP id adf61e73a8af0-3c92a62d724mr3112934637.16.1785592811080;
        Sat, 01 Aug 2026 07:00:11 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18d9c6sm18493764eec.30.2026.08.01.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 07:00:10 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	lmb@cloudflare.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] bpf: Check sk_fullsock() in bpf_tcp_*_syncookie
Date: Sat,  1 Aug 2026 21:59:39 +0800
Message-ID: <ca8d8c570509b02355bb4bd4e56859f3e2564c9c.1785576172.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785576172.git.rakukuip@gmail.com>
References: <cover.1785576172.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie accept a socket pointer
'sk' with argument type ARG_PTR_TO_BTF_ID_SOCK_COMMON. However, they access
sk->sk_protocol without validating whether 'sk' represents a full socket.

When a BPF program passes a mini-socket (such as struct request_sock or
struct inet_timewait_sock obtained via bpf_skc_lookup_tcp), sk_protocol
is located beyond the memory boundary allocated for mini-sockets.
Directly dereferencing sk->sk_protocol leads to a slab-out-of-bounds
kernel read.

Fix this issue by adding a sk_fullsock(sk) check at the start of both
bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie before inspecting
fullsock-specific fields.

Fixes: c0df236e1394 ("bpf: Change bpf_tcp_*_syncookie to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..afdcfdf41489 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7678,6 +7678,9 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 	if (unlikely(!sk || th_len < sizeof(*th)))
 		return -EINVAL;
 
+	if (!sk_fullsock(sk))
+		return -EINVAL;
+
 	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
 	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
 		return -EINVAL;
@@ -7752,6 +7755,9 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
 	if (unlikely(!sk || th_len < sizeof(*th) || th_len != th->doff * 4))
 		return -EINVAL;
 
+	if (!sk_fullsock(sk))
+		return -EINVAL;
+
 	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
 		return -EINVAL;
 
-- 
2.43.0
