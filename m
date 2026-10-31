Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484378;
	b=K9Kk6cSRoGcGwIwy5bCER893t6tstcU91Z0tUNoE6lQUXQxJ91RZd4NXPo72ZMsVAiR9
	 xbhLvJKay3x9z8X/yJja0USBHtEPs66ZbztV6nSGS/NynorTTAF3ZURyDzB+Z2+tl9HOx
	 igDf0XAg3QGvXuCouUfN7QWbuw7697tr5xVxD0fUGHrjU1maduoz00dGGQH79Cgth5Bw/
	 XCIaGiw8+MQJ1BZr3yKQsNnaXOsEPTvnjE9LaRoMDatFya7UsDbOzyaus1Nyn+yGYFrrv
	 IMlz5AB2ckXQI/gKuZuQN2hELuTUDrLgQkgW9LJaR8gyVyfiJfY1Q4snRzcms8omWVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tGh44ZX9IP3H+G2VpzMKFgDsAUCDVrE2RYYN0ijxXSw=;
	b=NGj+24cuzBeMC94Y/uyUn3ShqKkVBW7O74Tixut5Mvn9jvvO3swL0QfwTJzsML6S14Tn
	 Werv2RUPePCzXy/9KM6gTSrzKYX3wkevAjOF8fLCyz6qBH4il/v583I0D9eMDRAyu6Ojx
	 lWqVqF0SND3saX2mCCBv7Lh+NZF9R1Z4Hg6MeeU3G8X2lqCyvNe2/dwlOzzaKoYuXwb80
	 bBzDSeoIphBZyFKnrudYE2tkVZVH5MEtgwXNo65E0tMa/CTKwS7DFyYPNnn/11j+oSbrT
	 8GBD1kIIlhQflP56z8qiApw2cdWHryeeDpZVST8q6gVecMTTi2C7hbGeyD8Mf1e2cyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHCtYesK;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AA606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E62AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHCtYesK
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc502d509c0so683942a12.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793484377; x=1794089177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tGh44ZX9IP3H+G2VpzMKFgDsAUCDVrE2RYYN0ijxXSw=;
        b=qHCtYesKIhg18Eu/At9/pfzML48NvFc1mfSR71ROH7QqYAKAn4cC7NhAOQ6QqgHFLU
         XtASBFR+gTFS/TcWZx8CNLf8dYGMHA7462LJSL6bpsdv4HehbLL1jr0Y8PIuawxUORxc
         2djoLwm/MznOXcausyVhhZeFymfPBatPH+9yzdczDn5MKgm/Dk3WzbyIq4yqhui424Xg
         lFy9GcCwRSIBLPOA4jE/3gwF1jT7LS9lJaIcEBGxNnVOnaLS5O9hrSGrRlhcvaVDJBeS
         fr/VtSgdkkqQQsEIrz2uEnUiu9K3kSHT5Fmf/ra2gmv0ZqarmFICtCCetfpYPaCzTHA4
         WNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793484377; x=1794089177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tGh44ZX9IP3H+G2VpzMKFgDsAUCDVrE2RYYN0ijxXSw=;
        b=BpuKzIsj4tu8HngkNrDMn8SBO+anSok5YpFmR70Ok0LKcGWbtb3UVh/E8iALtIUBmS
         nPgEQBwwVSymDA7pVamqbyBXH1VCAK4qEY98pMn1LxntIW1Z7q4CpO01x13mvQU6AMKQ
         HlLaRbrv4sbAMo7+A26+ZuxvweKY2/I1NgyUqazyogzzlHZxpAYj+dsO2j36S+YQ+Pdt
         +urFapVUpv4i6FhqgPJ2l+G6MWRfUZUewogzgvicUcHYBRwvVpMDKobZams4X8ClcNhz
         A8nuhjUke7rt1Z1JjVsviN61nlQvi/X2jgCnsP0+BgtZEFzbr7j+OENpY7JrJf2Q8PRd
         410Q==
X-Gm-Message-State: AFq9FYIcB16z3qQCh1sYoQXE7tDVYYsmI7hX+xdzQSxuW3l/pshuejVx
	6XBeyUsDqf5RAvRD/ECTEbSz6+U93uuGrx73h23/s4n0H5Cc4rhL3vnRJrJOmg==
X-Gm-Gg: AYBFou0lwC0X5GMgGQgdJSdMnI8YupeKH7ZLmJJWo98H+fjAAkGBgV7czNiV+l/Bbeh
	ytPXL3zpOHe35wFWXHCQ1OwewEdPJXt2fVosIO32cSGmnGaRNZFX7eTzWEWvVlCBXDbwgSXbL4r
	hTNd7wEHIJfnHi56zxiKloobBMHsNCn9jb2qNLYvcsBAhxfgIH456o8QUaJPPa/KLVblj+BpJ9/
	Q6UqYGAkmd6Q8xR9njtv9z9gJWt5U0AJrHOX79Fl6q7121qdEzGIncjCoC8KHxJ8n/jSbCnBNmH
	lZOYD+BgeIpxF734SsgkE1CMG21OX90105YGLw9Z/9VRAhEsD5qf8GbYEYvl+XHeO4E292OxqzX
	zzc9ysSU7xMfmuAXVviGq+JxQXfiHwE3EFOohtGnA60MBMqdeo5RulpGK874gcwbScjoFWgi+vy
	n8Kqbe5xxqqIz1acdEoCyjCJxJddODSwJBi8FNDNwIfHPGIYE0JlqGjAC+1TIsgBYAcPYSx5xtg
	RP1tIYbLCMVADukArHmN22Rgi+21C/AOxOGEN2zIw5GYpvP/OCzkNzkgDSmFSpWw4bCcuo1jaKH
	GazB0UiwIaxvaEpbhQ6aUu4/5nl5ZHf/eUOerXVcmnQkfNRh6naybvWCgDUFqmrDAyv9lXLKk/r
	ZqpiEvxbyNzK9rRbfAy2zUuB5m5WZlawov9V/rGFK8j5tDbiU8ue+LlLPgNN0P2l7zeeNYADQvQ
	==
X-Received: by 2002:a05:6a20:c759:b0:3eb:34dd:74f3 with SMTP id adf61e73a8af0-3eb34dd75demr2050174637.11.1793484377030;
        Sat, 31 Oct 2026 15:06:17 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fdb34sm951168b3a.5.2026.10.31.15.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:06:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 0/2] bpf: Fix the join of fp+0 in the analysis of stack arguments
Date: Sat, 31 Oct 2026 22:06:13 +0000
Message-ID: <20261031220615.804426-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The analysis that follows pointers to the stack before the main pass takes
"r10, or not a pointer to the stack" for "exactly r10". Then a store to
other memory counts as a certain write to a stack slot, scalar evolution
misses a real write to the counter of a loop, and a prog that accesses
a map value out of bounds loads.

Patch 1 is the fix. Patch 2 is the test.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: Fix the join of fp+0 with a value that is not a pointer to stack
  selftests/bpf: Test the join of fp+0 with a value that is not a
    pointer to stack

 kernel/bpf/liveness.c                         |  31 ++---
 .../selftests/bpf/progs/verifier_live_stack.c |  29 +++++
 .../selftests/bpf/progs/verifier_scev.c       | 111 ++++++++++++++++++
 3 files changed, 157 insertions(+), 14 deletions(-)


base-commit: eaae576c34d7e001767b6845a5950b0b8db3e68a
-- 
2.55.0

