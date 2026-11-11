Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379478;
	b=ZXG9WqUMBOXGJeOz90XM3DegnxDUKOR1UPdI8vPoD7i5L0zdZUAf4rcmnshL8ASU01s2
	 //nIIhmIbtnzyS42MDWaAbYAudR/xaqS7VXoH5nemiiVZljE1BeyM4+1OngyVfTW9q/j+
	 v8vb/3KMfIiLqWOgEPxoGH412sKcMToioZVXqlTcrXbiy/ygJ5xDr9+upf+cviEwjHO34
	 V2GafGA6yefl3vv480RkPbs/ZHoKH9SN/foJPaTm/Jm8D/8ohFFXv5/rKofM2fmXfhdGr
	 YCfxowuxtiQCksJ5516pIxZwJrtSR1pTC1vRRrZ3DtLBbyW2Cu5cT9kmRJ007gBajDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Zbz8v729/ehKnALp9fFMbSuAgX1DQTsUrRLHLCcKqTM=;
	b=H5WDUMXdgm7mNebU5YXAJvU15wam/Fdibrw2vfoQ7hOF0/PRiz3WOtXKay5kDMkO3J4f
	 MgAsoyQObvMEXDB1pp5hLeARxWQ9rfVKY5RWEoS+tqLwSv2Hyt/xJLAIktH8jdxv7HWro
	 VWs00Ofw6bvoYdi7HXn9swMEzoGcvLhzrwYQGFbO7ZxJp4MUJppr/BDfFzImiDQWBCRth
	 xorygDRFJqVcYHeUe71xEd09+Fdk+X6vwyUauHnuQnoWXAlM2trpmlTgY3R+KU+9smCvB
	 1zfMIsWeQ6ZdsWrHPNI7E290F8cZsSmmorE+CND94P/WlFPoMIXTHfTfg2Ez5FUfk7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eC+S7B6c;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C4606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 06:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66C4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eC+S7B6c
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so4414873eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 22:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794379477; x=1794984277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zbz8v729/ehKnALp9fFMbSuAgX1DQTsUrRLHLCcKqTM=;
        b=eC+S7B6cbqVbU60GWawrGHzooUCvxhlnp2yIxpJb42cM31he3S+6z4V7oSHYzicuM3
         SLJoODT8s8lH6OcN33+pakpiY2nmCJABcU0pSB9V6k2nNYa7FQrxi6TXTY3XhhVg17rO
         DOTY6ZIhfbuwJ3NbWONti1jtBa6UI+gYRZT6rd/M0HqYz1jactkWQjgSShFl7awr+eod
         bgI/WfgGUAv7LdOQP35+6oe1ABCr0lAD+5yJ6FuHIFdTihNH0lkfCrbNnR17e0unqH/e
         bRTGwJFTr5pfS70oVlgSBxpjoThYrohMU1XMBbgCLtAt/aqT9VDLLH1pSNeHI/v4z+pH
         Y7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379477; x=1794984277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zbz8v729/ehKnALp9fFMbSuAgX1DQTsUrRLHLCcKqTM=;
        b=r470hEkz0h88lCH5AOJ2OjOru6k+V6j2joKhXJutmZ0RK0s+zeMX9FrbHKrUcnpS88
         RX2wo7Ef7a7GaqkkTEjozPaxiYmL8f3C/B0rPbu22P8kavU8oJ4LDek/FkPRwi0PvtSn
         bvHVcGnbe0vtqK5j+tcFqW/nMSQvPlltI48vkIMkibdvfoeivgX3iq6+J1QjibCLcj5K
         Bwtp8Wu41nVzdn8r4NqkTRGyuwt6Km2b59p/4oQaabgeMJZyyr5BfINgvdswiLmxWb2w
         uTB0DPiCTdo9G+b6RZQ0B1fJp7HNUUavDlbdDjhmoZNWylUPWk8+c4yWWZMBUFg4w6fx
         /+jw==
X-Gm-Message-State: APuU4Z9jiyHWsqHEJwXGK+69F76Di8Gn8u64KMQyZOtBJ0JAr3kw7kjr
	VP77jBz1madiCi7sRFxjfN6Gus1F+Z0dMB54L15lkNvqvdrouRbqQP/z+eoVADew
X-Gm-Gg: AYBFou1UoW3gkgKmnmPyUQRr6XlhgcTDCcNL9AiMtoks/cOgDe6jTMwiHV42XLcbhMw
	0zKcQlTXWlavk2HUbjATPWHmJKPH6exhJg2cJ2MUAk20K5vSH8KRt+OXSmxxlkjV62UHATl2BUH
	7gGnj5jfhEdM+pgodbAGqY3Lzz+hJP3/vPgXiTvS4UAUm8FD4OZ5ZjnjWeUcW1soaLjjM1VX97B
	+TNyRMwvBLYYVpfe+mqk4/qBdXP/G7LivOnjYybNa32dQFdm4rucnMUSoQ2yfoWlndKMaQNnJgE
	OXJhiF9HIN6w8Mln7KkU4zeo08/gSozcFLuapOG0G1v2AnJRhCL6KoXhs9q0IP0fCGI7a2LrT7G
	QSsSyvBi+iR6ppC6jPtwDIgyUtdNq655UiD2YWAzzGzsWIajKEllxp/NPi5YM54LldVOuClQKD+
	Lhgq6/QYqJIIyY3+ewgWYqSl9qY7zQ1ZyE2evu3iObd08sX3uT4KRTcl7gBt+W3oHGxXLcz7eU2
	RtgulfWYQvlcfpocoUFJY8xVFTLRM3e3AOwkXx01TIYUVxtbQAR3Ar5eu+rN+6Pn/piD0jf1zwm
	uKQia1cZNFQ05a8yPCyvD9JocdxjW9/G2QOt2L30/phU4pIz5QRU
X-Received: by 2002:a05:693c:42c2:b0:36d:d7ec:5e3d with SMTP id 5a478bee46e88-37686174912mr2157258eec.21.1794379476693;
        Tue, 10 Nov 2026 22:44:36 -0800 (PST)
Received: from DESKTOP-31QBR7C ([103.120.166.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm14333994eec.17.2026.11.10.22.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:44:36 -0800 (PST)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH bpf] libbpf: Fix incorrect module BTF fd index in warning
Date: Wed, 11 Nov 2026 12:44:27 +0600
Message-ID: <20261111064428.1902-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
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

When the number of used module BTF slots in fd_array reaches INT16_MAX,
resolving an extern func ksym fails with -E2BIG. However, the warning
message logs mod_btf->fd_array_idx, which is guaranteed to be 0 at this
point because it has not yet been assigned from obj->fd_array_used.

Use obj->fd_array_used with the %zu format specifier instead so that the
actual overflowing index is logged.

Fixes: 9dbe6015636c ("libbpf: Support kernel module function calls")
Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0e2a93a42908..d71e8ca199bc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9553,8 +9553,8 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 	if (mod_btf && !mod_btf->fd_array_idx) {
 		/* insn->off is s16 */
 		if (obj->fd_array_used == INT16_MAX) {
-			pr_warn("extern (func ksym) '%s': module BTF fd index %d too big to fit in bpf_insn offset\n",
-				ext->name, mod_btf->fd_array_idx);
+			pr_warn("extern (func ksym) '%s': module BTF fd index %zu too big to fit in bpf_insn offset\n",
+				ext->name, obj->fd_array_used);
 			return -E2BIG;
 		}
 		/* Cannot use index 0 for module BTF fd */
-- 
2.55.0.windows.3

