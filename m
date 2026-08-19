Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3478F26
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101539; cv=none; b=jSu7A+Tep0kMbqcEL/OephY1I3WO1cida6zNBU5hwJRC1jIcqCU5b1EQMRXLbMrSGHoAfF9FucWlLukayDhJNOITdUhk7Bep10O1kxCppEgaeyBGnqzExTwyrbO9JTCCx9NGFbExRc+gKn8VqT921B2tzB3BFcHWhj3a3r82QXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101539; c=relaxed/simple;
	bh=90FGMOqfaMwKFE3m6MrCWpsXGFOlRbBwVWKfP0t4P9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eF9Kw43Jw+DMeByolS8lsJJTDL3SOcNsSAzS47LuYQrylBAWPqZ0vAjxteGregTRjbBvuFw5fdNupS/ayolmuCkXKkpgv89PnAaG0kfQd+yU/DYJUEtiv4Hjs2XUMQvkx+Tv/2fTbpt2eJ6aoZtLDWUcjBg5KCmqk3iSlQrXE1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPT9aDkx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPT9aDkx"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90a92f5000aso5968616d6.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787101537; x=1787706337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K00Qxp5YCwypDmxrz55eJ7p4e8/W3wjazUln9Bb9aCA=;
        b=gPT9aDkxPG4ST3WXII+bd7l4tO7sh/CqvHCMWFoJu8RFlqB19jGEWnuQpgEpc6vzg9
         CrcUw/VqcBQu0+R1YAJt3DchhN7V2+xfR9OOIPiFZGgbwTXEcYXUVMqNEKsd2H6eicGC
         esqoi/MSHLjajy8/Z1Alrz6P97JYT50sbGvsFvx8xi9Ge2/gpW2ne4xZeoT3+tKu5STc
         amL3Na9GYWMKrmWEjmiyFmwxtushZdk6djaSHrTr4nCYA6Z2S23eU0jsY5zHw6G27Rrw
         AJusUySsGEnVwykLEWaE45nDKJWDVi2kwV6rUv1FAgX3eCmwqBWas9Rfp/j79/7Pk+La
         bBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787101537; x=1787706337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K00Qxp5YCwypDmxrz55eJ7p4e8/W3wjazUln9Bb9aCA=;
        b=ozVgYzh5Yvx9+SYxNukSzf/Km9CNhUgpvzqEbnP3rr2L2ZoyqDiyyyKBp3ElglGD6G
         SZCx9VSN0uK/otV00ws0C5FwuKJlqUc62n+QIng4V4ZGvDI7c//XTQzl/3Z/8CNtD+9N
         wSu0R0raJ24az8Ot8kd8cuJeirhmMo6fpwXM+jlaLmONo0opjHG/ZNAWUd8Wz0mTyHvg
         rLH58ZP3l6G4ZeTI0jIg5ZTVmupNwZJ1Pb9SVZpTlRcreMEZpWN9d7w8MK15FA44EHgc
         IQEcrl1zo/naDECW+Q9Ie+HJebwoDdjFp/tctEg0r07IGBc7lXyl1XXJhV0KZA/KnaHU
         5N7Q==
X-Gm-Message-State: AOJu0YxkvinDS+i/O/9nYBCZpxUjCB7LrGE2kzMG1OGseEtNAYAKaBSz
	3Eso3BoCVP++lqeVXllU3OUObfCREjpt/KZd4tUjKGqj22UJRSjicHDbm/E6Ew==
X-Gm-Gg: AR+sD115AiLOkPNEeTkWjUfrdXM7Dk0D3fD81UOXhVPC6d+D6cxhWzJa4MwzIEYuocL
	iyOk9AVga2Ocd7K4kb4Ec9iJBsqSqpUdkWUu2AUBPrnBi4qvPJwD8ZrGiI1kXe+dLoia7Zh2EIL
	N9q65InKzCnKmuM8aolPaZcIqWdHP29Ot0KnOH/vc0d1N0rAmk7emXqz5b0XNhOpI4yy7sFF/1G
	IKht1PoYALI89QYpWfLNOZ/YLqbr3Wv/NZ2KJJR7U0KNqhIf2IX7A4kY6VputK4ta4iqMEn96B2
	sUtj0vaek4o41MqrYoU6FV5D94f8tCQ0MxzAh5LNMleVHf0KWj0tJ5fHx3sBaf69dCKaBu+pw22
	z6yfvXpP8wZBEQn2okCw3rd+tCwUIYT/cTBqk4r0teJNMdpnTl13hml3o7u3mc9HTPLRtTYtwef
	90h2jwQSaLOgn+SUSom8RVm4MtUWzavv14F38PuMnlLikUQWPwBWJN4Y4kww==
X-Received: by 2002:a05:6214:2c0e:b0:90c:4d5e:d8dc with SMTP id 6a1803df08f44-90c5eb40218mr9560686d6.28.1787101532058;
        Tue, 18 Aug 2026 18:05:32 -0700 (PDT)
Received: from Turin ([187.15.143.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f29065bsm2398716d6.24.2026.08.18.18.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 18:05:31 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org,
	tsbogend@alpha.franken.de,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 0/2] bpf, mips: Add BPF_MOVSX support to the JITs
Date: Tue, 18 Aug 2026 21:05:21 -0400
Message-ID: <20260819010523.1057789-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf-next is closed for the merge window, so I am sending this for
review. I plan to post this series after it reopens.

The MIPS32 and MIPS64 JITs lower register BPF_MOVSX as an ordinary
move because their register-move paths do not interpret insn->off.
Negative low-width values therefore retain incorrect upper bits.

First factor ordinary register moves into backend-local 32- and 64-bit
helpers. Then handle the BPF-defined MOVSX widths from insn->off in
those helpers. This keeps the verifier-inserted ALU32 zero extension on
its existing path and preserves the MIPS32 register-pair handling. The
implementation uses shift sequences rather than the R2+ seb/seh
instructions so it also works on base MIPS32.

MOVSX can be applied before or after the in-flight SDIV/SMOD series.
Both must precede MEMSX (yet to be sent). The ordering discussion is
here:

Link: https://lore.kernel.org/bpf/CAJZwKkis=3NGw9At0WfiZaRYEoMPbQfqJKN0e+vtRDvp4VY5Ng@mail.gmail.com/

Patch 1 did not change any test_bpf result. On the four little-endian
profiles where the complete suite was run at each boundary, patch 2
fixed the ALU32 byte and halfword MOVSX cases and the ALU64 byte,
halfword, and word cases. The 32-bit totals moved from 1031 passes and
31 failures to 1036 passes and 26 failures; the 64-bit totals moved
from 1030 passes and 31 failures to 1035 passes and 26 failures. Patch
2 did not change any other test result. Ordinary MOV and zero-extension
controls passed at each boundary.

Selector-focused QEMU testing covered MIPS32 base, R2, and R6 plus
pre-R6 MIPS64, each in big- and little-endian configurations. No
physical MIPS hardware was tested.

Nicholas Dudar (2):
  bpf, mips: Factor register moves into helpers
  bpf, mips: Add support for BPF_MOVSX in the JITs

 arch/mips/net/bpf_jit_comp32.c | 54 +++++++++++++++++++++++++++++++---
 arch/mips/net/bpf_jit_comp64.c | 48 ++++++++++++++++++++++++++++--
 2 files changed, 95 insertions(+), 7 deletions(-)


base-commit: 6655c409707ec8ce9ce0850ffe4fe02331fd4d9c
