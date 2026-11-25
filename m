Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641436;
	b=XPWalL7ODKJtqQh3W/dFfhrlSLhaQ6i6UCdWhjZ7LtzqriRjI2MHspBP9RTsZurAm/HG
	 EIRf8t/YUaDJmx1gC+NVRVQ2I7t7oAKpmCA9yuzPsA6lkvHzp4Pou+VB+i9rR7cW0qaq2
	 gd9V0SbulRsu+e8WgNj5vsKTB7muwqIEB4yen8ln/KZpXhb6y0IaO5J8a1hPmBJ17sv8v
	 LL/xWYHjLRd1QkIqxsW23V2PsVfL3ppkjj6d4fr/LhicF6TIsopczYGsVPUIp3PAeKE9I
	 W11igcvCAXK0MNdC7M3161g7VKWcNLl4xT9BY2cHZhkA5m06JhPGnxyyHBVbyofXNyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TEG9M41Q8ewXtwGQfG4tnvfBTrejLAcva0flrqD/WdY=;
	b=3fzBWxfZc+tq5QPlsrei7KOaicmh7bI5XUobaIxh0Ehq846Jl2PphZ1ykMRvdwjPjczV
	 OBm563eYMexsNlWm8/MC/8U21+oxpS7YtRFwfO46TLKGaOj9wLJFKbThIZthvqCnFrJMO
	 t8XgQKYo0MP0CPYbmtOGWxOILvROLpLTBWE3XfXFIl01OUGUCINDuIuvHcRIE8+ZPQeyg
	 +KQyRqV5BcuxVFH9HeAl5/E46oRW/ZyrlNHHSmeqjAvoP/YZirIbbtSwRlLEf2lhFcbSB
	 amS+DDuFL0eBgPKIDK5xnCc5CLWECsqDcTy9icmSA5ME2MbMQO5Qr2n39s4G3vLwjmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FAvBaeZt;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD36606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECD36606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FAvBaeZt
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a42b34e930so5473006f8f.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641434; x=1796246234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEG9M41Q8ewXtwGQfG4tnvfBTrejLAcva0flrqD/WdY=;
        b=FAvBaeZtkzHiDon0djemThMFyxKFFEu0d4AoC4xULyl5S7Nr17uvMUbf5ajyGkkJYO
         M+OqooMcQ2oma4u8ujmzHXPp4+kzQZATskLNYrWjFva6ahBzUDmInUCKigP6TWOb6P7X
         4w7LmOoFcYKBnGPywxiJBZB1k+BjfzHHehtZU1MvVhhlYlkOR2H2g8p4Vg1HuoWAJG8S
         JlqTzG3jUnKgVedyGHpwL3jO2E2C9PM2Ivyx0cjQr4cTHjkP1fp0xhRANNeFP5Jga68L
         Dn9MqvXv84HG1jKzVTFvxAcbTsMnNb2kynI5mFEO0FW3o7X9s+mz5IiNmZAGYSxx9AH6
         Va6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641434; x=1796246234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TEG9M41Q8ewXtwGQfG4tnvfBTrejLAcva0flrqD/WdY=;
        b=0HXCNPdG4RW98m+SyLg6rLAGRW8atHGvFPvyhawdm/BW2+UUc0+h+jDe34UqjtUp81
         5UjZp6uJPTrtwyWuKGCiIrD5k6Q/IbvS9wRkPSWImqaj5/VkSkhRCljScHe3X+cEiOb0
         xH4btXg9dNyPlqNKp82EKwhqQprpWVo8sInyDbKU8HFetMreBdjauGfvxLErlLoyIHIt
         QR+GnuVI2IV5Mnp/itTnu52RWVOFKwzphhOrbrgWSH6M+GzG2zaw3ShU2IvxKf1Y+mtj
         +rVPUnjipkRNPOMMHfY8PL5PeSextdgu9SvbJgEfGBFEOlp2VX8xBi3xCNV3/Fg/L2yi
         +hwA==
X-Forwarded-Encrypted: i=1; AL+hErGdXd+2EPpLUQKmg+nQpjB+fjIESRSFgWsq2VLTxJswx4es6nj2/1StQAAC57FcX4FprDg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0OtzYZBSwMfXyVpU4DlPSKbEyWaa4233pitqFpnQ0k397TEtU
	/eoUyVKgppKdrlZUjVqdmD1pRpCRar8IDDYiuy6kUdYOnCTmZ5ZZgkp3
X-Gm-Gg: AZFdTZcQ3EvQGDh78u95fAN8dhsc8JtHvJlMKCHnPOhkYHonB2Hsp12GmrGR1ga+o+A
	v3xoZjgzQiCQowyAMjA7ptjO4Av3mUN5jawmtfsm9fK60x/6hh96kt8kG4XIEI2vKzSggWAhulN
	TWzYBJMT1KsXL/ZEmdUvmjrf4szYY/68M+SORU1Q+rMxEeu1OzZ0vanBpZOUIccvHuBArYKtcxz
	tktKFQWLgN7zKt7feej3LacSrTAemF/5TRR5eaC3L6dImQpNWaRyudnJI+4zY/ruCtqfa3oclXA
	zUOowMUHy645I/CMcbJryJhZk6g+9/PV+SXYW/6d6ZOw0tB3tssDKLsEDfAzjWlffa2IZSIi5JF
	lWdDGfPdhAXndh3CtRD/rwGPNAecQfNqfk/6nJIAvcXUbfeYpAi+SFPLeKfpn4xmo4bgIAW6xF9
	ce7huJAXDaGW1H8Syazh54FbcBu5FuU8zR6culbJ/034EOk/4CRKHci63xmXATTZSLsjMtXOJVh
	v3hFdB71bZSuJjJfcz0EnL7NVSV4a/zSyq06hLfW62FOmdthXEWh4PFWGacmgnBdtgeWN6TlEDZ
	Gz4NV6QiJwFkXQ3+ZPLuAJI9fDX+nHtwQIeBsAQ6k5t1OtbjmK1dugrNpRno+tKsloUn
X-Received: by 2002:a05:6000:2893:b0:493:f3f2:2241 with SMTP id ffacd0b85a97d-4abb272746fmr37510665f8f.23.1795641434184;
        Wed, 25 Nov 2026 13:17:14 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm41840507f8f.24.2026.11.25.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:17:13 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 1/5] resolve_btfids: Do not tag functions which work on BPF objects
Date: Wed, 25 Nov 2026 21:28:34 +0000
Message-ID: <20261125212849.868523-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125212849.868523-1-a.s.protopopov@gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com>
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

A program on tracing_iter_filter() which returns -EACCES makes the
verifier miss that a global subprog throws. A function which takes or
returns a bpf_* or btf_* type, or struct btf, works for BPF itself:
for the verifier, a link or a map. Do not tag it.

__sys_bpf() loses its tag. A program can still deny a bpf command on
the syscall, which is on the error injection list, or on a
security_bpf*() hook.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/fmodret.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index e1afdb6dedd5..aaff58718da3 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -56,6 +56,37 @@ static bool fits_trampoline(const struct btf *btf, const struct btf_type *func)
 	return btf_vlen(t) <= 12;
 }
 
+static bool is_bpf_type(const struct btf *btf, __u32 type)
+{
+	while (type) {
+		const struct btf_type *t = btf__type_by_id(btf, type);
+		const char *name = btf__name_by_offset(btf, t->name_off);
+
+		if (!strncmp(name, "bpf_", 4) || !strcmp(name, "btf") || !strncmp(name, "btf_", 4))
+			return true;
+		if (btf_is_array(t))
+			type = btf_array(t)->type;
+		else if (btf_is_ptr(t) || btf_is_mod(t) || btf_is_typedef(t))
+			type = t->type;
+		else
+			return false;
+	}
+	return false;
+}
+
+static bool has_bpf_types(const struct btf *btf, const struct btf_type *func)
+{
+	const struct btf_type *proto = btf__type_by_id(btf, func->type);
+	unsigned int i;
+
+	if (is_bpf_type(btf, proto->type))
+		return true;
+	for (i = 0; i < btf_vlen(proto); i++)
+		if (is_bpf_type(btf, btf_params(proto)[i].type))
+			return true;
+	return false;
+}
+
 /*
  * The codes of include/linux/errno.h, 512 and up, never reach user space. They,
  * -EAGAIN, -EMSGSIZE and -EINPROGRESS tell the caller to retry, to go on or to
@@ -220,6 +251,9 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		size = int_return_size(btf, t);
 		if ((size != 4 && size != 8) || !fits_trampoline(btf, t))
 			continue;
+		/* Skip functions which take or return BPF objects */
+		if (has_bpf_types(btf, t))
+			continue;
 		/* Init code is gone before a program can attach */
 		name = btf__name_by_offset(btf, t->name_off);
 		func = image_func(&img, name);
-- 
2.43.0

