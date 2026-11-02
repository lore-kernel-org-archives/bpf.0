Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648515;
	b=gq1VAA+VA9qKm4rTWfqFHOPOCxyjvDGi8yhCnIRWimueICABnVM6iLQZqE+tLKaT5iFe
	 8S3Df4RPMZK7riweXgIiRPjISoOF7F0+sSp8S/MwZtHp3qvEb2PJEYYxDas2se86noSP5
	 EaAK8crKTTMRGyQTS9wOfJJBhDdx2WzNSpQL7ukZ+7PB5WkVxCmIVbWB9pTZO4tTSqbV7
	 LjlCBO2aU2CMmf6d4LfJalzsTmxq5UK0qYa4UF+GmwDBuZ7CotRGq8NcsBfztO9ackujD
	 RNsuRt0IQfNmEnwqUYaZjIsp6r3ZHkpGS0XG6QPpVHJf2l5TuPVwFrrJW/7IEvaJETA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MlxGrO4qVY13JT+narJGH0GFq85Jy87gUAILKXGl+Ms=;
	b=fkmg+oKl/5Zibl6GDQYtynfL1Ziw5daKQhQXJdGa/U+HPDC5R/rrpZlN6eS0UEZ2GKxY
	 IzdVkgMuJChf+qWbVKAujsEzWx7wgcwxJetRQY5+sxIIN23HV4ewsbz9P6e+bQiOXVhe8
	 T32AgJxrIO6tWOzNFAw3lYCiqAUFsI4pRl3sPGwyr89VWeFMWRlsbbDj9aIEbDhsnZhFK
	 pwJczjmMN4QhvX2x4kc/0L3loQAP33AyLb6ST+/tPEiubxbB926VGuoQEkKzq1y3Ba7yc
	 zAlcc476Wu9ZWB62ySpdK8pEyksgtksTjX+ZpalNzFU4uSzK6DGYj/gL2Ve4tARG29w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QcDzCNWM;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4A606A339
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E4A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QcDzCNWM
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so20759045e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648513; x=1794253313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlxGrO4qVY13JT+narJGH0GFq85Jy87gUAILKXGl+Ms=;
        b=QcDzCNWMmAKVwvWckR04y20Nz6TYmmXMX2PW1oRXh4Tpc+tUqtSLgJpckrGxox0rup
         CLJYVKN8T8hcDixLwoHS0jKNBKVVF0MTwbBtxuA5sIsqNM6RuJeRKelGVY5pYVwH+4Ei
         y9JA/06g/3TS7/Fk4Pw+XAYR4TivKripWnddFnln0FoaZ1QtSlhqRcTo7CupZDm0OAEs
         RfzAxsT+B+/kS8SBeAJqGuT0ZNeRFFu0Hnt3bhOcR1FeQTWdub1qco5DPLj7TcSyhuVt
         YIzvoBOAzBj44pOPTgceTzl3aP+F8LeRDVjJoUTaF7da2uTX2Oycb9rKGO6SSoageuW6
         cgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648513; x=1794253313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlxGrO4qVY13JT+narJGH0GFq85Jy87gUAILKXGl+Ms=;
        b=r1u+4k2y8fruyzs46FXuSYGUpHVeGY1uc8faa8zEvbBAXxrXkmjPAcaK3cSYNUxylo
         mcyDGzkJXWmczMwMii4YvtzPqnz5bQI6QynnLu5NzmgfglIq/dgMZf4vRYnjYxYgCtWJ
         MPjfHs6D3h2VbONRnoYCnLfXLiOyyGRSZjOhzzEUJu3pnvx1WossU3PZa8oPiFVSPj1o
         rN2dszpMNwDyVwQNhJ3XiBZXr1dyGukFZlEWUC8GNigYOnoDuKOlmFPDrzurH0TFAITv
         um/4end8GswqxlkwB0gGL5as2EaSa8FGpGVRFgdbKklvXB8g7+5cw2G3/zZUjVwsXFC8
         LkRA==
X-Gm-Message-State: AFq9FYLv7VLkSbqLVvWC+GG4DEr46jOo6gOIhPXNX1laZvLTpoms9pPL
	VQGMM+RRs2xUQy4JqXz1m3i1d6cTXV2vPEX8kPGTMQs0kuIlzsLcD5/+QP/yoD/Vr1Q/vA==
X-Gm-Gg: AYBFou3CCTPKfMoM0WktsUuehdhYYn1fNAKa47fmVwfsHq2RI0UCDkN7O8O+N6N0Yp4
	//Qpv1ODDtxxqg/MmU/eT6R3PUBjdMl46Yuaj5J1OP3UUHpI0YhFjZUSkcY9aHyIdAZqIfdgtBY
	KUnaQnsj+wE+u2FB0jP6jftGmY4tkcCCFfp2vJdKqnLMhhPOstBrWc2rcDfMOA4ca4RAsjKWU/T
	jsBw2jg5b6oUS1wAgQ2sRFJNVmvVsNmHgDDX2Zbs3nN9dG58W52/LlgjJv0h1Ni+x94NA6NlT8L
	r/HSB1Sn0KHFraIZNEsMYqAYhZu4QKmn8Y2ddtR3NBNNAmWM5q5AJDtsaOsl+gI/PRulCXDJT+z
	0xsTO1D2a95IRfJyh05aKe14Nlu/fSMDv0dkHLPUipJeAiWHvC9UyQGpjpFU2P7kDypPiZczNeM
	3waNzQYoYuB5Rz4F+8MnR9favbGI/ehBOQRXUf/K1pH/YjXXGNOfQTtEFv+bSRudWsIrew8Li5k
	EEsX920vb1wk48g3sQYciAszEZQM4Uyr24nNLu0vf6plrisfl5EvGWYA8cMglNEWlIHg5MD7XyC
	/VvGAZTknImDmuM5IDDbu2Pj1ccxktzbzfm9Xn9VipbrkLihMFid2xAlzYHDBzjrIg+hdJr/bAe
	A
X-Received: by 2002:a05:600c:8116:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4ac17e10724mr259459885e9.16.1793648512913;
        Mon, 02 Nov 2026 11:41:52 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4ac0a0a3495sm231386345e9.4.2026.11.02.11.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:41:52 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/5] libbpf: Count entry programs for bpf_gen__init()
Date: Mon,  2 Nov 2026 19:41:40 +0000
Message-ID: <20261102194145.620210-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102194145.620210-1-mahe.tardy@gmail.com>
References: <20261102194145.620210-1-mahe.tardy@gmail.com>
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

