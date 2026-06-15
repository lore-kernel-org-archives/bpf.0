Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189940962E
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540482; cv=none; b=RKD+OmHp2PPW9OgPKsiVGjW6n5zdwqm5E4q4RJCxsDMYhsE8dpr5NWSOAvrxbYxMgsOjTdb/PTEeEct+XzuSF/Ua5zpaf5cowATGpQruntJc3arBON9EJ3DJKtUXZR6xcd4u8Swwrxc5a5Y/YdTOfmgDsew1NdN5fl4SLWDP/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540482; c=relaxed/simple;
	bh=KgE+WqXVLgH30tVuySTTAVAtZ3WsnrJIYtFnIQ/o9C8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EAzZi+e3reciqM7yXRnPACiinQfzkvNivpIGbsXegqstjV3o336BnRvWyW4JRHI31rHK9cLTpOaaN+moKlrit84Rjck1NZVea7uWFO2/wY3+qLYlvb9zRhKIX06zGZKkEGZ4A5cE5UbIFUxVTriKiUELXp4lrYCizxZ/t177pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgwItR4J; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgwItR4J"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b3e03939so26415525e9.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540479; x=1782145279; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsblIdcLnk8NKn8tTHvEQP51D9b3911iBv8DFashUEQ=;
        b=JgwItR4J1zPxhtnMdepP0PH2ZUQLOEK3nGyCA5SRFkFMDhzPkh1igYygXr5McB14/U
         wZV6i1PMADtFARjvsMRNwN61BRs7WwYqwHZE2+Xqn0YMrWCha3s2RLcd2PMB4Z0hMYvw
         T8kv6+UnlyCondRDI8buahBNs9ptVokSGWUMc22tXIQ14dITs2zFuibFMi0oCj+c7EIP
         h5Wze6VJb05n1yQjehA3bQXK6rBHbcTk1mDOGp9BbwK1YauvvUPiu69GesgxJ+0RAfMz
         7dKe+UUcfNeNOm7dRLlQbW53l5m8EycXPv5ddTL333tOJPOchMsvPgNaO79ncB/anCIx
         Xulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540479; x=1782145279;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsblIdcLnk8NKn8tTHvEQP51D9b3911iBv8DFashUEQ=;
        b=bGYSbDZKGe9OG4pTlSQo6IyQILwVLZ1bnmJXJ2AHuR1g3Bl6emgKW35/Pe/BrCHFNu
         CV5MFjTTXhdcZcxbeuyAFALf3fZmwASWGj7BZpI4BePVr6wT1tY/YL+BAcCk0VkgtZQh
         Iun6uymquJTMX9u6WZbrJ02+k4aVE2m4bLPjhjlwl4acFNH5lXLmCoa7T0Qlsqf3aw3n
         3df11NFxsXhl0odXSPFeV2PzeN6HBICjHfBZE7cESLq4xiWSx4xn+jXGlboge9JU7m86
         CliaDFZrV2yWlBK7YlDFI4qm4KSQYc9ufFwr34n1qJtNCGNvwG+It+AzsNtZa2H7RwQW
         zXCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mhq9kEWxINIYT878lSaydwQgtGjPN1x5ng8YHzt5ch7Q5HlzJdEmDcua84PtijoWQfs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmjpklsSaEiVjMv9SCNBKsUsr/0ekULA3ICAeZhVINEzQ2gQz
	odzjv8NjyCXF1zFUxWYxRmfo+nUAl6OYCVNKDP8NWsCQMGz6ZkSEmkqep287NVDE
X-Gm-Gg: Acq92OG2iV5cgOUS7/1uhUliNl8yZDi3MKCTM/kZcrkD5xXXGo68lEMx0QHYEUgl8cf
	N53Eqicuv1VljorXZBm8S2PJoiBMKtnX+EzkBqLDprmNOCDdmG7DnlRDJJCqNwRj5fivUTHgmGv
	69Hu48ky5Oo82RKwN3Vx9y5vXQtPbtp+IKASiJB5kniKuRBoOj9ZtgekA6PNxS2Cr+K/FkSUPAz
	8tGW1AC1ODTinkTwAuyoQMmFSjsrgyOBQ7Q8emDDx0XGp5kLFIxGV3OCHmSrTgi2odBBOciHcDI
	aP1/+FSYZanAKTBwqB3vvnObZeM01id3s+JaGmhrA3ETdUOnSPNFb4K1uie3PKPdBYA2K5xB2p+
	97qTE463cL5BpNOqJIFQSNU2llGe9tn8BUarVznyCFe4yxd1tGQJ6rPomSAm6her3ycy+MSsxkN
	r0F6YzlBXkrvU/0xz1eq2Kpx21LREOpU9yRby2MyASZHS8BfGYAgA+KJG9ITJNbro=
X-Received: by 2002:a05:600c:810b:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-4922fac1214mr2934565e9.6.1781540479156;
        Mon, 15 Jun 2026 09:21:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922f9cd140sm4320745e9.0.2026.06.15.09.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:21:18 -0700 (PDT)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Subject: [PATCH v2 0/3] seccomp: Allow using SECCOMP_MODE_STRICT with
 SECCOMP_MODE_FILTER
Date: Mon, 15 Jun 2026 17:20:20 +0100
Message-Id: <20260615-seccomp-combined-v2-0-41687a943ae0@hill-daniel.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQrCMBBFr1Jm7ZQ0FYuuvEfpIplM7WBNSqJFK
 bm7sQdw8+F9+O9vkDgKJ7hUG0ReJUnwBfShApqMvzGKKwxa6ZNqlcbEROGxYAkrnh3qo6XWWW7
 16KDMlsijvHdlPxSeJD1D/OwPa/Nr/8jWBhWSItsZsmo8d9dJ5hmd8cJzTaF+3WHIOX8B66Kc9
 rgAAAA=
X-Change-ID: 20260302-seccomp-combined-24bc3dbe32fd
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, will@willsroot.io, 
 Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781540478; l=1487;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=KgE+WqXVLgH30tVuySTTAVAtZ3WsnrJIYtFnIQ/o9C8=;
 b=tqRvar313uQ6byQ6LFIU/A6uXQlUB6EmbEhMTrGFUXkX2d58V0C3UCC8MZ3h9UiekIaU2Nhjw
 tb/z86Bzs3LD7zRnVdu5q8O5RbEHtYRRWdKWgERNC1p+xZeze1YrKie
X-Developer-Key: i=jamie@hill-daniel.co.uk; a=ed25519;
 pk=ovqCXSlFUjrT82WuRtIuXB13U5n1yfxM6o0M5O5J2tA=

This patch adjusts the logic used by seccomp to allow applying both
SECCOMP_MODE_FILTER and SECCOMP_MODE_STRICT to the same process.

Currently, once seccomp has been initialized, a process may not
transition to a different mode (only add additional filters).
This means that in container environments such as Docker, which by
default runs with SECCOMP_MODE_FILTER, processes may not enable
SECCOMP_MODE_STRICT. This is an obstacle to using applications
requiring SECCOMP_MODE_STRICT in these environments, and requires
disabling these security measures.

This series adds a new 'strict upgrade' flag, which runs strict checks
after the filters.

Link: https://github.com/moby/moby/issues/42082

Signed-off-by: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Reviewed-by: William Liu <will@willsroot.io>
---
Jamie Hill-Daniel (3):
      seccomp: Store death as a separate field
      seccomp: Allow upgrading to strict mode after enabling filters
      selftest: seccomp: Adjust tests for using both STRICT and FILTER

 include/linux/seccomp_types.h                 |  7 ++-
 kernel/seccomp.c                              | 74 ++++++++++++---------------
 tools/testing/selftests/seccomp/seccomp_bpf.c | 68 +++++++++++-------------
 3 files changed, 68 insertions(+), 81 deletions(-)
---
base-commit: b9f0372b25cf3c41bf8eda02e65733afa5e8ad7c
change-id: 20260302-seccomp-combined-24bc3dbe32fd

Best regards,
--  
Jamie Hill-Daniel <jamie@hill-daniel.co.uk>

