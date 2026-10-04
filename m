Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2C436BF0
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121131; cv=none; b=bxQh9cFjM2aL0PpQIJmRoQhytVI+RaJt8LcJVg04RiqMqDl2PHErzg7QKAREJjzlYhrzT42v2eaD0LMKVWipDss+ObmeV7HhOvTN42vmo/gAq17ySf9B+3FopK65yUBRrwzSTdZbxfCUOvX1EM4wfN4kXoUeDPM5ADNlGx9bJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121131; c=relaxed/simple;
	bh=7AfKJg2xbwRmTIffnycazXz8lToGJEQ8RwSTR6Grj40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7d280YLe9QtB+XX0Scqc6d6g3381HncVeINf63/S+21ltJaj5DSIhb2Fg6KawmVIVbeuPIyRnTzNiUAq9xyff1oiku4KQSz4EwATVznuJ0leU1c8ZJdtOIBD8xOdIzlWgZgmFsO+VbdPsa4o2M774zOiOZNslQclsjWyk1gwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ve+kYZ+K; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve+kYZ+K"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e44so272824a12.2
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121129; x=1791725929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WSVLSqDuY9NLn0hGTQ8/+lMGSF1GZL4tWD/AntUCQwU=;
        b=Ve+kYZ+KFcd/sQehXMSVc8gCFJs/6tZ0EcpeXJLj87wbHl4rcGIeYeCOi6oJmg2nFP
         hdmCtxoFZfTRkbSQMfybCG8cjsbAMoqlQdQXEPZhj7jv+nyxWf5xD4jY0OGr1c3fbwoc
         wlUdNaKbO0vGYSkDMuRbhQLqg1sE6GpgpuRhHWhyFRlg8Rr9PStzecmFkXTwBFrrs5fW
         pnef/ZgyZ/8rZ5sg3x+0osnJP3GtViDgW/CwSXtwa3ZPdwiVKUMjjlprTHPCFJVm/E9W
         zwbo60upmJyauTqn1YEJtLmDWgSiBzQUGbBh66EvJdN7weUmynPFIPfzrLm+EKo6Z/D2
         qvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121129; x=1791725929;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WSVLSqDuY9NLn0hGTQ8/+lMGSF1GZL4tWD/AntUCQwU=;
        b=XjunK6s+H/DsfpgTnTOsou990f7wjcHKr2pWNom4piMOKe45YelpmI5o8pO4iozafZ
         G7h5g9aQ7I6Rnq+Lyf54wAZy+vaVqm3Xo0qlARwVza9J9ZzjW1UM5fixaegKwOtHW1CA
         bg2q/mI9O5zqD888mqCSBg8rN0TGSBUo5ZG9f75jLjLYdJoewKPKwXTJJWZnXy+g7agT
         e9yvsWIvWvjMaZp8gv7EXfzM59pd0CvtXfQ1UPz/jMKSWF05WAsi2OJAHeBm+1X1dip+
         8PmVojOYAjki6PPpz97FrOgOYoMZR6LsMBRoai87un5pk5u7F7RHk3nvY9mvIRxCUqWR
         cZAg==
X-Gm-Message-State: AFuF++lYcJ2ixRyrMAcmJ1fkKsAohAdKBfUc+v/23ECm1INH/I5orTox
	RhvVCL5/UIJJqpd52B5nsLpe6GSOGMZ9WKT9NJu2kPbv9YAPLy8zXVEj7hsrew==
X-Gm-Gg: AYBFou1M0XR9L+razSnnzIhs9h6FFgqYHhwWZ0R/FuX38CK2epbgbLvfQc9rapMfPTf
	K/tiRVPvl7Lo7MtTc2OOw5Zht5geo03LQg5deZlZb1Va0iZqeKHWg6T+hXjyLwHPv0iklyBGJft
	MFjU9/FTiSvVJFpErb0e+Rr+J8g2Y+NiGs7m0K6qZ0orfbgyaqwk5q2Q25vFc0X0Vzr7vQQvALx
	2ctoByHN5IQFWtUZiTzQ9JLsqVrTufyBWZXkEFQPwxmz5usb4g+7bxhNUyHvhW3MV+b/Vbr9xvp
	3/OG8CYwoHJC17rD1NMLv0IZjdfZFMOuPOTTsU/luNc+GmBHY8B27eVFl53qjE/GuSgS12vHba8
	icSjHlg3hBbexUTs9vcAnsOI4Sz+rqt79prMzBF31WhRHmnGWRgg4C3+x2VkfDO0pAwMyMHCwfi
	gnw28hx1OMALh9sBIWLHMusuDe5uuhpmZY4iamGmGnE3SzzZNft4Qg42Cg0ZfRtWVVC/1qdBOy7
	3Vb5MpJw/mJn2I=
X-Received: by 2002:a05:6a21:1505:b0:3dd:85a9:559f with SMTP id adf61e73a8af0-3e0bcf14fecmr8772468637.33.1791121129193;
        Sun, 04 Oct 2026 06:38:49 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:48 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 13/43] bpf: allow subrange relations for PTR_TO_STACK in regsafe()
Date: Sun,  4 Oct 2026 06:37:55 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-13-f6254e29fdf2@gmail.com>
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
