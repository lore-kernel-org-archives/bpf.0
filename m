Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582039;
	b=lzF6L81Zi3j+9/YTe7Xtt0O/IOfSk4D6viFzEIQApzyHKghucr/RWX7WvKgjqgoxmuxB
	 QQbLzaupHvm88qGuebzTKlNfI9bdfzKNn8nJ1ru6WkL5hg03rYbWPaX858HXGIt1UX+8K
	 uSAm3UIuQVFokSKL6e0iiBig8kA+A6MWXEWr48U9n7PP3RDtkaMEWxtp1oS3gy9RyzKhE
	 tmqMBQ0uzCZNtnSxdC3sbmRc6z/TQVxRODtxEvfzWa+CA+b1PZyn5Y4mhhbyDcXkM15pz
	 HL5bN7lA/YcAwsgrUgMGRvjXgE8lEAXN0L2FToTgyXthyLwBpzQuDMGz8PCTAikAjOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DWvpGGZnFMcBi8vnKFhpJMHt7ncorde3el3j3sr/TdY=;
	b=wuEslKortRVbso0kc10bf8LDYtcGfgHtPBm4mwodWIh+CBxR3ETS63s2AX5eggzNpJkF
	 roatruMGFXpWGKgFYP2k1uMaYh6tVWskSw132LkrRrblsYddae3zjKPG5wz/HRYgPfp6+
	 WLSS0cviw73mKYyE7TVIW0oX0cfOdNluZhL4shaGU1wPfMFWgRpgaWe6j9ViRdLXQs9Om
	 ZRs4x8yh7Ms2mBKOFTf0CDzbqcqdPIbhPp3XNZ/8UK1H/dgReckTGHVHEtiKL51gxpA9g
	 PrtrMACofsZ3lGz+pvO3F61slzbM0mJxyhoma9XT/EMtW7QR4SZYZH7XdLVRECrKdqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8xB4y19;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0B606A32C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3D0B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8xB4y19
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04b676219so29155365ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795582038; x=1796186838; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWvpGGZnFMcBi8vnKFhpJMHt7ncorde3el3j3sr/TdY=;
        b=o8xB4y19riQxDnBxmMvMXVdMsQQl/tpPCBnnDxQbO9pdw5Ltt3ojkrkLOxuJupCCX+
         k7GK5J05xL4YzCM5JZoQR4K/5u9io1ApV7L9/QwglQcAVCLH3uSyfsSUoMw00tA9OSmf
         lBcqmIxquuLFVE8pOodrWj9GsD/PQ3gr0Vbf+vBghY7762HJjtkE7DiQgwssIDINNMyk
         W1sf/wKCX2SFY8jrfvX8syO6XUNzZG+3YBOlpkXmRyu6ioCv0gPKSNMLWDVx/oBK519H
         ptkBCLMyWKPnSQCQDrcPwhiI133WLk7mmbvotVHhbkHr60PlL2h89FhMk6sJOYHyTp4H
         h2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582038; x=1796186838;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWvpGGZnFMcBi8vnKFhpJMHt7ncorde3el3j3sr/TdY=;
        b=pkv2Y+m550HykAC2IuyBsGE8dqgDfObyTJpU1BO7z2nnRCTNZJS91MKN53SRL9iC9I
         rBPg/jw8BB+AvlRG4aw8H5tJIJsjyyRaI+LZ7jbMbGOTr14t1e6eUbsVsXEUS3XmyXIP
         4WxvuB4wxDqJB7IU8jE81ln9BlLp9x1v6X193b/UP4Ghqa3IR0CvMyXiEfsNvw4tKkeb
         nTGqgowITGaJI3K/hR7rx1fl/U6CteqswihirFCS/652g3FYRMDKv+yvbRRA/Fc3tu/U
         MvGDbJhwY877e8G/+z/3ggxOyMQyo4YmnNRaLk0WUfL0vQwxL3VMVSwXs5FInb16uq5S
         5wfw==
X-Forwarded-Encrypted: i=1; AL+hErFzmLDs3RHrU04TYpkuA0XhP9hqpwub51hFe+aqNGLl2bwQd1WhwkeYtvLc89Iky30pr0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NdAm3SykV0dnhKMWZfny1HEolKdpAvnRoyEtq4HvGeTkV8DLq
	iMNS8qUi1x3MDTaTV+EwEp0ft8u6QlpbIrwWxcOhNu1+YZa4krZPQA7q
X-Gm-Gg: AZFdTZfgsuUrV2eL5z/+otsCVwsL+maakXuMxEAQxZm8Ol2SKWINQRCWrvlu7aW/4HQ
	3mmU1LBnb+VAC8Wr+vs4RfGjj/XW2lx1z73mTxREiQOb7GxRl//XmxHIzti3/SSdGNn6ZYmi5aV
	Pr8wkWlvB3vK8jvGqmE0CCOzk2GNjMCg6GVVHl+UqD5kU7wYbnsAObD8T4v8BiNUOaGD9I0vgvk
	S5aDbvxcpEX0+7EDtiPXmZUXKIOOQ+kuNhnhVvoICjg1OLfQYpxk9BjWIFm7LtWqEC00j4jTaw8
	w7VQ71EewGYluYjAuy8PR5k5gVKmtDv/rpDvi9VB2kkDpUELUVMeYBcNZsoe1550zaclf1TbAeD
	lQziuFmMVJ/Lf4usMEvOweSuTG+4L3bD+E5ZngpvOgjA/TqKvRaLv6k82sM4G90aF+LTwnBcwUj
	HChdCV3F8+FHrfYz91+gwfZ8jRr64MzhcUJsuLRrU3Xv9BP4geOpLMAwbf74pO63WL7YbVBtsz4
	bMn2xS2VsTbgOcClPgh/VLAKXG0mISMaGfSoHXhOExzxunbD+msN1z9QbGa9ntCmNeSl+hZL8Pj
	ARrzdUQwGmbl3fwRYkq/37y9H21HV3U+QXs17Wg/jjQmu3ZF+AR1Au+4rybO5otqMyUnJ7UHQ5C
	ZlMNTvSFKuSaksxwjvcPAuFW1NAxO+M0UCw==
X-Received: by 2002:a17:902:e88d:b0:2ef:e864:e0fd with SMTP id d9443c01a7336-2f03ef870f4mr181606655ad.5.1795582038283;
        Tue, 24 Nov 2026 20:47:18 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1215e2sm78920505ad.63.2026.11.24.20.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:47:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:47:17 +0000
Message-Id: <DN40PKFY2KUF.13KK78H8OW2J9@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Dump unaligned enums and
 a zeroed fs_context
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <sashiko-bot@kernel.org>, "Hungyu
 Lin" <dennylin0707@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-216524@kernel.org>
References: <20261116080151.44860-1-dennylin0707@gmail.com> <20261116080151.44860-3-dennylin0707@gmail.com> <sashiko-outbox-216524@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 12:20 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +		/* 'phase' is an enum bitfield 3 bytes before the end */
>> +		ret = btf_dump__dump_type_data(d, type_id, zero_data, type_sz, &opts);

> Does dumping struct fs_context with emit_zeroes unset read 1 byte past
> zero_data + type_sz when checking the phase enum bitfield?

Yes. It's an existing bug, but let's fix it in this series.
It's not specific to unaligned data. purpose is aligned, and the zero
check reads all 4 bytes for it too:

  *value = is_signed ? (__s64)*(__s32 *)data : *(__u32 *)data;

With need_free == 1 that's 0x10000 on little-endian.
So the dump prints purpose == 0 without emit_zeroes.

pw-bot: cr

Hungyu,
pls fold the fix and respin.

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bbe8692..e78a14a 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1879,7 +1879,7 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 		return -E2BIG;
 
 	/* Maximum supported bitfield size is 64 bits */
-	if (t->size > 8) {
+	if (t->size > 8 || nr_bytes > 8) {
 		pr_warn("unexpected bitfield size %u\n", t->size);
 		return -EINVAL;
 	}
@@ -1888,13 +1888,13 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 	 * stored in num, then we left/right shift num to eliminate irrelevant bits.
 	 */
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	for (i = t->size - 1; i >= 0; i--)
+	for (i = nr_bytes - 1; i >= 0; i--)
 		num = num * 256 + bytes[i];
 	nr_copy_bits = bit_sz + bits_offset;
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-	for (i = 0; i < t->size; i++)
+	for (i = 0; i < nr_bytes; i++)
 		num = num * 256 + bytes[i];
-	nr_copy_bits = t->size * 8 - bits_offset;
+	nr_copy_bits = nr_bytes * 8 - bits_offset;
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
@@ -2579,6 +2579,8 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 	}
 	case BTF_KIND_ENUM:
 	case BTF_KIND_ENUM64:
+		if (bit_sz)
+			return btf_dump_bitfield_check_zero(d, t, data, bits_offset, bit_sz);
 		err = btf_dump_get_enum_value(d, t, data, id, &value);
 		if (err)
 			return err;
