Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057925;
	b=kdXmFpIaAT9Y3fE2y8fHWVxSQdoZNy7RLdCQfjrvBd6ODBxWQCz1ojMTdtX+qr43P2bU
	 Oect5JastdopB7UmjlEYUbNYt5uPAgrdkvUab886a38oH6UlB2Rh19GpTzo9PSHSHRitc
	 1v7woj1R+w5LYp8uSyyoSN08IihmrslUGB5eLg90CcawljnfRNiQlxy8xcn5Pe0X/c8mx
	 bdJ3nrx5gF0R/NB3GS0g7doPAKbHjnM78pmShimdqm37UWka1us5c/XcVofyVd1U4m0/6
	 VOPe64YIgSNWZxHDnQls5vaWeV14zSoUc6ZgT5s3mcOJUbYbgezr/ZoiNXyqog0dyoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=lWfEYVoOc1lZWzlQwPsg7ypTWatS1Y1EsaEwfv5LcyA=;
	b=kpv/3nvJbGNRchrNmgSqdb2lWX9cGOAKSfhc3cFpwkWFzDTUo/2C9LsQxMMLW39YrBzM
	 GWYmI8oWtuih4fPtHmWKlDojz3yskWKnp+O/WTMYUJ4mC06X83lCfE7ZKw4CVG26DsO1D
	 yQKPV21bK8ubS5ztCskAA6KIMENM9J8RnXRr+mmKy1nA6dixhRwf0Qq/xBhLFaxzAK0px
	 aaPUIZiahQXnVdcoEjaZI9ND+sqQQVpuwNpmEqIU6Ro7tfjFsLOUVUG1zKJQhASOgQAJR
	 hRhUOcWIgROCnJsQs+CigVcNgbOYS2rLTxhvMsNiVdB0a1am7MwlKedmL3jPuZMKZVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5m7x05X;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C635606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C635606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5m7x05X
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1896071a91.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057924; x=1793662724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lWfEYVoOc1lZWzlQwPsg7ypTWatS1Y1EsaEwfv5LcyA=;
        b=K5m7x05XO3kn/r9PVz/OfFT8Nm88wNoFbw/KlAND0oQ3MU8O2Shdh0m9C48g5pn5bK
         xX7ofx7wd0lAP5gwbDyyZN4NUu/fQWw2ihPiUjAhxn9WuDdVWIzGgMAdjV87bV/UOR2E
         82AwyS96ybXb9hAr7hQDeDE7kk7rsJqueLeSz4bQxEk5rEVvMsBb6jsfOFMZeMRLeMWl
         zoBy9ORzW/pqoJWMaclLiLFOX6q/20UwZUU4meJzJbvbB387AYIrLU3UEi1AaHuSwUQS
         K66Y8t0AxtqylznsJa84PB47q56IAtiU3bzSfVHwfaYdoeW52zUOD+px4r0qce4nGoDM
         2abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057924; x=1793662724;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWfEYVoOc1lZWzlQwPsg7ypTWatS1Y1EsaEwfv5LcyA=;
        b=yemAtB5vWJU3OesWkU6qE+aY70YyXUMD3U1WhaUCSFTc4gfU1LOTi5OGFJq8mLz1LN
         U3ln2i8A69T96dSqAk4IicSWZ1QvFGuZWVzieiY5SF01mBW0qXAw/FZleCzK3ZOAButa
         R+QhwqJAPkSM05SN9SG3A7c9IIubKUJh5feC9viB2WWwH59A1lTPKdwT9xRY5QmCd8X8
         vXnM/MIBZq1UVaizywyfb4qRUo2qN4fYCuqtyVaKkMk4QQavm/OkkY3tDlkGjYVUpb9M
         a0UGiN1H65xET28I0QIeI+1wUqoh+TiZayabO9nyMrcvF1gGmpsHBNBDc0+JMAqwJZ4G
         q0oA==
X-Gm-Message-State: AFq9FYLHiQXncEk1vcBlZJW8DARyogkWh/tgpy6MsYDIXTnTjXPNb7qH
	K4r2E2EOw8kEFaMn2hbQIjwMMNyKk51qIBTQm8w3BC8Kp/kHi9arfcRO2zHRXA==
X-Gm-Gg: AYBFou12CnznXrZg4Jp2gUmm4GTAaXcMP+aCEsKj05q+yvz0JVuit6Z28cY9+Y29Le1
	m94iN8dw6yjycAl6lMbcdW3oIG4VLXQuOHs/WZ5WmqkrEfTHT3isUmEDYJRk26hfOXYYYu2Pv/y
	SxrXMJhraF/dIs/fq8KInSTDKtBxXuOGBhDW1V3MgE+CsIyAtiyb3r+nM2usbCq0RiQyn6PDcap
	7oiwhsWm3EZ1Vpko5eHcwUhDarlgHQXqKZIGaytnrsAVG0Fpmt+oh+lfkyRTRtXEoHFiPfMWdDz
	NwcfKBVFrPl2iYsVNJrXKQymvL5ZCPJ0laHaYoLrlcZU9dMZXVAmxYMLi1s6aEmVMGRjg8uTJd3
	sJ/23BQGIB3zgoRTXF+JYjHUJOTY5Br0mc8j+QBZTlX3Grj/UmRnpp49HI9HMr1G70Zw5BnKn8z
	rkz+w551PpoAqLFU55vuuKdoyejnsYThpgWU+kYLZbOTYtSwIimbI0v4Ze6zr0JkgbQHUeOy9CT
	ilOLgok0eb/zGisDWZdmomVlyI2qMTWoDoODv16fWaAymVrPPTyPFT31SHQdPhsjAvRmhjWD/Aj
	3WW/pG32UiYXjOq0TfDbA/vs
X-Received: by 2002:a17:90b:1812:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3adeafcd3damr6573545a91.66.1793057924396;
        Mon, 26 Oct 2026 16:38:44 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 04/11] bpf: check the iteration count before the predicted exit value
Date: Mon, 26 Oct 2026 16:38:24 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-4-f373aec9825f@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
References: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The comment before `total_change` computation:

    /*
     * compute_backedge_taken_count() guarantees that 'total_change'
     * does not overflow in 64-bit domain.
     */
    total_change = initial + step * backedge_taken_count;

Is not true before the check:

    if (backedge_taken_count >= U32_MAX - 1)
        return false;

Move the check before `total_change` computation in order to reconcile
the code with comments. Old position is not a bug the check was
performed either way.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/scev.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index d67e793d7a18..e3c2220f89c9 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2307,11 +2307,15 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	if (!compute_backedge_taken_count(op, initial, step, bound, &backedge_taken_count))
 		return false;
 
+	/*
+	 * max_header_count is u32 and U32_MAX means "infinite",
+	 * check to avoid overflow below.
+	 */
+	if (backedge_taken_count >= U32_MAX - 1)
+		return false;
+
 	if (latch->zext32 || latch->jmp32) {
-		/*
-		 * compute_backedge_taken_count() guarantees that 'total_change'
-		 * does not overflow in 64-bit domain.
-		 */
+		/* total_change is guaranteed not to overflow at this point */
 		total_change = initial + step * backedge_taken_count;
 		if (latch->jmp32 && is_signed_op(op)) {
 			if ((s64)total_change < S32_MIN || (s64)total_change > S32_MAX)
@@ -2322,13 +2326,6 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		}
 	}
 
-	/*
-	 * max_header_count is u32 and U32_MAX means "infinite",
-	 * check to avoid overflow below.
-	 */
-	if (backedge_taken_count >= U32_MAX - 1)
-		return false;
-
 	/* The header executes once on entry and once for each taken backedge, hence +1. */
 	iters->max_header_count = backedge_taken_count + 1;
 	/*

-- 
2.56.0
