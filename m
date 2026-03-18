Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4636CE0E
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820688; cv=none; b=p7CocvxiNOqLDegiQ2apH7nmC/pWOHNCpaCeyAAOONm2RerGcDAdk0JteegTaIVgMiuBUR++rtStvC042Z/vYmVsHe9zibjz0cVFi0ujKlNndcTNdzG4mAPrZhLkV0OuJbLa9Gly7PoeO7GpLLfvCjm+drmEHwCrC+n+0aZ1ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820688; c=relaxed/simple;
	bh=L40p2zbxr4VueGCnfIGVazxQUq3AFtuir7VMyKKcUw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBlFGjpad/IXM45MJCymlTi0sGxb2vhSxnS0VYoehkORSPdIGLStIKEGZwF3tHOVir+QBRt/2IRFqUL1g1ycx3nkKiDjRbzvZ1xHa/TRIVZ9eXY0eb/mYEklAg8Er5BUPJJmR7PavHc4n5Mp0XF8CzcPnGIfwY8qQkQskt9QpOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHXX3tNp; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHXX3tNp"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50902b1006cso58322401cf.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773820686; x=1774425486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3iD2EV2JfPkM0yEJ8uFlk8skpvYqLJ1rlFNkhcwt78=;
        b=HHXX3tNpvg024/S/5ekLdWetNUVz8HxQH4NLlCKK8E774ax62mlZsJv9Hj6WkGUKbd
         swF0/DlxI+XwG3gc6krKa8AIwo5uAjOVleQC6XhWpBCkBFIlIZ0U+lgwBJAn4O2bmC3A
         PU/2eIkO9mOEj676aF1FKgaDz6S566BNqKC6Ky9lIaLRVhmXZuvwXcdzc0qgA1wtr562
         tLfKQgB5LKvIamZcfmflhMaSnjvyxgIg9ehXW+2+3JrnkQ6lc/TV+nBbXfdP0DDlbxhx
         5EHbnDwc6Rhixcp4M5xgDo0dqSxWw6pKs20DVTv+qm1V+Jxgj4Fd/opJmqWlI4Abc5A6
         fXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773820686; x=1774425486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3iD2EV2JfPkM0yEJ8uFlk8skpvYqLJ1rlFNkhcwt78=;
        b=atErhmmlFv9fukW7IZvpPm539TqVLN7MW6nBfibNHsLavGK/4YBQTnunJ1EmjCVasx
         Hyo2K8sH6T/34XHS20rtFjorM/D2v9Eo++Xs9EXUPVhOzNLgCXA0iaz5zBushK+BOMDs
         UyWq7Azumufrp2Q24IKemQUHTeMCQwiJagoBuUFNJBSnAe+OUoESLNqIOTeDhUydCvHw
         +a0F8rw2sXQ88uU+ZtD3Y3x7JQcIcuMS6hOQmP1MHET+ef4NmkyWDi/f0014wSeQLFAS
         m+M2/BaJvG2MpwpxPg+IVoxv1M3/xc4Bcl8CFD2D5NKoeTeW4fzHYxVNLauP93w47isj
         PKBw==
X-Gm-Message-State: AOJu0YzBxn3bkWhYG0bt/5eqcWAlYD1n7eX44EYVups/F5WrCHIhOB88
	zL76heNQpO2rnNjALKggumNKXUjU+eFIT7w/fgBsFfzOLyIBLfRztXCPFyzSySoNIKc=
X-Gm-Gg: ATEYQzwqnuKDAUVD+Pgs5cNK4BbEoCVNb+9XwLROWX0PW57ZKOrWzVVA+pqDE8URRr3
	UvfqDEWPR5vsvEgpmMv+FYeJaZSP0jn6MeqFXzIIHnvRy4Zo+Kkh8DPbtZQkBbmdPX+WfwaFgxs
	egWJh5RIYrNrYAceUxnJjxFu8dfI1/PZuHv12lN+WyBvIitcUr/iixCHnWWK9MDi7oHKuRM1FS+
	Til6prDYVIFwxdUDKVpkCfG6yoqR6nHcSFaeM85BfKXd92Jgrd67aqRoI5wwnTkZ5xIaHOHfERt
	6YptJH4VO9V7SJlEWwPW9WKiM2xFXW+Tk/3p+mEGyHGn4jPQQallH6aMmXIaV7RYUuYNLu8jITN
	4byUIIi7ON+Ne9GtKdYGIBgiS7cmmQfdDDs0yjvRpPduijFCz3YWeMGA2X/gjJ16WmyNljc+cwa
	nVpTgm3sXv+RAPMY/aNoU66q3U5Dm20fLCBhLUdg+cA/gW
X-Received: by 2002:a9d:66d8:0:b0:7d7:cc43:9727 with SMTP id 46e09a7af769-7d7cc439c8dmr872425a34.27.1773820295640;
        Wed, 18 Mar 2026 00:51:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9985c1dsm1710306a34.11.2026.03.18.00.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:51:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] Allow variable offsets for syscall PTR_TO_CTX
Date: Wed, 18 Mar 2026 00:51:30 -0700
Message-ID: <20260318075133.1031781-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; h=from:subject; bh=L40p2zbxr4VueGCnfIGVazxQUq3AFtuir7VMyKKcUw0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpullsMB193+FsgKQgFaaHbX8oz4l0Uq6yg53HcjT6 PdsuNROJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabpZbAAKCRBM4MiGSL8RyjFnD/ 9dtRL3vozh5uMfQJiniHcheQJotpl0kUrJjTxuM/X2/7pvXumtl6KwYy+nFpqm13AZYZjRBGpxXX+j ywM0AN+fSb2iNNTcq0S9kINvaFG5SPYsBJ3iEy80Z/9ry0jhSZT4brAeBkY3cpdYCfqRO1ZLNcTuXE rOHFy+h7xX+3jyi0+ta9QPq8ShUM8/g441iAoCkDEeMSofuLyYYTTBR4aalmFM5laPD5xCc3cKtjlo sNhGieQFo/lXrtIZ09xb/9HFuOyzysQlk8rZviBa8vGFGc8lEgQgQBve4wlJH93ILDAQKOYyy2dbEy wWwmTKC2wjFyN+m+N1WyELCXJoLjmc0rzDGx0zcuU7meHPqGecIx5/y/jACabHB6aMbT0p0YFFRwzZ 5sK4BW8oaH5RHqfX3zf5xzKE9lEYRdh+82uoEbSTGYGAGYmzGaUGF70wmmsoe9/p8SwvaY9ixNDu3L TgEgpYQJuibqjHg0nJeVwtxfvMck3F6f1RKiA/7nWNhnosxjL/vQQL3vkvBKtmjO4S0m9X7KdoixSq zsfd3QUU9Z2b9x+UP5L8I1mZJpMgbDwsRpLXksBx2KRMeSR9dkB0kUhvjRju6rtyIvujjKp2IaV+o4 oAc63XPXfRm7s7a2jRvogahLgFewCLhd/5ZOERhh+u5SA1S0sXlbaNE7kKnQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Enable pointer modification with variable offsets accumulated in the
register for PTR_TO_CTX for syscall programs where it won't be
rewritten, and the context is user-supplied and checked against the max
offset. See patches for details. Fixed offset support landed in [0].

By combining this set with [0], examples like the one below should
succeed verification now.

  SEC("syscall")
  int prog(void *ctx) {
	int *arr = ctx;
	int i;

	bpf_for(i, 0, 100)
		arr[i] *= i;

	return 0;
  }

  [0]: https://lore.kernel.org/bpf/20260227005725.1247305-1-memxor@gmail.com

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260317111850.2107846-2-memxor@gmail.com

 * Harden check_func_arg_reg_off check with ARG_PTR_TO_CTX.
 * Add tests for unmodified ctx into tail calls.
 * Squash unmodified ctx change into base commit.
 * Add Reviewed-by's from Emil.

Kumar Kartikeya Dwivedi (3):
  bpf: Support variable offsets for syscall PTR_TO_CTX
  selftests/bpf: Add syscall ctx variable offset tests
  selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX

 kernel/bpf/verifier.c                         |  65 ++--
 .../selftests/bpf/prog_tests/verifier.c       |  34 +-
 .../selftests/bpf/progs/verifier_ctx.c        | 356 +++++++++++++++---
 .../bpf/progs/verifier_global_subprogs.c      |  95 ++++-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 5 files changed, 461 insertions(+), 91 deletions(-)


base-commit: 77378dabb50f593c756d393d8eacb0b91b758863
-- 
2.52.0

