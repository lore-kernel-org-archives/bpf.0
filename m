Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973A335BBB
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503818; cv=none; b=igsy+10fYQbxZufsei6E2wC0AtxFgsNy8FlZ+tNMh6ZvrH69Midx1mTwosA+jaRXPuf8X8jqhgPDs2/40I0dkshDgEK965b+3kqeWsJyZRHf530GUeQh43V1qNjjgtD9sfCna5X2HmEcll5u6nbnxLRgzix8Sy/dWMjnLeb/ecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503818; c=relaxed/simple;
	bh=G+mdTUEGAA7xgXEbrkxxlO3xp4/Jk0J+MKGwOR8O2kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv10gHr/JvL4eiJuZtpSCuFOxh1PnH+L2onr7zc9XjLeqo7dkoTfbHiS9LElnQgQoHZd/WAPx5j2l7I5ShH0RVjTw6xb5JbX2DgyKcRn1zqP+uYpKpX4RsnZ/Y0QO87ve+o047Lgpfaiimua5MDGzPqxGrlEjT2EobnA64MD81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYlyCL7R; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYlyCL7R"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-483960225ccso170382f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503814; x=1789108614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilTIJSDOzbohGvPfWloWUC6lqM/w4si9TaieoULKGr8=;
        b=SYlyCL7RqkbRKaWJrjZMdKT6zw0H4AM4KJ7TtL60xeXmkhd4S/gbQAwxCX6W9deoUo
         fwCx/rIyAuLtx/Ic32f2RvRoKv5QuE2ZE9W3CZqwv//1NEjeBBauHkhT2Zhrm1nhvYZa
         kay/rnQahXI9+D5cspoXslhlRhqMca27hG6NVKD6kPBRRMz6LWTj8taH1ZO+5EYgN4Mq
         opexNoFS4FI4jvtyC7DRUzJHB4wCVQBq/j2IPH6yla/ye500yLQ/F/TpoMn3sy0pkZRr
         gVgoj555v6zMmiNGaJG2HFNBlIGpZVV3t+34+qjlF7RIsSQDz2Bz4Zc3GQyCJiVAlRZm
         6CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503814; x=1789108614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ilTIJSDOzbohGvPfWloWUC6lqM/w4si9TaieoULKGr8=;
        b=RkcKleF6FeEkswY4y21VuJ8lYpKoqIg/RvS6+8rS52LZTgmO4ib+hLxh7qBjrgYO3t
         m//nWNGRu8l/drGEwBIWaU+LDzKpIPZdQgbqNtBn75qNOiLB+XlCAD6Jaaz4zCdHvQy9
         bkRfW/qRWcwLt2qr6gNZRW+E8HyYib4jk7dgv/3OukDQtMZpQ3BBuewbRxy4uypbqsaO
         g2iguwECXkPNuk8n77BAx9rgmjtfATMEpBJzSCiklqsiaUTIpIMsxOpbAXk0I90zl9eU
         ozwu/cp4VpIn8ZESeS1X1RLk8C2TG19zJDecJZH8IAEKFg1jHrh9RtKcsg8nqpNL8mpC
         sWJQ==
X-Gm-Message-State: AFuF++k6MSGHZWatmQIEWZ57GIH3BNbx8oopTOLm4Ku8e4+3AaCRoHh+
	wA5y3iM6R2UsYyJj70OfbxbLOvqnMU4648r2j3l6DdDuVdGP09ouVtZKUI0KiL2e
X-Gm-Gg: AYBFou1J5jJKxJLfm2hnoeyMA2KME3iWsJvN9sSAwdg2iNFMr6xTSXpNmv70A0uiVGn
	E69i6evAB0hVgTzHGMkoTpvYE44ZJmnYaooYAJyTJ/ZGSoXFmSgxtuQ2d0MqS1efGyeeNBxG39F
	3UXJDfLMdI3L7JtjPDkc17iyynvMVfNV0rrMIDLbrBK2gNAosFty/pxziVd/eBbNzfHMMaECCCz
	zqyBIJ19iYs4p5OhR4ik0mscC3gp50cOCYZpVzgKiPxY+ZxGxgW7SLsqlVwyLd/Bd4YAq930TwE
	vZqP073Emzo/M/plha3rg2gYqEZ/hbdEfoTMAeDnkzrL9dbPT/BQAnBIKip8ph9OZlr0ZWsnvKr
	mGGM40NQaUMLrcR+fxbzhG77j0NXvENFpsR7JiobLNoJg1bNz3O+1mPBbILIX9umOMm0jNM8GQN
	m4h/zhvo+87mGYNWO4sXVi+t9magTr1Z1yTDhcL6oBZ2FHAU3scDHN7kkIOYjIBbfkmNNLqOo0m
	TYImHzxOk78uc0m4N9sSkMODDnGl5LaJqpXG51+JlIMmYgUL8LBd8zuoBhim0EeqUF5zdqJuXkV
	INemK8W0uDOThpDPO13zcD4xTrU=
X-Received: by 2002:a05:6000:993:b0:485:847f:fd7d with SMTP id ffacd0b85a97d-485872d5061mr5023436f8f.24.1788503813537;
        Thu, 03 Sep 2026 23:36:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm4053784f8f.8.2026.09.03.23.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:36:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/8] bpf: Require MEM_PERCPU for percpu kptr stores
Date: Fri,  4 Sep 2026 08:36:39 +0200
Message-ID: <20260904063650.3877826-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904063650.3877826-1-memxor@gmail.com>
References: <20260904063650.3877826-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954; i=memxor@gmail.com; h=from:subject; bh=G+mdTUEGAA7xgXEbrkxxlO3xp4/Jk0J+MKGwOR8O2kQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtW2kXjjKRo/8S/0ly3a/jXbyrf8MKW+/iu3Gs+JiH7G 5RZMx92lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIVKQz/TPPX5S7JWeXCm9Ik nKNrtogpty/yjOFO7gO/Xlhl3ytoYWTY+qRC8l2z+H6ehOaSR523Wriv2l5xuc8v+FtaRds5zZ8 DAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

map_kptr_match_type() treats perm_flags as the set of register type flags
that a kptr field permits. Adding MEM_PERCPU to that set for
BPF_KPTR_PERCPU does not require the source register to carry it, however.
The subset test consequently accepts both a plain bpf_obj_new() allocation
and a referenced kernel pointer into a __percpu_kptr map field.

Loads from the field are always marked MEM_PERCPU. Consumers then treat the
stored value as the cookie returned by bpf_percpu_obj_new(): per-CPU pointer
helpers relocate it, and map teardown selects the per-CPU free path. A plain
allocation can therefore provide an arbitrary kernel read/write, while a
kernel pointer can be relocated into an invalid address or sent through a
missing destructor.

Require the source MEM_PERCPU flag to match the destination field kind.
This preserves valid bpf_percpu_obj_new() stores and rejects both the
program-BTF and kernel-BTF variants.

Fixes: 36d8bdf75a93 ("bpf: Add alloc/xchg/direct_access support for local percpu kptr")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d7dd0befbd10..68353aa61fa1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4488,6 +4488,13 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	if (type_flag(reg->type) & ~perm_flags)
 		goto bad_type;
 
+	/*
+	 * A BPF_KPTR_PERCPU field is read back as MEM_PERCPU, so the value
+	 * stored in it must carry the same flag.
+	 */
+	if ((kptr_field->type == BPF_KPTR_PERCPU) != !!(reg->type & MEM_PERCPU))
+		goto bad_type;
+
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
 	reg_name = btf_type_name(reg->btf, reg->btf_id);
 
-- 
2.53.0

