Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C604C753A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542926; cv=none; b=c8BwkNvdLY3aWZaRqgSzwSjak4+8QKxZSoHQwQGUjdY/X+9O2vf4hXMJefftlearF0k3out/KvQqatTc+S8f8rRVIa2SAX48c0JfTz1dsaA3Hb3qWXf1kgde7hVy97DuJYX0pci6EXSix/HRDedLb41/CGMpQhWMnwFj7IDHsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542926; c=relaxed/simple;
	bh=7AfKJg2xbwRmTIffnycazXz8lToGJEQ8RwSTR6Grj40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B05CIiBxf1+2EJL/8bKNT+f0qThK3gsaOuhHTp5YLVgDQrnX4C9Pa0Oo4a/R0CPOS9A8Obd/lqDHEqZXahlRbzRz5j/6JPeHA1i9ynVvSmfmwh98hcluUSXsug7QWwUmrY5LvHxsmFlr+omVhOsT/1fyIQrth2se2Ls0efkN/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIgkGVUJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIgkGVUJ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ccce967aa8dso2781715a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542911; x=1792147711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WSVLSqDuY9NLn0hGTQ8/+lMGSF1GZL4tWD/AntUCQwU=;
        b=JIgkGVUJlUZKJwE4hrssAoj5/FWwAgw7dSGv4JqQmlCa2ZKi1/tqhafEirFxt6ARu9
         jXmISNf8Xs4zSsZUW41xhwkCvdJOFbNWRsnzL8c5yVNhOT9ILZdjNtIQ0rSwfqAcJ8Nc
         9OWG2vDewmEg5NlSAdn8p7zfwuazfCW+9QY96XefRMWTR9uorlaCIk/V/6gcPooDf+WG
         2eEoNPfJobrLMUQ7WxoP/L453pOFXLMBL6O3aTatK/6iy0CbnqBpOLvhgNxmfJfoX7om
         2IZVfQit3sdqkT/07yxy280rBXuF9R/FVoy4SbLzmoO81a3uEkkNVR9/MoW/SodIrd7J
         jTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542911; x=1792147711;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WSVLSqDuY9NLn0hGTQ8/+lMGSF1GZL4tWD/AntUCQwU=;
        b=c7LRJF0tEHLdWnSEUJhILcQ7+r+JPVXtDZs9FQi7PPgGFGztxtj8PqwV72v4x33njM
         Wx+OtDEybZezz4jlQN29z7eqND75WkZEQW9yWVBpazI4MSpsWiiAbe2wNLRjt/va8eFa
         745THGPLupl5aHvzoqbDHzT/76l/R4hGteJMGAkKZyaenn4bbf41FM7i25TH301v8P3N
         Y6BXgvhVmVPOcpFU4k3wc5/dEjf19XkF/p2uoJUnpTVUO6aMk1ULhkqIIaXNNCZ/sTBZ
         xGww2asWmUXrYvL8h/ABnvAUoRiO6s5r9WuhDvEIjFpaRi6e7JuI9HqUb7wYhrJBttin
         4MIg==
X-Gm-Message-State: AFq9FYKNVmuI+hon5WPWlcsXAdhNC4VpndmIFmlMCA1taenwi5PQ16o6
	tfx1usQW0H/Y/4f6WE64fDoSqEeXffmkYuJ6NQqjEsmpLkHEB7+6GLEFBgDfzjQA
X-Gm-Gg: AYBFou0EYqR3kvyzN4n9aS05+hnbzo0qIl8Gq4GEDaNoSW6snGep75wnV6p30jPtpaA
	rkedzIw3nTLTzEJDX44Kv2t+7RX5JKIeE3dmQ5SpzsUFO1mTXYrzggsUym5wcF++sKHcyr6EikQ
	59T12EYxyJrchy86205xb1gA61sbdgpWPDxTE99Bjva70/rMqT0UJbSwXQycEb03mQL5HezINO6
	3uYVFCUxp/NU0F8lhlqdjBOiAoxRTz6UFps0QtqTsuZUHQpz6ZJmJTAzERVLEG2MDC/YN9tBOpD
	31o6/ZtpeTGJr50l3CgeAmvjPWe7nBYD2UiFKu3AEjIDhl9TzOsVKHUNDQSbEwHQU2p3BXOb1Ac
	cR4HhqVuyx/5QOdVmbseied/35v5jIUS8zICPWBl8hdwk0ZeNnUNtjYSgX7LuoTp8d7get3JjIC
	IW1+OmA5AOkn4Egv5sRYizMH0uASl7WO2M7EXeA+flZmIX/n13Qfow1l6ZK88UHEdgdmcggDJu/
	7ydFonqqp8lgXBe++wUMGK2PA==
X-Received: by 2002:a17:90b:1e4a:b0:3aa:9a32:5051 with SMTP id 98e67ed59e1d1-3ab3ab329bcmr1335825a91.45.1791542911424;
        Fri, 09 Oct 2026 03:48:31 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:31 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 18/51] bpf: allow subrange relations for PTR_TO_STACK in regsafe()
Date: Fri,  9 Oct 2026 03:47:36 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-18-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

regsafe() currently requires an exact match for PTR_TO_STACK registers.
This prevents an explored state from pruning a current state whose
variable-offset range is a subset of the explored range.

This change allows a checkpoint containing a widened stack pointer to
cover narrower offsets reached on subsequent loop iterations,
for example [-56, -8] within [-64, -8].

Merge the PTR_TO_STACK case with PTR_TO_MEM and others, as the set of
necessary checks is almost identical. The only difference is a map_uid
check, which is not needed for PTR_TO_STACK. All locations that
produce PTR_TO_STACK reset map_uid to zero.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/states.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 18bf7b660c2f..345079cf64d3 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -610,6 +610,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	case PTR_TO_MEM:
 	case PTR_TO_BUF:
 	case PTR_TO_TP_BUFFER:
+	case PTR_TO_STACK:
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
 		 */
@@ -643,8 +644,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
-	case PTR_TO_STACK:
-		return regs_exact(rold, rcur, idmap);
 	case PTR_TO_ARENA:
 		return true;
 	case PTR_TO_INSN:

-- 
2.53.0
