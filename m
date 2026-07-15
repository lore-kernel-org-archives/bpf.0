Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485601F192E
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093741; cv=none; b=YIg/B4XA+1WE8Qm/IggiC1MJ4nUHrvJF9RZuI5nEfVyOSQ+dcNONf1dTiwl5x7q6sIfmGzCwLE5VtOhPOn+rzOJec5RFZOBcB/znwqDMQS8jXZeHYDzCRoSLeJ5SYbZyuTI5BCH4FIPgQFrcy4a37IRFXxUBRSFFFsWwFYMMsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093741; c=relaxed/simple;
	bh=pJX/4lNrcag8H0C5X7KRzo+mZLWneQs3WuoJyZPrq/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KNa72H8R9QyQxkN0+V6mkd6kGA41802fJwNsEMNLzYv9bjWzaDzJGVIRDpqeQTHnlQ510PEj0ztMNNF/HQIo95Gy9EUpo03PLdc0PI+1riBHBoA7/VeokWLVEQMP+eKFiwYOv4nVj0pAnVF+RLKidp+0zcluqiaxMLJZ+7gTjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=QiEaMwsi; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="QiEaMwsi"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7CA903F608
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 05:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784093735;
	bh=o7X0Xr58oM7rQRCx2gdCy8KQKCUZWoTYtzajiDu6fH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=QiEaMwsiKbLZmGjYTLv63+of2NuSLJYdmTdw327OnZmp0ZnZKDAVXlvF2XYnVHvez
	 bL82zKGcre62LNJnyTrk5fgIDSPa0f8yO2FaPGXlWudXCY6ISj5TWELy1JxypgHcF/
	 nkrsgfbv+ThVPMcOI1rtei9YHHQlueg0gz7zROwHdR6fz8Y95PuDHX/WP/xLS2vqO2
	 LXw5vBnOIk2y0o9ame5Zu9uAdxhzdGHowqwAtRE6EBilenvBmG9MyMN5oTRxCBC1vu
	 X80ErDrmPUjQ3Q2GQxfTaFwSM64BwkNxuYyOfC6g52gB04nFnuGkUzuVkJBQ4/Yxmg
	 CujsrGOostOfmey8FebxCOEYXP/un0n12tnnSENv1KiGpR0kdJmuMGVY461PxXQpeb
	 zx6GSRMY/I8sIBPaAaYK3Gu0jODnEXogKSGConcZCvBbmLWCaOJdq/BzonYEumyRZ8
	 JynqM70ywFtNEp8KF8BfJplY44dE2Yc65rROZujTz+wuDM9WDs9sKtSaqv+fjXuE84
	 6Y0L812TXR3FAZUOu+JXPZz4II1k5ouRTNj4ROcELJdnbIJvsdqrROziebjONlQ8+U
	 dz2h1N3DRLQC4KPp9znGXc/I7vzFa6JhWhh/G9Iz36d/0OSyOPgkyTA7RBH22yhUDC
	 FF1aIfVDiCxjSRPvbcgL6ZTA=
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cacf17c7e0so24575325ad.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 22:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784093734; x=1784698534;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o7X0Xr58oM7rQRCx2gdCy8KQKCUZWoTYtzajiDu6fH8=;
        b=h/Gyo65aGau5XCYhFRY1kWCXLgxn53J7msHkaKt5Mt3r2tNuhydKxXl7ZC2qYJXg2+
         g4SqOq5fyfJ+fku/cdYI+3QeszcA8AEpDKOHi10gB+js1ZiTh+dQKmRQrMGrviZBDlR4
         NIbSfetidTiHVtyqlBQE61+UHy+b/7vTvfL5bE6w7cmQM/8D3aG2J8e26GLjH1gi1lMI
         MRQgvvO79pbRtfYXw04oZSqJxbHa+7iwphbv8hZYyVctZBwl6U8eDF/3DAPRVsw1LJwb
         l0fSuFVZFQlIOxnO9tJc964lhZ6wDLhkwRHfUss4uNCfKxwzwEvoDak7Wg6YGq/yBt9k
         KgYg==
X-Forwarded-Encrypted: i=1; AHgh+RpNKPolR88/i0Bijzc+LziinBrDuGYwVabTppEZxqYAmd7SYv8UskodJ05/ALLQQig6ewM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyzvBrAKS+Aok+avMLZbckEUridY1wCW3YmorLBAXUixykDOa/
	rkU6KYV1vvEwykrY/Z4SVT3SOg1KSNdaRMOnN0AmCcqrlTZJL8I25Ji5GVx4SnIVhymf3xqAq75
	5DKCATLaosQR6fusaOY900XSMAQBYGsZ+jPrbh1piG6WHlz4iRA2cD6uwaeH1jsAVblq4UpXrr4
	vkcw==
X-Gm-Gg: AfdE7clrCb+dEsXMC11mzJECyxI9wmrHLbKYo/PQV2Bg+LdzbzZCQgLTtQ1jcssNV7o
	g/wOVtnNIzQ0EHrtoI/tJwLNVDnDDElRV9D+cmqhSt0ZtAYFZ9yc7fpXoMndLh/n2tF406Z5F3A
	VIuDQJCBR8b/6O9QtgiEybP5I2cd21Oe/1PjdBkPB83ljttsxYFhNWdPV5ND7m29Gd4CMbhvr8C
	rC74BZ4AeHxyAudsjjGkr+0qs7WfXAZNcZ2u07XJZHoVQxnn8nuTqhgOmLWOq63M0iRi4rhfOuY
	qTNr34EkBNMhPOc+k5FqM+Hh0hqgI2b73xzimbwhMMsu9KawrmK/iXh81rCyyW4mt0ho75O/MxC
	lN3cWhAUDrb7Af5g5aS0srCHdwdItWks7qq56Gf2JewpRxBh/Mlv9AM/GdZuMBMgGKQrbVMZzDK
	2o
X-Received: by 2002:a17:903:468f:b0:2ca:eea:eb5c with SMTP id d9443c01a7336-2ce9e9ad7c6mr169580575ad.18.1784093733869;
        Tue, 14 Jul 2026 22:35:33 -0700 (PDT)
X-Received: by 2002:a17:903:468f:b0:2ca:eea:eb5c with SMTP id d9443c01a7336-2ce9e9ad7c6mr169580385ad.18.1784093733497;
        Tue, 14 Jul 2026 22:35:33 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cebec91c92sm51358305ad.56.2026.07.14.22.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:35:32 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Fix pointer type mismatch build error
Date: Wed, 15 Jul 2026 13:35:52 +0800
Message-ID: <20260715053559.28535-1-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We hit the following build error while running the seccomp selftests in
our testing.

CC seccomp_bpf
seccomp_bpf.c: In function ‘UPROBE_setup’:
seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional expression [-Wincompatible-pointer-types]
5175 | offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
| ^
seccomp_bpf.c:5175:57: note: first expression has type ‘int (*)(void)’
5175 | offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
| ^~~~~~~~~~~~~~~~
seccomp_bpf.c:5175:76: note: second expression has type ‘int (__attribute__((nocf_check)) *)(void)’
5175 | offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
| ^~~~~~~~~~~~~

get_uprobe_offset() takes a 'const void *' argument, so cast both
operands to 'void *'.

Fixes: 9ffc7a635c35 ("selftests/seccomp: validate uprobe syscall passes through seccomp")
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 358b6c65e120..0622bc2acad4 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5178,7 +5178,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ? (void *)probed_uretprobe
+						      : (void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.43.0

