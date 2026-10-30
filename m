Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352198;
	b=m7W/vF37BmHse/gdGhS1mn60c3DJiL8yN2+g3iSe9EkxTGvbDSrAf+U+7ewv3JBog3Dz
	 64QtJQsIzEfw12PSSrlZbMC6XM8rDuip3h6xYTRqWmiNy5jLgShuVInFAfQQHfSQnOiH2
	 OUji75G/cpfRDZvtuVdwJsNWzZGDx6TygNv/wxWTbX1UrYiEVsFxCpmqbIEEwsqXUSSAT
	 5bW4NkpL/9RPks7RZqZr3sArSHxDBVo6x+wlJwhi1JJ7DLr1QzunkvCQzrkBUSUMVWFB0
	 UVaPbStjMWhmWxUyc5TWUBe7McvygMMNz0EBaa72cYal9y6i1JI5GOo5TqKtWGtMSEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JAuZVLYEPLoEITPcQc7Yebtk0mlDdnLB2+PWyq4KYq4=;
	b=upMpCFksAh/qxMs9YPoXCSFf0MzQdQ07+FpgAzD1A5QDCAM8ttAspYMN1MWLpA/WTFPz
	 cKrInHb7JLImm3+0C4r5wxWrwDFSPa1tXpXipP90WwwXpJZZ3ZtE9qMp0Mqr/7PdiEDdl
	 8nCsaDTdwRLEdK2S5PocveMjub4GxIqYyMilfr40WusEkllFeF7+peNlwe/hU2ceRYPFh
	 7aJ68AvLhE5D+6KNtnr2BrcZABr3OyOevAIbFqUFmZh1thH/680ihchcTkuvs5v6fMHe3
	 zOUZhe1jQ3CNYQRsvP3Xx3MNdW1atR9KgZ7rbvrjPMgEt6jPoZBcGuXHhHIlq1Y2aDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RlUGkL6U;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E81606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 09:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RlUGkL6U
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so3115315e9.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793352196; x=1793956996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JAuZVLYEPLoEITPcQc7Yebtk0mlDdnLB2+PWyq4KYq4=;
        b=RlUGkL6UQIf8N+8QfoyQMOAtrl/MGzXwj1MTtmRX6sSAL6Oe7Psm+JoPST563PChA1
         +8n8iwDYnw9iOJwugMG6AynJozQnl+0+b4HC8dYknuPTSzyTllJG7DtqHspj2pcAR08y
         hqwmfB0TXpYkQ60kC1uZjPOdoJnTJ+3RCoibIAw5Jqps+EKWlm6IKY5zr9EdSPhzwbV/
         4PqJXRyT9azEkf0jnr0OAHBOhhKSBPLBhd78HaRtDT2ufeTsZkIzWeTzI0v/rEUqcLtr
         B76/K+3lZcqjFQk6UMNeUvo7DeXiFO0XJqz75zNjlXEd8jL24DK8N868ojdfhUu3nYFv
         sK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793352196; x=1793956996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JAuZVLYEPLoEITPcQc7Yebtk0mlDdnLB2+PWyq4KYq4=;
        b=nBZWulR/ykiys2Ia5ebbsSGN6ecjynYz2CgTCwsnt58NmbaK4tFlQK2DlH5FUSp095
         KPlMRsoDAxcs22ieC6lj5zBkqyUJbOF1zEpGL8ZxUZ/EwSQ7P7iDs66QOC+c0NDHXkXg
         FqPT9gDS6ExyKdqXTiFLPEeMQvY/SdPuW8TMiwTxR2I2ggfDHCSByivxUulDFdvTmxoi
         ivfuk6YEy0+MSnC4GSQU4LCN4DuSHPcD3hIUELwac+Yl6kYt76heVYrv6fFSpz1BYIAn
         pEB5cm58DHqwAHeCZ6mz58qyE9mw7XZdmbQNPYy5qamd5FAb/EJx/mHeu/p98mEI6rrj
         A1GQ==
X-Gm-Message-State: AFq9FYITC1TQ4NIJYCLNRyUyMj/ZCguBXU3/N+XIIJUH/wPE8qcn1fnH
	ZwXhGo+9TcXDqtAGGG2O4jr0LSCat2JCVDe6HG85i34N7yL6s8pTMuHiL0LT2DeO
X-Gm-Gg: AYBFou0nbPfxUg8mbMqDoQrQDmTcMwpu+sCzQJPzzyQbUilcXaGpEFPgPdBKk2INnE6
	MiE0BhCEAdViifxKaE8EB0WvMq/RJT6uEII6rb16OF7/q7Wu0mxMfbNhkEk5l55pkliR5AwfC2+
	76YaZ9FjF+zkJMhMTx23ZXCxWu4dSVMQNvFO0Us06ur2KWnkRvL5jkZ237WTqtJZtYDhsLm5DtX
	3B52m7cP331boR3NlV4rap515W0N7EJgPTcGtdKbHj6vofFEG38un46JyLcxTXpx5hfYqoO5VFi
	vRZ3jyUkCa2rYDSnjhNwi+AuGrp6Vz1YSW/8vhnFDIIV6+R5Jmj0wwRCmGgTUcF5PlFX2O79Ooc
	cg6K/xRj+075FmdZFGFoUTq8m2Ydd5qNLcDkZiKkjIFhVMx5Bk5oMG/dQj1EdCdZNd7+yHk9s+h
	8ijElZyoNfAZIckWN3p57/F6vyRfgIBUjtBB2qFN0xovvBVsRekEIzLtII59i6XktDPrNHnUCFv
	iFhoM/euulfBkBuZZKoH8MlcNAMHa1bVpwsYqGNdLFQRmh94EiTEKM95WhvDq0SWpXyp26g/Sb6
	OLwUUs1wXudd1nI5H+34E1cu0srGGcklihl2tJCj+RevwEeaTp97lOBfcU80PB6JPlY+WwRh1CS
	KDAZBH4wGlQ3PAff175tmBA==
X-Received: by 2002:a05:600c:6095:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4ac18b7e1c1mr33393895e9.23.1793352195788;
        Fri, 30 Oct 2026 02:23:15 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4abf723b5dcsm47072665e9.14.2026.10.30.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:23:15 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf] libbpf: Enforce program limit only for loaded programs
Date: Fri, 30 Oct 2026 09:22:48 +0000
Message-ID: <20261030092248.7388-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

As explained in commit '259172bb6514 ("libbpf: Fix gen_loader assumption
on number of programs.")', nr_progs which is obj->nr_programs at this
stage is including subprogs and autoload=false progs which are filtered
later during the generation.

Quoting Alexei, previous patch 'aac5ba0a4d52 ("libbpf: Reject excessive
program counts in generated loaders")' does move rejection at gen time
instead of load time, but some programs are still wrongfully rejected:

  Two objects with obj->nr_programs == 33:

    object               before aac5ba0a  after aac5ba0a should be
    -------------------  ---------------  -------------  -------------
    33 progs             -EACCES at load  -E2BIG at gen  -E2BIG at gen
    1 prog, 32 subprogs  -EACCES at load  -E2BIG at gen  loads

  The second object fails today because of the cleanup loop in
  bpf_gen__init(). It closes nr_progs slots of prog_fd[], and
  prog_fd[32] is at r10 + 0:

    r1 = *(u32 *)(r10 +0)
    invalid read from stack R10 off=0 size=4

We now clamp the loop generating the cleanups, which may still be more
numerous than necessary and do the actual E2BIG check just before
writing the actual prog_fd into the stack for the cleanups, after
bpf_object__load_progs() has been doing the filtering on progs.

Fixes: aac5ba0a4d52 ("libbpf: Reject excessive program counts in generated loaders")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 tools/lib/bpf/gen_loader.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 80a6b5306183..555d4757a898 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -122,11 +122,6 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	gen->log_level = log_level;
 	gen->nr_obj_maps = nr_maps;
 	gen->max_func_ptr_maps = max_func_ptr_maps;
-	if (nr_progs > MAX_USED_PROGS) {
-		pr_warn("Total programs exceeds %d\n", MAX_USED_PROGS);
-		gen->error = -E2BIG;
-		return;
-	}
 	if (nr_maps + max_func_ptr_maps > MAX_USED_MAPS) {
 		pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
 		gen->error = -E2BIG;
@@ -144,6 +139,8 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
 	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));

+	/* nr_progs includes subprogs and progs that are not loaded */
+	nr_progs = min(nr_progs, MAX_USED_PROGS);
 	/* amount of stack actually used, only used to calculate iterations, not stack offset */
 	nr_progs_sz = offsetof(struct loader_stack, prog_fd[nr_progs]);
 	/* jump over cleanup code */
@@ -1139,6 +1136,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 		gen->attach_kind = 0;
 	}
 	emit_check_err(gen);
+	if (gen->nr_progs == MAX_USED_PROGS) {
+		pr_warn("Total programs exceeds %d\n", MAX_USED_PROGS);
+		gen->error = -E2BIG;
+		return;
+	}
 	/* remember prog_fd in the stack, if successful */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
 			      stack_off(prog_fd[gen->nr_progs])));
--
2.43.0

