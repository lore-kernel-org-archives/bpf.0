Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794731218;
	b=wrH2TJEZqo1x6D6HzcnjqQMWhQ2+65Ry9GCMPfOZ7yezU7Prnpj79DO03E7DO8RVDzLa
	 lJghu64OMjF3ychPH+xannOhddz8OdjRGQ/mh/qtOARnzrXjPQGP1wHB2EIuE9x4gicUl
	 lfDkm20gDVVB8lf6JWU+SOpeNhMyBRswyZ4ROMqDCs5r3ovyzzk3iMnjEtLU7bQWo0FyH
	 i1o3n4mLz+c0Cto87BiAGCCqKkl5zNm4sjZCIOaH+XY13NkdSPBjhSliAxx+oxadjUBRq
	 TJF5xodypUN3yrAfErWPgaPExtZhbMgXnJak3UdXkszEFRBnK+0exyTZIFBWq9vmEoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BwbbUjCm32HgUeP4ZFaN0t0nCe1cf0Db2slrnG7ON14=;
	b=UtUNmuThvSCbb++AsDQuJjXZAbmqW14OlTDhPd0tY4iGGrVS/cLfCyxxBy2VcmgtewFL
	 gyOI7MSfrNFhio1XrEa6BzSIHfd88DrnJkT1p51MpvA/Z6DsdhNGd1TAuMFN403oPg07s
	 nOFnQw5tthX1Ev3GgX4vocrDW2p1kHGxmFP/J/FHOZWBsx0pN7+tn61ZMw0LJENWThPBj
	 bVJP0a7Bcp5XjS2DdkVcOm10qt+e/21leTfaW1A0qLt8Lx8IlaM/ZYWj3DXYWJYsYmSwc
	 lclL9p912OC+gc1rs5IEeFE8ECdTgJ8GGhkZqhzb1gB1uMdRuMsxk49s/wRJkdqZWJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alc0obJY;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD24606A89A
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 08:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD24606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alc0obJY
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b467581b98so18452895e9.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 00:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794731212; x=1795336012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BwbbUjCm32HgUeP4ZFaN0t0nCe1cf0Db2slrnG7ON14=;
        b=alc0obJYXeBbRsPUUhRUXSNPwqD5/0rFD0tT1kMNMovG8tARE/UWJwkF/W0ANfPFvS
         yC70yshabfB9RMmWhQOszbKmvFXcCMqi91Oopo8tPHa7uKoa4hERGT0aPcb9kgxM9O8n
         qY+MMzxhSr8UPtwFSSFt3hcRQz5P9UKFkkVLsAiq+IBs8fx0oOK5J2uFhyJuYt1OuR3H
         AaGNAjIgYm9Thv6zz3zrdnI/VWLa2/n1vDCEstO7ZQKSzyWiV/Dqs1aG3mWr2Ph+HQd8
         /qxVZLC2MB03q2lqv+gkH8EWocGc/6Cxz2duYDRmKxZZD6t3m6LhlBX6RRArAt8BFlyC
         aT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794731212; x=1795336012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BwbbUjCm32HgUeP4ZFaN0t0nCe1cf0Db2slrnG7ON14=;
        b=heiP7SJlvbUAFMONptuRC4jHlsLGnb+XUcqrA56GhWjk7jBLDl9+XU42lW+OaQV+hh
         lIIGBGwg8MaMmPKU8PWorAY7+Fdu+w6aWtqChiK4yiDRA0HuxRs0JX+n93DvvBROAZRW
         +b3Zr+eko0p/nDFNC65NXj2G2naYOFHVTacmZNDwZdMxPuwSnpGbprgGX2pHrNXIL/X4
         T12QjOsHjPfjVAy7g5Yx24mNwYHFRJpQ2qJMqE0Bd7ssC2W7DnVkiLRguq3wbDa59g85
         eZtGHlmvC2bD2rX+gkycUp3zn3KxWVLbI/OY8UJ5D954UKpcvraT+u+jScFLrhSvGubc
         w1KQ==
X-Gm-Message-State: APuU4Z+gRJlvirpawmX4CCEdl98fKU3I3Wqc6mLZysBjhvi+/yFc/kVT
	Y66evi74x4XcQSWzNT5Di+beQQK/9Rgu6qYWTqZ0AJ9jxxqhx8864UdoJsORAQ==
X-Gm-Gg: AYBFou1T+cNa/opdE5uV5WOqJJB8C/g5pipk/y11nTsy2Q2+3CYJoO8q2YbEE1M4Iwu
	27MH5Vg6jKI6oENx1xW5skSQwi/NubFkMoanemty66QEyZTFuZ+LnxAv1rToLIzC9D8hcq6DrO7
	prA8ZGXGMKZwfwY/hmHUbw2CJnQzdkuM64hF4JmI6VrkUDqVBR3+CPKgfqVQw1kxbgQ+ZBpJo8F
	gcqGhmF8f/axqyB3kdY2QoEzxTBXO0CHpQybltkRKMxTHaZeLmGiIPhPNLTCHAazJ7bSuM2Mafc
	bEyP/v6hRFh40HBDJOfnMs1V9kZqW7JMtPe/9rg2hLy3n19hnkgGxQlSDhpGo1oDYpE1mYijfYj
	a7/39c9ocZUd4vIPgw3aMS358tfCX+5Aql0UkCTVtutwAVs0oe9zQF/mgtbAfv4HRq78rNjuQyY
	Rm+B/iQNuqstWHv912hbLCu6+AQjkjQOunzKdX46kJ+jMV/H29YZYdYMfHyK3U3PsuHR6Cywrkj
	A+0sDyohGrYF+1XddJHheLohL+jAbfyHql3CnUMwOcBQslddAPsjtlvO9L2iN39t8Ia108J0LxO
	7n6WILSV+L2uJSPAim4x/uzDgys+e8dTfnA=
X-Received: by 2002:a05:600c:8b65:b0:4bb:6a5a:783d with SMTP id 5b1f17b1804b1-4bb6a5a795dmr23310705e9.18.1794731212247;
        Sun, 15 Nov 2026 00:26:52 -0800 (PST)
Received: from thinkpad.lan ([2a06:c701:474b:1700:e121:98f4:7e8f:ef80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm15452845f8f.23.2026.11.15.00.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:26:51 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	brauner@kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH bpf] bpf: Prevent reopening BPF token inodes
Date: Sun, 15 Nov 2026 10:26:41 +0200
Message-ID: <20261115082641.131459-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.53.0
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

bpf_token_create() assigns bpf_token_fops to the inode,
but initializes private_data only on the original token
file. Reopening the token through /proc/self/fd/N creates
another file with the same operations and NULL
private_data. Reading its fdinfo or using it as a BPF
token can dereference the NULL pointer.

Keep the inode's default file operations so fresh opens
fail with -ENXIO. The original token file continues to use
bpf_token_fops, while duplicated and transferred token
descriptors remain valid.

Reproduced on x86-64 using virtme-ng. The fresh open
succeeded before the change and returned -ENXIO afterward.
Also tested all three ordinary open modes, O_PATH,
dup(), SCM_RIGHTS and token FD lifetime.

Fixes: 35f96de04127 ("bpf: Introduce BPF token object")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/bpf/token.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index aa42243af16b..df4962a40e4a 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -163,7 +163,6 @@ int bpf_token_create(union bpf_attr *attr)
 		return PTR_ERR(inode);
 
 	inode->i_op = &bpf_token_iops;
-	inode->i_fop = &bpf_token_fops;
 	clear_nlink(inode); /* make sure it is unlinked */
 
 	FD_PREPARE(fdf, O_CLOEXEC,

base-commit: 4b4eb7f44ee05754339d07e9df649809f45d14c5
-- 
2.53.0

