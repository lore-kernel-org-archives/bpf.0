Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A863AC0EB
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700827; cv=none; b=k8Rf0NZ/wSwp4Urr74UgZJIa3Ce3b0GxgXKJ4Kt0PNEgS4hkCqeM8u6arwTHUv9zJrTIDkGy2hlTymH1dVynxfNcKdsz8wmGREMrHvfFuHx4CArGJL6MhoYdYoVBhDbhVUXDBB7ulbOrX877/IHJApgw5+poI+89RMbt8ujf5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700827; c=relaxed/simple;
	bh=8J6NgaGCCetBLXRGpxpKHV94ANRd/G1DP/GDpXboDKY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=blKG9zc2oSPRIO4oNKYiRaNxaBNZnuAPBhWdpa5P2g2je+6g3lAlnKEMHIKp+Dh1wsTbItr26S6iehdeiK6AMQiNLUTY4GM0WZ15pWERtzN8z96Thi6TnBtRSlbKCDoJMqOdLfJpd5l+amAJaX5/Gjn6m+UocrpmTUUXW1Uw0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7XhH/BO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7XhH/BO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso81990005e9.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700824; x=1779305624; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ra1apGW4rTE/l6GmOt4/TLtQuxg6dysGhEZxribEj88=;
        b=e7XhH/BOLjhKP4tYUUQ63D481cWobOCXDQFDHlYYQdTVCGTyWvd1oVdsehZ5dsRuWU
         BDb68sPsRdZoDZxcs7zK+yx7TaN83W0X9fcElBnM3nb/zbjgyuaPr1pHXo8nDl0lb9Ec
         TzC0ZooocUGoph8VEPsdPIlI1lZKVLzuOGqSBnyz/H/rreVqAJyCp+HW+kt6pLjT/Npz
         bomGRZQ0cTbMXUVpVCtM4aKGcwjIr4ij10TWM6mRf2BR3EUy7YrY7bva2nloO+dk9F3K
         Kfbl3NbFYYst+ypQdsXn2rj1Q3cMJ6AOq2pHy/JiYeuStkKcPvnZZOdJX64mzpVfdNJW
         3bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700824; x=1779305624;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ra1apGW4rTE/l6GmOt4/TLtQuxg6dysGhEZxribEj88=;
        b=jNok12vHDEjM/L1oxO/ap6+KQIv1IKUyRE9Y2J//AxOC+ET+wj8vFhL8pKoem9v9K7
         XCdfUFIcS9Dg7DvPkLCS5lZqUtQXV2fSgjYi3luisIrBVip3P9vpBH0opTi7sgi0ZBh3
         zyiiAsKR9Vs55kGzVOXGjWxoMc0YLSB5HF9WeKjbXPMGMLO1A2jy50t2sR2oNfh4MEf9
         ZMkCZPtz2+VK3u8HYckMtOW3lANI9WP+CQLFsP85zsiDNUJFgIig2WzOAkLNQl9Jg/o9
         7nP5oX9L36+04svBjZNjwTFf8iTGGhUP+xf6jlYHNQWdySxEBPcWBk4yHsiU8FQsusdT
         OAAw==
X-Gm-Message-State: AOJu0YzDaJ7UTri5Y3++5tnGLzNAdeOMsr0qaCQWR4g80K6WODDNM3qU
	P2KsECI7u1ZbZkusxpfZkl78ZdUJpPjqHH7Z6EFRchD8DSTvB7xttLrlKSRBRw==
X-Gm-Gg: Acq92OFzB5D5OyyDD1Nnhh8vbbUD21mS4EjrT6n+qaCDzf6suKTT+kxjQ0MGRfSsRst
	3dcgt7sxeYOXFBNigerZpbnKtLQtYKEkgQFuD9d3D9W4z7Sfp+2qVINxC4rKc+DgAhNr9YTCC5v
	DTztY2I3fG8EsPnBBFKrey3pRXVMHgb6Ew/E6bFFm/DBSzu6kUNvam7nnZV61/x++UfWYjC5lqQ
	HvwLD/pcV5RgftPcCqXSyako9E3+ztkQqdpnRrBe9fSis6gecnuH/3Y5c+2kczjwjXWEkyiAPmT
	mnWbbXmuNr9WIiZLhVBjJtuRAadV6Y37kj2HC0rOiD8+lVk10lPTifFkIOEJBvXWbYo7phPaaJL
	sPLP+Feh3dPTGJ3RJkrqSY7Y4CPfmZND4BfLkWQQomqrtpvq1C6vGvUdvWL2rTU9704GaxfRXE/
	0EiWCGVzxxQj4T5IvfSynQPS90tl03pmDw4KMhGTf1wpe1sN5IRftcfNzL7Mm87HXet7tehYISI
	X4PuFz/ScSvn2+jn5g1MfpWoqkC0SLA/3MVtwyJevyWyd3qgDlzmVAYsoGglz4A4jqQewcockoH
	SqKPH/DfBpfp4CttgwFwpnZgxUve/0eCQ2m5+rv7SoB98M/eJ21UjA==
X-Received: by 2002:a05:600c:8b47:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-48fd6123d95mr20042185e9.9.1778700823977;
        Wed, 13 May 2026 12:33:43 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd769286csm1684765e9.33.2026.05.13.12.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:33:43 -0700 (PDT)
Date: Wed, 13 May 2026 21:33:41 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 0/3] bpf: Maximum combined stack depth
Message-ID: <cover.1778700777.git.paul.chaignon@gmail.com>
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

Changes in v3:
  - Increment spec_cnt field in veristat for new MAX_STACK id (AI bot).
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
 tools/testing/selftests/bpf/veristat.c            | 13 +++++++++----
 5 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.43.0

