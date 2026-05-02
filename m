Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086538A702
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752455; cv=none; b=Y9cuPLFxqvfUupPO3b9YAcNZ7e4IUPGb8/N0eEDIicxJ8qb+PgAi4Jjdfjh4PrrFmCy0Cv+uPFF3RqVtQ+aIpcYTME2EvIYSYsjaCsMJGeLshZ/I/GTw/qnI1szSkzaVSFlj+lACCC5f1LRBu7cCjC2vVbUuIkOOtssujMDgh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752455; c=relaxed/simple;
	bh=fctOOu8ihanad4KwnadnhQVcL0yq7+8B+O+aK7WYNr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qw6b36gXHDLL6dQuYWOrr/8s5+KNJHDAkfYr5p/TCrEqHzvoJSzhwHALJT03WF6LCAOEyG5WvtR9RwMyRswjb2RDTozwZbVPvyV6kSi4xdS66OPQSPs36VHWV5sEoX2WITNUlw5oDB/mfgRlbp0KKF9LSQVf0q03Qi10SMkZw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L99LJwb7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L99LJwb7"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso4751034a12.1
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752451; x=1778357251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=L99LJwb7ghjZyJGAltcmlCigsj1usM68fDPWZpkd3mI5PpuZCKqf9rBZ8Ot0+3xfJV
         Klvb9dBriboTRcFfzlaxtebi/tbyn9sXgKRGvc6wg9rNngLXmfpyQk6y0IRu4Zv6jq0R
         jvoNHa8bgcdVdFNXXa8eYo5mLZYQCvyVeni/bLh3fAjtb0krx4HUyD4+o2pri/RJvgKT
         jefcTC8GiJluLmgVb05QPMPx1RbsFI1NeiQ29MIpVdabAU7D0uAIiYFfRothlyAytDEN
         4LqnnhfutO3FMlgsNRT2O7Yh2bdgt7pvlzWKk69MPkmyO7PCta7AwddDexDRs16bGoYB
         0Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752451; x=1778357251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=q/SzyfLNF1bpsOyVt9x1jCh7p/VVdrQc0tadNmIybJnOJpxkjYV3bQrvNpW4vZevwH
         xaguxoMg7ARaIurP7hIjA+4s2XR5UB2rshe+vwXSWisiPWuaryxaKsX7O+mmwUkKOaqA
         UcGXPwHw02ZpVM2ep1jfDugfdvnkKubiLMqAdoKqR9d+AmWkIuWEt/bOc1k2LRpLLVqc
         93TxcVgUN6nTwwjvfMUuHcFLILV896+zxDU4cqVRF+CfMscEbgHnh8TFNH2UmOhP/HR2
         hle87QZAczRvZDg3IDsi8djd5K6HD+BGF+HuHLlFarDfSq4eF9rxAiWpr7/ncMicdvly
         0kZw==
X-Gm-Message-State: AOJu0YzcahbDZWQ3cQ/iCzSJISb2nyL4rHi33mmWcXKW1Ox3Mwen8etl
	BlayA4GzLeG/7+2O7fKpsk307Cf7jDIv5/uYThIpguc9nEh+hgoEQBF/
X-Gm-Gg: AeBDieu0FFfGOxxV8uNMuoYbAx0j8fuEUfzCu942vgLRXvJrPBA+GhJGK6QpwqgsKXP
	g4MdkSWmXv1gE8duwKXOyxviRZkSCM2hD7H8O7EsTipiHy1I+01/UxIophMaSv9jNfdfAIELXkL
	rjYWPFCoBUNVCm+fPNj/YyahQXMj7XppZ63EYSbrFqxGbKS1Hb7cTCpJ1A+F+pF4fmWEhyKvdZE
	UN9wkC1385kiWUO5S8yXcOP4m8pdHSKCTCwqQd8FpAGQ7a3gBCRyoVm9S/zLJXd5fLTcBxO15n1
	oHyE3qoQ/5bz46Q4Fk5Bo8MBLZ/1GcI3ER1aFCaxJO1XwuRoxqtL2jT0Ven+aaRIgD76BobClVZ
	D9ufjseuCsIB1v0IpkdU7QZMx0qb48yonb39EgcKSaZlzKIKVzJFA6s7TVZGN154Y/S4/MZEuOQ
	hUJr7UjBrOn6C47wazkwhxZmpMXoLRBIVarmOR9ehFwEJx6BPKlsBS5G4oKCzhIqRSOj809rBSa
	5Y/J9v/rAtwS6QZ2QzaV06BqbJh
X-Received: by 2002:a05:6402:158d:b0:678:f8f4:a7f3 with SMTP id 4fb4d7f45d1cf-67c1620cccemr1505390a12.0.1777752451354;
        Sat, 02 May 2026 13:07:31 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:30 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5 1/8] xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
Date: Sat,  2 May 2026 23:07:15 +0300
Message-Id: <20260502200722.53960-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

skb_checksum_help() is a common helper that writes the folded
16-bit checksum back via skb->data + csum_start + csum_offset,
i.e. it relies on the skb's linear head and fails (with WARN_ONCE
and -EINVAL) when skb_headlen() is 0.

AF_XDP generic xmit takes two very different paths depending on the
netdev. Drivers that advertise IFF_TX_SKB_NO_LINEAR (e.g. virtio_net)
skip the "copy payload into a linear head" step on purpose as a
performance optimisation: xsk_build_skb_zerocopy() only attaches UMEM
pages as frags and never calls skb_put(), so skb_headlen() stays 0
for the whole skb. For these skbs there is simply no linear area for
skb_checksum_help() to write the csum into - the sw-csum fallback is
structurally inapplicable.

The patch tries to catch this and reject the combination with error at
setup time. Rejecting at bind() converts this silent per-packet failure
into a synchronous, actionable -EOPNOTSUPP at setup time. HW csum and
launch_time metadata on IFF_TX_SKB_NO_LINEAR drivers are unaffected
because they do not call skb_checksum_help().

Without the patch, every descriptor carrying 'XDP_TX_METADATA |
XDP_TXMD_FLAGS_CHECKSUM' produces:
1) a WARN_ONCE "offset (N) >= skb_headlen() (0)" from skb_checksum_help(),
2) sendmsg() returning -EINVAL without consuming the descriptor
   (invalid_descs is not incremented),
3) a wedged TX ring: __xsk_generic_xmit() does not advance the
    consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
    the same descriptor and re-hits the same WARN until the socket
    is closed.

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/#t
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_buff_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 37b7a68b89b3..c2521b6547e3 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -169,6 +169,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (force_zc && force_copy)
 		return -EINVAL;
 
+	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
+		return -EOPNOTSUPP;
+
 	if (xsk_get_pool_from_qid(netdev, queue_id))
 		return -EBUSY;
 
-- 
2.41.3

