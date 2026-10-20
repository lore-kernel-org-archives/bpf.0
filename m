Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491926;
	b=vx/wTXp/keC+vCTumR9VKPGM/1/0mJWQml7GpPtytGuD+IBAlsWdbxzzXxUM7m9dQZfm
	 9HoGj2PvywCm1v2GeYeDV4z/TMwYn2bI+y/PQ4OA95rkjoQhoi70auhVnb7YH01Y1lqmk
	 hLaGNW6F7e4Uss/f/ffY5GCsmoDUJxA+u7IPH/DcKTeueIr4xcpp9zQJO77eRGhscmVLW
	 +iK//pdkcr6CJrCydEyZU8ZS9pQmiS47ams2t7rzhbjWX7Aa1MS4wRpn0NC6aIPGkOZ/y
	 3p1dwiyHdcvmVO3h79k/teVJvju6ZXOZX1ad15KvIKqES+5YmxJ6S8efPAEFPtaHZsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z5XGNpGXK3qSx+5JfcbKid0ZtLDq9NM4nm/EIul2pTc=;
	b=yyae0kqTz8CfHB6GxlrVXm6pw0ftWxigKnyhG5wRH5rvxxIGniBHp3NCRgLfCuAU4ApJ
	 r/nn0sdf/7+vWp/t2KKIrBToGfT1l6NR69Vs/jKGsuAtEdRmMOR28iw+fwRboDaF0d0Sj
	 aOOUWLV5Nv6Pcoo1v+f8GAV5JQnGuoK8dk0harL7ovQXuaWB/OHIY+MGelZqI/BBQb3Mb
	 Flmjd/P3D5XP0/UQewt3j0vUUj0bGts8NAg25pka2wyOV1sEGqe424rw7WnWrakYfWYr7
	 bu+0tzZN8z6Y9c/7iDuLRj58QPsbjoOSjp0M+UQfpCGJZCCGQMoRHDvJgU6Jms6nMVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JlmqurnS;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA52606A333
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA52606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JlmqurnS
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1658797f8f.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491923; x=1793096723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z5XGNpGXK3qSx+5JfcbKid0ZtLDq9NM4nm/EIul2pTc=;
        b=JlmqurnSfs9uNHxOetvntBvp9V1dThkS/Kric/sKhgYqj/a16I+EmevTE1wjd+IH62
         CRxqRGICq0AktlX5sURhJxNzwhyER3TB6ecKcyKLZ9lNO00iQHRT4f83CDUijLx0fmcF
         1ylzJu9PCKX4pFYIJzY4CW3lPgSVyYS/KrgWzLCz5LdDDxbVJB/y9M74yPjDQlWlKY3c
         wQGsYwzlSMEBaHdtwtqrFJojIKzdXOVeT5AuBt2Y1M3Gsyshc6MS6emtcs5+seEhsau+
         KmsY8f+eT7K+A+a7DRE7GUOpz5ZIcrIz4rPhzRf86+5xGoFrgFKd6pikOYJHmut/RDZk
         Zg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491923; x=1793096723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z5XGNpGXK3qSx+5JfcbKid0ZtLDq9NM4nm/EIul2pTc=;
        b=eRhqs2Re4cabyccMzLoym3S/blxdnuMEoiIvFrX2QpA/QZqP1IUXykhZ4lTvsXR4nJ
         1j0YC2DDhPG4aUMhdhB+G0xaeaWw+ip7xQvz2mBeJNU+J0W/p2Fbh4KFgPSezpaJaT2w
         vRnUKcZXjQIbdgSAG1s1mr9vGcHwmeHZMIOoHq7j+JVKBIiSCaE2gxAthYvdLn0v5HhS
         Tck8DpiH6D0k/ab+T0zra+Ocr6Z5YKYLYe9J8rJG9BY2amfotyIUU+5fpKW/iWudRJmK
         QBt/Tw0Qh2BUrPh4OTYSLuKBssHHvNLow/5tyaK1MRO863I15332AM47VOkkdbVrVNEz
         E7jQ==
X-Gm-Message-State: AFq9FYK7yVa3oz/d1CTzF97ycBTs0dJCvmCoROnNgoeHEffxrys6wQty
	rAc6P/KmfJchvJGA8xEWzKkJHtLrizbh8eLdaFjRL5+qJULS+xXSmjz0yqFytXHSXrQ=
X-Gm-Gg: AYBFou3QZ90JNp++Qi3IjkMUOP04rBKfokpBpkw+DVMj836u2YzCpMOkoHfD+XwlMD5
	PWVUGKOEmQ2fWi9FN+T/7+vyDvSl+DVOGA4/QVsZKho+BUEXqdtlRpqpb8RoJJUfdkuN1xoW28N
	jTB1k1+RpBn2SPaEEHxEdYnGD+ESwOlbZwjcpIyTG9dfhhO+3fpZGn6cnvNyydbpxnvSCAwBD+F
	XNEjtl2bO9zj8u8/4K2+026dGs5VreP1+mavySpOr2eFjZY1kOT9QMGP41BHE9l52JWYHcab0EK
	etQuzTh70wT/CTdHSkSJu24Z8RZeMi1AHKIWdi0sXzKw1pfGEk7OOnNtZeVRLxyKg2w5f/hHEDo
	8zI81kPOHuwjysiMzOnfGOISeoPODLjwTkhAyLqJhQ9nrbTn6h7SBKWGgTM1i+HsRtajw0zItUc
	H89ds29vFqxrKfLgMeu0oA0wj9L7vuiFVZzZ0QP6KvOIwc6vqx6k6mQynzkoocwPaRYtYNkm9TB
	h93VExKWYE/Oq+JV/Zrkyn5YOzC+NrBPVkK8LxVRMtHK8Nbu+8uR7W8
X-Received: by 2002:a05:600c:1da1:b0:4a1:6425:be69 with SMTP id 5b1f17b1804b1-4a1d7614e61mr231916665e9.17.1792491923358;
        Tue, 20 Oct 2026 03:25:23 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:22 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 2/8] selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
Date: Tue, 20 Oct 2026 10:25:06 +0000
Message-ID: <20261020102512.518479-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020102512.518479-1-mahe.tardy@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
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

This test makes sure that bpf_ksock_acquire() and bpf_ksock_release()
can be called from programs attached to ksock_socket_sendmsg().

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
index fd2ccfdb5802..740ed370d28f 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -12,7 +12,7 @@ char send_data[11] = "dummy data";
 SEC("lsm.s/socket_sendmsg")
 __description("bpf_ksock_send is rejected from socket_sendmsg LSM hook")
 __failure __msg("calling kernel function bpf_ksock_send is not allowed")
-int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
+int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
 	     int size, int ret)
 {
 	struct __ksock_ctx_value *v;
@@ -32,4 +32,21 @@ int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
 	return ret;
 }

+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock operations other than send are allowed from socket_sendmsg LSM hook")
+__success
+int BPF_PROG(socket_sendmsg_ksock_allowed, struct socket *sock,
+	     struct msghdr *msg, int size, int ret)
+{
+	struct bpf_ksock *ks;
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		return ret;
+
+	bpf_ksock_release(ks);
+	return ret;
+}
+
+
 char __license[] SEC("license") = "GPL";
--
2.43.0

