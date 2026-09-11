Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93045322B6D
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103564; cv=none; b=QABtJIvNjL2ixyj4TozawzAbjrMqxG4c5MW+8G+V6idvCTDPiD/+7og0KGRZdEbkcU1HAee3dfw3tBrHGR1ulES1mAgosj8fgHj6DCDnu0U8LjhjkDzgDtx4wPpWLCpkFTZmlab+uVzyDAPB8lCkGhbIXEa492q81I1Btl0BDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103564; c=relaxed/simple;
	bh=v8QPt/+6xHPYj5T1pIpALrRuWfc4JBj3a7vaRoVc0uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Byys32+8E0+92QioQQ1QLLodkIdR/fRQo3VMbW5NX9M0c1E3Aq2xjy77+NgFCh3kmue/T1Ztu3rDCIMLnokrGFVCez+T2UDeVxIZqqOa6ZLFMy3oMnDpdzYqfvbk4PvEYZ14I9cDqyUh+A2IJykNHNJpoNucanh55Rq7FPkpcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmkzDdF5; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmkzDdF5"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so206876a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789103563; x=1789708363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v8QPt/+6xHPYj5T1pIpALrRuWfc4JBj3a7vaRoVc0uw=;
        b=OmkzDdF5RPS6bkC/fa6tLpnuZjBoiNqggxqeXlgff+h808S6CmUriIOMe6UY98ms3g
         cQS1QyFf+OF491Tu7PuD65QOdlisL6appTpST2VvcRv4BZMpOHo/HkUPA6kkUmws6BNV
         GxCs5uPYqDQFcyn2YhCVHgoboeBl8NaKASBWckfrqyCFJxwoXKrfhv6NQPtBGACJTJPG
         cTqkI6o5QAHEgr+DNBVKvBx61I3/n3NwUNAbGEgTpm1leB5WWHVSxkV28SJHJiD3J7nN
         eWLKsiHdGBz8vHpJHayQICDqkd5NhMWxT+oeJUU5n4u8OCAAckmx/WMSVlVo4PZ8H9RS
         mC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103563; x=1789708363;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8QPt/+6xHPYj5T1pIpALrRuWfc4JBj3a7vaRoVc0uw=;
        b=MjfxC8xGBxEV+SfFH1J++3AF2jiHZ9heQfN7WQpRt/m2SbtbSix5Kgu7PvI4zAillR
         A4OTw1sBm0Wd2XosEZJw8m+zDYOdCcUU6Lian5IkJZqTrMuKHSZLsNznQ8Ky6c2zDejA
         gqO2NNMym3fv9TQbijGjtkA6+Omool4XJKxH5KxZUzMnf4MUjeeVwFlIzwqrjjU7DRSc
         xQ6uDMjtrvSX8BRMbnyfSNzfl+O/sVubW8JoNYxZE5QRGtHt+8Vhe+Vt8nm4HN10rok0
         +DXbpoyj+R3/3zUvKB1RldEQPDqi9OQ/eloOtSjk3WNtmmSOgle5kyhfAaXEktteB5hy
         O+Dg==
X-Gm-Message-State: AFuF++mcFkPwzon3PUbO3dKraUsqpH/OKX2tNuFZrI9qALmtjSSrpHYI
	TAcqZFopbIdCwygOvQnsl+WW8G2ZN9UeHmvDOqjLAIN9FOMJ0Jbz1oYay9YerWmDQzQ=
X-Gm-Gg: AYBFou3/+hRqOvrig9vo7Kj5K74vf+xvdQbUgg/VswjP21wLgH5R9FaXU6Qk0fr+Zht
	GG4Cj3PhMLE2AU7lTiyHcix5mnTl/RAMYoQfCFcrT/aWfZOKUVuTU9cDVMKEQL7t3HEQtuMbLK+
	oPFMymprAX17WNVLTT5Gh8b3oMveT3UgLpWJJzfDMj8v82Bis8rE20/BRQGBtbLXcFALIR7D1P7
	jShFh229n0HFrgDVumdnkS5YRl7eosL91TsRs0tk+MsfrbFm7wgIpQC0l8FHFnRsRnWps80UMAE
	2dRmf7u+BuKdPSn4SxFwP4XH3+yyM7uaUhj4LkkT+Vqqtze61zDJlLMp5AX8BcXajt/oaIGFzcp
	YeYDYPcx+iLBaYqa4xgPNvgeQG9xX3faMZGWmdttW1QED4i5aoEEOQFEijFluSNUFXCeDdQAkmU
	B0wiCchZUh4n0zz26UT1F/JG8CXouEbF1L7oXar/BJ
X-Received: by 2002:a17:90b:2ec4:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-39d9c0b705fmr4194518a91.16.1789103562682;
        Thu, 10 Sep 2026 22:12:42 -0700 (PDT)
Received: from fedora ([2602:f921:f20:17::a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm2700464eec.31.2026.09.10.22.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:12:42 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: kernel-ci@meta.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev
Subject: Re: [PATCH bpf-next v3 0/2] bpftool: Consume ring buffer maps with event_pipe
Date: Fri, 11 Sep 2026 13:12:24 +0800
Message-ID: <20260911051224.283996-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e7211adda619bf43e17dbaf59ffec76ca2442726a5e22485cd783ed9a5e9c655@mail.kernel.org>
References: <20260911025114.190899-1-diannaaav@gmail.com> <e7211adda619bf43e17dbaf59ffec76ca2442726a5e22485cd783ed9a5e9c655@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi CI team,

Could you rerun the failing x86_64 GCC 15 configuration for series
1162498 and, if it fails again, compare the unpatched baseline?

The only failing subtest was rhash/test_rhash_iter: key_sum was 2553
instead of 2080, and elem_count was 78 instead of 64. All 17
bpftool_ringbuf subtests passed in that same job:
https://github.com/kernel-patches/bpf/actions/runs/34557186977/job/103134336101

The x86_64 GCC 15 ASAN job passed both RHASH and ring-buffer tests:
https://github.com/kernel-patches/bpf/actions/runs/34557186977/job/103134793523

This series changes bpftool, documentation and its selftests; it does
not change the RHASH implementation or tests. For a local baseline
check, I built test_progs from unpatched bpf-next and ran
./test_progs -t rhash/test_rhash_iter 200 times. The selected subtest
passed all 200 runs without skips. This used an x86-64 KVM guest with
a bpf/master Linux 7.3-rc2 kernel built with GCC 13 and LLVM 20 BPF
objects, so it does not reproduce the CI toolchain or configuration.
The RHASH implementation and two relevant test files match the CI
pre-merge baseline.

Source inspection suggests deferred table resizing could lead the
iterator to revisit entries, but I have not established that as this
failure's cause. A rerun and baseline comparison would help distinguish
an intermittent RHASH issue from a regression in this series.

Thanks,
Tianyi
