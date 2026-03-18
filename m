Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77091184540
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873742; cv=none; b=GzBjd8L0r3zw8lbU/KVmlgqFouyDT0CKjhssaDjy+q5n/a5z3tkkSJplgokRTdAvqKy7VC42KYbQ5dDT9m+d/tuFDFtHf0rmTLqCBOQJpnuotRQgeUJHdF2d5YWAbbk0XrwfZ0B6rq44teaFaPXn+kNZkrSjAWTxib3fe6ZDyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873742; c=relaxed/simple;
	bh=L2rQ+O/AoNuvDfz1gJU4cLOXY6ZPgKG0R/QW6UlVd0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQ8AZtmASJ0LIewC+Bh7rBpV2rPFY6oTQpnGL/0Ew8PfYIUX2HuZEMpaIA/HYNww0YCq6zYmYgLngMes8fJMN3fdrzC0rh35sjXNvFLJln+NxN4W+d3STQqxoPSXHfg/JQz30GQS3G1Xdg/mVXhpISCKbqf52iMvupIoAxz5dr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acKQT5B1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acKQT5B1"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso252999a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873741; x=1774478541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNeehd/vlj5muEeFxvciWt3NrS8MhX6lts7hne2yrOg=;
        b=acKQT5B1AsFMfvIBo7Tya0bKyfhHe5XaQtEWYaws9YGYOSBGuzVrKoyULRPBeVSMsh
         IokS36h0QvrxVupPLhsvPUyDclNZMEftdQ6Qudga0Vj40nCv0/tCmf0RpBhzLjrRYmqR
         Ab3Lv2S2i2h7S+/+EjfpIJcBlADFWTsC2Us50eEEx7dHrMgjjVeawAEEUxxAnNPTMcry
         aELJMU15aTe9I5ME/jD69n6KV6xs184UAZTa0RlJANL3ksCYggIQH7SeRTe4WVNQmT9r
         Ezq8tn5dLNqJo8ffgRFvBHDo73QdbE8VAvyB5KN3NfmjlJc6k8DR4qMVllIUD2dafinF
         vyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873741; x=1774478541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNeehd/vlj5muEeFxvciWt3NrS8MhX6lts7hne2yrOg=;
        b=V/kD6g2G2gYncQ9nCupCq1rtwQl4cDWW/CbWabQNCn5ZW+asggJ3/J42Ngo2pLUxwz
         k/ot9QTyua0O04wRtx0QqcfMFI/U0n8fo83OtqV3h1TOyyBg55yo1B9dNe569j/cxI5K
         /K4nFJAru5kxkgMR10cK7HnH6CpYbO1LjrBKFT0ytOCMOh8eVr9xUGEg7CvE1Sf62Qc9
         rXoIH58cIvYJrdFiiXvEhLBR3jK2ycPmpTWkEKjviCEV6o6eqZAqVgoclqpVUaW8x2VQ
         aeLgBkQoeo5vL8g26wcNwup1vU2jZjFBDHf70arVBVm3dvQ0fjwQMjF79CwkCasqhbvu
         gpvw==
X-Gm-Message-State: AOJu0YyNd1zp0a7VwFMRSMkbiqQnzYQSAy5ySN6xS//zFAEKaKkd/6u+
	TtPh/crdrL9EI8BH2l1o0nvkljN4u+ZAvmJKXX4JVlMoLX96zkrpvJW7jYMToQ==
X-Gm-Gg: ATEYQzxedMMlBnaNLzz31ybZdYtKzBE+NrQ6/cFD90iYibImJhuoe/WdCrBjI1nccqH
	TLt9kgPnI56ghIojGX1//eV7fCl+CtzpO19ls2AqncPdlgtO1AO5DkU7iZHrqERajf3SXJ6Qg/I
	QECJbOo5x4fccGwra8yI2EkygwdjGK6enDgNg/Oty+dP24KAHIPIrvDeZA01FXhWR3DpJoi/Hpq
	kBggpHMRMeO2qlphZ3UPihEAdDSy62RMRIUyYOVIS0Z/D/EGr82qM9BOstYa6LKvnt33kpqK1aL
	788ha9+yAXogWQp1wFogMR1DqNT07Q5+UHBp8X97QBBNiSZnrN0rUFJBrgXjKB1dxMmPBOOh7yB
	44S1O8qHKllyIVnfyImFDSHh9Xvq1idtsxz1xvU2I7efCjJ2swHUPRqVtAcibd/GgaoTTKtBTxB
	QE09BW/YJ39GF/aQ==
X-Received: by 2002:a17:90b:3909:b0:35b:97e8:904d with SMTP id 98e67ed59e1d1-35bb9e55db1mr4479199a91.13.1773873740604;
        Wed, 18 Mar 2026 15:42:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc60ecb30sm662722a91.12.2026.03.18.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:42:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/1] bpf: Add warning to detect memory leak in bpf_selem_unlink_nofail()
Date: Wed, 18 Mar 2026 15:42:19 -0700
Message-ID: <20260318224219.615105-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While very unlikely, local storage theoretically may leak memory of the
size of "struct bpf_local_storage" when destroy() fails to grab
local_storage->lock and initializes selem->local_storage before other
racing map_free() see it. Warn the user to allow debugging the issue
instead of leaking the memory silently.

Note that test_maps in bpf selftests already stress tested
bpf_selem_unlink_nofail() by creating 4096 sockets and then immediately
destroying them in multiple threads. With 64 threads, 64 x 4096 socket
local storages were created and destroyed during the test and no warning
in the function were triggered.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9c96a4477f81..69bb2a7a71bc 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -494,6 +494,14 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 			}
 			raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 		}
+		/*
+		 * Highly unlikely scenario: memory leak
+		 *
+		 * When destroy() fails to acqurire local_storage->lock and initializes
+		 * selem->local_storage to NULL before any racing map_free() sees the same
+		 * selem, no one will free the local storage.
+		 */
+		WARN_ON_ONCE(err && !in_map_free);
 		if (!err || !in_map_free)
 			RCU_INIT_POINTER(selem->local_storage, NULL);
 	}
-- 
2.52.0

