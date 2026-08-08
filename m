Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5964B04BB
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170370; cv=none; b=RWYtK5ViUm8oZXe5RcEuk2zG7p9GFErAPUomezPQhltxMawj0kxzG+6FBqnJr5P/XaF3Dfaz9gkS6PHN3QIDob27hJ7gb9Tw5UcOMBgL03lAmyXDHNa0zYhw2s4nUA/zfnL2DmzhcwEzPpaZ4bnSh5aT594iVIbBjdZXpGHJd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170370; c=relaxed/simple;
	bh=EgIiPN+rJzdA1Kk8WCDbrGIxOHYZQyAJQgqWNr2/0ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbapBp5vAJ4SQcO023bwDJRMNjPr1isD8Gx0wKo6kryMLwCzKXegW29jMlf+PJ4xMzl+Ij6DLq+fpHxcMG1kpD5fCmTRSRdvxQaZElhrM3SJMR8xQ/Wa5qTKdAgykb32DQFBjiZaOcjh6GsF6bBDA2x0j/WbeBUpNynOPqVF2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa/kYeQB; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa/kYeQB"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso33426f8f.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170367; x=1786775167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J2KPRVJPouESLWmZpQeHNijb/fQWcS0wm7L/tX0GeVI=;
        b=Fa/kYeQBqwOuNHLgtJ07B3GmUgogVXZvJjfRzdVHizDJagMWrupuB6EJZo79gWLxER
         let6PXRhEZyK8ZHaUiplknKwSeXeknEFkHWN/O1zKAFHX+0C+pQQ7cOojkFHtOHbnpxv
         pWNhPDjLHK83PcvSEoKQ4Q/FPIqPjPplm6d23lDNAc/+9+jhVuHzuZgZEIScl0mj37uF
         Kg3Uh7nP9ELlHsUigPO7RuVnuBAElTbPLVcxUSsrPXHEDEqIGmwg6hTTyKJmJa+g8mH8
         xFxhabulCNSmROWo06upcroNOUs2aGLItNEgeP7AZlOVM2UgAQTJc3XWO1g25DKVsvxC
         Ygow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170367; x=1786775167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J2KPRVJPouESLWmZpQeHNijb/fQWcS0wm7L/tX0GeVI=;
        b=gIWQTor+nG5BhCcXPGMG5OJURpajj7nQGhJzi4zNld383n12YBuz5dHdslghz+En8S
         swxo4aCJgdpT/xd87th0QOHl4snngqwcyMcIhmi8lNzKmemLbiqP6/Fx/V3JodBJQzoH
         e3YdT93k2TvCBTWlcXTl/ZYYZNyYZnD+/UzRj1tTS9QgssmMe4tDkpxnpHuIItewC9ov
         9cWIb/UsF0LRWjrMpNQKR/6kyBG+ewacIma1Fk+YgVx/pVPpwuifwR66imXdtHH1jATV
         IhqR34gNlQCj2qy5DLyBKC5I+7LdHiPITavo16d1m/83pqbhqfnxKY1XgSFt9JMBY3cy
         uLIA==
X-Gm-Message-State: AOJu0YwulfPeB7opPKB+vxi10qbcSymOY731LjDP4fGXHNrpYAsVwfsw
	OxsAZMl/GV0pb2MqFCHFN1loPv+57GHkycCnzg77Wlw7u2LnP5V4Cd90qecEIDYgEXg=
X-Gm-Gg: AR+sD12Bp+Ei/N8//LxRx2PzdL5tHiUEfKgvoJgLQKTN896uD/tG0HeZ4W+hWAVdLfz
	XFO+TKwfqk1uamTA+zxGeLT8VuS3RJZAo+DTJCNe05XffUebtHQ3FvFTH9l4kNL49RieYyOsDfv
	nNRXwBeW0iRWt1gm/8jpwMOMr5zpZSU/vY++sSgGyx4S3TQ59ysWkxbIeZGILY9U434oDoD2QzT
	Gim6hcK6k5M5hK5mYMJDTWGPqMeilfqVE2iIAl9TeEy1ymKTCJizx5jaBp4bZ2VfQT1Ddqibucn
	nSnVd84YNUyOekVHQR1UzubpM7yY1a69kEpPQ3kekO0E65JP2EWUHlZDbpmv6AocWrYT2tOzYG7
	1k/WtDjLYYedeotMcXmfgJnfoLoijtkLxnGViyee0CQDqIFd5bA0sIAse4oVom0drA/I9u8SCQ/
	5FqROGLaQIF08vZ+lkV+xPh/9BJ3ctNeInXtXe38QvzaJTBDWLE/YTMvPsbTiqbweFC9A0PRMk2
	CPo4Lh9JjLXksqaHSXIV41j7IBB0l9xy2Kj/JbjDU/D48esWRTC7LmN1lclaYGk8DyGb6S5cdEl
	eIFwP/ZB81FuSdRt+pPAkFAJwwQ=
X-Received: by 2002:a5d:5985:0:b0:47f:b452:49f1 with SMTP id ffacd0b85a97d-48130e7e7dbmr6797060f8f.2.1786170367529;
        Fri, 07 Aug 2026 23:26:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145679sm11742839f8f.3.2026.08.07.23.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:26:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 4/6] selftests/bpf: Adjust veristat stack depth parsing
Date: Sat,  8 Aug 2026 08:25:56 +0200
Message-ID: <20260808062601.1070988-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808062601.1070988-1-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578; i=memxor@gmail.com; h=from:subject; bh=EgIiPN+rJzdA1Kk8WCDbrGIxOHYZQyAJQgqWNr2/0ec=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavs9K32M+U273/HOZltXL1dTv552I3WlENJ1xIYRWMzH rH1fu/tKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ4mxkZlh15cM/okKlHzC6e ZK/f8rdaNmW7fTR6/+BftNN/8XfyiQz/a1IWhh7QdVmiM/Fj1fUCpSvvp8UtzDXYvVhn+sGf3O0 LWAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier now reports instruction and stack depth statistics using
uniform "subprog <id> (<name>) <kind>" records. Subprogram 0 is classified
as main, while other records are global or static. Each record carries
insns_self, insns_total, and stack depth.

Teach veristat to parse the new records while retaining support for the
legacy one-line stack depth format used by older kernels. Skip both
instruction counts and match only through the stack value so fields can
still be appended without breaking parsing.

Increase the bounded backward scan so it can include all 256 per-subprogram
records.

Zero-initialize the legacy stack buffer because logs using the new format do
not populate it before the trailing tokenizer loop. This makes the loop see
an empty string instead of reading uninitialized data.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c9c257784ee3..0ee4a675b938 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -993,13 +993,15 @@ static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
 
 static char verif_log_buf[64 * 1024];
 
-#define MAX_PARSED_LOG_LINES 100
+/* Keep room for all 256 subprogram records and trailing statistics. */
+#define MAX_PARSED_LOG_LINES 300
 
 static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
 	const char *cur;
-	int pos, lines, sub_stack, cnt = 0;
-	char *state = NULL, *token, stack[512];
+	long sub_stack;
+	int pos, lines, cnt = 0;
+	char *state = NULL, *token, stack[512] = {};
 
 	buf[buf_sz - 1] = '\0';
 
@@ -1025,11 +1027,17 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
 
+		if (sscanf(cur, "stack depth max %ld", &s->stats[MAX_STACK]) == 1)
+			continue;
+		if (sscanf(cur, "subprog %*d %*s %*s insns_self %*d insns_total %*d stack %ld", &sub_stack) == 1) {
+			s->stats[STACK] += sub_stack;
+			continue;
+		}
 		if (2 == sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX_STACK]))
 			continue;
 	}
 	while ((token = strtok_r(cnt++ ? NULL : stack, "+", &state))) {
-		if (sscanf(token, "%d", &sub_stack) == 0)
+		if (sscanf(token, "%ld", &sub_stack) == 0)
 			break;
 		s->stats[STACK] += sub_stack;
 	}
-- 
2.53.0

