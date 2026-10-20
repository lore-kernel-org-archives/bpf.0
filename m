Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491926;
	b=nMyIouwlg5wUj4S76W7IZnIoJbyG8Ol+DgSeR0/GSgZn6mPo8n/tER9gZ0a8Fk63bwuE
	 j1oEH/QVcFgNYJLF1jIVqBMkzsyUjN3nB7ckOZYZxxJBx0QFfTsjyy8sB99w7jY1+gsLI
	 JNyvnXbpw56tuIDU1HfmZ/E/cbINeJ1Qr5KgzbrnvwqH4BLKiwtuLyh7GeTRMaiyV/e4y
	 jM4pMtNy6Pv8dsQG3h6i9jNmiVqVXhBb2zg+St0xAruSi+sDe4WPtwCnaBBXPcGu+KDrU
	 NWYK7s4mMBHV4XSwvh47HVYxBVcrmyAYLdE2NFAfGXrAmsHxMEX+ZjL0bAjeYESeFpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9vmVUK4edB1q8I8ZmjVfaRKyA02pZXb5Eagp0UVPZCg=;
	b=33fpcI4ipA6Ni0kRjfn5z12KQys/Nuajzl2HCwZrE9ZHv2vHUYBBZvsW2BgOlJBS8Q8W
	 mzC0lRhHB8jHjK6LvOXFllnmNXrz8OaglBFnJrKHhuR9YJ3fMjuyc22PctDNxgrtjfqJU
	 bmz1CxI8ncYDhiWup/Rdc8VWRhn4by9nlxOVTHSBiUNV8yw2T0dJnfiaIrNlFAmBxwErb
	 Q3qi4pqAwqaBuWzRXTT0wEFr8a6nmFRpPGC/NobUe3V3ClRiSShAZPBjux11gbTvkQgc9
	 o2RmF7JHfQhu2qjqC5y+clfVvTcKwkUPM+LD0nvOUE+Vqn6xyK0VswSr+eRKgzrM68A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecWKua4W;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAFF606A32A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEAFF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecWKua4W
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso24458665e9.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491924; x=1793096724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9vmVUK4edB1q8I8ZmjVfaRKyA02pZXb5Eagp0UVPZCg=;
        b=ecWKua4WoxWV6QYeBGtoAohC4EHnMx5TsMOGXQLQsqiTcayHaCNRt5EARml8kYO3Vx
         QORwP5ZDmqReZBd6kabaWNNPBgxgBfgaBThfAr/VPrNs/jl13SkQbRY4XMUc/ZyzNSzy
         vlnJTB1Jy4uESsxqRC7OYfg8jKKoT8jJPPz9Qjau0QaVofMxNqbQh4hX/SkWjUbSHcMr
         tzyY4eiwCGcxzZcjLnBVc5BfHTDLUuWLTW6ZwKnk8lyNHg3bbte9JuAGQMIi27gIBszb
         cYn6RXyx21YEBKqJvl9CU2dDC2YbPR7bccBlUMeO1/UB2ji9vrBPj928hgwAqHd5cc72
         edOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491924; x=1793096724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9vmVUK4edB1q8I8ZmjVfaRKyA02pZXb5Eagp0UVPZCg=;
        b=SzXo0mzWnqcU7+cilATA3cpyYURN71kclaI8GfxqTafAAucMUtmNZ7umkhrmL9aMif
         38cDDuNpZR6mQ7ASok3HBzfCeHoqra+L5jnNcNa+fn7rBQRFQYbhd8m7UR3gEOXHwQkH
         gmNoxmzc2qtSUWKDIkR4YEKAjoaUplyWFUGTx7DLPoFlIfz0i0BKY+PWHYCNjWqzvOlA
         RNT6W13LkFsjVTvlauGt8B3+0WOi5phepkGDI9EjBcEGTuMqj5VPQ7c1L8Rk8XGc5GOI
         +U4cdJ0U8NP9bi8sNkiZYEws9KrH4lPhqYhhp3D/wFo1/vbuH1+93TRtmu719MDTbKqS
         oHmQ==
X-Gm-Message-State: AFq9FYLBNa9JI3d0kbNEBmPos3/r9+Z6mPCsl/66hWE4Q9GHqh+bcAcO
	zkrHsGnZq9rvL2+3GzrbbyDlgGXAuEnKU43e3lfzAUCLKdPMDifr+x45L6WcL8n9ujQ=
X-Gm-Gg: AYBFou1EgEMv6njPGo6lwQqDEvEgEh1mLbnISGkOe3a0OhQkZecKiWwZiqImqDULf1E
	mz3xpFmEYUs4kxmTK1W9Vc/+FjEHqhjpb/EUrPlIVsgEnRo/MyLGOHNR3wQiErOo7B2mwP+W7i2
	u8pxKwrHDnzo9XMRdy5kOYoa+89qLE3ijNEfqaASIH75XWKckkmh1CCg4ar2UoUab7/flgD6BWR
	IFzGhhHwORfdlkBYSiwsKc1k7MZ/1gIVv7N9HxlBcW/52urahl6E/+NpvL6u/sqwSPkNUigtjko
	lMHHZXDiwtcI0QwD1sZkPhKaYExWQXbbYkswGnlED387yaDOtfWWB86dlXln59p9WunX29rDwXa
	sLl1lTgyeMQSj9BkHCJOXjovSTT388awu4W33XBqTqoG6mC6KMDQKXkv37KNPqKmLahO1OOJLXR
	lTb8MJeE40qRdT9YfvOUbKfHiRK4zLMjaNCxP7D1ikduyfZGvYdVvT380I2BMMJ+C/2LYCweqRF
	B8wtYytU6PbthGL7cIdE2M8VujrUYJVxa70WIC58w1d9g==
X-Received: by 2002:a05:600c:b99:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-4a1d75a9828mr204102215e9.1.1792491924037;
        Tue, 20 Oct 2026 03:25:24 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:23 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/8] bpf: move ksock_connect() out of init kfunc set
Date: Tue, 20 Oct 2026 10:25:07 +0000
Message-ID: <20261020102512.518479-4-mahe.tardy@gmail.com>
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

This allows to ksock_send() to various destinations by allowing to call
ksock_connect() in the send path instead of initializing it once for all
in the SYSCALL program. It was limiting in cases ksock was used to reply
to specific destinations.

We need to break this potential cycle between the two LSM hooks and BPF
programs calling kfuncs triggering themselves:

socket_sendmsg program
  bpf_ksock_connect()
    connect_socket() -> security_socket_connect()
      socket_connect program
	bpf_ksock_send()
          kernel_sendmsg() -> sock_sendmsg() -> __sock_sendmsg()
            security_socket_sendmsg()
              socket_sendmsg program

Breaking this on one edge is sufficient, so in this commit we prevent
bpf_ksock_connect() to be called from LSM programs attached to the
security_socket_sendmsg() hook.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 6c508c7a0adc..87329c4a2f8e 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -144,7 +144,7 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
  * Connects the socket to the specified remote address and port.
  *
  * This function may sleep while connecting the socket, so it can only be used
- * in sleepable BPF programs (SYSCALL).
+ * in sleepable BPF programs.
  *
  * Return: 0 on success, negative errno on error.
  */
@@ -243,7 +243,6 @@ __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)

 static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
@@ -254,6 +253,7 @@ static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
 BTF_KFUNCS_START(ksock_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_kfunc_btf_ids)

@@ -265,6 +265,14 @@ BTF_ID(func, bpf_lsm_socket_sendmsg)
 BTF_ID_UNUSED
 #endif
 BTF_ID_LIST_SINGLE(bpf_ksock_send_id, func, bpf_ksock_send)
+
+BTF_ID_LIST(bpf_lsm_socket_connect_id)
+#ifdef CONFIG_SECURITY_NETWORK
+BTF_ID(func, bpf_lsm_socket_connect)
+#else
+BTF_ID_UNUSED
+#endif
+BTF_ID_LIST_SINGLE(bpf_ksock_connect_id, func, bpf_ksock_connect)
 #endif

 static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
@@ -278,7 +286,17 @@ static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 #ifdef CONFIG_BPF_LSM
 	if (prog->type == BPF_PROG_TYPE_LSM) {
 		if (prog->aux->attach_btf_id == bpf_lsm_socket_sendmsg_id[0] &&
-		    kfunc_id == bpf_ksock_send_id[0])
+		    (kfunc_id == bpf_ksock_send_id[0] ||
+		    /*
+		     * Break the socket_sendmsg -> bpf_ksock_connect() ->
+		     * socket_connect -> bpf_ksock_send() -> socket_sendmsg'
+		     * cycle. Blocking this edge is enough.
+		     */
+		     kfunc_id == bpf_ksock_connect_id[0]))
+			return -EACCES;
+
+		if (prog->aux->attach_btf_id == bpf_lsm_socket_connect_id[0] &&
+		    kfunc_id == bpf_ksock_connect_id[0])
 			return -EACCES;

 		return 0;
--
2.43.0

