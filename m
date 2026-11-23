Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468431;
	b=lQwS/xEZinUkOm6Lqc6q7tfvd/MnzfRygogkE1Lnfpa0QPEDsP8vprhuXGjR1ZnLwknx
	 CO12Oh5/raxUuO7DUgfIFNyfkXIRqqSbQnAmKc3sJTx0iA1EZfzXoPkTqOvKMuDG7vrz8
	 On5OYM0tG/f+B8O4FJD/TPzvim06sML5iesnv9nuBJF9HuU3yqQOuptq9oL0gVCyy7GTM
	 5NOrDcxa3wGfuikp1ATOHKVFYji4yfUXK9M+6NUwav7H/pKvs3bnZinEVDHssrsDj8f1H
	 b6ruW6k1dE9d60e3ZQ3FAYh4KVTk172gtHPbPKnwB33O/Esqay7im+VL0vVzeGLNLeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=iZ2GVaGZzacxETrJfASACa38iYdC+h6Us+/jvUQYA/o=;
	b=uUUNDoP/DRlEkO1J1r5MSC3353/7j9ItAi+coDl3X3NkuCqhu1WgX4pyALvqY3wb3wbD
	 6xmV5j3Ioc7FwkjXKCn1fn9ktNdt0g/6xT9mHS4gOLiIIYSnKZjK5a8ZHHcHao3EpeBha
	 dXumNNIXimZsagoDIt0SB0DmJ9BE3NH4rqxpLiqjCLG2qwRGIBujGEyny/gxvdWrJ7HSY
	 BoBI13ao6S1Q8benkRxnXD0tbLomiSas48+hXDeIp38fs0qQMWNO9FmWocog6WguL2zRS
	 4gjwBVAHvEoRp83bsIEIgwp5daTLCj0LVM/yLcsFfwLjUaMpnUpQyFQzEAfO3aRbQvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P1GmPaXq;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A56606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A56606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P1GmPaXq
Received: by mail-oo2-f8.google.com with SMTP id 46e09a7af769-860f8b7b943so1499102a34.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468431; x=1796073231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZ2GVaGZzacxETrJfASACa38iYdC+h6Us+/jvUQYA/o=;
        b=P1GmPaXqi1sFaZmyDjUCiBBeLaa+2IJ6Wv66jw3+FAsNwyzPfMbT8y5ZxkBTiVNXHZ
         8EAV+jBNK96qpEZp49lexblW7VZ+sr+2fboRcegdrV8PLJwDkH4H1S6QiIWPl4YOfrSV
         8xO4YT5PEQesoJW/ZYyTYDJuGrCjxC1ULC+F3C15yw/BUyUMwf0asY3LvKd2+9AECA1E
         74bKcTP07v02N3L1QuBJtdx/sGxXds+6KrGwFv8uyMK6YB+vtHO9VrKQOqFUeL576YAn
         vTimYjqOwE9lRUmCS0foi7Kih+oBMrGDLEbyD4NRNQqy7T9EnVP/U6IH+c32MJSg+807
         aaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468431; x=1796073231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iZ2GVaGZzacxETrJfASACa38iYdC+h6Us+/jvUQYA/o=;
        b=XdV1qJZu/6CtLiFe/9Rqe2YPwUJge2AXf549iVzpLy5XDPvscd3omFZLaZY6LgVoDj
         VS5xr5VV0E5J5ADovXld14YoaXx1tTnh67pLWJFR5CZ0NeU5+qUugQZr0lSc95ewwnEe
         l2XrVee1xa9QlhKQWTevyX+RbLTajHqLTKWTzkP6B4Mx1VdgGC7pP3ry9KZc8eEWfak6
         e6+I5g80yabrt09XOvpat0doJp2CV8Qq+oeyxLR3ZSi5erBGmtxbfZ71pSV5Zuh1jM17
         JbGID7MEfq0UW0SJTTANZeIrxjQvjNoI/UokKuFt4tBEjryHVgihON9FBTfgf8/xjbzX
         ypfw==
X-Gm-Message-State: APuU4Z8HXR2/CFTjhuHWKOjlhsrltixLXmSI2G0WtSOevD/MtztpWeiJ
	TOwkGDR99HDrB6EDTXpzpbZtMppt8F8pwRfr6ePC2AaE6TE5AwtOMkKvZ5j+Bc4GcNs=
X-Gm-Gg: AZFdTZdWCNqf7heTPuK8vm73clby5WAL65YU4Nr+rpw1lSGdybjx5ag9A0qGnz524nN
	PfIWVM2qhmBJfelLxKFXRNRpQkzqCNBwc7YxKHH1T5/ksTttkQhA0HA0D1crUKps+oRDfK4A5Gx
	fBbueqxe5XURjm0yFkzXsxsEM3RTWysFGNr5ib/5NXJhlZpQSpXgqnccwqD2YR3W/NfVXKHzqCy
	SJ18R8AA6/U4/OnxZmKEI8lrTTmkp7AZFP6bXKtCS1A1EL9zwRnNsdymhxN6fTN7QKnTM1ucex+
	iB06YATOGwohhw4pmZq0prSwVJRYNVvkQOI+Z2WM7ch5f15xggd2RBVCNYmqG/2XPntPGi0WPND
	IAMrHMmInXsAe89PBmZIQUF38u91cRnJ5bdeL5mi44BVrlKZ4BK17nVAvZYxRWR8bVQWuRAn5Q6
	xE6TQHnjmlhzDqHOpP2NYG4EoYnS1HqqtA7CcqIQqb+5JukdiV7n2Sth5WEODB4pQnr6kEWBaSt
	4aqGeeS3Zq6DwvdblFV26HM+xchZztI1DldOs7W8Mb2+Mm2jIG7cJC1/mk4eBTpt3aL0m5qUrXo
	mJycTNqcK34mPaLfK0x4aFIrFC1Ws3Y68SAYYXzma8GZz5KuvdC0/dwnIwnUwwg0e7dwlqGVa+1
	+HtLVQhGJyAlW4bRNQNCUsgw6zgDCQox6nSE=
X-Received: by 2002:a05:6830:2709:b0:862:b748:25c2 with SMTP id 46e09a7af769-863159a6f90mr12675843a34.23.1795468430525;
        Mon, 23 Nov 2026 13:13:50 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86322db2d1asm7906271a34.4.2026.11.23.13.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:13:49 -0800 (PST)
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
Subject: [PATCH bpf-next v1 04/10] libbpf: Account for the overwrite position in ring__avail_data_size()
Date: Mon, 23 Nov 2026 22:13:27 +0100
Message-ID: <853ef5deb34f53b2007ab47699c889b730d87805.1795467315.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301; h=from:subject:message-id; bh=mdYdeHuh/3Oqx/sLdjTM1Vdp3NSvNdYR+561S8Cm0zE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhUnFcndr/kM5C/sT4ra4ei2J8z14Yck8tdR1B5cFrjqw intxRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZy7wwjw82bWz/PPfOzlq/815t7vw IXNDycJKPvNFXqikrFp/D/BtsY/oedCFRt2jihOzrYLva4z9aOg3MtrIV0F2cbyV7Lb8xT4wUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

In overwrite mode the kernel overwrites the oldest records when the ring
buffer is full, and keeps the position of the oldest record that is still
there in overwrite_pos. The records between consumer_pos and overwrite_pos
are gone, but ring__avail_data_size() still counts them.

Read overwrite_pos, which is the third unsigned long in the producer page,
and return min(producer_pos - consumer_pos, producer_pos - overwrite_pos),
like ringbuf_avail_data_sz() does in the kernel.

A 32-bit libbpf can't tell whether the kernel is 64-bit, in which case
overwrite_pos is at a different offset, so it keeps returning producer_pos -
consumer_pos.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/ringbuf.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 78fcb3df243f..271c6b9b130d 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -28,6 +28,7 @@ struct ring {
 	void *data;
 	unsigned long *consumer_pos;
 	unsigned long *producer_pos;
+	unsigned long *overwrite_pos;
 	unsigned long mask;
 	int map_fd;
 	bool overwrite;
@@ -150,6 +151,13 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	}
 	r->producer_pos = tmp;
 	r->data = tmp + rb->page_size;
+	/*
+	 * overwrite_pos comes after producer_pos and pending_pos. Its offset
+	 * depends on the size of the kernel's unsigned long, which 32-bit libbpf
+	 * can't know.
+	 */
+	if (r->overwrite && sizeof(unsigned long) == sizeof(__u64))
+		r->overwrite_pos = r->producer_pos + 2;
 
 	e = &rb->events[rb->ring_cnt];
 	memset(e, 0, sizeof(*e));
@@ -426,11 +434,16 @@ unsigned long ring__producer_pos(const struct ring *r)
 
 size_t ring__avail_data_size(const struct ring *r)
 {
-	unsigned long cons_pos, prod_pos;
+	unsigned long cons_pos, prod_pos, over_pos;
 
 	cons_pos = ring__consumer_pos(r);
 	prod_pos = ring__producer_pos(r);
-	return prod_pos - cons_pos;
+	if (!r->overwrite_pos)
+		return prod_pos - cons_pos;
+
+	/* records before overwrite_pos are gone */
+	over_pos = smp_load_acquire(r->overwrite_pos);
+	return min(prod_pos - cons_pos, prod_pos - over_pos);
 }
 
 size_t ring__size(const struct ring *r)
-- 
2.53.1-Meta

