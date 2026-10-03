Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A442047A
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791028056; cv=none; b=SScNnKvGYy/0A9+RhEv82CVoUvMHofZITsxjDFUME/6e9h6o+NImRXEOSVOdTykZ780AeGSVzDWgHdIBYCjJaS1+4DhXCq+uUSTk0qBU4P8HVTAtJ1xYg72ZXc3oMeR3pZ3L9EYOcTjnJjUIxZBCSXY0+KVlZgfTYtKlc4vZirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791028056; c=relaxed/simple;
	bh=W5faO30N74t7sxHyDVY1DBc72S3l0txd2hQ2mRetbps=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=tQoj5XsY8VgbQ0U6HcMUvHp2+5cXozjlvCev1CvY/bLuL9kgTPVgi/UuSG/t6BMnE2s5AcSsM1Rl8GSol3wVDXszlty7v37YmN1G1s84BKA+meCCdnlDpMwYMSo9B+eC3LiDyY1jAzhHpKSFt2X+8yxRyF7VgfG50Yokqerom64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgEOAcXu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgEOAcXu"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso220676a91.1
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791028051; x=1791632851; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l7Uo1B/Ey3qUdOJCK6P/9HdNum+iFz1a+CmU7hRQ4Zk=;
        b=PgEOAcXusCx+fdz1cyp5Au+oqSE63jbpUkc5pE6muEw1KrdxhPhb5LzFimAU+bNAaC
         iHTqrID8zCDztnwW3F9lxfVPijSAch+jW+KBPh/FHBSQXpVyD9Wpf5e7Mck4nPP84RXW
         hKd1BPrZFLvw/Ab1IfV5B8HwOI5XV4eCK7o15jGgLx0G89S1l7/8lloLbEQ7eS1uAGid
         OYAWUNOEfdax0op30qpuq/bl1wC/K1FadGY0uziIniKVUEcLu9uA5aRa2oaEQBESESLX
         Nh4gsSdZXTQK2QVLdfrTugTkukxpRcvg4/QWINkYdKrwayFI+uHjicpPMlGuuaNSk29M
         i67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791028051; x=1791632851;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7Uo1B/Ey3qUdOJCK6P/9HdNum+iFz1a+CmU7hRQ4Zk=;
        b=hIoYpL/c5rNz4oH5OAgxnN9cLH+GPr6q+gVPd/ZX2MWSMZ4awqKwV4kw746GzrPLYy
         v6OvzT8KIU4M8/WSiZguCXE9CObfPV4KLXuzS/bLq6RPWrQo4A/uWpSBa5H+0G8H1BaT
         6QR+r1OuoQEVN6pv3KV1U54bT+5AvlMWHseaDRTdT/b2hMyuhlbhjnQW5cJlMO+Op8iK
         qO60VuawwsPhACxmwT7UAarC644R3h0zp+27yrUAsVyH9dlzZdDDOExMNCk5qOBw9GN+
         m2pLLmXS6tY2GmVbJPyWHBxCBejGGCY4700iw8YA2NfFf8jkjn+g0/8XVoFmBaM0+oFM
         nn9g==
X-Gm-Message-State: AFq9FYIE08UG4tePnv6h5933t2mW8Y87jDAexuHciN7r0VTCVewNIt9M
	nDwROYeflBN1NS3Prr2/j0oX67qpH9eNUrb8BVx811sm8HS1rC1dbyaLEW7oe6GA
X-Gm-Gg: AYBFou2byT84F5MVPAzdrhZ4TmKrpEA0DkiWDrUuM0WiMfhjid3NrNOSA2VWANF8DKW
	WQzPqFaesn9v2OYEbjIgHKQ4hC1jn1pPXTjZM/NQKJhE4CKH+KLmUqhL3rqd87qi41O7rkWahnS
	UCNhU4Zd8B77DurmcY5O8ZJXVawcfwlECZLTp1ksjGGg6dZeUfGJ5yFaSVN3I2+hBHOburdNwob
	ttyzOCgIz54B8F3uX+ipu0XX6tQL24A1Li9dZaq22rZQRbIGJHnWqRraB7LexByI1/HXJYnSPv+
	7Aj6/0Kmzf3/r+T/ItsZxCnufy9b4BL4xU/DLFN5S7VPEQzxYRpG+l1eo3ojZjhWpUv4Pw3WeXI
	EbRzB0GLNAl84Q4KEVil9aAsGcFPSHQhWx2hSxuRq4jAt2nTikEmBbt5K18s1DzlEx969Tmgg/M
	EOvrePDczlV5YTCs19H0YQqNaYkL+epMC2E/dnLQ7BZzoZQplUUdXwoX0VG5j6p6KQBbJmRDjWK
	LB2M1yiWxEhj3MOwb6UNdn/DY7Y2ik8PRXvarYfskt2X6dTqGhqUeqbHdEy12Ce5HFS3AkCXol1
	4O/b
X-Received: by 2002:a17:90b:2cc6:b0:3a7:9045:fe40 with SMTP id 98e67ed59e1d1-3a79046041bmr1089278a91.50.1791028050636;
        Sat, 03 Oct 2026 04:47:30 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e497230sm2655598a91.11.2026.10.03.04.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 04:47:30 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 11:47:29 +0000
Message-Id: <DLV6GFFEMPEC.3MK9MWGDF2MRJ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 15/15] selftests/bpf: Add test for global
 data of a program in Rust
In-Reply-To: <20261003013306.493601F0089A@smtp.kernel.org>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com> <20261002124714.180012-16-alexei.starovoitov@gmail.com> <20261003013306.493601F0089A@smtp.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 03, 2026 at 01:33 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +	ASSERT_EQ(run_prog(bpf_object__find_program_by_name(obj, "list_in_data")),
>> +		  100 + 20 + 3, "retval");
>
> [Severity: Medium]
> Could this result in a crash if the program is not found in the object file?

No. bpf_program__fd(NULL) returns -EINVAL and
ASSERT_OK(bpf_prog_test_run_opts(), "test_run") in run_prog() fails
the test.
