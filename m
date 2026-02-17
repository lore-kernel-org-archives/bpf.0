Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962D212F98
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318411; cv=none; b=cgyoiV+7JRCzpmHcyVvPc0NVvyWWUhosr6kKjgwyOI7g/LjlOePFAgD+1yY6SKaoq9fufTCDMK4PQx8t09WEQEsWhPn7WLhPGCC2FnsQ7l6p6NvHo5e2kX/WX4bu1uTbS84tSEiZNleqmIu31dgc1EzRt9NHEHeWWBVLF5M7nIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318411; c=relaxed/simple;
	bh=3/OEwOp6IN1cmPJevTWgpCrJGWymYiwzr+RMlrIcCxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nEUP/v8JybJDHwP1coLhb7sUrjqjrLhT8rCgrbA6QMsIsVxl0crdKRTptKC2vRSLfsHilXZb6eUKvu5DvkeQmKW/v868IqDo6n6aOBf3DCgNoxlx9YxmqkzZeHguqOSt7INhcOi/+JyZBGCic2rUtclLGzOt87LltgSS7bixsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3Jcuhrq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3Jcuhrq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4834826e555so39899055e9.2
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 00:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771318408; x=1771923208; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FY6rJaMEuUNID7+YVzUGltekr7rF1Bqq0JZlkELpCNo=;
        b=e3JcuhrqpajKv0kZ4RTYTthO0rhIOGjedFAj90f4Gz3cNljFkkhOWCgDyVjTyed7+T
         dqyt4SeoJrQObAIDaQAyRqjsUTx03xHjfnyhqXkXpdiiCuO1fjDQ6u2hyrVwCprQq28r
         txxJYit30rqb/B8EG3jrCo0otr5r6z8QTMrv2FB+0cEuq9lJOBdH33AtYaUjHmnZutM/
         Ae7UaPbRwx3p12DujgUB/4cJ35PcvOwJee7kf3mlWXIxWToZa3bMl72pnpdcm0KP9DM8
         Zle+4O6wGCTlQO1DODBvwLQt2IIHCkORqhYVlhyW8BrpntqgAji9XUzDNNDTrxXMZKSI
         XmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771318408; x=1771923208;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FY6rJaMEuUNID7+YVzUGltekr7rF1Bqq0JZlkELpCNo=;
        b=jW/fFKDnlwQDu5On90d3m2tuLFBKfxySEQ15PFbPsL8jdt/FtApN3bKxfW8wL5JBJq
         kFf5XLWBUZdDlBnsrMv7kOEPZ1arv6soVrhmnKOva4x5twYNLpNBSX8xTXOhTuM519YX
         gSUBK6c+1rDMgH2WsKLy+qpXBePbnkLfdl6oYBqV/ZymXNLfPxidJgEpBzXHgR4Qce7s
         NEsITVKmNMbkvTjYhbKHx3J36pWloI3oJEcCwC8y/A4eyQXCQCvd437AJgAX/buuddWO
         MVZ48aABYcX1aJ9HEJrB1Qdi1vbIHecF/k6L/LPC0bGhP24ulNVQxL74gqL5ESgq+0+8
         g9Lg==
X-Gm-Message-State: AOJu0YyhMMwcN5sb/egZ5ubsmDxzcPvDIfFur+zB1p5TleJbIXPEFkYt
	meqPk9CnsJR31p5zBOngfpVNAE24wlJZpP7dr4E7QNZAjdUM1tTRd4ekwzKmrQ==
X-Gm-Gg: AZuq6aL0Of9JTa9LVZ6eyH3o4+DMvNLcI895XdxuPe8FdLnMf9yn3eKuZ/dmlVJvhrn
	6vlhq/E+SFAs0OBItZhiWQoqPKdpqp+dnA1FRz/r6nzLYDhDGHixKKztyHVYcez1PoWZepKjb3q
	WUefIqTYSn419h8MSKPhZNjtvsr1uSRrkt+v9Nvkn2OxSTCGNM7ERp2dFurI31zBeRvKxfUjuI/
	K86PqexnPNrmE4HA0oTlSgYFqU6PfAN9xlCA2WUet8Do0JN39nOyrUfQg4rsXCp89NwyOFyvAou
	FF3u7fd4hJEI7BYoJAsOuHe4nE/Q3fxAawv8dQFoEyui1boQxuenZh4RHoEiD1eoog6qhbIbKZt
	refbiV13Ms8LapAQ/IXWllbjiK7+fbNXiz5/v/ODhACKeB0DLV4T/TJNi2OtKVQS79Y/duWv9om
	8VCoALTEvOFtBI+mJodSGWRTwjtoJ0/CLAhNoOVLFwd51/p3iWma3oBU6pQvjj4k3usAwPszFxW
	cm0Omn18ontZjKM9I1A95VZ81x4KZwilMPF8d6YB0lFgfe5gnb/Kd6gUPqCGjwv58I6hBkKbjnf
	JEFb9PyhUmXhQGz5/PYCEw==
X-Received: by 2002:a05:600c:4eca:b0:47e:e87f:4bba with SMTP id 5b1f17b1804b1-48379bfc3bamr173068675e9.29.1771318407745;
        Tue, 17 Feb 2026 00:53:27 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e003025d1eb71f3ff18.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:3025:d1eb:71f3:ff18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a10cacsm171314555e9.4.2026.02.17.00.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:53:26 -0800 (PST)
Date: Tue, 17 Feb 2026 09:53:24 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf 0/4] Fix invariant violation for single-value tnums
Message-ID: <cover.1771316309.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We're hitting an invariant violation in Cilium that sometimes leads to
BPF programs being rejected and Cilium failing to start [1]. As far as
I know this is the first case of invariant violation found in a real
program (i.e., not by a fuzzer). The following extract from verifier
logs shows what's happening:

  from 201 to 236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
  236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
  ; if (magic == MARK_MAGIC_HOST || magic == MARK_MAGIC_OVERLAY || magic == MARK_MAGIC_ENCRYPT) @ bpf_host.c:1337
  236: (16) if w9 == 0xe00 goto pc+45   ; R9=scalar(smin=umin=smin32=umin32=3585,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100))
  237: (16) if w9 == 0xf00 goto pc+1
  verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xe01, 0xe00] s64=[0xe01, 0xe00] u32=[0xe01, 0xe00] s32=[0xe01, 0xe00] var_off=(0xe00, 0x0)

More details are given in the second patch, but in short, the verifier
should be able to detect that the false branch of instruction 237 is
never true. After instruction 236, the u64 range and the tnum overlap
in a single value, 0xf00.

The long-term solution to invariant violation is likely to rely on the
refinement + invariant violation check to detect dead branches, as
started by Eduard. To fix the current issue, we need something with
less refactoring that we can backport to affected kernels.

The solution implemented in the second patch is to improve the bounds
refinement to avoid this case. It relies on a new tnum helper,
tnum_step, first sent as an RFC in [2]. The last two patches extend and
update the selftests.

Link: https://github.com/cilium/cilium/issues/44216 [1]
Link: https://lore.kernel.org/bpf/20251107192328.2190680-2-harishankar.vishwanathan@gmail.com/ [2]

Harishankar Vishwanathan (1):
  bpf: Introduce tnum_step to step through tnum's members

Paul Chaignon (3):
  bpf: Improve bounds when tnum has a single possible value
  selftests/bpf: Test refinement of single-value tnum
  selftests/bpf: Avoid simplification of crafted bounds test

 include/linux/tnum.h                          |  3 +
 kernel/bpf/tnum.c                             | 52 +++++++++++
 kernel/bpf/verifier.c                         | 16 ++++
 .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 91 +++++++++++++++++++
 5 files changed, 163 insertions(+), 1 deletion(-)

-- 
2.43.0

