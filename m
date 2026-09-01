Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A51DF75A
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252437; cv=none; b=N3HiZU9aXjnk4VfQRsahfVe73M215PWycdRetsnbw0BLdlCTGoH/G8r3OSH0BGp8AZ1gM1DAZaglM6RoW4uTpm+XSOplJEhIU4KY5w+m1ckmFDUnv1M/Kf3NT1O14j7ugwuDafMF2umgxqo3h7lpIYIt0nzWeKVrte81tRBr4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252437; c=relaxed/simple;
	bh=j5rOCgjCtKS1vvUujbdd9wDavbG3is4YEEheTUZ0k+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOC49g+0CG4P5vfslWL4m81eAtLZSbVb3VvMSCBFurL9bH54AN+sl9umauj1htoniOBnQ5MwiEt4Fc918CjpD1Dsjph3hISIqT4efPLPz/3EJS48jHv7CcZ8SrFfRXmhpaecCzsX/fDXdAOl/bottXrIuKT+l31t3DUo/+TuMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIqfcnAm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNtrebJ5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIqfcnAm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNtrebJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788252434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoT8WR6PoQnvkYiV40nokKAmKoh4Qwr6e81p/Vx95dA=;
	b=EIqfcnAmxv76+xbzLDJ6NZRdBFmTq0SE29dpfwMC8LrWK4frtmhRiPQRN5YSjyFD3Y95wU
	0doRAwoMA+uDnrVNf27xrhLVF/HsJ9BNsP7G3fHGy8L16hnXvA2dt75fhYC28hQDjlO5VW
	Ok3tzfgQxDqLdc8bQ2ZpRmqkjNTSXB0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ncNwc452NRGIraadPHGi1Q-1; Tue, 01 Sept 2026 04:47:13 -0400
X-MC-Unique: ncNwc452NRGIraadPHGi1Q-1
X-Mimecast-MFC-AGG-ID: ncNwc452NRGIraadPHGi1Q_1788252432
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4843227cfcfso426845f8f.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788252432; x=1788857232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yoT8WR6PoQnvkYiV40nokKAmKoh4Qwr6e81p/Vx95dA=;
        b=KNtrebJ5S0DBMj26MwvGGrn2b+u28qtxDfv5GXdC1s1+VR+a5ORzyndxfIjQqvQWV/
         oX2zU0mslzE+JT8fhkND6tv8Yvf6lS3vvW3uPiGhMtBCwQQDAS+YyFYUIrwnre9WNQI6
         9wFT4KhZpJN1cyjnJSexMtQMjMFMPmI0V1Tt6X18obhO0lhVp4wIWxHGxG8vVsZU1m66
         IZkVAqZLM3vMwrGxiMVQI1EwdMsCvcXr8AyUp5d11UGktbjdPWGfYHSIdyBHiaqD/PEg
         C9cWyVSPaMTFmsVFLWWGCTIJ58MbUBIvTVrTbLSOQg+MKJbFJYFtOHGNd5a2nBhaPJtT
         T8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252432; x=1788857232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoT8WR6PoQnvkYiV40nokKAmKoh4Qwr6e81p/Vx95dA=;
        b=iX4gu+M++cfjKK6MFp0iE1jcxIdt33VgdVd7p/sMMclUE9Z11FZ/p9MQzWA6JkY17l
         2ZS8bhPQLcUmsk9vOkpOYXPr7UQkeciFYvOBWkqTgCImiRPkaklme+fi1zImQ0CNM4O2
         yMxLggeH/repHBeAAxT+zJ2HI+ihLCoX7OtxOX3wNTMKj9aX+uVALPtPaGj3CaEsM8Eq
         EKGpZ7pnHPjiLUnUiQCp7E19VoQ0zLs+jCfIEA41z5DEJjcGuOEpGLXTet4eIV1QpRQe
         MAXb3y/DjBaZNmBaZTt5WFZgY+CTm5AfFlROoV1xLLiwuJy9PFbvvFiizk5CuYj8Zc9Q
         ToPw==
X-Gm-Message-State: AFuF++mlqog0RhYi3fb8IfrEo7oXrCDPbpKIRhb4sxQ/9KUx55Legx/j
	tdxzfO5me1aQXRtOasab3yO9zCkeTg6mA1O7Te7FR86YbQKePmmrG8dRuM1kaaLwqR5Szeom+Wg
	opy3ixQ6rZFY0UxscXYuQO/dIn9gZ5Nl+6dEcYFp1t7Em+yekaGqU6g==
X-Gm-Gg: AYBFou3JoGNn45GaRUw2OuBarVxF7XNUWxrVso8BA2hrbI5t68cANzDAcnG4Q4/Ntw9
	nn/zznHPzwLaOsad0W8l5QXpNqTOz4e3KnKvnxAlh64+h6ZPR7oGAWnoYaMjDAqzL26iLw5ogIo
	HQDvgiL+x2yoZR8htsFy1aCEFoDDrsrdzr2Phr7zNbnF6MTe4Jl8IfdWsO6eYAFLSRkYtChrhn0
	I3+ni9lVRPLBj9QUU0c3QqIdYOImwB1jDjYB2enxLKnlKmkrdjc8r3q3nlCEbtRO34zgjPWdpcQ
	4/6GfQfcWxG1DNw/3/6NwA78cPJTVchWUdMKui6D2S3L9AuuhVc1IsW4Ffrdtgx6eR64S6M5D1G
	0yWz/4zf0HZaNQEEAuKdAxRqm
X-Received: by 2002:a05:6000:4549:b0:484:4768:feab with SMTP id ffacd0b85a97d-4844768fedamr363575f8f.13.1788252432171;
        Tue, 01 Sep 2026 01:47:12 -0700 (PDT)
X-Received: by 2002:a05:6000:4549:b0:484:4768:feab with SMTP id ffacd0b85a97d-4844768fedamr363473f8f.13.1788252431552;
        Tue, 01 Sep 2026 01:47:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442c425cesm3697842f8f.6.2026.09.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:47:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 939A197C522; Tue, 01 Sep 2026 10:47:07 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 01 Sep 2026 10:46:55 +0200
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Set BPF program flags
 non-destructively
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260901-libbpf-frags-flags-v3-2-4eb6f14968b0@redhat.com>
References: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
In-Reply-To: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.15.2

A couple of the BPF selftests would set the program flags without
looking at the existing program flags, overriding any other flag values.
To avoid issues when we change libbpf to carry section flags in
prog_flags, change this to always set the flag value non-destructively
by OR'ing it with the existing flags.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c      | 6 ++++--
 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c      | 4 ++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c              | 2 +-
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index e8c1a619e330..7dadb90e7b68 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -543,8 +543,10 @@ static void test_kprobe_sleepable(void)
 		return;
 
 	/* sleepable kprobe test case needs flags set before loading */
-	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
-		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
+	if (!ASSERT_OK(bpf_program__set_flags(
+			       skel->progs.handle_kprobe_sleepable,
+			       bpf_program__flags(skel->progs.handle_kprobe_sleepable) | BPF_F_SLEEPABLE),
+		       "kprobe_sleepable_flags"))
 		goto cleanup;
 
 	if (!ASSERT_OK(test_attach_kprobe_sleepable__load(skel),
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 73f669014b69..652307a1b22e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -35,7 +35,7 @@ static int check_load(const char *file, enum bpf_prog_type type)
 	}
 
 	bpf_program__set_type(prog, type);
-	bpf_program__set_flags(prog, testing_prog_flags());
+	bpf_program__set_flags(prog, bpf_program__flags(prog) | testing_prog_flags());
 	bpf_program__set_log_level(prog, 4 | extra_prog_load_log_flags);
 
 	err = bpf_object__load(obj);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 2e0ddef77ba5..ed3fd0a88dab 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -362,7 +362,7 @@ static void test_attach_api_fails(void)
 	sl_skel->bss->user_ptr = sl_skel;
 
 	err = bpf_program__set_flags(sl_skel->progs.handle_kprobe_multi_sleepable,
-				     BPF_F_SLEEPABLE);
+				     bpf_program__flags(sl_skel->progs.handle_kprobe_multi_sleepable) | BPF_F_SLEEPABLE);
 	if (!ASSERT_OK(err, "sleep_skel_set_flags"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..047dfdc322a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -408,14 +408,14 @@ void test_xdp_metadata(void)
 
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, rx_ifindex);
-	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);
 
 	/* Make sure we can load a dev-bound program that performs
 	 * XDP_REDIRECT into a devmap.
 	 */
 	new_prog = bpf_object__find_program_by_name(bpf_obj->obj, "redirect");
 	bpf_program__set_ifindex(new_prog, rx_ifindex);
-	bpf_program__set_flags(new_prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__set_flags(new_prog, bpf_program__flags(new_prog) | BPF_F_XDP_DEV_BOUND_ONLY);
 
 	if (!ASSERT_OK(xdp_metadata__load(bpf_obj), "load skeleton"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6db3b5555a22..c5501b3fdf48 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -845,7 +845,7 @@ int main(int argc, char *argv[])
 
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, ifindex);
-	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);
 
 	printf("load bpf program...\n");
 	ret = xdp_hw_metadata__load(bpf_obj);

-- 
2.55.0

