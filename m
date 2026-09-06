Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5272331EB0;
	Sun,  6 Sep 2026 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734046; cv=none; b=S+HBSceIfWKXjc+Pq67+iLU0jDmIQjIhekRQuDpqlpmV+Ne2KUIwYZGV6O9NK1dIFwB/qqxcmMfDKnwXfIwrMsAX83tJJZ6MNtGhB3UNJgdfgxmXywnuCvIcXfuLIo28N3l35rZharJtxnFxNa3cqskdcT7mpjldHovNb81+VNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734046; c=relaxed/simple;
	bh=XBy0VcovaU4ItO/ghGaC7L7fQ7lOeCzSb3Jf5Kd66Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzbyJw8b1+NrqMsSOCH/vZzLP1m47fhnry8SbhauPmaC5PGFfsIdjYISvvYKYlsyUsc1Sti/YGW+c0dE3TaG6FcgmC6elo+rKlzQhVE305Jhxi1l6ZZk4hVjky00KUOIlVHjwqNgCX7L9srEGW6/4huijj8xK8u4VRx8NIvo7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Nju7nCuv; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=82wiqzf0; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Nju7nCuv";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="82wiqzf0"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788734039; bh=pUNc+A4t94f6TwnwdwgXfAA
	dye5zpzhXS9o4iV8CRMk=; b=Nju7nCuvNnrOLF2VSm0KincQMdeuJhKqJdAC5VMSrh73LMIIOs
	rQNIceoh7c7geqBiVOOavoMSYOCTMa+ynGcH9j6qXQzOJAe88yW6B82j7ROdN0VB0bBmBUJ2xkn
	qzxg6/L6GFC/cCaaeIKyi0LqfebUnYKsZKj7P4/dnhKU0R60Z6R1pLCKcZSlKoTe6mK9zjxzbl1
	v+/GNnw54T1G1WYlGSFIab1HpL8Bozlz+fVzhTvi1qhb6KSLbp5PihebYO1ubWOGjfjs3vhsOhF
	6QReuMcQjmMzR3FU3ibtkY+EGzcxgzeQwbDJi1LpWUmrhPfEsJnKpBJ4iEcNnHUE29Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788734039; bh=pUNc+A4t94f6TwnwdwgXfAA
	dye5zpzhXS9o4iV8CRMk=; b=82wiqzf0wn99F5Ls8Vd0/bBr08DBe0nlD16aqgKjCxSN+NtfN8
	I7dmHnzWzeU9n5eqyvaHl7htIu+YqZP134AQ==;
From: Bradley Morgan <brads@mainlining.org>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH] bpf: btf: make alloc_obj_fields array const
Date: Sun,  6 Sep 2026 22:33:58 +0000
Message-ID: <20260906223358.25717-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alloc_obj_fields array is never modified. Make the array itself
const, not just the strings it points to.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 91b8ce77f699..d23282e218b0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5766,7 +5766,7 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 	return btf_check_sec_info(env, btf_data_size);
 }
 
-static const char *alloc_obj_fields[] = {
+static const char * const alloc_obj_fields[] = {
 	"bpf_spin_lock",
 	"bpf_list_head",
 	"bpf_list_node",
-- 
2.47.3

