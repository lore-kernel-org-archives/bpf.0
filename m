Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596A417340
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182834; cv=none; b=RzZi8g/bXy48d7Fki4Su2KPNHSvC486DyqKPdhjp6lmDEsqw7oiPjLUo/7LXJMvnuG0uhVT8nyTrRGei6mGGHkib0yJKAdCAmAeUExnD5/D4caevHxguWyYqiygWrEuEvhJlZgZXrYDjbyloox+LmNRI6RAnG1oSepQpwPtLdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182834; c=relaxed/simple;
	bh=OIbi3ceGQZ/QjbSWzXjim1yzwnJvjTsZFCloIxWPYhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqjEXR3Cf+TdsefqHAlO/IH6shBOYyfv+aqFP3Sh/qb1RvbKaunC49ms1DFMuLOY1xZlApnphSciIMrvKB5gLG+5tP3VuQJbNj8MzjUQGxMQ4sYUKdb14dtbx60CNash9jnPkMZgonXrOSDzwcmPkTksRcrOCFwF1xOi7xz7lHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTz4jJWt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8wZwrTj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTz4jJWt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8wZwrTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788182831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KvrdHLkoHirj2epQVtvhrFYMOrEgGC1u8Odq3InD4Y=;
	b=LTz4jJWtcNYHxE000Ic09Jvk4lIuX0gOhEfkXjN0uWcVvidOx5tcGNxu9IYRfK0iLYCAwp
	+p8Yn55PFdqmd9Jtd2uFzNpTipa3/jJ7GzJJo4Gs29gjFTge8Gw8mxQg+mGBoMzmQBjPIh
	Zg2u7T8Q5GBvVz3yT0RefduI0XqP6RA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-HNr6zCSOMw-uMAOyg79I8A-1; Mon, 31 Aug 2026 09:27:09 -0400
X-MC-Unique: HNr6zCSOMw-uMAOyg79I8A-1
X-Mimecast-MFC-AGG-ID: HNr6zCSOMw-uMAOyg79I8A_1788182828
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4997b060af8so20829965e9.1
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788182828; x=1788787628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KvrdHLkoHirj2epQVtvhrFYMOrEgGC1u8Odq3InD4Y=;
        b=F8wZwrTj27r+Mb0/4H6deu6DbomZBPp+TcSOR4ho2WMnN53Egrs99YJ+fAfo9sWx9/
         I0xeqGW2ZKQCeRFpLHdHwqga0jyD9YrenSRfADRKRJbAo4ahy+izdZfxntXFmObrpR7F
         khOl5VP9MTwmhGMNF8UaI8Wv9dfgl/AM8uwz+0OKdRbVlHkW/Cr0CPoyJqeKYXyG2LcD
         mKG9rmEwyOaAOPFpyyS7ka1eOMniRvGneO3NTJuC7c2jDJTN/0QKNCkUvG6zvPfmuH+N
         HcM1qdrQMGmQ+hlVU2rQ/u56DCi7w1WbdiPQA8boW94wtU3dZQJioxTAxT0OeTosoPB/
         6L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788182828; x=1788787628;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KvrdHLkoHirj2epQVtvhrFYMOrEgGC1u8Odq3InD4Y=;
        b=cvU6G4h52xW3E1HNLlcxL4UySnkaCzY6tm6V7BOyTaqowUF24w0WpaL80fmmhO9wrW
         2W+To3Ymn6gxT9/syDEklcfEi6qpmWLnvSTYiCtYbLPuvXd71/M8eUtdSgdsIkwuNBAa
         HaK1OPLUUTCIeMD1zocGJLNI18rY6jmbscASJOdubHswBlIIQArKQjjnmQGBoMWOnt1n
         UAOmJDoGPNEmjOjQY4t8je2v1YpLENieKFg3K6x4k2yYTWH03fcjn6wpPzJz2zOpRnPs
         M4q3jtKZPCnbakupgEJ6kBpECpCZRYoVpOSAKWugidwixjPhMjxH3yiU/nyMECUTFbYU
         NCsg==
X-Forwarded-Encrypted: i=1; AKwUvBy7uATh6KRclw0IedYI+HNQeRaG1/yJi4Q7+LOt/yys/niVEkQlj4F/lPqcNsHO/1J7UT8=@vger.kernel.org
X-Gm-Message-State: AFuF++nLFSBN2xtInPN6Y/4q67l9EG52Maf8F9hukrh1bd2mIrh90I9X
	qxbMtR+YuKq8kbb8TCorjbzZDys1FEHYWEbDnNuRpfjojiE70bKUiE/Cqhrj9znXXSa1q+19OTI
	p9FTJYto52RXzUHpjKaN19hbzdLOfrawrVwlHUkgedlhaxnZpBrrRnQ==
X-Gm-Gg: AYBFou2j8IcMKVcuHjB2ZedSk5O/poGAqTxtKWncY2+cOFq8/haQPZr4uO8RWTOjzLS
	RjTEupaoXXcAGOtDcBdXZe2PH9NbHbl3m4/vFEsn4xZczdfwg5VRBc7wTJQxCVddNQnhsdZRPX4
	SMy5UuqGycFCuV3FEMHbNF8UXHyBzlbN9N2RA+4sNQzjoropotoF8eywta1svowQgUWIbNU1E/o
	PUuSEre/Uo0OeGuhCeuVNkpr7fil7NwehKtooc7DdStj+fIx24ll+KjWEEybortU45co4Ux9GSm
	dPCVqecIY6akX35cwcWfPXwPZlz0wiakaC0zWMnTTDSYK21A2bm3P+xTZFnZJbNtvsXKsr0Rsil
	501s0aInZUlghuY0v2PPphMQ1
X-Received: by 2002:a05:6000:2288:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-482f79c9511mr39217373f8f.11.1788182827935;
        Mon, 31 Aug 2026 06:27:07 -0700 (PDT)
X-Received: by 2002:a05:6000:2288:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-482f79c9511mr39217230f8f.11.1788182827310;
        Mon, 31 Aug 2026 06:27:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb32d30sm23633940f8f.34.2026.08.31.06.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:27:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 385CF97C44E; Mon, 31 Aug 2026 15:27:06 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 2/4] bpf: selftests: Check for flag presence in bpf_program__flags()
Date: Mon, 31 Aug 2026 15:26:42 +0200
Message-ID: <20260831132648.65843-2-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831132648.65843-1-toke@redhat.com>
References: <20260831132648.65843-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a check that the BPF_F_XDP_HAS_FRAGS and BPF_F_SLEEPABLE flags show
up in bpf_program__flags() when opening a BPF program with the flag
definitions in their section definitions.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/kernel_flag.c       | 3 +++
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c  | 3 +++
 tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
index 97b00c7efe94..25eb59f460ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
+++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
@@ -16,6 +16,9 @@ void test_kernel_flag(void)
 	if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
 		return;
 
+	ASSERT_EQ(bpf_program__flags(lsm_skel->progs.bpf) & BPF_F_SLEEPABLE,
+		  BPF_F_SLEEPABLE, "sleepable in program flags");
+
 	lsm_skel->bss->monitored_tid = sys_gettid();
 
 	ret = test_kernel_flag__attach(lsm_skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
index fce203640f8c..a894b1ab46f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
@@ -18,6 +18,9 @@ static void test_xdp_update_frags(void)
 		return;
 
 	prog = bpf_object__next_program(obj, NULL);
+	ASSERT_EQ(bpf_program__flags(prog) & BPF_F_XDP_HAS_FRAGS,
+		  BPF_F_XDP_HAS_FRAGS, "frags in program flags");
+
 	if (bpf_object__load(obj))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index a8ab05216c38..dff6b3e7266e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -146,6 +146,11 @@ static void test_xdp_with_devmap_frags_helpers(void)
 	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
 		return;
 
+	ASSERT_EQ(bpf_program__flags(skel->progs.xdp_dummy_dm_frags) & BPF_F_XDP_HAS_FRAGS,
+		  BPF_F_XDP_HAS_FRAGS, "frags in program flags");
+	ASSERT_EQ(bpf_program__flags(skel->progs.xdp_dummy_dm) & BPF_F_XDP_HAS_FRAGS,
+		  0, "frags not in program flags");
+
 	dm_fd_frags = bpf_program__fd(skel->progs.xdp_dummy_dm_frags);
 	map_fd = bpf_map__fd(skel->maps.dm_ports);
 	err = bpf_prog_get_info_by_fd(dm_fd_frags, &info, &len);
-- 
2.55.0

