Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08D4949F6
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136096; cv=none; b=XAK6IUPLDOTnsYR/CNYMyjI/2zOVphIHNx2LAb/OwqoXE7bNJnmgdrCQVlnFTJ20TS4jFr71lRDL2imNSoWZrvAapNhJRF775VbkFphjR/rAVYoC/bleH70XwOijAyr9d6Aa9pF5QvYaL/iEXxcJgWR9j0yszaNekw/e4aCOkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136096; c=relaxed/simple;
	bh=WqZ3N8Z9GMhOpoU8cNQY5CHAna/3bR5F9MzG9CZ+kCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNQZpYIhauDER5mwXWOMjj4i7gPY6fF5IoIOD4fC3NduHuwIjKvDdfeSpmF9E/cs1qzcJQ0jeIyfKQ33UXNx/te4ZHBD8HFsbjbtYk8l3cfWBuV/MCbxhomfp2MbItnPDycmrEEIpgykDaphPVGrif6izeMkxgQPXOG5E5CoNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwidsIOw; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwidsIOw"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso1664643a34.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784136092; x=1784740892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4vNV3CqeULTmndH7AF/LHNbSZMxBy/oI/o/Kp0rSlk=;
        b=TwidsIOwrfCaFwGcLDbwJEeTX6+r+7NsoIeIjQYGuRHHXsjkf3yuzCon4HBbo8/ZgI
         oW68JM0v4VaXytVp8s3av/b8Gd4H7/CUAA27ItvhXkU110nwsJSwY7PHzGT4a2Xu5mPb
         BoeonYalUpauhhAeWCh37T1hH45ZcVsdhZsf7nb8DgMAxaHnFmiNea3xttvke1Wuv1gZ
         p8IlmGOJsVVTACkfVIZypcbDra4/4cQmHOmwk/EfUSEORp1SZRBto8T49gt8PVpyecys
         zsVUVKS8uP+ZJdF0XlShSSwP0q/WpbEw2c20dHRr2taNK0Mm4sDRar8S/pYIaemGZsHI
         f6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784136092; x=1784740892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4vNV3CqeULTmndH7AF/LHNbSZMxBy/oI/o/Kp0rSlk=;
        b=PvY3/KTbNOT6uaprYH/G+Akgm1o8Ut+YA8t7UpU52qNnEACTusHamn49J55InodrgM
         ZwN06RTxCp1xgXqgljZnZTKyj/FGM4EYXQquVd/SiifEDCQc8Rf8BLx06WURF8UFhV8q
         g2qWJjbSCdE+Y/AtSwpj0o4yNWD89mgA+OJzHOGb9l4WI0zJdTf+277JZp45lBgKdsvg
         2cAKAIeZ/MDZDx01hqVLzUfwmOkCBtblmoCOTAdqmS6hQhqSZKYgb3huyTdrrMqMXZLM
         pj/rO77tzLgY7NE1WzwC2JDEsYZztwXwvD6V1CYd81h30EQ3nAX13nHyi/VeJw/+iB8v
         KRbA==
X-Gm-Message-State: AOJu0YwtZs7X02Io8BU9BYPSDhBaB1nrwWvi0zthRec1SDmH2PADc2eZ
	nZksPbHEHm1gXT6byRtZYME5/CRsCn8GMh6DOA92nJbAYH5O3TMTb920/yPI4A==
X-Gm-Gg: AfdE7ckfnct+YBnBQTMeHasmxHgKZqpuHewhIeAaYHxGgJqJVBq95YYxYUVlMFBhy/B
	xlgpVYO5SsFmPKT4FgtFBfriyYoWhAz54gt+H1889cXHRtQi2fTuzBgFTlH4DuVIqpSjTJeM1Va
	WUhr/MmnRPbS38TV3Bez3VQVGzT002JIlW+3FhmIYJ/sHujie0x/qXyo/FKqnsLDsTDpsvE71vW
	s01hSqof4yCVp2AvHQyxyRMAC3N11E2lDlh7FJZZNlayiWOP9JYGrG96x0BXNWKD/5Ge7pFcHN4
	nMpdR3xVflfl6GoM6w1M1NqCZ9+PMAXJkEYfKIktJ7c7fM8HeND7ljTF2nMiQlJKTfAb19XJBpD
	Dc9J+DsvmHjE5d1qVb2OXfkDkbOsb7hQY0FeiWg9COlfIbaN+k918y7ngh/Ztx533wGjsJeKMlZ
	eIiGg=
X-Received: by 2002:a05:6830:3989:b0:7e9:dc11:5920 with SMTP id 46e09a7af769-7ec68ae8fb3mr168463a34.8.1784136091809;
        Wed, 15 Jul 2026 10:21:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f2b86sm17627342a34.26.2026.07.15.10.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:21:31 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] bpf: Zero kfunc arg meta before error paths can read it
Date: Wed, 15 Jul 2026 10:21:27 -0700
Message-ID: <20260715172127.2416388-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715172127.2416388-1-ameryhung@gmail.com>
References: <20260715172127.2416388-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_call() reads meta.func_name when bpf_fetch_kfunc_arg_meta()
returns -EACCES, but that error can come from fetch_kfunc_meta() (e.g.
fd_array_get_btf() rejecting BTF binding for a signed program) before
meta is memset(), leaving it uninitialized and risking a garbage deref
in verbose().

Move the memset() to the start of bpf_fetch_kfunc_arg_meta() so meta is
zeroed on every error return. The intended "not allowed" -EACCES path
still sets func_name first, so its message is unchanged.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c87e5fec5a85..ddfa4f57016b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12571,11 +12571,12 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
 	struct bpf_kfunc_meta kfunc;
 	int err;
 
+	memset(meta, 0, sizeof(*meta));
+
 	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
 	if (err)
 		return err;
 
-	memset(meta, 0, sizeof(*meta));
 	meta->btf = kfunc.btf;
 	meta->func_id = kfunc.id;
 	meta->func_proto = kfunc.proto;
-- 
2.52.0

