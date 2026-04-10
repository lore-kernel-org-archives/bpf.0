Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDC348896
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813373; cv=none; b=dUtKn6MQuSsA3qmoxK40B4to/tRDwSvlfoTRZg3Nl/5EKRD7wWyKp6MgOE2+aWGscybDOjS1UIyzmY9v1DZckK85U7WBrEGbvcwEC2Lvp+MaboL9ytmkRn4gYe47GR8YBU38Rec+2gI5Aks65uK3NCK8I/ipe2dQETE27KvHLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813373; c=relaxed/simple;
	bh=62Ix46kA1Xz90T22xspOOMdXhfiODw7H57e1MUPlBUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFaHcvIW969aIqu7LD2Qc1RLbqc7BqB4uHaSG41w/RzAvtB7CocrWyyG8PM8l7mnEqeWeTg/0otS/Br3o0/BkiBW9TXdCFBAx9lKeILOgxbHU1s0ymIEznXCUF7hht/zUDSszHNZpvFZEMuONtOITSTL15Ot3Z+6NlJRuetJqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsOk24bK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsOk24bK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab232cc803so9836125ad.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775813371; x=1776418171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H++hNpOnRmeKqCmKO1D1mWWdRRxARivrhqFGJ0EFx3I=;
        b=OsOk24bKQdnERGth3AlIj+K5flGXjjkWMw7LPurATATSttPvexRSNWaGzGWSRrAOVt
         rsj+CXNhmWblSLo/TOJVSmbIZV60wR5Lj1M2rUVlu78ruWvCarYDBV3/1RKfd7eu3jeT
         klZzImsiTSJk50ltKIct0ENRhyomMwTMOeEK9rwytZ6/ezY1RaY7A7LHTCWTDI9/ocZj
         b2DLd3PivQD+90fZUe5uh7e719RV4sPRZskSucEx1AlFloOJw9xVuVUOLX/pY+gT8W76
         4TlgbbtScfaDfHXhDH1VWcvdsX9yYbqC6ByPiWYlKX8ZJ9i9Jd1SJBNo6PB0lO9FeBKA
         ypXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813371; x=1776418171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H++hNpOnRmeKqCmKO1D1mWWdRRxARivrhqFGJ0EFx3I=;
        b=Mvkpud53k4Rbv2b+w4g+eQ9ySjD1WEx0v2MaJq38CaJp3sPY65sRYF77aKP2B9kG7X
         +SAG36WYK/PlQ7xYvrDjqQVRZYmxu7DypEAHy6t79vHd9YajQbJjK0Qy67TnnPDBZcpJ
         qG0puJaPTZ1XnMXQTj/om8bvl4mLwiAwONvJn5zR/Cacre0hWnVDEpGNNbs1CDE9vVy9
         gsTTKy+227bh0eEI2UazYwSibxvinKDUqf0TPDqnUXyGaE2M+B5XlERWFK1rQFfoDbD5
         ZvlwwctDhxqR+YOW4rrUHs3JSs0pOe+e+1PsB1EvAtu2n0ODZJaWowZbQejF/MRj+3Ab
         81nw==
X-Gm-Message-State: AOJu0YzxM1dDbdcGCvijJ7tc6O6e5NR0FnALhjYWbzRlEr0xP+bJguDa
	+eNixR0amOl7srF/NOLJq4ylqnQT8vXkh7STOk8L98wwL+F/REAajb1tpu1EKiMQ
X-Gm-Gg: AeBDieuE0BY7kUaNaUhxOwyH2yOBsondoLRCFd+5YakFoEekre8Az7/wsqo0rip48ED
	Yh9X3g/6Lb9WWtFV8DF6xBD9geBcBDGqGLCKHIw5veaMcvuS7Mbajc72P4EsVbkllms7abqSgrn
	sl8P75fkoujoIQiqaf1da644TG0ro80MM513WW6pAZLWLl2t6HXoa4iQ6mToin4YjqvIKCjsDxy
	AIDiiNPNWBaNiVYsdYeLLNfjj+geehsL5JkB2FSnqD6Pnc4a5S1hh4jqYX86jUS7ejrbVh0vRoo
	MMg9MNkeTNGpLeH+qqWkK9OLCo14XvwRKBxmbMRRF7fkHJwAx22cWznSYg+2Vn236ozRG8u9ga3
	G3Gbg0cwXty2qAJHXojN95XvpWmNtClDr5OcaYMhwpCPHlCjHxXM+3mUYOjE5IECen9hygEJ4dg
	KFH0jVAMbE9QkotBMJXN9CTME599evsnNuBvIjDl9aB8SDZodh74cgk7Q3C7m/PiiqouA=
X-Received: by 2002:a17:903:2acb:b0:2b2:50f6:cdd9 with SMTP id d9443c01a7336-2b2d59764f9mr24690315ad.8.1775813371243;
        Fri, 10 Apr 2026 02:29:31 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08b9esm23015335ad.41.2026.04.10.02.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:29:30 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 02/13] bpf: save subprogram name in bpf_subprog_info
Date: Fri, 10 Apr 2026 02:29:06 -0700
Message-ID: <20260410-patch-set-v3-2-1f5826dc0ef2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Subprogram name can be computed from function info and BTF, but it is
convenient to have the name readily available for logging purposes.
Update comment saying that bpf_subprog_info->start has to be the first
field, this is no longer true, relevant sites access .start field
by it's name.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 2 +-
 kernel/bpf/verifier.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 15f7f9f35be9..cec6054d6333 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -664,7 +664,7 @@ enum priv_stack_mode {
 };
 
 struct bpf_subprog_info {
-	/* 'start' has to be the first field otherwise find_subprog() won't work */
+	const char *name; /* name extracted from BTF */
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u32 postorder_start; /* The idx to the env->cfg.insn_postorder */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd81cfbad680..cd2a56308e59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19682,6 +19682,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 			goto err_free;
 		}
 
+		env->subprog_info[i].name = btf_name_by_offset(btf, type->name_off);
 		bpfptr_add(&urecord, urec_size);
 	}
 

-- 
2.53.0
