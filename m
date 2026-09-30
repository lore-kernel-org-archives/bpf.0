Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE964F5DFD
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774497; cv=none; b=qyJ1pcuuVLEdJb5QetBqvaQ5cZIvv8bhUYCiwqGQWv7vbPr1r0gX7vQo5V0ncnSxiNdMoRyNqQOxtoXwANbbfXqrfu5yNoHus6NKXXLOjxbrEt0hzS1i4VocuApCn9y5QtgKH63N0rEFN7NY2/dWywxHND9AZmXhXVIxDGEpcz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774497; c=relaxed/simple;
	bh=KF7dDOx7DaLCNyQNSsul75suel+43Q9ip6d+eR3BH5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ljQocspMuqLx462N4O8vghMa+gec0vrE5IVk7tvQuxiSTs8JTdeHdKnuU6OGhTQVFPIfLhmUCUsZlwyBJa7jbBLWJ1TM57we28jgL3ZOXrJTfvgUdxWCqOEHOzQ7I+OjLaMDYITrgBVjCk5Y+Kqu6Z26Km+APHRdtDFo4/9UDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fplhQ7qS; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fplhQ7qS"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af929e59dso1132802f8f.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790774471; x=1791379271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tGm+gMifQidcQlMxmJXtxnGy2ShpN9JxNJdyz7K8Aho=;
        b=fplhQ7qS3y/WREvjdvh6RXRkRgvXvOtCsOAJdGliy/q96tIMygouXNL24DOTuVX/RD
         WbFpOOzuxTnz/r2T7sKC4GDLCJR2SJn2xcBrie1wfijTj94dlxbFcG77S17im+QNnTFL
         gbJnqQNzokUkHi/etgwrVSMBDEo0hOrh/IG48vSzxaD5v8iM/l51yBFyyWUSV8na+Rn8
         yrZxgsyzRgsTQQiN10nj9ucLYzcf6Yesn/qq0wwu4fHe2avjVQTJ2ilxDUgCmtuwJPUD
         MbeLhWdWuhW7ttkYDOndOK6sdIeUtBoOARJILgDpXcrtAslNVUSGeb18zZbPUcJVWYPV
         Bgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790774471; x=1791379271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tGm+gMifQidcQlMxmJXtxnGy2ShpN9JxNJdyz7K8Aho=;
        b=SFBSAt73683dtHJlpTBiuj9dFPPhNQCaRgnSNUCqmHXKQeoDT5vcBgoVZyhzxxxOxe
         gizFe80vrRSLO6qiHmf+yZYTQSFU8RPwrWfv3gzID3uutPOxBAymhn5Y6z8PUP8swkHR
         3SNG5gfOOFzYD/8Kn9o5yeeEyH1Py4x3X3yxGczz65r01AKvtJWjGPZw481DkQnu2Wnr
         1hO/em77j87B6p86bBOUXapiYMYNm0zlR/GAG1fZyfbBx1zuoma4GhcdKGH2CT+u2H1b
         bAfgCCkk0SLax5BAe9l0MWdJsTNK+N+gOtcl2dnnUGnNFPM/hDLyR65nXqbyvxA9L1Te
         hf/A==
X-Forwarded-Encrypted: i=1; AKwUvBwC7kL8oN4IlZLuwA8uQzh7HvV66/j4ExkYkrFdBNEyKzi+tJIJGnhwCVG8xUrG4XPZBxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZPemJPt5IGr2I14nSsu3z+PbRr1J6oTYsXKKiYcA1t92UMI5G
	rDnKvQpEQNaebBacnMnZbNOdJ7yBW4YUfRQ1fvXY+WqWQ+LfhAmINCXc
X-Gm-Gg: AYBFou29YqcgjRCiVLwlWY/ICXqYZCxmufWBevoxskB3u1W0sfzPWV7tYdcpvrPqBBB
	9uwpGqnuWScmsJ2DNGKdMr3e0ZTwazu7P+8YyR6kiaGvDupb58FygqFT32WcnPI3WcNW2mivfwW
	lol+mlY94gWxiNcI+oQzlD69zuOjkIyrJPEyCGzcTVQQl6vl7Zw9oCTJxlz0kc5vDrA2lmNSsMT
	8qtSisP3Z/8bx7jjwtLqRmnM8OTAmf1fWxCmByAJdOr7cMXD2zHR5fq4g3VORBViPRIbRzUrAjb
	puwWAiHxKqm3qcHLT6Z+uaXrHjLtIebQVDx5DD1hDg+VZi08AgrZFBTq7lnRdG0MCRXaDcyS5L2
	Lr2Ae4aNZJhc+9rqb/QS5WK6q4xsBo07FvzzMggZqXsXwKMfPcfEnrRPhj4dDaTpRC2uYiWBgnU
	b6Vt/LkgUxdQSZ7cQKJdnQStNNiy8hBGSBKel4yu1yp+vdz3ztMvSKzfLTau9jYqWNcFmykDmma
	Jv6RYgsrObiPQFLSjytmScHU+UX9oFyjlKmH9BObhih5NdYMRUSxXA=
X-Received: by 2002:a05:6000:2284:b0:488:8859:b0dc with SMTP id ffacd0b85a97d-48b02554433mr2945079f8f.56.1790774470878;
        Wed, 30 Sep 2026 06:21:10 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029bef64sm5047284f8f.10.2026.09.30.06.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:21:10 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH next 0/2] kallsyms: optimise symbol search by name
Date: Wed, 30 Sep 2026 14:21:06 +0100
Message-Id: <20260930132109.260597-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is from Jim Crome, included so the patch series builds.
This is currently in mm-nonmm-unstable

Patch 2 Removes the linear scan from the 'search by name' binary bisect.
Data size unchanged for 'sane' kernels.

Seems to work (I'm running it on this system), but I haven't got any performance
numbers.

David Laight (1):
  kallsyms: Optimise symbol name search

Jim Cromie (1):
  kallsyms: Match compressed tokens on the fly during binary search

 kernel/kallsyms.c          | 171 ++++++++++++++++++++++++-------------
 kernel/kallsyms_internal.h |   4 +-
 scripts/Makefile           |   1 +
 scripts/kallsyms.c         |  50 ++++++-----
 4 files changed, 144 insertions(+), 82 deletions(-)

-- 
2.39.5

