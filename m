Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C8385521
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065166; cv=none; b=VFJEBqScIEXumSJxdt50/hIDlZ9tWMB/qKG9Dzw0fYZ1GwldG6Jqbz0vfjsVb3egcKM2fj/5HyHgX1NaVwIrppwe0eN1MRINL6c6M9L06JdbY2KfmN512qEcUCcUJ1CD0RhC2p0iLP6v8ViSRuW8Zgv+nNRBQX1oQDVKTRSn1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065166; c=relaxed/simple;
	bh=PI7uGsrqYBml1yQ62BeBmR0W34Xd1twYSjkMHlzDzmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zr+RneGpNsjAmOeQ6X19jMc6LBbAanBqbMoway5ekzhUSz4mWY2mATjYAbl7nCllHDmdtw4A/4+Xi1n8O9glSeYOEMmjP+b8rtyMqcdmYD8RWG3P4gDF4UM2xN5eA1J5v2EWIp9s5/Y6BNU30jWDeIkBdV9RWXnvXPSwmba2s54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hh6J2uS1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WH73my5T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hh6J2uS1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH73my5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789065157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpWhO6z/1eXUTTgA/H9eXGVtX0eq8vp4A6ySs0zyK0c=;
	b=Hh6J2uS1mOxfbmRIfVd5DpEJ8fGY3vmiJiJGuH6cBPsvSlj5OKzrARtT1zvkBOXjr0ZsKF
	9aXVq7aeuRtDe2WIhiCFPCpak7WsljieNgzILwD6TbjWmIBb54PD51KWr0xteTAqXDqIRX
	V1nL4z5FZhKM6hnyFEPf9CJzjWT8R+A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-epSH8UZQMhKUgpVdNbEC9g-1; Thu, 10 Sep 2026 14:32:34 -0400
X-MC-Unique: epSH8UZQMhKUgpVdNbEC9g-1
X-Mimecast-MFC-AGG-ID: epSH8UZQMhKUgpVdNbEC9g_1789065153
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-499b99a8a10so10188115e9.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789065153; x=1789669953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dpWhO6z/1eXUTTgA/H9eXGVtX0eq8vp4A6ySs0zyK0c=;
        b=WH73my5TrNFumBPYszXMFqj3qQE+a/7rwiHVfWW7WHa0IoW7FiLdmmEhClKjvgGYJf
         05Jvomo3PPUqqqSPMLISQmHvm3NcgsBzYHj+XkXSA4OdXPVP9un7J8T9sGbEuLHVTEqP
         5Iavtb32JgHcuIHYIb0n1w+xVtAFG/2lsAntmhm/E0xrZiRqawtXNAhQybXTXtF9K/t5
         26jg1exri47xvolKXV5FUPeFhsL1qaslF6LIgh1PoKmp/AZwQOsgEedvGE+ULxaCz7ve
         pYSbw4n14M1Hmb7mbSzshpu3RMghN8bt/nmWPX0kC6YS3q2h7T9EMQMjYMWeGYM6BVKT
         kh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065153; x=1789669953;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpWhO6z/1eXUTTgA/H9eXGVtX0eq8vp4A6ySs0zyK0c=;
        b=eg1a4rdszFn2H5ZkyW9/l1fUiZQ6eeiH8tQeO/5oJdOfoFBLTDJ68ddOUTf+LsnZPY
         qBmOiEx0X6HEgHQzVFdElt1fPIrADeKk1bI2r9Nzjz/7VJdB2CtWrXSLw3jRd/ylTB/K
         SlkAEMiAShWljd0sDwQZkdNM4ODUSLBnAa1vquR4tDFQJ1K8N4UNIv7//+L0+UxN16OB
         JaJzsZPvDD0NJbPVIyB8U5XMWSDVSStdpo46APsQFheZqS2rW0hYlfY29X2GfVdkK5qv
         7I8S+jGjLH2aJ84OD2Rb0hIlLNKze8QSkq/YRegRWqJxGgfhJxtj19MT+lsZWBnIxju7
         JfTA==
X-Forwarded-Encrypted: i=1; AKwUvBzoODjq/6PVQlqE6cJtkPYq82DUzYIDZONNPyfo0JXy3G/75hKdEs9bZDo+IwhGTt83gcg=@vger.kernel.org
X-Gm-Message-State: AFuF++ly2XWWvFOCV21qTRvQl+GRqTVKQ5y8LUy2SbbRBw+gCmxce0EJ
	OcMUrsVZipp8JLGiLz9jYV/McChieZ2kl5gbo5fglopC1SlZ78E6Z3LQxsLloE8elMuLfZ4s2VB
	2c3ct1j4uv7KLbg2tyryjacO8LLKFImitOrkpg0DjmncIELKXCHSRWA==
X-Gm-Gg: AYBFou0wMBr63HRlzM5V33/+K88U1jca5GZ776aW7tdijz6QpYN3Yhk5XLtrhz/m/XC
	Jh2raEkOQh882mHWA1IysfmXsSfnNNfGu2goufCZ9VdjLgCC1rn8TZqxwAGY0NFfC6pYxLKPZ/h
	PxzVViNRDeeD8O8N2qZcbrFcVVXRT2l8U68a1VCdtAU+6KM/wojslMK2C+NfGdEZKhJB6yfbm8i
	TEPTIUIQo5aZQUM9TFNmsOFPIRI7MUY0ZV16636RKXUv1YJTKu2feeUBaYs2kVGpdoA8eaeql+Q
	pMFR5O8w6YBD32VrBTPtwzkTXqUEuxs8vEbu3Ltv9Mn07RUiHzh0GSM9B69YAbQkXoMsX/CyPjH
	LDnD2Zct6tIDHTrxVHGQmy+2MogM=
X-Received: by 2002:a05:600c:620a:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49e60f5af42mr10094095e9.2.1789065153257;
        Thu, 10 Sep 2026 11:32:33 -0700 (PDT)
X-Received: by 2002:a05:600c:620a:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49e60f5af42mr10093785e9.2.1789065152909;
        Thu, 10 Sep 2026 11:32:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a80948sm2211005e9.3.2026.09.10.11.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:32:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A2B529B97EE; Thu, 10 Sep 2026 20:32:30 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Adopt bpf_program__add_flags() helper
Date: Thu, 10 Sep 2026 20:32:16 +0200
Message-ID: <20260910183222.307208-3-toke@redhat.com>
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

Adopt the newly added bpf_program__add_flags() helper everywhere the
selftests non-destructively modifies program flags (which turns out to
be every use of bpf_program__set_flags() in the tests).

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c      | 4 +---
 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 3 +--
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c      | 4 ++--
 tools/testing/selftests/bpf/test_loader.c                  | 5 ++---
 tools/testing/selftests/bpf/testing_helpers.c              | 4 +---
 tools/testing/selftests/bpf/veristat.c                     | 4 ++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c              | 2 +-
 8 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 7dadb90e7b68..41136e1c7752 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -543,9 +543,7 @@ static void test_kprobe_sleepable(void)
 		return;
 
 	/* sleepable kprobe test case needs flags set before loading */
-	if (!ASSERT_OK(bpf_program__set_flags(
-			       skel->progs.handle_kprobe_sleepable,
-			       bpf_program__flags(skel->progs.handle_kprobe_sleepable) | BPF_F_SLEEPABLE),
+	if (!ASSERT_OK(bpf_program__add_flags(skel->progs.handle_kprobe_sleepable, BPF_F_SLEEPABLE),
 		       "kprobe_sleepable_flags"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 652307a1b22e..902a70d5afeb 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -35,7 +35,7 @@ static int check_load(const char *file, enum bpf_prog_type type)
 	}
 
 	bpf_program__set_type(prog, type);
-	bpf_program__set_flags(prog, bpf_program__flags(prog) | testing_prog_flags());
+	bpf_program__add_flags(prog, testing_prog_flags());
 	bpf_program__set_log_level(prog, 4 | extra_prog_load_log_flags);
 
 	err = bpf_object__load(obj);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index ed3fd0a88dab..651123cd8602 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -361,8 +361,7 @@ static void test_attach_api_fails(void)
 
 	sl_skel->bss->user_ptr = sl_skel;
 
-	err = bpf_program__set_flags(sl_skel->progs.handle_kprobe_multi_sleepable,
-				     bpf_program__flags(sl_skel->progs.handle_kprobe_multi_sleepable) | BPF_F_SLEEPABLE);
+	err = bpf_program__add_flags(sl_skel->progs.handle_kprobe_multi_sleepable, BPF_F_SLEEPABLE);
 	if (!ASSERT_OK(err, "sleep_skel_set_flags"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 047dfdc322a2..3ab963458903 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -408,14 +408,14 @@ void test_xdp_metadata(void)
 
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, rx_ifindex);
-	bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__add_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
 
 	/* Make sure we can load a dev-bound program that performs
 	 * XDP_REDIRECT into a devmap.
 	 */
 	new_prog = bpf_object__find_program_by_name(bpf_obj->obj, "redirect");
 	bpf_program__set_ifindex(new_prog, rx_ifindex);
-	bpf_program__set_flags(new_prog, bpf_program__flags(new_prog) | BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__add_flags(new_prog, BPF_F_XDP_DEV_BOUND_ONLY);
 
 	if (!ASSERT_OK(xdp_metadata__load(bpf_obj), "load skeleton"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 794a7dfb0579..28724de06322 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -748,7 +748,7 @@ static void prepare_case(struct test_loader *tester,
 			 struct bpf_object *obj,
 			 struct bpf_program *prog)
 {
-	int min_log_level = 0, prog_flags;
+	int min_log_level = 0;
 
 	if (env.verbosity > VERBOSE_NONE)
 		min_log_level = 1;
@@ -766,8 +766,7 @@ static void prepare_case(struct test_loader *tester,
 	else
 		bpf_program__set_log_level(prog, spec->log_level);
 
-	prog_flags = bpf_program__flags(prog);
-	bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
+	bpf_program__add_flags(prog, spec->prog_flags);
 
 	tester->log_buf[0] = '\0';
 }
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 3f037949e978..d1d60451c5bc 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -292,7 +292,6 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 	);
 	struct bpf_object *obj;
 	struct bpf_program *prog;
-	__u32 flags;
 	int err;
 
 	obj = bpf_object__open_file(file, &opts);
@@ -308,8 +307,7 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 	if (type != BPF_PROG_TYPE_UNSPEC && bpf_program__type(prog) != type)
 		bpf_program__set_type(prog, type);
 
-	flags = bpf_program__flags(prog) | testing_prog_flags();
-	bpf_program__set_flags(prog, flags);
+	bpf_program__add_flags(prog, testing_prog_flags());
 
 	err = bpf_object__load(obj);
 	if (err)
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index e70741c6b9b7..9cfc9b4b41c1 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1722,9 +1722,9 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	fixup_obj(obj, prog, base_filename);
 
 	if (env.force_checkpoints)
-		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_STATE_FREQ);
+		bpf_program__add_flags(prog, BPF_F_TEST_STATE_FREQ);
 	if (env.force_reg_invariants)
-		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_REG_INVARIANTS);
+		bpf_program__add_flags(prog, BPF_F_TEST_REG_INVARIANTS);
 
 	opts.log_buf = buf;
 	opts.log_size = buf_sz;
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index c5501b3fdf48..ab3f5fc56e86 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -845,7 +845,7 @@ int main(int argc, char *argv[])
 
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, ifindex);
-	bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__add_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
 
 	printf("load bpf program...\n");
 	ret = xdp_hw_metadata__load(bpf_obj);
-- 
2.55.0

