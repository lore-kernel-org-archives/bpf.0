Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5A3E171E
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699719; cv=none; b=pdFr/ALI4nliSaxcLUDajWl6hXKiU5knOyy5UouxuHAA1WYOfDgTVCjBuAvI4E1eFcywm855qts5JY9GdWxyv4YgP2JV+m74kdEhF9hZAiRNsxSgYya37Xcpwrq+UmPURacU0QiU6iBkT4SOKWg7S+rRIzsUY8XFup+cJHhR8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699719; c=relaxed/simple;
	bh=LJVfkCei/XsbexH+y4wtxtCpgs1HX+Bi6s7lWac+JYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0Rk4l3CRd9ol15DJm9vSQITovhcVhMJKR/4EH3IFUy9cJN3tx3LHt9R3D9pkKsUCiQ1OETNrMo2oGb0YJ/AfhidMnQ3kScLwtPZHePi8Q/utxG2RXoIV4dyG/6mJyTLcIkzd6kw8W+DnWE4r2+MTXmfM8ZkaVKAd01b9S2aHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE8pT31S; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE8pT31S"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8520161fdb9so627470b3a.3
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699717; x=1792304517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e9EKIEiXFfEKX19jhGfR/Z4ckDWGe665UuIuGo1clpU=;
        b=PE8pT31S0ODfIlTDmVrF7/ssYgngjImxjf4MDYrTl9+KImPrr0Luw/dqVpTG86QoRw
         9wQAsU5/ADBtSybEY7i1St/DUMLpZOGQjOuEdMQDEvLO8SDSCME80Iyxu+ugx2kaYtZ3
         GecaxFgu/ijWY9oL5extyeUVO6k/moBKKbUE/v45osLVjTVry/XZirLeTFVb03OAkmLD
         Hop2fji+wEC/NXqm5lHhvn6Z9ssKpTupxbIn2zyceEjNuOMO3YI7MgiFeUad8PJhj2mi
         O7S7eyy96H7rRi/7HSyxtfNK2uJcT1DcSGLosfuyGMqFArdKZu0P0scDnp0JXPG6B3jO
         ljoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699717; x=1792304517;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9EKIEiXFfEKX19jhGfR/Z4ckDWGe665UuIuGo1clpU=;
        b=PXC7GL6kC9hVYEJiVO4h3kI4SCJAKNyRWmj6aV78cq3WSdkYDt+0gU9wgT2b2j+0vz
         n2CFgtBNpVZLIyVHiDOJrr+WJJFaZHTIz9WWsFnpn0z6bOx+/XpyfZAAAS4QAX1mlGG7
         WSa/G6vmDyMzR6DgIJjczcMPaqrbYZoi1BBlW5DLxxsxC0FiaA+5dMUOWJCJOPmCGQ/q
         P8wlX17kIUjzNA95uf+w2uSViQURAwetDhmurNftB5dn8fvypABfs2QTl37Ny9EcuDn+
         c44kTkoSc85dx9nXbWKBmZ8HvgBfjXtASAWRSjVBdvIPJd/4TrpnT8broqlzcLxngUb5
         03RA==
X-Gm-Message-State: AFq9FYLhJbLCBhD/Zsyd3tiMGDE24JR5Gb8DEck4DyJp+uNg7Py9DwnF
	ASAmIGtM6xfYqfzWw4bDU/4GRFhGGfA53sG3xioKl96JoZTqY/viTLznnCZ4bw==
X-Gm-Gg: AYBFou18qOrWeEuDqifDLMztk/tIJgjvUtQ01Uyb/nRuoEXaTYj53MBmOGK+G8fhZyv
	N6ZzwrkKJtJLviLVOI/kdLBarYeZfcZAvkFK1J52Q+r1A2RjBm9riJ5lKi/ntaXhq/73je0AAkm
	PolRbXOxZy5esjXKtXUuLKh1fk+CYxtFjZXf11o3yJaw60eTjtdJvPYawafbg2PKeGkxUZZlVy7
	uPt4ykGUCTHkxkPFsju6mIBlkLHqoZru5cG4UfCuuzsAllPD9Av6r/FyXDUNtzi2rNpppSrq8o4
	kkZpD1kQTWcNhpuZeD4G4vYLOR0HT6Bhufg1Qc6HB5R6iC8cY/HGiqlGxyzt0cKXFoB38CoVJmo
	3srxVrRzng8s4TyQLQrqFQF/RKKKNrssmfmW2cYTrzTx34HI4b8lJvxsWQE40I485BofaOzGemr
	TiujGBpAr59Q200LubTAL+NJtDv31TnDgsA7/LqzNGyWO2QwhgHoSyJL9i0SJ6xNxezIVzP2taL
	PVIYqa9t0XBtvZQGzhzLwgo/w==
X-Received: by 2002:a05:6a00:1956:b0:881:4b67:ffd with SMTP id d2e1a72fcca58-897c76e19b0mr5871180b3a.26.1791699717299;
        Sat, 10 Oct 2026 23:21:57 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:21:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 4/9] bpf: reg_bounds_sync() comment fixup
Date: Sat, 10 Oct 2026 23:21:38 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-4-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Array traversal logic in btf_struct_access() starts from reg_smin().
Update comment to match the logic.

Fixes: 0892ef2a7ef3 ("bpf: Representation for intervals with steps")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5b6200083d05..503c01a36a12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2354,7 +2354,7 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	 * potentially w/o intersection, or intersecting after N
 	 * tnum_step()'s, where N can be large. On the other hand,
 	 * step+base *must* be in sync with r64 in order for
-	 * array traversal logic starting at reg_umin() to be sound.
+	 * array traversal logic starting at reg_smin() to be sound.
 	 * Hence, place this as a final step in the reg_bounds_sync().
 	 */
 	__update_bounds_from_step(reg);

-- 
2.53.0
