Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78847252A
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252436; cv=none; b=S3a06LacgCtqTVrTxOw9rWSUz7R0b/xcvI4fENbUHiXXy5+AzjpgGhjmOZSUZF71KmUJm2ZrLR6GvxKw7oCS2SnYV77DHKauwK9MX4piCHQax4HiG4qJuBML5qg59ec+/bneXosEFIxjA02T7UtnCcvoucqGYGcu6NtOvJFhCs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252436; c=relaxed/simple;
	bh=z+HW7I7NkDUsO+hibEZGkJxXKtnblCu3cM9QUeCPUcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6VLTWH7cxf3JshRBMmAqRZITYG/sBjqjR7pmZYOxa1O1/HuXIbsEPbrXlKs/jJRCXuX+pfFsRMuKvs1BHBgcv0kwnay2B5lWdBJTg+mCnfpzF/yRDlDa0P4UAmq3oe9gFzbjBp63MbTw4+jfL6StNXm7WQoyiDljBDH/mmZzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rvf/ff5M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VN4UTBoa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rvf/ff5M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VN4UTBoa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788252433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAdkCBuzlLqn89B3vmC+7D1QnoijlhTFA1izqYqLDeA=;
	b=Rvf/ff5M8zDWaUVXQSHKXoga2axc/idWvLG9dJ1slyJj7vFHYlGUvjDd3PZBjOx55esia7
	3Sf2R0gw/CYRoiUx80xVEr+tvcqt0lLLrXbf1cPbcE/BKsSUrUbIaVeXqjCqfvZfAbGaJR
	vl84VJPgjzV2stEAqwwjBH7XKfJW7Zg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-vBgWb_rWPmWkA6Wmmw1NTA-1; Tue, 01 Sept 2026 04:47:12 -0400
X-MC-Unique: vBgWb_rWPmWkA6Wmmw1NTA-1
X-Mimecast-MFC-AGG-ID: vBgWb_rWPmWkA6Wmmw1NTA_1788252431
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4957287363bso29930085e9.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788252431; x=1788857231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JAdkCBuzlLqn89B3vmC+7D1QnoijlhTFA1izqYqLDeA=;
        b=VN4UTBoa7Sz5d2bWyUnqcXEuOjNlQdwUbdWIon7/HQ/QCyh9dvwn7RtrVSMiH1JlKO
         IR7Ou5C/pO+zLv5ojCfZeu6iuWA5DNsOA4gBI5xeKMCuIm/xexmY9x2hnltEJwroF0i6
         NsLgqwuqlpfXw77aqv17jyrBDCay3Tp2IPqN/qA4FyTN43jhP5QFQFQYjZVV5J54aFNO
         oErZQmCG2Hza3gmLRWLI05GHrg5Qu4ZlnPpwFglsU61lMHhvrjAArB928Eqg12Nvl3CD
         CaYlAt0wLzP4GHqsaYC/9GXkRhQq/Pf8mBV5aOONog7iFsz9VO1lNp9lsUH5jW4Pm751
         LBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252431; x=1788857231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAdkCBuzlLqn89B3vmC+7D1QnoijlhTFA1izqYqLDeA=;
        b=DRoUepKEtR3VVLkII4T41zSpEoTtQHy0AfOoSwn0Hv+pTFRogeWn8C14bvMq7hPhEx
         IXtolFpE2vkWIWqxP9ERxzms0FGdlr0kTWZ1Y9Px1FWWWDpBDYlqEcxaHy9rTVfv8iD0
         oC4mE9IQOMdJh6SiMivSn8+lQGq4+kD4RRb1ymVLD1c9orLFABIqOlc2aekvP/sOwGzp
         yFGwXIcnw0OoFPwMefeRB57jPBOnMW83nXwMC4YX5e5VUAaR2XEeBZP4N1kGRmA83r6G
         2/FcIZreunwLrwUNDg2HjRE4a5lCVgHc94FLyHF8xAwWhPMA5xhnPTr3NcLKs0CfRZ6+
         uwYw==
X-Gm-Message-State: AFuF++nwlW+3tFWu5PvUkAvNN1cRh/iScEXxU1kRLY4V/rIgmXLHYEmk
	BWdyhOEAvxxkQgeBZ6Vg8qcHs39WYgF/YabhhcSUbzEJvNBgZFErB4PMJfRdkkrE61FSyVwekd+
	zBx58HyirjPGaGc4cxus4FwE270lmQDWh08h+AsAqL406t6Tpc1WhNg==
X-Gm-Gg: AR+sD13jemI5RZh5M1mESB0tIum1UpXhz4fLX8TuIhzgX6hVK9N8DvIKZUbJGZ4tQnS
	uTGP/AwVqJgdkZyGv3oubJDsjhpcAIevLsMmTNK6RbfAhL65DvDM3fSMnEIGNVj9PRU6ELVNVCE
	y8/cWfkQ39+WU2rrkLRUQmN6K5L2bbJ5hDdWYgpdcTrRSYuWhgsKEYEn9x0zIPF6c/2tF/lUJ8o
	7Rysx0bYFw1vPsTfCSdNb5+DQCrJhc0QyrvrPbq8hVRciguxTAuWfJ41ihTtxrBEPDNhg7fRhfU
	+nbngQkWxxeU42jAYNK15IR06uJpVXcxr6aojKE9X5ptfVx7aVc8Jv3Qp1SNSn4zp2X4XLl9rSS
	uAvjFEzvai7ORV0ImEhbYI9sq
X-Received: by 2002:a05:600c:a03:b0:499:93b3:91ea with SMTP id 5b1f17b1804b1-49b91c5096dmr474880105e9.15.1788252431001;
        Tue, 01 Sep 2026 01:47:11 -0700 (PDT)
X-Received: by 2002:a05:600c:a03:b0:499:93b3:91ea with SMTP id 5b1f17b1804b1-49b91c5096dmr474879395e9.15.1788252430563;
        Tue, 01 Sep 2026 01:47:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10153sm57066485e9.4.2026.09.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:47:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9EEE097C526; Tue, 01 Sep 2026 10:47:07 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 01 Sep 2026 10:46:57 +0200
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Check for flag presence in
 bpf_program__flags()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260901-libbpf-frags-flags-v3-4-4eb6f14968b0@redhat.com>
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

