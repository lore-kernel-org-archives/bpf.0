Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E531C56D
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095801; cv=none; b=cP2w98yDIyaS3sjjKFz2T7rMY5WTgkLuFp6k7q0zGmY52YsWO/1gHbRBihvSVb/8NrDLLC//H0iZRDBrcpvEoO+raq92g+vZfrQEVJ6U708itcmPcoQqXnnN7dj97H+Ucp2a/ufg24v1MP+nsKyygyewyS8j1uecYkxaP/EHWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095801; c=relaxed/simple;
	bh=/old4jKRCWsiFjlSdpH+uXgOHrvpMJuQq5EDgBf/RQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vD3+zL2U8clSlbguTfYryBlRbhC2y2FUDx/vZlZRV9IdKSJrZALH3TVFMfsMwUOvAH7buzuVN1vmz1MCjLP17TsJAVHi58mjP4ZyAxeav5MSHBCU7M1OCCMH6Vz3nILabQKGPv8doR3jWWiqPzFMD7DzSgbw2PuIK8MhtrUGak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRanycgN; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRanycgN"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2d313798bf8so1730115ad.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 20:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095799; x=1789700599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/old4jKRCWsiFjlSdpH+uXgOHrvpMJuQq5EDgBf/RQc=;
        b=LRanycgNNdmJleIxM7xD3CzvAesvI2N5WBqbHUgSW5hncN8/AeNnhtDgeNHPAA+mKX
         Lubgfl2zWGWI1g7R6B2fLaozjr3yV5uoGb59ICwor+Qckfe5LJYJQlfYTLyZQWKBsCbh
         N3vwGDkWqL2P7LTbJyRc8u3W3GfniPSmX1f33YZvqIfGevx9Ui4egLdCxf3qNk1vB2nA
         EfBSEBcdHkfwc8JyUNUT4QOGS8bdEhWjTU7wYlfVDPOVHUXkejgxp2ZK873RfB9wAJNd
         LETQr+Q7ESNipBpEFUSn49g1GW0azFM0DUSnTNAtNTDfMyP0UiKOAm0YrTNymuEkbF9g
         D4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095799; x=1789700599;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/old4jKRCWsiFjlSdpH+uXgOHrvpMJuQq5EDgBf/RQc=;
        b=poIZ3CF7TVBT2rJXsPz8RU8NoFAQFqoAR2p3/J5BBuNNuuxYrA4WZLKWg0t+KTorBU
         i1DBwIgB1d5FsRQ2+it1SfFBEi0dy91Qw0gJZZdMgpecx91GR8SJ/fSoKjID2sQlWWfQ
         PThK3mPWqNDPxxrmpm2OX87+f7xV+oykk1HD1rMsb8/dOSsojtASvBk0BYERANeODtEs
         arIH5fOQKuauLtFwOxdaQlDmlIeNcePPjGAabhge7eYBdevAZjIEg2B5xGAJ0La3QGyN
         eCnbAcP7/k3dn66B6BeniXrVbq1zRJFSOhafxiDGW8/OxK1NT2Adewlo+CEXnJsqJfFw
         rc/A==
X-Gm-Message-State: AFuF++lFY2++VaCWqxp/iowZa/dw+PPdpwZrf5WqYwDs+aHA9ZlaYore
	vdQwXoTUgJjAg1HcsD8aGSSvzICxvVWZ/swsDDedztqitiVPwiAkCUkO
X-Gm-Gg: AYBFou2/vh+srt06ovRjkEbZRqXHa6ayVK8ReAP0ngwVSFVculXeJXVwWZIiJY79gZW
	eKRLouL9m0EFT0juBk4fKxK1tCM5A2Spc1caD8E7dfyTuPLbjXq/UYKci/nEgattOQH7J/PxZB3
	zQy9t5jMpzGLouXhVLS8E3yPR6Lpf9sHTYgS8MGxXkeaQptjUeU8kz9LCRxi5wLuK80CnrqQ92v
	BdQdT07dzBKA6zTEuOQ/g7AfgnOr3l685WXcWHGG1XqYTNneSDGn1fRZZNjD4RrKYtrehMWTQB1
	tY+Okgz1oywPzfEghVwQUJo3btz7DCYn84yRKrRtmxzPUlQuX4PjscF4fu1vk9EF0SLZHDMTFfu
	Pg8By7Ue6Y4J+pzan0B0S86jeCN8yjIS8rxz9uPORBOID0Q8jP6+9IEMU4OjFPLYmOA691sEpqj
	eQyQGqxsdYLMZtcUgk9OZ76M0ehkC9eQPfIe1EryeCURHiSsT6BaeNBtFktu6wHhdD
X-Received: by 2002:a17:902:f64b:b0:2d8:d4ce:7e40 with SMTP id d9443c01a7336-2dd2a462479mr49122175ad.21.1789095799260;
        Thu, 10 Sep 2026 20:03:19 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ceb73cdsm3979725ad.38.2026.09.10.20.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:03:18 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf v3] selftests/bpf: Check returned keys in map batch validators
Date: Fri, 11 Sep 2026 11:03:14 +0800
Message-ID: <20260911030314.195110-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911025713.AB5891F000FF@smtp.kernel.org>
References: <20260911025036.190487-1-diannaaav@gmail.com> <20260911025713.AB5891F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These files run under test_maps, not test_progs. They include test_maps.h,
whose CHECK() reports the failure and calls exit(-1). That header does
not provide ASSERT_*(). The suggested ASSERT_GE/LT/LE helpers are defined
in test_progs.h and depend on that runner's failure reporting.

The distinction matters for these range checks: execution must stop
before indexing visited with an invalid returned key. ASSERT_*() returns
a boolean and does not itself stop the caller, so a mechanical replacement
would not preserve that behavior, even after resolving the runner/header
dependencies.

I am retaining CHECK() for this targeted test_maps correctness fix.
Migrating these tests to the test_progs assertion framework would be a
separate change requiring compatible failure reporting and control flow.
The current v3 passed test_maps with no skips on the rebuilt bpf/master
kernel (7.3.0-rc2).

Thanks,
Tianyi
