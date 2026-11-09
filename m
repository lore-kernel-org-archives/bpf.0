Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243281;
	b=bktS9EAubpJtgpaNEpaLfT1tNf1/lEDtrDCrV7TlF7sA3ZaWqp1Eid46RHMnHNFPyxgA
	 cckgti8/P1eLvWuurdxidCJ+jt2Bg6kR/Tv/lqR6JGP8YY0XBqpNpbOYiqYsIl+Vodkjl
	 LhyFt9+PwVVKkahK00TdiJjK6GAt7HIDwr3PKjdMr5e+zGm7tfUQ9Wrj9JtZcB/mEPqfH
	 UY8K3Wf11YaOy3RACdXw3jl94R7eHpbxLdGgzYFl5KORBkKaklL8QHgze4tjwBRljseF+
	 owBA6UVE3+bpn2EnSxoVoc7sSsm9/cEETD9ZdZsedeg1VVJkMGiNxnkAxMcbDfLIQZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DLsTnaW3uXr9AC/QbRfpXuwiBDpvXM/nxSHrEfIP3lc=;
	b=zyTPtrVCtqjEaq+b/+1h1Q+j1GR2Du7FfzVy9+paFPbiX+uAiZkiPSeewYEFH8xwwhGC
	 aps4uiIoF+b8BltKvKNNhN+Oyc7+Mnb5y9v6moF8aGkQ08+TyZzxdbeIW4mmmVV6os71Z
	 AuHaapwOlbBunjntFVayMcFGiK1db4uEhwGrYcPPb8+RFGi3fdLd/xODXCUd/itKOm1kv
	 KsgID+2tmWaurgNPAPWfru7vRKLM1vcWTW0hP99lp6kJlxz/VR7KZ6RIRZ9kl3Y3vMWcH
	 +LMGkaaThRfGl5lCNqw628ofkSmeszLzrBjuVXqrxH6doOCmgHPQMxpr7t3nD3UKDYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8e719wF;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11060A2634
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA11060A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8e719wF
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492690dd5daso781984f8f.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243279; x=1794848079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLsTnaW3uXr9AC/QbRfpXuwiBDpvXM/nxSHrEfIP3lc=;
        b=P8e719wF715utMM0BRS2kJqVSYe7YveQ4yQjF9Y97k3HMC2eLyNsR81rVvRxTet/+0
         efqilVOrYrRw2N1MbsFwhDJ06wH2C1I6jHwgVzf5U694NTaMX3p5X4Zk9RXR/RQ5EY3x
         7m4NS8oCbD41RfDBB8Jx6M+FkVV+5qKOS7/oRQ2W+1x5oQAoLoUGkFmPB07cqcCm1xZd
         7j35awHvoSMcapN/fc64O/igLu46J3Ex3g9pJeudIaZF1CeoLM6HHC0pirXloJ/jTqeB
         Urd3DB0d601rhCF1ZfGGLRGzJgNnIQqWfl6gWX+7Ij2gLLcJdSeMpgbAxBfVoFK8JbUA
         kkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243279; x=1794848079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DLsTnaW3uXr9AC/QbRfpXuwiBDpvXM/nxSHrEfIP3lc=;
        b=nz6UF2P4jVCatAVhg5MHjwUcUf8bwBNu5L8cgiSE5WgoeEa+z8bXg4hd8U9eVb2q6i
         cUrogmoiHsabSDDNjZmc++o2McOuy9y34Z1dNliO19/IlHksOg7yALmsQsfBljpiweug
         m4KILFO7YjCOop6NNIZT/b4gmW4owpFUGI0ad8yyLpQB4ZOHNha9oRcncfRFqTYc6Eln
         WRZxtsrhIxPcNY9EQ+C+v+WFt1lAvdF9u0Wd3xTuZt3GDZ1JgbMuIiVE89CpmFPes95z
         En4FSzGVGvc0Uggd4dLfcj9YMbp9UwvxNyTb5TnMcF60PhpXg6TUsFZy0xFNAl/J0eWv
         wftg==
X-Forwarded-Encrypted: i=1; AL+hErG25Jjgsf8SgO9AwwukEhoIPrQyu601ssqBzfqDX6Df6D32UvdC+djcfRMSaJyv3iAPN+w=@vger.kernel.org
X-Gm-Message-State: APuU4Z89Qhc8mBkpIF5FRr3HD1+YNivVh00lokrR6vQ3uGzAMHaNlPQu
	84F1n5TvvRPqw+VNrU8fSEzUWNqinR+vtkR/mE6ccJDY3kqcL70avFeC
X-Gm-Gg: AYBFou2b/3q7Virclzl+M3SO/1u3ABA+oxgHY1iAm6+rPkNHNpLaftgO+Wyfd9vX2AG
	22q+LF70m/UlTn4w5UBpVKPrObQhaqQ0DA1hi4nxgXiShZWzfkft2EY+zQy40ps/0YvVFFKcelf
	/Zeg+qt1RI7+9YlJezNYyZCsj+co3LoJm6Uc3YwHyh7Uj84m8Ss8WMndvx3j1ai1YgBU1QX0sSN
	A3anqiHNhF5dugf5AlmIan3n8xBAaTceNOGXEOxRhvbnfSdgcv0I6rUV5AHlYJRrL+wjM8EcxMc
	EIAOhkmRNF648iJN/+hyqdILSJgwIquj48dXDsep+DR1dj5k62LNie8KOKsBsfD2Cbh4VwTop4e
	wumjonC+h3VA/4haiRdGlKpnJSp3RnHNKH2qOxMtOtmcYpJWV7cZpugDqXAC4A+VtZ7af6JKDuq
	fEpIefSC0HaiG4Z85gePZWhQXA8mNwNSJmAT35qrRe/cb7pdh5uppXkI4RAhcuHqNHUH2C1DxpG
	FsPxhpzvNjiUqpeDANmO1kclB25UXODuQ3lCrpRqI22EGndn++xTZIsdqAg1Fg7YupqlS0x3lBY
	Ganmonzqm49wSzo4KinSHw5tCuePi7oCGXs1SfpL3CYUk9/2
X-Received: by 2002:a05:6000:288f:b0:48e:5cd4:aa60 with SMTP id ffacd0b85a97d-49830206f10mr57743f8f.42.1794243279402;
        Mon, 09 Nov 2026 08:54:39 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:37 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 02/18] bpf: Add a btf_id_set8_entry helper
Date: Mon,  9 Nov 2026 17:05:22 +0000
Message-ID: <20261109170550.141443-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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

The pairs of a struct btf_id_set8 have an anonymous type, and the
btf_id_set8_contains() helper returns a void pointer to the pair it
finds. All its users but one only check if a set contains an ID. The
one which needs the flags, btf_kfunc_id_set_contains(), finds them as
the word next to the ID.

Name the type struct btf_id_set8_pair, and add a btf_id_set8_entry()
helper which returns a pointer to it. Make btf_id_set8_contains()
return bool, like btf_id_set_contains() does, and use the new helper
in btf_kfunc_id_set_contains().

The layout of the set doesn't change. Update the tools copy of
btf_ids.h as well. A later patch uses the new helper to set the flags
of a pair.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/btf.h           |  8 +++++++-
 include/linux/btf_ids.h       | 10 ++++++----
 kernel/bpf/btf.c              |  9 ++++-----
 tools/include/linux/btf_ids.h | 10 ++++++----
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 87fad4076f0e..00495e7833b6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -558,11 +558,17 @@ static inline bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
 	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
 }
 
-static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
+static inline struct btf_id_set8_pair *
+btf_id_set8_entry(const struct btf_id_set8 *set, u32 id)
 {
 	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func);
 }
 
+static inline bool btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
+{
+	return btf_id_set8_entry(set, id) != NULL;
+}
+
 bool btf_param_match_suffix(const struct btf *btf,
 			    const struct btf_param *arg,
 			    const char *suffix);
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index f27b7db81100..f5985acf661b 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -19,13 +19,15 @@ struct btf_id_set {
  */
 #define BTF_SET8_FMODRET	(1 << 1)
 
+struct btf_id_set8_pair {
+	u32 id;
+	u32 flags;
+};
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
-	struct {
-		u32 id;
-		u32 flags;
-	} pairs[];
+	struct btf_id_set8_pair pairs[];
 };
 
 #ifdef CONFIG_DEBUG_INFO_BTF
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 228b93d4f8c9..61d2df6776a9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9973,8 +9973,8 @@ static u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 				      enum btf_kfunc_hook hook,
 				      u32 kfunc_btf_id)
 {
+	struct btf_id_set8_pair *pair;
 	struct btf_id_set8 *set;
-	u32 *id;
 
 	if (hook >= BTF_KFUNC_HOOK_MAX)
 		return NULL;
@@ -9983,11 +9983,10 @@ static u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 	set = btf->kfunc_set_tab->sets[hook];
 	if (!set)
 		return NULL;
-	id = btf_id_set8_contains(set, kfunc_btf_id);
-	if (!id)
+	pair = btf_id_set8_entry(set, kfunc_btf_id);
+	if (!pair)
 		return NULL;
-	/* The flags for BTF ID are located next to it */
-	return id + 1;
+	return &pair->flags;
 }
 
 static bool __btf_kfunc_is_allowed(const struct btf *btf,
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index b371ef7241b9..3b5b2856c628 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -19,13 +19,15 @@ struct btf_id_set {
  */
 #define BTF_SET8_FMODRET	(1 << 1)
 
+struct btf_id_set8_pair {
+	u32 id;
+	u32 flags;
+};
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
-	struct {
-		u32 id;
-		u32 flags;
-	} pairs[];
+	struct btf_id_set8_pair pairs[];
 };
 
 #ifdef CONFIG_DEBUG_INFO_BTF
-- 
2.43.0

