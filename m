Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1D3DBB3
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395226; cv=none; b=HExi4hAGaspO4MP+7sonRwvpOiqJtMagFcwUIH+qJ8s773xOWceXKLZzVKT3uJUlAKAaStKWpuo/zMVRTXNGXZ5YHjTEDbcZ/qBN43T0srJyfKDP8TkNzK3OYh6keK8J6v3A42ShDJnOcXMMKxcKErhNqurax5fZg7Ph5ST/LIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395226; c=relaxed/simple;
	bh=V866d7v0EUjhFe+hV0qrTNaTJ3Gb92BOJZHI+Gz3L24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBqZdAaUB2koPExX4o7HZ0aqjoUKw5VC5txmdBUVKb0Rlg3u8p+CHPz+NTuzPIGD8/rBiDFRvQ11BK5ZddD239/1M8kMdL/lzcaGQ0YzfWizCh27Gp8pXVuPef9KoLCRoaxKbtwJ0j3kzfGM500aTMdwVKss4l5S3DRIxqMQu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rxTQMXIl; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rxTQMXIl"
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BFAE63FAEA
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395221;
	bh=qzaONF2ufkMLEwxVO924M3LwWzApnPaibbBgBkLZGxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=rxTQMXIl+s9TlEyQ/YloVV5GPHN+LVpAWmUybYi2D8xTXVG6RaMO/+wHr8JRlQ7Jx
	 eFa1Fc6S2xkUJzf//TSPgv83cDrqQg3kND/SyG7jJwmDmHu7XsgurXNpDodgdGtAZk
	 JtDUhw4AP9CW6VB2g+N7ZuJY89TQ/gqDpXO37wIdLO4OQgI/HC3XKTR5gC1dbbVJpB
	 Rsik+xpLEvjvorVay8OXTmi97B1yr29uOuV180Kt16wDdVTGvA8Bp/QoKOoa0D0zwi
	 XDitxMooq3vQJNgOxLn7/A9x+NvDqdVaxqbl9Jj1RcZhvM3ZimZ+RQFkYMvRK89EDD
	 X1wscRL8YyjFQ==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-515cddd7960so2168725e87.3
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 02:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395219; x=1713000019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzaONF2ufkMLEwxVO924M3LwWzApnPaibbBgBkLZGxs=;
        b=ApiyVVAF0N5ByWF6h8cthLleaYPGphG2CdMXWCaqm22ZFDcaRnwVn+J4h8egUK25to
         iy3E3G4WkVAIRA2G266T9/fj/NzHcO6WQprhq1Ph2lpEC6QEE4YND8R8LWoWwlBiGQph
         OuXKyDArh28S4R1H5BuluDxcsCG/oXgd6h5JnvzGHqLO/mMA9thSkcx74+1EOmf433cE
         9e/cGEVdB867GVnCzDW/88TrqIYhzvXjtaULkaZojDJdexWLnb0DU+DijAix2myerCHB
         KUrR7bWUbODMyAYQCVUJ4IkW5VhSJeuxw9WLFamuYurZBWNoIwbVV0V8dWxn1OiUEETU
         4W0w==
X-Forwarded-Encrypted: i=1; AJvYcCX2L6MAIpVvPC5XpkYhycAeyF+Ko6mAqnu8jrzGrxcE0uMSTUsZLi8K34mVbJmxOcJ+Hj01+yQFaawGGfgOICOKg+Oc
X-Gm-Message-State: AOJu0YzIAG1glBoSfly2a/ydAJ40OJaAYEiJjcT2CzTeCszMNCvfY5+8
	JA32O1yGQMX1cFv2xcb+DDtYf7UmFS3pnUcEQSY1auplBOfJ/ivUblKmmCAeBfk3FOCxMXmNcy/
	BF+n6ohyi2yzN3TyC8QIXyqUuUbIHLlSMgfZNkgQegr8UylifFykPcpLxBEuQA8ASpg==
X-Received: by 2002:ac2:528f:0:b0:516:ace0:9a75 with SMTP id q15-20020ac2528f000000b00516ace09a75mr2341490lfm.23.1712395219278;
        Sat, 06 Apr 2024 02:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZAyOXnlJzHnF6UAxzVX17DxYL4mhxCDf8C91bLhJCKP1I0WnSc9EcZ/D+EvzXCHwk6NrkuA==
X-Received: by 2002:ac2:528f:0:b0:516:ace0:9a75 with SMTP id q15-20020ac2528f000000b00516ace09a75mr2341471lfm.23.1712395218819;
        Sat, 06 Apr 2024 02:20:18 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:18 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] selftests/bpf: Add tests for ring__consume_n and ring_buffer__consume_n
Date: Sat,  6 Apr 2024 11:15:44 +0200
Message-ID: <20240406092005.92399-5-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406092005.92399-1-andrea.righi@canonical.com>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for new API ring__consume_n() and ring_buffer__consume_n().

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 48c5695b7abf..33aba7684ab9 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -304,10 +304,18 @@ static void ringbuf_subtest(void)
 	err = ring_buffer__consume(ringbuf);
 	CHECK(err < 0, "rb_consume", "failed: %d\b", err);
 
+	/* try to consume up to one item */
+	err = ring_buffer__consume_n(ringbuf, 1);
+	CHECK(err < 0 || err > 1, "rb_consume_n", "failed: %d\b", err);
+
 	/* also consume using ring__consume to make sure it works the same */
 	err = ring__consume(ring);
 	ASSERT_GE(err, 0, "ring_consume");
 
+	/* try to consume up to one item */
+	err = ring__consume_n(ring, 1);
+	CHECK(err < 0 || err > 1, "ring_consume_n", "failed: %d\b", err);
+
 	/* 3 rounds, 2 samples each */
 	cnt = atomic_xchg(&sample_cnt, 0);
 	CHECK(cnt != 6, "cnt", "exp %d samples, got %d\n", 6, cnt);
-- 
2.43.0

