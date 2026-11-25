Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601812;
	b=pohtyQONNCzkiE+Dp4HzEfbi2YM+j3Mcnob6Z74xOgRHnNbtpFoVj8sXmmiUCJKPi7uO
	 4GlG/hGMIGdquKv2/7mdrV2E4aL6RpD3HHijNOT77/+ZEEN0N2AybOdb/Q/90cjfhtTFy
	 +kT9vH83oGDXvCV7Zn/tbeCGlOM9OyQNNZqPECSZSH/rMkQjEVIrCnIyRj0RTgy0W/K0Q
	 A8ELjDjP+yBhMk+GxKio2L+ljLV8FzaWxgZaeUwbvr+lH3Sy6br37x+KP3nCVBTCUax37
	 DP5DUmYC8DjrxwwC6knZzPcXD6a2usDsAvzxj0nGOWnuCQdBIUtudvZcczrR/bxqkyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yvhCy1uyLo3WXvylX0J/Y1cR0aMs++7n1SNGJRrgLa4=;
	b=QVsLQOeAvmFx9sPdmVHHP8ihn0vtcABPsdI85FV82eM9V8Qn7SUT4axW5KgY6BC8ZmD1
	 wyvBKqfVPkL6kHdknv6slL5HkKFY5XM5IausrWa6wyGOLuS7Jy7wRo0DQYJk4G0pMIcQk
	 HxvOxszJfAz/LkmXol+/UC+3KCP2sE1ieTka/Cu/2WfFK3sjtw5GWxLF5rYGucSWFPu80
	 4Wf7dAOZAlBFV/sMWcDSIG0JVqE5jh+4q2QrsnM08yzjD53OghYvmr39+TmnNpcYl1H/f
	 KfmRMxvtwsq5DKJBZwq9Rv1TDykHXCTW/PynAlmlBeR/kQ4YHMRBos7xBZWy6GiB5Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bUFapKYe;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66D606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA66D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bUFapKYe
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so8623705a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601810; x=1796206610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvhCy1uyLo3WXvylX0J/Y1cR0aMs++7n1SNGJRrgLa4=;
        b=bUFapKYevx3eyk7/2t8/7sInQ9DSReEmckPihk8yOraigjevCcmrXcWoLEMs+/rh3v
         uvTV3DodS9jQcVCdqnULkDBMdV1WJ9P51El5Am7oR3IIo95xaX/DCaH8hjuKEYZ6NRlz
         TbpbwXjRQwh0fRvClXhi1irOOfM4XoY7lF6m+RWr3YskicWgEtVZJTRyofgXNNVE3ytu
         gQhL2/Sq3lsIm8EPGOB7DosF3BR/PZITXYvEyA2HheBwHMuwjUZ3hdWxhVcqGldma3lX
         X8+epNOrSueqT7VslJv5tNtObx9ydZLCsFEI8qsHOkoOjMLb4nz07clOftQUmiTO4g7r
         4wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601810; x=1796206610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvhCy1uyLo3WXvylX0J/Y1cR0aMs++7n1SNGJRrgLa4=;
        b=mFLv5jopZsHWSLysUAF9EhYiRQ58IFuCcf5c4/YShYfqeQRnZ/YICltlvSrP4Kqala
         U4+6LN3ld5TAQ5lbPHyYbYNXaaLS5Hp/Hz4Y8e+t0Ma3gg5C8RqPDTIid5PrMppLa9BQ
         8rknptuJAdHb7IvC+QAcSSTTUXoInFPAiGGupofHJkkthdF4S4haFWWT6glL0/L60qT2
         xNrms67+xFkYSXs1cJTIBAsQAWMH3jdt3ikriQDh/5KNUFpxeElSiqm2Crt574HVUMgc
         xClsOV3swXpYh/nyVogzNFxVPFOSY2ztYnCJhFKqgvTcl47fyp0TOQcEMiDUuGvLt/ee
         X7wQ==
X-Forwarded-Encrypted: i=1; AL+hErF3JF0uJCLmy0CXR8XQzknuU90S3Y1dmkx7nOmciVWziMx7xMFERLS5fTilfacH2B4E2NA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EeUuR6UUbRSYM60paOUqO0kDEXPcAzMEt2Xm74y83rCVpaZ1H
	ANLE509onsRUQQ2fEMryUEHuJlgftJUo0LXfQg438jYY6geqeM1Tzfci
X-Gm-Gg: AZFdTZeJt5nicyO6IdPmG1a+H0Xdt+s7dN938gWOOBJcCHNJqb0t12RTgKgWqs0fRCQ
	YimC5LBqcP6L8Jn/5dlQqSY1gKCSLv1qlIs0Lyx5I9cNCdHofoHx8zq7Qjh2GooVwkKb1NZieQB
	U8oGYSZ7xSX4X8Yn+TJq2bPGc/jAWpoTl/gK4i+H8e1Hsvb6Ok0OdtDsxq4nk7urlifa9C0Up7t
	ABf0zcAcgHX0jgKPrloOTI21o9xmUxCurGNNrtTG3mYJIj/8t9TaYWq2sjezcxxIo5vbjq933fq
	QwNJtXicWVrkFNwrTkfpAbs2NfbkijHVZm9zdxoDZzhKXL23i77fBFkIC2AIarrd9aPcUVc3WCB
	0wjZUgtVZZ9YcXhW63eCEeLD2ESVOyQYjaHu4bBwJlIEj/zKI2/qLG7aY6ec1dHMvvdyPyymwQu
	olAWnsQn0dIBJ4J0Yt2JxSZKyx8ca9ZyUozDDkkOSw83uqhJ6oPvsTBfHnsH29pgheuMRO0bk7T
	o6mQyAfNgi/NfzjBCCod7Eim7n7lSpDMtDqTitgQCLACikhMU9WNFb0d6VQs0vf8E93adNpWkk5
	T/83LlVMbTqU51WZMXHk8D36wDIjbVsHIa0s1l+TqPSeTgE=
X-Received: by 2002:a05:6402:42d5:b0:6ba:b20f:60ef with SMTP id 4fb4d7f45d1cf-6bab20f6810mr7105981a12.14.1795601810083;
        Wed, 25 Nov 2026 02:16:50 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm34765938f8f.29.2026.11.25.02.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:16:49 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 5/7] bpf: Check fmod_ret return values of tagged pointer targets in 64 bits
Date: Wed, 25 Nov 2026 10:28:02 +0000
Message-ID: <20261125102810.699464-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125102810.699464-1-a.s.protopopov@gmail.com>
References: <20261125102810.699464-1-a.s.protopopov@gmail.com>
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

A later patch tags the functions that return ERR_PTR().
check_fmodret_retval() compares the return value in 32 bits if
t->size of the return type is 4. For a pointer t->size is the id of
the type it points to. Compare it in 64 bits as for long.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d2475edeecd9..8e866f3ea7f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19903,9 +19903,11 @@ static int check_fmodret_retval(struct bpf_verifier_env *env, int regno,
 	 *
 	 * The trampolines of x86-64, arm64 and s390x do that: look here before
 	 * another architecture is added to CONFIG_BPF_FMODRET_SCAN.
+	 *
+	 * A pointer is compared in 64 bits. Its t->size is the id of the type it points to.
 	 */
 	t = btf_type_skip_modifiers(aux->attach_btf, aux->attach_func_proto->type, NULL);
-	if (t->size == 4 && reg_umax(reg) <= U32_MAX) {
+	if (!btf_type_is_ptr(t) && t->size == 4 && reg_umax(reg) <= U32_MAX) {
 		smin = reg_s32_min(reg);
 		smax = reg_s32_max(reg);
 	}
-- 
2.43.0

