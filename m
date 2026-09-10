Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479B52ED5D
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059176; cv=none; b=Kj9uqYTTQS1mSbbJKqCQvAlibxHhMHF1CAxI1ZljUbNF9DRLtU+YD2SA4lLJ271koWKPUsrnyng5FTxrS6wuGjG4513qP2XVTGmUeXI+QFeQMdV/x0GCm5XnsDDHQcN3gx3voW65e4fJAzeWExRHA3mzicn8P0opLPNWlVs15G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059176; c=relaxed/simple;
	bh=IgALGRDOofcqRheiguSNaLkVcTRz8oPngUcPlnxx8O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TteS+rutlQ2k87v/b7+1l0Fp70eFv9HeitVzosxcj2vFFGaXYVVDM1RYI/x5PxTGuybRarGIt19yw1CMLJkWlY2gIPWbkAfxiooC0q24u8hAEBCVIbDCLL4WnLmToDxOXcN6OO/w0eLYpjfiST0TF0erAbc2zhUtfKS/M6hwEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIj09DhG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIj09DhG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398b3c37877so6874727a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789059168; x=1789663968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGkO5SPpG8vTsJvK+53ZWmDGMdLio9cfh5UfDSl6S68=;
        b=mIj09DhG734A7EElZRB9Cp7/iu7KbLUrANknfmERC3DXHxE8m1JTtKU0FblPo/G1BW
         f1TC/w27AHFMEfmchFMAcMoUB9cUcLkirdrJQAnmbS+G1FMLnyGwdYRqL8pctXb81aaz
         JPfz7SBcpHcRHVcELONJc6wyRzLurOAdPdhez1LFm3RDfH2CgyNdOUxc8v1sirok5463
         zwp5w1iiLBY7FktRkDplYHlwc9cNs6PCHb0nELzoX0TQkD0PxR8gFZlc7OPb1NHv8qe/
         gkLO3YiNJRDLkzlojd4FZ0sune9rrIy4YIRfc5GDY5Ggvg4Ri6jyAfv+1upELnz0j1E3
         1Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059168; x=1789663968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGkO5SPpG8vTsJvK+53ZWmDGMdLio9cfh5UfDSl6S68=;
        b=RzlaoE/v8b4vEuclNiNM9y4dbgSSeOjQaN4VVF8vyULU1PSfpFp4OBrytVGugYv6k+
         rB6B45TxlmCsmZzeW8nkinVZoZlNSuB+pgn0Fxrv+hbxEngG3h2bP+3Kzxk7ZSQsLDvB
         H1tLH+Ro+g7849UgjZzQTA+cqBhzLCU4SlhaFQhGvv5hoCCgJNLRt2XeY7wyJ/n8bSFx
         jbPcqavSQCmdJaj/jVW5NgSMU2SDyDuYr7hYPKLz0HmTD7poNPeHJpdP/o1pJUycHlkt
         NB4NSZouwtgQmkqBWxKwBWYrghhVB859+bjCW8mH0D3pUHoBf5ZuB9X6HxYn9K0fmhB4
         tr3Q==
X-Forwarded-Encrypted: i=1; AKwUvBztZAjxQR2jRJJ8faGudL+kmUzqX0aVIZ6c38kP8KcIeg3f7hnxYkySSSx/x2GhxZ6iyR8=@vger.kernel.org
X-Gm-Message-State: AFuF++nQUjp7VHJ+X1ge0nVK8NJI9KWdQZK5TwxHUsjrtWa8QCwcVdUV
	eEmb/Oor1M/YWxNPzjKwozYGWo5mL646pYC9pJKk+LcEUyNtYcwZtND6
X-Gm-Gg: AYBFou0V5y7H0gCVK28a743fiAPXm4NG+QiiSFmSh09shC8okwxpxDiWkJLZ7B+PKVY
	0YlwcC6WNumTgfRNSvQhvkTunDjvNXTdFWYtQbxPiJbqDJD0nc8jbCazOiikSU//vzmLj7CWIQA
	+19H2ucw4OixAm1VjkG1jwwoxf01NJoInAGBAH/8x94Mlblut/MLV3a1NfJ7Pytv1ek9Hpw9g/K
	D06DjRZV8kM9OACOQUQZetybvKPuWH1N5T9Q+kgPGE6MAbOzudfgSo1ty0hjJhj5myMG8LDUGQP
	tsVwSC7Dmkgp29Wx9irxicH4zXcR035/eXD3bDhqxgMQdLnMudsP4r72HTPgUbT7kxyWfjnCtoh
	l04D3mBnYYKBvvcK+kauAyqdKrxZWgKGf0J8gOPuIhjL9ljwIqkV3CnFouckujnZePQY/DqNIg6
	y74f0ObNROLBXnVryKLkwySVYuFpKBDOiGkng1m0yMN5qxUf74P9A37bn72l2j4b53Yr67zZ8+o
	4EeoEn/YjdWE1Zc3KX0eYy75Tmkf9TuvisSwXZPiBcMxOIBcUI5TppHL7/ejJDbJ9QxI0Cxh9jJ
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39b26277b88mr64406221a91.24.1789059167593;
        Thu, 10 Sep 2026 09:52:47 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e602d8sm64821a91.3.2026.09.10.09.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:52:46 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	akpm@linux-foundation.org
Cc: jolsa@kernel.org,
	ihor.solodrai@linux.dev,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	mathieu.desnoyers@efficios.com,
	hch@infradead.org,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 1/2] bpf: Replace sort_r_nonatomic() with sort_r() in check_dup_ids()
Date: Thu, 10 Sep 2026 16:52:20 +0000
Message-ID: <20260910165222.1186628-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
In-Reply-To: <20260910165222.1186628-1-visitorckw@gmail.com>
References: <20260910165222.1186628-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_kprobe_multi_link_attach() in the same file has been using sort_r()
under the exact same limit (1U << 20) for 4 years without issues.
Switch check_dup_ids() from sort_r_nonatomic() to sort_r() to match it.

This removes the last in-tree user of sort_r_nonatomic(), allowing the
unused _nonatomic() sort variants to be dropped from the core library.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Build test only

 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 29260951aa87..1d7e73ddbafb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3826,7 +3826,7 @@ static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
 	 * and check it for duplicates. The ids and cookies arrays
 	 * are left sorted.
 	 */
-	sort_r_nonatomic(ids, cnt, sizeof(ids[0]), ids_cmp_r, ids_swap_r, data);
+	sort_r(ids, cnt, sizeof(ids[0]), ids_cmp_r, ids_swap_r, data);
 
 	for (int i = 1; i < cnt; i++) {
 		if (ids[i] == ids[i - 1]) {
-- 
2.55.0.1003.g10538fe699-goog

