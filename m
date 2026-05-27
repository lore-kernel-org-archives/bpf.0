Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE92153D8
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843074; cv=pass; b=d+x740expovPMqBkn9OfGQQ3/50enV4gxmS3KnyuZM7z4eGCiyQJ9P9cbOTrhBvcCDxCGYeB1PpQ6IDOwT7EBSsMtxAEPR5RD6Sd2hkG35p+sWO0pGxvWchzEBIbZfoynlv2A99lexbuNTYdKDs64Y1LCMILiGy7Cz2Wlm5WNyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843074; c=relaxed/simple;
	bh=JJibPwc4CIrBpCKLjeH2Cl2lMT7jSdjAca5+6OaiM0A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hh9P9Yq7pYwLJH9R/l+uZtPpEycHl+qYI8j2kWlW9nhVjyLyiVfX+m7TCEBz2FCW581AA8gwczMTR9Iub1dHCTkLzjZOyhDemvgxI7zTcaku9s+wG4PW/+uxKtAc5hJBbrbB7VuYn3nfWQPq9KYNqMqisPUj8caLH36Yid4RML8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viswcANC; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viswcANC"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-516d78ba1adso7541cf.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 17:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779843072; cv=none;
        d=google.com; s=arc-20240605;
        b=GS2V87xoEEohJqoh9P4GVNCJlGEedIichp7OoW2AbEJjtCtvVVbOaRGw0XBM4vfyOg
         uv5LBtgb6ZuDTNKNhvYYarhVFFxVSJllrepeJEDyyLW5vPSo5E4ReXFPDRt4j0KqLc3C
         7mtBfab6NQBeVl9ePOfnHe+9r77EYhs7CpnKlnj6LUHZIpM5zIju3AdvVxaZ0md8FoQH
         eHu4jtWcPnQXmIWiO3fbm8Cu3dZ2svjMrONmoN68JAvLQMEOcP0MMkSFep3ERS1S/z7G
         Jmo/vSw7Ml4Jg36W+7NmlewfjtKf2Q6XA/7AMeQn25RDfyGF4K6mKZTEoQ7wkX1lJB1l
         1JWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rYovPQBl5r9Ge83SwJzgHkBnqWp3HqEVYtMZEP4Yxns=;
        fh=RvUleREe2yjT/Squ0bxWefm3AB09FKxyE6CL0018Dnc=;
        b=ZhvZKk8UoZZFOv82fLBeII4zV/5MpVW9ZuncwXvqruRkfLY1CRNG0UkTwxiLNx4FR2
         S4MFVRz481YHaMLSkowoDdsiX/KmfvNPW2H7kWB2F8vCH+9p0skfTRxCMTH6KOzXfekn
         q4pyQEV/6zoOhpO6KK7VJJpeTRCIQPgnbywCYWVYZwluW1ql9tVwvE3InZPIh1L4GUmw
         CU5cNng7IybHM78lCtQm9fiX/P3OJ3pN3e2VQhTHy9gqovxNDiqsJRrVJ5wlIL9ImyJc
         C73XM51B/velfiFXngtENNUHm/E7De3sXSWP9ZQ4cRWsx4gbThdxutTCkHi3eErn2WhU
         2J2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779843072; x=1780447872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rYovPQBl5r9Ge83SwJzgHkBnqWp3HqEVYtMZEP4Yxns=;
        b=viswcANCd/PwhggVpx+RnT2k+9FeUPAFnLHMJLyRjbHwif0VEqB27xw+cha8KhqNNS
         OYAG28SsGSBpu5M8bbZKkLx7KGJVDqJGeWWVaEkoImpfESULP+orRm3oL7iFKkagMFjv
         K1An+irZHmP5ovttkYlpkt2zfYFWcthnLU8bTbM/bwwfeGFUqJO7BOkGMRthtRNId1QV
         k+5LJNqvCi0iRvQwSoQqh+rnjwBLLTufle93+qXS09KuT6dBtoNQtW+H+t+AOF5vu4o8
         nKBDSIFoiuahL1033zFo1alVej644Vve/B/uQhX2/sZGLifgarZlidPAakkXPzx7JLBN
         2PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779843072; x=1780447872;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYovPQBl5r9Ge83SwJzgHkBnqWp3HqEVYtMZEP4Yxns=;
        b=Acrco9NqfUXHlBTWDDW8e2GtDXtQ2umILcC/EF7/hE+KGQGxL7dMU/QIHwRQOCytaO
         /i8K9/TPzuM479CV+kaONhyAQxMwqXa4FBQMLW6L94J5RAvqi/uV/DIXF7Qt2dOIYvEb
         MFtL5yjDhu6+knlgVmmK4yWVkf/mfOHH5YKgofoXRTXlR1XBAE3Jnwt7Y4szqqlC6ub7
         LNay3bZpy9ydFhuyS7a2UVJZMzW3MJY1OBejQWUKmmPzBjbV20ewiIorbiO1e776n6mA
         TCQAEVLgUuOcJAGKtVpJI8zTO3d+JD2xqYEc24ZzYKRw8UB3Z+52pFcGESFa57kb961e
         qNmQ==
X-Gm-Message-State: AOJu0YzVx5tNaX5Uya8DdymXLOP0QRvOJwvGav3T9XRpj1mhsswdZtZO
	rGJG6Ms8oEPYf7+u5pFmwaOPYBH2KtD7q8i7n/C1FGZFlkDAHLIs3POXY5vB7nKv/K8iVfYF0TA
	2y3AnbEeZilxU/XQwUyD5eaBqCJUzLIhDdYZWVhqDfao0IB9QVtvCqBjRX6A=
X-Gm-Gg: Acq92OHodUdzmc+U9gOO3+F0Twmd10pLHebZUzudIHbjmWttGf8+YqsRJyQ9j2KXCA7
	YUNEz3oxKbtNdgP8NaCmuf7QSrcQnXXcDXIYszzzdMly2DyWwkQ7Sy4ywu40TPusPLM/wl0B4VQ
	BzlO6198iblEGdFbFliaVVJFTatPESXZxCp707O8k3o1sb9BLA2ety/rTMr/jhug0VbbkpBFm1c
	JUK3noVAwoQbGpNVr5ove2jxIq/ekzsjzEt/MzrGNz6S16yiX5r3BYqL+41Dzxo/iBCZTF1l3yS
	/QJROr2PSgD+SVdM3hTFjGX7T0l7Rl0aIyAbDFR+prnRvTLNPDcXlbJ4Qg==
X-Received: by 2002:ac8:60c6:0:b0:516:4f62:85f1 with SMTP id
 d75a77b69052e-516e0dd260cmr32132611cf.22.1779843071244; Tue, 26 May 2026
 17:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: YiFei Zhu <zhuyifei@google.com>
Date: Tue, 26 May 2026 17:51:00 -0700
X-Gm-Features: AVHnY4J6ifMQKMOzbldQuCyXdn-EMV-7BXLd1MarChejWA8zShLW9uba0k1zfzk
Message-ID: <CAA-VZPk5=sQMCkngpXBo34v6=Ut5YmxNiTKSLfS6-GiSvUZUEQ@mail.gmail.com>
Subject: bpf-next verifier regression on unsigned bound checking
To: bpf <bpf@vger.kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

I was looking at Kuniyuki's selftest for BPF autolowat [1], in
particular why the verifier fails if these two conditions are swapped:

  if (copy_len > RPC_DESC_SIZE)
        goto disable; /* always false, only for verifier. */
  if (copy_len == 0)
        goto disable; /* FIN. */

This is the register trace of the reversed version (which fails verifier):

  33: (71) r1 = *(u8 *)(r9 +16)         ;
R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0;
0xff)) R9=map_value(map=tcp_autolowat_m,ks=4,vs=20)

  107: (b7) r7 = 8                      ; R7=8
  108: (1f) r7 -= r1                    ;
R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0;
0xff)) R7=scalar(smin=smin32=-247,smax=smax32=8)

  117: (15) if r7 == 0x0 goto pc+48     ;
R7=scalar(smin=smin32=-247,smax=smax32=8)
  118: (25) if r7 > 0x8 goto pc+47      ;
R7=scalar(smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0; 0xf))

  126: (bf) r4 = r7                     ;
R4=scalar(id=888,smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0;
0xf)) R7=scalar(id=888,smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0;
0xf))
  127: (85) call bpf_skb_load_bytes#26
  R4 invalid zero-sized read: u64=[0,8]

The oddity happens at this instruction:

  117: (15) if r7 == 0x0 goto pc+48     ;
R7=scalar(smin=smin32=-247,smax=smax32=8)

The C logic constrains that the unsigned copy_len != 0, and <=
RPC_DESC_SIZE, i.e. the end state should be umin=1, umax=8. However
instruction 117 does not record the umin constraint. If the checks are
reversed to match the patch order, the verifier is sane; the
possibility of overflow is eliminated, so the range becomes [0,8]
after the first comparison, and then [1,8] after the second.

I looked at the verifier changes and found this commit:

  commit bbc631085503a7fde9617be18b0657cc9a83910a
  Author: Eduard Zingerman <eddyz87@gmail.com>
  Date:   Fri Apr 24 22:52:44 2026

      bpf: replace min/max fields with struct cnum{32,64}

This change means that the signed and unsigned ranges are no longer
tracked separately, but rather in the same circular number.
Unfortunately 0 falls within the circular range [-247, 8], and the
cnum intersection returns the over-approximation result of the
original R7 range (because the intersection happens on two disjoint
arcs), thereby ignoring the introduced umin constraint.

I'm not sure how this could be fixed without reverting the patch of
using cnum to track ranges (which would re-introduce a lot of maths :/
), but I'm also not sure whether this is an acceptable regression.
Some helpers, such as bpf_skb_load_bytes in the test, uses
ARG_CONST_SIZE, which really does not like a zero lower bound.
Therefore, if that argument results from a subtraction, the verifier
now enforces checking the upper bound before the lower bound to
eliminate underflows, even if the variable is unsigned and thus
invokes no undefined behavior...

YiFei Zhu

[1] https://lore.kernel.org/bpf/20260522074601.1658705-1-kuniyu@google.com/T/#Z2e.:..:20260522074601.1658705-12-kuniyu::40google.com:1selftests:bpf:progs:tcp_autolowat.c
