Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4351862A
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771615098; cv=none; b=OwOB1aeXJiR1O0mjB8rliTsm2Iur8SobkKG8GkaNAvZxV7jIxIFz1tzjpQ8NlSVK6XEXqmBaZcpFKogXhOvihFU0FohxrqnZTs48oLrQyI5gbDI5L6jmfTLaruZnCv7AwCLU6ak5FkR7rFoioucxSPAKakmTDc78CpYwuT9tL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771615098; c=relaxed/simple;
	bh=MMKU9FqNgqz3NvXXH2j2SEZbmIqYn+jH5GJbzErKgAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BJdRzrcEhufnfPlAHqQUmcGgaqrq5vvuZ3ZojNryDTHsozz0jmGCu+kBDkk6y1iTJ5up/KRgyHbkstK3ZR6MYvEqXjKmQc427ZRMZOD3L1WCpgkFG/lRtq+ssTm0/QOcw/sUwLGuheAmla07Cc7zqM4j/Yfkeh06bjVWxpRiBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4opQ2pi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4opQ2pi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43638a33157so2239521f8f.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771615095; x=1772219895; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X69bRnKuXb2WX6TkOoSRj5/xx4z6hd6HuBxVnyJc/Ws=;
        b=K4opQ2pi2n/8QR4TMj+BcK9ijAnI+V7Og3LIlcjHLChUXCqf2wAJOuxaM1apSM+WFK
         3OKeVOf3DC51eB/Y7ojhdxe4FBq07VmnTe5yWV1BZd/Zp72676MthZehMdLmBrEfDmSo
         kxGWBXZUQ+oMyVBarOfruD8itj5V9dJo27uf5NLoByPOSgmKe3iYdmivslLDv5mQajgj
         kpyK6OwxPrvTgv58P0iuAUnEr/kCHhGPX9bUSg79lyCN5w9vlihDXxkjkXftdiXuqGAX
         1GCnfTmls6uhYOzqdrAXiHgRho+3v+1yHP28dRNzYBFfEfosSyGoKm8u15pLd+YIWxkH
         i43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771615095; x=1772219895;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X69bRnKuXb2WX6TkOoSRj5/xx4z6hd6HuBxVnyJc/Ws=;
        b=M7srQ6Dt9cRljGI/IzfqNigi/nIraEeFWH3+5aeABPxcDn6t/ljt53DfY8xqGOCxQZ
         vWFp1+8mQl2xj0229JF6KJ4sVbOlzWoyUbEAyL70TDcjiyvs9jglo1IzPvGAimYRSgSj
         HLMdcJruAqUhyIIfLHYYsFwIiaVUDx0rOLaIxHyLflLdxQfwTExUrWGhRhVTpNofGZcC
         Lr/022DbAR2amuX24gWMtg7vw4879+I3s4foRf2clcn2ME9Pb3XXZ2XOFxEEymDPeRUz
         9RydPrzeeZQMews/spPDkyHv1XNPzthqeATt8B4D+GFdwTgTam48+idoQdZ9mKvZ9UcY
         s5WA==
X-Gm-Message-State: AOJu0YzUKRI/3HjKfWKq5RKYMQ6MNiLkVuGk9nPQCSG7mKcZqCwwWX3f
	k/AMhfLvilLdQjKNk4g3ZIvs/fT3SSsZtmIG1bIOxWpdc9L0OeLZznmY
X-Gm-Gg: AZuq6aI7XsvpJQrsuB58HmdnC2+030fg6fHLxq+enwip+3DzW5yAZeUOZcQ3kemtUs7
	IzzynCbMXGMtd7Jc7zFhe9nXjauRb0xTpCoIigx5ycMhFcUBWS8prMKVuOJnj9ZWI9abQtIJp05
	40iuM8aneXZtUg12l2VTKFypP9Dqx8vU/plssl4vb8XzW+8N+v2BaRXl+yNalH1RolTu7mFZIuV
	ZPmG2F+Kq9PsHJz6gz1OTdS9eBGMgoOWSktZ78Lh8bCy0/Q4ePf+Gs1mhEuatYqBqEp4HwInDPv
	Z8vw5VPyxH24O+uX15mMdabR/6925N3w4HzlfqB2dIdE80RFFdLX4Vnbib1uVZHdaDaOsuKgJuM
	rjR1vDtyqYqQUP+JgxYJ2LuLxuJZIXMu9TzvDvxBPPohq0rL2pXPafvHKO0FhL7J5fkjZPPVgFq
	t8zN7RD0p78OdaQy28Yg==
X-Received: by 2002:a05:6000:184d:b0:431:3a5:d9c1 with SMTP id ffacd0b85a97d-4396f1753abmr1782049f8f.30.1771615094855;
        Fri, 20 Feb 2026 11:18:14 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fdd0sm86853f8f.19.2026.02.20.11.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:18:14 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 0/2] libbpf: Add bpf_program__clone() for
 individual program loading
Date: Fri, 20 Feb 2026 11:18:03 -0800
Message-Id: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGyzmGkC/2WNyw6DIBBFf8XMujQDqG268j8a0wCOlYWPACE2x
 n/vhC67vK9zD4gUPEV4VAcEyj76dWGhLhW4ySxvEn5gDQpViwpbkbkfk0mvLdBmAglTG6zl/aZ
 do4Fn7I9+L8gn2G0UC+0Jek4mHq7hU76yLPkPK9U/NkuBwulGotKjxcF2MyVzdesM/XmeX1J4N
 UK5AAAA
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771615092; l=2509;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=MMKU9FqNgqz3NvXXH2j2SEZbmIqYn+jH5GJbzErKgAY=;
 b=dyJnuToelj6qOXBzlJwFIskskp0Y0kYjB+KuL2P8BDFmCj6M2U6LbcJVN++dkXHp5OJ98cYSw
 0mgDS5raF3KCC9GBKAn3+3aXk2As0Mye9XaMHFmZRZMmZfOeCc2mooG
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

This series adds bpf_program__clone() to libbpf and converts veristat to
use it, replacing the costly per-program object re-opening pattern.

veristat needs to load each BPF program in isolation to collect
per-program verification statistics. Previously it achieved this by
opening a fresh bpf_object for every program, disabling autoload on all
but the target, and loading the whole object. For object files with many
programs this meant repeating ELF parsing and BTF processing N times.

Patch 1 introduces bpf_program__clone(), which loads a single program
from a prepared object into the kernel and returns an fd owned by the
caller. It resolves BTF attach targets, fills in func/line info,
fd_array, and other load parameters from the prepared object
automatically, while letting callers override any field via
bpf_prog_load_opts.

Patch 2 converts veristat to prepare the object once and clone each
program individually, eliminating redundant work.

Performance
Tested on selftests: 918 objects, ~4270 programs:
 - Wall time:   36.88s -> 23.18s (37% faster)
 - User time:   20.80s -> 16.07s (23% faster)
 - Kernel time: 12.07s ->  6.06s (50% faster)

Per-program loading also improves coverage: 83 programs that previously
failed now succeed.

Known regression:
 - Program-containing maps (PROG_ARRAY, DEVMAP, CPUMAP) track owner
   program type. Programs with incompatible attributes loaded against
   a shared map will be rejected. This is expected kernel behavior.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
 - Removed map cloning entirely (libbpf.c)
 - Renamed bpf_prog_clone() -> bpf_program__clone()
 - Removed unnecessary obj NULL check (libbpf.c)
 - Fixed opts handling — no longer mutates caller's opts (libbpf.c)
 - Link to v1: https://lore.kernel.org/all/20260212-veristat_prepare-v1-0-c351023fb0db@meta.com/

---
Mykyta Yatsenko (2):
      libbpf: Introduce bpf_program__clone()
      selftests/bpf: Use bpf_program__clone() in veristat

 tools/lib/bpf/libbpf.c                 |  64 ++++++++++++++++++++
 tools/lib/bpf/libbpf.h                 |  17 ++++++
 tools/lib/bpf/libbpf.map               |   1 +
 tools/testing/selftests/bpf/veristat.c | 104 ++++++++++++++-------------------
 4 files changed, 126 insertions(+), 60 deletions(-)
---
base-commit: 1ace9bac1ad2bc6a0a70baaa16d22b7e783e88c5
change-id: 20260206-veristat_prepare-a4a041873c53

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

