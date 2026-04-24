Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B53CA4A3;
	Fri, 24 Apr 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045164; cv=none; b=q9e6M1yGubNTEZelnw4MEFs2eVyRGJJQj93jOhM1SP1hm7I96EuR8jn2ArpGmJtbciLkMsXid7x4y4OWUE6/BnI1P0QOIYwOc3xL39Lz75IZnj7BBcfMy8+Op2DjOyEBwfZfC6IDNu8/+0xIeSpjp/fpHb53k708Ux7hf8RjgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045164; c=relaxed/simple;
	bh=tmWBlnkUF+KIWFqyQ1a6UluxEIi1hBZ+PojJ1YpsTsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rl/e9JAC4QBvXCRII2v1rQiR/G89ZoIidoGemMJ8t0PF6lPRxAEgFHEjLVJd0GCEsy/JiEdLjdAMfXxTg9xQZjnrtrIqt/i4HQP2+AZR9I/iCAiajDSr0tF/nISj7jE6WRjTQQ4hRfDW2+94OwB4niouWDEmoxwgxNkPJKnPrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe+47rlO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe+47rlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84266C19425;
	Fri, 24 Apr 2026 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045164;
	bh=tmWBlnkUF+KIWFqyQ1a6UluxEIi1hBZ+PojJ1YpsTsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oe+47rlOFc8h85wOu+a1WFDCD2qOzOH0mrY5T+TEDfFqSAyzVJww4k7NPbOyjWi7W
	 PYzHRlQZBYWVn6gRO752Y7RNHgQgGAXoN7yl7LARv8zGb74N5n6Qg7DOTLp7M1xZib
	 Hla4S8jSq5xKn5sNGc4/tMmUuxnbn2PcRrQiFNTImV5swlYkMNoI4mbfzNAVDg4OoO
	 0FQRiyRn9P6g97+FQb2KbVoQ0ueQcV38A5qox7PTtjS1UffqReEzLq1mgLnW9gxSrD
	 EDF7WnVW9als92nJVL3rMe3LLDKDaXQBiwNMWFNqegScDfRXUT8LNBXOWqot4Flgr9
	 JONfMJUcTg6jw==
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
Subject: [PATCH bpf 2/2] bpf: Remove obsolete WARN_ON call
Date: Fri, 24 Apr 2026 17:39:05 +0200
Message-ID: <20260424153905.354922-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424153905.354922-1-jolsa@kernel.org>
References: <20260424153905.354922-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WARN_ON call in bpf_trampoline_update could never hit, because we
direct the code path with (total == 0) to out label, which effectively
skips the WARN_ON call.

The WARN_ON made sense back then when it checked tr->selector, but now
with total being set just inside the function it's useless.

Cc: stable@vger.kernel.org
Fixes: 47e79cbeea4b ("bpf: Remove bpf trampoline selector")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 01082ecc5c4f..c09d64b83fa4 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -687,7 +687,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err)
 		goto out_free;
 
-	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
 		/* progs already running at this address */
 		err = modify_fentry(tr, orig_flags, tr->cur_image->image,
-- 
2.53.0

