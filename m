Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C3370AEE
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309254; cv=none; b=Hdb1fRQew7H15RDCQSMfH+dOE/qtog6gsOJGltd84EX1sff7aLtEAOB9nX7Pwz7H/gWF3p52UgmhM2x0Tgra9JXrj1WE1r2B6tdFIP6ukd6fEJ2WdJrE2aB9E1TuR3EiEc7sEQyZA03TnDbM14uvAq59QtcaoRzRI3tnUPSDAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309254; c=relaxed/simple;
	bh=dy3591KAoddrcRCeSj7NDuxGxv74bfjtV5WlTzlf7Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwwyZ1fGPgCKx759gSEr1F/xHMYbK095oIpTTueln7tBiysT5xGq506Q26+UNlepr3GgvfWzto4OJBXX/iX0EraYFnejMz46sPzKYMOPtBNSxpLKJLR6nLwH+70ZOYcjmpYAH31CYVe+0e9MhZrvjiRERuensyjnoJL2ZpXr9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZNZEdXq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZNZEdXq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82748257f5fso4069800b3a.1
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779309252; x=1779914052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iChxZzWfiNaD+hAkHjNeNDXclaERmNaIr1r1RbO6iYg=;
        b=OZNZEdXq3IrdEdKNUYm5Pi7eD567cvE6JYSdjW365WXUL/vz1h5B6fMVwxUC6azPzA
         dOfi6PXjQQZwl1d/z6aPinziKVXjRxDW2bzWiQeT4TGi/bmjEB887TETT2dbQQ9+k0Yz
         r/bMqn4I+blpP9SIXRoGX7ZaEPR3BS/V2lr0dbhVy2F45onGx3jUwlh/ede8qls3SK/u
         JzHGdc8ykVWfLQb2jPRzjiJZynpN1PRoKVyYUFQdqw+chyNMNhSl8CkDGViIThIrtZWY
         e8wstjsbR/VzFzkMHvQmNSaLFItloJ0SYOdsQekytBe1BFMlZQ3C2Ex0SBJjLom03dk2
         IDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309252; x=1779914052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iChxZzWfiNaD+hAkHjNeNDXclaERmNaIr1r1RbO6iYg=;
        b=iAdT/lTv0OPjksrk+RIllc0jq4N6Rzpz+TB2vsw3pyDr1KblRFccyoWreUYy8uGwGt
         K6y5dKcnXMXy9kDe7b9xNCp7tZiRPUpoweDyXdljbSw2dx1iD4YnIV2jToOl7G7WVKY6
         Sj7uIWp7C74R8pUumRlTk/2XkLEgpBqVKpNC6Iv6P15KM8gRq04UreGCYNP9gAMaq9i6
         yndPa+5kP0vhYbKv/Qe3iWey8gqDWxE72SratXMzk30mLCH5T+tVckyq26n7DLHKHi1n
         gFJ/eC0P10xOTakPzRXkDmQe4uR1P32SdEcQUT5XXIG3GItAkYEIafu7QBfPQb+gI7kT
         hWkA==
X-Gm-Message-State: AOJu0YwwTn2JVKlgpzWvKaBCQcx+pe1zlDrGZP7WxgDAoYuOrJJTp1aU
	ueEoF5QByw8Hlq08kkWthO6cK+Wj6y5eq2HZYdAXGdqJbTnbpSPHTC6uk/jscJG7utM=
X-Gm-Gg: Acq92OF1t6ic8mT1mVjeRJUvpFPsJA+MTcZKmExfjDh7m6wu08KEJnhu8LjdMMplW0+
	2P/E2g+W3GRxQZa7UAtev50r6wIGlgFz69s43iIh1f7uOz8xmzvjwUEJ5N/ZIDOp8FgCSM+f8Ao
	0iktZD4mAIyFdOVUtoB+/x9YvULTxRDkuIrr57Ns1N1K7FkNM1swE0dSXxeAJJKLAXfM1pYA6T8
	52euL0oAmN6N1JxausZhbFg+V1jjwl+xiOs3TiakFherlq/PmXdVMexTui+A/O+9g8vgtjs0p07
	afz2n+aL5YpZDpaiWlzD+j3n32A97OuD946LK6JeUe+TayloRISTcz5m1g/Q/NwWQq+kL2Gwom6
	wKfNkmLpp8953LlflgVWo3wxkcZ0szNyHxma+ztIyZRCh70iRhUNtfU3sE2/nUppIyg5pnoBpMQ
	x2pR0emUfD7fXbUCRM2kodMiGan65GZBEO83CeJuaFVwrFajk0DbmpYJn9V7XM9V+tHehrpIInc
	La7x0ICnJVZxzoa1Blv6ZHY+/jxL97fFas+6Ihk0fyDSHFwwiwl8o3N68iKfEOIp3UM6ZD1tV1/
	lDlaPciuheP/ea+I7E3Qrse49NgDLauHzCB4
X-Received: by 2002:a05:6a20:7355:b0:3a0:b65a:5df5 with SMTP id adf61e73a8af0-3b307f88262mr14502637.30.1779309252204;
        Wed, 20 May 2026 13:34:12 -0700 (PDT)
Received: from codespaces-78f0a7.2t4prynt4dlezbzls5ze3dxsqg.rx.internal.cloudapp.net ([4.240.18.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb121ccasm20172328a12.29.2026.05.20.13.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:34:11 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: bpf@vger.kernel.org
Cc: puranjay@kernel.org,
	puranjay12@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix zero batch_hash on CPU 0 after batch_gen wraparound
Date: Wed, 20 May 2026 20:33:18 +0000
Message-ID: <20260520203318.31939-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit fa747e9f843b ("selftests/bpf: Fix cold_lru producing zero
batch_hash in XDP LB benchmark") claims the addition ensures the
multiplier input is "always >= 1". This invariant does not hold after
wraparound.

batch_gen is __u32. After 2^32 increments it wraps to 0. On CPU 0,
bpf_get_smp_processor_id() returns 0:

    batch_gen = 0  (after u32 wraparound)
    batch_hash = (0 + 0) * KNUTH_HASH_MULT = 0
    *saddr ^= 0  ->  no-op, cold_lru miss counter stays 0

Setting bit 0 before multiplying guarantees a non-zero odd result for
all possible values of batch_gen and cpu_id, including after wraparound:

    (any_value | 1) >= 1  always, since bit 0 is always set

Fixes: fa747e9f843b ("selftests/bpf: Fix cold_lru producing zero batch_hash in XDP LB benchmark")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 tools/testing/selftests/bpf/progs/xdp_lb_bench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
index 13777b3dcac8..816880c1cd5e 100644
--- a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
+++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
@@ -618,7 +618,7 @@ int xdp_lb_bench(struct xdp_md *xdp)
 		__u32 *saddr = data + saddr_off;
 
 		batch_gen++;
-		batch_hash = (batch_gen + bpf_get_smp_processor_id()) * KNUTH_HASH_MULT;
+		batch_hash = ((batch_gen + bpf_get_smp_processor_id()) | 1) * KNUTH_HASH_MULT;
 		if ((void *)(saddr + 1) <= data_end)
 			*saddr ^= batch_hash;
 	}
-- 
2.53.0

