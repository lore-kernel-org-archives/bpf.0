Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89251347BDC
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472091; cv=none; b=mlJOsLeJDjSk/3OX02RC97W+ciVuT+8oUm1PI/ip2XE7cC6jK+ho2jX8es3Kg+6N/W/Kh8WBkPje2XL4+4343T/MD+ycIxzyRRgP9PNUPJyU/W50vwqGSmxArbQMTcsfwwZkovFhAkoCMpWeUzHaQOxURxYfotQMoS1dug1MgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472091; c=relaxed/simple;
	bh=eCoblO1wa9iyl/6H9+QTh1GDpRn8Bp6BkAtxW2LCWDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc8Kz5wXFyDeDmiUKUFLjVspxc7KJlVl/a+Ypy938bgfb9tK4Um1KDn+Htl5kaPRt0VDgndmOVezO2QbIomTfKSdAbG+enho8hydAYbw/OF3umdMYhEWvRt0rq8e6QlcjIYojwPmItbnbL71iqD1z5E5NBF/W3aerDIaePra9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzVniQcY; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzVniQcY"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso1019885e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472088; x=1789076888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhcALRh522ySN8nJme0Ri1s+5fOrKR0VvHZF7ZnRaxA=;
        b=fzVniQcY+r8ITJPi4LJYG/F/4qLbjSJIIwKS9rwXL+SfP1A9BLN1+aJ3mPeFqI8Nl0
         iOPSYiZb4mZKiniXINM3+inAN/d8in66qQQDdIyBg0MnfUui/8UykxbGDCv7nm3FZTQ+
         ieU8XL923bFeNBpqrpAk/JHT1HT/SUavnszFtehAIeXSEVdDCiMgtNzgNTLE4yjFXhff
         Iw7uBqmg2EvPbS1aVUe8ft9zD7/jXUOwc1CqBUD7cUAhhx895IezUOSeA1gq5owhceJI
         LAyzLFdnMDxMcShctwX5IuMCQZTqebO5Ci+Tijjt2adsdHGepKACE9vJM3oK6SIpScu1
         AtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472088; x=1789076888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhcALRh522ySN8nJme0Ri1s+5fOrKR0VvHZF7ZnRaxA=;
        b=arw96lhBeyEkFq0LZ0qpw923YtnjelUir3JAwoh+gFVstjokzr9nvO11TkKeBXeol+
         aR0/rkIVLxanJ0bC08heI9XHMqlYq2BFzGvM/Xz/gloGnawfnGwU9gK1V77f6P+YtzgR
         Gw3fMh6J++m8jIJ8Y+g5k6yld1ocUOqTBYl2tFTqXhiSScFdMNA8XZaFxgsOz9RheS0E
         T9rWvlpmpxb7xOyQ68uy36zH2cjmYYEVcrWMqtIYo7MPwjjP5ENPhxe3rqWTKrNyL9BL
         EAZQBHisHX7dUs2rW16GglOhBChEKanmygCnMAMLjDCAqh0WYOPXiOhMr0xYWzZCGiIZ
         2rdg==
X-Gm-Message-State: AFuF++lIQ/h8DuH06fQziKhz0YnN1K3kMqoSJjyeftZ12J11pdBFlq78
	NWjN3fJTDEQFjCAiuzJEDXQEJrqWhWExS64UFDOjlVOYGIdsyphywqj3TzJAo7Ms
X-Gm-Gg: AYBFou0iYblqeY8xZ8zi4IB5dfDlVH5kJdyeEgpF+IQWLxrXr98orjb4f6/FEbnkSX1
	SvH49xQjeNmbKV5sn9JUhHOyIhwp142SrwUYHd156UEaFd+GTMJHkIWbKZucqPIbD4tbh027Ig4
	dqxMmIraghptI+d/c+rBipit+m7c9RVJqDw4vP5cD2KlWZ2kCIWgAD2w6q4/asmCYVITD4XHf/F
	v3rcPHDb2ui3X19EfhVOkbaNXw6LhdgulapRkp0r/+TZ4WBiLEZxy8oOsrhohgHAFD3Prs9WKDp
	s3KEPlSYkFZ56+lTnvqUqL29cNDZaYfXhHmxJywFWfjZodvH0DE8tb6DT6zsRRyUAWMBf7F4Yjm
	/2yj9eGzfhKTWfTGKIBcW52Wp6GhFh1YKGVq3SIxHDKsVC9EBSivehRDSGTZ8lfYQSFuyx2om4n
	nK9yynkRUlbAiSehynSBpmRpyYjfSobHu9+aXt5sOoa9sf7a+VqqJtvki0+Hu0YyunuOxCRNDvi
	60+YNxfRr9hJcEJk74CZEJFRtyu+lhwZWJy10GH+fZMoMs2ki+pfDGRraCZrSouV2yIh7XPKJMX
	Bl0ZLRnDl44TTnAe/TL6ZaNXDc8=
X-Received: by 2002:a05:600c:6090:b0:49c:e3b1:d826 with SMTP id 5b1f17b1804b1-49cf825ab42mr15600895e9.13.1788472087373;
        Thu, 03 Sep 2026 14:48:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf771e9absm15606825e9.9.2026.09.03.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:48:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 5/8] bpf: Mark faultable stack helpers as sleepable
Date: Thu,  3 Sep 2026 23:47:51 +0200
Message-ID: <20260903214758.2727663-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903214758.2727663-1-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=memxor@gmail.com; h=from:subject; bh=eCoblO1wa9iyl/6H9+QTh1GDpRn8Bp6BkAtxW2LCWDg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvma1bBb23P/JbcV179+Eu1SVoCx8bTZ3M4N0+66jfl/ ZodLgaTO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRCB5Ghg1hjtbflCec3nZC /gSTXfvazJ0OAr3/ODZEmu6xjOD7foCR4W02/zOdtlKnZZJVJses05QKn07bkup6VKpAuIBRndm IHQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The faultable variants of bpf_get_stack() and bpf_get_task_stack() pass
may_fault=true into the common stack collection code. Resolving user-space
build IDs may then call build_id_parse_file() and block on filesystem
reads.

Neither helper prototype sets might_sleep. Since prototype selection uses
the sleepability of the whole program, the verifier can still allow these
helpers from a non-sleepable region within that program, such as an
explicit RCU or preemption-disabled region. The task-stack helper can also
be called from a non-sleepable timer callback of a sleepable program.

Mark both faultable prototypes as sleepable. The existing helper context
check then rejects these calls while continuing to allow them in genuinely
sleepable contexts.

Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/stackmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index a839041e0d00..d09d4c3fe547 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -875,6 +875,7 @@ BPF_CALL_4(bpf_get_stack_sleepable, struct pt_regs *, regs, void *, buf, u32, si
 const struct bpf_func_proto bpf_get_stack_sleepable_proto = {
 	.func		= bpf_get_stack_sleepable,
 	.gpl_only	= true,
+	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
@@ -928,6 +929,7 @@ BPF_CALL_4(bpf_get_task_stack_sleepable, struct task_struct *, task, void *, buf
 const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
 	.func		= bpf_get_task_stack_sleepable,
 	.gpl_only	= false,
+	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
-- 
2.53.0

