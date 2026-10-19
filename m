Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4F4F5DF4
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416173; cv=none; b=JcJVjazKNhWkM6MkdZU+yeLHpVmPefcsmJOAlc+gJmjqBNc7L5peeGxMMIcEKvDQy0SZDnwE1JfuWpTPnm77c77upDAWV9RRKJmythBfNd20cX3NP6+y+M1OlnEEb+5sgLB3swzEYbXZfFIxy0Jnnt+TYy7HjlEHJD2OZncfCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416173; c=relaxed/simple;
	bh=wkNICcps7frzL6g557F0CF4WlqQPE6ujHJptwnsZnhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LF9zc4Rs+nS+Iy23kUr3gxZnE/0gBtFVSIC8cg4gXys+9z0tHAom1KzsdfuON3IvN6v1COVmcoE4DMoaKkevzPo4m3Lp6Iwm2ijJIXnsED8L/dESw/4R5qfrW1vnOiKRsY711e9ltstsZCFi2NGMD4XYMHrMQ1L+Jl5epUa02yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pz2D6QgG; arc=none smtp.client-ip=74.125.231.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pz2D6QgG"
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-47bd4bcc3e2so736329fac.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416171; x=1793020971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LB7CvF1E002yt3vp9WKk4eerqqBc2RjMT2aAVgH3Knk=;
        b=pz2D6QgGYeJXM8NduvWoJ4J5SPHY5kwmInQfiJd3SoqJb1tWBi+eS97FGBBxjp9jqc
         ZY4yY3FvCqPZJt+Rri8K3s9yOB2/SqyxRXUOHqgISUkDDgGbeG33V/11NPdxhWwuLoY2
         o29LDkumBx1R8hJuCybiCoRr9XA6aDlpSzDXdEkMyg+jsTHUxbZ9EeTRran8xFwk3oqR
         B+lJ/r6RNuetrzxlaCmlBM2Q981yDsH21tOSiMwLg2iUexNZya+uJmgUAp2ZyAfj8IrQ
         +vzHvlfbbYhZZOV5vw19DZtBBKnoeNO35DThcZ5Gdyeo5+9MexNqfqUbePHkYfuk7Az2
         2zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416171; x=1793020971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LB7CvF1E002yt3vp9WKk4eerqqBc2RjMT2aAVgH3Knk=;
        b=mddTAJC5n9avEbdO9K1leii5ENfa+1tEX2Y2U0Jd7gD6I+w/ArzVgF49UF804J86H9
         6xKXo38HGWlt+lTLk+nQ3ZROHKCEaDXlKtI817XNkzwL5hdqbPKqB9G1nXOtFYnH4lfr
         4rKv/APTzktYQrXjZnOpx9xKlxQWCfmJdqObxbZfa7oQyiNNEvadjoEbDZIEKfSvnhPd
         wYcARUcMfkGlNdfKQbgTM6nSvcDbTU76fXhDxwPHK1yg/EvYas6Lg0L2op+JnJ97Q437
         jpQJjRB4+RugcWyTwtJ/Gi6vW5XU8l7QpwmYe76X0dgrG1zBJa506NYAEix0nQ8PQXFL
         pY9w==
X-Gm-Message-State: AFq9FYJ8rgzllEMF/5hNdT77GZI6o0XeJ49H9m7xGuXaJpkic9NTM5hR
	YYOpIZISWMpT9Vv+5mybHKi28kpX6u1WDmjgGf8lTcGO+oVLLwE6mYCLLoEzEL5bjyA=
X-Gm-Gg: AYBFou3idZxMifIS1AqsKhDjE2FINgEVZQ5qD+Drje8+ruPDC4dYcDJS7ZjEU56dSbK
	VIGmVXS3CG5pncoHnhRA3oTExaJpfG36vBcrgOKbJBig1n6h01LeX2ik3HGZ2/QBrvkbwyJOprZ
	jGbcwvQK+Wwz1pM44S0+KWZ30Qmfx2hhptqd/fQ0/AubpgVJWi+6uW0ZprvacJSVzF/Yykw512W
	sG26HiIR0Oftkt4S+BQ6rDGZI4fYntYxa8GCuzP7Rnh5ZPn02pVmcaqkdAxrvjJiz/Mfxv9dhfG
	cKbg8odCB49OfnNP58/ldzuR3UH9TdAPJ9XlGdS6Ux3BmKoeQB1ZX/NhqGJGbOLbe+/bdddJXVv
	GWdfD8ck7Y6470xcJbP2bADsdo2TP/KDMwvBD3DwNHIhmaxIqPn+244Q3E2M6ZIgRcUvpINGZ5e
	yTp3W7AExIzdQNFNgCHpNZf7aIEaPju349nyDcZqlHrs7/BSBCGlLfUzYaIBXjPqOnEj8/UVX0K
	OZurm+l1HlVXJQ6P5qNswK8TYwJ98Ro0Zwp/EfsEs1VeOhlqTXZmP60faZp0r2ct6OxrcOZhBWm
	fOx+qw==
X-Received: by 2002:a05:6808:2e4f:b0:4f9:bc36:fc5d with SMTP id 5614622812f47-53ccd5e2a15mr5605995b6e.35.1792416170643;
        Mon, 19 Oct 2026 06:22:50 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5397b4ac6c6sm6899731b6e.14.2026.10.19.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 14/16] libbpf: Render the arena type tag with its address space
Date: Mon, 19 Oct 2026 15:21:56 +0200
Message-ID: <20261019132203.3034698-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; h=from:subject; bh=wkNICcps7frzL6g557F0CF4WlqQPE6ujHJptwnsZnhU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxNGfnh/Mbr//I1HjflqM37P2aFb7NP5L5xvLZog5HOuy ObWuo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPhFGD4XyrRpf41I0Zh7ilNHx2dr1 LTdnPXvNXK/2KvM9v4+bHsc4wME4pnnMpV+qN/8duPyLxXvI3Tp9S/i7vJsb1YWJcpweQkDwA=
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

