Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561C35AC3E
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203279; cv=none; b=mNo++hLcRCZ5IODQQJWsf7sR4jjkuhmFJFh37VS5c+xk5TfMcwS/JTg8SKaCCVza/08kIPnfqLJ6Ft4rn0qnBI4CqDIgBlQ+eaDCHZbezvdFxwUKVH4mFF3AmB5uWzLP14gQpvCQ7lMA8lAofs/vMpWRbufTTTGf1kGZfA1g0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203279; c=relaxed/simple;
	bh=kA4O/akdo2tw2RMDpn/eCUheGJVrbEaLFgeSEjZTLkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYHLTvfz2qXnt/8n3d7tKoEegK4HIj0CyMIsPyG9d7Ne67Q9YJLmfyTxtxWGc174dl7Avg38AhjT+EMt9UFrJ6UiJuyhTCT34fs4ytg7bPOfMOE6KK+or/2gQoVXMnA3FpmJF7YQ42R37JClmQmjR1zhOLgRZaNjZI16qzmFmRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnfB3v1k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1wO1xiD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnfB3v1k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1wO1xiD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789203276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UVqrsRLM86Ysp8trDXvwZjNx2dQs8WYUeTmxIXTCoc=;
	b=JnfB3v1kjKJ1nXbu+aN5zQoEnVxSZOaU/eoBjDbab/gpXg6vezRcdCdILsaN922TPkqCSb
	XQhpMVheMzJ94letdRH4cwoad3Y8j0z9DcwBB2i8FbzCqiYTzGbpfo/O08ReK4pK+c6MvH
	Uo3bo8krlz/vX5S4x5TyIdHPR/3Daho=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-friWw5b8PmS2m3fusKkB1w-1; Sat, 12 Sep 2026 04:54:34 -0400
X-MC-Unique: friWw5b8PmS2m3fusKkB1w-1
X-Mimecast-MFC-AGG-ID: friWw5b8PmS2m3fusKkB1w_1789203273
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48597bbd963so1304608f8f.2
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789203273; x=1789808073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9UVqrsRLM86Ysp8trDXvwZjNx2dQs8WYUeTmxIXTCoc=;
        b=F1wO1xiDnQr9kwMDZSwlrwqLJCRfTQEyo28jdza67E18az2qPmkHlYBXn+i30uK+D5
         AhFtI/nUZC076agaeLSq/+DdeykxwQuCIszJpkErrMrgAbbW/UH0bcHEz3MSntKM9Taw
         NjFNcu+it7qHAeCuyUQ7+jwRJQygnSqnvFrrTb0NSBbKF7xplovLIPHahwMB0JJKgPSO
         8XKP21BkV0e1gWPocrTOH/uAA8JfD+lsdcf7/oWh0fac9hp3cVV7FZYaeluGs+crXPUk
         AnDCoBfr1c035m1SRD6yUpHyOgQT/+pFv0UDEFQAg5BxFJBzQwDdjdag0qHhnEaexUUK
         ZCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203273; x=1789808073;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UVqrsRLM86Ysp8trDXvwZjNx2dQs8WYUeTmxIXTCoc=;
        b=suABDjzWHu1u0w0AX/MbtIYPNgeVCCz+Y5bvGiEkcBgtDqtbv0TmjddR2inRPf90He
         enhhxDnGr83cGjVpJ3z7oJHoDTXlAXlgoXCb1n5GBXnGo4CEJWJ/7aiITJcpK+3xGi/g
         QDjCc8LEd5HCKytPr834NIyvI21bZOE4C+3qVsazvMsFpJfHA6a3hwTTt+V71hsUWn3U
         N6wSA/nem1rbsGd+6aZPB5J4F03TPqFwUmTYStbHumikzD1oN55uyPRERi+zZSsRB/+a
         y1YYnfpfXq3dj4pe2gSdBkyDGdIkgaDukfdpIIA1b1BgBokoh2+POeKIjUeFPSGhpock
         yusw==
X-Forwarded-Encrypted: i=1; AKwUvByngzUJc/mXnj6OC4aRM8HG4NNaqHl2ICyfR/Rf/zHcwaRVZoARGgwuJZKb/He/mjF6Tck=@vger.kernel.org
X-Gm-Message-State: AFuF++nf9NA4N4P0KH+HWQZk5VFPeqZetdwk/Cao6Nk3YF5SvP8p+zLZ
	9Z2TmICGs/bLuVFZ1wHiY+e7dOs6WK9TXUPxd5kVTdKpVJmka2xQSHihl/G1z2ropXM3qDwY8w+
	kWUaAe9VgWOo23k0XMPmiInMKxcxG9nJeMvRiYSkgvu0hiGia8/5FNw==
X-Gm-Gg: AYBFou3cBpq+rxN4RcpVh+bmtdZHUi54vUGbPKsRRJrTMiX/iR1TESbAwWXfwrNkw3O
	UWFRQ4q7YVB/aLzoL8LpcSNW/2wOJi+RQU8zTacnW/HyLxb6yAutI32uaVIh5M3bxiiyXNHVhh0
	h6znaa9mdpfLAWdMjQdPsm/B0K8qfdYUyMyasvugaBgRnODqCkHcyH0IweQoM0D4yignJ9Is74g
	4SVP4MdKV5J2gF1a/ZBcLYSgow4ecarqehlm+B0cptecEAJrs4mxzAtQyXEns60uLqDQ6HSdA9J
	opa5Y+hDkb2THYUT8b1478P5UQ/j0ibYAGej4BC+pDlVqxlSmGv5/vuOBqvDRTQICz3CREMN30k
	sjd4JSPwPIAH/0haYL7GzBH8cvYs=
X-Received: by 2002:a05:6000:184d:b0:486:f17d:14dc with SMTP id ffacd0b85a97d-486f17d15eemr17190963f8f.12.1789203273490;
        Sat, 12 Sep 2026 01:54:33 -0700 (PDT)
X-Received: by 2002:a05:6000:184d:b0:486:f17d:14dc with SMTP id ffacd0b85a97d-486f17d15eemr17190924f8f.12.1789203273159;
        Sat, 12 Sep 2026 01:54:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33e020sm12029348f8f.18.2026.09.12.01.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:54:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BF2369B9AB9; Sat, 12 Sep 2026 10:54:31 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Add assertions for bpf_program__{add,clear}_flags()
Date: Sat, 12 Sep 2026 10:41:01 +0200
Message-ID: <20260912084109.432834-2-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912084109.432834-1-toke@redhat.com>
References: <20260912084109.432834-1-toke@redhat.com>
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
 .../selftests/bpf/prog_tests/kernel_flag.c    | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
index 25eb59f460ab..c723c9fbfbcb 100644
--- a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
+++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
@@ -10,15 +10,32 @@ void test_kernel_flag(void)
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
+	if (!ASSERT_OK(ret, "test_kernel_flag__load"))
+		goto close_prog;
+
 	lsm_skel->bss->monitored_tid = sys_gettid();
 
 	ret = test_kernel_flag__attach(lsm_skel);
-- 
2.55.0

