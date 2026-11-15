Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794725127;
	b=utjSgVTIDsOnjylqt7m3DSHuAyce8gTeTMIgc0CQOYd3lWbIJ/P0Y4I/n9NRzkKpzvf6
	 sykng5sQBfsWB07VivfuGCSeFlEQgRAKQmNj+Y283ZMQPji/XjQmi02aBcYJIGe+fgHjq
	 P1qvqvB0rFwOkqP0xoYc8H01kL5qXz9OXGNuEuu/JpfrPj3Prj+ZuxujyOM3BKqqPkZ4R
	 F7aMeWRcnUfRV+pIi6vAgNoYVQgo2C+OHePvXaJQp4wv+9IxdaD6p4ArqO725fUe8o5Ib
	 PP7d9EOcoQtTZkg7MeuEJ3FUNk5GzGltuQjY3+03CbBXsU0NCzaHxhaBLSJJ5coVKlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794725127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jbBpt+FJ8a8qGQezAUJGyx793S/s/ZwSaKkH+VjjeYU=;
	b=Hlyc/kECbPOtXEhRUk8uYrhL5oDyqPdS4bc75bGTay3k2hboa6ihbqSapRXYZxelWG56
	 P5YW63wp4tdcSEDrdxiHU1FoA+sXzZtF4PpTVgBAVXCty9hI3sGJ2xGWxDShYJQxpy+II
	 tlm7tAuPneZbFMLn67v7Cv2cdIozeUAxaUNMwA4B95i1VemiHUHjrztuw86y9YgiwQMLG
	 qjYenHF5gLv0CqnxoCY2D8zIN2dl3krG0BQzyxxqLuAi7rEVxRB46gIk1UGRQjdi31TTa
	 5vodVRSrjP6HH40as8XPu0R16V24ff50DM1PNUeqxaGbjzVbQIct+gn7otbwlSErDSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkOIAS2J;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB73606A327
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 06:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FB73606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkOIAS2J
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-491d1f66968so463250f8f.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 22:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794725126; x=1795329926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbBpt+FJ8a8qGQezAUJGyx793S/s/ZwSaKkH+VjjeYU=;
        b=qkOIAS2J5dfRhEsOfY7uH9G91K9RXCbZa+s9wLCAP4VoHegeS862E7+8XAq9ER3GOG
         GXWzW5j2rGwrMY7ORSOAlNB19zj8Yt6g1GntL/2dPkZ8/U9TOVE8qJ4MP4KwDyz40Tjg
         daP4r1zQWxAN+w5XRvFj+wuz30nw0m/q0BaLIpqWlFzrRN68+M6Ibrf2j3Q8Uwnow+uw
         4ctrPSM3yp7pUoM6Uzu7jSeUqnw7eBzp0PHjlHQDLcc8dI9XgznELQw8n2wwqKQlHnz5
         XPJY9VqHgHiashmKvbyj4Hztn/pNUe+YsnnrzbZw8RqllSTLm3FoNNAPppHZ+R3OCX1I
         xsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794725126; x=1795329926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbBpt+FJ8a8qGQezAUJGyx793S/s/ZwSaKkH+VjjeYU=;
        b=LQATGkQPwRCjUB9cXADfW9v5LCpZ6AgvO2s1U6z9q0lximwlxzmO5zniJj9T3kItht
         4CqBHITjGTTudoJV8pF57g0KyWx6XRMJChiU3JPJCTXWYuMQFFBtc5gtuoUXqVBois/3
         gPmyRUkKeb0vVx1Dak2FFr64aVhnQ3T6R7xWBe9nUjv2y4pcK545yk+lKtNCxC3yGUaW
         VqjWMrB2Rf+8nmtCap0Cdy306NrPeAWSRY6OLsVGIDBpe2/7Y+mxFt9ulDrGLtuFzx20
         EWeMy3hXxKCMQF7242B+JnP+IccAHq/FpihffivILAxNhjfg+J10DU0/IiOhVsCpadeX
         XWtQ==
X-Gm-Message-State: APuU4Z/Oa8QKbZBo432on1Wuw4De8ex3XuIKi3xa5kKZHWslmCsF0LAI
	/Nsyx8lksspn5YnHDOcjdxTiAKKFHTkfLut+z3dZ+EF1zjN1ZPTh8XIrn6Qh5w==
X-Gm-Gg: AYBFou2NWUE9AnS2EphJUIs8Xw+WU8BpeDO6bNxvpCnuBqmxdWUpTtC7SxpBqP/xGuh
	OPlWXbCaaaTb7tRo4DCRdY6ag1g65TLf3yMJu7J5zH1+oEiX1NLCc5+f92QDsK65EZahjt1VFs5
	Iec+JvQphuxR1S20sgHEbFmmkINK0TjO8jjWzIpKFg5UJaq3BGQl3x6z20cJQNGQtFYqYHiyG8r
	EJKiLI7+u2F496VPcSfbwUAjCEHPSzmtHe7vQvabptzKQcMoeTqucBtl0mai3nHkveccAOEjCpI
	rgKgwFYENXGc8PUZA1c1m2I0ATPTmXVSlW8adrVJcroOop+zV497kjRLcmx/jiBTXrL/rckOMNg
	hV4rkLb77SxcMEcpyKXVXdwhhTxz4zXWyg+BOyaQASmSBJoMWFXT1kuFa5Dk/PF7kjEdSSWVkt5
	UiFm4mkeHTBrR2HPiVVmmeAmwKnrA6FIm12YZStQpn26wodWh41esYzKPtzEph5ZjvXUPtk0ctX
	LgoZ/a/ThljdtjMTazlBJ6ntxQroWx7G5wjOZsPIrKfZ+O4wOzF9HQpg2Bx1igRhpDx8gc8Sp8j
	qkgUezYlar0JqOu2SE8XSG42GsDt/ElfpD02
X-Received: by 2002:a5d:588f:0:b0:48b:a4b:5a2c with SMTP id ffacd0b85a97d-49c6d4538fbmr17328911f8f.3.1794725125683;
        Sat, 14 Nov 2026 22:45:25 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:474b:1700:dc0a:bc51:e26f:5cf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c6020bb0fsm14073284f8f.34.2026.11.14.22.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 22:45:24 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	emil@etsalapatis.com,
	houtao1@huawei.com,
	linux-kselftest@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Check cpumask weight after population
Date: Sun, 15 Nov 2026 08:45:12 +0200
Message-ID: <33f2b92b2bf65dd349beb6aaef444c8053adeec1.1794724099.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794724099.git.thnkslprpt@gmail.com>
References: <cover.1794724099.git.thnkslprpt@gmail.com>
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

The populate selftest checks individual valid CPU bits, but it does
not check whether bits beyond nr_cpu_ids affect cpumask operations
that scan the entire final word.

Verify the weight after populating an alternating-bit source to
catch leftover invalid bits.

Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 tools/testing/selftests/bpf/progs/cpumask_success.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index ddaba4318c57..09c0ee35d636 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -887,6 +887,9 @@ int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
 		break;
 	}
 
+	if (!err && bpf_cpumask_weight((const struct cpumask *)mask) != nr_cpus / 2)
+		err = 5;
+
 out:
 	bpf_cpumask_release(mask);
 
-- 
2.43.0

