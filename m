Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612723;
	b=v+7uRREbz8raSmDf52vVFAdOVA1U1es/N02XTpodeVU5YKiP73BOew6YxIc34Id7bcPz
	 kyZjrJlWSIfJXVLlTQkI5bc5++3BI+es9dQI44OIgCUVHTwSPEufr5q56RF0sqzHPcng0
	 IZiIUnge60HhbeODzZD1XIgJpQ012GTuTtSDVNTQ/iM9uOp+fxG2N/N0fUtr1xw6DBcOR
	 +oUHdaxWUT/CPVStEgt21BqZ/VOc39cCVqcJYARL0fqllGPotDgGxWDx/JmNw6S3wpD4n
	 DfYKaF/5Tez3tPOkVUoad4qQgMmPcjgMAineh4zoxVKSY+uAfSyWek68Y3hEpAD0HKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612723;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yAydzIVAoeyERrjwsju4GbQSFXyp+3uvSqDPl/+MC38=;
	b=3qXytl0/RxnDUGOHtj0FHK9Ghv1ApLrgSpDg2DsU+FKpSyg1Fw9ossGNwnF1cvnKUT/i
	 0rIjqlSE52aR3xWzHHmUFqlf8IAogKqVF2M7vE/IqXBt/jM64RVI/TgfZ1DLq+TkcbMOF
	 HYP0yeohEE7zfXeOio/K5U8Sdj22IEIa9i89oF0FpLk5EH+7FcLX9mNu6GH1GbKYENvUP
	 56YpsbbWHjS2cyGMJfX69jOyru8vIqFDmfnAr+lPpxo2mBjJ9vcyLJN7pvU7UOdnzGhN0
	 szRSLw2MCpmJxvaPBUQPcZbz7kwK7MKWHBycWhcTi5IrdCb5VkwIfTQkpLBYrrrc0VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8263bFw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB544606A322;
	Wed, 21 Oct 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8263bFw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A431F000C2;
	Wed, 21 Oct 2026 19:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612722;
	bh=yAydzIVAoeyERrjwsju4GbQSFXyp+3uvSqDPl/+MC38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l8263bFwrjWQCX3skqmlYw9DM0UQgw+9ci9Lt62/2mojFUV7kkvumXst7+UErRWp9
	 IINsXsZnkTi+e+xRuxpg/j4lucDxk5ISFSK5Q0je5vVM1l7G1h4C2H53E5vPbWRPe8
	 DRoVtHs7oYWlCiZwf6deKaTupTnx7nxYuKH1eTg4XJ5PTv8/uw4fhwygv5BzQvDjW1
	 qzKJ1ihZA96DUzQ/52wxhYsczbXLEpXyLvqisiLaLWg2Wrd24NLeZPchZswFJ1Tqhn
	 b/Mf0diwZsLoTHwvZ1/6naes9QMbn8NUxIM/v577i+6DICb6m7iGDFLIAN3wYhi63K
	 VevkQqnwtjBxA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [RFC bpf-next 3/9] mm: Expose locked mprotect operation
Date: Wed, 21 Oct 2026 21:57:52 +0200
Message-ID: <20261021195759.119421-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021195759.119421-1-jolsa@kernel.org>
References: <20261021195759.119421-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_user_page_exec() in following patch needs to change page
protections while holding current->mm's mmap write lock.

Exposing the do_mprotect_pkey_locked helper for that.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/mm.h |  3 +++
 mm/mprotect.c      | 20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 63f40e615754..47e853093601 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3435,6 +3435,9 @@ extern long change_protection(struct mmu_gather *tlb,
 extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	  struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	  unsigned long start, unsigned long end, vm_flags_t newflags);
+/* Caller must hold current->mm's mmap write lock. */
+int do_mprotect_pkey_locked(unsigned long start, size_t len,
+			    unsigned long prot, int pkey);
 
 /*
  * doesn't attempt to fault and will return short.
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 2888ee638d87..8d800830d3e1 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -868,8 +868,8 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 /*
  * pkey==-1 when doing a legacy mprotect()
  */
-static int do_mprotect_pkey(unsigned long start, size_t len,
-		unsigned long prot, int pkey)
+int do_mprotect_pkey_locked(unsigned long start, size_t len,
+			    unsigned long prot, int pkey)
 {
 	unsigned long nstart, end, tmp, reqprot;
 	struct vm_area_struct *vma, *prev;
@@ -899,8 +899,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 
 	reqprot = prot;
 
-	if (mmap_write_lock_killable(current->mm))
-		return -EINTR;
+	mmap_assert_write_locked(current->mm);
 
 	/*
 	 * If userspace did not allocate the pkey, do not let
@@ -1013,10 +1012,21 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		error = -ENOMEM;
 
 out:
-	mmap_write_unlock(current->mm);
 	return error;
 }
 
+static int do_mprotect_pkey(unsigned long start, size_t len,
+			    unsigned long prot, int pkey)
+{
+	int ret;
+
+	if (mmap_write_lock_killable(current->mm))
+		return -EINTR;
+	ret = do_mprotect_pkey_locked(start, len, prot, pkey);
+	mmap_write_unlock(current->mm);
+	return ret;
+}
+
 SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot)
 {
-- 
2.54.0

