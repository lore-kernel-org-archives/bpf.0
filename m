Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516A3438B2
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728877; cv=none; b=AuXhBNUiVMVI8R04c4jU3p3hQeQcmosh5Ubus9HA0mhxo9m478mY43Lz9Mzuy1FxocbFMTila5uG3EyigYqwOJlH2foKizunwRaMlzr8Dzw79kI4DaOlFUegHwr/FvdUcaGXLfSLdq40mkh6IrgZvlLx95vU/FM4kJN4rd06FYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728877; c=relaxed/simple;
	bh=XvVl5mjflIv3UtJ8KZ2CpGKOS7tfRL7wakHrEfbOmYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i424tvqym3pkNQqS99BHvGthQ+7D+PCXTU1SSZrdpbpqo68+pTlPAb2osu8vvQnpyagTrelQyZYr0NojuTBfqcJidZS58ovLgWDi5zWMWjxgV8AWWCHwRzbe3NydWzwU3Zl5wVZxBrNd0nTAAicpMV0sVPLgZnn0/in4jgA4rYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEarH/fk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEarH/fk"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so7482705b3a.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728874; x=1785333674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZEjjn0vc5h6Klfz50Xi3OPenrjoSwnSYbs/Qn95SwQM=;
        b=NEarH/fk0a/bhzHN/l+ixz/cCRwCV6iqTMYLltQPeoDh8C0E20EN0EUdeTzxmGP+uy
         /WvZ+9HZsAjVV61hkwMVqntKqEKVzqMkSMMWfqoP7lCUMmskEVwBvDzrDIqkF8+Yrb8Z
         AdrqAEKmqZO5z1L3ln3CmO+WdgFfYeusGYe55pqnuushnn2zcZIY8/O/auD/9ZF2VQoL
         1euhfHYmPW+xcw2Kx+hvs2/Izy7/LKMOO3gfTCSkuMPveQyXsWmbRT/LpbMsHpBV+iIz
         zyCxEt//W66H4KedZqEZPTnmtjfz1PyR6WUILY+Lih1pIeXlSYvr6yFQcUvFB0J2EYON
         RvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728874; x=1785333674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZEjjn0vc5h6Klfz50Xi3OPenrjoSwnSYbs/Qn95SwQM=;
        b=FbHXmiqLXUIOZjIsdBG7eOfHS8plBLKdIcxTJGGuo43oW2tb31x/ZFRCxO0Kva3yZF
         YXVLeASwgqnW8w/HyQp0WBOXdEAoI4CSW1Wig3qIQ2rEiE+4zRBinSxucz07Jamngv58
         UCTCSgH92Pe1oNAqyg9zBkN9lRHuYHl7ON8gewMMO7ncPZMjRWQp5RgtHWVCbU4gJ35k
         vLY7j0oIFD1dNazc0paMHmLQpCefXZcghTxlnQaw0a2KnjbAMdnQaMylEwcypK7qlNfg
         RW7pv+SGMHjOfzuyymS8eAQ9UYb6/VsDktiM3fW/E69gYeIBTh0CUvbFPgIW43mvZ4yC
         ik+A==
X-Forwarded-Encrypted: i=1; AHgh+Rq8qYd20H4Gi8LnB2FyVyRvlUVVDpqiqnd+7OOk1zR/8cZTXJwClk+EEWk1W5QUtL/0H68=@vger.kernel.org
X-Gm-Message-State: AOJu0YycLYSUyRQnqVnRpcza6c29loYNVNZGR4HXYIWGrcX1F3e42q/1
	DR/QbBSJNFU1pznY/kTs1S8y3xoTpnXZpTkbcuvyR3ZLRrY3xzYaYsM0
X-Gm-Gg: AR+sD11X2GbPNjCUFTSYZ6K9AAyNX+3Q4mletNHkOwl9MO4cLrqGd4t2/430aLAtUjd
	Ky11YmATLngQn5ZIjrZ6Vc81+PvVeofYGZES1rvKk7vkq9M65SOO73yyt2numRxhjb4inSKknFc
	AjHb7XXWy0uxSXouWoHZi2gop5B6m3+KmovHJwpX+3VvzzMtsk1lN3qTMtnudEO0eDUjJkoJrM1
	MhdvDiUlGLJgwM8UG5QaLeNYs3qs+oalIrEBq3+9+65a0LZ12ysqJEpfjO2R9EH2FG+ITHUbxE8
	qDb7jFgGse9lSmTOIwNzRlh76I0DY+7T66fZVPdWLjYy3Ri9+/E1Mob9KpUz6aHWYOFvgAnb7Ln
	sbdRJz7wrCAvNU0Gr28JW8rsTSJ9ZuZa7KKEc1wvfvXoq4ehfa0/9vlOib1BFMpYFIKO18SQY0D
	1nLs9R0UE8iDzvTJRhonmxKUwiZNsM3l9kQImSfFIL/5jQlVI=
X-Received: by 2002:a05:6a20:3ca3:b0:3c3:7ecd:72df with SMTP id adf61e73a8af0-3c3ad86ab89mr26184446637.30.1784728873939;
        Wed, 22 Jul 2026 07:01:13 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:277d::3ef:c9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1a8a1fsm1242281a12.26.2026.07.22.07.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:01:13 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org,
	pulehui@huawei.com
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v3 3/6] riscv, stacktrace: Implement arch_bpf_stack_walk() for BPF
Date: Wed, 22 Jul 2026 19:30:10 +0530
Message-ID: <20260722140015.1982158-4-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722140015.1982158-1-varunrmallya@gmail.com>
References: <20260722140015.1982158-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used by bpf_throw() to unwind till the program marked as
exception boundary and run the exception callback with the stack of the
main program.
This is a wrapper around walk_stackframe(), which now passes (pc, sp and
fp) to it's consume callback.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 arch/riscv/kernel/stacktrace.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 30b369dd2815..c0f2393e5163 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/filter.h>
 #include <linux/kallsyms.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -104,6 +105,30 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+struct bpf_unwind_consume_entry_data {
+	bool (*consume_entry)(void *cookie, u64 ip, u64 sp, u64 fp);
+	void *cookie;
+};
+
+static bool bpf_unwind_consume_entry(void *arg, unsigned long pc,
+				     unsigned long sp, unsigned long fp)
+{
+	struct bpf_unwind_consume_entry_data *data = arg;
+
+	return data->consume_entry(data->cookie, pc, sp, fp);
+}
+
+void notrace arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp),
+				 void *cookie)
+{
+	struct bpf_unwind_consume_entry_data data = {
+		.consume_entry = consume_fn,
+		.cookie = cookie,
+	};
+
+	walk_stackframe(current, NULL, bpf_unwind_consume_entry, &data);
+}
+
 #else /* !CONFIG_FRAME_POINTER */
 
 void notrace walk_stackframe(struct task_struct *task,
-- 
2.55.0

