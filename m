Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1FA4BB7F1
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607892; cv=none; b=jPvbUbMuI8EePLteCS6ricJ/CPRPDEB4edf0E6gCqFqrrnHIJ5I7xOMALsDPtd5oL5eH/2ytj81Igd1Xiwc/wBG8cQZFUMvvR3JTbQC2HFR24hroH/14os7/MzpJuUCklUs7zDeTdH8N+KCHN83rHckDVt9i8l8pBMoDabVNt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607892; c=relaxed/simple;
	bh=WjxG34ckArSJvICg7CN7SjHfhCj+djEKUlscplNZg6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBZ1scOkO/VCyhsHw0y+aDyg3Z3mKbOP4YDmQMErdvPtxoiob29MQG2pJ0sVURqlWF1Z7I4pzErJKqVCU3xCbUCz215KKQujNejasO76+E/BvCGD3kFB+crDxrM/Mhbl/1OU9Of0bU1vN6BkJBNcb6NiPNuUM+8CW96JwdKd8rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npzbjPdc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npzbjPdc"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c294ad260fdso23903066b.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790607889; x=1791212689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjxG34ckArSJvICg7CN7SjHfhCj+djEKUlscplNZg6E=;
        b=npzbjPdcl5K5BtmaCtT3jWaY1vNpcIKP5JmWU/+MtqSrpVv74rNw5LVwp/+abH34Ld
         JskcpUiT8p0G+jPlgamW1BcpuT3LiwgGjJhMHuxlPJgYjZU9gYzkmduQ7NjGuSMhJuBP
         R21Di7imKuIi1toLrbQIwwoBU+VTgZXDJxnH2aQ0+dkjguZT2Mh7pbjzP9YJpro2u15P
         PANr2TkxBLHjUYkOT0iWCZRj/RfQ0tCyyOgTCEOuToegEdFYmVbl8w400yIhDm5P4Zec
         8VR4Rt3d5tlG4vH6q5IQtixyb71He4QU6ANJl3bFTE/7pB0xQTX6Y5NSHeSYMuJ1r9TK
         eKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607889; x=1791212689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjxG34ckArSJvICg7CN7SjHfhCj+djEKUlscplNZg6E=;
        b=ujUvBsyr3bWkJ6HcI7y557wG4BajC2N8qtLclIkCYf4MenP2UAeNFOAsJbLJhUWIBo
         G0vsmrr+RQ2n6UUEMpuCzfl3aHR1b9ufDAqNM9dclBur/EzW8CaUzIVvZ4ErcXSRsUCO
         iYbO9REQyBOeZ3Apc2kFaTYddx1DKpJD0XLGDvQm+hTyGxCT7AZzt1jkYTTFb3DAXcrR
         B/INWtsz96qqv7FIiGjaDeXiklcyKx6OlBGcKUJ6moeoPacZ/kJyX1TAW0auYV3ywGH+
         H+9YvkNXSzzWZoiPre+xdYL34/UK4ckLhuBF2X9Zpfs5ptNKJrTrwjt+2o/oaxOAfFcG
         0cQw==
X-Forwarded-Encrypted: i=1; AKwUvBy+OJsrcFoJ7gb+ywohKYNzqol4PHhXfdiSxARzKZ2W7tIrTmyZa6GcTn/vePU/EQLI5r4=@vger.kernel.org
X-Gm-Message-State: AFuF++mJp9XT1Choo/OTGFgQ+F/PRChyRXAFTOKCvTUtKFkGt5V9ub61
	ugUIqyXsNkq+juRQFxV/dKb6wRjdpuCF/xq8b1lS3CI5FhLp0Q0QSRhc
X-Gm-Gg: AYBFou37Q8VUpxC+QcqM8fGbsT7azRZWybIF6ea5DBEJYN7hRYnR3j3N7gqonw/PpyE
	8o/pL7zzb+cA3rk1hzaDqaJCmVvBrxNQx//vXeMeqb5XuJNbe+OT7XjwTdP86OTEHjUrBpxt/M1
	Yd/zyB1OwDPDI+8RkQDZl47QCj5ZRrtT9ig9I5sFYEwBIsFiOiL+Xrzcj6xheZsfffZKMC/YpAn
	ZYQG4GZ/UMT5E0hOydOTJHk8ry3YGjKJt+4jA4vaanGfhpDtjrd8tsv9FWX9pAVVF8V/xm2qjWC
	ai2xkn8FhYpi2slZU7Kmpyo2wX0Zt+NZmgsMkbplfZRirKNeWmFe4QTTbghuOxb+6NneFJl5513
	zrCVfogPX+9TM6XnAWR2bo++ZvCfk96Kt4fZBx6yQWspprs5djiCqy4317x38S5aNGxWBj14WcK
	L/blm0cYbHBRdAZeHXIEdTt5TMuAVUFUoGO6o1qbYs2t7HkcTjbwrbxI0W9JgsvtVOenRT3ZvT8
	zH9KIgmnn4Lcr7W0QuraLTTnVlZ
X-Received: by 2002:a17:907:9689:b0:c26:1cfd:4244 with SMTP id a640c23a62f3a-c2ac225671amr1087174866b.11.1790607888866;
        Mon, 28 Sep 2026 08:04:48 -0700 (PDT)
Received: from APAPAG-M-7WYW ([185.10.235.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b9c1sm495522866b.33.2026.09.28.08.04.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 08:04:47 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	bpf@vger.kernel.org,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tasos.papagiannnis@gmail.com
Subject: Re: [PATCH] mm/nommu: Reject wrapping ranges in access_remote_vm()
Date: Mon, 28 Sep 2026 17:04:46 +0200
Message-ID: <20260928150446.36873-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <arZzn0bwWqp7xTE5@gremlin>
References: <arZzn0bwWqp7xTE5@gremlin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> BTW always feel free to nag if you're not getting review! Something things
> get missed. (Though I'd say wait at least a couple weeks before doing
> that!)

Thanks! To be honest, it wasn't clear to me that I should take any futher action
after I received an email that this patch was added to mm-new. But after reading
that email again, this seems to be the case. The patch is still open for reviews.
(Sorry, still learning how the process works..)

[...]

> Seems reasonable to me! So:

> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Should I now send a v2 with those changes? It seems that these are already applied
in https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=1b721712d07e831686de53efc667561985897956.

Thanks,
Anastasios
