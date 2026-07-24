Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D6345EA1
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924202; cv=none; b=EJo7ZtooBiUnERtuQLYtt31GyNiy3YT1OYhaABzRVZrnW5E2c6F25ja2LTto9S3IeK4CNVo7FsiDi3E73Vq3nqT15kQJ2WgNvG+lFsn4LCrGgVdR0iyd8Eylx3WkVlvIQFKj75CUnxytllgew+QTCcPOilVGVIhZZCBIzJAHXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924202; c=relaxed/simple;
	bh=KErE69bqCkkoWIL2Zx3CAGeXSr9TAo5G/eXibghr1wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E28JbsXhOjE80F6AitAeaTLJIjb+hLDGXBYx9avw9CcszMzt3M7/U0sOq4adwIZMWYdZmuhV3V06xMqQZ9mG+NHSDLyakJfyOiopSSn9+SqDRB3Xrusy1SphkS0eO6RA1/mldUoK/fxVWTqyPWRRbHZIOyDp9iNl3eCHmjvMpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY1ujbrF; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY1ujbrF"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso184200f8f.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784924196; x=1785528996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+0ththEorVPtmXMytKpD7OKGhtHIUig3coChHm+C3A=;
        b=ZY1ujbrF6dZ8vs4GjByR7Fd6mjy673oMeVefL3CbUKshnpUT8Fc/8ce+HepkDdyKvC
         whisGioUFQTrW7TxYR4gZg+xeCTxndi3AHrxDrfi5C19EadmWZLAUY/q/j1FKDIltKDe
         tklDE0gowIEwMjllnZKXUslTTjsnF35WfaQTMp3yFbf/bXvGMuaZfwGxN2Q5qgh0h7aV
         4kzu164f7jwytaH7A5M9RbqpwCwUNT7qZ465zzXJEYYS6rGBwcXWflcJwr8YJhVatVHR
         QwlPKcHz4CUnrK54SnTXfaZw7MSy49RgZ3PMy73mDC2YwGdc8rXpHPZYo//AJX0Oevaq
         aqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924196; x=1785528996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+0ththEorVPtmXMytKpD7OKGhtHIUig3coChHm+C3A=;
        b=bCnaY98oQlVCFq6o1dAASXjPqx2BN9Vwl9FLuVPd6RVrd7Bz2vllkW9N76x1QmYvS8
         XZ7fnjqEtR2DY9SD/WPph6VjLyosYlx+YIBXV8lvMzEQaJo7wo1ft+GDUJ4SX0XN+2ww
         jOqNvRCZAQiofeH9GNqDiCEzhoEFHX6x8jqua7vSVPp38nAuTk5vb+X20t8FAHdzUQHJ
         IscJF1SDzSRevKt2h2EcP9Tv/nwnxW2VEEZ6PjWBIDHnHMaIet7L2np6vd7wRZRdKX43
         4OG5Rb92PDARP82JPBmdlQfu4cRI0DjR2UWAkug2MHK5b/mADhuKr8+z7iJx/gxUZt8v
         VzFg==
X-Gm-Message-State: AOJu0YzVLNPlj1vnTU+1qDZMA0p+UzAuibfw9AK7QZSkOSVrqzgbIxBC
	Pd4K+MTUrI/T1qqBFtvKqMcYjzbgyIVnd1pqt96VAc5NZeB4guWj9HY8rBTCI9tE
X-Gm-Gg: AR+sD13acMKz+9lqo3AaneOKxjjw8ppXyrmobZAurb3Hdrj15ek90MEDa9KbCfHEt1w
	TFNuJDDKvfabB0ukseNol/z0cU2scBbcsZhVw6HvtswhslGXXYKCCb9jxW1Rh4KRMvhTdxYgzqg
	fMvUO6m0pugpGGdQ1vcFgzkrYT9bPWTqsuMmWQnPuXoi9fbxtvC6L9HnmtnZPjwC0qhF+0sGB+T
	Kbo3N/o3u1wmR3IhZeFha6WrtgjTnLhyevJ1yNCk1spspmyFSq0u6N+bHmHpeTLqVCzrk9/E1rg
	eUNOiX0Fh6RqwaeldLs5EYUTsKaIceqb6lSEsPp3dRSbSko9m4xhzpzQCHsgIPCY9q8ISkdQfPT
	f9+sF27hozcn4Jf4jiv2hey0NClivRFd3YepR6RfTng9nJyQ6qkrus3k1mKXDwB788dfOGMOiCe
	e/c948QFGOLWFGf7xm4Ajm9oipwrk2sAbh5Ryi1FjDHqj+P3UaKxLsvW2OtF9t7k6C1ZSU/T91A
	tzTZuaQVA601G1oLzWwCXXdeImlL0rPwLFRZQpgu+2w
X-Received: by 2002:a05:600c:4454:b0:496:b3a1:75ad with SMTP id 5b1f17b1804b1-496b3a17767mr15770245e9.31.1784924196301;
        Fri, 24 Jul 2026 13:16:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fa9sm27980524f8f.20.2026.07.24.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:16:36 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Allow bpf_res_spin_lock() in all contexts
Date: Fri, 24 Jul 2026 22:16:31 +0200
Message-ID: <20260724201634.3025247-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724201634.3025247-1-memxor@gmail.com>
References: <20260724201634.3025247-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=memxor@gmail.com; h=from:subject; bh=KErE69bqCkkoWIL2Zx3CAGeXSr9TAo5G/eXibghr1wQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISv5eOySe13fI8omrwmeNqehZX3M0q/7bR7dXpR8hWvyr UmCKf9XdJSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BeAiqxj++/kKzvEqeffdJnlb wGlPLu3Zr+10P61TTsySPTRVKHtnCiPDlMD0at4Tvj1J+iwdfnNP5DCKuxxfU9uT7PJ80tvLLxn YAQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

There is no particular reason to keep bpf_res_spin_lock() disabled in
tracing programs, since it is safe against reentrancy and deadlocks.
Remove the restriction for tracing programs covered by the predicate
is_tracing_prog_type().

This is a prerequisite before the definition of is_tracing_prog_type()
is updated to include raw_tp, fentry, fexit, and fmod_ret. Existing
tracing programs will be updated to use bpf_res_spin_lock() instead when
it is available.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce..57a76c21d624 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17815,7 +17815,9 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
 		}
+	}
 
+	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		if (is_tracing_prog_type(prog_type)) {
 			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
-- 
2.53.0

