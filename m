Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC61A0728
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996136; cv=none; b=q6t/xJHOYmnopmXYbOE90Srq+Kf+zo/i6XQfWVRD/gnEP4cUVw0VMZ5vyp8xA33M0/NGNtbhxNrD7N2sXJeWZ7wUTOcIrn2Gxc/KSHLoTvAHWgsS6smVsRGOXCpgxxrpB+NMon2OvqD2A2vVSLdHznbgjqMUn+4yBZfxlr7LCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996136; c=relaxed/simple;
	bh=5Q7aLuxOVdADzoU0uivwq0xD+2sqiuHUFUnRzhh3DKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohTj3IpS/so1hPs+wPsw6FK5bMUXP855noOReHMjBQtNvEg2gMmjh+nkMODto/QYbpbwI4VgjgwwTIG0BMGjx1RspKtG0SekqFfnC2ukRPjJcMEXh2JeewaIR1cb0pRx0pnd0EidwG6Ge/GHojpRYmAoxxe3bngjJMQ87rDzeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV1ujL4F; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV1ujL4F"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c7393c6832bso683032a12.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773996135; x=1774600935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVhVfvEdh8PGLTq9OCpKCKnbK78t+8gkIfnExz2ct6g=;
        b=mV1ujL4F+PLg4+Qoce68BOLDq4TYZ3R+sRDJ8w83pAVFNL697z1QfO9niV0bw53m2d
         qZ39IAmJCnS1OC0ts9Tegd2l+E9DeQuiK1vWBpY5NzZUs7VFxxprNQwZbd/liQKckaDY
         i7SI2lryLhX57J8gRIYwDbwVN19q2awvVcgHjUKlNVGJdrOSwGqV8YIKsVqslvViI6xA
         NrjqSuMOPNbiuvq7Qq8x/EtcXYwgVxGGKuo7RoNFwaQYaR/BxZ4JTsUPaT6ba4BupZXo
         u7YvN3qz3wvWQLsZpb6VZ2XlnkA/2AfvWXd0MK4a6iuzs6U0W7SWCyG+z9euY1HfopGR
         YyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773996135; x=1774600935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVhVfvEdh8PGLTq9OCpKCKnbK78t+8gkIfnExz2ct6g=;
        b=RKt8ky140gi6WY2/uJzZD1UhNyg+vZjJG6ClXaDQlXzc9Y4kMbKI7oAjO+AJ959Ikx
         DrIV/U0Y1jQzZi65fdjUINwE8qcfmvPEwT4MuGoTtoSct+SeckeU/mkOwnM/HNIiy95j
         BsFWQtjYhpWR6ha9irrJcSKNOauiKmbF3C8vqJLae1Azl4ILBEpXt3vFJQfI0hsleLLb
         z3eaPkBAho+xKnNPtBzX78V5DpgsGAhIhlPVjCDQdTiQXrwkn6LZlzhbil9b0XKzscZd
         +bBSlg3HQu1O0lLhBcV4q6EBTmANEEdzLaZ35pr41Vh/AsffyyVHddy5E4S/sHUBqg6n
         d3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT/1BJySfUiKHThIAUeXIQ8cdI7/II2weRS7r5RurWGrLDINO1ejK4dnGOKPLqfs3Fv6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeH8S01RuLvyUJxRf4vSDstOWW1Zm+4038PQ+71EU96SmOsf0
	4xnFoyaE+bMFVJT9eyYS/UYRcZPsVvPnTYxbrxc1qmQ/DPCLTtcBOSnP
X-Gm-Gg: ATEYQzzcUJQe0Y1FHjC6Vf8pq+tZsvu4zd6IDxMqp7RafBhMoCQmzEa1DPhwAdnKeaf
	UVj+FYORnPyGJSkAX02d2EPiadsSAaDvxN9+qm4DWD/KuqRXomvIM6tDm+pdd6+BIu+ih4znQ4A
	da8MG/T4SvJTxgJRplpP9SDvn9Ue/+y2NOtfPJHptbIYzb40Oz6mUvOtFCLIOgjJscjLvqRIx01
	tlZnhscprydDdj0cnmt7PetARwuOHERETNGPS3cXasPhsbJ13ILfOSQ7KLYN3Mw01ZdDKjtsemJ
	KqQXGfbWNDI6PC+PazOhPG23LGMGY7x0MlMRzEet9yKj0SX4/QB6Y+qRqUXdISgCqCTKamk/bR5
	cGX1C8lnBrQo/WNxuUHyCQbmmIARS05E+aDH77rG2F7u0yNiOFjyI51Pb8YZ+d301nK6DfDxVlZ
	prlGtb+PuRqD46X3R38inA
X-Received: by 2002:a05:6a20:3c8e:b0:38e:99a0:105b with SMTP id adf61e73a8af0-39bceb7edb0mr2140353637.51.1773996134580;
        Fri, 20 Mar 2026 01:42:14 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a7ff47csm1288665a12.6.2026.03.20.01.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 01:42:14 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: test access to ringbuf position with map pointer
Date: Fri, 20 Mar 2026 16:41:55 +0800
Message-ID: <20260320084155.288417-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the testing to access the bpf_ringbuf with the map pointer.
"consumer_pos" and "producer_pos" is accessed in this testing. We reserve
128 bytes in the ringbuf to test the producer_pos, which should be
"128 + 8", and the "8" is BPF_RINGBUF_HDR_SZ.

It will be helpful if we want to evaluate the usage of the ringbuf in bpf
prog with the consumer and producer position.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/map_ptr_kern.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index efaf622c28dd..c3fa57ec430b 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -647,21 +647,39 @@ static inline int check_devmap_hash(void)
 	return 1;
 }
 
+struct bpf_ringbuf {
+	unsigned long consumer_pos;
+	unsigned long producer_pos;
+} __attribute__((preserve_access_index));
+
 struct bpf_ringbuf_map {
 	struct bpf_map map;
+	struct bpf_ringbuf *rb;
 } __attribute__((preserve_access_index));
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 1 << 10);
 } m_ringbuf SEC(".maps");
 
 static inline int check_ringbuf(void)
 {
 	struct bpf_ringbuf_map *ringbuf = (struct bpf_ringbuf_map *)&m_ringbuf;
 	struct bpf_map *map = (struct bpf_map *)&m_ringbuf;
+	struct bpf_ringbuf *rb;
+	void *ptr;
 
 	VERIFY(check(&ringbuf->map, map, 0, 0, page_size));
 
+	ptr = bpf_ringbuf_reserve(&m_ringbuf, 128, 0);
+	VERIFY(ptr);
+
+	bpf_ringbuf_discard(ptr, 0);
+	rb = ringbuf->rb;
+	VERIFY(rb);
+	VERIFY(rb->consumer_pos == 0);
+	VERIFY(rb->producer_pos == 128 + 8);
+
 	return 1;
 }
 
-- 
2.53.0

