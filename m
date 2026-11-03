Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734701;
	b=l+c8SQHurVq6JsCjuaz/zom5ZDT8REwJPJ7Aab/Xm3xJjEr8YHa+fC3frDCah1shPQ1k
	 hNg1106b3IRUX/5VzgDV+RzaKm05DK/UXP1N4s6QEIFNSmrD96TVtLbL+SorE6jTDL4A5
	 WEkCoenEWcepKzVjcrlkxESaJeT7kn2HIt2UwGEwBDq2zoKB4o/sUEO5lE9/aydV/QYmJ
	 GhRLhwicd7WfWVmXW5ytz0RUtzjMmxSv+YmvATzbKGUb3hYml0TjTyQNNpoPtEGuwopcZ
	 gMjH5oasH1z47yzTGrpm4kDS8efEIrsYGAEgfu70Eox0phFprtHEBG2VJflZsPqElyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734701;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=BIAEAQ/rNEEvqR0qasRUJUL267sZFGnKCv4a/o+bBpE=;
	b=HRXdr/9mxPxz9rtnd/YtzEBkvUWA/BoTG6gBdGdy08XU/ieW5O+oAAg6lBrL+VP0oIFM
	 cLtEB2Yld01AhbyyNfI/YlpcqdKuEP1tSSMu5QFx7QTB4vGAQUCizKTCVNRc6ilzvo0JX
	 GpEw/pT82fKKez8vmm151DkIhE2F1jm7U11wy8IELHfNEUPZ+3Xtslxe/uuumWWEAL/+M
	 5eGNGTMoype4sL4G1xeGAf4hOZhe5PTyj6eRcMJndNiE09HkY3hGwih5P925303tzzA4Y
	 jga7bMPVSNU2dT+QV9OuqG9kiSMESMET/5GMh5A+dMjspIdc47xu8tvNnv/K6EfsUdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKpMXVhJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2020606D80F;
	Tue,  3 Nov 2026 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKpMXVhJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266EC1F00A1B;
	Tue,  3 Nov 2026 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734700;
	bh=BIAEAQ/rNEEvqR0qasRUJUL267sZFGnKCv4a/o+bBpE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PKpMXVhJoj+EnJfkxtrGcBm0tqDTevK5z2Q21phIsSeRv+5xWxtz6SS90ouYucq0e
	 7EREw4wIS13ehJoAEQeu2g0BTX/ow+bLFHDknb0X51s29zrcif41AS1QPSgYZmV+M5
	 HIKavRrSRVdl+uRQEu+KHvJX/44MICBxhXop9cF0hcKRlJ3sqMNb7TW022+qE5f++p
	 JX9uj1k4kE48Yh8eAfQPNhiGhV9rgf+XNEBi4xgbykxbfHPWDTH7KJGIppM7b1hi+Q
	 eoH138e4hJWw/h8CUfpDsHit+K1gTs2zM6mh2+MWhnl69FYyU1XDlagCw1BgsKpRlz
	 5YMj0iMXs3myA==
Content-Type: multipart/mixed; boundary="===============1362127791269916955=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <31ce05e35717f1efbf6060bfe2e4e66e85bf7da27cfc911d651369a75118b5fd@mail.kernel.org>
In-Reply-To: <0ed9ae636d79909ab7d90a9c99b5f4704b8d4725.1793732336.git.hi@tychen.cc>
References: <0ed9ae636d79909ab7d90a9c99b5f4704b8d4725.1793732336.git.hi@tychen.cc>
Subject: Re: [PATCH bpf-next v10 4/4] selftests/bpf: Cover recursive bpftool map dumps
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,skokovmaksimevg@gmail.com,daniel@iogearbox.net,ast@kernel.org,hi@tychen.cc,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 19:38:20 +0000 (UTC)

--===============1362127791269916955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover recursive bpftool map dumps

TL;DR: Test nit only: the expected-output formatting in the new bpftool
selftests is duplicated across several tests and has already drifted, so it
could move into a small helper.

> 		n = snprintf(expected + len, sizeof(expected) - len,
> 			     "%s{\"id\":%u,\"type\":\"%s\",\"name\":\"%s\","
> 			     "\"flags\":0,\"elements\":%s}%s",
> 			     i ? "," : "[", ids[i], types[i],
> 			     i == 3 ? "dump_discovered" : name, elements, i == 3 ? "]" : "");

This isn't a bug, but could the per-map expected-object formatting in
test_multiple_roots() and test_mixed_btf() go into a small helper that
appends one map object to the expected buffer?

The two loops are nearly identical and have already drifted: one checks
ASSERT_GT(n, 0, "format_expected") with the tag "expected_fits", the other
ASSERT_GE(n, 0, "format_expected") with the tag "expected_length", and they
differ in whether a trailing newline is appended.  The same object format
string also appears in test_unreadable() and test_outer().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41701079493
--===============1362127791269916955==--
