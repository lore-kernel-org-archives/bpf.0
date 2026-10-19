Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD404534B7
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391833; cv=none; b=aLvCUrIZYBZ6pSyNjn+txld301gauYkKeB6ZVB+kr8dWcgOYvCbZn+rXxtpelURS+Ig6I5T9n2KnyeAZZLG25PyUhhct2cFtbCu2phoN7fMCqJyUbrmMtPIzi8Xpb3BfydxIn/F/JhwwqEH68AEgimYQhIzHipLx9WoTMR3l1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391833; c=relaxed/simple;
	bh=1vEKNs1Lv8s9RlC0dYldCjP9Clmvu1wr0qp2xUuHHc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5qWaYTgVxDsLiqUriODIQj3bu3JTHWVvZTaclADQbzgWfePcna1odVBvl0Hx/yikRtxXvY4GLqZQUgBM9u8bVdx6rDowkGQ/rVk0JgVZ6WlJvtYHeM2hMgMfY8RXkE5OjTUoZ/D7Tpoh1Q5joNEn9pTxu/CJFlYYtDX73zTYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EltVEAue; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EltVEAue"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35c76e9614aso3393725eec.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792391832; x=1792996632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKqh3a+klgRP2nrDDzvAYEDMhzyw7ysI9kOxZXjrT/4=;
        b=EltVEAue9+qEdZCyEXhFXWuM+w5R9aaFVdIOHoJnqbVHyCmt5nJDmj0cLPD4d0nru3
         XAE3Q79HfNOjKwJ5LiJVRLARO/nwaNMkmL6HxDL3G/5RSHpA6BVSpU2/Tzm+X86GH+Ri
         +fCbuUh2CUkHFf9V2ZMK41zTA3LWDPiZH/msDrN3WTyaLA5vK9ZK5aa+6b6enlNxMQ+f
         dwP3OPOqJnFWoEFHfJihzJvjHPntzkiC39iPARN3mCmeouB+GggaoV3UWnIvPdy/E45o
         q+ATdj36oQdbGXy6Bg1iGeGxY7y8oTUajP3+jYJhpu+RmtZptZyLkfTYAsbpYumA8KfE
         RgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792391832; x=1792996632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKqh3a+klgRP2nrDDzvAYEDMhzyw7ysI9kOxZXjrT/4=;
        b=cC7v5R2k/406s3WmuSOoBn2AAlvIKSb95xXVCEFQuIMZYGIB8DPbRNjESVti4YSu3W
         ZSEf5ttXwO+BRNYO0mWwKgmeudPEi5z620dIEOda3zg+wv0CreNtWt1R8lCdCDF/gv4P
         7YX+D/j/UJkD3L6ogi5jn4xw/MmqNXzaUcbfszNrYhR2xJDPK1FftwqZCCmC60XcfgTN
         PhstuBI6asDvpaKCUcyOUHjKwHclnIfdsqbVTa2ypnwS8oTUCbZ+m3cLIjVwfEDNhz/X
         Oro2l0OTBGcjtIQ/the2IbfrQNEQ6PPuMo1XEjG4o/oq0SL4kKf+3jPkOr3x3kw8oLyi
         1BAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfqplL1mJejHMvxsP818c75ByWqP8m5H4ZhbV8Z62/5SlfB0es3WQpLcDIR8hl1UeZ7r4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKthWlmzzrVy/CSkGobtqYkSgqT6CnhAFN26uwy3qyKy6Rb/bwA
	9MP0OoxJbGISXyU7V7GRmtFxrIYurV2+WhrKWFfO0r/KGOaOGeEQGlYheeyP7Iwv
X-Gm-Gg: AYBFou3ROvhUFpICVmjWcGlkkKufbVRHOfOXZ6eA6MyShWcMSXpqfynmAyIyftDjoq+
	xlHRRKcd0dvZ1lzbkRcAiwbl7VITKNlgNYlXO0CxHNF70HoVGSu9XlUk0Moq16icWfFeUa+zZob
	t3RqT1vJ7DZtE2YGg0nPcgTn6uayuaei9Ps7zoyQlolI6qOR4cbwih6+5JQj41Zd0neP2nhj5Di
	E7OdlkIJdFMHmsa7Ky/ncxe8sjz1CisjfT5OGVbFnml+IWqKRQA0xL5XHVQt7fwWIYXayQkS2PE
	PtPlCKFHyN5LRNoeN95cCF3AUKb7eURb1wEOKwHarm/o0V/jrEqWNJFMwQpAlK4DYYKCx4I/pam
	zdOB34t+CVfkMk8NlaIpAK6+3tgppsxHanabzvaNBM4utRuSMdw0jRnmtGId3aokq09++7FMtvH
	jyZkVO9XyzvChTNIIOcIzIqnFjUniVDTnMGqDijt0bDRDfXhfT1djli9oxx0W7fyg=
X-Received: by 2002:a05:7301:470e:b0:358:8bd2:fda1 with SMTP id 5a478bee46e88-361a2649752mr9635115eec.30.1792391831387;
        Sun, 18 Oct 2026 23:37:11 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm53697748eec.24.2026.10.18.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:37:10 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Run tc_edt serially
Date: Mon, 19 Oct 2026 14:37:03 +0800
Message-ID: <20261019063703.2144943-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DM6E35SUH95A.2B7HJ5XOTFJHS@gmail.com>
References: <20261009-selftests-bpf-tc-edt-serial-v1-1-f72e045f2465@gmail.com> <DM4FOVA9PW2E.1WIY5HRJWA1QP@bootlin.com> <DM6E35SUH95A.2B7HJ5XOTFJHS@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 4:05 PM UTC, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> The test is flaky without -j too.
> It's in DENYLIST.s390x in CI since Dec 2025:
> https://github.com/kernel-patches/vmtest/pull/418
> and it fails on x86 with ASAN:
> https://github.com/kernel-patches/vmtest/issues/503
> Both jobs run test_progs without -j. serial_ won't help there.

Right. I timed the parts of the measurement on a KASAN kernel, x86_64
VM with 32 vCPUs, 30 runs each, median (max):

                 before 1st data   shaped data        after last data
  idle           0.7ms (0.9ms)     200.08ms (201.9)   0.4ms (0.7ms)
  32 busy loops  1.0ms (4.7ms)     200.08ms (200.4)   0.2ms (0.8ms)

The shaping itself is accurate. What eats the 2% margin, which is 4ms
of the 200ms transfer, is what send_recv_data() does before the first
byte goes out: creating the sender thread and accepting the connection.
That grows with how busy or slow the machine is.

To Alexis' questions: the misses are small, the test reports
"actual 2 > expected 2" and -2.4% was the worst here, and they do come
from CPU load. Widening the margin would only move the line, though, so
v2 [1] starts the measurement at the first packet with data instead,
which the BPF program notes. With 32 busy loops, 100 runs fail 3 times
before and none after.

[1] https://lore.kernel.org/r/20261019-selftests-bpf-tc-edt-serial-v2-1-41c3813e7916@gmail.com
