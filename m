Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507C3EBF02
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394588; cv=none; b=B8oOj+aEIgiN7V1bMQ7ooDJyvLGeV5KN1FzKHnCG2/m05jCeQ7XupF06WF//qNjOydXgrgxCHBJEN47V2LJPSske8YFHcm93qUR24TaLriuv5MZCxS40wUhIN+yawQtwrCUR85Y6xN0x47fuAiF5JeKpem8auQpklnxYJYVRL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394588; c=relaxed/simple;
	bh=cSmudJHbwRb7ftKNmXOyT01jlhInPfXyvTA0bqzaBtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hpjyzpwfs1wt3mEcK0usG0Ggmvh9YdBKb+vwnvsP7+nEY/a8DIzYrCVMGpx5gRh8ivCKkt9QsJRWgoVm8/VXUeysE6o+eMygnBMoIrA8qJXNl7/0eJmj9VG14NI1YNt1cpYoqVbQd0HcDoeejcjAHuSYyB9LeYIVb0EXBS9Cdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=LdL0/r4+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="LdL0/r4+"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e6f83f0bbso165451985a.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394584; x=1791999384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qkXLYOq6wxEnThc2GKl43lmdMZEROVt8Vlb6zLp/IGQ=;
        b=LdL0/r4+wMedua5xL2f5yDvgKyXVGypHS2LfNZIxvzlnhZ+LM5Ptq2Rx/Uf2STTcVE
         QxzuG62JNFRqJtvFiaSSBellesuPMpSocff5LOkNLhof7+EFmqb7DGdn5OHytpIF+F4d
         oThe9HtQ9Ussvg6te+7a7IEPL3CZBxR16t9/q9HAHEw0ywuegzTqFYn/hYgELw1BY6ms
         sZkHdAhvhNL53x0yhMTUTuLINzHCxOF3ZE5NqFo67d6OjTLZhnwLN/h4MbOMb0kLYmUD
         xZuhjUQTkM3OvqvuVcocn2z5Qd08LVfbxAUwjzf18v0GAPafEW1Ht+6w9UYIQrv2XmKM
         Bv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394584; x=1791999384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkXLYOq6wxEnThc2GKl43lmdMZEROVt8Vlb6zLp/IGQ=;
        b=X76/sGIVYC83tesvVn5TmZyxHuEUUquFwS7kxkVWxnkjcW3DcP5vYvgom/Y0tohvSp
         vWWxnVKhx8VugqGY+OrV1OGK0MbKRuuSh7kWlY7+33ESrVVBVLgQMgig89bSfwy5UB+z
         qAwIG/UO1cEZJGBM61bm66tGaj/+S7gfjxcYIqd2Ty4SMUpQbIMj6Rg1ScaDmmoFuIgB
         IW53nHGem1O2jwXHrubvfjE2rrGJljD+UnQbUzdZboh15Qsc7UqITsGhvX5pQq66jP7J
         KCQLScQF86somSziXMY0S2LiatSZOAQNGq68V+39UKL0BDF3dfJrcySipyQAnSovSEqc
         MNWw==
X-Forwarded-Encrypted: i=1; AKwUvBwtmE5G478/bGe27K2fk/gqhWlkQ1XFrqj7PHrvAvmt7bIr6noF3YIBBRJyIKBom1WE/EY=@vger.kernel.org
X-Gm-Message-State: AFuF++kiorOvoGB+m3DdoOZimvyg+gySTTftoDOAMPUNjbEPyCyQKFiT
	T0PZQUEMebqqk10jOmvRfr7xJaNQGkU/v9qFOO2F/4BiA6OmzSjm+BzvzPPkcoDYR88=
X-Gm-Gg: AYBFou1ui8v/bchQAW83apJZEIzFt3d1XmHvBzsQaGcA79z1oCxX8/5JIYMnqNFLPTg
	EB//dA8ixVMd99RDkkGXAVMdXQHUylpKbuKAiasS8TLoovhFezkcFKhtN4VqpvB7WLDuoEe49yv
	JbtNy0Fu47ZT4zA1ZefL442JUQhO5In8E7N4u92qLUno6GXziGc4jSDjRWij91KLupCmebYfNHi
	OJ4cyajmqc+yH4ImsClqkv0Ur6Eaf6HWiziCB0IuMATECkPEPEdiyI/EGYKDiGKwARwAyYlOvzc
	yMyz8i5XS/PRykSzuzIQdlIefwDsW+ZYbY8Bl8bM9kdYU1L0fbgIiIXamFd0iek6gV8dSnH7FLf
	nvUpnOGqNGshIYF3FUcVSdy/HbOCsvSTpSYFcjAcuBZz05m0zxIxD/vKQEESbQD7RDDGPYdw6zi
	yLiQ8uG5IJOvG1GVQxY9PGdt4W7RdXAhJHH5UftDtdTz/ENtw7zs1zr//j/LXiFtlipwJdU3woF
	96dpv1mDY+8vgaZ0F56hnjHug==
X-Received: by 2002:a05:620a:46a0:b0:93e:5016:e3a6 with SMTP id af79cd13be357-93e9b71c5b3mr603215685a.26.1791394583188;
        Wed, 07 Oct 2026 10:36:23 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991a5b12sm269963185a.32.2026.10.07.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:04 +0000
Subject: [PATCH net-next v2 5/8] net: skbuff: don't BUG() on a bad
 csum_start in skb_copy_and_csum_dev()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-5-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=2105;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cSmudJHbwRb7ftKNmXOyT01jlhInPfXyvTA0bqzaBtI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBpiN2WNeEIoX+g7s52V4F2BSYScskxIKcuTqYzjcLkjR7WDGGCfC3rjhpSFWB2PS/aejdpTZtl
 1F9LMUs4JNQE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_copy_and_csum_dev() copies everything up to the checksum start out
of the linear area, and BUG()s if the checksum start is past the end of
the linear area.  It misses the other direction: a CHECKSUM_PARTIAL skb
that has been pulled past its csum_start gives a negative offset, which
gets past the check and becomes a ~4GB copy.  It also trusts
csum_offset when it stores the folded checksum.  So far
skb_copy_and_csum_bits() BUG()ing on a short skb has covered for that,
but once it returns instead, a bad csum_offset would write past the end
of the caller's buffer.

The function returns void and its callers are drivers copying a frame
into a bounce buffer just before handing it to the hardware.  There's
nothing for them to back out of, so check both ends of csum_start and
that the checksum field fits in the frame, and if not, copy the whole
frame with skb_copy_bits() without filling in the checksum, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels.  The frame
goes out with a bad checksum and is dropped by the receiver.  If even
that copy fails, zero the buffer so the driver doesn't send stale bytes.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 32d7f5ed25eb..c896770203f7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3977,7 +3977,18 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	else
 		csstart = skb_headlen(skb);
 
-	BUG_ON(csstart > skb_headlen(skb));
+	if (unlikely(csstart < 0 || csstart > skb_headlen(skb) ||
+		     (skb->ip_summed == CHECKSUM_PARTIAL &&
+		      csstart + skb->csum_offset + sizeof(__sum16) >
+		      skb->len))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		/* Send the frame without the checksum filled in, or send
+		 * zeroes if we can't even copy it.
+		 */
+		if (skb_copy_bits(skb, 0, to, skb->len))
+			memset(to, 0, skb->len);
+		return;
+	}
 
 	skb_copy_from_linear_data(skb, to, csstart);
 

-- 
2.55.0

