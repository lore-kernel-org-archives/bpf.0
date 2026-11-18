Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018611;
	b=2P+JYcpaqFeo3ekg1vpP7DPs8yezhAA5+G0/kQjHKEa7oWvj195Q7QdllehKqa5gMsIK
	 BpoI/xlXOkklzP8+cCT2MR7T6249RrO5fMPYPJqErjvngH54Rivgj/EyAi+qGSP02SPwq
	 KosY8prqBG4t5JJ4Sdo6Q+Wk0DReb6cy7n9w2N3xxeZcB5R7zodLPT7EjU61liK50biY4
	 Pi6Kco7aobShoGZhRbsJbKeS02VMxd4E5hwzz6hH0pGxNgLZhFbgI6i9RDCD76a2tLqO+
	 WKqz40eMzEMHArcw3Xnw8OpyZFyTj8FISRx/qUFcnAOwciQaM4viUb0viVvIdE4/wrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Mt1j1NeBKppdPhQUtkeyMgCerh85ZsDSz+CjHWhBd8=;
	b=41yf6ai272KPk0vIi855MsGwGxJeBrpM0RavwGNCvcXSMcWCeB6qIg8B7PEb3lvgNmxA
	 Q8+3MuZ2y2uLOPqBZijBKE+P2QeahkkSnmg9da+5wqjfTzT2ayj3tKuXbOAvUv5BiEXxz
	 Q3hfYH/YjBAW5IX5yUvctTy9w9AH9g7TNGCjk/aaUlm1CvUuJ/YhnzrA+YABK2Oh1+ici
	 jWOP+Csn/edUT0bH+JrU8VlGaDk+1hn6TZijtbgU2TIdQ4+QrgLBFBCOCGfvjeTl/wvzf
	 FOZe1h/5z0OIVTi7RzwaKb2bm+Pari2WGHuEcWpiYAMe9YU+N7DKkFwefEjh8RiZFjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YF532Un7;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BD606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB8BD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YF532Un7
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3b3d12563ecso507189a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 08:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795018610; x=1795623410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Mt1j1NeBKppdPhQUtkeyMgCerh85ZsDSz+CjHWhBd8=;
        b=YF532Un7EfdsWUOyRvMcMPwNcfTpF8mLMNWjr8N88MGn6ZYleGUDOqh670UiNeMiPX
         MYNTt5y3qfJwfKVC/UgqOt1Vyiwyq2V5n2U3rhIuUjz5TSLBBkgHrPc+fkxDlgr0CrpX
         z/tvtjU7YgyrObfxzp6ETdn1Kic8NC94yvGM/I1fSLpgqUKEG3FlyWYVm+WvfpOMEcEn
         mtexkcehBm4WD9RLbjeur1nf0XCnsYQDlVNyUZ0UeAr9b7DZr0Meoq3jB3p2i0ZbS3Wq
         twEUyTQfHFOV/cBfSBZu6yGiQN9pNFSqermpNvBT0URnd2fVANm2u98hFX6IIXNZA6M3
         LLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018610; x=1795623410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Mt1j1NeBKppdPhQUtkeyMgCerh85ZsDSz+CjHWhBd8=;
        b=Dmu0bxxhVZqR8QBog2Jalwo0kLrDBzYbmN243r1vwRuLwVELMQ+pV1AzzPWZlTh4bT
         kXzTVL9YjSVbPfL/ucniJgPsDiaQPL6P1DdZO33C55u+rSCahWMh8lWCpSSwE8RZ5KRL
         qKM/F+foc4CCh4TcOQwaNblMNHIu2PTq6siDwMevOiZvU7h90nmBVXJXZn6nyvoVWNX9
         UJLbA/skrtXwqV79XxLSO039nUzbUgz33bGkYuADtJYrGoD1DAFLAubLjSxYPfz6dqdn
         WFV/S8/ZQ7gws9xLR7mm/DcJyLOYQs8rFXAng/7EhN3wJdheAQxYNhs09E3DH6aS/jXe
         7qaQ==
X-Gm-Message-State: APuU4Z8j8GcvTjcWbQfjvBXntnEFlHd1AkXYQilvQEY1ovpxMJl+yK3j
	3QAxBdvRu05lGYvk8MoSfJ4XCTS5v045zmDeGWtL5kEuspLWn4pXujj3S+JeTiSgQmrfFg==
X-Gm-Gg: AZFdTZcfUL/EBHz6UO8BkTrS8Y3DLC1jGgI7Qmh0pB5bvTFnkAWSYXgfpW0XDd+kRIb
	a9BisY1xOFTjksWqLGMBYg3MLzfMxwJCSfdUC4naOLwkBHccVEIb3dX2/eVHPyL+lUwSZYT+V90
	UqyTUCJBJpl6InztCUaMvZF8w0iyXvD4jVFE4zWm7s8oYxJ4RuVBjb4HWgo6taG90rwHV04IXN/
	hxwR7usuIK89yKebfl8p/WEky3pHs6aLbDzfqq6MmaRgf5gE4XTeOx0ImgTQIW7h/XEWNILZKBk
	od5XLw1qKOxlbiuTvB6KhYSJ5SJjCiLLjZb0PHtIATV9Ci83JgCxOSWp5qsyVyNbVDsh8YWRtvR
	RFUpUBvGeaLc5VMeum1Uhc9ZbV26pq2WPp+HZNz7typy7zfcQDmbWg5GeLOcdDACwAsYP1Zs07q
	HIvxrdKTTOazDMOwL6YQxHXz01XuuRcxCjeH1aW27V+ghxIuC50Pq94hhkFTaD1Ry21oPVmCFzn
	5NrbfKX4U7jJoumFSj9Uy9TVzYSpa8C/HHIfM48P8YXhOL5NoMBaY4uR6IA9j1EKVTvnY/O/SPD
	FzcjWdbDAPtutlXJpkvJ2yGYuA/WHa/M1e0bZ6qAZuLRSnw=
X-Received: by 2002:a17:90b:4b86:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3b3d06a487emr3376460a91.6.1795018609907;
        Wed, 18 Nov 2026 08:16:49 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde533658e4sm256978a12.2.2026.11.18.08.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:16:49 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
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
	kuba@kernel.org,
	qmo@kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH bpf-next v2 2/2] bpf: Reject maps without iter_seq_info in bpf_iter_attach_map
Date: Thu, 19 Nov 2026 00:16:32 +0800
Message-ID: <20261118161632.177820-2-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118161632.177820-1-shlomojune6@gmail.com>
References: <20261118161632.177820-1-shlomojune6@gmail.com>
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

bpf_iter_attach_map() checks map_type only, so an offloaded ARRAY/HASH
map can be attached to a bpf_map_elem iterator.  Offloaded maps have no
iter_seq_info, so __get_seq_info() falls back to the target's seq_info,
which is NULL for bpf_map_elem, and prepare_seq_file() dereferences it
when the iterator is opened.

Reject maps without ops->iter_seq_info.  All map types accepted here
provide it.

Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Link: https://lore.kernel.org/all/20261112105620.57520-1-shlomojune6@gmail.com/
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 kernel/bpf/map_iter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index a58c148692e6c3..9e459a2d34c3aa 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -176,6 +176,10 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	    map->map_type != BPF_MAP_TYPE_RHASH)
 		goto put_map;
 
+	/* An offloaded map has the map_type of a host map and its own ops */
+	if (!map->ops->iter_seq_info)
+		goto put_map;
+
 	aux->map = map;
 	err = bpf_iter_map_check_prog(prog, aux);
 	if (err)
-- 
2.43.0

