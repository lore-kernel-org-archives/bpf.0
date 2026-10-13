Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE73BE642
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879659; cv=none; b=c7zH6z2NRFtspZjRccDkszosw/Mn2Zgk2p0SFwZKk1MhSVeBEqzXcWLVn7NTUmY0XI73avbNwTUnVDCWQe6u9IyFEIDjH1+M560sa0plr0cpf/SQAwxyTBl76wDdfeVmlVD9VLlDU9y05Q+Z2BRgF/F7EJ2FW8KR0kG6CklxUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879659; c=relaxed/simple;
	bh=8SMkAqyj4XDGjwe99QC9Meej2GWQwsvGXdhFZXInRFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1qpqjOmazPDzuW66EOklZ2BbC0XQ6rpLIkwiMHjwHGOTBJoxC6aCk7pIelyY/afLZb9hqKJE5l7J+4uTNVVi13m3hXssSc5mD6Z6kzN66LHJmGiH9RQRJ5kR+/w0+izx1vCk5KFexfhZav61O1eUyeWrmKIk6DEZSiuwwk5Lq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/Vny0qb; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/Vny0qb"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-451e1066971so1277074fac.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879656; x=1792484456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2TA6s7HNT6Ke3bahJ4TDSgpdNnFuQbfCaq5PpS6jqU=;
        b=W/Vny0qbcC45b/rokagyX6mKDASbnNGqaPjL+jJqo71wx9pQfWp4T1KbsOfgKwpzEt
         1Fl9gNHCu/x/4mdUX3sKiEWNaiigOiWJTLJypg8lpBJvJnLN7JT8jyDH0+aem/cA3yZ1
         N5rLdidhhtiek7w1k7QrrNHyLE+y6cGPuFqlGDITeSFX5v0WCvrFiEpaNS2NURDdJZXw
         X8cw+dbbEI4w7tS/5FzediznlLRxRRpMB4d/YIsltUUHGaAraX120DVorNLo9uzFCTXu
         nQ6nOJtZ3pF1WVG3A1QTCxJ7DF8ONSr7PmHrO/pqnpCOw4OnXRuDMVmt8CM/ArHb66hA
         SAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879656; x=1792484456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2TA6s7HNT6Ke3bahJ4TDSgpdNnFuQbfCaq5PpS6jqU=;
        b=gmxv8E9JCsKRAJvb6KLqdaRntcqdAFRQ3QAxGXHRhdZ5MszKTZRGlxgGSXrGDiqUzb
         hKWfUuBJiS4vwbC2YMH6QvkXUK522pxvO+02fVZJZw4YtjND2Ww7k+BlozvzoQVKLO+9
         mgLt9AycNMo1y7KnGHP2Ji+tVu/lKb6MDcdg8afIYHM1sXmjT5ZR4Od7WPmWByowcpyN
         cLphowj5Nag8WUFqz7sWr3y0O10PFhp4fMwoHXMwmdtiuYGUrCNPBTzDMWzs90TkGO9X
         RRL0GjIF9ZIkOLtQpDZATFpbsk26RReN9dPtYy2/dXg2230yhlMz2J1RoB8HS7Macn70
         NnQw==
X-Gm-Message-State: AFq9FYJ2mP824E6hOCVN3/nHCzUkjhLcvdBRnDDUkel0+Ng7QYjTHqix
	SMBMluYbANY2gEtdDdXOQcY0FKrA6EuBJ2ncFUiy9aFH4JpWOfCHxTVZJ4JyeRaIwyA=
X-Gm-Gg: AYBFou1fhtOvKGNdDR3jtdR11XZ0GUjC5agf8lz/VFLvQswgOXpF93F15QaQYHiejFK
	nib+IuBoVCY0tuSoEpWnj/W3ZZYqhsexOGV88vBlow2TpA2nuz9D7CrBhMR3qdzi7AqfBz/WKdW
	RBy7iqfO1JwNK/U+at2zuqtKmjMpPoXEtPQ/novascxlY996etkmPLFwe9W9DRpQ7DN/78bPQ8N
	DRK9imjkuFtWeFcvqpdk3tvUgjqu9IwFYBhAGNt3LPNprITOWLTqQUagoKeV+SDAc/IprAE5NB0
	h3KIEv2fnCoZIU1B4rfOZcj9lHf/kBMHAygvNtmM4XPsWPA0LnSOSGgyK+txHapx409xAPEGZ2h
	UJtIlJbMenzSYdBSpRImY1p453083q1kkiuUemonAYuk158c8YLGx3TB2YWUg7kjjzAi8NmOevh
	dvlbrtUi6lOHWki6XQ27EjEwY1WhyQQz+NH3yxPAKSXGt8wxt6jOCCVXlgdgUN3zvbI3BjsakBJ
	Zkmy6Cgj54DnODgmr/9agpIcCR4G3gIKqcEG3D8E0ROJ7NUjFxwkcpHxOif7RCcEeYY+lgXQLf2
	mB2jrQ==
X-Received: by 2002:a05:6870:2486:b0:49a:84fb:a685 with SMTP id 586e51a60fabf-4a2a81753eemr10342100fac.0.1791879656572;
        Tue, 13 Oct 2026 01:20:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a822ef24sm11028352fac.2.2026.10.13.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 11/13] libbpf: Render the arena type tag with its address space
Date: Tue, 13 Oct 2026 10:20:06 +0200
Message-ID: <20261013082012.1107446-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; h=from:subject; bh=8SMkAqyj4XDGjwe99QC9Meej2GWQwsvGXdhFZXInRFY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy/mH73DI1d4K9H+9tPbOXn2541KipbUz9/xLPB114fqx Y7vcO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRzUsY/hme2fU3o9Lzg8BLQ/Nwsc UxVudUzA/GesonMT/b/eniHQ5Ghv702msrRRMN9n9+Gf6hiPX4jfrHHDdr3+8NnKe5//ydVkYA
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

