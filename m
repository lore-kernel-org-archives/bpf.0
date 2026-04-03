Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB101346795
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180676; cv=none; b=WW7PUmk5BTp5YgjjRGjO3QOoDZikf+p1MVGJ/IDJJpfK2dGQ2eURWjc2Yk9sBy+Q8JCt1Dgrsnb87ir32IZrbDqMuC7LXELjs/fzWQ9Pj2tjbrzwohjVvlmTqK+ig9A4a/JxYpzQik9KGkNzR57euMzgVvN69P4TYWWoc+eWWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180676; c=relaxed/simple;
	bh=HNYcmEf7EiwkfDMvJpQg7PP+wKq4v1XKjnMsfGqn4Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Io184BtRlFhlAIeVGEcX52BO7lJUNCNumnyGSAeAUf4snPhv/pc+9yiZ2nMIw2krY6x7LLUKUBpc+tq4BIcs80bh4la+JLL4LRJsiVb+V4oIzfgd/oTTEfTyE7MxvTvrQvMGWnCs0TD4vXsWa/YkZ+zRoblZ35fYJxLgAxG0I/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVEL7NcP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVEL7NcP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82ce0a9b3f7so672889b3a.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 18:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775180674; x=1775785474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9dV+yx8nNSmq6oEE0Ah8bgFUDuF7POWFMUhV1AmL2kw=;
        b=YVEL7NcPr9YE+EBxgPPrEvx0dywqQOOwp7Bsk2BgqBG7judiSmF4cQtoT2e+4rJekl
         3wjwNAILrotYoBcu8xGbIwxPbJ8q0j7SzBnO+bWKFpNn8doyRym8cVghqmT0aUx/MlvQ
         HT3rAMt1VGQVWyDSLAXfAMB6Z7VNK6g05md4kTW+cygUS6WQvFWsMazkAnhJR+KPqs+m
         9zT/UC4/BWZSlWuYUNYp0k+eHgAWEHTV2yaMA3aKxUyFMYn0uLcbxpaFvjqsoqekIqs8
         E8kovQ9kVKrxfbHnO+eIr3Zr7hQ5rUr5NOfYm+ki2kxuNoBbYC8BokBg5uCp8hABioad
         AmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775180674; x=1775785474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dV+yx8nNSmq6oEE0Ah8bgFUDuF7POWFMUhV1AmL2kw=;
        b=mGE4xQy1PIhOw9lS5h/oNECQsqBN1Yudbrgqu0xibtY4BQud0aRfXk8jMmINb/RpqE
         mZGW4at+TJKEcLUKCvqKcLy0l0cj6dteQb9gCCa61Or/r8W3m+staVi96+1S5zo8ts/G
         h+EttzTovBJrOXnVXPphy6l0LQHwJ/omDe70s1+9Du4ISuRjfIHSG25mZEKYOeiwfc2S
         uETiDbCg7h4LZXLCJsE8XTmK8gqyrGJe9bmVO/RxPHpV/ikuIB/DsLdSRJ0JNogOfNa+
         v24z263JB8zeRJiFS9vP4JFWKm4HCXavns8j1rLxJgKD2xXYb2MizPrq9oXiyoJKhO3a
         Xc1A==
X-Gm-Message-State: AOJu0YztshYAT4gG8PMPQFNE5lIJOuWdtVqoqgGBUe+JsRP68Mb4Kbua
	aX4V83fBODXMDCu1oRWQaF1CC+3kkNktgCi1IS01jIS7MI4gQirXhmJd4t4QoQ==
X-Gm-Gg: ATEYQzx7UlTKGoQDrf+WheN+xTUmxQijo3UQfAqRyvVXydER3Q1MJH5E5QZdtfMeojv
	/Z8ZqzKtmtKvtSUqiYW6ehnBYGH30nFwU2g5iZ+b1UqppzZBchzdiIU3tZsSRxr7YLAXRWG8+BW
	0fHHWF8i3zVRdmLQbq3hrFmXkZh88U4P/MCvykTueYXaiwwx9AHNBig932RtOpqjmYhLBw5PpTF
	DGahSGoA+PilMjQdem51WBtOWrqw5J5Qtngmrhf5zs46m/qWB8l9+OAUqE5CpqkLXV/sZEU1gWQ
	d+sllr6Ob+fHeJtdNuB+UAzPZXeKJ9OSqgawwOh5OAUKQlvp8ibI5Bxnl8m1JxEJo42taaFw1dS
	9uUKXjqNm/ka5e7YIKtKUn9kOqpry8XJsOupmupue7rLZceCaGrh7wFRGWGAUXt95pFlBelbOLi
	8xTLmGUj5iIKSK8g3bk5LCydFfwHm3jOYm2ZeYlb4qvBuN9A3nQkX5Ap4AbMFVYdOhCS2rtFETE
	rJzGjrJXJDH8eFV/tOGA2v71RNCimfaSI8s9Ni6bbGuO84dLOgfSAJXBgs9LfxANzFWycJ4
X-Received: by 2002:a05:6a00:1405:b0:82c:e39d:b845 with SMTP id d2e1a72fcca58-82d0da3dd42mr1090097b3a.4.1775180674048;
        Thu, 02 Apr 2026 18:44:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm4364634b3a.61.2026.04.02.18.44.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 18:44:33 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 7.0-rc7
Date: Thu,  2 Apr 2026 18:44:31 -0700
Message-ID: <20260403014431.67976-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit dbf00d8d23b43a7a1d717e704c50651731d01d71:

  Merge tag 'fs_for_v7.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2026-03-31 10:28:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to e1b5687a862a43429f1d9f69065b3bbc7780a97a:

  selftests/bpf: Add more precision tracking tests for atomics (2026-04-02 09:57:59 -0700)

----------------------------------------------------------------
- Fix register equivalence for pointers to packet (Alexei Starovoitov)

- Fix incorrect pruning due to atomic fetch precision tracking
  (Daniel Borkmann)

- Fix grace period wait for bpf_link-ed tracepoints
  (Kumar Kartikeya Dwivedi)

- Fix use-after-free of sockmap's sk->sk_socket (Kuniyuki Iwashima)

- Reject direct access to nullable PTR_TO_BUF pointers (Qi Tang)

- Reject sleepable kprobe_multi programs at attach time (Varun R Mallya) 

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (2):
      bpf: Fix regsafe() for pointers to packet
      Merge branch 'fix-bpf_link-grace-period-wait-for-tracepoints'

Daniel Borkmann (2):
      bpf: Fix incorrect pruning due to atomic fetch precision tracking
      selftests/bpf: Add more precision tracking tests for atomics

Kumar Kartikeya Dwivedi (1):
      bpf: Fix grace period wait for tracepoint bpf_link

Kuniyuki Iwashima (1):
      bpf: sockmap: Fix use-after-free of sk->sk_socket in sk_psock_verdict_data_ready().

Qi Tang (1):
      bpf: reject direct access to nullable PTR_TO_BUF pointers

Varun R Mallya (1):
      bpf: Reject sleepable kprobe_multi programs at attach time

 include/linux/bpf.h                                |   4 +
 include/linux/tracepoint.h                         |  20 ++
 kernel/bpf/syscall.c                               |  25 +-
 kernel/bpf/verifier.c                              |  37 ++-
 kernel/trace/bpf_trace.c                           |   4 +
 net/core/skmsg.c                                   |  13 +-
 .../selftests/bpf/progs/verifier_precision.c       | 341 +++++++++++++++++++++
 7 files changed, 432 insertions(+), 12 deletions(-)
