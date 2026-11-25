Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582121;
	b=FrLZykLfMt2rmLOpQemlEKza1+52+b+nD4JoMuP2FPAbtd/uHghdOgF4aZpR/YZtJfH9
	 /sNnoAL3EmLBXOsUJyrvYz0WZ6ogkA0cF3vcCSyB2MpoGMOsE/JgRwprBRFUl4rWBZZld
	 xwJSqY3dXJsdroQqCE7hIYpwk0ulWbYLqtU0hGbb0MASogNw2PTbkFvySJ8P8h20Ibjc1
	 A4ep15eH6hbyGSeOw9pFfse6HEVPQA5mI5UDkIS4KlrhMZfco/Ml0c74EU7r5EpesTy05
	 8wCxi+bZyoOj5BIcnYqTWs1RAGHvu8k1jWoWS6zfjV7oEjbTe0wpC5vGuhsyjjG9puw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=ibCE/HqS/x5d7xPsRoXs/I+gnefhANY9+jawDpdhc1o=;
	b=KAbGeM42DmrPmtQSNHh7As/h9KscgNr1boMv4RdqgeN3E1lFewowfUbN/bqdhrj/Cof7
	 upfw/PJp1T9Jj5/XUVu7Gj94mSbRBXkKe4fO4IFt/7pT1psyqHZEjhcr0zxE+T177zfdt
	 tXo4TZV+xYP3uKIOmt5DLsapdAe8I0gbta2chKsh6FVREonhEf2Zza97BC5Ac+aRfSkbJ
	 +2qLVAildR1TOR6eih0ccFidF/s38R334UHpgIsFQ6mnnIWtmTIJzatvPhxxBchIuHSuk
	 TJ4p729MPkFz6PurlZNVYbiy1pkKj3OyhYa3uL7xKJkyYvd598LjZy+ROuZUuBd0w8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5r8IgEQ;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965D606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2965D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5r8IgEQ
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso2049632a12.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795582120; x=1796186920; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibCE/HqS/x5d7xPsRoXs/I+gnefhANY9+jawDpdhc1o=;
        b=Q5r8IgEQAmZbYJu/A0c1xG1xuchmY4XyU1eozZEou/bXUSlaOHvyFcCRnbc2hKTb1b
         iglr9abON268kxwAoma+YRgC3gh7pA/14dUTq5OlXiDNpbQ0+v1SFSktNKRNyNmEyiKb
         47KeutDVhlW3vsl2b9ZFlsgXdyFYmXYFlYtcyc8eOmFnqWbTn9XOJAPV+9SVeDz9p99T
         NT07Po7olJPfieXLKL1nZwScFHcb16SUup5ZGhPZCoT4TgR3YB1qpv25DyotThsL6ubO
         46H2mGwDbyEdbSgX9c3drUv7TYiUZ0x+Qpk1ecIfGHq1rj2gXUBjnXPoTpf3wktMdeMa
         FG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582120; x=1796186920;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ibCE/HqS/x5d7xPsRoXs/I+gnefhANY9+jawDpdhc1o=;
        b=KP5BmgwS2PHXkzHs1fnKjkJAAas0MilllgM1pJnbqVCKeS5qYUblynlK0cLKH48SSu
         it5cfyYpKbq2KdB0+4NQ7Ax02jmVHNtaRZeZWdF3TsdfptYzfRvtOTvugpcKCEOxmbB4
         35RM7CFbgbA/p/pQnU4z2qwy2+75mBi0Uhu2wKDr4SK5knfdSHqZubxBIc7c6VgWsLqb
         RlLjdGNHnLMpVAqJ32GPMilnBmYFrcQ2O7dZReklhl+T8tT8i53p7sQrp2nH0iI36aZP
         g3hC+Z3J6eKa7KrHPmY2jDEMrIxP6resKUv4BUnXC4yh3MnfZszw7w0vdr6WkhaHeii+
         T//w==
X-Forwarded-Encrypted: i=1; AL+hErGBQleEi+lXwVgwFyHHgV3UikTWva0XJt8/tdCGDhDb3I+1aNQdJvqQb1Bei/QnwKrQ0vY=@vger.kernel.org
X-Gm-Message-State: APuU4Z81sqS9NoAArNgOliDMYQQABvh6XPSSFnw5kfI63dQeV4emulRU
	J+S+yciLCtTaK/c7N9ssJXBGiwh6lHIEPD66Sgt73w+isVDh7SZtVsbm
X-Gm-Gg: AZFdTZfx4p86H+jchiVvIopl+zyFoUE8T1fkYOyl23qkHFZp1LDEIj9hVvnRTFLFVce
	zduKTlYmYbyJrRTX5avhsOMvi4k2PTxYliY09JstaXEOQX8//uWe6p/RRh85raqEQmLc7Tn1/ES
	JyCGKSjw0VXcl8PPQnkqOuHaO4LqqFj4v1pNWcpkZTq/e+yJ5ZKk0ULYI3eFQqe3rmYmHRAPhQa
	egwBg4aSuhTZvbilB93HR1in8cs1qQkC8Yj37CkJAezw61i6WI4j/r8dmAo6Y4mPSQJQK96XEbB
	B3pgLV//Es0NYZtayegRPZrmJzH35ZhNXszXffEVLg1NsWZurTG6UnT70o4jA0saDnYLYkaqpuj
	pe0pDA8cBjEXmMxDdVmHvIgDF8geZZRlLA6GkB7RhNNAJsKBQp0XTh5uRQ5YlKBNdTV/dntGNxt
	sNVuMkL7FCzDe/PCKhAJBUI6C3/ZRqW/0enqYmHuWOGNqYprHywPEEG1vlBiNgPrlRoXNONqwjd
	hfnkowFO69Wb0SIJTZaBJVpTiojBCxmB+GBdxbqNoYCbP5UyE0zZYTGqInxgHx+vq0kU0enME3w
	OMrm0ezN9QHx+ekXA4WnRM2zzUbroWjCCUF0doHesCrcT2E09CjOBIsVEHd6E8HdYfN8hApTH9B
	owGAyckpmWK0VmoHDPkZpAgUXoKlUA2V1lQ==
X-Received: by 2002:a17:90b:4a48:b0:3b4:1884:984c with SMTP id 98e67ed59e1d1-3b41c7b573amr15749170a91.6.1795582120219;
        Tue, 24 Nov 2026 20:48:40 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm28760169a91.15.2026.11.24.20.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:48:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:48:39 +0000
Message-Id: <DN40QM3CLBU9.3GC3UR9AVWNZF@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Use a 32-bit compare in the array map
 gen_lookups
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yuan Chen" <chenyuan@kylinos.cn>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Shuah
 Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
In-Reply-To: <20261115102559.465375-2-chenyuan@kylinos.cn>
References: <20261115102559.465375-1-chenyuan@kylinos.cn> <20261115102559.465375-2-chenyuan@kylinos.cn>
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

On Sun, Nov 15, 2026 at 02:25 AM Yuan Chen <chenyuan@kylinos.cn> wrote:
> Use BPF_JMP32_IMM() for the three compares, as commit 70504de0bb62
> ("xsk: Use a 32-bit compare in xsk_map_gen_lookup") did for
> xsk_map_gen_lookup().

bpf-ci is right. The sparc64 JIT has no BPF_JMP32.
build_insn() returns -EINVAL for the new compare.
Every prog with a lookup in an array loses the JIT there.
With CONFIG_BPF_JIT_ALWAYS_ON the load fails with -ENOTSUPP.
The riscv64 JIT adds two zero extensions, one for r0 and one for the imm.
The bug needs a map of 16 Gbytes.
imo it's not worth changing the code of every lookup for that.

can we skip the inlining for such maps ?
map_gen_lookup() returns -EOPNOTSUPP, like for BPF_F_INNER_MAP.
bpf_do_misc_fixups() then calls ops->map_lookup_elem().
All three compare u32 with u32.
The emitted code stays the same for all other maps.
Then patch 2 has nothing to check. Drop it.

bpf_do_misc_fixups() has the same compare in front of bpf_tail_call().
With max_entries 0x80000000 the index 0x80000005 calls prog 5.
The diff doesn't fix that one.


diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 508706d..89c22c7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -227,6 +227,10 @@ static int array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	if (map->map_flags & BPF_F_INNER_MAP)
 		return -EOPNOTSUPP;
 
+	/* The imm of BPF_JGE is sign extended. It cannot hold such max_entries. */
+	if (map->max_entries > S32_MAX)
+		return -EOPNOTSUPP;
+
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
 	if (!map->bypass_spec_v1) {
@@ -302,6 +306,10 @@ static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *ins
 	if (map->map_flags & BPF_F_INNER_MAP)
 		return -EOPNOTSUPP;
 
+	/* The imm of BPF_JGE is sign extended. It cannot hold such max_entries. */
+	if (map->max_entries > S32_MAX)
+		return -EOPNOTSUPP;
+
 	BUILD_BUG_ON(offsetof(struct bpf_array, map) != 0);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct bpf_array, pptrs));
 
@@ -1496,6 +1504,10 @@ static int array_of_map_gen_lookup(struct bpf_map *map,
 	const int map_ptr = BPF_REG_1;
 	const int index = BPF_REG_2;
 
+	/* The imm of BPF_JGE is sign extended. It cannot hold such max_entries. */
+	if (map->max_entries > S32_MAX)
+		return -EOPNOTSUPP;
+
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
 	if (!map->bypass_spec_v1) {

> Fixes: b2157399cc98 ("bpf: prevent out-of-bounds speculation")

Wrong tag. At that commit array_map_alloc() has:

  if (array_size >= U32_MAX - PAGE_SIZE)
          return ERR_PTR(-ENOMEM);

elem_size is 8 or more, so max_entries is below 0x20000000.
The same is true at 81ed18ab3098, which bpf-ci proposes.
The limit went away in commit 1bc5975613ed ("bpf: Eliminate
rlimit-based memory accounting for arraymap maps").

pw-bot: cr
