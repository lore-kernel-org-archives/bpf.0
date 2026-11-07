Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794059673;
	b=eubGG7PHAVRUA5qa0UNmSfL86xEou9NFMJb1Q/xjiXvuKaxbtzJAv6toBNkSeHyTgrCx
	 kcMTo402jifjQxAOHIzVrhMA6UnCeMCq+VVY4sYrkibNBdrSutm6Wj5j2r7xnEajPxX2l
	 qRZk2IurMy7MGA25ySsijeU1V/MqrtSuZGAONidZT9z9Gqc6d7ooqgqN6JoGbRsgPtXSi
	 bJ7g72s3jxUGaOsyg7QwfOVgqe1EuNz1pfhyoqyv4eKTqTiHg58F2RO+lq7vBOM9gz3Zr
	 QR7MMC2w55pyxV5+1z5JMPAz3iJSJrdyfAMkM+ruZnf9p6XihnBr2WIrJAa2XakTExw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794059673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=micJSLwzCdHUI4gTSgOx2Ec5cxJSnBC/iQZVAPPAf/I=;
	b=3qAngZyBQFPaWFjqFtUFxsTEvhr7CADj1lY7eoC1JUR8Jrdm2QjcdmZZwDcgGpPqrkpz
	 qB6RDY2Fxgty49ICdofBJrHkIiH0wNAHD28efaqG/NagOhQmviKUcDXPNaFq/cmEXZ4xj
	 jsCKpWjmh1VVBqG5sXekVL1bI0uQmyWyKw9Bmo8tU19SxZzZ2jC74rMKYlBPYlbV3VLrK
	 Ufm/FQY7KqceU8MH/EzHrL75tNCGwI/IJ6K206B5VKs9xEIMQce8oaCQZ4WBtI4EaObUt
	 MLWdYlzOG7RQBJ0osZFIr5O80ZuXbu5KzP4Q1tWlmx8y3aoDC4UGcQOiubt8sneDD5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t8pgtXkC;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E919606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 13:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E919606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t8pgtXkC
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3b092ea1afbso517890a91.0
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059672; x=1794664472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=micJSLwzCdHUI4gTSgOx2Ec5cxJSnBC/iQZVAPPAf/I=;
        b=t8pgtXkCNgiYNYT44xmneFi7D0NI1JBkhmkbqQxXVesrKe8XzxqqFA/53cIm8w4WCU
         TCea+KD7Q9zBxl0e0LuwH0au+NY9Tuy3JWwk+0SnXDY6tHC0J6ZfPVkn9xcmyVaCwbbA
         F71XV58OlDM6hYZThVI+RW7BcTELU19CNi7NaKjyoKWLjwDoSQBihaWEFKtQOgJyFyge
         a8MrZWRB028Iq26mMExtkq+2SRrPmsvr3hr4BvBL+MxVcL1wCrrDFHLS5bUC29/iUikO
         k90FWoqdhf3ditEovyre5yG1hpeTFk2P0GoIgg0PtuTWJcPR9//Q8fPejvYknPT25EG2
         h+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059672; x=1794664472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=micJSLwzCdHUI4gTSgOx2Ec5cxJSnBC/iQZVAPPAf/I=;
        b=JsVXyneJGAVtbAznt5Z0OoFl+7naxhc1HnqwAlAfja5wtcvR2aZAsFdfZTwRUub6N/
         UwwROkrb+ZeY7CZD572knk13adrfkASRALcHK6HBHAC5gCUIWZptsmaH4PLZuaM8r1e/
         1oJp76rh6nmcLsvtIGfAvLfBekDCw60RLf58g0hFdkrJL09Jx4AjehAWgRKkTXVZgDtE
         2TmqTufBeqvgNP81IVq17fqdU+Ig8la+eXrXV0jskBw51ixTHyIY/5LUyoHM7arv0yua
         TnXBCECz84ogpnKw1AsWwesr7ue0t69xZrCuPFGPnnPnmV5JAqg5Sw4dARL3RnyyEkyG
         qxXA==
X-Gm-Message-State: APuU4Z/9Lhnn8j7GBtSVNUZINxehn2OnWkXEw3wcglEmpoI72G/seb+L
	p5/ztf/WnmKkZL0zouCGbZcg9TIObnLWjokQvy/w2faIDqkaugAWw/GFAnKWe/bc
X-Gm-Gg: AYBFou0Ye0hMnWhhcM/Isp4wiWX+bDgGSeyLbNQwGlezKWBbDMrJkXFJuU6IrrCOwBP
	vs1vRD1Ogp+2h3G+Vzs8dDALTcZY/d3gMtf2g/0NGTgxSf5NIYiOKDzP3RpbXkrLMAu/LqFvEPu
	COrOiXP+bEQ9RGKD6wnEVWu7fW0XgXhv/fLe4lGO343q0wOvA65PDkleNHg1Cp73OB95CDCR1rG
	/RBL6iNupAirji9VDqZdrzr3EsQF7s/9qcnrHJ7IKvh+Eb7JBZnuzJdPS/l2sSnLKdoXxPVbliW
	ISTXDJO9vzUt7JSiNbh5DEW2tLXWAD3vNYukEj51Fe/I63jwSZpC/ANWx28vL11V4ZQlCHTrgQz
	0BWtFAYdcy8tU1mUQNEW1fMCYv8r2xrNElyjEt9jPvoP/vBfmQ8i85bf+v4BTs6Ihm5OLbHwdAo
	VZ6UwwhnB24sPueQtMo6p2Bw9v0zGPZufIVYCpVKH/wAd+bA+d+6uRrshz6DROt/oqGoKP6DM6X
	jgaOhyCsxJxu9KRJxDUQizgCAI9Rp+U3fJ8leZG21ksXoqg2G7w+prEVbxeGs3U9p0gO+jZbXVs
	KfwGXbPRuLE66sD+YIlrWoUNlVPQjXGk3tub5NMAfx4Twxg=
X-Received: by 2002:a17:90b:2d85:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3b0db700c35mr5295034a91.64.1794059672267;
        Sat, 07 Nov 2026 05:54:32 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105831cf6sm3394941a91.11.2026.11.07.05.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:54:31 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH] bpf: fix special field check with variable offset access
Date: Sat,  7 Nov 2026 21:54:19 +0800
Message-ID: <20261107135419.81491-1-shlomojune6@gmail.com>
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

btf_struct_access() rejects direct access to special fields (kptr,
spin_lock, list/rbtree nodes, ...) of program allocated objects, but
for variable offset access the check is done at min_off only, while
the whole [min_off, max_off] range can be reached at runtime. A read
leaks the pointer; a write corrupts the refcounted pointer and crashes
the release path (bpf_obj_free_fields -> bpf_mem_free_rcu).

Check the whole [min_off, max_off + size) range against the record,
like check_map_access() already does for map values.

Fixes: 89e72f81a455 ("bpf: Varying offset access support for PTR_TO_BTF_ID pointers")
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 kernel/bpf/btf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8bf39098ba97a..47a64a57b370d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8094,7 +8094,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		for (i = 0; i < rec->cnt; i++) {
 			struct btf_field *field = &rec->fields[i];
 			u32 offset = field->offset;
-			if (off < offset + field->size && offset < off + size) {
+			if (min_off < (s64)offset + field->size &&
+			    (s64)offset < max_off + size) {
 				bpf_log(log,
 					"direct access to %s is disallowed\n",
 					btf_field_type_name(field->type));
-- 
2.43.0
