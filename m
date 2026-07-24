Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67711421239
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889569; cv=none; b=ecbz97HhpDqNT7RxnjyL99gNgv888D30U2pfgmiJR9Z4bczJgsfvLgS55V2TjcAbc2/CW7KMv4gDM658BGuKDnhWW2VMOqa1Jt0RR3RqxSsAdqwKDvub9BLJv8dMxquKhHdtl95vQeX/6SG13096UaHEhBd6As8e7qM3rFPcWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889569; c=relaxed/simple;
	bh=eKd9pCQK8yq/2taFlLxedEdPHpo601/nz/qzYpE3TWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtTZCasNBS5ycdb5scuGjKzx9RFqdHYx91cne2J8NuiyA/IWMhoaJHzipVWJEHhEuITlo+nLZN1swT9xVbJHqso/6NnRKUJWFZ/GCOv7+MnWHUR2P3rKZtbXLL3mkEoDX0dUZ71QuKhT3wsgYEUuHswUIKcIZReI1uVQ1U2wMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRpfZyOI; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRpfZyOI"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6681e786b81so36287d50.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889562; x=1785494362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N9RSE/2JZSOuvVzl92N/Hvh+oDgfC4zbCGCsJCtj4yw=;
        b=fRpfZyOI9xZogkAs2e+FLw/KFHE6GRjMp8hORrC9BV0aYChO5JwYhtuwYzZK13A4Fq
         FSxdENCJ61EQc+u2QFowdzvbLFLvn+xsvtwVfNZDONGriFO2XOReM6Kbjm7rWIoAmX/q
         vcS+mZQchYEZmVc9sMGPFqjX0kCKwc6bhk9pmM+L0sN0xAOVQFTU1CqLFHAS12Y8IEi8
         Gce23RVayOkKPh+J/kftwSKO+ERkw8o9qvW26sMtakjqFIpj3hnEQ16zKel/plqqXTBQ
         egDd/JRaeDSh59uwvq2+QS8RBkDrXa5yiHi1iVcGL9NyL6z5gm12pq5WDO8lojPxlnCY
         53TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889562; x=1785494362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N9RSE/2JZSOuvVzl92N/Hvh+oDgfC4zbCGCsJCtj4yw=;
        b=AHwWlIzP8gJXZ2tBN6SyH2EEZ04TpvEaEYVs7Gav5ZnLCFnarI9RdtHhv/r3Kd6gmn
         F5EDdXkg4z8BcrD7q7DAC2ND0LE95ntcloaIpRsL6xMgJJmfhIeQse+X3j1l0+RtdQh5
         v6Hhu+27Bq2V0XnUIgKC3TGTOLuEdFeHx4TpaWAjrvgHC8qkTbjcHej8s2tipXVxN0ZX
         T5OsYhV97f9fe40Rpzhhwc4pMH+Nrs21apF4AbPpy2DffpCzib8xbdZc2aEwvH9rDLHA
         9z7xKniC1w0ljH2G6dlud3AR5RKMb32+tJ4MB4/flLoQq5UukxARIX28B2Yo77pMQKWh
         ZnCw==
X-Forwarded-Encrypted: i=1; AHgh+RppGFrbSwUX4x8taqFjX4dThjZCoCF1QFQuAFLcLZAX2dgenNnKYng0yuHtEPVnw2uKWZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCA1JjwL1bWKyVKXBg9vSaeUBN0DMslweNUQKF73t/p/SafGjL
	YkOdG5Gf6jSazq8mh3rHgZPDx2w9SonXo0r146PIe2wq13+bJ+kDlhx1
X-Gm-Gg: AR+sD11WHUL5ta0c3MJn+QeHFOJi/0AVVMt4g5lDCVp+wpqyn+pHViLa5151uD8j86Q
	ptU9Rpfuqga7rZvsIyAa4GbgaECrnOuDmynQv9NGhjsCMQ84wAAHPQn29NuORhd0mwDJ6/33d7c
	RxD/eerLEW1Jnpp0oVhrL/uUQuOHjPcX6HrlWhp+cRYMTi5QWQBzW5xdGLV8aIVajKJ+/LzCLRP
	PqlUZuVDpW5TZESJDjZLNYZXiWslNNc6S4yE0lleateG6kooHT++3Ou0CHtRYxzevx5kho7qMQx
	aSDLXXNsyyRPb1QNKC8bNm39g75OSuUOihs/o7IWrru3bHxUqpVYFujtilyV3of9DUSgspeT1NH
	cpxzPvJLcdDGQkcLdEEzqhGWXsgu+NUvIzIe45eQsULabdfpRDimpQU7wy5zsFtasnDPYBXC7W5
	0FAPGLnFKS/cA/6z3/in2JfdgIwe2XEmzkRFHhSLXzzDhqMyF2r+9rh0h7a/+G7+fuNeaq
X-Received: by 2002:a53:e18e:0:b0:668:99fe:7ba4 with SMTP id 956f58d0204a3-668b2fe1f2cmr632835d50.0.1784889562290;
        Fri, 24 Jul 2026 03:39:22 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66890521642sm4645770d50.3.2026.07.24.03.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:39:21 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH bpf v4] bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
Date: Fri, 24 Jul 2026 18:38:56 +0800
Message-ID: <20260724103856.3399001-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87fr18lmzo.fsf@cloudflare.com>
References: <87fr18lmzo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which
drops and reacquires the socket lock.  Its error path tries to decide
whether msg_tx names the local temporary message by comparing it with
the current value of psock->cork.

This comparison is unsafe when two threads send on the same socket:

  Thread A                         Thread B
  msg_tx = psock->cork
  sk_msg_alloc() fails
  sk_stream_wait_memory()
    releases the socket lock      acquires the socket lock
                                  completes the cork
                                  psock->cork = NULL
                                  frees the cork
    reacquires the socket lock
  msg_tx != psock->cork
  sk_msg_free(msg_tx)

The stale cork is therefore mistaken for the local temporary message
and freed again.  KASAN reported:

  BUG: KASAN: slab-use-after-free in sk_msg_free+0x49/0x50
  Read of size 4 at addr ffff88810c908800 by task poc/90
  Call Trace:
   sk_msg_free+0x49/0x50
   tcp_bpf_sendmsg+0x14f5/0x1cc0
   __sys_sendto+0x32c/0x3a0
   __x64_sys_sendto+0xdb/0x1b0
  Allocated by task 89:
   __kasan_kmalloc+0x8f/0xa0
   tcp_bpf_sendmsg+0x16b3/0x1cc0
  Freed by task 91:
   __kasan_slab_free+0x43/0x70
   kfree+0x131/0x3c0
   tcp_bpf_sendmsg+0xec3/0x1cc0

msg_tx can only name the stack-local tmp or the shared cork. Check for
tmp directly so a changed psock->cork cannot turn a shared message into
an apparent local one.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---

Changes in v4:
- Use the PATCH bpf prefix.
- Restore the minimal v1 fix, as suggested by Jakub Sitnicki.
- Drop the changes from v2 and v3 for other issues flagged by sashiko.

Please queue this fix for stable kernels affected by the Fixes commit.

Link: https://lore.kernel.org/bpf/87fr18lmzo.fsf%40cloudflare.com/
Link: https://lore.kernel.org/netdev/20260719161630.2901208-1-nicoyip.dev%40gmail.com/ [v1]

 net/ipv4/tcp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8e905b50dead..a30475afb6f8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -604,7 +604,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 wait_for_memory:
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err) {
-			if (msg_tx && msg_tx != psock->cork)
+			if (msg_tx == &tmp)
 				sk_msg_free(sk, msg_tx);
 			goto out_err;
 		}
-- 
2.43.0

