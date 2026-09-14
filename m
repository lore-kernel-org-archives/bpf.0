Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A11345ED7
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391830; cv=none; b=rN/1NAaZd9KTa29WsILq7mXhKn4Asy1QvMvgvuEPHfNtT8LfsGzpS7MJx/0/7NmflFoITAfDYEHRaV+/NIGLRv61VNhrBYxnK84f/FD3Iz8QWp3K/ebSVU0/hQyadwydcqsEV1PznbsTi77btRMvliPkWNw3EPkiLJx6LbrKRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391830; c=relaxed/simple;
	bh=KZjNCPIpEr07Gj2jjOnTFxymY7XX174HZZ1JkZA13b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYg6UguqmcfpJDmNlBKGg7h5v+u/mIdBwIuFu8koG0DPi8JUsZIkCmTIGaipo3m3cdrNsC0yh+XyouYPl4Wt4t6sFr6imhdnhehLkzLnMTbeiqiEvw8p54DbRM9xiqNL9yS5sE1P/Vwp4O7bTujiNi2YWLoM/NBRGJIsoFEXyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4ivZaKD; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4ivZaKD"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so9399145e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391827; x=1789996627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fmBhrzK+pbKgaYQ+96gb0GLvWCdfcLYajrLY8jsXQt0=;
        b=i4ivZaKDco9JAe1d5XiT40YmOX4rUelIcRLIUvLEriwwF78FDgCKvr2KcjXydCEqCa
         2YUfXBJk6840zoUe45lJdP0vY7ImndjbfX+hGvintdX+gkLKVOgIUsyr9pApF8yor8J8
         vIykn7HPXU3NVeEvA9bWt1RM//niOwA7Q1Bf/tcrMpP60ldjRuEFP7/tj3mKehOztMnd
         H1SbCv8zZ+Hlpnhp16zMM3ejBfG/WNZApajK+9aNq6bOZQUYr//V3svozSqfwrdayJUQ
         Y07axg1pbnNApXgMXMelxaroUfmmewpNr5snC6sjH2Y3vqWivVEpgBFxqI1x6S4O05yi
         pX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391827; x=1789996627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fmBhrzK+pbKgaYQ+96gb0GLvWCdfcLYajrLY8jsXQt0=;
        b=JxOyWxbbGdUorsZV3fEb7ty1QB9SzsMN8RgkZv8I4vlkNQf/q2HwIRIli2Fex3j6Tw
         naIGnDvwiQQJuiOJ0lNLkuo8W38aV3Z/e4ovMnCKwzpv17pt9iCy6kV6bdtyQnj2N/id
         BK9aNzVBer9QMl3GEiKUg89cgGUHVwyxF1eZxP5c2Ct4Fo6x5jRECaTneRgdOmrt07kG
         /08hlzpRu57gpTEsHf9KTXhX7kFAQC7R9m1bXp4mPUywS0W1S4UT9M9Mne+eAcAW32+r
         OQbGipOILyp+KOVeSgu+ObMHQ4Kxk94cPIwrZmyIzPADSh2qHtFHXXRAzIADtdx/0sf1
         Njvg==
X-Gm-Message-State: AFuF++kfoWT36ITyR7Gq+FuOgFVnYSvVTe/SQcIM6tKvRH7cPKZn7VTW
	heMn7V3SqAYdZg/PlAO84eDvZ5BmjA0l6R69rivRz2XTKEwSkI5iYTrMeZnqeQvP
X-Gm-Gg: AYBFou2IW4dy4FEK88xDRxSfXXc1w2DPcXzoVEw5cNyf+58fSnrJfji19irMzD66SH5
	02hU3DozFVK6wb+FN9xUQL3vMytd1oeZSd3XVQ/yV2WFsCX1d3tt7jiZSELWCp3VUinPo2jTmhi
	5IvnH7E8WX48ia4na1vWcBWjpMZ+LX2WwJuHRhWAn2xHRCT3Zy00bWIv7Od6Zc6LAEHPsvGDy1b
	v0ER732R3lPbYaA93u6QyMCYDGxw3XRFu91+5eL/inWQtp1sCq51CfIe9yjsS2pHywn2faJi620
	lPy85j2lKsNUdTfhot4hD2G7lxSiyX/fzI17UWRTtP9fEQ0QGfw5W1kA5Y37acp422a2OeklmVO
	XNosl+yMcA3jE5DHeOIpOKwuKzAI9jrIpr3ymMTSoDK8oqOrUNA56Tlq469LILJ3Juk8gXmp2xt
	yMsQT9WrYqAcM6nKCcgZowhrgE3FM3ec4ZaSwHUIdAD5rre/1qDmk1lC6Kwgz62b+S2+70Vdqg2
	XAzcbuZu8pLrvD1byeH1jLd1xkNEjIjma9YxYvPnvxeOkSiCUv+eIrfYwnPRDe0ZbO1vCfIq8my
	E/pgOg55ItZFdE3GQ/CzTokc5obREZOdp6LCd8w=
X-Received: by 2002:a05:600c:5486:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49e7a66aaf9mr30186735e9.16.1789391826504;
        Mon, 14 Sep 2026 06:17:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26b7332asm403216615e9.0.2026.09.14.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:17:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 2/7] bpf: Preserve packet pointer class displacement in regsafe()
Date: Mon, 14 Sep 2026 15:16:52 +0200
Message-ID: <20260914131701.2529725-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914131701.2529725-1-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=memxor@gmail.com; h=from:subject; bh=KZjNCPIpEr07Gj2jjOnTFxymY7XX174HZZ1JkZA13b0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv55xmB53MLWN1X1b+JnXr625R9sdW6N1qnxjt3l8vNP 8Hifcu8o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOZ+JWRobV+b3eF3szPNv4b loRNtJc1+unIHD9D9WFdeM9E79VOcgz/U3u/zNkU4ngjP9ZR8ura6RkKCqsjY758PlgWxijMrV7 EBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regsafe() maps packet pointer IDs between states and checks that each
current register range is a subset of the corresponding explored
register range. It does not, however, preserve the displacement between
registers that share a packet pointer ID.

This is unsound because packet range is shared by ID. A bounds check on
one class member updates every member, and a later access can consume the
range through another member. Commit 022ac0750883 ("bpf: use reg->var_off
instead of reg->off for pointers") folded the fixed pointer offset into
r64 and removed the old off equality check, so two individually narrower
registers can prune even when their displacement has changed. The
explored path can then license an out-of-bounds packet access on the
pruned path.

Require matching range bases for packet pointers with an ID. Together
with the existing ID mapping, this preserves the displacement between
members of each packet-pointer class without adding per-ID state.
Packet pointers without an ID remain unaffected.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/states.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..6c88ad95b63b 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -635,6 +635,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* id relations must be preserved */
 		if (!check_ids(rold->id, rcur->id, idmap))
 			return false;
+		/* Preserve displacements between pointers sharing an ID. */
+		if (rold->id && rold->r64.base != rcur->r64.base)
+			return false;
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
-- 
2.53.0

