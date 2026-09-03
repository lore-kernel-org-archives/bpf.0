Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F603A1CEA
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427477; cv=none; b=jI3sjAhWN7UqBKf3RxJ5wr/ZZ21S3wED+yPctZnDFeeRNy+PgEolKuWw3QgCqzkt+f0TUjAXZfnxgvOj0bnhJ8e/IYOHReESt0w4D4W//HantIPaI9kIpPfhTS88E5MrIJ2I2EgjZrjTGUdcHvoa/Xj1ne3JbAfrKCTJ+/7AAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427477; c=relaxed/simple;
	bh=dCQMrEkwACrGAT08udXr1ru6yfRZwiBxV0C2nJ8MKW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TtnPfc2JvGcoj8UNLHAEENywrEkY8K7Nx2gZAsbJOStzlAcABm/37IXPtNdktg4iMeGh4KJAUGqWZET2/GG2blNqlekMRJQ4Twp0fl9lKC7ZA216v3tyTz5hppu0d+mvpIHJZQta1Q6LcLpjyNqdyITwGRz1SENWmK1pXm9dMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfHG5KFE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ppBaTBOo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfHG5KFE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ppBaTBOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788427475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qldvMZyBxnbwLYt4o6CQ5CretpU37v1Z9qQcnyf/9N0=;
	b=hfHG5KFEseV7FY3jnkmpBfUAvNj+kJlMApjivKXLpSbc/wuQjiiyoyqCh4T5MZZ4OzLSMB
	YCXDZ6vPE55vBfAkwMuA+1cgRlC90YfxL7SzosoAcH8HuQhym7kTF9AV96By53P0EUi4+u
	C03o1o6GtCOSVcx1QSWUl5ph+mMhFt4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-CcBzvjLIPvCaOl3TAWJFaA-1; Thu, 03 Sep 2026 05:24:34 -0400
X-MC-Unique: CcBzvjLIPvCaOl3TAWJFaA-1
X-Mimecast-MFC-AGG-ID: CcBzvjLIPvCaOl3TAWJFaA_1788427473
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso4385155e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788427473; x=1789032273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qldvMZyBxnbwLYt4o6CQ5CretpU37v1Z9qQcnyf/9N0=;
        b=ppBaTBOot0MJC3t7RK7b4iDjFMCtoWMkK97mUc3TAumijRwSGb46BfTHi9pvqv6XXy
         V+azgcL9Ntba5jz639IefH/BPwIIgS6WrZfaQtP3oXlxgZx6UMfee+FTxv2xOcuoLvOS
         kKwelh8NMt1gFPe3RrBonSRo4g1oBSk1LY7xG3u1zCJENDAhjQ2NUk4nRWERsLK8bclD
         HM37zrgK0gWRcAxmsAHjAgOOz76jcfzT7LrTFxNi2k+yWOfK6RmFiT4irJBBqQ4JypZm
         o/poPX6wTMqOr5QPa0tnTWHKymnqI63nIME+27yV/RnVcZpvIbftYdu01wSIzdIRCQz2
         Q5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427473; x=1789032273;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qldvMZyBxnbwLYt4o6CQ5CretpU37v1Z9qQcnyf/9N0=;
        b=A+u35bwXndXxmN88qEmoGpv3MYEyJa4Uir6GTncl/bH8xgt7+VraaNWtYh7x6uSQdm
         lRCRdWxs1sdsBg5bP2bxuExNdBfAnM7QYp4LqohRvx3vtTdGtul0SfT+AQAsQsGJbsL4
         +IMP25Ocoulzt4a+PiRkB1qoNLufsc62InPqe6uBxbO9xit0B0vprDKpFzPf7wOA17jV
         WzOf8J2vWjrBVA+9f3a50RPzfuIYuMOIEe1Q4tDA4f/zox3p+sr8JRWmcebuxV0vhjDR
         MI8oQv+VEH85UPMcXVCImYTTDZKc9zuiw/aCUE5q79lXEIRgDI+Kl/XmyjbHnkyJ6IzG
         eM0A==
X-Forwarded-Encrypted: i=1; AKwUvBzIRIOc0W3pZgvUcAEcHckNU4VsO4HvelOeXCqcptMWosP4JqFQ7QjjRkIb9YrHWzA3g5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++l09CeHzkJYxWa2KFmLUEQIxxNfzRWCfxC+WjvEu0hU+lhCUh6s
	qPcftXo2J+SrCO3eoQCcVy7+0Nrp5N667OpXwG5LrHIBEcrycdKfh50b3lpUa49z5XVQAD3RjZx
	UQZib1GjZbCmwZhYpEkGYGM6OxBAQoqWJzJJPDOI5pCtoUOFhfJTsfQ==
X-Gm-Gg: AYBFou1mQxxER4KIY+jD/IJoi1JUi8XgO1mpQG2nLkDP6pkwvtOpXwnErk+rpoXHOko
	9tYd1IUSUnwn5ToKhkZaQwsKLbvZzymrWOLvMFWJCVYCRm/rGWt1tzJgb+ob+TLN3uHsC2ZQvC6
	rC4dKYZQldtAuTgndUmcs4PVSdHZ+q8FytYqFyPyGCQPojN7+djcfhe98pWD13nUDJ7RMjyNzjC
	3E8MPK9MSB0299AjvnDOB8+JW/ZZPrRVaArgw6pyBaoS8VgHNJ926mmcBBche5ZIvvNI+bgVAdB
	6HdsL6jOQHig3mu4lB1rQ1HVwnWOgIb6MhxrcmuXqrRPvYISAXm9AcEBRgJUPo0vP4oXv1jNxvX
	VI/NEtHEZGdUxROrVkGFS5Q4D
X-Received: by 2002:a05:600c:348a:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49cf15a3672mr22467515e9.10.1788427472822;
        Thu, 03 Sep 2026 02:24:32 -0700 (PDT)
X-Received: by 2002:a05:600c:348a:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49cf15a3672mr22467275e9.10.1788427472451;
        Thu, 03 Sep 2026 02:24:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5927b68sm113395805e9.1.2026.09.03.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:24:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F242B97C7EC; Thu, 03 Sep 2026 11:24:30 +0200 (CEST)
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
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/4] libbpf: Add bpf_program__add_flags() and bpf_program__clear_flags()
Date: Thu,  3 Sep 2026 11:24:08 +0200
Message-ID: <20260903092416.223294-1-toke@redhat.com>
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
remove a single flag. The bpf_program__set_flags() function clobbers any
existing flags value, making this awkward to do non-destructively.

Add two new convenience helpers, bpf_program__add_flags() and
bpf_program__clear_flags(), which wraps bpf_program__set_flags() in the
bitwise operations required to avoid clobbering things.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c   | 10 ++++++++++
 tools/lib/bpf/libbpf.h   |  6 ++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c036e8a91ed8..221c4fe1fb31 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9938,6 +9938,16 @@ int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
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
index b965ad571540..3932bf9cb490 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1011,6 +1011,12 @@ bpf_program__set_expected_attach_type(struct bpf_program *prog,
 LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 flags);
 
+/* Convenience helpers to non-destructively add or clear the specified flags
+ * instead of clobbering them as bpf_program__set_flags() does.
+ */
+LIBBPF_API int bpf_program__add_flags(struct bpf_program *prog, __u32 flags);
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

