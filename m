Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468423;
	b=agJIZkMEB3OQpTsrZgOAROgUMVJdfgNe2svXvRDSAD6zi7oyGXBfwc5aXw9tD78ZhsOQ
	 sFkoNIfLzg1Pk48cPlUakdnOCdCOdq4ZCGB7IxLKjz4cvQujOZ9h5REys+k3XBNL4DSWp
	 YDNgxcUc8pkeIw8kv7UbSV59O0An14AmxgZy8Sg1V1bOLHMhZr6tTSU5XwrrXyLy7sQCx
	 lXFyFLjQU8CB7GFMn7l/l4DjsncPHQ5hyUjIll5GB+7GHvpB9KdlIeL4Y8t3JHqcGhJpH
	 JRHBPoj9iOKMrhz/7BiMmQfsaVWBOEeNvDf5OyOdFth/7Uqm543ebUjnhzj8fYNqJHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=5MgFH9KPoHBSR09ZIad8rRDN7CpmQmWW6sL3RB5hMB4=;
	b=gKQ/NYE+CJyS6a+5eE4ho6w13ejWopigd5ZOIVjMrvrfEbdyuh7tavmeKyu5OsU2YDwU
	 izCw+uf3br6temYUkLOfVOAyz/hoxovyfneZTlxLFZYn8rchch0D10pzj+UhQn9/vYkNL
	 Zzt07elPALC+nCBPOrKTxr4mQ5b5LhZCfvMg2IXvtoEvlOHaLX0BRxB+9naOhBrNFHmYN
	 bGq4Tfdgxv5owUgB15Jpr6CK7En1kjpiwvrbbCxfTvFhzeiM/rnM9Xpp+NQjBkrIqSmb1
	 PvogYsR+no5GYYlxCUP5ys9vBx1Qif1Mj7vRLOyw8lxUdjU8JFmUqX0PT0DEk0gRerA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxFMcd0e;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF83606A330
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF83606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxFMcd0e
Received: by mail-oo2-f8.google.com with SMTP id 46e09a7af769-860f0ac44a9so1479106a34.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468421; x=1796073221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MgFH9KPoHBSR09ZIad8rRDN7CpmQmWW6sL3RB5hMB4=;
        b=XxFMcd0egFaeu0eWDR5YS1igsXac4LqlvcrtSiAZJsgb3yhgqKebFq2FsFz2JLenJo
         rBpTdKxjhR/10pUyQcANMZv1nelqp0Lg12yB1CoAayhdRybGg1TVvS9oK42uwqHCAFS/
         MuQC8BOKbF4P7WKOzreO5VqcIsw1lTQkdr/czsz6OVPBAKxckgJjYNVXzqdjbYNVAkJU
         OTUxw/EitN97q8NoZEXNNm1LKICqsOuXERV2wx3Q7xU6LuwAgln9GaQX9bDBmqDF1/PA
         29Qp0xv5TXTWLGwO2iLE6k1XbaUIvB79vILriXyg9ZSemF/P1J9qD8P2nlfA83IyJr7h
         IZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468421; x=1796073221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5MgFH9KPoHBSR09ZIad8rRDN7CpmQmWW6sL3RB5hMB4=;
        b=ETZAMOYLZHu0tldVBLjNdfHEnOtOZXX6TAhtc3qUWTqBYc6IoucHC1DKa9DJEbZwl4
         E1uGj6YYHnMnC4dJjx74NAkbzgXf81CvEsGESnJ74+G+8xNI76SyQYOLa3jDLbBmgNwO
         FDLw8SkYMsBwx5zokKtdkzKni5NF8+6pVygbBC31iZIcWE2VQ+KX/kDxWgSmHHyzVdbl
         rT08NpNUHlooldTvhl/n8K9oamSZVbFZTHr/9yw4G7mlqeJdt1LwqA+QUeCtPJx8iBWJ
         9wMJF7LI6fi+4jsDVE82yJsXc6mtuAuUnGhx7cnWt9JoDPrBrUx1KrJvLv28IYvWONgp
         /6cQ==
X-Gm-Message-State: APuU4Z/L2vdzvxY37SgurBOOkA94X5iMR5wfxKArRMKwCPqJecwd/rk2
	L7Hx1wktFic+wc8bXSRDMyC1hhJALa7WCBct824U6FkA68naDSNyeeZa0C0+X3klnV8=
X-Gm-Gg: AZFdTZckBcVgO4xmr9U5OYxTyt/d4jtU6fU2BuMEDI9b7cG5/jIepYucz1qUXy50g1c
	BkQlsWHIu/QPbV1GbcFrzNJuXqQauzwD7ft6kkuGVen9r9zGE7gsPumZbHU2vHR12qQGujsz95C
	vga7KbIzR/TpTKrqPR6dZMpUnE1fGXB/8DulcExrS4EHDl1UOc4sqkvulOWi90++YgxkbsNyu+K
	ldZnX4om9GfsFBxes1YHjqnhwxrde/JYc0/Dvn2Tk3wVuQ5vtwJF0e/zFerFPALVNnTRI00rDve
	9i0Ee+kpW1E+p6TXkCA/B0StxQpt41wLGH54rysBigZs0YJsF2VVziDLpXK5H51wDrjf/HVV4U2
	Uhevlss9vqxWqEGY+ocyoX87iS6JOR79gKVrAPjZUBEyEPv1ZJozLSVoFrbl95/v8vvAzB+wfun
	6yE46MiPOB0GJ2WgZJt6CQzb53JtFRFvthtzRYurziCWJZ2PSQcnha2NDn+ahF57NvwGpZIMLXi
	d0KLg+RP0esUWStVJ9UzHbrRfiAOqLhcNIpsELyMIiq77+25enZf3phBQkTbEl6HSqw/ipjCIy9
	oIO0m6K6AsOy6+3aEX1JbpSYGQ+glOJBnIQlDT4l0HfSDSOz9j6YHOB+Iqdp6AY5rLMzVEpY492
	4qgL+Rnc/g+XN2pZGpvgoBnkViChHp7bsixY=
X-Received: by 2002:a05:6808:4fd4:b0:4f4:73a9:f853 with SMTP id 5614622812f47-57a06c1bc30mr15514873b6e.1.1795468421488;
        Mon, 23 Nov 2026 13:13:41 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a350548ffsm9139391b6e.11.2026.11.23.13.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:13:39 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/10] bpf: Order record data after the producer position in overwrite mode
Date: Mon, 23 Nov 2026 22:13:24 +0100
Message-ID: <8a47c80b9a3dfa8ddd4788781b854357a15717b9.1795467315.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2419; h=from:subject:message-id; bh=qBjNh2Q/4qlrErtrs/APAAou0YHhKDYUSSeD0I4zgIY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhfEuoVO64nmiK8Seahn+5Kltvt7LJPz6seyuY3OPcfAG 3AjvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET+uzIy/HKQuSyv03vunaJ++gGllh vG99SEXQol5nbJmx+ctdpInpFhYX3dwgnLrrUf1U1zWLbRxfWc4QSbsAnttc837fe+zf2KDwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

In overwrite mode the producer can reuse the memory of a record while the
consumer is reading it. A consumer can only find out by reading
producer_pos again after it has read the record: if the producer is less
than a ring buffer size ahead of the record, the record was not
overwritten.

This only works if the consumer cannot see the data of a new record before
it sees the producer_pos update for that record. __bpf_ringbuf_reserve()
updates producer_pos with smp_store_release(), and the BPF program writes
the record data after it returns. smp_store_release() doesn't order the
stores that come after it, so on weakly ordered architectures like arm64
the consumer can read data of the new record, then read the old
producer_pos, and take partially overwritten data for a valid record.

Add smp_wmb() after the producer_pos update in overwrite mode. It is only
a compiler barrier on x86.

LKMM litmus test, where P0 is the producer and P1 the consumer:

  C rb-overwrite-data-vs-prodpos

  {}

  P0(int *prod_pos, int *data)
  {
  	smp_store_release(prod_pos, 1);
  	/* smp_wmb(); */
  	WRITE_ONCE(*data, 1);
  }

  P1(int *prod_pos, int *data)
  {
  	int r0;
  	int r1;

  	r0 = READ_ONCE(*data);
  	smp_rmb();
  	r1 = smp_load_acquire(prod_pos);
  }

  exists (1:r0=1 /\ 1:r1=0)

The outcome is allowed without the smp_wmb() and forbidden with it.

Fixes: feeaf1346f80 ("bpf: Add overwrite mode for BPF ring buffer")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/ringbuf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 447863ece26a..5806a5eb5d16 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -532,6 +532,16 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	/* pairs with consumer's smp_load_acquire() */
 	smp_store_release(&rb->producer_pos, new_prod_pos);
 
+	if (unlikely(rb->overwrite_mode)) {
+		/*
+		 * The consumer reads a record and then checks producer_pos to
+		 * see if the record was overwritten in the meantime. Make sure
+		 * it can't see the record data that our caller is going to write
+		 * before it sees the producer_pos update above.
+		 */
+		smp_wmb();
+	}
+
 	raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);
 
 	return (void *)hdr + BPF_RINGBUF_HDR_SZ;
-- 
2.53.1-Meta

