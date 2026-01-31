Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6A2868B2
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769875723; cv=none; b=bGgjv5rTkhciXnW/emD7YWfO7ipY3gjkVoEgBYcBnDhO2hwQPUE5EP1G9RP8t8jCP1cPhG0EUsm3PAHCAyiEkfaPBSjHM87m/CTcKdv0yx2y14Cd3+6mDfV43MUn2eA2k87FFsEjo5xb3/nayuk7Ylgt26U/nq97RoEGKau1Vzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769875723; c=relaxed/simple;
	bh=L/R6boofzGk2DokCjpusrlAU2qY85ReI9H3XLSSd0uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hi0OibKQ2cq4RHqtj7zYjQQ+40rj3INMrClBghkfvGn/Hux/M2uITCcYEr55Ir3GDErIdns03SOu+rP5P2hrid39gvfqMzw3Z7koKzLEoyseWAArvOHtjAdHEjz58uYY2tZWlTVFUlMFrPmxZ+KF8jwQnR6a0fyNuclr4lUETW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDKQ5DtE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDKQ5DtE"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359228b7c6so2175067f8f.2
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769875720; x=1770480520; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5q7njN70fJiO/OYbhm0wtXtkw2yX7sP3fBk91qX8hM=;
        b=bDKQ5DtEi9YQzNMRK6A7gv5DwUf/nQ8ojGGKKHDE+445EyZ5Xlc6TIiCa+f6U6tpMe
         3/jVZwDqrc4MScoRCGry6+4WsCLhbawZWbUcRgOYgRQTILcNbMzzgn/2ci6mZkmHiqWy
         QccLb70QYGgB+06LMX4aBs5YoKeXtY8CwrwYxb0yro30CJA+I3qo6oLMNW4IRW5cGX/T
         6QXHKpdced0A8w1vyAIIje7sE4RYLtEtJ0quEjFeAiDKP+18eT+ZvTuR5Am5iQlfvp98
         SJ/SstIsRFxudOpna+AVVCqGqZV/Pssx9JusJmIkR6PUBuDnht23fS0mVeAueKbx1gES
         3nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769875720; x=1770480520;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5q7njN70fJiO/OYbhm0wtXtkw2yX7sP3fBk91qX8hM=;
        b=VwE2Ma03NP057lSH9Axcv+mYixoyC68vK3oRyzlMZxN/jIXhMym5og41aOmiSWgVM2
         WLMiv8ueBhlC//cYDeN9573oknKzaZ4nBKmI4ptLXY9IKjHVAcbxpwb5g4djECfcC3U0
         vx7NnjeCaZkAsS03YTr+48eK6MkeEIiRZm9zNr4w0KHmAppnM8IlQTVofFP9b/r4q6Sp
         wwpNmrRxjMPvyFiZzMJiX2557Xql6yI1GoGa8++29IECzWfelOMjFXg0YfShV5G7ILty
         fIktNS+K6rSLCbSewecj4fJN/OmL4ZhGjTivTVOOKr6jmbP1udVTimWcZxKKvmvzABZC
         UNfA==
X-Gm-Message-State: AOJu0Yz38VnjMvL7/TcnAK0C0RYal3R3CII2i2/azZzmcD+A/0TNxWOM
	3ZKNAU/MA7zQehYP7UlUDWT/bDf3a7wN8Mmt5TU8iVi58KW6AFcfPasUgf3lnA==
X-Gm-Gg: AZuq6aJoptA17MatSX230F2rMFML37DLOqKqn9YRvltdSzNljXMvRYNaqsMKVaV/Yas
	Bs+r27hnty3WOGop+Z4Q8hrbtbypvmVURqYGM0ft9qcwHxa6idW93t09np5SnebR2vy8FtRv0ni
	THbEVBZ4qu2as4YPnCjuU9qoZ1MpCLOWo60KusXPQ6KJUxey2l37L/UaBA9piQDKJqlaKjz4r4l
	eGtFdQF82CEOfb2wnw1OdXv0td8RmzbGAQ1BHUNHVD+xkPIuJ03VYcIw2bTGm/KunILWNay53AL
	C/oPJVrUHHjcwukejpK85Zd6/cbNPTHypbTs6bFwp6JAKtuDsryEjc3E8HLKu5lRt4z6fsujiwf
	pk3mRPUsmcEdoBIBi1fnrPbruNHsy6Od1him+a3qaUiYaQ4qYpKogj+IX+2G+6EjRQW0jRy8eNs
	QDy6CzkL+qBOSUy6cL2GYe1Qpqv+1HrHmdI2c9WEpQtxI3SxwV6P7MICVi/NoVdluwLiLy0vRbd
	5pV3VelBvGR+3ba5KtxNGpeF2HfxLARKeOOqb59mDBvCUb4LjpEGdzWGD/9+rLa7XNjIA/qRcXp
	u4nf3FdPiQ==
X-Received: by 2002:a05:6000:400e:b0:435:e3fe:7409 with SMTP id ffacd0b85a97d-435f3ab5239mr9591319f8f.44.1769875719883;
        Sat, 31 Jan 2026 08:08:39 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e008252ebe287038db7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8252:ebe2:8703:8db7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm29134550f8f.3.2026.01.31.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 08:08:38 -0800 (PST)
Date: Sat, 31 Jan 2026 17:08:37 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf 1/2] bpf: Fix bpf_xdp_store_bytes proto for read-only arg
Message-ID: <9fa3c9f72d806e82541071c4df88b8cba28ad6a9.1769875479.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While making some maps in Cilium read-only from the BPF side, we noticed
that the bpf_xdp_store_bytes proto is incorrect. In particular, the
verifier was throwing the following error:

  ; ret = ctx_store_bytes(ctx, l3_off + offsetof(struct iphdr, saddr),
                          &nat->address, 4, 0);
  635: (79) r1 = *(u64 *)(r10 -144)     ; R1=ctx() R10=fp0 fp-144=ctx()
  636: (b4) w2 = 26                     ; R2=26
  637: (b4) w4 = 4                      ; R4=4
  638: (b4) w5 = 0                      ; R5=0
  639: (85) call bpf_xdp_store_bytes#190
  write into map forbidden, value_size=6 off=0 size=4

nat comes from a BPF_F_RDONLY_PROG map, so R3 is a PTR_TO_MAP_VALUE.
The verifier checks the helper's memory access to R3 in
check_mem_size_reg, as it reaches ARG_CONST_SIZE argument. The third
argument has expected type ARG_PTR_TO_UNINIT_MEM, which includes the
MEM_WRITE flag. The verifier thus checks for a BPF_WRITE access on R3.
Given R3 points to a read-only map, the check fails.

Conversely, ARG_PTR_TO_UNINIT_MEM can also lead to the helper reading
from uninitialized memory.

This patch simply fixes the expected argument type to match that of
bpf_skb_store_bytes.

Fixes: 3f364222d032 ("net: xdp: introduce bpf_xdp_pointer utility routine")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 616e0520a0bb..a62e2d5fc436 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4135,7 +4135,7 @@ static const struct bpf_func_proto bpf_xdp_store_bytes_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE,
 };
 
-- 
2.43.0

