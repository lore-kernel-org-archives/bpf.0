Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE03546EA
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489382; cv=none; b=qmtRsl5kJs/zJu37Ui7i6RezUDjXo2qjCZSECjNKHBg+vhf4TfKu+oCN5LHDddj0GGmSLGERKkbfgDnJi06v05LS83NMDff2FkrsnTXEsizTS7MJWkMEp1ubtrzqY4DbAqNh8nfRNtxyxzNEKtHAYHoRs4pB2pX5P6jNSQzu6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489382; c=relaxed/simple;
	bh=xFw51dXZ4sV2S6QsFDgOI3rdiYdZ4nsPkNmnMFiXmeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiq8iBG3ETb4/804d34NN++fCt3FM1HuXcCMx5+Vr5d3b8Ce63xEUfIBmgf+LYhEROycW3EoFrlEkhqoelvPNBVDD4kwY6zUawB1YR2PpuX+mdmN5w/fOAaErt77PNA6i97EZ818F2geYn+WhkYIeStKlRlRjUyiNqfaRrug4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXHWbIgt; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXHWbIgt"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso3236958a12.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789489380; x=1790094180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e07GL+LLl0tLAUVUEQOcG/EbiRxQSyRFKLVY9ts/p8M=;
        b=NXHWbIgt4ut5nTqQQdTePyycnap0l4h1JjMlVzZMI2jR6GwTuNQgVa0ckZ4Ae89wPK
         rXEVk8lefOv/msnNLS77I6PpdYcwSUD0FkRqRcUYZIJCqbGnJqtc40N9Dp3qCLft61XT
         sjwZLB8ktifx9qewftfzIWE9BjkVD7ezCjARvWFQ1MoJ+nfprjg/cm2w70N0wAF0+icJ
         waC2k70uW3eaOM0I5yPJsJ41gbJYr6nOGZKGcahjaH9Cm6FfriMuhnPdVUrXsaW33e71
         WvR9aI3p0euBeoxqvUhXy/xOLeqNgSUKVIyRL3snV9vDE6f0T94xiSsYYxeaNYS2Xo/y
         Gq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789489380; x=1790094180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e07GL+LLl0tLAUVUEQOcG/EbiRxQSyRFKLVY9ts/p8M=;
        b=J/aicE0wf5yrsJRPiusYC6kDB2nf24ok9j+QCuZTqdwEVqXRPDk1jK3CqHhnO2yOus
         1XqBw1eUbriiiPhI37Ksiy37Uv4jFAPkm+2Q2zram/65A5018HPHIumWIoIDVm1pd/Dd
         5CLme/DfWBc4iUOy+GWA39FwYntG3uy1uG4aHNS2WCW6Km/cegHmcyO3ayyqSYdu1P8A
         6uJDCA9jspGOiOqvxDIq8IUz8rgT+vf4tAC0jEEQL9XXKmXjpDaOOImoh0hSSO7zPKa2
         rOqb4ERs0D4L8yLXY1H0kPMP+4vImj7ged0UTuSAwq3RoAZZW7oYAk0uwY2LQba47AF6
         zPzg==
X-Gm-Message-State: AFuF++k+S2bD2Y9f8B5hTtaRv0SMMXeK9Em0UH7F66QNnAkqVTe0j8K4
	xqt4c4BDoCKTmXMuqgLalGuQQYuuoMbtXMi4LDgUfof0hJjJ6Ks4eF2V9s7Y8AZB
X-Gm-Gg: AYBFou0eOtCZWJrC/Ln5ugdg+UNuBFaCm+Kuw7Ut7McnpOCJMFNNdZ5BE41rQR64eLY
	J6ereIzDDjYvqCXBCuVktDA1jCLk93d3SFzafONrnjZG6oZ7YkSObRD/W/TRrJf3JgcWbZ1n0cJ
	R2duOyHZ4c3qCfD9EvSYBfM1MffHgfec/kcygJLnNAQ+O4dC3/lMPz3d1b+dcmaLMJ+VdkD8t+R
	/yHS0pogJu41dKu0DIatQLLbzXBg3FL3S8wfEohtiShZS7yV54yG09JINJpZtOSmwfgZUTPsap2
	FKFebqApSJBULeq7yErCp2QHJW3zqjZmDtEvVbhWtGs+Gxq5eFTqciKvThPQpmGrCP0ddqclMoB
	vC7pg4AuFbR5eTHqGX9NLZpXF5588fN+8cA0QWsmMdjFV8rPc+xDwQ62pGxtvrjwizhBDB31ZuF
	TICqggOkvdN+Q/xnWTVRJHeDYtdyR7rmW2IfsKO5rdVTped1T4PIJBcUyaX7H4+QuPAT+uyFudB
	J/OzSa+vjK29CXsia52N1Ppi0tJdnJQ8nOYZ2TYf7kgJdUTaeMunpgZ
X-Received: by 2002:a05:6a21:339c:b0:3d0:d1f1:6ec5 with SMTP id adf61e73a8af0-3db4038ebecmr19290338637.4.1789489379966;
        Tue, 15 Sep 2026 09:22:59 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50aa988e2sm208232a12.1.2026.09.15.09.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:22:59 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: Mingpei CAO <caomingpei@gmail.com>,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf v3 1/2] libbpf: Reject local struct_ops bitfields before data access
Date: Tue, 15 Sep 2026 16:22:36 +0000
Message-ID: <20260915162252.473044-2-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915162252.473044-1-caomingpei@gmail.com>
References: <20260915162252.473044-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A local struct_ops type can contain a bitfield absent from the
corresponding kernel BTF type. bpf_map__init_kern_struct_ops() checks
whether data for an absent local member is zero.

For a bitfield, member->offset contains the bit offset and field width.
bpf_map__init_kern_struct_ops() used the encoded value to calculate the
member data pointer before rejecting the bitfield. The zero-data check
could therefore read outside st_ops->data and crash libbpf.

Reject local bitfields before calculating the member data pointer. Keep
the existing rejection for bitfields in the kernel type.

Fixes: c911fc61a7ce ("libbpf: Skip zeroed or null fields if not found in the kernel type.")
Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 tools/lib/bpf/libbpf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee0..84ff5e3be8964 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1223,6 +1223,12 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		const char *mname;
 
 		mname = btf__name_by_offset(btf, member->name_off);
+		if (btf_member_bitfield_size(type, i)) {
+			pr_warn("struct_ops init_kern %s: local bitfield %s is not supported\n",
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

