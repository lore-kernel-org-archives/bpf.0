Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE4489866
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593842; cv=none; b=KOfcV8LvD6oryLFEHuV3wuXupIO+l7BXmnvy1ngjWfUgb7TevTegeXshmxOvoPlgUE3mtsx7nZTx4Eaz3TB32WVBb83/lFlYkY0V0RCiqGwlUASpRJcCZST5S6nxl/dtm6zk4+8OVf8jYo8HdarG3Dy+eq4jYv3f9YRsSu1MIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593842; c=relaxed/simple;
	bh=PYT4ZbnNOltTAH830UgE8QUvoV9QQVI65GzA4VvF004=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XR+BxusEynJShT3yRycYHp9exY9U/FD6opdSJw74/hxVrKnL6FzF9+Yn2oN7lq53TUKw5wahhn5GlVJOv/X6s5A/W6g14D9HtNU3acYY7IQ3Zx/Vwvu1f/wIpYOpd6Bb+z3KdPFYzz51bcV4joCnLT4re3r7ou2TXJDuSwLgAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKoD1kWT; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKoD1kWT"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e512ee9so52388e0c.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593831; x=1790198631; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1u8Ca5fgKUmWBjGqjd9hE6KBvU5POGnuxsvv6rx3S+8=;
        b=QKoD1kWTL1JGo5TqsgM9wqf/NC2azWunMfh2ke4nKAvPgxlB2y9nEO+nyCx6Lp+1iq
         CM2dIiufiTHezMLx9l8weV/rQLQGHXoKUnaVLNUEF3LrXK8nnAz6M8wg+wBSi36vk//V
         3ZcSb9nFk9qND4ANucjlOjp/weqhEzPMOp0E6z+qe5NNdkB2oUOALvgaJKS+SCku+qQy
         WAAOOR0MAvnMHhMTAp2rwGa6J0h2EqRiwOa79yUriVtLdbIACvxLFI06t/5TO45A5IXD
         o6OgcXTExV3LaxcB+psCEDWE+c2p16PfgN0luhuPyPxSXqgXu5Qg4UCSSbytec21RbPz
         jPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593831; x=1790198631;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1u8Ca5fgKUmWBjGqjd9hE6KBvU5POGnuxsvv6rx3S+8=;
        b=M7A8HvaiB8zepXsJjumwUN3+HkDia5aLwZhGH/u2D7+NpuIR8uwnfVA2+jVgGcoT9b
         gqyZz8aJZzE4w6F/71SEFpdrDOXIgBRKkbc+tSSmDXaJCQeKvBCKASURGpTu+Zt3VuXe
         4CWBKAG8wXycJh/VmCMieKU+bxNvHQJsPvJLGn/dB+ncIJrER5eBpciMc5X2vc1csGCy
         pT0uCEmkwiW+m8BqOmLpngan0uNschaw2S/hIzSJgOWU5PZQsmj9v1MGRxdzoTq/rFnA
         5coC+ga1jVMCs/RZC0AUeFeJO2cclhvratz8Kx9LU2nYyJqHww7sniqzORmI7KZoeymx
         GB9g==
X-Gm-Message-State: AFuF++mGfFn9NW5LgLpVLrl0pw/3mRqFsDpOmmpl1MVw2/Ah7MnQ5OqC
	J/tpz3/Qrrhk3J/ojDbHhEDPfWmEYqkT1ClKrq/jlcTL/O02TIxSNSNy
X-Gm-Gg: AYBFou17AfuuGORlbZcqoowMmLNjMFf2aGZqjG/9BDXUpNsoS+kTotFTSb47WBWapXg
	zsEAk8izjXYNukQhxAFmehAfrT/7kzriqu/ZmlyYxYFRTCjuqPZ1Z9FlZ57CWHN9/GrQ3WP5nU8
	HzOCXCSXULuw0aSe9i0x///elFFa8LvvFiTVlJhvzWihuC4MqO5AH4B/YXXYOcFqlYmad3ZIjoA
	maR4UocIvy8SGSgpsDanrdWMTnxqmiKQzsjYYAK4TgqLjpLEC+Bv8BONJ1xjX5ebtrfljb4o18S
	Jzj0NMjH9LL+jx8SblUsZRCRhgIeQyUNuSZ/SmewG6HAk+EzaVaYVxhWKQI6vWJkZWkTY9B2Xac
	jYnOuB0Fd/brK6yTcCWGXkXkDtmWe6ClqLu21uReEpA5Q+gkFQSsQATX/QmQfNnSKwMVkXhORjC
	cZrTETfhh2ItS6TQiDJ3Vp5PrPpVdYpkDGSf2ebLaz2un/8dNLKiArAz0A1bjvhZVGkHqP33Hpz
	QfzIfqL
X-Received: by 2002:a05:6122:1d9e:b0:5ab:26f:49e3 with SMTP id 71dfb90a1353d-5c99abee033mr6427627e0c.3.1789593831650;
        Wed, 16 Sep 2026 14:23:51 -0700 (PDT)
Received: from [127.0.1.1] ([2804:187c:8477:2200:a81d:7882:284c:4fe6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9a51a05afsm1034934e0c.1.2026.09.16.14.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:23:51 -0700 (PDT)
From: Luis Vieira <luisflavieira@gmail.com>
Date: Wed, 16 Sep 2026 18:23:35 -0300
Subject: [PATCH bpf-next] libbpf: Validate ELF symbol table entry size
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-libbpf-elf-entsize-fix-v1-1-cf181da33eab@gmail.com>
X-B4-Tracking: v=1; b=H4sIANYIq2oC/yWMwQqDMBBEf0X23IUooqS/Unow6aTdIqlkY5GK/
 96ohzm8Gd6spEgCpWu1UsJXVD6xQH2pyL+G+ATLozA1pumMrTsexbkpMMaSmFV+4CALDybYtjX
 ore+pyFNCqY/jG+1CxJLpfi46uzd83n9p2/6Z/29rhAAAAA==
X-Change-ID: 20260916-libbpf-elf-entsize-fix-a0f9440e79c7
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luis Vieira <luisflavieira@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789593826; l=1101;
 i=luisflavieira@gmail.com; s=20260913; h=from:subject:message-id;
 bh=PYT4ZbnNOltTAH830UgE8QUvoV9QQVI65GzA4VvF004=;
 b=HCjD7qj/QfC2EQY4bMSCMJivgeTsusrUpRqbF10U9spVIYYPoYOF9IJeKtX+NcKGZyi3kTXnc
 okomQzXOmMwAtgkHlk+cM8ApvO8RYhNO55SRCk4x7wczLNd3re7rBEV
X-Developer-Key: i=luisflavieira@gmail.com; a=ed25519;
 pk=98MeC/NdrC6ah7zYpPnkWiQIoyj62iUP/rNuV3esCW4=

elf_sym_iter_new() calculates the number of symbols by dividing the
symbol table data size by sh_entsize. A malformed ELF file with a zero
sh_entsize causes a division by zero.

Reject symbol table sections with a zero entry size before calculating
the number of symbols.

Signed-off-by: Luis Vieira <luisflavieira@gmail.com>
---
 tools/lib/bpf/elf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index fe136d025967..ba0b3df37a59 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -118,6 +118,11 @@ static int elf_sym_iter_new(struct elf_sym_iter *iter,
 	if (!gelf_getshdr(scn, &sh))
 		return -EINVAL;
 
+	if (!sh.sh_entsize) {
+		pr_warn("elf: symbol table section has zero entry size in '%s'\n", binary_path);
+		return -EINVAL;
+	}
+
 	iter->strtabidx = sh.sh_link;
 	iter->syms = elf_getdata(scn, 0);
 	if (!iter->syms) {

---
base-commit: 10c4f610b215bf961235141161992f010cf7e451
change-id: 20260916-libbpf-elf-entsize-fix-a0f9440e79c7

Best regards,
--  
Luis Vieira <luisflavieira@gmail.com>

