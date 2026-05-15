Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5023C4FF
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857111; cv=none; b=eE5f2kwVKxuNmFi5QIL/R//+rg18ZrCazV431BvNCh03II7tVrWlSSl4EmklKW5/vXTy3gZOiP2XthD6zdLtEnIV3PiLzCTdelQuA9pY2dodcyaqKiekNLyCJUm1JP5st2pvbg1LORCLQ8Oq0J9e3g92rzVulreQfnPOb658Vs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857111; c=relaxed/simple;
	bh=E1xx1uYoxK+eSCVWHUsVq/IguOxd3TLj+xysRTJERkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zs9GWeSqRHIn9kBle+2/5ef1H3BU5y+jXvQZ2JCD+LW15615Z9ZwCre/jCGVrEV2lUi2uK6lsES7TKfbBzAHcMAKvF7cfz/u0syO7MK3tLsH0zpGumonISrZ90aCvDeo5PGGGn/9+OTvHRr+omEG0kNizPpKCsI2WVkpn2NqOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDAnfSVr; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDAnfSVr"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90fe17c157aso344749985a.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778857108; x=1779461908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+nei0qxNlG/6SVkqADrmiSvLLb+6waS8I6r15019/8=;
        b=PDAnfSVrU9OUHCH0STDvIPOJmRymaf8I4D7D0/3cdx7Nh94rucmofMhBh1MZlaKj5J
         L/GBLIHg906/V/r/BHUsSKmv71mbxCpJjd3Ijviiy3G9Usq/tjqIA52GSp5WNVbuZBmz
         X6G0tnUXmmOXj8elA0thZqSXX0u1mEa5jEYEU7prPCMae+NrHDNcX7jeoWMq+ty/ayEk
         /Z3Vv6vsYY7eQuzU652tfxXN/6EdHZ+aMRkj5bSYVMAOcMwqoOgwGzykM6ESxB4I5are
         w5dEhem6l12rzFq7eJXx7djYbRp6VXZTaJT9a3uZdrXU4iT4H8hVGQ6IIbKJqcPdNw28
         I0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857108; x=1779461908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+nei0qxNlG/6SVkqADrmiSvLLb+6waS8I6r15019/8=;
        b=cmN6M8VBYIW0KeDmyT9PPH26VCl1Ths2UZjGw9e03zj15GpF6g54tlZM5ETUnMrSmC
         AvY65QFeZyGspyrnqSToj6qj1agH0tC3EhD79P6KtITr+60+AwGhxtmTr1xpqQoJMR0s
         LNiMKQMeUx7i0IBzN1EajOk0rq8Jj9E1PVKUzlTpRgzomjeQOawCpwowuEJYkISXJd8+
         7EpCUM+LINiR6rKdw4eoO8orwj8CDABGR2uTIJEPeen03GqBYE+xQ/NiwgitYuRID/sZ
         tscBVeCzllzaoc7JAYuBCf6vp03RXpjyXiqMav49yztmjSdNWLIJnU44xYv7k8pkACBE
         cbhg==
X-Forwarded-Encrypted: i=1; AFNElJ/HiEY7iL0V+QFmHliDtCcGrdBsrt5L5Se4dH2K/rXhO33jmU2Vqz+KcDBUI+RxISZNpyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz333x3+N0XdDc/C5hy/iNuEYPYexsq6bk0Wpf8YKzhw2gz2A/Y
	jozVAPzsJMStCF4gx3aoJl3l+7k42TyeRBZ+wG7MgXYRfJjSQlnqCwTv
X-Gm-Gg: Acq92OHnvfTpwi/Lwm2q+CKJSKvRMCLDfyHR5OVfr/bHGV5+V/vNE87zfBeuqlTEvsw
	Yfw9hjF94gyQ1UUyfZ5nBGVHWd77DE0HnGCSE2H+q7/hWEnhJP4c+t8nZifkWTLrFEawlSlK9jV
	s9fESoOlkRDu5SGMAVBeEL8eWDcN8IIj6fmHHXr6sPn0SpSTkNYqScNZJL3DTj2SsNqAhoWP9GI
	yIYK+vFNxJS+KCy55lQ0gZn37pezTH9aWv0ly+uVOj4BEu7/FHTTnqYJd4y/A+vEfvc/djuPW+1
	qUKhsfLGW26agJ/VcGNTYuR8gx/KLr3b/B8ThHun10+LaATnGokONIpWZ7RcWEGa5NaUp3liKdU
	NUS8KSLYITkESBCvWvUKhZk3z8HSS44at6puRbwJHxKr/uoF8WOG904d1SyX++9XFn4boW0aALX
	yIRz/+rOIR4PxX5QTqHCSSL+SbLSX29/kDWSyNgrvk2+mGtNLD0RHGYhXIjY2TGNFfZsvmmICY1
	yh+7/NnsHluWnCudgwVrrHM0rEihbVKh4WG7c6xPuk=
X-Received: by 2002:a05:620a:4083:b0:911:1a2c:f953 with SMTP id af79cd13be357-911cd75d3e6mr700185285a.20.1778857108064;
        Fri, 15 May 2026 07:58:28 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3584esm550293385a.34.2026.05.15.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:58:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Li Zetao <lizetao1@huawei.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: propagate array_index_nospec opcode into req->opcode
Date: Fri, 15 May 2026 10:58:11 -0400
Message-ID: <20260515145812.1241925-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1e988c3fe126 ("io_uring: prevent opcode speculation") added
array_index_nospec() to the local opcode in io_init_req(), but the
sanitised value is not written back to req->opcode.  The
unconditional write at the top of io_init_req() stores the raw byte
into the persistent field; the success path of the bounds check
leaves it unchanged, and downstream consumers read the raw value.

In io_uring/io_uring.c those consumers are io_issue_sqe(),
__io_issue_sqe(), io_wq_submit_work() and io_prep_async_work() (all
indexing io_issue_defs[]); io_clean_op(), io_req_defer_failed() and
io_req_sqe_copy() (io_cold_defs[]); io_check_restriction() via
test_bit() on ctx->restrictions.sqe_op; and the audit hook at the
io_issue_sqe entry.  io_uring/bpf_filter.c added in v7.0 extends
this set with io_uring_populate_bpf_ctx() and
__io_uring_run_bpf_filters(), indexing a heap-resident per-filter
pointer array sized at allocation to IORING_OP_LAST.

The kernel's spectre_v1 protection is per-site array_index_nospec()
annotation, so a site missing the annotation is unprotected
regardless of CPU vendor, microarchitecture, or microcode revision.
A per-site array_index_nospec() was applied to the same class of
gap in io_uring/fdinfo.c recently.  Propagating the clamped opcode
to req->opcode once, immediately after the existing
array_index_nospec(), closes the remaining sites at the source
without per-site clamps.

The compiled change is one instruction (a single mov of the clamped
byte to req->opcode); the cmp/sbb/and clamp triplet is unchanged.
No functional change: array_index_nospec() is a no-op for opcodes in
[0, IORING_OP_LAST), and out-of-range opcodes are still rejected at
the bounds check above this assignment.  Boot-tested under UML
(x86_64 defconfig) by building stock and patched kernels and running
a 54-test subset of liburing's test suite against each; pass/fail
identical on both.

Fixes: 1e988c3fe126 ("io_uring: prevent opcode speculation")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 io_uring/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4ed998d60c09c..7b257a03ef84c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1739,6 +1739,7 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		return io_init_fail_req(req, -EINVAL);
 	}
 	opcode = array_index_nospec(opcode, IORING_OP_LAST);
+	req->opcode = opcode;
 
 	def = &io_issue_defs[opcode];
 	if (def->is_128 && !(ctx->flags & IORING_SETUP_SQE128)) {
-- 
2.53.0

