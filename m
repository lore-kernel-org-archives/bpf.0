Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD3372EEE
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283449; cv=none; b=GftbcbRg67G6iycb98sj6fWY3wLa4FsbQtpkJILpP+0kTY0SjK9GF4/T7sn55ooEKquVr/1C3G+XvAfujpwQKm3+xjefz0lHt/LEba+/mDe4Hk/KUHrJfWKhZaWzkfjdDcoBo3+g+DImYKvDy7dHB3tHEKfwD4pkieqpBniwQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283449; c=relaxed/simple;
	bh=pggxb5klrCa31iAHEsZWCNSyt4ephJB6XKes0lC1k6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jELi/ezG8jB3umfJ0Gua0ZFdB/odEY7fL0wPsW24lA1P9B16SO5P4m1xlcB6oSM4QINFhSiZxn2BwPlYUOZtZBrKUN1gT+dthwk53sHPhRs2LwaQouWIbiLdARiBH062WTED+OTnXTig/N2YOTOeYKvvFycdxg6cmFV2SB6SCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeDwM3sS; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeDwM3sS"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128b9b7e3edso5837248c88.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776283447; x=1776888247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zru8FySz5AhiaWwf6Upr4P1h7py/Mu2zPj3hDHMgLYM=;
        b=KeDwM3sSWvoqGUN3z8vKEYD7sshy1bInB3SGaJwwyEaS7ytkc+3c5M8Xn2YRM1Slpf
         4yS+xLenEksNQJcKs6lrSjGanR6GiLAc8q8udKhKmgDGThWgs/mXs9zJuUD30Li+ZDjB
         JkdlV0HectmmyIlvxuevrTqfTq0gVVnHdlrgywR5gpB71Xr72JfINgbpnKOO+n4OzcPS
         W0C5m+OYxq20D3zfi7YdxrXjxMgbtI5/omEwj+yPM+XvuEsPWSQeyohuRPvaLFYZ2EYF
         bASphJ9DaXF8cIxvqaF6nyQHon7RpCQdXoP/o9lNZ63NEBHTNSpced8LcmtrQVwcMLsi
         xiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776283447; x=1776888247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zru8FySz5AhiaWwf6Upr4P1h7py/Mu2zPj3hDHMgLYM=;
        b=hrueyh6sLR+ZrBNBz2zbkzHhFxR5yZPGWplE0VA/Z5kv09x8ApYw1EhTYWMzbIbEru
         W3QwJKCQ5/7JzPEqUO4LFHby0+W+gTfHGIal3FPhzCelW3t2DJxJ0gL7YUbs4Suo4Jjm
         Lxn6bZlegWcrMWkTQyY7bvsDSQRDDr05z4bc/15EfLmD6OR1pfWcYj58lXFNdiv7QmW5
         ot2gb/UNA2YiaSWiW7tdnHhhxR/6ZZ5bEcG4u0+b/xVCRschL8h+NiYzJkyKlxKXXxxK
         B21eCASwKkJnrYbutjArfxAr1wJ4pmC5qaOBHTw5MIyTGmKKJpS8t9tdtrQYjhYWewL4
         Wv+w==
X-Gm-Message-State: AOJu0YydddZrfvRNu8verNU4HxqxC9m/sduQXiXkmE+lFDJZPCozsFmC
	6g4ITVlL3NX4jQ5IHmrExmBARLC79f/tvPjvztK59axezNH4to/mrS+4Xta0iCuA
X-Gm-Gg: AeBDievZ8lkDM1DlXYxEX/Zig3KVOfekuqgrEePT4OBN4idZJRy/ilJuHYfC5GA0g9m
	fFVKmxysCTubags4kOigP7flrkhRsdYe0N6O8wliJ8UWZwCs0KmQxXqTYgMbuR+CYZcyoUUCRfc
	5NnlmHfqe9yxBjs9ioYf9t+FNf7SachfyP8wvPfIUFatKuFNBC8fQSDgeGUObExgpmwM9E5efGY
	9BH1tAtARldKFv4C0jEf3LH0o/AYag1ayfKlKuvaw+3cOEww188o7NOkYjL9bu7Tj4Hs2JTA+FH
	hgtlfnab3EKMPeSe36nFjfhN4cX/cEKHJs5QtfYeVSMk0I00p2byAJ2h8kKMPuwRrQc89SCyaTv
	OtoGN8Fh8Otg9xpskjpQSX+jZkvuUJRaKNuE2zXP6NjPDgOGlYxoVdxMa6Aq9pg/jGBq8Pb1B4o
	UeqGT0OHYgpHHp0hIrFjeJs9gMEg29nR+OGtFHhhXg/tNSFwMt0HcQRbjKyLkk4Y16d2APjzJhz
	ILF
X-Received: by 2002:a05:7300:3212:b0:2d9:94b4:a1c7 with SMTP id 5a478bee46e88-2d994b4b427mr7598702eec.15.1776283446584;
        Wed, 15 Apr 2026 13:04:06 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c605851sm4163518eec.9.2026.04.15.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:04:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ctao@meta.com
Subject: [PATCH bpf-next v4 1/2] bpf: copy BPF token from main program to subprograms
Date: Wed, 15 Apr 2026 13:03:55 -0700
Message-ID: <20260415-subprog-token-fix-v4-1-9bd000e8b068@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415-subprog-token-fix-v4-0-9bd000e8b068@gmail.com>
References: <20260415-subprog-token-fix-v4-0-9bd000e8b068@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

bpf_jit_subprogs() copies various fields from the main program's aux to
each subprogram's aux, but omits the BPF token. This causes
bpf_prog_kallsyms_add() to fail for subprograms loaded via BPF token,
as bpf_token_capable() falls back to capable() in init_user_ns when
token is NULL.

Copy prog->aux->token to func[i]->aux->token so that subprograms
inherit the same capability delegation as the main program.

Fixes: d79a35497547 ("bpf: Consistently use BPF token throughout BPF verifier logic")
Signed-off-by: Tao Chen <ctao@meta.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/fixups.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 67c9b28767e1..dd00a680e4ea 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1110,6 +1110,7 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
+		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
 

-- 
2.53.0
