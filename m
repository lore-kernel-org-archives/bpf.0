Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577559;
	b=zDxdhbViSBWJ1Ivdd+J1UD0y+P/H5qLKSq1io9P+R8qPHexGo6oYj+Duwe7c//nMdC7X
	 c/5/pEhzoJhFhBfSN61Nd+H9bRNmPYbFRfUwW5ijVCXPSntmVccOqSRcmgf8eT40Ga39I
	 kkT80bVaJYjVBTN8asR6dVaX/K5CLvEDmsD4++wkI6iTaFMNlLHuJheJMibaRHJMi9sC4
	 MJI+YGc3D9GdKN1Kw4gzRqAzyea/KXLNog3ljrJUnrpvPAvAhdizEpmzlwdssaLCHejOa
	 t8FuJ34wOlckz/UXtrt3is7XFBfpu+6M0NASoQ+w6Cq3cqiilf237mf+Ocbdv8GpSiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CBGVKBb/QPPsiMGo1+ZYmcoy9YB7vqr7UdSPjBpsnT0=;
	b=PrG3vOfYiRDRH7FpGFTwcV+H2/YD+OS6gYIXmevzGLmwHOKRGQlUbwMSLOZirAa/0mez
	 zbg/sYVI6+3oIqsEspPabZQAk0Jw74MTO9f2Av27OApT7gCGikP7X14UdNwOO5tN9DNP7
	 wVFGayzDLBYn8tPHpRQs5oe0RWKl+XCYA9yRxl4r25hA8I+2EOdvljK81Y0OrCOOxR5YO
	 22s5bEPXi+E7PfQF5NzCJwY8vbsWZQgaNAliHzS/rMxJ92GQul4DNM6CvWK1N8E2EFAOB
	 hCsY22W5C7BuP9JhahF8K41+PMw+06ABJIhLTk4ETinM3zDKHGfY1Qi9EkbdA1ELeLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+UYg6Ey;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4B606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D4B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+UYg6Ey
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b6b22be970so2039186b3a.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577559; x=1796182359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBGVKBb/QPPsiMGo1+ZYmcoy9YB7vqr7UdSPjBpsnT0=;
        b=G+UYg6EycpU9TL1Qe8ELJXP5kvLztGOVy0mlIJW43dKUUwVa1mlvox9PfWaCi0ngy7
         c5xRaFTp/TihsRyACTtKiIC0otH38v53YLSQlF3140ExJkw64cmyBQgjPJFIFdgpRLBU
         OQKzHTlaKBfZHP+UWllTWwxbJ/sCTMWgJPkWtKaH3JgpJBlBPUczDIgU7h55wwK9vgIO
         8O6ousiqn5duuu6g7oH57VqEmC3kK/2Bu0w8qdTw9kfCHoxyA7JA8a6oo+WTtwnyUHyQ
         JzZTg6D3BRAur7HFbOmrqsMbQVjx13i9QwhzLyKD0tMNqJOVw0PE0PhBBW0ZkC0LaRTi
         chZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577559; x=1796182359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CBGVKBb/QPPsiMGo1+ZYmcoy9YB7vqr7UdSPjBpsnT0=;
        b=dS+GvR3tMS62nFuw8TdTor+qqMGE7mRPacScHBoJ3Utdv4DEB4qvY5NwXo4s/4SQfQ
         wzEQyn0gN1JpE3Um3BSNWKsxdVxnhrZLAHApP/w120VbiSIFORBa757i/y1/ysBzX+uP
         hQxhbFHI192WVZ5ulqL8pRt+nBt/nLfTup3FpZqdQblCW8UNZZE+28JwOt9E3EsUVd9o
         ny6LTnjzZyzktooU77FZItStcjpn99o/Ofvz/NNk6VM2ZT8d9fNWVDKn1laRzHG6GbRr
         JVNM61D399sML+UWurq5UVVCGA4BnSbcb3Bv9BSB7jphCopwkYqsG/mIx/o5Jhev2T0u
         m43w==
X-Gm-Message-State: APuU4Z9mTM8Rd7851/MnWdGW6pjF/xFYuj084DoNKXHMAf+O6DB18kFS
	cC4SIX5mZaPQ7NlMPXrEELoKHqxMKjZOr02R8bYZRTVxG2m5LLOuFylfGv7wf/Om
X-Gm-Gg: AZFdTZdvoL5mHj2c5FyrYay4P7XoPHQEFUbpcFfEAM26rkEapNwlZKVpUrdp+Tlss2h
	D8M88eI9TLQuRFrWVY0Ort/bnnRPJ7JBOgM4vq+V+rTLsWq1EbOx6j40AqbV8R7aeT+oxM3aLuZ
	Sih3gM1Z52U1G2/R5UbKYj0EY0K0dBnIfo24lPqb8fhOYnc6ga1F4mo5BOxfkGPGQbshZ2PesHJ
	ONSRosNDusUhGERLbpnOgvDyS6+XYXQXGE4WNVc9kgv2M6WlMP3Rcin7eehM184PqxV5R7ITig8
	gaSLgl7+whvh4ZnloAFMuOTnF6huTmtnv4t0XtHG6lzSNcNDvGpJo6EC5lJ8ZDKvZ+yllhgbM3F
	K5fzeMhSgT5DJnHtVNSfeZNfxD10Uun+b/WEjTxnPXkSiB2/xwdEb/xrnX+tRhPDpDYylvToNgZ
	nDofQD87eHgDZ3AUTvUzIjyaWT4IOVnUAcpbn+gzpp5w+rfXrYjvBO+pdXnXeYTte/Ix7iowiwL
	zIm3NCZTqaZQfdTXssML2iwx1wv0odkPkLLBvYDTPMzXtYQxqSsVIddDYbl8rg473BgDSyxgN7I
	3PDt1B6TxSjgaAVMaKi6NseZaYY08DQZee6Pa+Gph1wc8VtOMg9NSG41Kse6x+BKpOWFYNGdUW2
	cGBGCvAfSXgwbdbVs0K45nsZl1PpGSb1XBRzsCnrAVs4erHq6W/+2OywPgDggpihj03TLh9wfxw
	==
X-Received: by 2002:a05:6a00:44c7:b0:886:5938:cdd4 with SMTP id d2e1a72fcca58-8c87baccf21mr15013981b3a.19.1795577558584;
        Tue, 24 Nov 2026 19:32:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm8128847b3a.31.2026.11.24.19.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 30/47] bpf: Zero bpf_list_head in copies of map values
Date: Wed, 25 Nov 2026 03:29:21 +0000
Message-ID: <20261125032938.670542-31-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

Lookups from user space copy the value to a buffer and init special
fields there. An empty list_head points to itself. The caller gets the
address of the buffer.

Fill the fields with zeros. It's what a new element of a map has.
bpf_refcount in a value reads as 0.

Fixes: 3e81740a9062 ("bpf: Centralize btf_field-specific initialization logic")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 448431c4cd2d..5d4b0e5d56dc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -566,7 +566,14 @@ static inline void bpf_obj_init(const struct btf_record *rec, void *obj)
  */
 static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 {
-	bpf_obj_init(map->record, dst);
+	const struct btf_record *rec = map->record;
+	int i;
+
+	if (IS_ERR_OR_NULL(rec))
+		return;
+	/* Not bpf_obj_init(): an empty list_head has the address of 'dst' */
+	for (i = 0; i < rec->cnt; i++)
+		memset(dst + rec->fields[i].offset, 0, rec->fields[i].size);
 }
 
 /* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
-- 
2.55.0

