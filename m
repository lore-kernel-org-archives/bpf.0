Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127862;
	b=mnmiH0TOkfbvVZ5cNQcVfx+0zMY6Ef7RMTBPNdesqWvsNlOuXU8mi4UH4WB0b6zZX+ML
	 YdbePUwc/uDWgIe7HAlkti20frbUU8x7rnqPRwllma+8D+8x4TurcmSvwh79QbD/2SgYC
	 3bOew05GGrYBFi5uouqWRs2eOWKnvccSYm2Zve67cSvwxM8SCKLrzLSyYxgeoR7cGElYE
	 WvMApcZQf7/NxfAPMZ6dqZo1CJJAKVTE4JxWWKsv8DinYpfOsJoMlbgOYZ43WbNxN+6pq
	 onSsp/Hhc/e9fVXXl6kljKzjvvjYZC/7wWCgRy1EcUimNQiUjVD5u8lYB6TI9OFwVZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8jfdLTUrBQz7WWMANN6Wx6RxSxMiqMyLOvlUbwX0+CY=;
	b=Mn4MBQyPAJwNcsMn1Rxx3vbtNg9DEGjRWK09to43kJjj4Hu7QEsIfiCbzfE/+6IRNEkp
	 gDhkfJvP3WQp25eKNBmzgjIndumk8OfqNEqaKV+M8Xs+GziL5H2u2aMSv++B6asM041oV
	 pV2UWRdXuHM0qdxVem2IebfvD463ckfI+xxViR4Ltg2E3bUyYb3Ts55CltID4qXMpe/mL
	 R34ts/jvuI0A5wBZXFJCKeKjkPFP8JQl4HOFTxlnHMGCeHesAHV1MNEsj1lsxrhK2PM9h
	 PCh2RQprMZ896SkFfLmvftPCrEyZ7MHjLSVpQodFTN43M+24+inzq4Q7mG8TAWH3bVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgWwxbmf;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E6606A329
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D30E6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgWwxbmf
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a058315c79so107395b3a.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127861; x=1793732661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8jfdLTUrBQz7WWMANN6Wx6RxSxMiqMyLOvlUbwX0+CY=;
        b=FgWwxbmfm/OSpZtURpOsUSEb19CmTS/S9smFr/xIPsOuCwVjMuqQTmYSeVmIMDcinX
         8RlxHtFJ/yR+WFkyRLLj86txqNfa/0n54pIobFp/L15cMYUpCWTyxP4h+Zxbfk/jaL6V
         m9UPwByMHSeNs93VRrmBxZWaw0bk6Uk3IMPMNnEcIE96bXiuux/RTx3CkAteEVwoQl15
         rVsu6sh+WjNuuXOH9YjLVQzf4dk5q0JkvnotE4vuZEJPPVejYdNZ7BpQj5rx/NHm09sR
         vO4NLTStaP2EOhWyGa+kRmDvX+LOL2Mww1euPAXhTApbGDgdOuqmcDL7YBdjjUbzhhAI
         7+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127861; x=1793732661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8jfdLTUrBQz7WWMANN6Wx6RxSxMiqMyLOvlUbwX0+CY=;
        b=tn+MDylhU/+FmQJLu8oRnG6p6v3TEEmr2hk/upGX37uGZeeBgvO1KkWKZeXt8T+Jgx
         UzLtsOj/d2Hu0C8fuXVUODeuR664BSoGYCgb7ADP9v7MIB/o0Sv1X8uo+oVuk0+dOCQH
         NOeYQNKLFxTXf9Z4wWe4OVuZ2lZFtCakRpUfQOM/+Rzb4toyMJN3iVBW4LK28UA+PsCM
         3sciNuJNsIQe/M/Ptm7hII1G/Tla9ZFkO9TZyzU0dxzVLZQCeYoIWXui5KMV9naZcsL+
         DzFDE1qzekkLYacOGwY9NN82B8j0MZSjeZqPqSltCD3oOUqdGXBYdl4a9PrYceqM1SYa
         QUeA==
X-Gm-Message-State: AFq9FYIE7mPsumEfe1nTjDnyfiQjLfW4LzOhkL/SgdALQRIEKtz940d0
	WHM+PB3x1L1dyUj5fqT3aP31w+JqLmPZXo5VyhfG4cZ9eGzewr0ZLGyAPx6EYA==
X-Gm-Gg: AYBFou0A8AkfijOPEUmTnG9ug3IRdRdoRpfQ0nAD0tziZj2dEPEbbJibGdw0OrJ89fT
	ui2djURdvSLaglJUECSzlIFvNvRJsTUUvjz++Q0er4kSgCjZSrVeNM8QGusoO20dwuo/bK5v0u2
	GAJrN/yOkJEbxd+jVrhzpZd0brJC+3Nu6Lk0y+o0cd4pV6bRG1XNc+PDm7ZQrx21lBxRydCSffD
	zQC0q4Lc2HzNp2ddELlUFdA+lnDX9Conzfi9uJMAFLSRRXky+nC4n2+1vPC7psyPrK5n5kMIbA/
	KtHSkaDczfbPhiPxYiz2wXAoVmuvBhQgUKeUNdv2VFUu7x3O1sCCPhx+Vsidn9CK4VCLO7/sNnd
	MybUWt+C7M4F2aW3R5x4/Qgt4zktLUqSXDwVUPnVHzC46zR0G+XYefWzSk8GdLiXCKRMBXYmSnS
	878ytEChktFEfh+SMIlWBUynDdlTFtavKhuQQ6y12aOXRSX51Hm2vUZwMtGyRzMHkYmp4GFn253
	8px/Rv2Ds7QIRqqNsS24+ffQAc3ySwqLLyJih7I76RcIh8Dyk8g7SZ82JPdQPllMXU8yoLWfeyo
	yzb4Ip4PQO2QQQu10yoUK8IeRmiw3j4Yc4edq14r61N2lDc8FHX+MtnouLozQ1OCkZLU6jw9Z9L
	KEpJ2PHplVOkLF3r5GZ5OuC80
X-Received: by 2002:a05:6a21:4ea2:b0:3e2:1850:ec5e with SMTP id adf61e73a8af0-3e9020cc95bmr163025637.1.1793127860918;
        Tue, 27 Oct 2026 12:04:20 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc45a19sm3246477a12.12.2026.10.27.12.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:20 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 11/19] bpf: Don't widen a pointer to a buffer in scalar evolution
Date: Tue, 27 Oct 2026 19:03:06 +0000
Message-ID: <20261027190314.1440199-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Scalar evolution widens counted loops. Since that change the verifier
rejects a loop over the per-cpu values of a map element:

  SEC("iter/bpf_map_elem")
  ...
  for (i = 0; i < n; i++) {
          out[i] = *(__u32 *)pptr;
          pptr += 8;
  }

  loop header at 12, widening r2 to 0..56 step 8
  R2 invalid variable buffer offset: off=0, var_off=(0x0; 0x38)

pptr is a pointer to a buffer (PTR_TO_BUF). Scalar evolution replaces its
offset with the range over all iterations. But __check_buffer_access()
accepts only a constant offset. Thus a prog cannot use a widened
PTR_TO_BUF.

Do not widen it. Then the verifier verifies the loop one iteration at a
time, as it did before.

  loop                              before SCEV  with SCEV   this patch
  --------------------------------  -----------  ----------  ----------
  counts in i, reads through pptr   loads        rejected    loads
  counts in p ('p < end'), no read  1M insns     loads       1M insns
  counts in p, reads through p      1M insns     rejected    1M insns

The verifier cannot decide a comparison of two pointers to a buffer. Thus
it follows 'p < end' until the limit of 1M insns.

bpf_iter_bpf_percpu_array_map.c and bpf_iter_bpf_percpu_hash_map.c have the
first loop. They load today because num_cpus is volatile. The prog reads
the bound again in each iteration. Scalar evolution cannot count such a
loop, and it widens nothing.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 3f7534cda47a..6231d16aa311 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2379,7 +2379,6 @@ static bool is_widenable_reg_type(const struct bpf_reg_state *reg)
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 	case PTR_TO_MEM:
-	case PTR_TO_BUF:
 	case PTR_TO_BTF_ID:
 		return true;
 	default:
-- 
2.55.0

