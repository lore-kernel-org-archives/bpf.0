Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E042551998
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061058; cv=none; b=YjuPcr/WXJEFF2HruyPonM//4ARr09jcgkLPi3pmNwlWQ4LNCupqwWJKlxo7EWmpFAViGPdia9963A1dUvmjqlMd9BBDfCDCps8NIwN0YtoTrimuVfef+MhxVDXiER0t/MiUStCDtYEkL4n3db1rT88YkpNXCer9Wxa7pQrclIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061058; c=relaxed/simple;
	bh=x9Lj3qHTY5Wkc5C6YWsmWE4XGd2tZm0DcXaGKkRvE3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNqT/EPOH2J+GfuSBkmQsuD0YJwQfbl8BD/5+Ko8nqjavsoo1wUZr8O/LLSRI3Joy+SAhWqtDPg5SsZNvZ4X/B7473x8gYYcYhDmCTSHFwtO8wMfI8IuwXNXF6oGTCWeXSnpoPvJp4+z7985V4hjmSzvNhrlNkcqwWnwkWflcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSmZchPZ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSmZchPZ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so1459416a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789061037; x=1789665837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BAaY6hBsQ0LUtb9I4qyj1phWCf3HpvuU2902p4lanHk=;
        b=qSmZchPZtcWj9YhX3VghQSqmupdBHfqkUlgbP/1B/Vn9TFoemm2ErFcfwvOQTU7H/w
         HATx66zC/0bfJ9EGzm2t7UMR898QwW0jCYR47g4Voiz2fdsgkQe/W6M0WcMAjzXgS9Px
         ENGAHq6sRaRxc8NDb61vrquUhJp3NyIzSYWr+71D3iTY8SghgwNapRTmGuMEBgyC3KPT
         PF83AM2MUUxKr5NWsfNNdlIzthG1tFdM9FWQ6HiB2OLzDZS/Dsqxdoj5v/BAiut4gDWw
         ZH3Z/kmNV9OTQEdC0kwHSUxd+q4AgjsYgJ5lX5h01t+p+ULNmoJ4xXGJ38i+U8MhU6rw
         t+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061037; x=1789665837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BAaY6hBsQ0LUtb9I4qyj1phWCf3HpvuU2902p4lanHk=;
        b=aP4QAmrkr/HD6lEAYyFlpgSQt0QA+Riqn2GE4uzh04w4EtZykzjJBELejDEMmUD2s2
         8fDxw66CeZ6RwP+blJGYe0iSMxJ1oPIrS6KpBK2wnZ/OVnv8xiZel4UlpfNqQavI9eLe
         gFmblMclQ5l/ArczwCaO4+aI1i9QTX7x6J7R9jp58Adn0ge9NgL1LFKxSLttt2mD9S71
         OjpnaoSAft+vIozAPa0nKskL9etQNtcuS/MIDKZgy47XU2hGLE1oRloHepdXdPLYP5Rm
         W4BImNyqS623iz+vO1H7bh6WIuu5joRqxq5VWvbqu/tbhSxDwsPcEvlJyfckj85cj9cG
         j4jw==
X-Gm-Message-State: AFuF++m86em2pg3vDKtq/Ff8HzVgBSUK8QHH69o5OExOaStiX/uy357R
	sWQ2RfdtF0dIw7/HkRg0vflj7gglST52D4zL0gpiLy7XCwHOi7alru7Gke4z8WOY
X-Gm-Gg: AYBFou1SKsftAGNuSpOceX81dZzd0eFVgoH/6kB5Dy5XpDIBsG7vNFEa3/x5uDZ+srr
	pVRnOAJbxup6bTPoOFO0gk0p4BeT5sjM59PIJIqFUByxMY+qBZVEjnlJMSXYN8ovGKM8Z2fCqb7
	hNQ+yrFC30ORkHS2BWHEZ3IMrCBbieRW6nX9wL9m3JZJHos3iWAAF8v5j4dbaF+zwH2PnKrKV28
	I7fWpnGopmWiyeeCoPjpYP6RlV6sm7ME6bUd003PNLtJx4bh6a6HK8m4ivMw/eSakoz8PtzGNBw
	xzMRhi1HJ4Yw33VHAL1A0tSgdPki5+kfCf07yL4cEhiAftZtOO8Ko5IAq+AQie9MgbGUcE95bvX
	tRePWt3g5PIz9bEsyKbtQmRXC/NxPAPorbaPo/68wE8ZIsgmFG1raUlSX84obyDRq4ify65l2aJ
	/1en7c5dbesUgGTh8eUwJVdzNZhi9eelXVW72Og3xDOpkW3T/slnAV4yU8RSJ6B4gUInpFIQK0+
	8YxrRwwNhAs71uPT0gFbhAcgxajtc62Tvm2CcMxyRFCXgTq1Db7e0c=
X-Received: by 2002:a17:90b:4d0d:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-39d97ea0248mr382004a91.3.1789061036701;
        Thu, 10 Sep 2026 10:23:56 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d995a42a5sm164304a91.17.2026.09.10.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:23:56 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf 1/2] libbpf: Reject struct_ops bitfields before accessing data
Date: Thu, 10 Sep 2026 17:23:39 +0000
Message-ID: <20260910172340.1467764-2-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910172340.1467764-1-caomingpei@gmail.com>
References: <20260910172340.1467764-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Clang-generated struct_ops mirror with an all-zero private bitfield can
crash libbpf. With kind_flag set, the BTF member offset also encodes the
bitfield width.

bpf_map__init_kern_struct_ops() divided this encoded value by eight
before rejecting bitfields. A 31-bit field therefore selects
data + 0x3e00000, where libbpf_is_mem_zeroed() triggers an ASan SEGV.

The issue was found by comparing the same ELF in JIT and interpreter
configurations. JIT+BTF reached the faulty struct_ops path, while the
interpreter configuration rejected the object before this code.

Reject local bitfields before calculating the data pointer. Preserve the
existing all-zero compatibility path for ordinary private fields.

Fixes: c911fc61a7ce ("libbpf: Skip zeroed or null fields if not found in the kernel type.")
Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 tools/lib/bpf/libbpf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee0..1738a42220f0c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1223,6 +1223,12 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		const char *mname;
 
 		mname = btf__name_by_offset(btf, member->name_off);
+		if (btf_member_bitfield_size(type, i)) {
+			pr_warn("struct_ops init_kern %s: bitfield %s is not supported\n",
+				map->name, mname);
+			return -ENOTSUP;
+		}
+
 		moff = member->offset / 8;
 		mdata = data + moff;
 		msize = btf__resolve_size(btf, member->type);
@@ -1259,8 +1265,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		}
 
 		kern_member_idx = kern_member - btf_members(kern_type);
-		if (btf_member_bitfield_size(type, i) ||
-		    btf_member_bitfield_size(kern_type, kern_member_idx)) {
+		if (btf_member_bitfield_size(kern_type, kern_member_idx)) {
 			pr_warn("struct_ops init_kern %s: bitfield %s is not supported\n",
 				map->name, mname);
 			return -ENOTSUP;
-- 
2.43.0

