Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F270F82D9C
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813027; cv=none; b=BLIDzcUSVzWoxbz0xpg7q/JdTpw6tKiUgF+TevBRshWpU5owWOQnQ9pA7513PQlGcBhG3HvApMyrrbOmZYLBNSnHxdbgjJ1tF8d6b54G9tqNGELvndb0+pg5T8RZdkgj83MLN9rAIAN1qB8lNiKmhnL8EU3RPtv47eSSEGec9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813027; c=relaxed/simple;
	bh=VabsikQF0k0IQ9y/QlLTfmY6orqjAdYHABK5Gdt7a3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FG3Tay/bRMvUJfakelLD30/Bmun07VO4F61IpZS0HCDCoQe3qj2G7LbO6i5SbBsDgC++Q9yy6FIXigX8oaadxu8rY7AjVgA8Ek7+Ht5AuHQGq0t/A1WZQc24Q7nO/eqo/tckXQbrexfvUIqjmSKzQ8rI02YHT845GtdQxb7B1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJpqp8Tt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJpqp8Tt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709813024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDEgj1V2cjc85YaJq6bxK4Rqtu+HuPgKUTy4qIFCidM=;
	b=FJpqp8TtTJ4W9Jgi+B0XgVqrWorr3EHCtzNyhUP27eIaChCaYdNfXZFvfQtprETz78Z2PP
	SNy1jVYMX/Bce/upY3rMKH6gEPdSlgO2OlhTM79B01Zn1Dkn3xDP7Jjv4SBXlmPnkXXxyH
	LfodCzTOdcM/ataSE5PDbaXMHH6Pv7A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Pqtfj-0-PCqksjg8Z1Lv-g-1; Thu, 07 Mar 2024 07:03:43 -0500
X-MC-Unique: Pqtfj-0-PCqksjg8Z1Lv-g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a26f2da3c7bso64278866b.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 04:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813022; x=1710417822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDEgj1V2cjc85YaJq6bxK4Rqtu+HuPgKUTy4qIFCidM=;
        b=UMhe2evX+lRWUF+Ntc/I/Co9TbAx6X/gz7syk5AHbwrpBLJko3cNBKG2+ahlJdnZfj
         i5+XMNr6W2PrkA/OM9nlBaE3CgPODJ1WB+tdsLBcLAX4QZdp7sTk82GuhyuTh15azYnC
         O7InvzyVaVcNMlzRuNNWJdPk1ae2RYfWZPkYQA5OwZZg4zMu2bruO14cXqDkkZkzjSHC
         Xq7Hzg8jjtRApWM2E1lD1PohHjDfPWICnJs3JZDR4Zh9MYDT3bUo/AP1me5sR6y5gMs7
         kEhAs+fidIV2iPrVYob2OdGTCLimflAbQkUKS2GdarN3VFN9wPkBjLqHItAlAh+/B23Y
         u7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXM40kYuYU5PCl4ydgC8iHBkaZ0/Fj/CDXK1AuOryu1LgMuDwqAXVDYE3IDjurfHJ20VmAZMIZFPwx50hKslWOovTUi
X-Gm-Message-State: AOJu0YxV+GEvQoLwcbDXvcWL5HpmfmbxtWUHN23H9v5Cb/zF2R9CvloY
	FeAsLaHif0D56UkJBypqkF3C3ZcKkph6jZeA981EdInDoLphrXwJ+nVcugJHYGZwsvf8/xaEs+0
	3Ju/2Nn4xSkOsJUQefInFF52bYksq2maikwFj/sZgkS5V5NONjQ==
X-Received: by 2002:a17:906:248b:b0:a45:ad00:eade with SMTP id e11-20020a170906248b00b00a45ad00eademr5150168ejb.57.1709813022436;
        Thu, 07 Mar 2024 04:03:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5RvWzENV6+01U16kQloAf54kfAnKlJDOtXE0Bxsl6gER15VHdJFNSFH56K9QJGhc38Na2Og==
X-Received: by 2002:a17:906:248b:b0:a45:ad00:eade with SMTP id e11-20020a170906248b00b00a45ad00eademr5150146ejb.57.1709813022167;
        Thu, 07 Mar 2024 04:03:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id bx16-20020a170906a1d000b00a4588098c5esm3486946ejb.132.2024.03.07.04.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:03:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 780B4112F378; Thu,  7 Mar 2024 13:03:41 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf v3 1/3] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Date: Thu,  7 Mar 2024 13:03:35 +0100
Message-ID: <20240307120340.99577-2-toke@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307120340.99577-1-toke@redhat.com>
References: <20240307120340.99577-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The devmap code allocates a number hash buckets equal to the next power
of two of the max_entries value provided when creating the map. When
rounding up to the next power of two, the 32-bit variable storing the
number of buckets can overflow, and the code checks for overflow by
checking if the truncated 32-bit value is equal to 0. However, on 32-bit
arches the rounding up itself can overflow mid-way through, because it
ends up doing a left-shift of 32 bits on an unsigned long value. If the
size of an unsigned long is four bytes, this is undefined behaviour, so
there is no guarantee that we'll end up with a nice and tidy 0-value at
the end.

Syzbot managed to turn this into a crash on arm32 by creating a
DEVMAP_HASH with max_entries > 0x80000000 and then trying to update it.
Fix this by moving the overflow check to before the rounding up
operation.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a936c704d4e7..4e2cdbb5629f 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -130,13 +130,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
-
-		if (!dtab->n_buckets) /* Overflow check */
+		/* hash table size must be power of 2; roundup_pow_of_two() can
+		 * overflow into UB on 32-bit arches, so check that first
+		 */
+		if (dtab->map.max_entries > 1UL << 31)
 			return -EINVAL;
-	}
 
-	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
+
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-- 
2.43.2

