Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127850;
	b=rSb4Y3fzXvswgaOETccM/ZGCWDm1a7zHKCcgRXLgGx2J6Li0/rHUHsNLCHCHh677IDWH
	 6CXERUHTGHK04ca46/t2OEVNxDH9zMdeK60k31gYbM6D1sJqAhC9aEg+wNou6D62quZIL
	 d3aDh4WFtPzFkeXS0PW5g5Y9azKS4U8QAwRxlUKzStMYKo+n0Tcrbpms9NsleqXn+kIW+
	 Kp172d4E0rC4QQwqjRMWT6gb6d6voLA8PX/7E0faIv+eSyjCsYCwbCNMtz/Idj+JcRSXQ
	 RmE4hAGSn+7pwbeI3gdf37VyP1unmwqhOGGhwf5luK//QL/k9ZqF9kLrfSmdrx+Gf9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SBJH4wkqnKo8HjOIpQ4O2lmqpnZtwQWQMRaCPfmcYq8=;
	b=YZBNtDNOlborRoQ5gJggASCYejSC1p2c3ywtB6WUTk1dQtJMSky05F8qVTkq7GyKkZbd
	 g9xW2wa+eHxq+fVOrqCOfm1bS1zjoEjpMZGhSHMvdJOgnlWchwge1DzdMJmWmOUPGsdwO
	 jf3IOYzTEudT3+kmc5ZWJYmV/CyLz4uaZu8gJAwZLNsLKMq0KWAHeB1Y0jwp//EgRtYb2
	 3iwa/T40qNfneoUTspW3NEYRujl2PmZ0bEmYG3HCT57QkaATI9yZiAXzUzZf2NfokEG1k
	 vItOsXhk9MPCzpaLvh0XL1Gz1P9Jq8AXIyTbnAR9QqrPmEPdrflvcJgKUY7Q1+68+ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NixDVTrL;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC8606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FAC8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NixDVTrL
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab41538192so191629a91.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127849; x=1793732649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBJH4wkqnKo8HjOIpQ4O2lmqpnZtwQWQMRaCPfmcYq8=;
        b=NixDVTrLFZQppuM4oh0+Qeco9/K6OmhwdfwmzxpJcOpVULCFTuV3jZWkK/n9b8f0uQ
         6MUviTKLDJUGAQuCAEltHxnGmFil4FzKZLFpmpqG3hYxw6X2nbqMHEYGc0JhP7DqTuCg
         7rHJU/HhqbP2+9fK6WxIuovEu4yjIT+W7a7AT4FdgCSgwL6A+NxKMrES79mZdNpeIKAG
         Wfax5/mmLVGUIQ4IwUsF+mxj5xxmsTvtnGXgASVIY6DTd9ZwbA5I2O8ZrLIrfWIGtJzy
         ux7eZK5hVBxdcgLScsl/2/6LuJGOzSLzXyaRIMgxPWky2K79uFwqwcSs8KYD1/gsu+Ue
         xNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127849; x=1793732649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SBJH4wkqnKo8HjOIpQ4O2lmqpnZtwQWQMRaCPfmcYq8=;
        b=P+Zr6gbRAyirwQ3sfIBwzjZKrvOsHc0Lclq4PgWJ7OIvK5crgSKgIZ3fG/5zKG76x/
         M7yMXXo+idS31MeHyMPZotpfQMay51V8Fz1AwVeGJr6DR7Q4vau2GCuM0Yfqo/Bn+i8L
         ReaVnej5bGkpUoVE5P+mf0wZIx/eXqrdcCBFLwvMBZlYD/JH9y7kxHLsVegRGHViGxqm
         ZbvuAtBqkMeHHSeJgn4ireJwkxfKIZVVkBsKDoaThnxcX+rif04vprqFkKIR5paX+5Z/
         Qa2exXVIY9JyWmD5LROWV0xnyZjr5HJjYPRuc9tRuxAl0fqnrbGR/t1ya5OinEs+aEo9
         po9w==
X-Gm-Message-State: AFq9FYJNHykI9+B0l3PkCjFyFt+nV4RAN9roHQfJnL7zMKQp1qWgnCg6
	fE879DN/Cdxyj6eTCA9OUgwJQYENO8jGX/CF0Sf+vs5wLQ5W4nx8PnK0VTUS5Q==
X-Gm-Gg: AYBFou0IVdltJo8zn/177vRRrTudaPRG5gSrhW9IcsT/3yDv3nnrH0SA5FfaTZa4hRK
	jRLhO6Vyg7/eloOpYJG29/Ga1Phl1QBLMgH1Kc8CtX2wNpjsnxve3oDtDup4cQkk7bT4SsjlQvP
	oAa2P6PJwJ0QHLbdxABDmP6bnYeBdFHZsBD8vl+DUcBp0Vmc7lSeeY+ImWVVIf9TqTZkPwecbRY
	Oq+Vp+Ied41aP0qufAlyMRc7QDnCyvZcolpd63PjyEMN4fGmBKBDN5xA/pzHRZZt2x3DiADponD
	AcPs3r9uGPJv7mpkgCHSliMm6fmDv11dI/pN5UidlCrYRY26rtdy4uS2EZ8np73lXW8B9QU6+uK
	23KnC4RekU1s2vO6cvHBISkx/hloXuDuQze3B45bCAH9A8NsceLq3Nn1qLVyLTwkE7JXGagTnuc
	59bfWO4xqkKek08jqL80JURCnSHn2XOH4sQEG3j5IsWfAxYO7lMV0Ok8bLGymH8L3znQ6yw1UPn
	sk5JXOi+u2pJOurXV40wEjW/Gu7HehaF0lieFZHRfAKHiByxp1b9OvsY4OENt6c3OUagJ6p7oiq
	tjicn6NpvoR0mNzWdgBPhPet+aFWYxE4QWUPonUVnwC7eSPpzKAvA5Xk+BidbrcqkpGActXl54l
	Z3eLN4Eb8w4KJjeg+1JxnCEA3
X-Received: by 2002:a17:90b:4488:b0:3a4:a850:6982 with SMTP id 98e67ed59e1d1-3adeae8b896mr8951258a91.26.1793127849305;
        Tue, 27 Oct 2026 12:04:09 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae57c62111sm61429a91.13.2026.10.27.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 09/19] selftests/bpf: Wait for the last maps of map_kptr to be freed
Date: Tue, 27 Oct 2026 19:03:04 +0000
Message-ID: <20261027190314.1440199-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

map_kptr_race/htab_leak fails occasionally in a complete run of test_progs:

  test_htab_leak:FAIL:htab refcount unexpected htab refcount:
  actual 6 != expected 2

This is a race between two tests. It is not a leak in the kernel.
 - map_kptr runs immediately before htab_leak. The two tests examine the
   refcount of the same test object.
 - The kernel frees maps asynchronously. Thus the maps drop their
   references some time after close().
 - map_kptr waits for that after each subtest, but not after the last one.

Wait after the last subtest too.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/map_kptr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 17e707dddda8..f103f8cd458b 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -225,6 +225,11 @@ void serial_test_map_kptr(void)
 
 		/* Observe refcount dropping to 1 on map release. */
 		test_map_kptr_success(true);
+
+		/* The next test counts the same references */
+		ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		wait_for_map_release();
 	}
 
 	rcu_tasks_trace_gp__destroy(skel);
-- 
2.55.0

