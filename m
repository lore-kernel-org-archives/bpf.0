Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A22238E5DC
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689641; cv=none; b=DhAiZ42ShjY2Yv+wFnnOwYr+LAmCEQeHgj1lWJDabn7SGwCtFLIh2BGdWDknDytckSfURhG2DOxphKi+n3V3rmRpUTfq1IEUdLucsCqTIuDNuRTcsc5eUxDMvcvkon87it73cqlnBTSxy9fDqctTuEQcO8+yAT4/vb5/YOiJcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689641; c=relaxed/simple;
	bh=0h+Sn3AuRMNSr3NtpQKpuVnxx11mTbEyxOqwFlUodJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mlBZZ63Oo9Pn4eIsvlFqpkgRhMpyVa/NfKgTA619II+RubDM1rQygoD8Xplv3ThOtMeWJcf8khoTgMbqs9qKEEKHi6/5Wuz9om0ojrj2eK/mrD4oefstOShLL1YtENZ2tOv/zjbiTK+9aQzn2MVKWgsnT6oqZDDNVSEYBQAIP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQoNLRxe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQoNLRxe"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48909558b3aso69250165e9.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689639; x=1779294439; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1C3LAYB9P8jtOHihVDlnpTTfFyW2Y+jqVMaZX9tXLHs=;
        b=DQoNLRxemjHIHg840sNGsanqv4kTTha8Qi5ZWY4oUeJk0bspVv3ns4wd8Flu6glLO9
         9+AUx3DenBab2mHC28IYK60OzJ0J+gl2HGdR9p1J4ZhHgPy/1XaEpjPfICfcujfbLKqT
         EFfCjhgV37dbfLBjFtOgkMwYCNALHUi98ihQanIw29mVkSJ9jc497UD6maxxbIlJaq6N
         M9NCbxiq+6aFjLFaer2O0Q8wYZNRFQzF9nvVFa/Q8R3KciCSf99EkshR9uWsLT9lpEAH
         oeabjXK3E9LVCG5T4bo+bNaL4Y9wh3Ywsn1dOWvnpbRaGVWzAeE/eVtKhrdVPyUIYfDk
         5B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689639; x=1779294439;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1C3LAYB9P8jtOHihVDlnpTTfFyW2Y+jqVMaZX9tXLHs=;
        b=T3j0Nw04yVgKrBECd1Htx64pmWqG8UqEWiSQNk6Hdbm4ojz+RWUnp4ZXSfIgsn+s+r
         yZORmlZdcWaxpcUTLioCR4aYuD5EOfKkH5bgv/U0w98m+8nf5RCsRdi7nj9ZrnMtXeX7
         O81hmqaJ1lMJKHPELo80P0oZHjY67x5qJAzCJKth+l9rhBJbPQEPmAaECkIId5KAjyVQ
         OS/IP5CNm7BusXPOrc6JAOpZuQHcy9GtKP8Dm5KwiGS+3tcjDw6ebCP+7fZ7sVSF+SNn
         YjtXbfYv+7YI98Vj5qyjPpIRdbnvNLxmRPYRP2aRl5KVhSbGmUXcWA59BuJQ86cc+ley
         nEWA==
X-Gm-Message-State: AOJu0YxuFSjXAQws7T3nZuTpkfn7UXd/+uzcaSIFMGpkX98q82EmMENq
	D8oyEhol9+IjPaK406E3FrF/4QRr3FKIKfwMAgDt8qugzEp9BKf8XIlNbDkiPg==
X-Gm-Gg: Acq92OEAaEIItNL1JmxhzkWKi7irnz8BjV5CPLY6AtFKfwz/Pmvl3cn9ZJjapy1GBlP
	INsKqwIPHg6aMlRzdTg7SHaqYiSHVXads/gXtkTA03GswfKe7XSA+q24MK4pq10Vb2m+k+6Zrbs
	8ATDXTy9cabOUh1A5uZlXuKcTfwqzxDj2BlxtoOxvA7j99L8M0QM54NDTG9cpFt7xMBHOwXvqSl
	DqngVxmBA/qKaPVVbZE57dizjv6Kj9+I5Y2/gHLITOlENiVOth8G/gB3oy6mwUO6bvww3eVJ/j8
	Y75lMAlWH51iyaEbwPRwLHmKRAT4+KOKLeEZW0FK+XcNHxdqjgF5CYT0OHy6oWYnUxDDV2uPNFF
	yhCbOpwfrKfavZTWidd6+IXmwFQCAX2OU9DZxE/GmAv/GMc5V2i9L+QTDkj6zLgDmnDbZnWR/6P
	QB6bRZWRxdtRMN3vvKTRdnQA6btzALn9s0hV98cOVVagHJrESr5zptRRJX5p72rUrvQMX0k0hh2
	WbISurY0PAlRDsvU7c0ind2hLlmEfi26BTPJcuMCCVEpluz0A7g7xGc0QzuYt9EuxpBfQTToyEo
	V15z/+bIRPpAFD+ckJiBWQ1tfj6++E46lXAdW5wRoRzUR+MTeFjsCw==
X-Received: by 2002:a05:600c:4583:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-48fce9b2fe7mr51925555e9.6.1778689638625;
        Wed, 13 May 2026 09:27:18 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f442129sm45363005e9.28.2026.05.13.09.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:27:17 -0700 (PDT)
Date: Wed, 13 May 2026 18:27:15 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: Maximum combined stack depth
Message-ID: <cover.1778689025.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset dumps the maximum combined stack depth in verifier logs
and parses it in veristat.

Changes in v2:
  - Remove unnecessary max_stack_depth assignment (Eduard).
  - Fix and test incorrect handling of private stacks.
  - Add veristat metric (Eduard).

Paul Chaignon (3):
  bpf: Report maximum combined stack depth
  selftests/bpf: Test reported max stack depth
  veristat: Report max stack depth

 include/linux/bpf_verifier.h                      |  2 ++
 kernel/bpf/verifier.c                             |  6 +++++-
 .../selftests/bpf/progs/verifier_bpf_fastcall.c   |  3 +--
 .../selftests/bpf/progs/verifier_private_stack.c  | 15 +++++++++++++++
 tools/testing/selftests/bpf/veristat.c            | 11 ++++++++---
 5 files changed, 31 insertions(+), 6 deletions(-)

-- 
2.43.0

