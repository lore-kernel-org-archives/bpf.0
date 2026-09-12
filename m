Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE637189C
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203279; cv=none; b=DaemOi4cZaxOiMSshikots4rABqoKJzp3rApGZirI3I5uKL0CcvZ26mninQrIC/V9b72RbNwwoq9P0Ot1xp53whOLg09d0voFnHR9BfXN1iKP5B9+iQs+3va0Eq+1yjJhaySdhBNefUkiyy750IMaDYqL3HgiZ0Gqt/TcjbLlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203279; c=relaxed/simple;
	bh=+p+chbFlI2LOez/o2/zhRw4SWeqORTCeHzgzF9yj7l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Er9ilOa9Q0SCx8I022yakEH7EE+IbPGfo7BmvRlM/jT4ETRNLeFc1aDm86FMGLkdtKonKB6Xh6g1+3Xso4UkhV79UBzuYB4XJzHiqpKKjltXgJpH9TB66Epwsk5Dyn+6PUzhUzanXOhRxNIomaA1N8xOhnROhOHqxDQxWBskZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6Ms2vY8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPoD070n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6Ms2vY8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPoD070n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789203275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jfw1/X1g0jEu1m6Vah470u8dyO0bTJVKsB7FRXVfakI=;
	b=V6Ms2vY8IWI2H8sDZxeIYIYRF+jCQYDUfPiz7QAqhJTf8aProivDRloZhUGo4TNfaTMzVn
	oNXXjdpXrKDLrap4uGSvv5aMWJKtErk5A5B4zTOdlAgPA5+7Mttzgm+7JeharLPv+FdRr7
	fW7xgaEOeWiBPmwjtK4QReN4W6qMXvk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-2PaH7JxOPhCabIDqmIGEmg-1; Sat, 12 Sep 2026 04:54:34 -0400
X-MC-Unique: 2PaH7JxOPhCabIDqmIGEmg-1
X-Mimecast-MFC-AGG-ID: 2PaH7JxOPhCabIDqmIGEmg_1789203273
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so22315725e9.2
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789203273; x=1789808073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfw1/X1g0jEu1m6Vah470u8dyO0bTJVKsB7FRXVfakI=;
        b=VPoD070nx+1dgaDk0LpSdM4O0B1Q1KFCKbb4/hx8PESftF8Cu+Yxknm7KmDaCM/Ols
         PfTHRYM+5cusVSD4HSo/n6NSUYv8x+M/tVr9o2VPk18nWTWhHC8s72o+BbxKtZG5n5HB
         w9VJ8r4jQKu7bniUzyBDf6gZ/YIpkuUCveGUQ6xQ8XPFfCPZOfWX044TkZ64dAjuwJko
         fYTFdYApSsuxQeyLVZFha5jNYWR4JYnpDHPWP5EWp0sAEow07zcQzzaSQPTmdY/eNviV
         D5bWx9p26V2yx63f1wI7GAjvrAhEknE0h9fAXJBEzt7fGlCQQBpp5U/IvXakiW60p3DL
         nZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203273; x=1789808073;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jfw1/X1g0jEu1m6Vah470u8dyO0bTJVKsB7FRXVfakI=;
        b=LoCNywL5XXj3VO4Ceb2avyzbLhGzj9QaSRdufIZUYDxLywM5KvRqy8Ku4nEGuhOSyv
         +c8T0A8GhJDCLUEJI5YsfNfE8NT8byXpnL3SIHrqlzl3qknwV2beOBWo9i8kskQaTgDx
         +MjNJRacZzAYQslJ4zx5/yINvr+ztjA/Jj4CkMiYX4eSn6TcMZjZts/7d8yoVsewmDxO
         o/5xu3M3rk0n6KGrik2gpUFBeo3diIotaHpglhUNdi0bnkdOb0kEf+/FtD0nEbUq6SEj
         EfbwZEHRKT3czUnX+yMynxT48BopDzVDe1IFwffg+adKejhHBdt7EVhED/YVOu18NM25
         cRhQ==
X-Forwarded-Encrypted: i=1; AKwUvByZZgzbOTiGc+c8sXILvbG/90ZbkYFyGnqWIfWHk1UpXHFcR4dsK1xb6o3lOKZBhJDXG5M=@vger.kernel.org
X-Gm-Message-State: AFuF++lBPzDz0ePAIPi9JZ1TQyc7qacfEXrXaimxECrp0R0b3i6oSjQS
	qmkJ8PXH99EkNBWjGJ8T8uBwuzzqzj7VWtOzpZt5Eu34ydPk1QBaoNDoLs9Df9DJXmL6JSV/KnJ
	fHf667Ha/KhJ9FE44YrruEhrRSQM4RUkUJK/0kEZb+W7FzkHcoEGtrg==
X-Gm-Gg: AYBFou3stUyLSw9Tk5QCLX/ghnh0FGZ8YRtfm3t67RfrWTXt1e620soZigI6NQ/aq8z
	WOL2QbxpTX5tak2gECPeA7pp+FveS0cMcP3zvWRv9Dn76vQkKwh2ayHRXE8OidVOkP1oM30Jdbe
	pHuYq4h/E6edHhqwTBkLeEpmrtTmtlyx1Y84Q5YVRUeGA1+8Vg+WWuwiHlIeCRWeO109mU/6thu
	4217K+FWFHhP35LxMmMVd3DOkBZmrUA3sZ0vnzen3nuMaLq3Xk2aTDdvtbXHMpVjpVc95qAhw5x
	Nyrd3jIebNbN19+SyprKoLUfyrpSRrL23/eY7PgvMZSfgD1xsprhWV4oTEI3MuIfpgvACmsjY94
	Ll9D2DZSjCVhBUGxJ1BZx3nhu
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49e6198a3b2mr63249715e9.12.1789203272895;
        Sat, 12 Sep 2026 01:54:32 -0700 (PDT)
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49e6198a3b2mr63249505e9.12.1789203272547;
        Sat, 12 Sep 2026 01:54:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32d3c7sm10965695f8f.10.2026.09.12.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:54:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id ED82E9B9AB7; Sat, 12 Sep 2026 10:54:30 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/4] libbpf: Add bpf_program__add_flags() and bpf_program__clear_flags()
Date: Sat, 12 Sep 2026 10:41:00 +0200
Message-ID: <20260912084109.432834-1-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When changing BPF program flags, applications often need to just add or
remove a single flag, without touching the existing ones. When using the
bpf_program__set_flags() function, this requires reading the existing
flags and doing bitwise manipulations before resetting the result, which
is slightly awkward to do, and easy to forget.

Add two new convenience helpers, bpf_program__add_flags() and
bpf_program__clear_flags(), which wraps bpf_program__set_flags() in the
bitwise operations required to modify flags without clobbering the
existing ones.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v3:
  - Proper API docs
  - Early return on load failure in selftest
  - Replace the two missing instances of bpf_program__set_flags() in selftests

 tools/lib/bpf/libbpf.c   | 10 ++++++++++
 tools/lib/bpf/libbpf.h   | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8da5181c8e8b..2c6ebce2b675 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9933,6 +9933,16 @@ int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
 	return 0;
 }
 
+int bpf_program__add_flags(struct bpf_program *prog, __u32 flags)
+{
+	return bpf_program__set_flags(prog, prog->prog_flags | flags);
+}
+
+int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags)
+{
+	return bpf_program__set_flags(prog, prog->prog_flags & ~flags);
+}
+
 __u32 bpf_program__log_level(const struct bpf_program *prog)
 {
 	return prog->log_level;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..48266e752223 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1011,6 +1011,28 @@ bpf_program__set_expected_attach_type(struct bpf_program *prog,
 LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 flags);
 
+/**
+ * @brief **bpf_program__add_flags()** adds one or more flags to the BPF
+ * program, preserving any existing flags.
+ *
+ * @param prog BPF program
+ * @param flags the flags to add
+ *
+ * @return 0, on success; negative error code, otherwise
+ */
+LIBBPF_API int bpf_program__add_flags(struct bpf_program *prog, __u32 flags);
+
+/**
+ * @brief **bpf_program__clear_flags()** clears one or more flags from the BPF
+ * program, preserving any other flags not explicitly cleared.
+ *
+ * @param prog BPF program
+ * @param flags the flags to clear
+ *
+ * @return 0, on success; negative error code, otherwise
+ */
+LIBBPF_API int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags);
+
 /* Per-program log level and log buffer getters/setters.
  * See bpf_object_open_opts comments regarding log_level and log_buf
  * interactions.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 08ab2ea881fb..a811a1b3a085 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,7 +458,9 @@ LIBBPF_1.7.0 {
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_program__add_flags;
 		bpf_program__attach_tracing_multi;
+		bpf_program__clear_flags;
 		bpf_program__clone;
 		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
-- 
2.55.0

