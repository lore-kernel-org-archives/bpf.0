Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB2435507
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493086; cv=none; b=IEZW1f8bDG089KukAukdMLlOHujj2qyHJjSvHa10uFU1cVm9cT1+NFWyGNpNAx7vbvSNUbYqw8jWO2fM9M4ylbGVbcIfO3K7BEMZKknucJ50SZ+jH73z+mX04i9xUc1TAFPq353Mq4DRGRkvT6EZcPiNWd/8hJgwVlF0l+UPibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493086; c=relaxed/simple;
	bh=vpbeEaPR3E1pmaT/xNDC5hjULFUimCv8YKxCMpWM/dg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZTAT6V50K+tTpOhJElvTix9ZwTIczSS30XhKfLcSv8Qh3tLuKCqrch7u3zWqb2FlDZWXmhVlUpx4g74zlpROFszoA+/TNp2izCELLh1YIVGSW1iesvdQSdI0VIhCwpx2Ie5H9y81E7+d14WEXunyvIT+UVV5e0mn5BdWsITpqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=ZGQjSkiv; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="ZGQjSkiv"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6711f05fb14so3807789d50.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791493083; x=1792097883; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V0S61SflNz3PvfgcGBGx11GkE7hBo5diSyO3i89hlIg=;
        b=ZGQjSkiv2AEUSaNPDRvhadrbCMs1ALgftpyqaSsdg83snUiUpmwdtkPBHcPjXcMSW5
         WTxrlWiKiSu+EiohigdEJyvDyhVbn64MLu/fV8wqp16F9oO2eu3g6wku9vB9EbmI0EB2
         LB0WiT2LDRLnb7pQca7cTWOuOr3HtS8ca1rVms1p3iMuRVnxHkLTRYX3M3TWpvURtRSj
         eBE8oMrgkHViifnMrhbObPdyBF9FhNEDWhglMesj5txF1bXZB9bHgf9B+uyEAXeKEaH8
         Mq4q1kDoBNvoY68r5QfLqMIsyxdPRH8aGDwENlYI12C3ehEf5R+UOFa5poKnY/LbpfB0
         fynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493083; x=1792097883;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V0S61SflNz3PvfgcGBGx11GkE7hBo5diSyO3i89hlIg=;
        b=OYrnWaDfsuIrBgyzYXp9rpEw8IoB+5ZFnHKWDxDdKYLeBwbamft9e7/58ydNJ14AWu
         tOYEAeEBJbJ2DsPh3SxkInthVPEjFD3iwKyXiyUkK/Mf3Wp2d21YTIWJdh0L5wMUNzB0
         OrX1XkNxKmJfX1hM7K8luPBNrAKvVGtILR09C9ATxa0H9+7Hc9h59vqCCqyd461ys0iz
         UIJ+bHV7VLVZYX2HZja+/zMyifvBhI2+lZZWM74J14U4yOxKzxt5BEAuat4F8IXvO75t
         lBT8D0xr4/xeSevQu+SXI+ZNLlzxEiUHZAv74G4zfJK8qYAEcAkqY0ak3XximaIUiJq/
         g9PQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7Jq6xQ0VLMcFyZv6IS9c6DKeIL3MxBExu4m6uXgub9IaiTC0RgOTskGy/X5qP8yNZV7w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnkYx8cFCMZuz3LJCIXxmj3SURbhmPqSLUy68jWJMm8k6SCktO
	cSAd6GWN/3X6bRb5QbRkxNnFq3S/g2tKEqWsxAkVYxoECGepGkEeKfHadpm+nSTG2rNE
X-Gm-Gg: AYBFou0PEArAHJ2jynjZPwlVQAsLBP8L6UV2Ox4LAaHUCY9HA3KbqpctAGmihaHSNdQ
	UA3YMJIyGtiraBnT7FjfnCGLN0BWaX1B9CsMJ9qEEZIWFkElqKzxcpdchFFf8D9hCe12aJHsHiK
	CoLJMq3l0rPcckv2mm9pXEw4nZiAIO1ifS8DfI0WtFNFSy8ripPG1Oz/sSUQtkWZUa83ugFhtik
	txIvkbk4r0i7FaBYnF/M66ffHJUcarNT91rb/wLkdAFgBwxhMxAW8q7rWlZhm6AfH3kwsPH94x4
	F26RpsOygDHam3E2Ud2QAbXYJGd+jbuac9weu+rkT+zb9iScZgBqO3YwPHc0G2WZUeMJ+JaI+82
	sRgUSHcZjNGQiz4Em4gCHNsszJXYOr6cZRZHH2cFpkLvvxSaFud0OW2by2+DmZpl33llWUQbcUl
	/pio/fjLEQn3vgeIuCAFEpGWuVEkMxq1WDFz/8ragPfMfe4ykow5acDPx5ocvVOXUOqy+6SK5oR
	akeD8IfhJs9W9fd1M+nJy6ugY4T3CFetTV9unQp2J9gJNRgG1vtsVoI
X-Received: by 2002:a05:690e:d06:b0:678:4671:d9d1 with SMTP id 956f58d0204a3-679360087aamr34732d50.21.1791493083618;
        Thu, 08 Oct 2026 13:58:03 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67935707401sm78814d50.24.2026.10.08.13.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:58:03 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Subject: [PATCH bpf-next v2 0/3] keys: Add well known IDs for
 fs-verity/dm-verity keys
Date: Thu, 08 Oct 2026 15:57:34 -0500
Message-Id: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBBFr0JmbU1bsIor72FYtHSQUSikrQ2Ec
 HcbbuDy5eX/t0FATxjgXmzgMVGgyWWQpwLaXrsXMrKZQXKpeC0qpt+9HrTDldkx5W1c2ScDWXS
 ROkLPKnG7GiXL0uAF8s/ssaPlaDzBzB1zuERosukpxMmvRzyJw//RSYJxxkUtpW1FqZR+6PEbt
 Rnw3E4jNPu+/wBcIMGP3wAAAA==
X-Change-ID: 20260914-ajhalaney-dmverity-key-identifier-4187b6233be5
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
 Andrew Halaney <andrew@amutable.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.14.3

This more or less follows the bpf keyring approach, allowing userspace
to easily find the keys instead of having to parse /proc/keys.

Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
Changes in v2:
- Rebased / target bpf-next/for-next since 264d8fd2794f ("bpf, keys: Add a bpf
  keyring for program signature validation") only exists there.
- Grabbed Reviewed-by trailers.
- Link to v1: https://lore.kernel.org/r/20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com

---
Andrew Halaney (3):
      keys: add KEY_SPEC_DM_VERITY_KEYRING
      keys: add KEY_SPEC_FS_VERITY_KEYRING
      Documentation: keys: document IDs added since KEY_SPEC_REQKEY_AUTH_KEY

 Documentation/security/keys/core.rst | 13 ++++++++
 drivers/md/dm-verity-verify-sig.c    |  3 ++
 fs/verity/signature.c                |  2 ++
 include/linux/key.h                  |  2 ++
 include/uapi/linux/keyctl.h          |  2 ++
 security/keys/process_keys.c         | 58 ++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)
---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20260914-ajhalaney-dmverity-key-identifier-4187b6233be5

Best regards,
-- 
Andrew Halaney <andrew@amutable.com>

