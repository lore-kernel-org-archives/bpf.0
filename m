Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272E3A1A54
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121127; cv=none; b=rl8ul/jYAHnVuGVIGKgvEFV17Uu559cMfw/im/ZTfoUhPMl3C3Y0D/uJkY0+VDu4qsu/Ccp790LRAyET2eFySjSsQTr2LaG9saFCHAyOCXJIQCAHyo8Maz8DU90q4RRCTIRbd7rr5Jw8gltWEfskk1Qg/W4/bJgONj3epNUJX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121127; c=relaxed/simple;
	bh=b+d2xVLVvNQ/m2pSoHTpLRBqVDd3PasakBp4l1JxC+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBogmz+4PBqvO09YeW0ANa3JdWe/K8hXuxSZhCq6bH9gIx3c2WRQiCBlQdqehgd/tlneeA+2cne9W8+mmgwnS63gup9KJXSsGAGQcB0EVtekDjTtgSvk320h+beslqokGLfvy9eWl1r+RhstJue593Dn9QFXieChdu+L1T12XkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVYbk0xe; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVYbk0xe"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7c4c92477so476347a12.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121126; x=1791725926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iZ26yyVTjktNd1GjbvBiX0vBeTQt/nL6+4U5zZp+AhQ=;
        b=kVYbk0xeocC0Zh+1yooGcRVHAfCdjw7XEZ8drviF2tuEb2w3AywOXXQzW6j+BEe43K
         x89trZl0/avy+jt08CqbBl5kC3ApY7SUB2fHUy2tq6AOQzWF+JB3bUOaBcU2ozz/04kV
         u9uF6j3gPbPYq74W8a/65WXTWiDxsLJWV2ymXACpRL5DN/fEVEUokncdRsZtGsqCFcod
         VwTzfh6e849lvPs2vLJg9i19G2x3Ohx7tv9ld4V8dAfzoHWdQLBqV4NRvSUneYkyWn3n
         HJs9z9/dVQ/Yg38opQ2/t8n3XkGqBKf/zMPsTnp7jOBdV16/CK503CpqBwpS7VdXg7aW
         IDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121126; x=1791725926;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZ26yyVTjktNd1GjbvBiX0vBeTQt/nL6+4U5zZp+AhQ=;
        b=zq9MydnIW5SMRpqRqd08s4uRhHQ9JkWx6ENKGjGcE85JjtHOZcfsp5TERtd4Dq/nCD
         A7t5rsMBs0DAY121ocUd56yAT3KAa1g4+5QsrYVirHnR8ZTMCOmW+phPLfu/eCRxBcW5
         lxLCOYAyjSULA5FtTIIZ/9geSOO185tcFw4TMD/FvA467nAH5dNgzy/N2PIcsmfjvbsZ
         CzYYyuCand8Igv1e1KveAwUW6nVbOB/5yThJAOMt+qEFF8n7YWW0BNe+qzH6SJ6UaRo7
         US1Ye9RshPmq9qTeKdY8r9RCIITYUvDLkuyBD4bzmQq4V5VvlWXy/ZqOJn693QO8zKF1
         Ap8Q==
X-Gm-Message-State: AFq9FYIu7/PqFtrGvYYjDAN72SA9naJ7aYOZQ4/mXjkZXInYF237nc3L
	/4xxYxoyYOYh0qZ9gDN5RDmOf5NrkwVciqPyhJLnkRlEqF5Gkrgp6uum3A4HPg==
X-Gm-Gg: AYBFou1XjqvbbToW8qJxvf2pqZPWQoh6Dw1wm1VmdVPYh1a7FtyxnBol5IHd5kQSZOn
	eL66F2VmxWvG9jzOCl4pbUiuHZ8FL8Yj07SPpjdyh5I4fo3upDQFZJZxHdqeJtSmDDPU96MUKEa
	SzQ+PMb5uXBa1kIReZGLj/gOLIZNslITkUyFeB3mTwU5eP+R+s6TQKtDLS0cGLYbRPMFRINvplC
	JRwsRGfu1s6OQ2UzIzS+cWlOFqdQAMbJKSLf5gnUG3NPjFm/YqO1XBCHJc+7u68bDi7oXQlyeiF
	VB85FIVsgl3uT/iih2OOZHMlWXTpxslke5T8GEECOyJphI9DB8Y0wsOk0JSdsj5mueTtZxOWmXn
	iTbvJZ5zezgIq2jQG7DadFf61pmaiELYrTutersPoEYNhGiI6QNeQI7sYxAqvkH35gNmtITnb2i
	V7kG9EEq7Ag4/d4JpKVWS9GU5iX0dqmgJMj9Pr54rZiepBCTj0ydF1hbz7+Ik+0YNgFutC+31/j
	QHrHAMWoi76psc=
X-Received: by 2002:a17:90b:1c86:b0:3a4:d5c0:f826 with SMTP id 98e67ed59e1d1-3a6ce9b0fe4mr7294175a91.65.1791121125863;
        Sun, 04 Oct 2026 06:38:45 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:45 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 09/43] bpf: add tnum_alignment()
Date: Sun,  4 Oct 2026 06:37:51 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-9-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Used by the SCEV widening logic later in the series.
The verifier checks alignment for some memory accesses.
When SCEV widens a pointer or an index variable, it must retain
alignment information in order to allow array access.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/tnum.h |  2 ++
 kernel/bpf/tnum.c    | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index ca2cfec8de08..16682248f963 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -134,4 +134,6 @@ static inline bool tnum_subreg_is_const(struct tnum a)
 /* Returns the smallest member of t larger than z */
 u64 tnum_step(struct tnum t, u64 z);
 
+u32 tnum_alignment(struct tnum a);
+
 #endif /* _LINUX_TNUM_H */
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index ec9c310cf5d7..1f620facd1b7 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -317,3 +317,14 @@ u64 tnum_step(struct tnum t, u64 z)
 	inc = (filled + 1) & t.mask;
 	return t.value | inc;
 }
+
+/*
+ * Return the number of trailing bits known to be zero in a tnum.
+ * Return 64 for a tnum representing zero.
+ */
+u32 tnum_alignment(struct tnum a)
+{
+	u64 v = a.value | a.mask;
+
+	return v ? __ffs64(v) : 64;
+}

-- 
2.53.0
