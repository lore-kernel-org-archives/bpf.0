Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22EE481AB5
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065164; cv=none; b=nUdbQxPe6m94HnPYtIhz4Yx5ekTv9BITMTtCP2MwwmH4PebJdZRThrgC2ss33WHI/0RyBpjXrUkYhKYVX/T5YJOKOE32v6YXX9Y0oJGuNYA1ncnpxue91nMTCeY/PByDEvyHR1/hObvD9zzwYoUBjgcZDsQAsrLhFS2J+z66ysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065164; c=relaxed/simple;
	bh=cMp1VsdsQz0vNzbyhkcNws9a4oOwysOG1eRkdE4uSO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ru6A4R4b78Gya05U8cZ3nD1gjpxcrNWru7tVf44xc4SmSbtXywqHyVk6wlUjqgSt8GySTs6h1w+SuYlpsvm8k9SiE4N92vm8NLKNft/xlCE+Qd6Z8fZ1FCyJcRuENrlReF0Ffdkndenf6DV49AHI1Tyvu+xESGX7otVWWXzG5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aiHeOeG7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4w3edFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiHeOeG7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4w3edFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789065153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqYNqU4lqML3fRZSRPStdgLh7sIE0K4n+xpeBZSASYI=;
	b=aiHeOeG7V7z2AfNUaDP/+GVzMoqM8FfKb2TJDLa7FYn+42alW7Zj+b6j2Cbn1v8xn+BA3q
	NEkGXDqcBhjY1IoFMw4c7tPaWi7DkPwKs4higLNk/sEvouAdDfwZkumWmlNdDNJ5JGid4h
	qABg/VA17l5hbeQKJsCDwjuXqoNfEgs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-OjzTi6_cOhuonb1A9Fl2UA-1; Thu, 10 Sep 2026 14:32:31 -0400
X-MC-Unique: OjzTi6_cOhuonb1A9Fl2UA-1
X-Mimecast-MFC-AGG-ID: OjzTi6_cOhuonb1A9Fl2UA_1789065150
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4843d9ab895so52156f8f.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789065150; x=1789669950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZqYNqU4lqML3fRZSRPStdgLh7sIE0K4n+xpeBZSASYI=;
        b=Z4w3edFbquyYygtYo/+H2UgPknhORVX4+7mRBYA1pFA4Aul0n7vxo358oR4jKndHJi
         gbt8kzn8LI0w1YLcdc9Kxy9hjme9RCulxKSNAcnbJ19Zr2gzwbjSDnuy15Bgp6swHn/R
         cN84/91NZ0f0vbPyknyVe09hi3JntFf4BhQN/T5ZQV/UF2LclfICuW95ZjK5IXrVrAd5
         7A2c6QCD8nQR5zb+B1h5/fFQG2Aubk2mLEzzwOkcMM4+gVx7j0xrGAUmiLfDTjRjZ9qJ
         0Uia0+U0wtynYC3xjTBZ0Bo9ZEIqP9nNta1+UebJS0YtOXyigxl+skwEZtBw0ge0tAKB
         UBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065150; x=1789669950;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqYNqU4lqML3fRZSRPStdgLh7sIE0K4n+xpeBZSASYI=;
        b=ETiNNiqvhCgc2iNAysspYyeb0uK0WqBJXDYgwCjKM4v9eXX4S5If7tMi1al68Ifnf7
         +DR11di+dOmgUvzvK+gC9VYdBds9eML8eKcSNpzsrQ0ngE6vjI1QQzjVivIjqPDDBIU1
         kYq+eObZ38fGw5imuAA/tzKqtMLtD+cdCsOU1e3WFsWF6w6Ou2FKueK+9xRVp1LrgCZp
         4oXUYjNUjNh807eK8q5aAt/9JYVrSNBv7V8T/sp5jqG27FwVcikzuaEIPZLq4AcEqiog
         mGM3SWV3znJ+VmuYGACpEVda20t863CmdpwY1Tj5hOV7zfI9VL1PHgQ993Hq0vawyg6j
         bTqw==
X-Forwarded-Encrypted: i=1; AKwUvBzg03F+qKaZD+i1ndKySWrZzKKOs3a8WhiODLw6+buZxN8/SkFj7B1mN4L/XyOQ526vqOw=@vger.kernel.org
X-Gm-Message-State: AFuF++m1nJFAsOQoJQiRWuTFXbNCJLGnK3MypCfJ6KjSMoVZEI21epmF
	O7zT2DW5dgtVKjtJfsKoDSNgDVfP+f7oXiLKttndVPtGJU3UQgV3Zd75oyqdOemipLMK3wdQ1cN
	7sLgvtT/W4fCOmBscGQduPeHdFPculcJmRIGegSuAPWAlAAVMOQsNPg==
X-Gm-Gg: AYBFou0Taua+SEmtMZXYApt1n8TIjevybdWn/CpVGg0DddSYGdos1Z2TcaBlzYlhnju
	tRQJngK3hTsBiu7CShkDXEigLvAuMy0vcD0wwQzIEmR4u+bbnr80aOehwc+6i4q1IlHSmUjXCL4
	N1nXqDnwaVelxNJfWF17qyRHnVkV91X6q3A23RQo81BsvrSBVis4y3MAIIKjZL/2i1u/VR2wYnd
	E04E94cpF3mXeMzeKsfueBjqSMMOJPV42zcTAJLaK24KlL8oVTxSpqmwh/5SBwb3FKZPfcRUf0Q
	3eHPzV4rWujevQ6iXqV5IfioOxL+wb1AGi3C3aHNhx4V7n1WcVq1HBuswi1M4emv+KDoZ3YG0mb
	pFl8i2oPzfHuT0ek3ny/7mI4CH70=
X-Received: by 2002:a05:6000:118b:b0:485:8c16:5ef0 with SMTP id ffacd0b85a97d-486eb2fe6e9mr228482f8f.42.1789065150439;
        Thu, 10 Sep 2026 11:32:30 -0700 (PDT)
X-Received: by 2002:a05:6000:118b:b0:485:8c16:5ef0 with SMTP id ffacd0b85a97d-486eb2fe6e9mr228459f8f.42.1789065150104;
        Thu, 10 Sep 2026 11:32:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee8bsm270102f8f.15.2026.09.10.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:32:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8A4759B97EC; Thu, 10 Sep 2026 20:32:28 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Add assertions for bpf_program__{add,clear}_flags()
Date: Thu, 10 Sep 2026 20:32:15 +0200
Message-ID: <20260910183222.307208-2-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910183222.307208-1-toke@redhat.com>
References: <20260910183222.307208-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add assertions that round-tripping through bpf_program__add_flags() and
bpf_program__clear_flags() ends up with the original flags value.
Arbitrarily add these to the kernel_flag test prog since that's where
we're already checking for the bpf_program__flags() value (and the test
name contains "flag").

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../selftests/bpf/prog_tests/kernel_flag.c    | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
index 25eb59f460ab..72c0ef8da409 100644
--- a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
+++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
@@ -10,15 +10,31 @@ void test_kernel_flag(void)
 	struct test_kernel_flag *lsm_skel;
 	struct kfunc_call_test *skel = NULL;
 	struct kfunc_call_test_lskel *lskel = NULL;
+	struct bpf_program *prog;
+	__u32 flags;
 	int ret;
 
-	lsm_skel = test_kernel_flag__open_and_load();
+	lsm_skel = test_kernel_flag__open();
 	if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
 		return;
 
-	ASSERT_EQ(bpf_program__flags(lsm_skel->progs.bpf) & BPF_F_SLEEPABLE,
+	prog = lsm_skel->progs.bpf;
+	flags = bpf_program__flags(prog);
+	ASSERT_EQ(flags & BPF_F_SLEEPABLE,
 		  BPF_F_SLEEPABLE, "sleepable in program flags");
 
+	ret = bpf_program__add_flags(prog, BPF_F_ANY_ALIGNMENT);
+	ASSERT_OK(ret, "bpf_program__add_flags ret");
+	ASSERT_EQ(bpf_program__flags(prog), flags | BPF_F_ANY_ALIGNMENT,
+		  "bpf_program__add_flags value");
+
+	ret = bpf_program__clear_flags(prog, BPF_F_ANY_ALIGNMENT);
+	ASSERT_OK(ret, "bpf_program__clear_flags ret");
+	ASSERT_EQ(bpf_program__flags(prog), flags, "bpf_program__clear_flags value");
+
+	ret = test_kernel_flag__load(lsm_skel);
+	ASSERT_OK(ret, "test_kernel_flag__load");
+
 	lsm_skel->bss->monitored_tid = sys_gettid();
 
 	ret = test_kernel_flag__attach(lsm_skel);
-- 
2.55.0

