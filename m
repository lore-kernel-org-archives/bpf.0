Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5C39937C
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675557; cv=none; b=qhMLUaUSQkw7zHli6JMUYYta/f19l1bnbzMRD558glaev3IB8db11tCx2DH/bJ73jSW8FkWJuywtaHRYiV9MMi8xfJleSzL042cbQVqMtkQJ69zpXlXHpC4QFnCO3EeufyPtSbOAkD57JCdgu0i1gTm4C6db8v+rin7Q0ANxQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675557; c=relaxed/simple;
	bh=s/MbIsksUaSydMaHe/a+eMcwLYCQMs9zjlIkw5+6eJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5LtC92B8fNFQSTJqvnBwfAL2z8+VrXmMWv6dS5IDzP9L1xtHT36jnLEM8qCkH97dDs8jpekEc7HMwiG/YrkBnR07MHSlER/pHOSlrXkXY0oP8b3HDMFvo1hUQrfAT8nJx/B4bFW6CodZJq523Yj4oTmKQEVervG5zn0rmN4SKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vlq9lwaQ; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vlq9lwaQ"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-80199394f52so836538a34.3
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675553; x=1790280353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nALUV/wXNg0DuRucdSBT6s0xt5qlSmOqGtlhZvrNcM0=;
        b=Vlq9lwaQ+weFJqPD+jdXk8Y8u7p1R+2kMeMho1khKa2c1H9N9QIKI0kFoa3t4fN8lw
         xbfAVscpnNa/CfELvaimQrSRg7Ssym4m4KFtBX4tcv0Xiflr7XX4oQWbhA/n3DR5UEvu
         gdMDs8f+QcXyAg+BUh0bux6XU1QrlLml33rEGkzKF1z7iE2nksxa9PrmXMubd9+GTOln
         CHWnvDi69FwH9kex0hiK7/9LuwVLBXPlwKJAUUbkyRqaoyJgsIS3kpoHPrQoAEJ2p/XF
         XdT2pYmEjr883IZERVYTrXjGZRILuVnv9qHJo50ZaXJqknsr9KN0kZiODmGOpHI8ebop
         JDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675553; x=1790280353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nALUV/wXNg0DuRucdSBT6s0xt5qlSmOqGtlhZvrNcM0=;
        b=FTNfSPLWmGgxqnn90r0HepN+nNS6zntaCptmApw+Zaz0OoqvXRQeBDVMFrYwZt755r
         w5FRmfEp2OSr5l902fOgz/KJpVsGR5hxKQtnsMv9rDGHvZEAfiYbT3QfUHaRuETFD+tQ
         3Wd9FlQ3ot/7gQWYyOWKbZmtbokSPRH/CSRpZeVdiT4ZK0Ux/UgIqmZNkMijvmcBLONV
         j+PfDmTiZdak5TvC4MxUrVDnLjHJ6OjNRC6rPTzzMtzVldybRRBBFqDnElkVi7dRoy7T
         AGcaJsh1SNJfyGeEuohe0d28nNH8Wo+/PpOhpsDMKeIhK7NIh8k7Bxt1+fAz5fzRtEPU
         TkMw==
X-Gm-Message-State: AFuF++mFqlPsc32QmfF9LIID3RLtHLKNjIShIGocUg3vNwXuF8ukYHC0
	X4hvuzrMI2a/hj4yUHITGfCr4A/ySESCoMMlRCptP71u1XZwI4jpxFit36rPTA==
X-Gm-Gg: AYBFou1Ldcm+YIBwbRtTsd2G4HJt0ayxFY7TijLMbouDCBYzBSK2bgHMcL7rWjbuDzn
	YdXazBKDoj4DV7T37E4VFpyFmbMfzm6Zqgc1jd6A6+S0kBM5ljpjlDEJd7alv/DP9DD8hzAV48t
	YYUR/kpAbJ0lfTwQ9o5qAC0g6k8EGZVaOjpAg0bNPz9tRKMSBcHzevziFws8GsTnrIz/1Xer3XW
	qbdO8vspjh3QykC6EKDajdarlPP+bwr8sPcmE9iKgYUFQVUBLKTyZatzY0MXKoIl8ifhtMkl2pW
	A3oJs/mIOCr4JeFZHB10EW9ymHEvzd8RQTowpLTrYTtQMglxA2EoHDE5W7NFTzhbcZE35/EKSGQ
	U/WmQf68fzX/7Dy+LtLp6yP1e8SUzBZEdWxk5yymfiT5XmcQul683maeHNpQ8AYJ1P34N5cbW9/
	QkhF8aC3s8wfe7GxdtaI50y2X9qQmGd4+oU9OGum0R4auxYwnNRSuaYrkonOyQnw==
X-Received: by 2002:a05:6830:449f:b0:806:3ff7:a6e3 with SMTP id 46e09a7af769-80de2ee50eemr238904a34.20.1789675553372;
        Thu, 17 Sep 2026 13:05:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c476ca2b7sm4369174a34.26.2026.09.17.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:52 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 04/15] bpf: Remove unnecessary prog_list_prog() check
Date: Thu, 17 Sep 2026 13:05:30 -0700
Message-ID: <20260917200542.3689605-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

effective_prog_pos(), called from replace_effective_prog() and
purge_effective_progs(), tests "!prog_list_prog(pl)" to skip a
'detaching' pl.

When detaching a pl, pl->prog and pl->link are set to NULL in case
the update_effective_progs() failed.

However, replace_effective_prog() is not detaching a pl,
so the case "!prog_list_prog()" will not happen.

In purge_effective_prog(), the pl->prog and pl->link are restored
before calling purge_effective_progs(), so the case "!prog_list_prog()"
will not happen either.

This patch removes them as a prep work for the upcoming work
in attaching struct_ops to cgroup. When attaching a struct_ops
to cgroup, there is a link->map case and the prog_list_prog()
will not consider the link->map. The replace_effective_prog()
and purge_effective_progs() will then incorrectly skip a pl
with struct_ops map attached to it.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 149672c76c49..2fee0cbe5dfd 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -973,9 +973,10 @@ static int effective_prog_pos(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
-				continue;
-
+			/*
+			 * No detaching pl (NULL prog and link) is visible to the callers,
+			 * so skip the check compute_effective_progs() needs.
+			 */
 			if (pl->flags & BPF_F_PREORDER) {
 				if (pl == target_pl)
 					pos = bstart;
-- 
2.52.0

