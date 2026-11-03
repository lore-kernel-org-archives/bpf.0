Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716162;
	b=MHq+yvc0AQA8SBrKwofH7dQ17nB2a7ioXIabY3irUbU0wN43ymwG+k/Mh49qaX/WHzSK
	 JEHJUeppHAq3md7HXyFe3TburQVobGeG8/6xZp1JdGAsFBRp/gPquMAMVFQruRGc11jCa
	 n5PKM7JR1m1XlC9LG/gGfmb2x15+epmgJuuVpK29+739Jk/lAndLkzLNtj+L3cO6zBXP1
	 fbeMBPuqq+8c900+DpKubzuqzjHfjXIz3v11p1FQ6D7x/LnN7NyvANZMs8cNgSyDq0dcz
	 2a7Kbb2/KjrXGMHYUYBNvlNnMuI6A7qskLiLQ0NXtHgyhmpoR+g4mpmUmEIFcjKdAqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716162;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HVT/3/cQiw7Q7cMEYiLUSb89Iu5FJgQDmzxCqb5qGAM=;
	b=hvJzvn9cnk4UBSyxntS7LVUIS8/d36PYMOuaphkYt+Rt0gYhBATio2tSy556YwsFQhA3
	 dT1/ovmIvw9NlFjTW2FSoXevEkiQU+4N1X0EaFF3m2aYAXsjNYBMFhmkGRbUykqJEBTUS
	 o8+lsTCt9Ebfwc1gzUL7YXv5WW4biw4LWFin0e765iCX298u4YkSm8sy7KE3wiZJ2o5Iw
	 1Rei936VCHwfElvKpdhHcYabaypv4NruskvXFNq43AkSN9zcjeLazTSObUTXDMdBg5CSw
	 bozhWY7ZRrcb4yNtBUZ7MJTaafWxCP+F1WJ9d4GqzdmZvRqBJBtGdkyv9YR4ImBfevA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnULwmIo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C6606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnULwmIo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6671F000C1;
	Tue,  3 Nov 2026 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716161;
	bh=HVT/3/cQiw7Q7cMEYiLUSb89Iu5FJgQDmzxCqb5qGAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JnULwmIo/Roly8f7mJEAmd52JRVl6Pxhx5NTgqPRK/Nz+9xUIhsPhY/chts6tC/FV
	 Sj6CwHoh8BulV2fqpwvSEcJyjDyooQkqAgVgCLJs6pqvuw5MGNCrXoykwicFcXrAuG
	 AGQ7kA3d2zUnqc3Zb61t911gVDsDI3g8XLJdRBuC6EKEXLm/+p7ziIVblw8wSPS1ek
	 vMBgnDq20mjRb9fYaMwioAbWv0RLkXtZFUbgHdqotQkL8bPuUZhWIUFWtH9kmEw7fL
	 IEJ0NmH3EXDKZp8iaHW0MM5POtZvQdwXaK9lJnmz6hw1o6OcrjEqNQxQcQfN4rkk2j
	 6hXPxZXeibBRA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf 2/2] bpf: Invalidate freed prog pack memory without holding pack_mutex
Date: Tue,  3 Nov 2026 06:28:54 -0800
Message-ID: <20261103142856.463063-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103142856.463063-1-puranjay@kernel.org>
References: <20261103142856.463063-1-puranjay@kernel.org>
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

bpf_prog_pack_free() calls bpf_arch_text_invalidate() with pack_mutex
held. On arm64 it interrupts all other CPUs and waits for them:

  bpf_prog_free_deferred
    bpf_prog_free_images
      bpf_jit_free
        bpf_jit_binary_pack_free
          bpf_prog_pack_free
            bpf_arch_text_invalidate
              aarch64_insn_set
                __text_poke
                  flush_icache_range
                    kick_all_cpus_sync

When many progs are freed at once, every prog load waits in
bpf_prog_pack_alloc() for all of these broadcasts. On arm64 hosts with
many CPUs this showed up as hung task reports with sk_attach_filter()
blocked on pack_mutex for minutes.

pack_mutex protects pack_list, the bitmaps and arch_flush_needed, not
the text. Until bitmap_clear(), the bits of the range are set, so it
cannot be allocated again and the pack cannot be freed. Invalidate it
before taking pack_mutex. A ptr that is in no pack, which only a caller
bug can pass, is now written to before the lookup warns about it.

Tested in arm64 KVM guests with 16 and 64 cpus on a 72 cpu host. cpus/2
processes attach a cBPF filter to 256 sockets and close them in a loop
for 20 sec. One more process attaches a filter every msec. Median of 5
runs.

Sockets attached and closed in 20 sec, in millions (higher is better):

             before  after
  16 cpus      1.22   3.79
  64 cpus      0.42   3.38

setsockopt(SO_ATTACH_FILTER) of the process that attaches every msec,
in msec (lower is better):

                16 cpus          64 cpus
             before  after    before  after
  avg          1.32   0.27      7.21   0.56
  p99          5.39   5.52      79.7   9.89
  max           447    159      1598    253

Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4dac33a4208aa..51f1b128f0d63 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1073,6 +1073,9 @@ void bpf_prog_pack_free(void *ptr, u32 size)
 		return;
 	}
 
+	WARN_ONCE(bpf_arch_text_invalidate(ptr, size),
+		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
+
 	mutex_lock(&pack_mutex);
 	list_for_each_entry(tmp, &pack_list, list) {
 		if (ptr >= tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > ptr) {
@@ -1087,9 +1090,6 @@ void bpf_prog_pack_free(void *ptr, u32 size)
 	nbits = BPF_PROG_SIZE_TO_NBITS(size);
 	pos = ((unsigned long)ptr - (unsigned long)pack->ptr) >> BPF_PROG_CHUNK_SHIFT;
 
-	WARN_ONCE(bpf_arch_text_invalidate(ptr, size),
-		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
-
 	bitmap_clear(pack->bitmap, pos, nbits);
 
 	if (static_branch_unlikely(&bpf_pred_flush_enabled))
-- 
2.53.0-Meta

