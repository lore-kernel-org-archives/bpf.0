Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0741167F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511424; cv=none; b=QO0y3wX1ItUgcQkcnnKqgUbyY8wbVPJM1ddeaarjE6kW1YEchTWZYBG+8lj9LHgpTNXleonNnV/y56EihZaFU0ILYTtX0cY1pjBk3VBX2ACD/q0RJ7/quQo3+7yc+DpVcaN8rXHwfpl12aS6XTwOcJwPRso2KG/84wDe8H3CnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511424; c=relaxed/simple;
	bh=DHGo+nMhwLb7jF36KxW3cOWZ2EkkCRxXubrUxi275uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekxtUQaj9Yw6XTVufQjpAtrY7U30jvG8AbnyTE8pTV6+Gz3cEh31j1SRNQI7QvUNdK+rE0Ho7aTnbpH4Dy+C7JjKRLihErokGpTOclF2RDT8/XS4Ku7LmZwGRbHmQ5mosydJGBay/FMvzzIdPEWzIdNXkYKa2tHZTpV7gkdVxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2ucNntb; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2ucNntb"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484349b1961so284676f8f.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511418; x=1789116218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnl0L190XFrilVSAmY8S3ZopotWsd7P+T81I3TNIBtU=;
        b=G2ucNntbRH3GnMCAxDpATEiOc8JmJbpdjny2StjzMfXS8Kipfj/du6CgRARgxuPOZ2
         GDiSvrP8aWdkhfVjRKSH9GTA3gA4Ivu6OZojPaJttZeT9AEoK9swqx56VwRf6rA1WFUN
         buSYe5VGuEjrkLsHpx0zs8Rx8g8eHkDx2fPGmVKx8EMYnvT0VbEDX0gtjG8itTagZ0Bg
         ++IeI0MHJBtf56kN2z79apPJancsgc9upF5kcIF9F8eVQaeDsrz9zytxQgnON4MwxR9e
         prjQpfkMmhntP2/R+9DyaZf8ooA6QkxYzBij/bxU81rxsODBbkjgskgvfI72IznHl1Bb
         rQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511418; x=1789116218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnl0L190XFrilVSAmY8S3ZopotWsd7P+T81I3TNIBtU=;
        b=rcITKAwDBNpUec0p/CS9rgeZ6ShZ7YL87Cy9efmz59R0DKOYrMmXVcp2roagRDjmSD
         ntk+OoaYueNeF43WHYlZ18CjxyDP7/qBvv9bPImGhI/giA+SpDbPD0ksLZLvlCknJr2j
         8P7FHeDkPie4+O+uD/KnkssoJrMnr9tZYaHu5il17FZMw/X+C7DMd9B6CrcoNqwDdf5g
         SwVYyXNQtlEokdgEGPzInFWgPxkMwbV2BZaoCfoleT4Yn9jzEdyp3RAPPc4X1fnrptXl
         5fRE/6+2ysmO5QsCXAiyNSNCFY5nlF/urZNzewdxnngAfvCdi4or4pa2bnE4JSjOwaBq
         HbsQ==
X-Gm-Message-State: AFuF++n4F1ux+Z8d3SH0SxkYDH99rUrXeH3pBq4oq4wbYRW5eEQhAqgf
	f4uwAuaZok6GBzo4iRfd3IVf8Cgi0+Q6l7b00nSbO4hNUA6XJVmAtezwloGlw6ty
X-Gm-Gg: AYBFou2QRCunZ1PHxcJqHh8Ipl4z9et2iQpEc8OhUgId82ZnHMKeFTokqX4UF3uSRFc
	ehzcVdacHXmKKos/bYG5n+gQSEY/cDy2+iPLsseLL1uafx3FmyWhbOZnf1hUjffUhVX/ntYbTif
	RonymCSTre1CRXCSBb4X90voW01LVxK3jwIOGREygUQdmJILSDAIL0lDpm21I2A9JI3cAboHoAz
	bWs36/oTRs75E9veg3CUOb2kE1M2JYfd5h2ESGekd38Bme0XPU/xEOzAj4YDI7q0N16Z9y1lp3E
	OutlxLP4rvAvH4ixxYOKWIpXSu8empSbz4fSkIx/e3SyS8B0HZYUG74XbH8O9FCeZ3VHs6ZMM/X
	xTl6tLXxSWD6ZJtyvkBkKC1UMvgiEbysb8DPDuy4uL00xygMzt2W3AiYF78onrQQT32HxOguLGs
	mA9KZVP43BmC74gCD11PiwcRDEP3I6arErl49RL3aIQSsoca0yyb6O6l4tglznrEOoqcTiipezV
	0ZKpgoxRq8MyDjFm06GGcKjZWQpbWiklVXQHgCxLB1xkvbCL2Il6HZ6+LEDJlRvDDSkdRmiByBp
	794ZOro/EiUzSMrp0BXUJp5qMsY=
X-Received: by 2002:a05:6000:4b11:b0:485:8313:9f47 with SMTP id ffacd0b85a97d-48587055d09mr9751351f8f.10.1788511417583;
        Fri, 04 Sep 2026 01:43:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm4878527f8f.27.2026.09.04.01.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 7/8] bpf: Reject untrusted allocated-object pointers
Date: Fri,  4 Sep 2026 10:43:20 +0200
Message-ID: <20260904084325.52250-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904084325.52250-1-memxor@gmail.com>
References: <20260904084325.52250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; i=memxor@gmail.com; h=from:subject; bh=O0xbawAqnBylYPa9BBYqUadEoCJXb0J5+JGJNj8vDJk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtWy+SnZetvbmi1eTnh6ZKWjydXmNavumCckH/Yur7I/ eLC6U81OkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCR03MYGeanLNy0/+7P6x9M /+8KM7lyz4I7cYZixga/KcYvT7WI5u9j+Cty4oPkD7ZNZdcr2XJuecvPE3ryfFpP9uOiUpHLRmt +6/MBAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Ning Ding <dingning04@gmail.com>

When the final RCU read-side critical section ends, a local kptr is demoted
to PTR_UNTRUSTED but retains MEM_ALLOC. The pointer may be NULL or may refer
to an object whose lifetime is no longer protected.

type_is_ptr_alloc_obj() nevertheless recognizes any PTR_TO_BTF_ID with
MEM_ALLOC as a live allocated object. In particular, a refcount-only local
kptr never carries NON_OWN_REF, so it still passes the
bpf_refcount_acquire() argument check after RCU protection ends. The kfunc
can then dereference NULL or stale memory.

Make type_is_ptr_alloc_obj() reject PTR_UNTRUSTED pointers. Since
type_is_non_owning_ref() is based on the same predicate, graph kfunc
arguments obey the same live-object requirement. Fault-protected reads of
the demoted pointer remain valid: writes are already rejected, and read
fixups use bpf_may_fault_on_deref() rather than this predicate.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Ning Ding <dingning04@gmail.com>
[ kkd: Rewrote commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1339c2f028db..36b65797877d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1381,7 +1381,9 @@ static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 
 static inline bool type_is_ptr_alloc_obj(u32 type)
 {
-	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & MEM_ALLOC;
+	return base_type(type) == PTR_TO_BTF_ID &&
+	       type_flag(type) & MEM_ALLOC &&
+	       !(type_flag(type) & PTR_UNTRUSTED);
 }
 
 static inline bool type_is_non_owning_ref(u32 type)
-- 
2.53.0

