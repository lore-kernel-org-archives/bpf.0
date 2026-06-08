Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D723DB630
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930125; cv=none; b=OM041eMgULR+JYMKLmxA8cA7IVAY199b3jtMrfk6bcKdruGnUhgHQ2hiby+AO/3P6VHxhnR6yp/Vah24guJRhcrrlMYUmfjm2vG5c/pX0OkrtMCKQubgkVZuOyKemagdNM31VpFFLNe5JVSb6d2UYGd0DV0bjopqSJw3vYIailc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930125; c=relaxed/simple;
	bh=Na2LsqshzRv7AVoWDWwjSMckR83aQ2do/o9XY+EH+XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaKzDIQe+ULMxVxpCEMVx9x5MQRFde8fxRA55x4mXOwAd3s4f5He1p2oP35O4sICiLeB+EDnUeaDkdB29lLDbmQTT/3Icrq76x/fSEtcua8xCM7capYFjP93obFLAefFyr9wMGa8DXHm64Hz0ZN+1KSbq+3LzEO2IlXo7e4yEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNhj3PB6; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNhj3PB6"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so14175625e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930122; x=1781534922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsi9K/zIIJIB7ZfPOehP7bemxzVh8aOQ8gPGkf0Wdng=;
        b=BNhj3PB6WEwyYHfamxbKFhDz7lka/nT4RwxClgKoB8qYi6lOp0bWit+iiPm7R23wEH
         nEpRIwAH2evlpDg/cxrzJYMzJlTJX3SuqhpU1tWDURbAftxn0auB/Le6TEzvyhcO6VLB
         7U2Ve1W8UxGdopdYlwB/4nKRo8pcoahqAYI6n4MIR88lI1PXCCgvFZrtggxtxcUWi7DU
         O84eyf10vUhsOjhsd+VgTVqkmKaWqGmvT9vXaGK/nMyvuIGPER1+f39LhzL7TPORIroE
         P9ss5a2nmxK8QBnZdR4nV2zPL3Xwa3AqtY3ChqFOrFBSuLaQqR408vJJOTrNHImRFBGu
         MYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930122; x=1781534922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsi9K/zIIJIB7ZfPOehP7bemxzVh8aOQ8gPGkf0Wdng=;
        b=d5IhUNfGyJzqXHt7VG112H7X9V6durf6joGzc0HdmbPEcMNRWVyTDAjegto+0WzGnX
         FkivllKqp7PXQeWasqUclJAzwrwhZVhLlKCBoEmxCPFgC+C+z/hnh7Sx+8puKEaqOP+J
         4dRgrUsK4BawtBWqu54bS0ngOJueWO01e3aIbWPshHWUTvqVuEeL+Mw2vYRlwqbgiXww
         PG5OgNeVLwjHoJuQOiRRXDYFD+debPnzKOXMaoV3qs4YvXijBsoTuU0klN+QQB4rWvz5
         Fi9LhOc8W3hDhxI4aARk10A6OR9LYzL5WnTRQsWQs1/XGbcw6qFlt0RCLyXG2DZ/qYT0
         wMFQ==
X-Gm-Message-State: AOJu0Yy9W1wzieTWXu3F9s90ehMktAaKN4OW642uoD6S9EB3Sq4BGVz9
	9riRoUn/AAzt7TOeFjej+SoM+kXiHNqqc7Sy9UQ44fy7yxqHQT+SChgkjtr7G4bK
X-Gm-Gg: Acq92OFmQ1rJd0l5mR7sl0rWiCEX5SFUu8RQZxZoDrvTxwIq+n4MMgqGp75O4jX/3nH
	wlkwZtXtG9xsbcAB5s7E7FyFrQgxZNvEHG16/rgWCxj8gycI5O9lYlEGRlH2MQEiW4qFqN1cwE3
	WTK9o9BONsk9dCiqkPiuS5iGXQSf7TSyWB7hrouGq4116TCnVKXElf8JQXE3KOZ3bhuK4yvzmnW
	PpW+AJOsir+BdUZfPOaaQmryNrZlhAj660/JrClN4N6Ap4t11nMb2mKX7RFRPCFruJuAMeprTrS
	PHazt5Z+QV/6aIhMN4ltEFNerxbFXZD3kdEzkHX+pL+mcDfAXBc8F3tfgssXQYPUV+WEtWDiThu
	AW++vgBKQoDGAqOP30WpdHUVoNcy8k57xecJlMY10EXSvoRXj9bzJVzqMOoT7YhIXDa/BCpf9rE
	3F2gHbqV8RxZfEMBRD5PoF6pgs0IQsV5J5rcB6/ZGb3/OwzaN2FTSoxX/xbYsjgUWTl3bk0DG/W
	4YwhIFEsRkNdUDF0G9GDftI95FstdxNu98CJMOFKsv3MvU2q3X6BUmAD2Q+YffFbBXPL6omArvT
	Fn5zrX8SpS8=
X-Received: by 2002:a05:600c:528c:b0:490:cdb2:fb5e with SMTP id 5b1f17b1804b1-490cdb2fd19mr99661825e9.22.1780930121819;
        Mon, 08 Jun 2026 07:48:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fcf5bsm479008815e9.9.2026.06.08.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:48:41 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Justin Suess <utilityemal77@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/5] Fix kptr dtor deadlock
Date: Mon,  8 Jun 2026 16:48:33 +0200
Message-ID: <20260608144841.1732406-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=memxor@gmail.com; h=from:subject; bh=Na2LsqshzRv7AVoWDWwjSMckR83aQ2do/o9XY+EH+XE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUvtmmS4V+DXO6V7o/PSKguuFb+8Gu6QH+/jkXaTI9dAq 2WzY0RHKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJrI3gZHhoVTfUv/urfP58vzk OALsDjyfp79c0LQ9+AHzwyrpM6Z7Gf4X7c5eLLVvEj/PK+lJZxkLNYLfT32i1y/qsV5gW+bsFQV cAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Referenced kptr destruction can run from tracing/NMI contexts through
bpf_obj_drop() and map value update/delete paths, reaching NMI-unsafe
special field teardown and deadlocks. Justin reported the issue and
iterated on fixes in [0]-[2], and also confirmed the bpf_obj_drop()
reproducer in [3].

This series rejects unsafe obj drops from non-iterator tracing programs,
limits map value recycle to NMI-safe field cancellation, and adds
focused selftests for the obj_drop(), NMI delete, and recycle teardown
cases.

See patches for details.

  [0]: https://lore.kernel.org/bpf/20260505150851.3090688-1-utilityemal77@gmail.com
  [1]: https://lore.kernel.org/bpf/20260507175453.1140400-1-utilityemal77@gmail.com
  [2]: https://lore.kernel.org/bpf/20260519011450.1144935-1-utilityemal77@gmail.com
  [3]: https://lore.kernel.org/bpf/agyG3eQwgmoJwmj2@suesslenovo

Justin Suess (2):
  bpf: Reject bpf_obj_drop() from tracing progs
  bpf: Cancel special fields on map value recycle

Kumar Kartikeya Dwivedi (3):
  bpf: Treat non-iterator tracing progs as tracing
  selftests/bpf: Exercise unsafe obj drops from tracing progs
  selftests/bpf: Exercise kptr map update lifetime

 include/linux/bpf.h                           | 30 +++++++
 kernel/bpf/arraymap.c                         |  8 +-
 kernel/bpf/hashtab.c                          | 32 ++++---
 kernel/bpf/syscall.c                          | 27 ++++++
 kernel/bpf/verifier.c                         | 51 +++++++----
 .../selftests/bpf/prog_tests/htab_update.c    |  4 +-
 .../selftests/bpf/prog_tests/map_kptr.c       | 66 ++++++++++++--
 .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++-
 .../testing/selftests/bpf/progs/htab_update.c |  4 +-
 tools/testing/selftests/bpf/progs/map_kptr.c  | 89 ++++++++++++++++++-
 .../selftests/bpf/progs/task_kfunc_failure.c  | 43 +++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 13 ++-
 12 files changed, 352 insertions(+), 57 deletions(-)


base-commit: 50dff00615522f3ec03449680ca23beb4cfc549c
-- 
2.53.0

