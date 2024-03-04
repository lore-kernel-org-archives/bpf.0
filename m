Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F97C089
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592732; cv=none; b=TQs3wulks757C7C4ppPqsfJ7QwhcI2SBm8kN4HBF1LoOA6ospiLT936AlEO3B/sZTvVJ3E210U5v3Xsa0azApi8dr8Vq2Uew+wxaB6QuERwerCYSIUYbI6ONueKx624Z3N4uZ4n0hCkqJ2R/w5JYDfOS529N3hDPJbxvDxW/uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592732; c=relaxed/simple;
	bh=7n3VOltWg2CvMWA84SRE1wH3LRcYRxUITz9dnx52KQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQTh/xHWkH7xohYMyXjwFatPeN8k6x/aM0U6zzP0OOc/NAZEDKR4HlUymMgT9DoJdCqk+1QP7QWxUM6O3Id5rlLNch6LLJuRASj+kRlq/YTW8V4aOSlRYCZmF8woK3qz2Djs7pjDzKGiMtuIIflGFZX29OXJbQ2v8eR5hELeqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqtOv5PT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqtOv5PT"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a449c5411e1so453822966b.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592729; x=1710197529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v11JrOpQ0vOwRfRtr1r+yvwVR9OS5PTJrump/SfFJRM=;
        b=FqtOv5PTru2tCO224rSDU0hNu3YsjuF5T5iFUZLOtVIaXaivbdnHACZeSY1WFo3stI
         KbOXuBCJqRlLZ4kFgsYIwHZc6ENfxJXN7hleukHy360UUkihTlJSCRT+ECcV87KYga7t
         CGlQjicoSsYE0JvgP+hyaczIKwW6oQ46GbrUTbxhApbdsDkK7cvMPiGBF+eeUlxQXeoQ
         Omf+CSr/vPvyFB69S8aLGtULiGeGIoJIx7h3nIKJS9KoWcYPcwfxcapPueR80ey0b3bG
         uqUEezCnno4e+cw6FPC5aJY7Gwor0/b1rmcDbYTnWFlrTQghQ74uTlpklQrVXvLQXH31
         qPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592729; x=1710197529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v11JrOpQ0vOwRfRtr1r+yvwVR9OS5PTJrump/SfFJRM=;
        b=ljri8ZZegJ87M1UwoqigLmNd/AVvcF53uePerIRD8yeBQJ9OW8sAnwfTf9PZEOfo+9
         0o5jGUSS/wR1PodgMqsQIrdOf6gHHbTa6+xyYmrOnly5OyxuZX/tRsCMK7PtPkv39Uxi
         IiJ60XaE832y+GTd3JrGdbI4NRZhKxa37jrnv+PhdqlYrcAvvJ8JUeRWVdt48I5my6FZ
         ZA6pa02vjmnwMXDO/DPWkhHtJ8neElpvwyN/2qccBtWUCvwZqkyieHl0fagAAzvgVWEN
         b/oZyW3ZzLsTKqHtM6ORCyGPCJNCfP/YzoML3lZfwzd1NAbLpaydIVjy459ArA0vQKDS
         KleQ==
X-Gm-Message-State: AOJu0Yxscg5Z/2jK1+TemzBQkNDp4I/rj1gJiJjHrOQ/CN1/aASi3Qn/
	5+6Ab6fCb2L6TfNDZinbw/WI0sNSR0imajQruOaZRKXkXTDU/xzOr86lmxtN
X-Google-Smtp-Source: AGHT+IHsuQtxvXmASDXywZrAG1WDaOMVVkRcxbdOFBNOdfRGUpVFzComBJihgNvo3S6lFag/z10kwQ==
X-Received: by 2002:a17:906:e08d:b0:a44:731c:bace with SMTP id gh13-20020a170906e08d00b00a44731cbacemr7592179ejb.35.1709592729121;
        Mon, 04 Mar 2024 14:52:09 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:08 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 02/15] libbpf: tie struct_ops programs to kernel BTF ids, not to local ids
Date: Tue,  5 Mar 2024 00:51:43 +0200
Message-ID: <20240304225156.24765-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304225156.24765-1-eddyz87@gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enforce the following existing limitation on struct_ops programs based
on kernel BTF id instead of program-local BTF id:

    struct_ops BPF prog can be re-used between multiple .struct_ops &
    .struct_ops.link as long as it's the same struct_ops struct
    definition and the same function pointer field

This allows reusing same BPF program for versioned struct_ops map
definitions, e.g.:

    SEC("struct_ops/test")
    int BPF_PROG(foo) { ... }

    struct some_ops___v1 { int (*test)(void); };
    struct some_ops___v2 { int (*test)(void); };

    SEC(".struct_ops.link") struct some_ops___v1 a = { .test = foo }
    SEC(".struct_ops.link") struct some_ops___v2 b = { .test = foo }

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 49 ++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e2a4c409980b..2c0cb72bc7a4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1146,8 +1146,32 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 
 			if (mod_btf)
 				prog->attach_btf_obj_fd = mod_btf->fd;
-			prog->attach_btf_id = kern_type_id;
-			prog->expected_attach_type = kern_member_idx;
+
+			/* if we haven't yet processed this BPF program, record proper
+			 * attach_btf_id and member_idx
+			 */
+			if (!prog->attach_btf_id) {
+				prog->attach_btf_id = kern_type_id;
+				prog->expected_attach_type = kern_member_idx;
+			}
+
+			/* struct_ops BPF prog can be re-used between multiple
+			 * .struct_ops & .struct_ops.link as long as it's the
+			 * same struct_ops struct definition and the same
+			 * function pointer field
+			 */
+			if (prog->attach_btf_id != kern_type_id) {
+				pr_warn("struct_ops init_kern %s func ptr %s: invalid reuse of prog %s in sec %s with type %u: attach_btf_id %u != kern_type_id %u\n",
+					map->name, mname, prog->name, prog->sec_name, prog->type,
+					prog->attach_btf_id, kern_type_id);
+				return -EINVAL;
+			}
+			if (prog->expected_attach_type != kern_member_idx) {
+				pr_warn("struct_ops init_kern %s func ptr %s: invalid reuse of prog %s in sec %s with type %u: expected_attach_type %u != kern_member_idx %u\n",
+					map->name, mname, prog->name, prog->sec_name, prog->type,
+					prog->expected_attach_type, kern_member_idx);
+				return -EINVAL;
+			}
 
 			st_ops->kern_func_off[i] = kern_data_off + kern_moff;
 
@@ -9428,27 +9452,6 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}
 
-		/* if we haven't yet processed this BPF program, record proper
-		 * attach_btf_id and member_idx
-		 */
-		if (!prog->attach_btf_id) {
-			prog->attach_btf_id = st_ops->type_id;
-			prog->expected_attach_type = member_idx;
-		}
-
-		/* struct_ops BPF prog can be re-used between multiple
-		 * .struct_ops & .struct_ops.link as long as it's the
-		 * same struct_ops struct definition and the same
-		 * function pointer field
-		 */
-		if (prog->attach_btf_id != st_ops->type_id ||
-		    prog->expected_attach_type != member_idx) {
-			pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u for func ptr %s\n",
-				map->name, prog->name, prog->sec_name, prog->type,
-				prog->attach_btf_id, prog->expected_attach_type, name);
-			return -EINVAL;
-		}
-
 		st_ops->progs[member_idx] = prog;
 
 		/* st_ops->data will be exposed to users, being returned by
-- 
2.43.0

