Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650445;
	b=w3wfi6B25cm01ZnzCC7tGC5yKfU3TANtPVHWuz+hX8Mw9KgTKOyjTZa9UVjcy/N1rg8f
	 Yb3xYCWdwJ4/J8KV1OWmw06dG1XF2f3Frx6ZIzrYq238KF3ByIjuV/xeL5cGgO1cLCH3o
	 uMwBLNdFqTJQumxySxEzMmD2x47RivgXP2vQ0Mc3dimA9jIzErILfpLKYlhqWK2Rsl9Nu
	 6vv86ViGmQaW+1lYAvgyi+kU9bssIrrqhRVdia0qAOzHCCp74JA39Ori5ZozLJqierHbs
	 gTKBjdlnTpPaavMmO5tASFojHlX7Z42ZPChV7IqdQJm9p60ZS270gd3wU39li9yNFrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MlxGrO4qVY13JT+narJGH0GFq85Jy87gUAILKXGl+Ms=;
	b=eo7pKW8f0Y8N/dU6VH4BzwYXJy9MrMjk6egXg7YpMLzjUhQLbYw5TelHiG13lMC8rk/y
	 iyBJhQqrY117Y9BpEfIcvnUswowZnuk55lpPgfaPVU8KyN9iZNcK0jcDG3fX5Oc6HC/0N
	 KzJsqtkmtniDRFXI4zj994EdzgVnH5eyVAEuHkIbUAkj711e/sRHdGEinDYecEbBec7LG
	 6C1eoqFtI6JIfBax2KN5dyFPHlyhAovw01Qqod8/dJBED5qFRJaaptEa0PTzovvRosib+
	 ffcCqYQahUulVXdo1TNsQZrXwR/pH1vdzo5I4wbq6bpHDnFFQB3CEeDwqMBNSjT8CVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qx8587wx;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8E606A334
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 20:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2D8E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qx8587wx
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso1362734f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 12:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793650443; x=1794255243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlxGrO4qVY13JT+narJGH0GFq85Jy87gUAILKXGl+Ms=;
        b=Qx8587wxxbR22BoOvIwqG8mbTtcPopxfea//1XQLP4IJcVMnHNo5IfbPTzhs/JRkt/
         Qb9b0N1mMt3ctF7j/LteVwQqMUgbMnpFJUUoBnrW9+N8c6pd9KEdB1CKlk7FH7fBffnI
         yOFdNrnInbc5nGWNZq6NPmHX3XN/FTZNnJG2EQzFrPDs45KFrKjJFM9F4uqG33fIJ4Gl
         qRbu88baVzNcrNBTDz9de2+wmIfqLbNqWxtimMAYBLx8EYt/afzmuqytEjFXjg7t7oRo
         FoqsbEq107BBV1xiob+8M29o2OjzRSEqIOOQiLlyoLO8wc2GhPRGl4qfp93c9lWnbBdq
         4E9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650443; x=1794255243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlxGrO4qVY13JT+narJGH0GFq85Jy87gUAILKXGl+Ms=;
        b=OddYXjyAfAXCilXIelX4+No+WhyEXI356gB3MD2sgbjKY3TtG5Yoo7KBLI5Hp2twp6
         KbEcEf8c8y8EeeMO0rL6jT6B9Iv28H81xKp52L04/Z1eNQ+c8+DqDBwbfVz1kzn5+blx
         QtJ0fl5g6ZL3aRqqjX5a3Ks3Xq1jExePDu38nCXxMEP4ng9Gwh0vGqIHlSbPQGHkpFXy
         B8VPaGmJa/fj0p3YOjJ85fxgfOt7Gp7eO/h7qt8uaiKfii0FJtgZ1CeTtJRulghPmkBa
         Nu+dpvCTM2noF/J0r5GCg/cVrZVkSPOlL2BblbEJLfQfquYS29cTkt6pnwTmemlOdBk0
         IGSA==
X-Gm-Message-State: APuU4Z+OzN7/Gi110CasU3ys6/gY/hlnDkQvxpPdGzGe4N8njR4HvLUD
	Nc8O2MVQFrgJz4kbDmjcQn4/JEJa8MQdYfRzAox+rJTRsUosw2hBMR69j5Vtsgp5wCF3Mg==
X-Gm-Gg: AYBFou0Ja4YnLzpNtPciqVX8GHTsiTbFKFUcmYpfhZUulUUWB3aTmD4+13ZFVntfO9C
	DulCIgTFp1zrLfTuP82gjEcwU34LmprUgUa0lqPdNBIW8fGFduVhQcRFHkXB/4+EcVjvjB4KYF8
	u613txi+55EiCkX7WfEySiiMcNRLw25/1TR2uWuby1wtQW5uMnrWT6y2SedY2p0/fWKvuHyy5RG
	v1tTtMv6EqVZmFZMvkrRBTLYodvfhYGMwXOkv/81sH9QyfwyctVIAMyIQhfdDe13GnDzI6qhy0J
	tKCiSUd7UgUiGjnW8sp472M9meIR0vq7MQ3J9KDydN90pfpyvwM+S3poCpOqfOyJRxbpU5kU15X
	WPrsuSGsBJTw4g0RlePdkGzFLs4pxh+niX+aDdhbllk9qt3CVBMWWNSEbJdkplThHy8H46QxnnI
	9uEy9NBITEUMQ8y1ZkfXVziIHOKv+Chx+zJUHrHOprBMt5izWLHi3e8JG51brz/DW7jgohSSC9j
	WCNX5k2wolXyzrg7X1Fj6EInYiw/rV9qB0tuZOks5EFrIUtS4tl39bvtEPueCyxddeoNXSDqefQ
	4pSbrRh1boz1/q5/I1tyz5g5AsxiMZlePRPfonn6m8ujCd58JQDPPGtOjls5klXFojuqzI+PPD5
	1
X-Received: by 2002:a05:6000:2c03:b0:48d:f034:7fcd with SMTP id ffacd0b85a97d-48e6e4fca93mr23474451f8f.51.1793650443196;
        Mon, 02 Nov 2026 12:14:03 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm21471805f8f.43.2026.11.02.12.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:14:02 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Tianyi Chen <hi@tychen.cc>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Hui Su <sh_def@163.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 1/5] libbpf: Count entry programs for bpf_gen__init()
Date: Mon,  2 Nov 2026 20:13:52 +0000
Message-ID: <20261102201356.5798-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201356.5798-1-mahe.tardy@gmail.com>
References: <20261102201356.5798-1-mahe.tardy@gmail.com>
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

Commit '259172bb6514 ("libbpf: Fix gen_loader assumption on number of
programs.")' explicitly mention that we may pass a higher number of
progs because we include subprogs and autoload=false to bpf_gen__init()
generating a bigger cleanup section which is harmless.

This is in preparation for the next commits that will introduce cleanup
of the link_fds to bpf_gen__init(). We don't want to overallocate but
have the correct count of progs in this situation so that the
program-slot count matches the programs exposed by the skeleton.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 tools/lib/bpf/libbpf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 02e75b183ed0..a7cbe7204043 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9800,7 +9800,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	 * permit cross-endian creation of "light skeleton".
 	 */
 	if (obj->gen_loader) {
-		int nr_func_ptr_maps = 0, nr_progs = 0, i;
+		int nr_func_ptr_maps = 0, nr_progs = 0, nr_obj_progs = 0, i;
 		bool text_has_callx = false;

 		/*
@@ -9815,13 +9815,16 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			if (prog_is_subprog(obj, &obj->programs[i]) &&
 			    prog_has_callx(&obj->programs[i]))
 				text_has_callx = true;
-		for (i = 0; i < obj->nr_programs; i++)
+		for (i = 0; i < obj->nr_programs; i++) {
+			if (prog_is_subprog(obj, &obj->programs[i]))
+				continue;
+			nr_obj_progs++;
 			if (obj->programs[i].load_strategy != BPF_PROG_LOAD_STRATEGY_DISABLED &&
-			    !prog_is_subprog(obj, &obj->programs[i]) &&
 			    (text_has_callx || prog_has_callx(&obj->programs[i])))
 				nr_progs++;
+		}
 		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
-			      obj->nr_programs, obj->nr_maps, nr_func_ptr_maps * nr_progs);
+			      nr_obj_progs, obj->nr_maps, nr_func_ptr_maps * nr_progs);
 	} else if (!is_native_endianness(obj)) {
 		pr_warn("object '%s': loading non-native endianness is unsupported\n", obj->name);
 		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
--
2.43.0

