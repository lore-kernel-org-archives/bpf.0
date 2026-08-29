Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D043F1ADA
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788032603; cv=none; b=ZEhM1fUljgfBV4Wcm4hhK76q18AQGdXa3li3LlOJ8tcyUsRwKrYN8ncHhf9xCSls1T9Of5LHM3teygCusFlchm48rXOG9itrBLcsHRJZnomI7f38se4IfIw1MoYPBEB6a06Yq5J+nn3uRxiT0VMUs1aFmHuWRb8e33nsl72FoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788032603; c=relaxed/simple;
	bh=IFvVvmjX2mZpey30mo30J5RQZMA0IA52T4KOH0GMTvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R2pTzFOKOsIreJcNbxVL0iFy4sdHZacigw6y5QR3gTAq2elmtTc0QPe7zOELtYUaU3Od6otnPimRQ4Im7O5ehYQJYv679aZmySRe21rO9WPLIF+jPTfWYUFXyJdcw2KMAs2QG0sMr52rRXZzNHVe+u3RzccTtNptdD+KhGu7bV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCeFa6be; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCeFa6be"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48431648f33so367900f8f.0
        for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788032598; x=1788637398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AVYKdNB/XEBKGA3j23bRZsJH20yuQZjaM4yMJs/fEPM=;
        b=ZCeFa6beg/pxKRD9RvraxbPWpph8Qb2jACVMOSZ9j5z2rFkXzaF/fxGJ1UZ8f2QRTe
         6P0RH2xUKdT2lhH8PNwfSAL+J7py4lKIZJwP1Palu/DH2VLr0xMdeN7CiY38K22KCysx
         Dhn8U/NXRIehLk1Zs3HmcyPHduutd0jyPWl5/rrWW2Qxo3CF0IdClrdCnIFHH3OTcvxh
         znRA51Ge6LZ5BfURBPUT6h4KwbttfpT5BQfU5Ty7hGnOHpWlwKiu/E6rlqtW5VB93lC1
         M1QA03GyNRE4yvAzL+oeZzOVlyd94Tk7CaP5ECOkq5qB0oA1ohc8GpfS4uQRXHg5rGfS
         1Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788032598; x=1788637398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVYKdNB/XEBKGA3j23bRZsJH20yuQZjaM4yMJs/fEPM=;
        b=Nxbymq6Hsj6ImcKOwcpmxgc3nlfnINFrxNZG6Vd84ctu2LbWoAp4W+cXn/wn7g5QtJ
         V4RNwCGpYWCKtDd7cbwsZvBX+qu+fuMTsvnkF38qWBKkwLSrQbiVLnqrnziGpqQh6oNy
         ampun1Zthaq1oaXOMFZXflIK2oLIW6PQOIJvjOZYZp7KhE/lPqUgvw9TzVZodgSj5bRJ
         v/Xh+ns+jYY1j1rfLG6ZE1Vqx2z0i3APdkmZK98LCkXNVVbmUlT1tRosLdWj411X/esL
         H8ZI6kigd8paJXuXYQNxZxzTVeA/bdxhA5J8o3BpM6deMjSHMkV+8BJcDxmjb5HquCGB
         qO7A==
X-Forwarded-Encrypted: i=1; AKwUvBzq7QT0e1AYTcPeaYBvrCOebF6a4clzAUaLn4Cc5tJBTnmEolML/nwkpkvJmNdOFE7Pgb8=@vger.kernel.org
X-Gm-Message-State: AFuF++nmubLX3LSfSPoCuhTwQzZIUO8SkJGS5IHnNFS0vcxRolBUKq6E
	TKrGRLPPFOgI4oDzRqDd1Ka5oSZZVFASkoLmN1peBHpe8kHo/qm5Yv4K
X-Gm-Gg: AYBFou0xpj7wjbo8bZ040eApqgqt61RU5aLaarYXSRgxPPTXxngpeh4+zaQrdsSOuOj
	K/V3HLlyXd+hP4iaRylMz1Ah73E98sjKtdYC6cBQmTxeUUC/Zc6n9f7mtun7Tj8S5nrlLqZlD5K
	4DkkexsMaOtg2CaB1kKCNq0CgPiCsJ47SKhB/bJqRMvvcZLst3rp31w9KMMF4moqTg+MH0Ypb25
	R2sPFbsMk9uSrc03ZWbdK4wD8a1Z2AaKa4tilVSCdbosAXqBejg9mMskoGOqWmnCXNMuDWjE4X4
	wrtF3jG8rCZ6tGrPbGGtcISczJiDuIQtCBtMXQSne6icudQEYxVhYW8eXOYnv1gf8UNPviv4bui
	V6/OJTgmHE24nRvvWe1gguBw+z7VcHmlGrZysNDtVkiPFq4o0NGGsy8dHT8XRHQ1AwVbRsjb/oy
	rMkj03CRbzQ2cVykYyHqmieQnSPM/tuQXd51kJxG70Q7K6fXCSx1J/6LZ9iBm7Y28wuHawK8M4Y
	+5dpiqtdYgIHqkE2vx6VC2eELbMagg0I2Yt6CdQpQeD5IvL6yrr0urlJrv+OB1liWUrIdjrTVL+
	0cCz95V0bwsPXPLK33HfYu26erOUsLvyw/NGIw/6OCVzVjoiIS3nwlCVAPw9HAovQus=
X-Received: by 2002:a05:6000:2583:b0:484:361a:1c7b with SMTP id ffacd0b85a97d-484361a20b2mr2894856f8f.7.1788032597670;
        Sat, 29 Aug 2026 12:43:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae86-1b01-80e2-8851-4221-68d8.310.pool.telefonica.de. [2a02:3100:ae86:1b01:80e2:8851:4221:68d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843310ab41sm4441984f8f.7.2026.08.29.12.43.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 12:43:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] crypto: lskcipher - preserve state across unaligned chunks
Date: Sat, 29 Aug 2026 21:43:14 +0200
Message-Id: <20260829194314.42685-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

crypto_lskcipher_crypt_unaligned() splits a request into page-sized
chunks but never sets CRYPTO_LSKCIPHER_FLAG_CONT, so a stateful algorithm
restarts from its keyed state at every page boundary. It also marks every
chunk CRYPTO_LSKCIPHER_FLAG_FINAL, which is wrong but harmless: chunks are
trimmed to a multiple of the chunk size, so the trailing partial block that
FINAL guards against is caught after the loop instead.

ARC4 is the only lskcipher with internal state, and cbc, the other
in-tree user of the direct API, never passes more than one block, so
this went unnoticed. bpf_crypto_crypt() however hands
__bpf_dynptr_data() to crypto_lskcipher_encrypt() unchecked, leaving
both alignment and length to the BPF program. An 8192-byte ARC4 request
offset by one byte comes back with its second page identical to its
first: the keystream is reused.

Set FINAL only on the last chunk and CONT after the first, mirroring the
progression used by crypto_lskcipher_crypt_sg().

Fixes: 0ae4dcc1ebf6 ("crypto: skcipher - Add internal state support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Reproduced on a Raspberry Pi 400 (Cortex-A72) with a BPF program that
creates a "skcipher"/"arc4" context, takes a dynptr over an 8192-byte map
value, offsets it by one with bpf_dynptr_adjust() and calls
bpf_crypto_encrypt(). Unpatched, the second page of the output equals the
first; patched, it matches an aligned run exactly, final state included.

Rebuilding that needs two programs: bpf_crypto_ctx_create() is KF_SLEEPABLE
and only available to BPF_PROG_TYPE_SYSCALL, bpf_crypto_encrypt() only to
SCHED_CLS/SCHED_ACT/XDP, so the context passes between them as a kptr.

With CONFIG_CRYPTO_ARC4=m, load arc4 first: arc4.ko advertises only the
legacy "ecb(arc4)" alias, so a cold create with algo "arc4" fails with
-EOPNOTSUPP before reaching this path. CONFIG_CRYPTO_ARC4=y also works.

ecb(aes), cbc(aes) and cbc(camellia) were checked the same way before and
after at several lengths and misalignments and are unchanged; with generic
ciphers they have alignmask 0 and never enter the helper.

The helper is not dead code, in case removing it looks tempting: ecb() and
cbc() inherit the wrapped cipher's alignmask (crypto/ecb.c), and geode-aes,
padlock-aes and sparc64 camellia still declare one, so those instances use
it today. They are all stateless, hence unaffected by the flag handling.

Not an unprivileged surface: the crypto kfuncs need CAP_BPF, and
bpf_crypto_encrypt() additionally CAP_NET_ADMIN.

 crypto/lskcipher.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/crypto/lskcipher.c b/crypto/lskcipher.c
index a8b07594005db..6c30436a11354 100644
--- a/crypto/lskcipher.c
+++ b/crypto/lskcipher.c
@@ -75,6 +75,7 @@ static int crypto_lskcipher_crypt_unaligned(
 	unsigned ivsize = crypto_lskcipher_ivsize(tfm);
 	unsigned bs = crypto_lskcipher_blocksize(tfm);
 	unsigned cs = crypto_lskcipher_chunksize(tfm);
+	u32 flags = 0;
 	int err;
 	u8 *tiv;
 	u8 *p;
@@ -98,13 +99,16 @@ static int crypto_lskcipher_crypt_unaligned(
 
 		if (chunk > cs)
 			chunk &= ~(cs - 1);
+		if (chunk == len)
+			flags |= CRYPTO_LSKCIPHER_FLAG_FINAL;
 
 		memcpy(p, src, chunk);
-		err = crypt(tfm, p, p, chunk, tiv, CRYPTO_LSKCIPHER_FLAG_FINAL);
+		err = crypt(tfm, p, p, chunk, tiv, flags);
 		if (err)
 			goto out;
 
 		memcpy(dst, p, chunk);
+		flags |= CRYPTO_LSKCIPHER_FLAG_CONT;
 		src += chunk;
 		dst += chunk;
 		len -= chunk;

base-commit: cf72cbb39da84b6f02f90c07f33b102fc10b16f0
-- 
2.53.0
