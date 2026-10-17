Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDEB2EEE8C
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200470; cv=none; b=TAd5w6Qi0wndRy76rBruaBt7aPgBGHdtKF1wkriGoAFVmKFx7scPi8KxcWs7vofR/lpOyVF4stugLmspJcMBMg41xlvmLRhPRfXFAPTIA6PDITNvqHyNuhKDrjmZZdnpDLfcBWZ5gGy1wRO32kT2iH6vflWzPRZC7EaLJmp0tAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200470; c=relaxed/simple;
	bh=jqT5Ab18KbkMPLG5nuVmKYwi9/htcEz1suyx38WJeRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dszYAq//x0k1QIlpcU+zqByLE/F8pityKDz3woCHNRtWITiIcuECdo3IqwTLbOBTtzRA7/BkBHSS8x/k6DH0CQYFM+4+nteiUgI08OyEoQhkLJ+edIVQlV3uegeG/muB0tlPfZl19wGAf35mXof3buxOg/HyFw54FIiol4k0cVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzXbxCNP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzXbxCNP"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so317771a91.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200469; x=1792805269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIpcC7WsRUsfob/M32I+w1LmmQqZv3hP9zFFPAjnTx0=;
        b=kzXbxCNPf34WSlNfqlfLUj1nuQbgGCGNRw0+s4Bk32bA6KWXB0IXzqT3l6gdPacCGG
         fNOR9FLRmakhstZKNSWL+Nah4gvsVrBh44v8Jpp5WdTZbrLfW+Sr0OaS5aGURnapK3Zj
         gAvd0j4rZ4GOwQXXJMEo70xOxKXT38FAhdPkjPc6gIx/fCfZneBYve3S1j7tJKM7KM9M
         HITBrW4n7jP9J0XIO1+b73rMFkNhgGFCjBrHk2jFY0lEUzUUOcNTap8l86xMbPPTTvnd
         +hk9Tah8e2VYADqkg6PRc9BK6n8c6hdG+Q94Gv2gslt6bqKARfWVwxaEkDxOmNmHdiiU
         D2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200469; x=1792805269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nIpcC7WsRUsfob/M32I+w1LmmQqZv3hP9zFFPAjnTx0=;
        b=iItuSKqyVtLciuQKfKOhdUhyjpldj9qUWyGum71hKl0INEtltgeIvDfCds4UWAzQJg
         AqhX5lNnbeu85g8oZlUL3z2Osg79n5NdFe67MR4kBdGB36LW62exWdkonBaz3nbnDG85
         tBpGPWHRxnJcBmPfdPRjXUi1TF6OMSTrZhHqVc8mmh3835rRvGLX8o6pOHcOjhomD1Iv
         DAtyAZF3dTT+T6TdVqUs4kh5f8dNZwKumsadIofwKuMQBQH8P+juYRbSAdDMssFdyq1O
         cTsAcRsnFTIEOBjgwwXpP/SpRui7D1kMRRnBCvymMCTB1K6uTT0PjnkmPaC3lgq4i4kn
         M/HQ==
X-Gm-Message-State: AFq9FYKLlFl1Wh/I92dRlqcRxUQXJMuHz4fb3AEXn4JCqfjfrFUHqeKW
	Sh3VnGiIvJ0vXuGkmsI8XuougD3R6i1Jdl79cz2AeaCQ3I1rFDc1nm+gpAuvchID
X-Gm-Gg: AYBFou23BjNhAfmtlGUkB+NBh9MCAZKJrBpfEJ6WvrcTZ3RShqVfpeO0JfmJ3WfdIm8
	RQzL4EiyG2QvCgJtsOjfDwaG3JwaYEa50wXXGLgx5TTtFbh7AMomIOSgVRqHGW1xpOFUmlZX9+A
	6M0p4alSj0A91Bhc38gV7PbdCNnsboXtJk7mvllJnN6XgG8Rud/xQhKWu8ZSVnC7tcSdiMx/Jwo
	rX23uKM09/ZKraC1gnJ4yPvmzZrhk9A5nbhWQUq/B1fk9goUayETwSPEwb6tVbTZyIthO+3t+u0
	jQNcnSCPbGkoqBQTp0lVvHkp/v+ijUK1Md3/GQSZ1s0c5mijIjsMReYJuh+1utVXkV2tWCp2joT
	F1BZcd1MQ5YncwrMOjUhdSIYrv5Z+392lCFXDxQMKH7P/jmRP6u9cgEBK+l9bchKf2IHo8hk56n
	c9nea9teTeX4JldDkNkWLeSi89tSJIO7Sk0zCTGeCPeXRlkIWop4qVlUax0urPU26y1otQAse74
	K9SOh0fwHwMEPJDef/HrsmDsH4e8I6P/u6D+Yopvv9fwnUjD0B5mrF4waoMKWJxZh+jGp9xhgBM
	XzAEs9JZkwwCM95VLTfdTnkt+cahnzhLudM3BcQrA1Mc
X-Received: by 2002:a17:90b:39ad:b0:3ac:a7ee:678c with SMTP id 98e67ed59e1d1-3acee2796fdmr1139235a91.2.1792200468922;
        Fri, 16 Oct 2026 18:27:48 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9461d71esm11282572a91.7.2026.10.16.18.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:27:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 17/38] bpf: Bound the nesting that the BTF show code follows
Date: Sat, 17 Oct 2026 01:24:30 +0000
Message-ID: <20261017012451.364800-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

btf_struct_show() and btf_array_show() recurse for every nested struct
and array.  MAX_RESOLVE_DEPTH bounds one resolve walk when BTF is loaded,
not the nesting: a member whose type is resolved already is not walked
again, so BTF that defines its types from the inside out can nest them as
deep as it has types.

Whoever may load BTF, with CAP_BPF or a BPF token, can give such a type
to the value of a map.  Reading the file of that map in bpffs then
overruns the kernel stack: with a few hundred levels the stack guard page
is hit and the kernel panics.

Stop at 32 levels.  That is MAX_RESOLVE_DEPTH, and __btf_show_indent()
has as many columns.  Nothing is shown for a member that lies deeper, and
the status becomes -E2BIG, which bpf_snprintf_btf() and
bpf_seq_printf_btf() return.  The types of an x86_64 defconfig kernel nest
14 deep.

Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64c78434fa05..a9bf4c3c0a27 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1081,6 +1081,8 @@ static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf,
 }
 
 #define BTF_SHOW_MAX_ITER	10
+/* nested structs and arrays shown; __btf_show_indent() has as many columns */
+#define BTF_SHOW_MAX_DEPTH	32
 
 #define BTF_KIND_BIT(kind)	(1ULL << kind)
 
@@ -1474,8 +1476,18 @@ static void *btf_show_start_aggr_type(struct btf_show *show,
 				      const struct btf_type *t,
 				      u32 type_id, void *data)
 {
-	void *safe_data = btf_show_start_type(show, t, type_id, data);
+	void *safe_data;
 
+	/*
+	 * Structs and arrays are shown by recursion.  BTF loading bounds the
+	 * depth of one resolve walk, not how deep resolved types may nest.
+	 */
+	if (show->state.depth >= BTF_SHOW_MAX_DEPTH) {
+		show->state.status = -E2BIG;
+		return NULL;
+	}
+
+	safe_data = btf_show_start_type(show, t, type_id, data);
 	if (!safe_data)
 		return safe_data;
 
-- 
2.55.0

