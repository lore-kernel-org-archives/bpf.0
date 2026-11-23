Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468425;
	b=lnwjmw//sq5Wp5+zR1sqz5Xy4OJs9FUhOD4wyEjJFf7J+jlJd3j90KAiiFx+9tJL+7v8
	 i1R5uM4UCADBBOanvFWmZ2Gf52PNaroDuLW+/Z69MtvzcLTa3Pg7VGXDGhfcjtCrO0p9U
	 /VqL+xD5vRGBDligiLYGI17gZMNhLISTMZGb+EfZGhHz9Mt3C4I96pEmLAZhhkAuNY2NI
	 xG6plz31UI2nJoxldP7s1vIicpBETEzIky2V6j1Qd04LSdxerU8sfLARLKFV4aLC4NC9w
	 zvTMVZ2MCNNQFYh9coIWsRRw30R3FlbUHJesIgbPJe/k2dRsA+p0KEg96rcJJmT9TYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=jOrBmkaA1MhIUwHAdE54Ojv9y9oOdSgBsokbvUaGn5U=;
	b=0Iz99OfuCgueSsBLQZDBumsQuJup+d1i8+aYghWDOl9n7TFkI18sHHQrbtTEOMxPWX2r
	 TGHfhX/h9shLr8y2KlUu0NthSvkbyxlTqJrj4WekkwyUn4h0aghChRDrEXo/Uaf9kKnQI
	 oCf5LRFSyx2V4n6aR/MulBnFx/W/x13JhaXvUDr9ZdJyLI/a9+noG1klYIkMWGNwiOUUW
	 tQ/lOfNg1oBtShGKw6hfF1XhISzblp4c4kjy6N2Ct/xv0l9qcgFZ8xkpDnsXJntaDNnoc
	 9MAyffcB6BneUwt4IiBkgUFIhYihTMeP8wNzhrieNNDaLjtIhbndPTRP1df85h/KNXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLZSctgp;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7C606A32C
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A7C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLZSctgp
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-71702e8143cso1119100eaf.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468424; x=1796073224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jOrBmkaA1MhIUwHAdE54Ojv9y9oOdSgBsokbvUaGn5U=;
        b=WLZSctgpxa0Hwc0iXACfA3pwnhcFQ3AmhrrWOE1p49fGqt5+XPChv/CbobB6njFDD3
         6dmu0OeHivZvP36SpZOKONpoviQF1uQ76vtJhAzfHOlyjEdHS8PZE7LqorXMdPG/QD3f
         k1oifKAfg9eICqGSMDvmpHhOIDmecy8aKFOYsuQb4t14BoZVo1BrCsFIZpe03NNyT0J4
         z+KFel6cu4LJaIRV5/tQuz81qkyGxZEOiZad3kIBPdUmgH23vZygytXeIOWHLahaF7h5
         PeC3VWPCSxdxOle6iYU+ri2H4YgUiAlNXzhpg3gPezhjOa6DNfNSWxMRBFNNldD8jybM
         EFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468424; x=1796073224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jOrBmkaA1MhIUwHAdE54Ojv9y9oOdSgBsokbvUaGn5U=;
        b=COEyqz0/welbRVKlxgCG1F6MdpQ+ZTPPNF3SirVJYYrxAS3uguXkNFotPBG33sf03z
         5EiSvZwPNBvulYyIF3RdN++25U2IofFW47OJYPnwYATsFvRcXbq398u5n3/Yj3xBVYeV
         /rYUK4Pl+OJuyu0dnfoZjHlSiNR0cAHlBD02p1eIAYauL8OIQMD12Rsga9OUJQl7ag7r
         McrN47wrOH3NG27j7v/k0iZ8YKbVxtUMzoraLeN8o3MFacFDUPqZWuGm4NwgJSbM6hwu
         6BeyvJpA39Ykekj+CToY8hgAIdDKnlZwd96UUadByTGt2AYtBbu3YZaIgihTeV8DXvOQ
         I81Q==
X-Gm-Message-State: APuU4Z8GNgahCeHay9xS95HXVYuzu1ricxzqrTgkc4lBn4tgyCySlCFz
	KPhTx620oS2/eE5JNTaNAd9XokusScOpnDyNACkLiXgZ+U9dsglDK8m/6naZrA4MYq4=
X-Gm-Gg: AZFdTZeTAGHZR0n554W9OmU1SojhtHMh4KMnday/uEXJUXR5hI1OMbFLXcvnQlqyIiF
	O/+N1JQl1zkMWi5SlWEyF8BO7zEL2DulaQ0gZgUa2LziTShQFTblGKCC7XXN5dyqMKggnnaza5L
	vR7AbRzPfAoAQBXpDwjF2/a8lZHWju2kAXz8cGxTC3oVOVL4ZkGKojrFC/zfaRAYYwhSgBnvFVC
	eUASYhpwbN4ATpTJMe+Y41CSzRoVY468Z1yLWJ1YVYfKqRrDF5NqN/Omm4b49u00kaqsiB1LJ8i
	b/MGhR0X2uHcidrmzrFSEVRgvJb52phFwP3bn5DDBQ6cf2jFbU30kGFqkkVE1ckMf1OMAb1SWkf
	d0l69hOR4OT9hdZ4DDUTDD7atkuElbDI59tpaPiVqPznjX6qYWLWrOaVv7X7s9hf3bFrHxSQi2U
	N1xImt5vR45uX0xHLnqTBWMx2Qu7FUEb/Hn5ip1DIpfmXAV3l4j8cA21FHb6hNpWJcL2P4gA4pB
	u+t0/z/5IFNU7zkoZsYQueHkEiDyhD9iOlYSZ9MQUTMEBqD62qS46wA2lAHPvp3F2bDKjDl33Tc
	mBghjuVoKVKD1rxKVCMhJV9We0sAp7OpOGbznV2tNKCIxekrn5Z0vU8NlTr9QAJbzAMfxkft5S1
	AQAVOg5UUNhTGOv3CA4/NQJYv+Kdu341h8nBb
X-Received: by 2002:a05:6820:4185:b0:6b6:c3d2:702e with SMTP id 006d021491bc7-71b392991bcmr8238382eaf.9.1795468424082;
        Mon, 23 Nov 2026 13:13:44 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e5472sm8401696eaf.14.2026.11.23.13.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:13:43 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/10] bpf: Keep an overwritable ring buffer readable while it is overwritten
Date: Mon, 23 Nov 2026 22:13:25 +0100
Message-ID: <5663a3dad6f78e6e52ad468d24579b0dee662d1e.1795467315.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3612; h=from:subject:message-id; bh=yab9YbdL0nUCC4japIPhUC+Sevd2q5n/eDpu5wFtMtE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhcmcFf8FEneXXGOJLyl9Z9SRa/oh45eZeahNjJc8mwjH +fiOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATET4GSPDiYb8Q01+qyZ/X+FRnLj29S LL3ZlxzOXpxqELez8YC3/RY/hf+OG1nprMwrkxNyTcbSL4GCWPdpX/0Hl7w95RZeKlLiEeAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

ringbuf_map_poll_kern() reports the ring as readable when
ringbuf_avail_data_sz() is not zero, which in overwrite mode is

	over_pos = smp_load_acquire(&rb->overwrite_pos);
	prod_pos = smp_load_acquire(&rb->producer_pos);
	return min(prod_pos - cons_pos, prod_pos - over_pos);

__bpf_ringbuf_reserve() stores overwrite_pos before it publishes
producer_pos. When the new record overwrites every record in the ring, it
moves overwrite_pos up to the old producer_pos. A poll between the two
stores computes prod_pos - over_pos == 0 and finds the ring empty, although
the consumer is behind the producer.

A consumer that polls at that moment goes back to sleep on unread
records, and the commit of the new record does not wake it up, because
bpf_ringbuf_commit() only wakes up the consumer for a record that starts
at the offset of the consumer position in the ring. With a ring of 4096
bytes and records that take 2048:

  consumer                            producers
  consumed up to 0, epoll_wait()
                                      reserve and commit R1 at 0;
                                      consumer_pos is 0: wake up
                                      reserve R2:
                                        overwrite_pos = 2048
  woken up, poll looks again:
    over_pos 2048, prod_pos 2048,
    nothing to read, sleep
                                        producer_pos = 4096
                                      commit R2, at 2048;
                                      consumer_pos is 0: no wakeup

There is no wakeup for R2. The consumer sleeps until a record starts at
that offset again, which is the next one here.

There is something to read whenever the consumer position is behind the
producer position, in either mode. Compare those two and leave
overwrite_pos out of it. bpf_ringbuf_query(BPF_RB_AVAIL_DATA) is
unchanged.

The missed wakeup follows from the code and was not reproduced, but the
empty poll was. A user space loop that polls an overwritable ring, while a
program overwrites it with records of more than half its size, found the
ring empty in 25 to 59 of 1.1 million polls in three runs of half a
second on a 4-CPU VM, and in none with this change.

Fixes: feeaf1346f80 ("bpf: Add overwrite mode for BPF ring buffer")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/ringbuf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 5806a5eb5d16..1334cfd90f2a 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -336,12 +336,18 @@ static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
 static __poll_t ringbuf_map_poll_kern(struct bpf_map *map, struct file *filp,
 				      struct poll_table_struct *pts)
 {
-	struct bpf_ringbuf_map *rb_map;
+	struct bpf_ringbuf *rb;
 
-	rb_map = container_of(map, struct bpf_ringbuf_map, map);
-	poll_wait(filp, &rb_map->rb->waitq, pts);
+	rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
+	poll_wait(filp, &rb->waitq, pts);
 
-	if (ringbuf_avail_data_sz(rb_map->rb))
+	/*
+	 * In overwrite mode ringbuf_avail_data_sz() can return 0 for a ring
+	 * with unread records: a reservation can move overwrite_pos up to
+	 * producer_pos before it updates producer_pos. Check if the consumer
+	 * is behind the producer instead.
+	 */
+	if (smp_load_acquire(&rb->producer_pos) != smp_load_acquire(&rb->consumer_pos))
 		return EPOLLIN | EPOLLRDNORM;
 	return 0;
 }
-- 
2.53.1-Meta

