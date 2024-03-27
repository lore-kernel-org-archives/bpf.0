Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643817545
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509648; cv=none; b=IvhRBwpXQY2Jyr/R6SN46tvVeiaD/OEMxykrlWGifYq7etPPKMliCndFOn+j2yn9yTQ0zfqzbHdX+LtLSYx0BgEfjZYfKlkiAocj9NEGVx3JKvctmoC/fayrPzFr3UQ8dT6sdlU4iHbsJ7EyAMgPCYWwEan6GMYhoYFJvC/7fmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509648; c=relaxed/simple;
	bh=pD/7MHYfEEPT+nhdC4WXaJBUOL/NeKW1O0JIp+c0fH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oeJTr6zMgF0sD874ep/+xpO5otjdq1UN3dyf91jNwU+V2J7j0YGVrlY54/KJlhrnVP+HPooUq4pDqCavbuwFZfzgHNT7UmbizpCdD4HpukIlePPHhYQjypELtrBJXqmqCX1OYwXKwebZyqH5VMDHcw+y/py7kvNq/tHzvIvrwoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckpmblrg; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckpmblrg"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e6a1d24770so3556316a34.0
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 20:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711509646; x=1712114446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l92N7chaVf5MpwEsX5I/ubg3jeSFNEKEREgCg+8w/iM=;
        b=ckpmblrgHcCqQxKRPJDVYTVvsQ+IvZ7hBgf5F04Sna3N8vDIsQ14sWwxiTwu01K3XJ
         2y3GGc12AcvDrqbq2cqosFGcVnJ/BWK6hZwPCdRDXtqwfygPPvWorRumbWjIjSDVY+Ji
         fLwZVX1IdNZU5He+Yi9HihCbxkWa9/E8dZZ27LcBCLYrGkms5CT8tJwYAf717oxCMu6f
         t7+aq8wcutRyyZe1d2bsy+ZkcLGlfcfBFzO/S/9RkMXdCSkoZrBsbn1bDxl72F5k5XE7
         c5nP7q0pdXpbyztU/29U+D0ANlJZmL1ONZQ+fuZUUzG8d+gcHgvA3mSq1pYy/ocH02xN
         I8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711509646; x=1712114446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l92N7chaVf5MpwEsX5I/ubg3jeSFNEKEREgCg+8w/iM=;
        b=K+P8WxbtVkkt0/PKi41F+ydoVRC9UJmk8o9Tekz0mYceuX31VVxl9zT03lOwAcex4a
         1aTpdhhv8Q3MlIlJTVC5giBx8fvJxfPGkDodlAjHeT5CA+MQ+Y+pDPdohkI8U2Dn4IDm
         OgO5xyjGDcdR6g9fAJVqwL/tCnEfBqS2gQadyPpihBCzum+YZ2vgKGPclUvIUBcIGEyf
         BEol0IbtuycSa+iuAo9wrV6oL884VysYmK4uE5AobggN1PZZ/HLPbqLmuapabt4eXdeI
         lFX9zn+UWe0sr6ke4c4AekfGfjaP+bio3BIIBzIqxNiVmKLo9mNmXxQTsq7daNAqC87/
         LMJw==
X-Gm-Message-State: AOJu0YyY2T375qjpFZCRWgNB9C/LMuOpGHvbsNorMSX55r/RxHF9UTFC
	26eJ/o/Ji3Kw8wAOUp51SesOV0XWuiDZeJZbg183MaYAd8/hrsP7
X-Google-Smtp-Source: AGHT+IHSS7oVi7x4jXnwtMBedaIOeROjTn/j6jlcTO3YGH36n8MaF3XINZ1da7hjjH+6GIjpONTMJw==
X-Received: by 2002:a05:6830:16d5:b0:6e4:efdb:bb4d with SMTP id l21-20020a05683016d500b006e4efdbbb4dmr1607205otr.24.1711509645911;
        Tue, 26 Mar 2024 20:20:45 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.99])
        by smtp.gmail.com with ESMTPSA id o29-20020a635d5d000000b005d3bae243bbsm8300953pgm.4.2024.03.26.20.20.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2024 20:20:45 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [bpf-next v2 1/1] bpf: Mitigate latency spikes associated with freeing non-preallocated htab
Date: Wed, 27 Mar 2024 11:20:22 +0800
Message-Id: <20240327032022.78391-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the recent upgrade of one of our BPF programs, we encountered
significant latency spikes affecting other applications running on the same
host. After thorough investigation, we identified that these spikes were
primarily caused by the prolonged duration required to free a
non-preallocated htab with approximately 2 million keys.

Notably, our kernel configuration lacks the presence of CONFIG_PREEMPT. In
scenarios where kernel execution extends excessively, other threads might
be starved of CPU time, resulting in latency issues across the system. To
mitigate this, we've adopted a proactive approach by incorporating
cond_resched() calls within the kernel code. This ensures that during
lengthy kernel operations, the scheduler is invoked periodically to provide
opportunities for other threads to execute.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

---
v2: Call cond_resched() in the outer loop (Yonghong)
---
 kernel/bpf/hashtab.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3a088a5349bc..e81059faae63 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1490,6 +1490,7 @@ static void delete_all_elements(struct bpf_htab *htab)
 			hlist_nulls_del_rcu(&l->hash_node);
 			htab_elem_free(htab, l);
 		}
+		cond_resched();
 	}
 	migrate_enable();
 }
-- 
2.39.1

