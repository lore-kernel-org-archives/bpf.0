Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA23CA4A3;
	Fri, 24 Apr 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045152; cv=none; b=YUcD0+Xuxkyjol+F/39etDQUH9RNgV+aXBcYHmqTzqJOn5Mlb6/ASeQ5hgPQWXf8XPXf/pVa7mMTXDGhitk6eiEHHEbMfveizn/Dkkvh6dEKc3kvYQmcPojNH7/GbNBNIfuinduxRJL+Dl8/hZJyxhzycbFvzOhcV9mwPmEzmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045152; c=relaxed/simple;
	bh=HquodDfiZUv3PlNPjtYzdljXCR7R93ZhvNKOzHrMgcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o391zvJ6MTHE6E3XnJb3JP46HBdFs2S/LBsjpZzOkdHr2wsGcMXWWe5SklPj69B9Kx0mA4Zq4inSGAP0FCLIiNQsNrrrTd7ePfMv+udcN9i/FJJgNAO3XwCDzlUwswonlJ0BSwGU8UKgQIN2hvq8fj66yLWcQJMFdpbur4UShgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEaWKgL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEaWKgL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2CAC19425;
	Fri, 24 Apr 2026 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045151;
	bh=HquodDfiZUv3PlNPjtYzdljXCR7R93ZhvNKOzHrMgcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GEaWKgL9vrqAHPkO+MVFzMeq8PQew7zR3rnYEU6g4kKoXM5UZ/yGSGrh9RVnUD2vL
	 OpEc90BHyaHgqs1gWKDo2j98c4ITcYaZ14lZBdt0jRhaRuF5qV5FApOHw7fOPdBZhB
	 X5RVuBszMVrrKjaeom7SUoa6G+6pnq55SUZXYLkQ3nrAOvhZECI7jzQjwiwGWfW8ij
	 V5pPLB1T1/yh/joDDWo7RwO7we5WbEnBx07q/YE3m5ZS0L3tJfY+7MAOGiqgLr2xlS
	 pV6DxIE9GKx2NLmjx/K4tKCtDFBeurAj5f2wPxS3/sn7N+cnS3lvzidNOmT1d4aee4
	 LpipuCYZMjJvg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 1/2] bpf: Do not release trampoline image in case off unregister error
Date: Fri, 24 Apr 2026 17:39:04 +0200
Message-ID: <20260424153905.354922-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If unregister_fentry fails we still have trampoline image attached
to a function, so releasing it could trigger crash. Releasing the
trampoline image only when the unregister succeeds.

Cc: stable@vger.kernel.org
Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f02254a21585..01082ecc5c4f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -618,8 +618,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
 	if (total == 0) {
 		err = unregister_fentry(tr, orig_flags, tr->cur_image->image);
-		bpf_tramp_image_put(tr->cur_image);
-		tr->cur_image = NULL;
+		if (!err) {
+			bpf_tramp_image_put(tr->cur_image);
+			tr->cur_image = NULL;
+		}
 		goto out;
 	}
 
-- 
2.53.0

