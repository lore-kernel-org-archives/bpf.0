Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CE347C6
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380302; cv=none; b=rjnTr7ZmQwUtAjvy9urc46C/Tq0jfjtIyKfKHdWleUgWDPcu7qAxBtKTBPfvZO9m42nvokguI5my8vzF04MqikJybDkPdLYV/+Gkq0MDgPcyHzLof/LOwYNK8y3IXMbf+/yoJKnbSOem5ZRPaU4aZ75lqTypGwXWzhkD+Fh2vOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380302; c=relaxed/simple;
	bh=wkNICcps7frzL6g557F0CF4WlqQPE6ujHJptwnsZnhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ7iAyHq4Y2AtwVv3kjvGevy7h601ae8f+O3g4xCJJ+6McMIi7f/N1NjOQHRuk3FtWoep+1Oqf0XQyKv8zJrwNkDjZBfWkJMtBF4g2j6TlVv5VpGINTbgwrxuNkxTA7TclzuWSgWmRab8X1mJ8G0yTtFaR7xxNYqugV6jLXza0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJXgiK72; arc=none smtp.client-ip=74.125.231.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJXgiK72"
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-4840f0c24bbso984340fac.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380300; x=1792985100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LB7CvF1E002yt3vp9WKk4eerqqBc2RjMT2aAVgH3Knk=;
        b=kJXgiK72ujoeq6un0zojf5HgTtplXMDDrrMi3c8X9Ll74uZ+FRakZwcCtCUD07lVHR
         7Kcw2s0oiCoqdAEBEbeLiK6g5H6uFZTn2sUWC2gMQZ+Q8Z93ifGF10mUUJz981FpPP/H
         X96PG8oAFWWrjGA/SAW4pQfEGsFRYhapnnOetnPYQG+3fgJsiklCfudrfojTc4M2t8MB
         ZNNWGo246Ac5QXTNkOvtGBDD1Ykboq5q1G902RTyJ6ATNoATHnYj7JTpdoL5YeAxTV0/
         v71CQsufd7yNWLY/Oqdb2Gi93bkwpCIfsubtB0G8DzVZFx257AEm7fmxujs8jXKUTcfe
         Fgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380300; x=1792985100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LB7CvF1E002yt3vp9WKk4eerqqBc2RjMT2aAVgH3Knk=;
        b=ZNfHYHPPW+yvdNyRQVS9HRHSsb7CTQ8gwv5nGQh4Vqx7gXBZeFaP+GsgNuYGxMKmVg
         khaUZ+23Hcb6VifMSQDczY1dzDciSksLTlEYFrtZG7oT8xjIVByj8gb0/n7UaAccu9dM
         Ymmpjw6cseiN+0lsoVGuXI5dAaDHrRibuJnZTelfq5aQbWcSW08XBdETyuO2i2BoxwCi
         Q3zC/b/+/WilpOkvk4DcLV7GlIlXpqFTwzSqCZtU0dEtHkR0l5opywpvzdLiHUL+EazQ
         dh0y4oGjQMX9749v/vw2X3B9hDoLnI0J8htv2Y14lc/fuUqOzpoWu/vGriQX6bVIzPZ4
         LZBA==
X-Gm-Message-State: AFq9FYKnb9xc4C8ogXsLIhcJK4FlkhVzcKn0DChLGCYyNWiqpqUCv/cU
	wq4+58Uiueywy3qNlJSMU78ML4Tpi4vs694zD+AFsznPTRX8Lvb/DWvjK54J87d6UWA=
X-Gm-Gg: AYBFou0qU9yBDZJ65txxh40dZmz1JN2smgdPfnnTUDaMwCrnTMYQIdaeJThrduqzaJ3
	4o9bbmseg1N232yv5ACyy7nA7HtWE6EWqtMg0jFgDoftiXZeA6C/vPss3ExCAdfjGOPfQV84tKg
	SsSdt1BtGRvyJzP80fzMkw+AGNOZ6M4naBVrrLGyLH/LhLUUvqvkAfqWev4yMr2513CfkeDYbWw
	3aQ/FrQ68vDMecbq5myu7Q/DesSBhGU178Bx2Veg38XBH95d+4w7VnQy/CzC+I+acgaMlAOwVOj
	XsUHAKhNhSSPnACCc6yo7YEbBG3OsrWVPKAiTrL4PvWq659dt1wo4maoH6sqbfwyOOjpktY51sR
	HIHtHmj40P3GRrzjzLPrZGiIcE7AMmHDMjWRWhh2DxKKI++3nVqIi8pTiz5Kr3q9ltuG2WTt7WY
	lmMPtjs03P7XUmeLa7+roAPtdxcWBBgccY7zem1tNN/FEgKOv9sFuJj06X6or/upf/B0SmzemL5
	uCOLXjBhKifTmG0IrJt+e02Zf05ZvVqBu3rq27TtD2mDPJgTCH9E2/ZZutKsdo5JXDphRSPkdBb
	Cq8XAw==
X-Received: by 2002:a05:6870:b3e2:b0:49e:45d6:feb0 with SMTP id 586e51a60fabf-4a75789dc38mr5371678fac.20.1792380299715;
        Sun, 18 Oct 2026 20:24:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b2dc362sm7904828fac.2.2026.10.18.20.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 14/16] libbpf: Render the arena type tag with its address space
Date: Mon, 19 Oct 2026 05:23:54 +0200
Message-ID: <20261019032401.2302823-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; h=from:subject; bh=wkNICcps7frzL6g557F0CF4WlqQPE6ujHJptwnsZnhU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr95Pzw9mt9//kahxPy3G71l7NKt9Gv+l841lM8QcjnXZ nFrXUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIm4zGb4p9jHUL9ld0lWldHNuYeCDQ rz3neec9cK+v7tWb7p5YjVaxkZ1oaXtFhcr7Gqfh7g2TmtonHlEW3V19/3uanX9nVa8ZnwAQA=
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
modifiers of variable types and never carried the tag. Clang without
casts between address spaces still accepts the declaration and only a
program touching such a member would need a cast there, as it did for
every arena pointer before. GCC has no address spaces for BPF and warns,
under -Wattributes, that it ignores the attribute, which the selftests
build already silences.

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

