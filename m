Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E521420E6C
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948598; cv=none; b=X2W0Vbs3PnHHXTpq6+ILdUzq+6Zgv/5tLANY4TTUeQYzvgj9JEwVAIXxUJ4b9KOiTFbXtFnT8/e/30qiNcAnP9hEm+HV8X9jgsdHvoBNQTmapYtkg104u4UzQnDmtahyUs9AwFCL/gp7kNLaqj/KSZKX/6asO3Y4sJd5vWJw/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948598; c=relaxed/simple;
	bh=gkPtij8saZRgAahhMThOlUWUpVh7SsZyL1UOtnXMLF0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B2TAdB/bZQ8qOlIJxhjeICPNRXfhVcpf5Mq0wqv/1jXgdUZ72fg1G5LfXvN0/Eg2uCeJBOjXSKPbx54Hv5G6zXM93AyZWfRkV2ZU4GeziuZQLU76EcM+2yKRAM459U9NJSOX1mbdo4NRXw6wUtoiMQHGtkU6nLmc36GIhgt5iFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=none smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=YLBgpUsj; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="YLBgpUsj"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c999f162c9aso1733252a12.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1783948596; x=1784553396; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvNHgh5W7s/63zsAYDOarIm7l7DKKEyod/RpiToacD0=;
        b=YLBgpUsjCCNQHhPNvsqppBDlIE33VrtIxpAiTbvL9BCtJiDT/LjGAhv8HSpN3T4xKa
         sqeHkTC0PjDaa/zzH4zWFjhdBb6byj98250bXKMAZkdPkdGK0tItQa3NUmVLb9OTRTRH
         3EYT81A708ilSdxfPFHkO6RrjSo8eyCGCdvt7FzPFt2RVAi7MVCyjOmz3jRDmp3B2QTr
         65F3Tl9F2Izeiwfk+brDi7Z3PRDbJZYYEjSAhb+gHhIvTS8MOuM75zFqhhjRlExdDTrm
         9ZmL7VJhZDEElc1aZUAJd35NahL2bZv7GXX/R2LeonBB+QSdXl6HJOO+dm+n9VVoEFeH
         vpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948596; x=1784553396;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LvNHgh5W7s/63zsAYDOarIm7l7DKKEyod/RpiToacD0=;
        b=b+3HvJsOK0lUyTKHfG3A0c/TStBRg4LRyHjzOTlBm/JF3JskoT2o04A50qMkcRu/O1
         eL89JTo4g3dt771Nbp0r+8GNAtlU7g36hcEV40XrjbJZOzOXp6o1d3xGqO0zW4ZIpKtz
         EX0jlpD2MZ8S1vrFsCVTebMcOEqMs8HaYO9zlUYs3uMXNlVD+zmcfGftKr39WlLfyURk
         7iBFbZRhtobUv6Xodof9YAnFQ1KM4aDmC1xt8/Q/F6xBIv088z3ymg/LGeu0dr6i5tCB
         97yCD9ca+1mTzwJn79hT7deldJevVP8lVONlNkRiTGQgRNxjCBKSdOpNRyk49qrppX1e
         1vNQ==
X-Gm-Message-State: AOJu0YzHCTKAw+VhCPw1SUvlGGUrfBtr26uMNnAtw8Va53RuQzihJCcu
	bf0ozXD47akEYiPFg0PJfVV5kQpcwY+awSlAICNeWMnxKP4egqcIsqsOJCHXgldDslXSXwqxqUP
	AXXe/I+H7BxQ=
X-Gm-Gg: AfdE7cm2BCb3YaDYR5+0HDZ0XAP9XMAu4e/+4A4fCOwTqnqpcMlaJrEa83zYtrZB83p
	REmzYVzMiOEQ0BV6hiDSNQlWP5S34CtLTHSFsyImVuldKzCTjtd/QWtHsUYCr171g9pvAKgjfrO
	6SIzEBxi5S7QMmVVAr8MGxi4mnLhOX0436RIyHk7KUQK0rBWngRkWiA9lX8WPlKiWZ1bRa3dNV4
	LUw8NGN4L7ompSv2PmVABHH9TwMAFk/9SXGtAoQG24VyFvMieK2qjPvjB0REXdY4qcX4Nj1pTkZ
	rtvgh1/HP/sO+KBYk0XsJ2BHCtDgQ513zWfp3NxLaukrztzd/6aQDwB4nZ0t+Vb+2Z4pKV2aahs
	HPv8PgnshQDJae9oFNyGQqaEhDbTgY50igvQ5HwEnaIzapIgroqJvSPq4fbFtmAeHZuIrpKYwWg
	Le2RRPzrMegjYFUxRsscgTwwWyQWp9iX1z0w8s9RB2PN1FWtZ9P1inVImKqWyqopZkV1NqB9mAf
	cueQoE0ffP0xTgGqNVM0Y7ytnUQ+ugYfa9tRHIXdoAub8AOC1nyu+RNgIHv
X-Received: by 2002:a05:6a21:4593:b0:3bf:b182:94b with SMTP id adf61e73a8af0-3c110a1935bmr8647088637.6.1783948596375;
        Mon, 13 Jul 2026 06:16:36 -0700 (PDT)
Received: from 169.254.75.85 (ec2-3-108-4-54.ap-south-1.compute.amazonaws.com. [3.108.4.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ba45b7049sm4624261c88.12.2026.07.13.06.16.35
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:16:36 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: bpf@vger.kernel.org
Subject:
 [PATCH] libbpf: reject linker STT_SECTION symbols with out-of-range st_shndx
Date: Mon, 13 Jul 2026 18:46:33 +0530
Message-ID: <178394859382.2.942623981274846749@digiscrypt.com>
X-CodeOps-Marker: da2b6f4c518044acbcfe3bfd66b54170
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

linker_sanity_check_elf_symtab() only validates a symbol's st_shndx
against the section count when it is below SHN_LORESERVE:

	if (sym->st_shndx < SHN_LORESERVE && sym->st_shndx >= obj->sec_cnt)
		return -EINVAL;

For a STT_SECTION symbol the following check only rejects a non-zero
st_value, so a section symbol carrying a reserved index such as
SHN_ABS (0xfff1) with st_value == 0 passes validation.

When a relocation references such a symbol, linker_append_elf_relos()
indexes the per-object section array with no bound check:

	if (ELF64_ST_TYPE(src_sym->st_info) == STT_SECTION) {
		struct src_sec *sec = &obj->secs[src_sym->st_shndx];
		...
			insn->imm += sec->dst_off;

obj->secs holds only obj->sec_cnt entries, so obj->secs[0xfff1]
dereferences memory tens of thousands of entries past the allocation
(reading sec->dst_off) when linking a crafted relocatable object,
an out-of-bounds read that faults or folds unrelated heap contents
into the patched instruction.

A STT_SECTION symbol must reference a real section, so reject one whose
st_shndx is not a valid section index. Reserved indices are always
>= SHN_LORESERVE, which exceeds sec_cnt, and the in-range case is
already handled above, so a single sec_cnt bound closes the gap without
affecting valid inputs.

Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 78f92c3929..8a93faa41d 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -973,7 +973,7 @@ static int linker_sanity_check_elf_symtab(struct src_obj *obj, struct src_sec *s
 			return -EINVAL;
 		}
 		if (sym_type == STT_SECTION) {
-			if (sym->st_value != 0)
+			if (sym->st_value != 0 || sym->st_shndx >= obj->sec_cnt)
 				return -EINVAL;
 			continue;
 		}
-- 
2.52.0
