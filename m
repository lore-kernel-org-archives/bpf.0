Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491929;
	b=2c0klmpUjLGJOb+HheljBnSFRp/+4GCodj9vpEV/7purPVYK8S2eaxvOO9Cx2hjYg7Z6
	 RalgATAIrAXpLNOxrdW9DYqgIr5ss6QuEe0By9bgQlmTp6F0SDPzX4IO3Bb87kttr11//
	 z1uBlDLBWSi7VtaEDFvsukS5jJcPprbXkxBe5DTEKfnXmPKJX3F0KKCNa8Xh2nByU9K4g
	 XdnCEyqFeJNbl0FTerUg9TTvIZsesFbvOSnq7pMVKzIGIRbibi8ksOpE4nNFtFipsbymU
	 weVVu3dQH4bO+vgETmkfXs7o5Div48+Gmw0xh6Q8nZCiqXUCLHr3sFPqtXpvRAL2H1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ddVaI0v2f71ZZ44CArj4LpoVJsryP700DD1ocplBW6M=;
	b=uDnkz80VlH42lD2UToiCW7J4DIG28DgenCTul1sStbu0tqY+Bf9qgkyJfT/N+URx08Uw
	 +3omQEtazr9/OJa73FDeDKAmTZ6CkZkP/HLoRYKK8kGlJnkpSdOOJRZsAyPfT/HYVZLEQ
	 pCguGigOfyyj2wXvBrv30ii9MW6YPp2U5ykg1ZdER5K7VqTQkFqeq3zJGx+PLPNcbCNNx
	 rjZ1IXi1v7UAsHRhc+Fcs8wEcu0L6nPKtU9fIpV+s2yINBGOhMkGykT2Ch9WUaUmI+7cM
	 5kF284sfa5oKiNRHtgTVVcNiJE5naSgHCVs5T8qpo7mkpjhWu0+kNvFaTuk7US6pcZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hg32D8c0;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BF60A2622
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4BF60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hg32D8c0
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso33652095e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491927; x=1793096727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddVaI0v2f71ZZ44CArj4LpoVJsryP700DD1ocplBW6M=;
        b=Hg32D8c0YB0vq+nwCCni7BZCvEQ4j6c2smN1VtqDfAtpRqex+OgzBtiTA1tnwA8rXP
         AczlMkWvkljOf3TqbbBn8+NzW3jH0w/0ElDduqdBxn8BW3sNNshAYDEpHM0H9kOi2ArH
         7Xo8F8G1kteEmy4sS9ZRVgsz1gSrP0DNPYIhbf3m0TjCMXWxy7EYMaBbNQ2UQw1imGR3
         iEx/QRgal/tOXJN2/8/oHlZgnFJvdQFFFcLS4eWmCwEXZso3IStgzWAxjUqBhKsA0eBn
         DXfCCBF9agMoXTwaTLAWOYSOBGTRv8YWlUAC0BbsomEVRTWIHMcNKi+dCe/U+RQJ9p/9
         cmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491927; x=1793096727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddVaI0v2f71ZZ44CArj4LpoVJsryP700DD1ocplBW6M=;
        b=ikruX/c56zLp2vMt6oQ43m4xVpaKZJWN3jJpFpJs1Qgx+xlflcnwINQgmdru4sehtY
         U1omW67T8DJfZZfqj5KLAGfH9db2MJze0Ln3yod00Tx98gdPRLjm1oKwnx8rtXYOWd0y
         oLK2ZMwN3aryxNC+lT0WfYTED61U+Nfxgj8W4mfZLy3a/bdEJYaDK+h/6YrNSnTiIKaW
         aynLG5l+W+1tBHMtUQ++Ic4IVU97nAqjydkMI/k2PHlEyx6BCkKZzOcIkfKDUITLKFm0
         EOIvgbQTsDcGMSoumgEwoJZUGju009BMkOEQH7sWiPzzRo6kAiiQSkwrE+uZawNcqqpa
         Z6pQ==
X-Gm-Message-State: AFq9FYL7y+FAfyVa8fr8xH9sFosCXLiXyZg/xOZP4aFKqSMODcXOLRND
	hzDH1Sy6e8uyP9qPFTsbFpdGFyp10yY1fe3jm17aDuUFRo+Acg+NX8rQXszseFGCrBLbbw==
X-Gm-Gg: AYBFou3RQR/5cXXFUmCCSL8HNnqwS14GTMjDkoG+ajw+c5OwaSQ08UgMJNdLaTRi3p7
	9t9PiIyD3gBcIMSZCKpuBVY1hK4dPkFEo8RO2oEjCV8ZjJGbpPCr7d1sNHAIBUdHzrYdWn4FhR4
	WZ/1cSbkaB+qyDjuAVzkU0Uf7ObS0cozm5vBSDdVsFTNDk9utIqVXPI3VIupCa9Zs9dOXBlbgyY
	Zry7czgjWpBmU5XxTfuHJW9FZ2qAJ7JZz3IzG81sz4meGGXIkqHDiEJPI6Z2pvnsy84+ZQX9hfd
	c1kJUuRLjuy1JVbmQHpZt71f+BX7A2tO+sT6akT+RPrpRdv9k8Mu16NeqqUvyoMdoOusHJv7ARL
	qfDXjpDy/+k6MXrjfDJU5S9VxRSfwGlKLIvTgT1u95xTKN6dywTpo1ndI2ABvn+JcXlbCsxCOY5
	dfp4K0bYw/Q9L5cCNphBZ6XzZ9XpxS2pG1eyIixMXBTMvkUQW2BSHukfPLjXsrta7WN0TH2vNfE
	q57Lc8rxQwy+dc55IqMUJDcrhoMyHzb8GiYnH4tZt6w8w==
X-Received: by 2002:a05:600c:3b13:b0:4a0:2150:55fb with SMTP id 5b1f17b1804b1-4a1d75ad08amr259692375e9.4.1792491927077;
        Tue, 20 Oct 2026 03:25:27 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:26 -0700 (PDT)
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
Subject: [PATCH bpf-next 7/8] selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
Date: Tue, 20 Oct 2026 10:25:11 +0000
Message-ID: <20261020102512.518479-8-mahe.tardy@gmail.com>
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

Similarly to '7b0dfbf5776b ("selftests/bpf: Test forbidden
bpf_ksock_send() LSM attach")', tests that the verifier filter prevents
bpf_ksock_sendto() to be called in a LSM program attached to
security_socket_sendmsg() as it would create a direct recursion.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
index 7b5d118e5750..82901c9e78c8 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -33,7 +33,26 @@ int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
 }

 SEC("lsm.s/socket_sendmsg")
-__description("bpf_ksock operations other than send are allowed from socket_sendmsg LSM hook")
+__description("bpf_ksock_sendto is rejected from socket_sendmsg LSM hook")
+__failure __msg("calling kernel function bpf_ksock_sendto is not allowed")
+int BPF_PROG(socket_sendmsg_ksock_sendto, struct socket *sock,
+	     struct msghdr *msg, int size, int ret)
+{
+	struct bpf_ksock *ks;
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		return ret;
+
+	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
+	bpf_ksock_release(ks);
+
+	return ret;
+}
+
+
+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock acquire and release are allowed from socket_sendmsg LSM hook")
 __success
 int BPF_PROG(socket_sendmsg_ksock_allowed, struct socket *sock,
 	     struct msghdr *msg, int size, int ret)
@@ -103,6 +122,7 @@ int BPF_PROG(socket_connect_ksock_allowed, struct socket *sock,
 		return ret;

 	bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
 	bpf_ksock_release(ks);

 	return ret;
--
2.43.0

