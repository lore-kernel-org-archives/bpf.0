Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9C577E58
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097651; cv=none; b=QEGDPq1GBx35FdEDpvYJP75rnAeft6VUbzS16QvntC3+f6FzN7DRWQIO+hx66vOJP5JpH6Hb7rbTPdwgiHw5jtADeeSenC+4yjdKdysSniip6ERl68XB9wAkaHeNrKCGA1MUEYrlbE1HDmz1/v+LuGjdHi9oHXlFfUORiVVaBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097651; c=relaxed/simple;
	bh=E/TPExh1jjASY70ZzGIGurLuBPP/eWZW8hPMLwtO8CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOzzZHw1B0kI5n1RJzOEHpI0+Rf35401aiceffIGUCsg+BQ4P3OA12fIyCaUMwKrw6kfSN5mvu/W9J710kgxwRp+xdtfqUKPwIdZat+qmwVYwOoOPGdMAw4C7qrTb2QVw7IRt1M+LbwjdilyS2bGCO+B0oAfT2thccgWfiCsQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=B1OgW+Gx; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="B1OgW+Gx"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d740cso142241a12.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097647; x=1790702447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=soLt40mP+bRJQKkxwxoTXZXIMy6sUfgHio+5spPhnfk=;
        b=B1OgW+GxxMbIA3DYsDk1X07BipTZ2s3NSJ2uuoVXZSwVJtTQ8ORl1bnkSiHtaMALhb
         C+yJi3yQ7+sQXuqbVTQ5K9DpGrOkF+TQ7EOUaTHKz0FdOq1Y/h7U8oVWixwIWg468Nyj
         oVs18l9+ai4XEeMSVm+Oqp5jF+ikCBXZtOIyc7i392PwY3INO1Xaw7OlGSBdlfEh1saf
         VolOaDzTRpCJzAHd/kD96IK7G8WwkAaXI95i44lIo9Q9OX/wn8SQmIAwDhMkxqeIBSC4
         ahCzONR1m6U6sWdBpm6QjAomnsjdyHlq1NQAo9XnbQ2IKl5ZYlAeIDZGPq+4Rws8h2+m
         MHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097647; x=1790702447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=soLt40mP+bRJQKkxwxoTXZXIMy6sUfgHio+5spPhnfk=;
        b=CAwS95Q4IRddw3C4nlM1KUkD2bduX7tOr01hRsCSMXVPEU9ouIshxJg6UOG71B/9Q/
         L/TAHWMRSkqlFtZCaaUxRIHbnIl2lWhtM1erPOiEV8eLl9pUVH28rgulqocwYvpmK0ms
         hRlHkTDWTIfTDO2m6iGnvPw0y+HUBJN1hAU1BQ+X5MTfA+J1hHsFjiJTXiiJENZeem3B
         cdFMzeVr3QyqDWtaKb8j3WUbxBXapbN59ULAYBSeWpbh82sbE+X+GB9Ya8/uUICRDEri
         CB5zuAAKyycboS5ohkR9kRIQjMT6+jD3H4IILQT2xmEgf3MA5oq/EmRgyU4g7I1RWuoF
         szrA==
X-Gm-Message-State: AFuF++n5ynZcf1pYq02IrW6t3/bwKS2KzxeG/3IJcK6br5bkSR7BWLf1
	m9H/eYwKq5xbIm0lmZUWWCqVBGBkz6HITFV0ikkBJLPOjtknxXPxdSNC8cb4VfHuvsAJsf6zVAA
	MYqz9
X-Gm-Gg: AYBFou33lE0ug4AGyQJOZM5mL7PogGhqsTPtCbozd4CU74S6OeygUv/c978eJTRLVp2
	VJUuwO89IhfyU6ujCJA+i7+kbNGPLUFI8dkMsnownx/wRyoYXXIkPgIQ0LH0pbqQWRVYc/b++Fo
	vOcrglDCcEpLFddqCMCoB6PSobjkU0qNIWd9g25L+GlBU+OK4FCcGN8UaluxLJaKBwEXpw8P4Et
	sz/W6i6ueZVG7qJvs7E9nK2KxIrt1vWRCLKrG2A2uIwcD63KYlbpgOSABq3iwvhMQN4ydlDmZlk
	pjMGs91FUmHI9DHc0cFOuxztGSsuqTmNWir/vx/ncHqjGqQyJWzLE5PSWrK4XZIQ2qck66Ylr9x
	kJYtcBZkUO0kSWaOgC0qjkTC30xoHUlYeFKLjtdHp3rjGlooj76ETaJx8zPk/A2qFDqGWXpt66g
	0cVfGjSJb/DrCeGBoSJ5Xpn/BIeZEV/o1uxyx4sl9u2FC3DjYy3vFXjuX0XShXGwwkuAs1BSO2c
	gE0egSvXrOsa4OP94HBrXewB1tIkL4BvTwzbfVdVsk=
X-Received: by 2002:a17:90b:3e4c:b0:39e:6a81:f352 with SMTP id 98e67ed59e1d1-3a07e6be17dmr122474a91.44.1790097647174;
        Tue, 22 Sep 2026 10:20:47 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:46 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 08/11] selftests/bpf: Test for mixed arena/nonarena code paths
Date: Tue, 22 Sep 2026 17:20:25 +0000
Message-ID: <20260922172028.6269-9-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to confirm the verifier rejects ALU operations
that return arena or non-arena results depending on code path.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/progs/verifier_arena.c      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 332322c9b..1ce9c4b78 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -561,6 +561,55 @@ int arena_ptr_add_arena_ptr(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__failure __msg("same insn cannot be used with and without arena pointer")
+int mixed_arena_scalar_alu64_scalar_first(void *ctx)
+{
+	volatile register __u64 reg asm("r3");
+	__u32 pick_arena = bpf_get_prandom_u32();
+
+	reg = 1ULL << 32;
+
+	if (pick_arena) {
+		asm volatile (
+			"r9 = %[arena] ll;"
+			"%[reg] = 0;"
+			"%[reg] = addr_space_cast(%[reg], 0x0, 0x1);"
+			: [reg] "=r"(reg)
+			: __imm_addr(arena)
+			: "r9"
+		);
+	}
+
+	reg += 1;
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("same insn cannot be used with and without arena pointer")
+int mixed_arena_scalar_alu64_arena_first(void *ctx)
+{
+	volatile register __u64 reg asm("r3");
+	__u32 pick_scalar = bpf_get_prandom_u32();
+
+	asm volatile (
+		"r9 = %[arena] ll;"
+		"%[reg] = 0;"
+		"%[reg] = addr_space_cast(%[reg], 0x0, 0x1);"
+		: [reg] "=r"(reg)
+		: __imm_addr(arena)
+		: "r9"
+	);
+
+	if (pick_scalar)
+		reg = 1ULL << 32;
+
+	reg += 1;
+
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0)
 int scalar_xor_arena_ptr(void *ctx)
-- 
2.54.0

