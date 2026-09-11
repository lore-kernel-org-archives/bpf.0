Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0344F579
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127842; cv=none; b=TE0q/LRkl+aFvxk/44nPVlX+XTDrDJXXp+2BcFwGc5hEJmJSdMQb2T35Vi+JX+RhMZWlUgU7mfC/FLlwhvX8y2Kaxv/21bRfCShz5zQuK0X9XbrStVwdhU2je67ilwQ57Di0ykorzv29z7gjLevEvTfGQw1ILGnlJ3BRJniVmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127842; c=relaxed/simple;
	bh=OPxptqmpBFBOLjurjRMfQkieRxevXZiUqzvQso7i2h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZkcLCIB72eN/coHZ1BMBpsELQDpjsLVG9Gy89C24metIHHCVqvTaxq2WlQHqMD5z6A/iZMb6N2vFAuWGGt9fnYo3RN1Evec2k3RBEYvPYYaJ7VmqaJA94f14jkDg0of4rHjN65b3so/0vv1RPQv/RX7FFHOlOZzMHDiuRZZdTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alHew6Nn; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alHew6Nn"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-39d78580bfdso567055a91.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789127840; x=1789732640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S2fr7AWv7yRK2iSTL6yb26MNU1kRQa7OM28dJzh/GR0=;
        b=alHew6Nnl+unGKIMRbbmEQS+SM+fILqZgj4VDriuZy3og4ibiwT3raiLIDxOI2KaNw
         COf2yN0geq9RnzvYPTCb5cHNAqXBjdFRVzZ77/kEMcwzsNq28uKa9kiSOjgNKhR5wAOV
         VxeEh6++iXXCwkZfQggLTabq4XR4TgO6qDnm1zIzMWtYf/Fn8+FWbhwT5ZImdT82AO2D
         W4Xve7wcEyOsTj+89rYl9/sIhFunfGkBV+NRWbqZIFlUbYqg25ddxON5MYLwrVlc0bB0
         n25Q7n0WEwyBt6mCMYYsFiyrQV9obUV5qtomWep36U2XFrbvaJiAZIL9Zf7nRyWzWYGK
         bD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789127840; x=1789732640;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2fr7AWv7yRK2iSTL6yb26MNU1kRQa7OM28dJzh/GR0=;
        b=E/FKh2wOKtvrFcXebkEDrAJDmVX3F7YyCmcRWXWtVPtiXQY5IkVqXa/+bGxGnQ2Jwx
         ud8wW7g/IfLx9Ez+ayfl97HnkyI2yuGlCoW2pplteq25m4veE1O5OMd01QiaLGm296H7
         v/8Vgw9yQf8z6BtcCB4blCVvclicNzI+shSOtBlVq8ATM1G9SZQsFcv5kIUOJR7bDnpc
         6vcEJsPSJXvgz6ltshomQVa1g07Xcl7ZV2KEA1236B8bwIxo1R4wQkUZWn3rlQFRAdeW
         8YX6RxFcGi5xKUY9mtoTwn1p9MsiOqxdyqp47PjkRQBy7CnMvgCMKdT9qxC34yUpTnBx
         yP7Q==
X-Gm-Message-State: AFuF++nQv5OxCDaUot2WLWSTYES8Xg9RJ1ijIqZXnKvEDOeSMo1/VbHj
	R5KWQdK2pJ4KNelZ7MeIUt9Qb01/PK7g3qPTly/WkFLU0fZsj7vuGTDM
X-Gm-Gg: AYBFou2yTsXHFPqulee/DK/FoJP/kaMckthulPMvE6QmZNcdRipS56SwZButpZH6mwt
	AdLXTwLzricU/e45hnXoGTqVasNQAKaXH4S1HCCvhsoqU9MlVHaEyccvS5/5Iux0plIwqpTFqOD
	AWehYlcxOnDKBmCqyZp4dkt5az4SBmMdwxiFjxmAcIUFp0QuLLwgiPXiiZjFPCs6LL3OoBUVzHP
	jIg9xxaCGjb9+pOuM0V0mDJELLsgIAs0g5DC1phs2vF/4bwPFKXGSqtUdysey8kTxCOs2dJQYC/
	+uBGprUGx0qGPIS0jIN5sU+T1xhmc98KOHY56XL3kP61J7Tpif7C61oVx5MNvZZPL0bsBOTkn/k
	JSLfsXGBduSNE9BEZ66nJXd1OoOodTsGTeW6m8prRTkRdya0V60Vwok5USaUWfxSNy7f9cUt43X
	vMxYLLIEhzuCvCs3PEG/EjGwjxyzJCmqLfyh6CSq72JeuFiKzhSex3fP5XI988Pw==
X-Received: by 2002:a17:90b:57c5:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-39d9bc1b0eemr6680520a91.5.1789127840474;
        Fri, 11 Sep 2026 04:57:20 -0700 (PDT)
Received: from fedora ([23.142.132.69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b347e6sm5520161c88.4.2026.09.11.04.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:57:19 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: kernel-ci@meta.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev
Subject: Re: [PATCH bpf v3] selftests/bpf: Check returned keys in map batch validators
Date: Fri, 11 Sep 2026 19:57:04 +0800
Message-ID: <20260911115704.402721-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <fd1233fd7c263a4150672e1af33aaea82d625f727ead53cb681ae69bce1e6322@mail.kernel.org>
References: <20260911025036.190487-1-diannaaav@gmail.com> <fd1233fd7c263a4150672e1af33aaea82d625f727ead53cb681ae69bce1e6322@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi CI team,

Could you rerun the failed jobs for series 1162495 and compare the
unpatched baseline if the test failures persist?

This patch changes only array_map_batch_ops.c, htab_map_batch_ops.c and
lpm_trie_map_batch_ops.c under map_tests/. Those objects are linked into
test_maps, not test_progs-no_alu32. No kernel, libbpf, BPF program or
shared runner code is changed. All five affected batch tests passed in
the x86_64 GCC 15, x86_64 LLVM 21 and aarch64 GCC 15 test_maps jobs.

I checked all three failed jobs in the run:

1. x86_64 GCC 15, test_progs_no_alu32: tc_edt exceeded its 2% rate
   tolerance. ASSERT_LE compares doubles but prints long long values,
   explaining the misleading "actual 2 > expected 2" diagnostic.
   The same test passed in the x86_64 LLVM 21 no_alu32 job.
   https://github.com/kernel-patches/bpf/actions/runs/34557418186/job/103135036328

2. s390x GCC 15, test_progs_no_alu32: userspace SIGSEGV in
   ring_buffer__poll+0xc6, with an unnamed caller at +0x2f9760. The runner
   exited 139 and left its JSON empty; no kernel splats were reported.
   All ringbuf subtests passed in the normal s390x test_progs job.
   https://github.com/kernel-patches/bpf/actions/runs/34557418186/job/103134982838

   A baseline path worth checking is ringbuf_subtest's cleanup after an
   unsuccessful pthread_tryjoin_np: it can free the ring-buffer manager
   while the polling thread is still active. I have not established
   that as this crash's cause. Symbolizing the caller with the exact
   s390x executable and rerunning the baseline would help narrow it down.

3. x86_64 LLVM 21 / GCC BPF: failed before testing because ListArtifacts
   returned HTTP 403 from an intermediary.
   https://github.com/kernel-patches/bpf/actions/runs/34557418186/job/103136087069

I do not see a patch change that explains these failures, so I am
keeping v3 unchanged pending the rerun/baseline results.

Thanks,
Tianyi
