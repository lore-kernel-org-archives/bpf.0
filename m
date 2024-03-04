Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8B5C902
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572103; cv=none; b=uQQAhRfjptFyAYEWVU8lGfNl7pjQglkMNLCCvN7vWgFimp04pcQr5ntenTIpzwzCs3g2PPYcBqobfHXzjwz5vK/S7PitnlFDBLhejgBVU85+bC/RhoqIKoaUaAaahTKFHC3UPp8gsQ/1Dhi648z4kA3K41VlQTWonQZ3pybQCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572103; c=relaxed/simple;
	bh=ezb9zg82pk5gsej6O41HzUZ1y+L9epTVFblGdi+/XJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mR444UYjXpAQcHBOj0djQyv8THXxclQnxdI7UPcCrEdHHCMwe+eKDrqF65xTm7z27+8OAzGy2tTzU2MEedBzCwIKoIfKmq7lSyKijN/s+/X3rzhQ/JMRv0I3mL1WaL6RyutIQOPa4UDtdl7MaJE/RpoSC94hhtEpXyUBX+clyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR2IMJtr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR2IMJtr"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5132010e5d1so4926743e87.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709572100; x=1710176900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SVe728GVQpNqN67xiblptf+skCtxM1KZCTa2yaNHcsc=;
        b=YR2IMJtrHBCTfuRPNuAlMHf8diNANRZplzNQrZRrEgqvMi2mJD9YIT7gL54SCInNJa
         IX4KYwPA/sXtu/1NPMVS4WbbzMYbCJKUvzgfWWvRdmDu7rr9uZ4wxCSBNA/mFFmXVJiy
         Wg4vUYEPCqWZSnKTDG24g63kJjZnkrg/nYkugGg4aaYvXItAmYCjQqen+Zt3xSDHk4US
         qX1iFAePAGdm8G/FV6I/CYltHqJFDeV5m0qZ6NFxua+VB7FKoDWfHMzV6pe3mBkuQt4X
         QG6h6YBu8SXucVUSvbysU11tNXdWuD/DHorqYMY4LW5anIeyziMdgi3GZdBCzN5Df7JL
         kXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709572100; x=1710176900;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVe728GVQpNqN67xiblptf+skCtxM1KZCTa2yaNHcsc=;
        b=MJIsj1QFno0zyYhMxKmQRIc9rp6bDqRpslXb1haQs51mM3MCsURkFV46Jt99Nqc81W
         bSjMfqsEinsRRN7r5JGUq0MTfVCtxeBzzNijfEzatDcfEg9h39E09ytaTZMSjqlxVrtH
         SN4BEyAdAMo6aS1za/fmqoRO9B4bkklw4Pjntkq4M8AGUTFqdh0LYOnL90KwBAFvdxDV
         VnHnmvsT8rtWzO+LCrTkFKPsOmfunsMSoVbEVwjiqNn5V9GMd2E0ZkoNl537Vle87a83
         zEN1mc+NYoYilfWq+hF8j35wBMAFWTrxTdaob8WWnJI9VDEtw1cRYkk8CfIEFAIjxm4Z
         oDSA==
X-Gm-Message-State: AOJu0Yy/M8FR6iQmWvS9zYaG45xIY7VduGYCa/a2Wj3TvR8LBV5euHyR
	lxKYMMu4y8C8kT94Hvai9XBjlSRJRWrRDfrVxIzjVneCGJiKyRy+PsDmTxZV
X-Google-Smtp-Source: AGHT+IE5v5gsGNp4qB2PAz+Zo4WLRpo7zkKkwzRbQqctawqX6+A+UhePZw135D714/NXLVNvi2MYOA==
X-Received: by 2002:a05:6512:310b:b0:512:e7dd:2532 with SMTP id n11-20020a056512310b00b00512e7dd2532mr6391318lfb.30.1709572099642;
        Mon, 04 Mar 2024 09:08:19 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090646c300b00a3fbca02e17sm5032057ejs.75.2024.03.04.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:08:19 -0800 (PST)
Message-ID: <5d24bd2851af07696232236372835167c8950370.camel@gmail.com>
Subject: Re: [PATCH] bpf: check mem for dynptr type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>
Date: Mon, 04 Mar 2024 19:08:18 +0200
In-Reply-To: <ZeXQuv2jCsKnYZnr@hackbox2.linaro.org>
References: <20240303023732.1390919-1-haojian.zhuang@linaro.org>
	 <07f7315efef78b7a19dec16b59b74b15f7b97dd6.camel@gmail.com>
	 <ZeXGTP3ZIFRPGFCG@hackbox2.linaro.org>
	 <564df7e8c14864641c2f57a5283de53c746ea047.camel@gmail.com>
	 <ZeXQuv2jCsKnYZnr@hackbox2.linaro.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-04 at 13:46 +0000, Haojian Zhuang wrote:
[...]

> Sure. My test case is in the link (https://github.com/hzhuang1/linux/blob=
/bpf02/tools/testing/selftests/bpf/progs/test_crypto_kern.c).

Strange, I've tried your branch w/o suggested verifier change and
program loaded w/o error. I'll wait for a smaller selftest.

> > I have an old writeup on setting up local testing environment,
> > if you need it I can update and share it.
>=20
> It's better if you can share it.

Well, looking at your branch I don't think you really need it,
I assume that you already have elaborated setup, so this could only
serve to establish some kind of baseline for tests execution.
Anyways at [0] is a small recipe on how to setup local build
environment capable to build and run selftests in chroot assuming
certain directory structure.
All heavy-lifting is done by the script vmtest.sh already in the repo:
- it makes sure kernel is compiled with correct config;
- compiles selftests;
- downloads qemu rootfs for VM;
- starts VM and executes tests.

Some info about 'test_progs' binary:
- this binary is a driver for multiple test groups execution;
- each test group is split in two parts:
  - BPF programs used by group are defined under progs/
  - userspace part that drives the testing and sets up the
    BPF programs is defined in C files under prog_tests/
- Makefile for selftests scans all C files under prog_tests/
  looking for functions defined as "void test_<something>(void)"
  and assumes that these are entry points for test groups;
- Makefile organizes an array of pointers to functions,
  defined in test_progs.c, same file contains the main
  logic that initiates tests execution for each test case.

[0] https://gist.github.com/eddyz87/204a47145452f1fc4792c8a55be53d6d
