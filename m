Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711B3D45C5
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297323; cv=none; b=azxQFG+yP6a//YY6sCz5c8gPPMpRkUlbhSrpDV4ZOZhgkUrY4blyQOWOvuM5UlHZ7UWbQfbzcnXtnYMwHuviqA8X3AHO5EQKXH0qy8BcbacQtXZtth76WzlAWal5goso4KtbpcwL4t45xbbDtVMcx/Jlva4eCkGSVmge1xiUOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297323; c=relaxed/simple;
	bh=hAo0vwGVQ7+kpr8T3cgGCZDlFVZJeV9ymqFaz8SiIQM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LItGBiLbe8DGDOT0oB47EMIBHiXecSBQyw3cq8DK8E6gGyDNNiZuUR9gFf1jxemO4pxJS4V2g15Y6kbd8yoKUtmC1zDiH4Hiof/4o7PE7N6ZQyrLAd1YoUqM2fEqufdxRSG4N4HyqZXrnIj4SLUywUnXBV/NBdxD8vMG/mKGssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxMQMRVX; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxMQMRVX"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2e96b8bfb43so3260745ad.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297320; x=1792902120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u+mb+Ws97QevRJvwejrow/iLEBPi/r7J2JBQR0nE39Y=;
        b=RxMQMRVXouUBwDlPhl0WeoQQvYKzkQ492oDvKW3TDDgTwfO0edFj+VQgfBK8TbmF4G
         1P52Vmi4Z/xGE7tmFnKoW1hTLxZ1atKeRhYraaZoXOnwygunTAoBe2yQgDLWTt7H6wO0
         qRHwxTxMDWYeut2W12/r2CXT87YegzOgOwRpDmu7kUwGV0Fi+KVk4qLft+20C51kUrLL
         Qle4WjTgJ4WyekA8GZ6Ke/2olZmpN2mdrkDwTz8qdOw/swskB8+hnjX62O8ooroJYVqr
         Ea/1uTFBKfpq2Jg8oaMgiyRXAqaX0g/EctXsHnavIYEpNdbmGN7UDN4WonQoSolQZIfd
         9jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297320; x=1792902120;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u+mb+Ws97QevRJvwejrow/iLEBPi/r7J2JBQR0nE39Y=;
        b=MNZE7txcGYGGZMuGvbMGGNHtN048hKaQqty22C7H9xHHDgl9IZTAa7AW6EJ4Aw63ro
         IF/ASS99nNG7UWDhrdQEdvL66HUIzP500FqoTG53PtCTsEJomSYyUVQD2NjOKP8UTQ1j
         /LjG6EEtfjchZghfT2D8A93VgtmcF0ciJKjXp92zV0dh3MclvBAuiRNjJbOiAUa8GbTO
         mMrfjpHHJS9Gum5a3hpPOpoa6smShCFExS7DMHnYWYJCRsAPdLVtHIv126veo44UefnT
         GdfXXXY7kU/6yD1UyLBruXbUCXHWwHW5ZOVqiGVaBVPWy5IAddWeDS6wCVN6HA3zgGiT
         0Inw==
X-Gm-Message-State: AFq9FYJYYGlRA7+6XXNqK9DUYq1oHHoRa7e6BohjvR3pg93N20F75XZU
	WXcMWH4qMtGopJI++qGl9ZSnpntold+eCzZOQrRktOE48J9b+NIh2qK9
X-Gm-Gg: AYBFou0yBtEbo7TcZ9D4MuHbyESjcb/D3Y3zxj0IsvSMdQ4WcD8g2NPYjqLGgbLP+uN
	69iwmYdcl0ehCHdcVdoFnuejbKz4aB/RDkLnn0v4NAeQP3O5s3/qyuzwC4xnF+K9aurtlwod2qy
	B9gpcHS6qgrBXA7OSAvNiCqK+I4bCAV6Vmd/DEjuH+69uWoBkUMMyat640OTltoVkMQ7HEXH3K4
	PzCeLocvnBYzV1Gd2MRpfJY/8om/5EPfHcfnnn6AH2o/xBkpPb9qT+C3KUIGpYfO2np+GcSIrvm
	j+qtdAIytThCv9m88ZPVj6fPl1LgELFzXwBF/Oa+F6pZQQX3XaRjlSL5b+OH4HZF4Jtw1KKBuZ1
	YQH2vbDYB+abd6D/Z3zhZDcJz8phN8mGq8U1pyc2i0whVkMQ1Gcl4bmIAFZDThXp5uDxW4Uh1AM
	7AUElcFP9KlD+Ndk6c4fmRHbUwuQHumpThIdHN1DrIOY+5hRendY0N0/BrmXFACR3iAvcusWpnF
	R0oLGUpHUY=
X-Received: by 2002:a17:902:f68e:b0:2e9:7190:32e1 with SMTP id d9443c01a7336-2e9a69f7864mr32203925ad.17.1792297319948;
        Sat, 17 Oct 2026 21:21:59 -0700 (PDT)
Received: from [127.0.1.1] ([123.109.188.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8758efsm24799195ad.55.2026.10.17.21.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:21:59 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: Zero-extend the index in inlined
 bpf_get_func_arg()
Date: Sun, 18 Oct 2026 13:21:40 +0900
Message-Id: <20261018-get-func-arg-v2-0-048848b3eddf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFRJ1GoC/x3MQQ5AMBBA0avIrE1SLYKriEXVTM2mpEUk4u4ay
 7f4/4FEUSjBUDwQ6ZIkW8jQZQFutcETypINWum2UlWHng7kMzi00WNvXKeW1hDXDeRkj8Ry/7s
 R5p1het8PUP6Ht2MAAAA=
X-Change-ID: 20261018-get-func-arg-93c80d63ef45
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.14.2

v2, from the review of v1:

 - Shift the index as a 32-bit value instead of inserting an explicit
   zero-extension (Alexei). The inlined sequence is one instruction shorter
   and the bounds check is untouched, so no program is accepted or rejected
   differently.

 - The selftest is now a separate patch (Jiri). Patch 2 keeps Jiri's
   Acked-by from v1; patch 1 does not, because the kernel patch changed.

v1, the problem: bpf_get_func_arg() takes a u32 index, but the inlined
expansion compared only the low 32 bits of R2 with the argument count and
then shifted the full 64-bit register to compute the context address. R2 is
ARG_ANYTHING, so an index of 1ULL << 32 passed the bounds check as index
zero while the load was performed at ctx + (1ULL << 35).

Patch 2 depends on patch 1: without it the wide index faults in the inlined
sequence and the guest panics.

Validation, re-run with this revision (the 32-bit shift kernel):

 - Disposable x86_64 QEMU guest running a BTF-enabled kernel built with
   clang 22, with tracing and bpf_testmod. test_progs output, verbatim:

     #150     get_func_args_fsession_test:OK
     #151     get_func_args_test:OK
     Summary: 2/0 PASSED, 0 SKIPPED, 0/0 FAILED

   The pairs in that line are top-level tests/subtests, so both tests pass
   with nothing skipped or failed; TEST_PROGS_EXIT=0 and the guest dmesg is
   clean.
 - The same two tests on unpatched ff47652a4b66 fault in the inlined
   sequence: a page fault in bpf_prog_..._test2, with the load performed at
   ctx + (1ULL << 35), which panics the guest.
 - bpftool xlated dumps of both test programs show the index shifted as a
   32-bit value (w2 <<= 3) at all 32 inlined helper sites on this kernel,
   and the 64-bit shift (r2 <<= 3) at all 32 on unpatched ff47652a4b66.

v1: https://lore.kernel.org/bpf/179221432098.1890560.17043109037413683447.get-func-arg-index@gmail.com/

---
Woojin Ji (2):
      bpf: Zero-extend the index in inlined bpf_get_func_arg()
      selftests/bpf: Test out-of-range index bits in bpf_get_func_arg()

 kernel/bpf/fixups.c                                |  2 +-
 .../selftests/bpf/progs/get_func_args_test.c       | 36 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
---
base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
change-id: 20261018-get-func-arg-93c80d63ef45

Best regards,
-- 
Woojin Ji <random6.xyz@gmail.com>

