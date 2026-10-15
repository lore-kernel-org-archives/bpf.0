Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6EB4FC339
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107734; cv=none; b=bRI77cBnbHpbL5Gl3aWaU80fyFPDJFcI4cqutExPLKrkit/QhexelmxB4fuHaorOBEk3Jq8g8Y709COY/ETDN56TfYgVNhkP1HWGTvBisrHZ/CQK28fgM65CoPeFf8lCXjgNsgO1P94nUKBuOKPX8oV/A9y0euVqLR6OwEdV6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107734; c=relaxed/simple;
	bh=8SMkAqyj4XDGjwe99QC9Meej2GWQwsvGXdhFZXInRFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hU0DD++mlNtEK/IJogXKKBRiD2ZP5AEwp9PXUvmvn7LbO0q9opq5S6SVXonvCzX7DMjbHWjg7KUmDw5qmgrv3TzZ3O/134iiv5IoXcp1FWP2pgDcAAED0fuU30EtpLguaXWFpUKhEHsFGw8/+JQuJVcD3umU6oPCsfMlCB9NAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da3Yi7dW; arc=none smtp.client-ip=74.125.231.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da3Yi7dW"
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-47bb3ddaaf6so2667737fac.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107732; x=1792712532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2TA6s7HNT6Ke3bahJ4TDSgpdNnFuQbfCaq5PpS6jqU=;
        b=da3Yi7dWe6ac+t8UnGF2ozqrSH0V1/kQhAEhz4SvCPmqZzvCZNfG+FVlq4co6vkJ2H
         JBpreeZ/RcVE74A/hs+lWp35mTO8F6Gkq1wFQiJ2YKTyNQtph8BrrP19EKUNEn6kgQ07
         WDvHfI/z6gIKPz9XcuPbYmlF48wvHwaks2/rKhRNgelXLCtsz39dLONCppWhOw3qUc0P
         S26v0F4RRMbNSeD/EwGdMF3MSrQcdwPbW42YYymS9zE3wyStkkDafz0BvQSXlu8NQQvR
         WQZ8buU63mQf0ymQSRX2VK9HE6QVHEBKFKbiaaVpwNmYyLZe25dWhms3a7Nw6TuEp6f5
         8RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107732; x=1792712532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2TA6s7HNT6Ke3bahJ4TDSgpdNnFuQbfCaq5PpS6jqU=;
        b=CbJPMOtyPlRUa9fx6S9fVTBuYQDuU8GrYj6+WGCFsoUJDRbGSy5gDuIi26g9AknhLp
         yNdGvV/5Nfvn3i3yxjYDbxxA9V5d8xrQSV0J3YT23555wsDJ6qrbT0r69kKCUv00MOef
         L03+yIdDV/TN83i7bIrmRgXZaA0Kih+tzyeFW0ydfwfKSqup9MD4aSczHiNHObzYIQH+
         V1+0F/vgnVluqHX3K4FDzVefEPxUmWX425x0qGKB1MmpwxCFBhaFGKiwL3rz0hg5Z4qe
         RXShMUiw7o822CsHi9TW9pjSmVRyhHiVVCU2f+k6ymbyTSFjU/JvIzz75EM4p/Dbzm1g
         gOng==
X-Gm-Message-State: AFq9FYI7IyjCFlSU67vypJ5MrPFgOQJLtx/GLMI1p9m4X8mxXYrWLdku
	DZ67a2DNJrsFzTlvTPTbij02b6J0WxXQUc1jGwva+fjS3KUiT8E5VbGrrFXFPZW49As=
X-Gm-Gg: AYBFou2A8UDJ9vAPPJy6xI66FDH1zwORcgl+a6CsChIGJ32ZPweNBoXeEFN8G9zaSC1
	KpVokMkWAJqtl1gUspgkXxvkVHiWRXBhiXuUjnkjeVLbiziWD/IjTMlDy6VOHcvfxOsDMtFh4kl
	s8m7dMNBpmQyzr2vnUnLyGm/dofpBWYnWxs0UPavp2ue0L/sqlRQMZpiY1+AwvIbPa1wH6ioe5E
	rLm6uDolA6SdI11SfxOubn95vS+3Gqa8I5rGETkIYouVI5t8j/mn4BUm0O9PrPsnVF7n/X9dsBM
	1kw0ENFw/lg7C6/iLGJd6QqAvQDWySYSm+pcKlqBtQww/vBHQpq4EftqiLDUGoRQeitKa+PwULF
	6MVicjmsPVq29M/v0Nu92XmaRmnEyi06fd15eHvmkL3+y06cKO7nKB6lJELY+ojuzo49Q/W3osS
	uja50DOuCUip2i8YzVc7ZA/XXuhIjR4CnsDg5b/kTpfS0b8awxPGwWJFzrfJtZ99vPQrS5L/bNM
	Q9xGdA2XlnMW5Rs389NwvA1JbMmBphlkJlQoAt2vcArKSc7kL3jayKBa3VVgV5YqMyauKHoTx6s
	zKWL
X-Received: by 2002:a05:6820:4d0a:b0:6ee:5e5d:160a with SMTP id 006d021491bc7-6ef102950acmr15212181eaf.51.1792107731902;
        Thu, 15 Oct 2026 16:42:11 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70190c1c106sm528199eaf.12.2026.10.15.16.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:42:10 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 13/15] libbpf: Render the arena type tag with its address space
Date: Fri, 16 Oct 2026 01:41:19 +0200
Message-ID: <20261015234125.3152346-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; h=from:subject; bh=8SMkAqyj4XDGjwe99QC9Meej2GWQwsvGXdhFZXInRFY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3JvDdzjkam8F+r9eWntnr77ccSnR0tqZe/4lno66cP3Y sV3uHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIDFZGhpaW889srqjw8eeeOZjEdp xXIWHy3F1mOzc/eFn758Cp2lWMDD2b+7l3yLwQUPml81Cy5IHrlMr9Z0WqA6ue36zZ8P9YPgMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A kernel struct member tagged __arena reaches a program built against
vmlinux.h as a pointer in the kernel address space with the tag as an
attribute, struct scx_cmask __attribute__((btf_type_tag("arena"))) *cmask,
so the program casts it to the arena address space before dereferencing
it, although the verifier already hands it an arena pointer.

The tag denotes a pointer into the BPF arena, address_space(1) to the
compiler, so render it as such: __attribute__((address_space(1)))
followed by the tag attribute as before, which keeps the dump faithful
to the BTF. A program then reads the member as an arena pointer and
hands it to anything declared with its own __arena without a cast.

Nothing else changes for consumers of the C dump. Skeletons strip the
modifiers of variable types and never carried the tag. A compiler
without casts between address spaces still accepts the declaration and
only a program touching such a member would need a cast there, as it
did for every arena pointer before.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 996e61b5f11f..7dedd3975c39 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1595,6 +1595,9 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 			name = btf_name_of(d, t->name_off);
 			if (btf_kflag(t))
 				btf_dump_printf(d, " __attribute__((%s))", name);
+			else if (strcmp(name, "arena") == 0)
+				/* the tag denotes a pointer into the BPF arena address space */
+				btf_dump_printf(d, " __attribute__((address_space(1))) __attribute__((btf_type_tag(\"arena\")))");
 			else
 				btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
 			break;
-- 
2.53.0-Meta

