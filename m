Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577575;
	b=xCpnWCtRUxkg8flpDJh8oISohCOf3LfL0SNSX2LFBzYkFTj4E0wu87whNoNKWvBL0A/R
	 gyaGBT6RajaomUVPxrkINQMNauyE4PoZvoXEbBrgYDZiMSOeTtekHLzZbORTOXccH+FyE
	 lMAnE61rRv2RYbircvbrZLIK+90hpzhjfdYxn/KRiVmOsx/ePjB7CNfoqkTkYKTQkl9As
	 CcOdidRX2NcveL+2qDxHvY2eK+OZexkuy8anIwFyEN1uLo/cNFOR3cylilX8IgqXMJYSs
	 GNDT3pSS5B+21+eZqN3PhOtLHsHprUHWRDPEYY9QW/eqD3v7YJrES7M17kZxx5FvuPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ze3Zk9WNhyf9aZFkXFTvd689lOKvfLYd1uM5RZb4eIk=;
	b=Wbx4WijAvItUm6Qs/aiEPoi8MCafUqK49kP3Qy9PEcW+tidxJW4dQJEqyioX6kdNF0GT
	 0n245HW6a7kJfBUFgtbK3AFhqUUrJkngXbh6vpBB3sFkv7QvOJ1yHKYdVy9xx6VgJNgqY
	 Cm4VZvSGkkfob+8uhRwBFGZ54T+toO7Qml2W5LFrvidn9oXa7FL9bELbRhuKhaKU/GZmn
	 2vTa/Y9DW/hRuZXRViE0n25abqVsOlFoSG8MFlRwBV1dLbvobU4gT7Y/oii7k7rOHaVFD
	 6LIuVbnkydnQb9/qwBq7kMVPuLAqYqr7V26Wg3kwm6iS3AgUMZ+/F2BIG1JrAixtcdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VrM2viyo;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A981606A32D
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A981606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VrM2viyo
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f0481b35c9so30322905ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577570; x=1796182370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ze3Zk9WNhyf9aZFkXFTvd689lOKvfLYd1uM5RZb4eIk=;
        b=VrM2viyo7YxES9yrLdxYFIRiBPMWAQSFyF96traEGdif2jlisCEbSxrTjVv2X6EGY+
         mHCQ4XIHeGVBXDhvsgGl9DuN/xq5r/BPcZXwYGuG86LZl3slpQxvuPrgWKvawGwSJFBx
         BYW+OhCmIpQhgDY8iCfjE8EnSzhkIZAEQf5JNEO06jJaryp2O3ALcYD9FdYIFH9d/Sr7
         udSshApNAV4NsneEsXfFjNFQTMubg5WoPrB2BdMSMb9mBbBgAcBKPDowUjtC8ozEA5u0
         5VOmN6cyUE94UHykwmcSMIcwUprQiDIey1uE7DNlGU4XjRx11js8PNhwfZmFh7WZ1J9E
         PUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577570; x=1796182370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ze3Zk9WNhyf9aZFkXFTvd689lOKvfLYd1uM5RZb4eIk=;
        b=y4K45GAJ+4EyepLYxbdbLw+ljL9sVeL3T2XK+gi3+u5D+z9RhkyZhc6RdLAVdv2NIt
         0C0XB3FvdUrXfaMoybkOciL/wFbc+O2vhocXS/MQcPN0ydAJQZVhv9N4qq0MCxSHjlxb
         K2g1S+YQDa+Pi1t+fEERclvxaZw5arxFsAI55x8TxZcLl3/sRa4PZ2Wi8PGgirPl1M7O
         NUM4htDMl5J63vHtrDiVI4RzD47uK0QyEP2vt0TO7zlaBWmtMnqET7dZvaaY540lplPC
         5GxtDEZ46h1ILsr+1ZFO8SOFaCyEVoEup7I+aY8TsF5RLLhDc+8vOkLfUtWLhptewbkS
         bwkQ==
X-Gm-Message-State: APuU4Z9ytTifs15uB3MQ1agogulBfmOutjKN9ar+Fmk16DAkwfmIvmZT
	Jnjs796Ahl3onYi0M4yfQAOY0E3vS85MmCoPM9wYQaEjkXKbqNF7yw7BtnZtlbRt
X-Gm-Gg: AZFdTZc0zdY93dyMbOo0ym3hsIt/1t68OHXOuZihSU/KO7qVCF8IgwKWpJDmyFpNrhI
	/JFmsd8Dc8D4Zcg8I5sutLzPjcG7R+wCjo1LLRG18/xxWjEJeesqe2VC4zW/ZC/D21O6x+RpRsp
	fHWXOZIyMczHKxOWYgMmyKngIkMDozKR06WPfuEunklKhazScZR/7puQgSzhjQn0EPwEAhY4jmv
	bCgs9b/ZaWUrFfMx65NAK5vsQcyeYu2qbbEDE5Kv4kZXbHVMKTDh8bVF5BaDWn4lD16KiOZGrlP
	IeM6PKSeIof/beVdYZ6f+omfN+akqodKq0L3N3mqUz/+MN13fittYd6/uaz5/99ZJ1+lsnQBPUe
	VECKyw2ORb0xF/yptFlO9a9b7yghtu4xHdZp6ATcBru2jezfdB+Bu0P5Ji5yQgjUS4C2YhyImnf
	cE9vud6pr0EQEALhyKs4OgRimQBBk7mvGlOmT1vkkaKGgZKZj/mfLvEAABmSYNuieNYN3U0MR7Y
	G3gRk4BTP25BMYqRIPtPBDuJnW5iTwCB5olnRm4jhFnEVXkHcwkqMlc6PFMyM7EC2OtcwSfDohk
	P0B5t0uppklR4/oeG3TIE+00Qdi/vG/sOd589+5BCfs7i8XDNUHjHdo1PYn9dGGz125WqC/o4Xp
	BOKxPa5mE+xoqgziiSEL5C8eoZAkVG5Wg2LtjgH9pakEgGiwUwMlymftzNJIWYIsfBm/IQM3FGA
	==
X-Received: by 2002:a17:903:41cd:b0:2ed:5548:2989 with SMTP id d9443c01a7336-2f03f20115cmr134557545ad.30.1795577570152;
        Tue, 24 Nov 2026 19:32:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1215d7sm75453795ad.65.2026.11.24.19.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 32/47] bpf: Require CAP_PERFMON to pass values of insn_array as memory
Date: Wed, 25 Nov 2026 03:29:23 +0000
Message-ID: <20261125032938.670542-33-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The value of an insn_array has addresses in the JIT image. Helpers take
it for plain memory. Refuse to pass it without CAP_PERFMON. gotox works
as before.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3cfc64e2f9e1..554d99c1c943 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7970,6 +7970,10 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
 		return check_mem_region_access(env, reg, argno, 0, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
+		if (reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY && !env->allow_ptr_leaks) {
+			verbose(env, "%s leaks addr from insn_array\n", reg_arg_name(env, argno));
+			return -EACCES;
+		}
 		if (check_map_access_type(env, reg, 0, access_size, access_type))
 			return -EACCES;
 		return check_map_access(env, reg, argno, 0, access_size,
-- 
2.55.0

