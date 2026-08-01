Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329223D7F4
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785625445; cv=none; b=SmgRyXAWTRiunoDtASAnXTODRoQ3rjuUm+yR6jUhS+P5PZ4adFBgHL5tD7girzDzldIRBkwo+9h3BJcu4JF3sjSyOdFUonM53tODygxh31sTK0Ylz+LQb2NizmFISa/s88pqSWksB+0Rk/IWwAT5qMzZOd29FVYIBdGTMpHYahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785625445; c=relaxed/simple;
	bh=SBDelu/TgdsgWx9C5dwSenUmjI7PREuq1e4+fyAPenY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocSGMiNW8hS4a+V0eZ4WVDW1UjvAXJ1I07HAvhqeQdWmj13KTXb42nQReVV+jeJ2cEPLl2aNNkTwt9pZHxHGARAiYrLaoeVtNdBrVjOqkxx5+wDGJE9mCo8zkBD21SIx2aAj/BA8wyqlTaq1XhS3x4D9nadCLrJWUDaNouPlAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itlFqR28; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itlFqR28"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-46e747fbf36so1087601f8f.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785625442; x=1786230242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dg4KXqQakrIO9i9IQkHR/6g+zH1cEix1LBnCV8eIXtU=;
        b=itlFqR28d+m2wzNJLPG2+1xBZ0rXtoHOqmhgIFQ1ocybbCsDpv1F8TPgvYt8Ysf9av
         5+j0q6uJsSLvmjhQu+PtJoMjVTC6xgbWafx3A9ppzK9VwstS79LWMLYlBjqGHhQF2AkL
         66hMlWpXgAI7wSDXjodVH+h5RM4xbknOSCxhbeH20BmhP+xslr3HHAnpKt7PRnbHKMME
         L1fbTjMO0Vvo69O/7Dhp5dOw5MuQyZnrIV71x8QQSPsCwwSVew4GfYNvDwlEs839b7Hp
         7qkIEc1XUt/QMCUPgQ+NQ+En3DIUDYcxrl6wZw5iPAciuyi9Ba6ri+cu7gC7/nJsSXw7
         gm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785625442; x=1786230242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dg4KXqQakrIO9i9IQkHR/6g+zH1cEix1LBnCV8eIXtU=;
        b=RXTLksMoqiATlYWyadhcbhcxZOhZWwanXYDBeF0vX8QyRQmUv7OeEcQXc9cAjAxk/u
         UvSIrLO3H87bW7CfZMocJdnFUI22ariAYzKDU4NNu8PHtSY2eKKCK80xOgnp6S9YonRL
         tkLilJgUvXYzkC2xOsWaIrAPpFR82USIS8hMu5c9SJh2XDstCNVqb5jaR7HkBr03+x1r
         7LphNBxieDMwjn/7TZdukncWdr4Ax5+vIBrcqdLcSmpi7K6XxwUGnhltWm+SbE5G/8JH
         wSTWxC2YXnIUS9K1SmKHHmU+kPuNC3xPdXXDmMipww6SCgWUr8LZqk3IYxQTQGAZNgdK
         4AhQ==
X-Gm-Message-State: AOJu0YyDJyN/2nefFL+6AddbcKVmTYGSxdL8he3+fl8Vu1b7+OA3InUt
	YE1v1hTThfjFYfPetuIar65O4jWm+RE6PTABY1PaYm5NJPVOt8SudUniQI0R6f5x
X-Gm-Gg: AR+sD13HWiXvVwXPGGZHhwNdpfki5Xk+mmjUEZg34n2HNwXHXlbVIFb+JxHrBJm55vi
	yjnkLkPcxF+xnS5i8U3BmY8SA/4rxWq8FFL6Th2qQyeLeBPaBTUCTdHml5lqNHk9OGU85bt/Fn0
	Fvi74mamcnahFkrTh3rcB6Uxdlsr24rZ5i5qVf0YSkFhPPWte4vpSz5K0+wojPC3PJRNratv3di
	mNVxsZKjTGJer2l7DiWaF1VLmzohyHqt4Dj1NyOeUlzep93ZrcPZDfCEFeJcRP4DL6HeeUcUR8j
	4DJwTFblvzNJK3dlJksLUpVqgt9aXs6OjrKczyXybay2KduWbCY7JqlQnA1+GlK8kel/1NyEmrP
	NbaEexiiVGvlHzbL/Z34s5zBRwmhaYJlbcXSG27pEuyL1JdUH342XkNP5qCk+wMnLdmfasfULE5
	1Vv+A1T4xuD3oLz6aMYVdVjj6u1b99qSPAhALoldPgiSH+JxEiWp2qnZEzC7Sgxaiecoc3RxhKi
	wGwRvx6DNqItOb5ez00Ij0sDyRD7GAT0RvdSyZvi3wc3LMoI3xF2EWbk9++bZFB9p9d91CxpW1Q
	wjTPVWQxL7B6fTVNY2Es4VA70C4=
X-Received: by 2002:a05:600c:8b14:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4980c66d8cemr92180515e9.4.1785625441583;
        Sat, 01 Aug 2026 16:04:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b59a33sm90607585e9.1.2026.08.01.16.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 16:04:01 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] Improve stack depth verification stats output
Date: Sun,  2 Aug 2026 01:03:55 +0200
Message-ID: <20260801230400.850271-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=memxor@gmail.com; h=from:subject; bh=SBDelu/TgdsgWx9C5dwSenUmjI7PREuq1e4+fyAPenY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuvqmPTzfSE6ybr56htEQmqmla6u2/RiX/bkgRW8f/2O Obu6P+ro5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPJZ2BkuPzt12E77RtGn6XC ON84rZD1WbJO8PMlFQ5m/bU7nczZWBkZJmuvk5xx+n/Inu0XDr647rL3yxS1/9NntdScNCz8LWW wnh8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some improvements for more clarity in the stack depth verification
statistics output. See commit logs for details.

Kumar Kartikeya Dwivedi (3):
  bpf: Show more useful info in stack depth stats
  selftests/bpf: Adjust veristat stack depth parsing
  selftests/bpf: Test stack depth stats without BTF subprog names

 kernel/bpf/verifier.c                         | 16 +++++++++---
 .../bpf/progs/verifier_basic_stack.c          |  4 +--
 .../bpf/progs/verifier_bpf_fastcall.c         | 19 ++++++++------
 .../bpf/progs/verifier_private_stack.c        |  9 ++++---
 .../selftests/bpf/progs/verifier_var_off.c    |  4 +--
 tools/testing/selftests/bpf/test_verifier.c   |  5 +++-
 tools/testing/selftests/bpf/verifier/calls.c  |  4 ++-
 tools/testing/selftests/bpf/veristat.c        | 25 ++++++++++++-------
 8 files changed, 56 insertions(+), 30 deletions(-)


base-commit: 28e911d61d66b92a3bded8b54622ed3cd2795bf6
-- 
2.53.0

