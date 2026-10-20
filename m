Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491924;
	b=rmzGsucSr9vCHaukS3PT3W4Yt1qqom/2NqbPXhU2uVYkkrrMVgGyBv8g2FKiJAgdjC3/
	 hGqbJrOPRiPukm6bKqGZPJPsvPC6e9vygrShsYhZK+jCAxrbv7+cm30DoQWaYDXHPLozE
	 eofSlIDyMs6KiFWGtMQTZRGWxn26ntasSuINiFtkEre7MlMsHghlZ6AgqB9kXgm7e0yvH
	 kkoLIXKYwni214eibH5LU/7vw0GKnCaE+CYkvzgf1Jn5H0P2lPlwtYOCX9zFQnT9mSx9R
	 RgQVhi06DwFuOLW7yP3ZflAUZTTqCZdVMafvnNWMt1+EEGnDzi1fHD3o5C2awKwt8vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TM2nirS6qLCdfkEXwJGzTZRWTT5VvtzmWaq8aIlT8Es=;
	b=5R3bcRB8sxQbSKmPaREiEDKAT+rRhvwbp6SSP/ZEu6CGgyLW/pzoIt67Tmb3yeU1rfSX
	 EgSYlIvySUKRI/UYHzxvhwzWrg9u+swNkzzoNJOjKuBRAZKGKmVmNd0AczQjjt1NgFSyS
	 06o32cbFCvoWSqHA1QJvQKMK4X1NQfKdsl6ZtW9GQ9qVmFn9NXj67p3VLdBzwC/KJ0AM6
	 2EVS3dcMEC1B26zSPo2ISdtt1Jh6tpCTkPPg/mhe9+YdPCPrmM27D0avoqhC7nZMjOsNU
	 FmfwB2+0xdl2WAW/j8oQbXGBm5u61tOadl48ldv+UG6j6lXhjSyXcER4Kd0cxNMzC9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rN+ZIgn5;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83D606A32F
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C83D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rN+ZIgn5
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1df146015so18015035e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491923; x=1793096723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TM2nirS6qLCdfkEXwJGzTZRWTT5VvtzmWaq8aIlT8Es=;
        b=rN+ZIgn5UDsDN7iYJJOAzOWGo+ZnZO6ByKmA+QRfdhWJfLlAoTB1Pi3HTkXvmNziCv
         Y9CRa7/HjbBvVGW3eMSQZHfdejFDKvLBH+xRMeHqu9e0KNgblNBfkrEPfpUeIUPmL6nO
         4naGbzrVV/c5hvWSBpiawmbKBBYYbRUdldYkPEqxcg+VgcopB4dx1x8kCTvLcIScPMjW
         Wpx3uY5XsAR0oXYO0UGidtjSIjQ0NKLUGmoyVpqBHPP27xJUATGs6yfGMd2kLApfHdw+
         OYIQ2JdoWP00tPo0w8DNTWHP2+xMQAvrMrK99/w+39XcRuOYJMxou1TZFfV4gVILlkJR
         CMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491923; x=1793096723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TM2nirS6qLCdfkEXwJGzTZRWTT5VvtzmWaq8aIlT8Es=;
        b=R8icUqLUHf8r/KEIMfvrjrmjc7eooQ/uw2mTysl5OM/Egi/7sNcFp7UL3ExMVUZptp
         Pdb/SlauCluEcSsK7FHIhDWARHCSzjNW8FFUgciZbM9BE1hyVshq+WXWuUsi+DyDrdl4
         fcP8CPd2kBAeld31VO894DbfgkI9GShMNx9v3R33XCoKKSCumO7aBv4beQAm6+RtjqLT
         q1vI5Pgft2sL0GlZnJwt146NballjyY4UEUYLatNbPRHtQeaTFqvFS5Y+3sAcLV1Uftj
         QpAB4N3zIJIv4B1oJ+VhDLetKiw8f3oG7n/TRKm3cGgkFwvh43b22nYpc9iM56zbXFXA
         1tCw==
X-Gm-Message-State: AFq9FYKD3ZgVISDCfW18KwXSLL9S/Xi5rsE6Brh4KxlM3Zrj2BwRq1Cq
	LZSVDngTV2tV+iQug0xRrVefjQNzOtPzIlrhFkESo1t7A0A6347grpbOzgE1eZkNyZw=
X-Gm-Gg: AYBFou2RqKEodi4yqvawYwslgSZ9ViRlP9mXfCFr5+sJrTKxODY8wOzpZoBZsY2h8BY
	ZAqfoBcbyLoGvYshszY6LSIcwj/9N3gTxoRR54gy0lcMZMf5kOyfVepPdu5lIfRUci/WEiHGPOr
	OSjSGDOLnn9qfT/Z1V1P+MDpjaT+rcblob4WU/t1tVNJ+F9KGFgnd6qnbJCGWDJszTSnqxOm9Ke
	9d05REF2qNltAcKkinvahSyYgnPPevOcijIM3BO7N3uXO1FtYeEubUEvBd2td3BbG4Hv8K7XtFq
	fEEpR4kxRI+n7Kpq6uaZEIX7N/OcPZfBq0G80OtN3r1QFlg9XY/tVKKrV5d3CHnAIs+HoVeXsVz
	rWgfuLkUFBdoCPcX+A4/FW3JQvGBI30dy5R97fb3svRJHNftBQLoEpqqZSo/7AONku4Gdkd/q1K
	vfe1ipOeJ4o8zDCAn5O3QTUFw+RNidW8MmwyaYjYQWgbv0pY1Fms1IS4y9cDaligaKylFaqIurL
	lIAuzd697KWV/B7yw1/D1oR7Fh3vKarbbN3qbLjNmx99A==
X-Received: by 2002:a05:600c:a10c:b0:4a0:1a7f:2abb with SMTP id 5b1f17b1804b1-4a1d75fe221mr175698025e9.11.1792491922422;
        Tue, 20 Oct 2026 03:25:22 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:21 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/8] bpf: improve ksock_kfunc_set LSM recursion filter
Date: Tue, 20 Oct 2026 10:25:05 +0000
Message-ID: <20261020102512.518479-2-mahe.tardy@gmail.com>
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

Improves '7ae4eb14c5f9 ("bpf: Add ksock kfuncs")' verifier filter to
avoid recursion from calling bpf_ksock_send() from the
security_socket_sendmsg() LSM hooks. The filter was unnecessarily
restrictive, this makes sure only bpf_ksock_send() is forbidden and not
the bpf_ksock_acquire() and bpf_ksock_release() kfuncs that are part of
the same set but are safe to be called in that context.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 48a2e2327ace..6c508c7a0adc 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -264,6 +264,7 @@ BTF_ID(func, bpf_lsm_socket_sendmsg)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID_LIST_SINGLE(bpf_ksock_send_id, func, bpf_ksock_send)
 #endif

 static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
@@ -275,9 +276,13 @@ static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 		return 0;

 #ifdef CONFIG_BPF_LSM
-	if (prog->type == BPF_PROG_TYPE_LSM &&
-	    prog->aux->attach_btf_id != bpf_lsm_socket_sendmsg_id[0])
+	if (prog->type == BPF_PROG_TYPE_LSM) {
+		if (prog->aux->attach_btf_id == bpf_lsm_socket_sendmsg_id[0] &&
+		    kfunc_id == bpf_ksock_send_id[0])
+			return -EACCES;
+
 		return 0;
+	}
 #endif

 	return -EACCES;
--
2.43.0

