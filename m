Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BE39184F
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763793; cv=none; b=NVxyF1p2A3NXPJSQe2pKGH1cD+2ZZbqb83TyV9ucskFKTVnwF3U645r+iEtQh+JfD8bIdP0CgB7rr49D+QfElzJWoQ/nXrcn4uZuK+x0Nl5g2SPH0/rSRIl60BdnXTpDUVmqx2hd4gdg69gl/uJbMaxzyFdlGh0ZZJoQKh5pisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763793; c=relaxed/simple;
	bh=2766B3eMmFd/OaLBWXRn8QBlE+XKdud9wFfOhEigG4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=td0NM5i5gB1QwXuNdBqykdCp0srVBr867JwmM4vZ1KOUA8YaVHuAB0G6fDq2NVOdtyvwXZvSevKa8YgrrO7lTENmyBu+5FmHs5VfPb5cxE/uK0zD0Q0hV5kd++1EwrMcyH4yCBk+1rFpDvxV56JVlIcil8qbYkFv4VcKChsPpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va9REisD; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va9REisD"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso3081393a12.1
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 23:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763791; x=1789368591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbyN7tVnWnxYp0pp4uHeU72ENpo3XFInJUk6Uv6k4kM=;
        b=Va9REisDIHkLARUvuc4c58/+a0xnLZZlUmKfjNnOVeUdYOYmUVIL8Nndnn0yvtP1wP
         ONFjIEBuDhP4IepPC32HlRlh0oI0I4jhTvO/f+QA9UMk2UVQF4lLfLlU33ukS04RCdlO
         0aNFXa2UV0gXdG9wQ8RU+VUncPM+61MLGgjzSTyrjnvrVwv0ext6F2PqsxSEc82uNJA4
         mkwNA5aK/Qn+/dzOL0O03I88mnBAa2iLTp19/ZOuq7VhUZIL3IkPhNMjElC+pG0uGDa9
         FEX9QA18Qb5NrDDK3d15F0DGgF0vw94JIdLqYj4M+qYV9wQo7x0HP4NlT9Tg+mw9DbxM
         nvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763791; x=1789368591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbyN7tVnWnxYp0pp4uHeU72ENpo3XFInJUk6Uv6k4kM=;
        b=PFOHfHnvOZm0ME8FNyfassNoIxMeCGKM94dhjvO/QoPus+H4xLDeV9qmGB4wZcQI6J
         9PCw5KB+JeSFtCuq1IiGGSm0/RHSr1d2sYVeJCiv3wv3v5jyTTt0MrVNDanL5xtWayGN
         //xJTAEqE+4w8OTPa+qxu03eJUFMeAGEQQ4JXwUF8+iMhCTCnGU5MREnOrYIHewK/iQ5
         70PdIiL1Kyi9eoHdupgAeBGb8Bu0gnjuqDIEuAdkN5JOS2LCywz6Ry5xBoTKYubiXbfa
         JcQxT7AJkMZESPZZ4Ght3FqYz5b6qJBLQM+5XIMf9pqjAPAghVTgL+S5fbLGkqRQDSq7
         JCiQ==
X-Forwarded-Encrypted: i=1; AKwUvByaiWW+shDBoV58rZY89cL7MY8MhMdyWkGzpcyTa7ZyANvN0aTkYJ+4t8QMfD+xSzyVVlo=@vger.kernel.org
X-Gm-Message-State: AFuF++mtLsco3FDTAuAVaZi9YYvgc7bzYCGuOGCp+uNVmetvJfIHVDn3
	N188LzCdaOxtpmbNwCxmBRiGrdxfln93x4FnUpeB2GpO9hQofVJOi4mC
X-Gm-Gg: AYBFou1vtj7EoNgIo2U5h6qmQpz56ikSDlIdfvVhOXc2WEZZCav447XgRafzkEcVLl3
	LONVrkHGxPF4HDpeL0rWbEBmPOtrhtii2ytRHYcPX9Wwb3l2AWmFhx6mEXPChGLFLsUYOWD4/w/
	HgjCXFoIEnEQ3yXN5uP4SF6i1Ym6TUf+P1f2S+WQfYhPKnOsIDcBr4JMQw8cfGvYp0WOiE5IDmI
	l/zPIDRiEh98Ot6vd8LXFUAGerhxwUgUCW6haqIQO7/GTJA0WO3UFNn7Bp+8sBph8WLOVVJngzP
	9+UsFXk53V246aJ+Ea0F3vPZ4TrZ7dGyU5YprmHIBbSgTf6yK+Y4sk3Jd+w2gqukT3cUAvGd4S+
	BE2d7Wre2nCawn5w9gP0gON2HjA9girkz+eUlPIbJISISN+MH8R5Dwfo8whJV7m5q7Km8N1Ah5Z
	jEXK1JXH8NPnysA0UPCrBdkGJ4g0MKamOU+HjPX2rAAGNul1syEH8kR5smFRCEXt4W4YxaqFCCs
	Hg1jzDCsjqM9g==
X-Received: by 2002:a05:6a21:6110:b0:3d1:3c2:85b6 with SMTP id adf61e73a8af0-3da39b43743mr33286987637.5.1788763790919;
        Sun, 06 Sep 2026 23:49:50 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm465210eec.31.2026.09.06.23.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:49:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] sched: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 12:19:41 +0530
Message-ID: <20260907064943.25304-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corrects 2 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (2):
  sched: fix typo "upto" in comments
  tools/sched_ext: fix repeated word 'be' in comment

 kernel/sched/ext/ext.c                   | 4 ++--
 tools/sched_ext/include/scx/common.bpf.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1

