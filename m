Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8B3D2FF7
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025377; cv=none; b=ntu2271rKyTvn+IW0E81Rfi0NchpvxYEJGhsP+wpEGtz0pw1K8noMjQp1jHqEKRAXNQZPF8qhw7VEqRVOw71MOnhSGk2Y6NVgxPDIdaIHjScCcZU6DMfUZddbcyvlFgAK6WcbLNNjQbUrKxo5AsivjZkwrZvrSTH5Dw+JD7yT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025377; c=relaxed/simple;
	bh=HaOcImiUpDuTf+6s2yavtbu/XQEbtv7A0F3QvK7PEjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJJcXwecuCKWp7ZNEdFwwJv+W4ubUZXMc5xsPiSecB818Je1NU/Hno/SjuiVPAJyfFu79CxGhEc9qcAovV1GnuxMkjExP+snCrpEvcFOjsu0yJHsfpgVDn6+vbbmGE8yPVUIQ2EPPbrwlx4/Sc4w3n2esIo8V5bXEjqtBphD0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/UqgV5A; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/UqgV5A"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so21191995e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025374; x=1774630174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCaUKvFka89f2EF/UYr9+j4/cQA/WcpyeA5YLIl53aE=;
        b=V/UqgV5AHMTtb+HumG8Yn4jr8Jgdz8dFjCMGD8mgqGlkOWw7OvtpMOzbqZW8jIeZsQ
         ycXW+eH3YTHROY1o7Yk0ztBKJCq6STKXbYrD2XxYte5zN2FT6puE6MWaUuQcIYKOxb/9
         kbt4liwZZPJ4ZhfV5l0+jtOefo84kYeV8BvpHRC9TbnrciJroTYyggJWHADFQkXQlfJD
         9VieezXFInbANsnaypUVxoHqhVdC7rjrzKzSk/+rezeU0v+5c5wtV2Ez6gkLqzbpsaqT
         mdq3XwJLGavyv+LXSIPdmFLuaOx3WuGyBouW2WAQQHKtpDMlMpot6UjDf8dEt4CvzfwJ
         8few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025374; x=1774630174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCaUKvFka89f2EF/UYr9+j4/cQA/WcpyeA5YLIl53aE=;
        b=GKz9QTmZuG3YlxCkhCSrpVgb7Bn7cdalxU9oeI81rDxk+ggbEUNUtf3UCECD6a3N43
         dRz09XPTmNL3MN8dCeIn/Bd+DhQB/u6uRDTz3VHn1iaqx0lkAQdN7dHj8Ls15QsMxihI
         hn9S38O+sFUyfxbSdaHhGPloDW6aUGw8FY82o/iia3u0hX12qBCiuMYGFTrKsGrgo+ca
         MtbwCPUUkRzLGnE1N7xomXpHvNcXbEJ6wOJv5Rtp7Y7rVPeyeHvXdvFM6Y1ITe2V3EDX
         pi04DhsmlpA/tr0IKhhiNAr5JJGoT/om7IA28U1U4F2wOlEDhCWn33TOceWIJfpfIDHC
         6K1Q==
X-Gm-Message-State: AOJu0Ywq+9Xua6bNQlV1a8KtB3aS5Vu4nJ2z7O1/h0CVCF6+J//78Tav
	1gsUtjFItTvC18X41a5s8tB+pKRetsQpOe1Vp5LBAowUl7SxbrgoQSX+1P6cMtAP
X-Gm-Gg: ATEYQzzehQD5pcNSoaVwzcVhCdB+VCYjSEu7lVquXPDWWipXITJy0RAvIz6mhHwYq/E
	qPwlu45xFBv0+Qo2ME0t0dhQHoVIrXrI5D+h+rEoUXqURadpZZma+/fPk1b0FyWyMr86P/JFsjc
	dJOs+snZh9IZJKyWN1oVXNubS5knQ2pAE45/kcf4AT8WVu86B/acN9P/Oj7kVngi93F0y3jJAT+
	C1RUcBhWyR5ZxigsyDGxbbk+mYAFVTrBuZYkwybXx3qVz8IRF1h+zU6vauNrGO70/iw147nkS3B
	6D9vloM9J1myXKu0/MgPfi8KvQlHF4I0ElBh4XAljOAsAqR42KprLSuxQJFEw20P/CTyjcv9MUu
	+n/4MzQCib90BVZ0cmjDc2WuV0KcnhViHNLSo0pEQgc70nAiVkpJXpe6EuGZE/OTDywco8SiOQg
	2J1IB6AeTjfPFCCzsqujxALJWvCMe9n9FzsVaYpJewapFiPn4qHGKUpI3qafExe20pvgo7/4fTS
	u/Cq6IpluM/Koh3Pw6votBLL6kwLQYtAEhjnTLBLyZK/sWpeL5cUDp0gVDPm6hnUuEEGG8wWNGj
X-Received: by 2002:a05:600c:468b:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-486feb5a4f8mr62741195e9.0.1774025373844;
        Fri, 20 Mar 2026 09:49:33 -0700 (PDT)
Received: from Tunnel (2a01cb09b013a2c6b23e8799d065d8e3.ipv6.abo.wanadoo.fr. [2a01:cb09:b013:a2c6:b23e:8799:d065:d8e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1b4491sm19400815e9.24.2026.03.20.09.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:49:33 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:49:30 +0100
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
Subject: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
Message-ID: <704bf39f66a98877f66a4982c77cddb42f14fc82.1774025082.git.paul.chaignon@gmail.com>
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

In the subsequent commit, to prune dead branches we will rely on
detecting ill-formed ranges using range_bounds_violations()
(e.g., umin > umax) after refining register bounds using
regs_refine_cond_op().

However, reg_bounds_sync() can sometimes "repair" ill-formed bounds,
potentially masking a violation that was produced by
regs_refine_cond_op().

This commit modifies reg_bounds_sync() to exit early if an invariant
violation is already present in the input.

This ensures ill-formed reg_states remain ill-formed after
reg_bounds_sync(), allowing simulate_both_branches_taken() to correctly
identify dead branches with a single check to range_bounds_violation().

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fbc29fb96a60..8d7ad5f21ed6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2786,8 +2786,13 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
 }
 
+static bool range_bounds_violation(struct bpf_reg_state *reg);
+
 static void reg_bounds_sync(struct bpf_reg_state *reg)
 {
+	/* If the input reg_state is invalid, we can exit early */
+	if (range_bounds_violation(reg))
+		return;
 	/* We might have learned new bounds from the var_off. */
 	__update_reg_bounds(reg);
 	/* We might have learned something about the sign bit. */
-- 
2.43.0

