Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328185;
	b=I75sikQjOGYJXlUuQadmHttbCI6c8n03gGKi+Mlo084+uEhtim2a+iwURIQdN/fBJbcF
	 3wYsO0K5BIomLkCneuJ2dD6sF41iu1+lww9WwZWJlUpnM47Q9Ev1eMc3BSl0mqdTppHlf
	 CIJZVBnAfi6lVCaQf6LxqXscQCcuM8MXMeLIQCJCVSvMjuQj7U2eRFA5PFBtm6eR2ZFUp
	 cQjFdVu+Xvy/gok5T+QOIYG1VvTUraLRG91U8FVXs6yJ7IJiWdhz6+zZIfG0GIAiVtgJS
	 chSLB2IZfAarXddzcKvTU48O4wiaWrAK5AWVGF6LNc/8p1xZh83QaA02hWlQ4PfIApg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hV6F7yYjnqHSXEHJzA6+kFWKMIKY39vlSpHiYUGRlP0=;
	b=al2IRqpIzIHBzVCgJino3V0BLk/NyW9FvBLdkTWi4JPisDaUuIS3sP3svXtVvYupo+VJ
	 +RedOutPI3cos8g6qCZc5XpK/jB6lC3kNuTo14ADvXzFk/VhY6WHJ2njOI18Lbz/GWstz
	 xfOpGEKDD19Udz8DMaisTA0WJwpADJVKH8eDeJXqS057aw5Xatu6GGSGrIzs0po6GgZ4a
	 +LOzCrQQX7xqAUZvccQL9EJVySKz6HoDMd6tLoebIYjkwMMgD+yY2ylbC/gVdZcfX4q5s
	 vQxFpbedMyY5URMWfkU6g+TAAKk7btadZc+gPqt6Xt2ZXCCLgfK3M7PcqwkQr1gXW/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lr1nJCsw;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3900660A6F77
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3900660A6F77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lr1nJCsw
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49134c8509fso1818412f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328183; x=1794932983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hV6F7yYjnqHSXEHJzA6+kFWKMIKY39vlSpHiYUGRlP0=;
        b=lr1nJCswxKRyPGM/46HaIs+xOyWtjUrl9/kBRj1lBdIljOXcw89Qeyq90My77URS6+
         57NXP4jzbNryQehACnr0Dm0002e640ssXBtS3jmSI4MMTgitqocnTPCUjsMJCqGAvkOe
         CQj/CKVBahW82rIa7NBGg8J2iMyFims/5fOZZwPsgP4jz0wz78/3Kc+FohSpMBw1LdWJ
         FzEnRLWTomW4ycl6My1zGw6qOeKmvGrM1n0JQmrSGcEJycbyom32ZcZY5yZ9RDqaaPcl
         ribXhZq/6HtSD1KgxmaKVF0p49JH7lEMNL1PqiprhW0pZ5T+fq6QR0pUBomgaiJC4v/l
         zcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328183; x=1794932983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hV6F7yYjnqHSXEHJzA6+kFWKMIKY39vlSpHiYUGRlP0=;
        b=zu4q2FmznTxo/mytShWSIR/xhlICTvxiNTM+WXKJAOnPpYjLqFKP3r8dIC37/loi43
         LpBcYt39EEDewyBTPUp/rKmdSPO0S30QSeuG146PgM3JG/RzPHN5eESlaxzSLV3MFM7v
         S8e1Iq8vJfWAKaXpJRZbdM/jnvz+c0uioa1RoqveEQG6paC5vXsaqQU99jPWV5dfjIP5
         QmO36upk6ekhtYCgjB0eUOjQOszqyVLuXvXewpF/Q5ae7/SpAgqzJZPuSRFweTh0MfvC
         zEZI5RFo0bt4yX/DsWj1nO803A3MQfXkrkzde0SDs/jRzWsMvmMvpIiw3J6lGS3+YZ/J
         0hog==
X-Forwarded-Encrypted: i=1; AL+hErG/kvfHUT5cxPyTrA/nvCectGzrz91TvHVN3/akNyLaxm1zCUdagEX4eL2S6cbNpPTJtOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z83/D6dDWAA3drPVCuXSWURF/nOkFRJZUa0KkSQcSa3msQBWI2+
	EA7XrBiHJ0RIWyxclbo7auQH2r5Or1B0Vu10+rAJ5xhax0eBeophyj1u
X-Gm-Gg: AYBFou377uEkHMry0KXfHNgS6Suou1DJslHUbY5Erwc7PuaONGQEcFHOj1R30DCMBIN
	apwzdbSynESf8M8agAJkRbsbVqzY4linmoirjEMgM3uDEzwRZIX0iFEFay5cq1jNKzbvS3uHfHu
	UyQoqrl8e9grJArExngRmt2IHJHwW//eKKqdCwLEbZ9y/QpWupmlQq7sk5glAr6MQAx1Iopy2SX
	m96CnTxFktLoZ+G/30v+80prpMX3qLg109cvntKnezb2Y83a9ooixV4NDtu5u1uzia5XKj505LR
	bF+QSbIiqoRFJChTXdY8SKStQloeOPmloteogKCCF45EHuIe+tjnv1cZOjO2OTNjpFVoOn1tnnQ
	22/cu1VavBMm7LXJb8xAT/SY4G021FdYuKrBCTSRyb7gMrNJ4xbYesVGyBPGRJk0wE6VprbNw3Y
	UYI0nsdyrmbLJIcbbdyPBkC3R/TmpO19fQ6o5mSrIn/MJx2J0mLEMJCyFJd7hizg2s89gtMLthH
	4owqKrab8z362mGD+cPUgdPj0ZSNU7C26k4uD8z85NYkh5FixrMw/MgiWuPXNjP5VaiVrL2UYY6
	FmOdZPMLDdgz9QeNUsQeRvFQci2+o0tRlRR0YLqRGhaTT4E=
X-Received: by 2002:a05:600c:34c7:b0:4a2:133:45e1 with SMTP id 5b1f17b1804b1-4ba0234cccemr51157495e9.24.1794328183482;
        Tue, 10 Nov 2026 08:29:43 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:42 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 14/18] bpf: Require the JIT for fmod_ret programs on found 64-bit targets
Date: Tue, 10 Nov 2026 16:40:34 +0000
Message-ID: <20261110164046.454431-15-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110164046.454431-1-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
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

The interpreter returns only the low 32 bits of the return value of a
program, while the trampoline passes all 64 bits to the caller of the
function. If an fmod_ret program on a found target which returns long
is interpreted, then a valid return value like -14 reaches the caller
as 4294967282. This value is not 0, so the function is skipped, and it
is not an error either.

Require the JIT for such programs, as for other features which the
interpreter does not support. The caller of a function which returns int
reads only the low 32 bits, so nothing changes for it.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b12b57c7403e..920ff39aac42 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23883,6 +23883,9 @@ static int fmodret_retval_init(struct bpf_verifier_env *env, u32 btf_id,
 
 	aux->fmodret_retvals = retvals;
 	aux->fmodret_retval_cnt = cnt;
+	/* The interpreter returns only 32 bits */
+	if (size == 8)
+		env->prog->jit_required = 1;
 	return 0;
 
 invalid:
-- 
2.43.0

