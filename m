Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603113;
	b=Mpqn2MjCcwtpl0jaFhY1ECkbLnULfhjkH0Vgu6x/+hwdna+2aqfRzl85bRxyYwidGZYV
	 ukXQPsWAe2tPLE2iDltoNa5WDRdVAkJdnQ+M7PxkrWkEwGcRU0ibp+VjdPjYEA9NMhOsa
	 dLixJQ9Qvz2BgYVAozSCP4LNayAPYzGUYvEG4pMbqbpOZ40v5gKWv0sJuqjSkIAxNB8kR
	 +bgUfDrJQLB2sH6/pKG/TZ/Dntl49cPF7EeuNQhwHi0rh7Z9LMgoGFjgf/0f9eZe7tarL
	 75Gkeu569pSZyMXiPlKxARTpWcv078BBIHJa1JT/J5wQLw66Ce5dna6VFKpFaU8AqgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QxzgRFCSRCWipNXz6HQpmDljDRMnyFeDckVppufFRK0=;
	b=ne5CgvaxTdClvRwFJF3dbm3BzmILI4R9quCQFJBh0Q9aVqpiEX4CMVI8pM03BGyE1hdY
	 kTXF53mQS8P1/mkMXKoZjaU0OfikZxrosImwaaN66msF/XEvwFzACbaA8IMjrM9AdeQXP
	 Tplzs3XC6Klo6xDn+hKynUn7KPKI/GT6SowejmtanCl347WhX7+ZcK5PON5wx7IBGLS3g
	 T0OHKFdnawCTL8NsDnBUvIJGVIJCYK5m1E26xLViSY1DHaEOeE78c8uydR2dHGJDl8pV3
	 w/k9vsS1jm0tHl83He9WgAYCXU6Au0BN7VnfabdNBuBbrR7g/VTV/fgFrZedNFrOQhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=dk4x0M0n;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C064606A321
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C064606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=dk4x0M0n
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1011596c88.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792603111; x=1793207911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QxzgRFCSRCWipNXz6HQpmDljDRMnyFeDckVppufFRK0=;
        b=dk4x0M0n6a1gnLUPee3r+NjT8j1Nkq7UEYWVEznEutAfLIFhh8tCVa4wAUzBKXD+Br
         421GLuQ2OflI6KKItnsqDrvVxYgLi7mCr1KPzkw3vDJ1yG3tFQEF7xhxViNPGPrUX2yJ
         4T/5VbaSAG/80T/ka8ti3/Z+CvkQKkNJ9a2IcVKZrVxJ3Dms6SN8JarqiKhFulLBCVe0
         hMdaqSgQ4nNLDJ9NyuQuw+5kngTGseQC3bptIfru7+XkFQFzkwA2DbBi+ryWP5uLbBWs
         sGCIj4QzJn9NrWr/jlyaf9D08/hZPd4aydNfmsYzXJ5Y4C+Rcq7F7sDr0WtFlqzb4Dc9
         LgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603111; x=1793207911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QxzgRFCSRCWipNXz6HQpmDljDRMnyFeDckVppufFRK0=;
        b=jed4NWoL0WzGNFBjsVI+K7YiV5mw2pfisOgFNCTEvdGlcVrKeBHZLmzD7A3Cpcnoc/
         Qc+uQHHSOofnaofviipsOWLsBzgNtPLZ1hxEji4CbDRuIV8ikjUPaISLSFmyRrWiPUYm
         yh+uzqauaqP5NUWViO5ztFDBy0tjWTWUL7I/AayVjfblJFDg+RFSnay0TD/jVfaCtngG
         nytwuyxeEjP6h6JvOapjJRB20fjhGdW5BPyIXS3nEcJIwKzx5fgPbVK430uzPASAzdyc
         UJPqEqVjpeq4T786OKHlU317J3GvL5s+BiwLSk1ASSuX6Jt0Jgbcz8Akhyf2oIeCnCNO
         di8w==
X-Forwarded-Encrypted: i=1; AKwUvBzs6MKbdgkLQfkAn0/zvC0ccnazI8sqgb8Vh5JlNt+nN9teBqw2yvkeVHblIhc6FDljS0Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaQQomaASKxtA3u5NmOTxPm4Zo1pG9TTj2FrkE3dxmINFwepGw
	Gc6KXdXjNXYxIaljJ3qvFhuQs7C2EW5AKWPKTzw8QfXQDJEMtrGTSBnVdJxKxQeGmSE=
X-Gm-Gg: AYBFou38sO14lhQo288vPsVuLlscE+Xc6GxirI1A7ZY6mCPNphLJeHrl/0yQwZlFcEU
	fpY8vVNr22k81DcR0uM7QYrFjXhpwGhPZeOhD3AI1Vj1puZsQ4F+Hjtg3ZU3BYmTO0L6HRzTa/p
	sgyui9m9YNxnsocaWRDwFPVVvi959/H4JX2Ai653gSUR8W/l3m/5kxh/ew1WOCc/9py91gSUPfk
	2TbsJnStR6mkwhXaxooAMK9qcitmEyXFh3tv9l8eIWZDfASZ49Ywz4DtAKyG6hRcevaj0HdHkpk
	keeZ2cRYr4BgT2jPpxfmQtabVRe/JPKIHCFiqgDC6PdmLDe+7HUnFMClpo7ewqeRu/CllcSKX2C
	13O6v7zIfCiuMKa4r4dNuf83hd46AAYMAIQO2wuQ33J6ano4UIdd9kC2OZ2igMuepLbBDhDRgFT
	hD/QL74rF7m3T9ZBvsu1WPwANiSpQBdlt2UFGJWbZD7REiBKjmvw1aCGLsmBBK2LUcvEB5L5EM2
	BgtySviB3HvnqhnmKaK2CHcyhCJuErlcwaWoSb75u8plRwHZ9dniPM1ONTyR3TEjtexGHZByzlZ
	UmRY0HeiXOWByOjoYbelVbQosx8KrVm6m4ePcAlk439jF04AEI4O
X-Received: by 2002:a05:701b:2051:20b0:18a:d0b5:fa42 with SMTP id a92af1059eb24-190a604f7f6mr3396857c88.19.1792603111196;
        Wed, 21 Oct 2026 10:18:31 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d0a1sm7529738c88.14.2026.10.21.10.18.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:18:30 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: ameryhung@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	pulehui@huawei.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf, cgroup: Fix storage null-ptr-deref after replacing prog
Date: Wed, 21 Oct 2026 13:18:27 -0400
Message-ID: <20261021171827.380-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pu Lehui <pulehui@huawei.com>

[ Upstream commit 3f562c537e9ecf4bc5e206cfffc2cc047f1b7e94 ]

Syzkaller reported a storage null-ptr-deref issue after replacing prog.
This occurs in the following scenario:
1. prog A, an empty prog, is attached to a cgrp.
2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
   bpf_get_local_storage helper.
3. link_update is called to replace prog A with prog B.

The reason is that __cgroup_bpf_replace fails to alloc and assign the
required cgrp storage for the incoming replacement prog. Consequently,
the new prog inherits an uninit storage, leading to null-ptr-deref panic
when kick the new prog.

Fix this by rejecting a link update if new_prog's cgroup storage is
incompatible with link->prog.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicloud.com [0]
Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com [1]
Link: https://lore.kernel.org/bpf/20260807104403.1013064-1-pulehui@huaweicloud.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-90250 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/cgroup.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fa6f818c8eabb7e3db0de27cc6d58821e91189ae..a810bc0192de8e74aedfb2351f54c118eb8be584 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -856,6 +856,20 @@ static void replace_effective_prog(struct cgroup *cgrp,
 	}
 }
 
+static bool cgroup_bpf_storages_compatible(struct bpf_prog *old_prog,
+					   struct bpf_prog *new_prog)
+{
+	enum bpf_cgroup_storage_type stype;
+
+	for_each_cgroup_storage_type(stype) {
+		if (old_prog->aux->cgroup_storage[stype] !=
+		    new_prog->aux->cgroup_storage[stype])
+			return false;
+	}
+
+	return true;
+}
+
 /**
  * __cgroup_bpf_replace() - Replace link's program and propagate the change
  *                          to descendants
@@ -894,6 +908,9 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (!found)
 		return -ENOENT;
 
+	if (!cgroup_bpf_storages_compatible(link->link.prog, new_prog))
+		return -EINVAL;
+
 	old_prog = xchg(&link->link.prog, new_prog);
 	replace_effective_prog(cgrp, atype, pl);
 	bpf_prog_put(old_prog);
