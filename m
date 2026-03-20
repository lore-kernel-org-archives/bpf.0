Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D63DB656
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025271; cv=none; b=pHRebTaNBOzlfp0wF+Ge3iRzZFPlNo5P+COBLDyeSEmRX5ZgKMz7D+tuDSz5atcgISyci3vmIhqOiZs1aXdD3UEG1W+lluQWm5n5Lf8dXODb0uN/9SsLtDp7wWAsGRbMGwu7//mMB7aTHj03TdTkxOR8de4Opt/7/Oi9z4l8wEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025271; c=relaxed/simple;
	bh=jrZCKPTXKGoQ440ajvngA6vMoYGeixRaUqAPQNvMAMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0b7jAXcs2xQGcTBAI9bgoTiCt7b6Fk4w0xYB6op8RTcF3l28rI7Zftv1QAXRupTMl0uKs5tZ2AWsuzb4G31zgMY7FdQ5WCEw4HeRktC2c9WgMpk2h1ZOp9yjoV5/2iyc4V1nhGFMpGtTHFl629oR5M1GXHkC3lU2/nSRULXnlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngwq1bwM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngwq1bwM"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso2035644f8f.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025268; x=1774630068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ikApfiBPQFhfiNym/oyuosiE+aX8kLm/YuzLjAMdnjA=;
        b=ngwq1bwMVXBRAYONqOXqqx6TVHiFVDH+PgoPOthk37gqo8a/hnSTmOkd6mo/+nOLu4
         E4mK8m/Za/C9ERpahzRZVuqwupO36VZM8MIJG7t0t3Xe3uJSqMKQLU7QwHcjRnkBSc/E
         W6I7LuVGTfqyuoxkgMLhKzbD6zBDPc5az7i6k0ioMomW3q0WChb8EWgEoa1nM2b4gKAC
         7gliQPC9+suT5NTSEUKMw27OhEkhZuom4Tm3DlvCyGin3Mn1hAL/vRvWOthNYzM7d3Y0
         ymFmydlfLSr0iwvDGozDFlc63WW8SP4fWm2ydkDplT9sh6DOuaohNd6dYDEb/3v4JbaP
         HPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025268; x=1774630068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikApfiBPQFhfiNym/oyuosiE+aX8kLm/YuzLjAMdnjA=;
        b=Cd/QOyny9d5l5W2+FN+a7m8euFbowHq/q43J5Vof1OeAQn/0iQPMT6uXaqQyCNpZ1F
         0YMUGQGZ1nmtLasJ9KnvEQ57eu1z2mrR900DwGlxUm2yxM4YeDTfpuT1RuHFfgz3VPWx
         xMzjGchE/iyOmUe1fAZjNSKVP39aG3td/9sbKgaAdF4RpJdEnTo1If3lNB/RyFkjE1AI
         gUplC83r48FLRuN/MrwGiGQ2+ZHOPrP2VVetqZLZsDPUulnovWs4jaTu1VbbHr3vEwcv
         XLifNh1FVMc+LyqCFn3helNJgZpnXGlaNyp/t4mfQzMDyF3UJ2MD7IaPRHAHNL58V3mO
         GNFQ==
X-Gm-Message-State: AOJu0YzNNDAa9EaJpRWgY+lrGfYV37n626JhrEgmrLOuT6jt2XUiksZK
	D211Ihw3KRR4ptL4IT6UuS2gyy3AFm9G3xzqaF9wDpxLoRzMWUAjpGuz4QV+r6kZ
X-Gm-Gg: ATEYQzxSbXuIG/INYn19fzr1/VtkvkZB3zB5bVQEFzSoTVkTMgIq+3izhKk9tFy3Kjg
	bEEhERF6KG3+SD8VqeVeZk15o8J5nmHxUfK2+qTG/PUUBIiYSIgFUgcbytYuw+w/Xt3zohXG3A/
	m88Wfj5r/3i0H2J1ZqSGKrgK0K5WsXlNT29oleQIQu6nP1iQGCTRu7K8/X2e9wCAJJQWEGXlecq
	vc9sxvg6T+eqdCkgoIvx7UHcr2p6tj07NofMBBNFdvBykjW7hZjV5CWmmor/l1PjM55CymruEai
	iLc/O3mZ5qj0MGNr7X9tjuU8BizeWQ+opmEUYxdoxg8i8jOnwFRn0ahJKJoDesnMjXqCBelxJlT
	sIFEjK/aQ/02dWq/0mgWOEZ6SQ3LHvT/Acb2HRNed5cp8IwFuZMxzZLROrGjcvlDD25mPHvWiYV
	JfuT03HqDksjXmHDe+HF2pBkWANTIZLWxamfzSDsJKE/y/l8LszUM5ujRl3S0ccdmUbQKw5Oq86
	MZAAqMoe1JV6XSeIU6gZo6GXc2A5wzgvnUXPqpspAvEcJRr3hpCwle8EzWqUzz3b2/Gj83GqCLi
	heatM3qEgnw=
X-Received: by 2002:a05:6000:2207:b0:43b:5b25:67f8 with SMTP id ffacd0b85a97d-43b6423a2dbmr6880307f8f.20.1774025268301;
        Fri, 20 Mar 2026 09:47:48 -0700 (PDT)
Received: from Tunnel (2a01cb09b013a2c6b23e8799d065d8e3.ipv6.abo.wanadoo.fr. [2a01:cb09:b013:a2c6:b23e:8799:d065:d8e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae619sm8615890f8f.5.2026.03.20.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:47:47 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:47:45 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf-next 1/6] bpf: Refactor reg_bounds_sanity_check
Message-ID: <d328e04c67b520973e295d0f1c2fd88715a6390e.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774025082.git.paul.chaignon@gmail.com>

From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

This commit refactors reg_bounds_sanity_check to factor out the logic
that performs the sanity check from the logic that does the reporting.

Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 50 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01c18f4268de..b638ab841c10 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2802,40 +2802,60 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	__update_reg_bounds(reg);
 }
 
-static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
-				   struct bpf_reg_state *reg, const char *ctx)
+static bool range_bounds_violation(struct bpf_reg_state *reg)
 {
-	const char *msg;
-
-	if (reg->umin_value > reg->umax_value ||
-	    reg->smin_value > reg->smax_value ||
-	    reg->u32_min_value > reg->u32_max_value ||
-	    reg->s32_min_value > reg->s32_max_value) {
-		    msg = "range bounds violation";
-		    goto out;
-	}
+	return (reg->umin_value > reg->umax_value || reg->smin_value > reg->smax_value ||
+		reg->u32_min_value > reg->u32_max_value ||
+		reg->s32_min_value > reg->s32_max_value);
+}
 
+static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state *reg)
+{
 	if (tnum_is_const(reg->var_off)) {
 		u64 uval = reg->var_off.value;
 		s64 sval = (s64)uval;
 
 		if (reg->umin_value != uval || reg->umax_value != uval ||
 		    reg->smin_value != sval || reg->smax_value != sval) {
-			msg = "const tnum out of sync with range bounds";
-			goto out;
+			return true;
 		}
 	}
+	return false;
+}
 
+static bool const_subreg_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state *reg)
+{
 	if (tnum_subreg_is_const(reg->var_off)) {
 		u32 uval32 = tnum_subreg(reg->var_off).value;
 		s32 sval32 = (s32)uval32;
 
 		if (reg->u32_min_value != uval32 || reg->u32_max_value != uval32 ||
 		    reg->s32_min_value != sval32 || reg->s32_max_value != sval32) {
-			msg = "const subreg tnum out of sync with range bounds";
-			goto out;
+			return true;
 		}
 	}
+	return false;
+}
+
+static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *reg, const char *ctx)
+{
+	const char *msg;
+
+	if (range_bounds_violation(reg)) {
+		msg = "range bounds violation";
+		goto out;
+	}
+
+	if (const_tnum_out_of_sync_with_range_bounds(reg)) {
+		msg = "const tnum out of sync with range bounds";
+		goto out;
+	}
+
+	if (const_subreg_tnum_out_of_sync_with_range_bounds(reg)) {
+		msg = "const subreg tnum out of sync with range bounds";
+		goto out;
+	}
 
 	return 0;
 out:
-- 
2.43.0

