Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794106622;
	b=UDWITdM+hu9XBljhMS8xKIpQkAiy3Nk63k2JWMjPNDsNmT2Vno2dhrdeBbOsyzh9HlbS
	 QSNGHEP45t5epgqN/A8M73unr5E/A6Ju7iEvApdqhLlvqn3GWFcRQuCDmxOKYM1KceWtn
	 HnY6ZE2sxiPhHtub2gOxGCbZ953uaSPJko/YaM3xla51FhTJ1x8DCbrnvXGqFX+9v35KR
	 I6jn3rhy7AJt9F9LC8nq93g76z23TsfuhuFjVqv2KwUCC+OW+WWXgeIbnRV2emwm9w0/u
	 E031UoQIOvmNjuSc0a2WFMjE2MIzE6lG44y5iQ3PMKYJR2vco2gcrdwo7XKUDlf5Hjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794106622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bvSsXHgLF6kuuQ4pQY0Lp4DI1Bm9QjjpbUjDZ0uTeZo=;
	b=cgJJoAJsuACpx7YY0RRVhiq58BTUF4gvyWPcBJ3umwQq1OGIWm/6XL/Bgvn0Hqw2t/We
	 khOPfNZx3j8JZE3OSngH3YjxfTw48TnP7cJdD0n6ML37EaylPVtEeean1oDlBI3Ufr5wJ
	 arhIkynuWd+knmpk8STKpn4i312ZtLXBIOv4vqVDgv3JVXqTTtBfQYNBuJSvhZSfc98zH
	 I6/Lvw2UmNc9YCTkVitxJnKnHq0RvsvMPL7cBwUQb0lCJsyeZ2hb7z0mID2x0KGEitWnb
	 tfbofBPSh8TMfRadna8CFhenMn6MwzNsYtNYV+ueE/v3DwRN5/bt7a3ANSwxv+EUW7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aZGS8xjZ;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47556606A33B
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 02:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47556606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aZGS8xjZ
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36f645c688fso81414eec.1
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 18:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794106620; x=1794711420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bvSsXHgLF6kuuQ4pQY0Lp4DI1Bm9QjjpbUjDZ0uTeZo=;
        b=aZGS8xjZJksfJYKzfZs4giH+2hZiPcHfLatACHE0VeFsbi72N5654l/TzjxjuF1IuW
         jT4boYASs/6eFcQ4drsiXGbcTeM51/hAA7JbwGAbIcAn9HzZwLwtdkz5qLszK/I84IwZ
         tvN9b3lboPm2RwG1i8d9BSTPcUmh3b3F/OX3ovK8jBFUMdSMiqQoRGJPY/r+lKKLK4cU
         sukynaT3VDLtEuBwlXWKHTDc0APElDlqhBuIqBHO7xyKPmQ2rKYhRB8IO49ICF0XBsiM
         7C2kMpkV8I37G4xTB0GCbCOpBF2Ah2OeGVWX/3tbO5NmYevkoD0dbQLjHyvvrt4rZ3un
         gu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794106620; x=1794711420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bvSsXHgLF6kuuQ4pQY0Lp4DI1Bm9QjjpbUjDZ0uTeZo=;
        b=WvH/wz/13eJZSfb1Bsk0ELZcOdBLS0YIzH+sBfXSmC48sOJSvi+u9NNgo3Z7c2Pn05
         kpZIrkESUr0WB7BRTogLm9FAQ6NXg0Amgjb5gYJUuaAhcBb68De5lvrlIyEmnh7LouzU
         MQm8FxCltuWAXKV/EnLERy1APEEEs/Zf4Xkc1W+4lbdLqOj7HAF7GB1tKs4xjJBs4908
         p2PnoKTLiHXLZt3+2Wl6/ChGD6eIEAbgH1nCuQqax2bt+8CTDq/xQpljEPiYmVE8tMkl
         +SmPjtrSfL3/GcqBowba0CCXety9TKQ4ioswKVuDsHo+kitAZEHz8LQpcH5gASmlyGOD
         sgXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGK83gTGQKQoRj2HeViYe+iZNlxhATNh9kFhO7viVsNTbacyRHIA0rFOCpV/WuwWkwGiA=@vger.kernel.org
X-Gm-Message-State: APuU4Z88PAQJcfTx23k+M7L84Miji0RjFpreRfDCIFU3QRFcCMu/MwgD
	M200d3HVdXy9L/zZreGxUWOy8nayG/udzth0o3gz+jUPyi2o4NwyzV8a
X-Gm-Gg: AYBFou0NpOK8qZAdqagutFSxd2p7qo1rMfxwTPgGr3ZxRD5p7jZE83gobljEqlnY3HE
	DHZWxpVvSCXJLi+Mhz0DisIMIKQVhfmDHurFfpPb5ShFIoOOsSKCu4Ztv/I8A3dudvXwLOs6sVy
	K9XqkE+HdxiUNywwP605eP1Htyxsj3A478pQzmndzShVCX72gDW2a+U+aqqIQt269FqMp3Vxk4B
	JExYfdmlYe7+Pdb5Vc9NYzagcg6oCRkn1kxbiPO5HIfeIif4lJMTfAYSzo7jFH2nAOgjWOgNuQ1
	rksgIJkkXC3L11FgLzKNkkqKr4daKt380+JCja4EGy4QSilljkulbgP/DcEK+MgwRaR136IzMck
	szCDeDqtXTRERww97NVkNrxFJ6eyt5I+yF3gM9xwQR2avkOWIVBSh0eAzpU6B+NOPKY0Kn2ymyy
	jEj6tjnLWdYjjRVJO7OtADq28TP8GKv36SxF7POYCHd52r67m+n1e6/2JrII9k5IUnMY8ZVoklY
	CSO9B5YwfrjCWMHvpa4j7Rmqiltqq7WnVso5UCxp39BR/eQ9csja2vJhZvo4byrqvncCH1R59Qy
	C9e+OqWB8uL1gcag57mqH/gv192UeZnosRskRaTA/pF4PdLohvI7BySjYId/u3Vmn9uKYXtCXmk
	E55mecWIn1MkSGXLRgmWE55DHcKW3cQacuew2KQ==
X-Received: by 2002:a05:7022:140e:b0:15a:4155:3d9a with SMTP id a92af1059eb24-1b39fedf712mr599512c88.47.1794106620308;
        Sat, 07 Nov 2026 18:57:00 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3773ea50asm2241202c88.23.2026.11.07.18.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:56:59 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ast@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	qmo@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next v5 2/3] bpftool: Preserve unsigned enum values in data dumps
Date: Sun,  8 Nov 2026 02:56:31 +0000
Message-ID: <20261108025632.10799-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108025632.10799-1-dennylin0707@gmail.com>
References: <20261108025632.10799-1-dennylin0707@gmail.com>
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

btf_dumper_enum() loads ordinary enum data as signed and uses signed
numeric output. Unsigned values with the high bit set can therefore be
printed as negative numbers. Narrow unsigned values also fail to match
their enumerators: an eight-bit 0xff is loaded as -1, while its named
value is stored as 255.

btf_dumper_enum64() likewise uses signed numeric output for unmatched
values. For example, 0x8000000000000001 is printed as
-9223372036854775807 instead of 9223372036854775809.

Load ordinary enum data according to kflag and use btf_enum_value() for
name matching. Select the numeric writer according to kflag for both
enum kinds, casting the value to __s64 for signed output.

Fixes: ca7e6e45d108 ("bpftool: Print the enum's name instead of value")
Fixes: 58a53978fdf6 ("bpftool: Add btf enum64 support")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/bpf/bpftool/btf_dumper.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 3267163119dc..a7171622ce57 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -149,28 +149,29 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 			    const void *data)
 {
 	const struct btf_enum *enums = btf_enum(t);
-	__s64 value;
+	bool is_signed = btf_kflag(t);
+	__u64 value;
 	__u32 i;
 
 	switch (t->size) {
 	case 8:
-		value = *(__s64 *)data;
+		value = *(__u64 *)data;
 		break;
 	case 4:
-		value = *(__s32 *)data;
+		value = is_signed ? (__s64)*(__s32 *)data : *(__u32 *)data;
 		break;
 	case 2:
-		value = *(__s16 *)data;
+		value = is_signed ? *(__s16 *)data : *(__u16 *)data;
 		break;
 	case 1:
-		value = *(__s8 *)data;
+		value = is_signed ? *(__s8 *)data : *(__u8 *)data;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	for (i = 0; i < btf_vlen(t); i++) {
-		if (value == enums[i].val) {
+		if (value == btf_enum_value(t, &enums[i])) {
 			jsonw_string(d->jw,
 				     btf__name_by_offset(d->btf,
 							 enums[i].name_off));
@@ -178,7 +179,10 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 		}
 	}
 
-	jsonw_int(d->jw, value);
+	if (is_signed)
+		jsonw_int(d->jw, (__s64)value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }
 
@@ -204,7 +208,10 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
 		}
 	}
 
-	jsonw_int(d->jw, value);
+	if (btf_kflag(t))
+		jsonw_int(d->jw, (__s64)value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }
 
-- 
2.43.0

