Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604156;
	b=2/jconL7gSWfHsAFeW4/2uFaqCTCZksCK+CEO1tD5wa8nok509LqqRLYJkdHZTe/KPg8
	 uxZJkUHiOVnAtpPdtjATYhaIMn4TFoQkfNdDfgsOq5NVL11FF0NyimHRG5kQIob2NVvLN
	 m1nln+ipKU5+9XxEcNbq6fosPUJPjFLSuetlx63KnWr9BXrSHv3annyPHtdyHyAbyRzIr
	 eSz2EcPFFj3shVkcBaBxZzIf3HSEVN1Y+FNd+5QfxQksz/Lb2GBY5y2S/Hz+vjwnYtODP
	 9WCXxrtAA2dG+L41GVNMNJXi2ao4cCsXKdfJnMNTdDMqt4NSudN2jY6Q1vNm4SrPM6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
	b=ZBYDWXA4ee9irn6IHwiX7fENIcw+hjAXkg1Xy7yppr9PUUm9/BqntjJ9YaiiU3j62Uhv
	 mQ+VaVRBWaDU8L8cQYSf1etkJxL0U8CGh7KwFX7ZmeKxTVoNZMCJ8BMcFgFoJEkGqpuBy
	 hC1h02x+XiCQjXAZL7qqsrS+bJ+aneNKKjAh2loVwqLX0Y+iCUuycQj5j2lvcZmFEhXhl
	 ZST2mdviGLQzPhZaO3oW+/2RGBGIAukOktuyeZYuwI5PHA5gohm9Ry+Zm47IxmP5zK7w6
	 6ytiyd/oYqMafGdyDi2iZzy2Hb7uYa6tlKyKmOagOSsqc/DOIws1g0jciXOpgb7aRFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3rdKFsI;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393C606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4393C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3rdKFsI
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso15778605ad.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604156; x=1794208956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=J3rdKFsIh/VOU3Z9IujXGcPGdVqgLtYrJgw5MIy/igWi/drqwsCdxEDercaQEmWYp+
         ez+wjhkhPEvqWhoC/fRrreXVBpTFG1SvmN9jH3tt+xHwP3FPllGpuZjSYY/wjgTb+gKp
         tLJpYe0c5Wyc2etjb4T+lz/0EgyIdsIdsCcXooSrGCl49SBZhvJpvH/E5dO+UhmIlW7Q
         UGU92AV2r0r35s3H7OEkypAJWtaZBRs+IKLDAmBMsOYy1Yx96K+V6mi8BXQzkWWcVgDC
         85Dz3eza7tcOQb3D01HcA1MC4bK+EBV30UjO5g9XcEoG9ToUMTXWYttYK78L29wO9L/b
         d1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604156; x=1794208956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=dVSkVCaKrwbK7nldTbvnAuP9fY4e3C4hs3gdsPWp8vszV7NZZnnm7LcZ7spaRDt6Bj
         1miUbVWSacGNSGrkY/0c6EN5bmlq/fyhLZ3PkUyPcydipoSHPAM31RJiVQPmwhw3SzMh
         SHGte3OfUnJlIkZIflnXqVj4jtTtDWSRTIzV2Y5fX4mk398Go7X7fQmh4Mz/mteoi2NX
         Lb6/s45Bksm8fGxmDxjYgeO92PqZakLzHetUiBOidAiWztRJChViiO9RkZu5Aw4XcVDA
         m8eNyVxVxsYo0YDhdYd7wloAdvLjmWvBtAT2rupjfXq8VKuMdCFyNevcQXOH3DADOrf9
         NmUw==
X-Gm-Message-State: APuU4Z9W+0JDsKBMuUObcD3YPn0eiHecxva6jQuCojlST8YTk54noCso
	isamotj7V+TTqVn+Eh4MoYTaSuwYxcv5Mb5X5WHtphSl+oJ3d5Lv9OBfw320zA==
X-Gm-Gg: AYBFou1MkWElW+PF1mjW/qT3csumQiL3N+7di3+1cR9IABm3/mSnt+J/qETTVXBE/f6
	K6yM65qLnc8DF2W64cB9atu423pxSsANcyIXqyP0OwIpEWwUte3P3gOmbak7cE3KQuB/7iqSSFv
	GUVjKm8eDcE/Ul2Ri6y9DjFpiXF0RL4eaoFdRdRRqAzdvlTpLoYZVNeN+D+4n4E0Omu3GBDM8Zx
	VE+vPJiwFCHqKvAdaDD4SmjMiMDc9rA0TTXEitc0V048fOCnNHUpJGXQ4d6ztl9tt9dMX/+2Uok
	7xvOPDSeFiqZ/e5gs3sHmxoyPlzll214sMvnUz2OTXbaJMRaKo2PZMQN8KeXn2KFygEmmgiTSgz
	LldUIRTeIDvyCJ/ih8RQMobXGvw1ZWOPfC1TISPuCenQmCGeUnq4eCZYczwBmVZC5yUvqz86G/V
	VQLLre3v6IJ+04AEbBwfD6vCTxD7zfa42Xq33htfh7IsUL1FwCn1mUmnimOxGyROa2+qzi/ATor
	w0xYmi0wfS3e/eSXlqZ12jTqGUXK22ifDwGu3Pe9IHAMFcK/dqznl3k8PEoRDVN3H7C12Htcz8G
	sPny/gJYc6siVjCPgexLuHg19d5DbRBmZtNTzENcHUDSyL1PSFSOxlR6iRHZY9D16db92UN0zTF
	rWsBAa5mFs6+MwZ4COmiFgSEhzY5k/gU1TYxHjNbGcXTLJo7oYItCzdy5+EXRkL/Oc8sQce48dw
	==
X-Received: by 2002:a17:90b:2e51:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3ae8983f049mr7620183a91.47.1793604155368;
        Sun, 01 Nov 2026 23:22:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm3292338a91.0.2026.11.01.23.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:34 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 12/15] bpf, sockmap: Clear the redirect target before the sk_msg prog runs
Date: Mon,  2 Nov 2026 07:21:09 +0000
Message-ID: <20261102072112.4160195-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_msg_redirect_{map,hash}() store the target in msg->sk_redir, without a
reference. After the prog has run, sk_psock_msg_verdict() makes SK_PASS a
redirect if this field is set. But tcp_bpf_send_verdict() runs the prog
again on a cork, and on the rest of a partly sent message. Nothing clears
the field between runs. Thus SK_PASS without a new target is a redirect to
the old target. If that sock is already free, this is a use after free.

Clear msg->sk_redir before each run, as the skb verdict paths do with
skb_bpf_redirect_clear(). Only SK_PASS without a target changes. It now
sends the data on psock->sk. Then sendmsg() can return another value. A
redirect that applies to more bytes uses psock->sk_redir, with its own
reference. The counts msg->apply_bytes and msg->cork_bytes stay as today.

Fixes: e5cd3abcb31a ("bpf: sockmap, refactor sockmap routines to work with hashmap")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a5d498982848..8a3b8536c0c2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -936,6 +936,13 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
+	/*
+	 * The prog may have run on this sk_msg before: it is a cork, or the
+	 * rest of a message of which only a part was sent. The target of that
+	 * run is not the target of this run, and the sk_msg holds no reference
+	 * to it.
+	 */
+	msg->sk_redir = NULL;
 	ret = bpf_prog_run_pin_on_cpu(prog, msg);
 	msg->sk = NULL;
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
-- 
2.55.0

