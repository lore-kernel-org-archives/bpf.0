Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698878;
	b=h2QVF3SqDOgNeX5mYUtK9L5k7Bb+bA5QqZarfm00pioKKVXal/PPFN/kUCbWdgyyExfQ
	 NAoRfTpiBNNB1VV7niV2VLIhJtk+DeX7Dctdkm1sCs/Wz8fuFsQ857Rage+i0+n0M5qyu
	 GJaiYxYconPNSr4x3O6yuXx5y5d7AqY3hYvM38fJwfJ7dET86iasEAKznp+9cQ1/M2QYK
	 hpSXQ1MDYLfm15lT+5zDTA4l4n9ELmJb6o6Q6cD7gL/rLzujsTOrGFrg7J4Qv4l8z1tKu
	 WBVhsVw/WhzMqvvSLwW8JfTEaA/B+XMCnNfWbvb24LLw6P6YujFE7RzltoqaSP4gTNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8OdYBIQIZfX+BtuN+0pczgDogiciwq+LfA9eryGnQWw=;
	b=ROMu5IBLw5qnyu38t+Xq7uEGCtJkaYxkF/0y635XsWXaU1wWGf/jSMSk6KAIRku3lUB3
	 BnIt1bSocVz6D6QLsf+7D6HANJzDUxfQmnuiTg63tCDLCSL2p+mZra/l4e9GXPLztMsRo
	 FV+47O4Ji/n1sBHYe8uNY9ghvSX1S10EkWKsVV9ogIUtNW50Dve3/vGQ5vjDaXxuC8vER
	 sg0Dxlmg0sQVoA/nxZou8yR0U5CrgFFehITIwKeRjIPFPDs3GFEpjTT5x7Pflwiaf5wyM
	 x2dsBhWis1qAgnGYWWz1E7iUz2wEAllRabewraMvWt5E5rjTIrBul+Pjk38X/r6Fo7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l1VjshKH;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104F606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 23:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C104F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l1VjshKH
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ed3d8877e6so22357805ad.3
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698877; x=1795303677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OdYBIQIZfX+BtuN+0pczgDogiciwq+LfA9eryGnQWw=;
        b=l1VjshKH5Dz6Re1ciUe+etTICtw1glSZR7qwQDUDK892aY6L1VflHFLTCLAtkQl5+k
         obxWtC61woRXPN1zlw6/98o2ugsw+viGQvFDIQqcYa45H9SGpq9K4j8waMRcNs++UVLJ
         zgGPp6jPNVQZrhZqdqAhEnBNiH/sHFq1BZ07wS0kPGJISq2fYoi0jzLpmD0v7AQbp/nW
         hAj8TN0k2gBew7sAqgwUq+T8bPFgrFgkQGs+KMQqOc/al4nhXexXrQoEXhlF0SDm6+Xx
         CWiI/kwyQOIcyGpMRbKsJbZm4ryp5RazJQiMj0wOVPxVsp7HZ2SqVkF4um6WcfQEVxeR
         GR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698877; x=1795303677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OdYBIQIZfX+BtuN+0pczgDogiciwq+LfA9eryGnQWw=;
        b=PKfHudwaHVdHCO/8aka9LDuPVSTPxvYbQq9brJ4Fdmxmc+zNEiEhr0Skaoj+GbiWce
         STktfyzAAYrkqduzAbV/iECM1Xor1O1YdJY0SjKbA16EGK0dGImngi2ZAHauGJ5mrr7h
         Kf5r3CaBioQMvRBaxyMhvGk86uSVx9KTiM6Nrel03hOQZ1cQwvH7b61uDP8ZsSlFpD+5
         bEFt00QiqruhBFAvmXQTOy1VmsnU078cv4GDCi/RYuumvLx03bYPsQGwn6p911xRvMz7
         zU0YK6dpbgGFWiPzgr/xsYAWcP0DCvJNPU2OqZiamdapIDuqWE8Lg/DI26NbsFvT1Rt/
         d4gg==
X-Gm-Message-State: APuU4Z+4DIgjiwGDc0mPnt6vDXKkXCldf7VNnP/HBE5rI7pzA5AS8ZhO
	/E/US473tcWOVBEulRVmjc4oNt2G+U4OvZPt3Qnj4es3J3TLoYpnTny1DHk8og==
X-Gm-Gg: AYBFou15BSkjqT7WyqnTDbR8X78x4ISwlc9qBoIDBhQ2iuzkdfUuFOuQ51Rc0r3nuIJ
	zHtQnvUijeQ95N1jpJ/ZcoBd0S5VR3FQyDsjD6n2fqvVS6kdG+fcTmDrk8pqA/8IlphbU+JmR4G
	RK+11/NeJqnLJd2GqXsailPu8AIzwXcH+JJMy30phuf1qCHPYD7a+YKyGgUoewUbTlpxApIagRG
	CpNUVF3vJdAKFonEN5TBL2hbyhq6LWy8CJl84I8+L88W/7jdnV5ODYJWkQIc9kAn1WEgCtWtx/o
	tzvm4LswXjNOEeStyUxhtccQ3EO5RAoV0hpY/nvYFi/vsgV28Y66yFMcnPngIm+CsmRZQ+lSgM8
	liGIlblGyCYXYay0eO5MGrhihsFf6i+HnAPf3ZRZY3r+tivcwcezLcmgskDiA/fhSuI89HVYCTx
	636WyB8B2BZShwIAS+on1FDxn+FZlGYsOg0S4yrZB3AUgurSuIdyiUEWVzQG/Du4x8jkJ+8JvxG
	rJfh6W4XRjovsvZ9CoQJpopDJtfUFICgNuxCATXcccjFUGuP37DDDh4RoBttrsqnJYnL/piJ7Qg
	F/xLzHPDOPJBHxFQZ8zbYiAZlqa25bPTc4ki76/whkMlQnq2T7tPxBGaZs7tVi/xBuZ1ZearBFE
	kpfAEF/mIpUDLskYjA5C8Q5+d1ttULvOS7D6UTu9fwG7eosnCXei/HYSWMYL879RaBxtCNihmqk
	k=
X-Received: by 2002:a17:903:228b:b0:2ed:2b46:667c with SMTP id d9443c01a7336-2ee0d55e2e1mr68997295ad.0.1794698876751;
        Sat, 14 Nov 2026 15:27:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c875sm23259415ad.15.2026.11.14.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:27:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com,
	dwindsor@gmail.com
Subject: [PATCH bpf-next] resolve_btfids: Don't list -EBUSY next to -EINPROGRESS
Date: Sat, 14 Nov 2026 23:27:54 +0000
Message-ID: <20261114232754.2732901-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

crypto_enqueue_request() returns three codes. Only -ENOSPC is a failure:

	int err = -EINPROGRESS;

	if (unlikely(queue->qlen >= queue->max_qlen)) {
		if (!(request->flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
			err = -ENOSPC;
			goto out;
		}
		err = -EBUSY;
		..
	}
	queue->qlen++;
	list_add_tail(&request->list, &queue->list);
out:
	return err;

-EBUSY says that the request is queued on the backlog. crypto_wait_req()
waits for the completion after -EINPROGRESS and after -EBUSY. The tag of
the function is 'bpf_fmodret_retval:-28,-16'. An fmod_ret program that
returns -EBUSY skips the list_add_tail(). The caller then waits for
a completion that never comes.

means_failure() cannot drop -EBUSY for all functions. In most of them it
is a plain failure. In an x86-64 GCC build 645 of the 11432 tagged
functions list it, and it is the only error of 205 of them.

ccp_enqueue_cmd() and qat_alg_send_message_maybacklog() have such
a backlog too. All three functions also return -EINPROGRESS. The rule:

	-EBUSY is not in the list if the function returns -EINPROGRESS too.

crypto_enqueue_request() stays a target with -ENOSPC.

	                list -EBUSY     lose it
	x86-64 GCC      645 of 11432    1
	x86-64 clang    674 of 12096    2
	arm64 clang     638 of 10954    2

No function loses its tag. The second function is seccomp_notify_ioctl().
Clang inlines seccomp_notify_addfd() there. Its -EBUSY is a plain failure
next to an -EINPROGRESS of another kind. It keeps five other errors.

Reported-by: David Windsor <dwindsor@gmail.com>
Closes: https://lore.kernel.org/bpf/CAEXv5_i17dJmGp3y_0U_f_xK9-SyC9M4GkLCx=pT=4VoXJ4abg@mail.gmail.com/
Fixes: 4dd950adacad ("resolve_btfids: Tag the functions that return errors")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/resolve_btfids/fmodret.c                  | 13 +++++++++++--
 .../selftests/bpf/prog_tests/fmodret_retval.c       |  1 +
 .../selftests/bpf/test_kmods/bpf_testmod_retval.c   |  8 ++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index 0751519b95d2..e1afdb6dedd5 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -61,9 +61,15 @@ static bool fits_trampoline(const struct btf *btf, const struct btf_type *func)
  * -EAGAIN, -EMSGSIZE and -EINPROGRESS tell the caller to retry, to go on or to
  * wait, not that the function failed. Their numbers are those of the kernel, in
  * asm-generic/errno.h. The errno.h of the build host can have other numbers.
+ *
+ * ASYNC: the function returns -EINPROGRESS too. Then its -EBUSY is no failure
+ * either. In the crypto API it says that the request is queued on the backlog:
+ * crypto_wait_req() waits after both.
  */
-static bool means_failure(int error)
+static bool means_failure(int error, bool async)
 {
+	if (async && error == -16)
+		return false;
 	return error > -512 && error != -11 && error != -90 && error != -115;
 }
 
@@ -82,13 +88,16 @@ static int cmp_error(const void *va, const void *vb)
  */
 static bool format_tag(char *tag, const int64_t *values, size_t nr, __u32 size)
 {
+	bool async = false;
 	size_t i, n = 0;
 	int errors[nr];
 
+	for (i = 0; i < nr; i++)
+		async |= (int)values[i] == -115;
 	for (i = 0; i < nr; i++) {
 		int error = values[i];
 
-		if ((size == 4 || values[i] == error) && means_failure(error))
+		if ((size == 4 || values[i] == error) && means_failure(error, async))
 			errors[n++] = error;
 	}
 	qsort(errors, n, sizeof(*errors), cmp_error);
diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
index 1db55d8d8d67..281c6192e570 100644
--- a/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
+++ b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
@@ -17,6 +17,7 @@ static const struct {
 	{ "bpf_testmod_retval_minus_one",	"" },
 	{ "bpf_testmod_retval_eperm",		"-2,-1" },
 	{ "bpf_testmod_retval_denied",		"-13" },
+	{ "bpf_testmod_retval_backlog",		"-28" },
 	{ "bpf_testmod_retval_effect",		"-22" },
 	{ "bpf_testmod_retval_effect_late",	"-22" },
 	{ "bpf_testmod_retval_effect_two_regs",	"-22" },
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
index c6263d7e65be..85722e48d34c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
@@ -51,6 +51,14 @@ static __used noinline int bpf_testmod_retval_denied(int a, int b, int c, int d)
 	return d ? -ERESTARTSYS : -EIOCBQUEUED;
 }
 
+/* As crypto_enqueue_request(): next to -EINPROGRESS, -EBUSY is "queued on the backlog" */
+static __used noinline int bpf_testmod_retval_backlog(int free, int may_backlog)
+{
+	if (free)
+		return -EINPROGRESS;
+	return may_backlog ? -EBUSY : -ENOSPC;
+}
+
 /* A caller which gets -EBUSY relies on the unlock */
 static __used noinline int bpf_testmod_retval_effect(struct mutex *lock, int value)
 {

base-commit: 3a4161c87e356d33e179076a5194d6f407cda567
-- 
2.55.0

