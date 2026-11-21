Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299239;
	b=WieHDWmGi0TuFn13JlfNAVI9xIjdFvlwpI8rxkJWvmt5hIWwqVTOhGbn/Aa8JEaRTqlE
	 zaDSD6eLhy/DH3+tj4mBx21mbKys7k7/S0/0OXBEqlRF7U52G47YImREvWLw5knFsZ+sc
	 jurIFp714l8Z9ARMWeqWB4DcFkbjipRrULQnoBAtKifLuZpVRmZk8xyUnOOdGb5Ew1HWX
	 mFLHC5JUY99WWixQuw2+8GwPgszRxTum90J1YT1K6dz4KIRyt+tUYKnEkThDFBpCvoFfz
	 Lnu4DHADRJFo6nF7QpkTU9ZMI7B/VpgP7ftI66nb8lc/T96FW7/iNEkeMHE5PAuqeqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=raCgLsf7Ok0Lue5mv3EMqpvakpkAfxWTIkfDdbHQiCc=;
	b=UoZAJloVFTdcEP60MjSQTOREotaeM6YCm3ozpSYtLt0QX2+BIJ8UvGArJrhJidi9lVSW
	 EjsXb9nl3aVcNUfP0kXIQRwJYGr7C6uhMNFu4E85pd0AVq3XwxEpd2VBLv/Xt4TNuoRfo
	 CqF32IjYJdf5PomTknQGpuYUUlTR1VPXZQORjCsxyNgoPi+vkLoeUjiw5XJmQHcJXq0wX
	 j0coM6ve8JpWqTUvQzgE78L1L5ef5nEhxoT8xB/slShrZmpK2B09Cn78FTdTqNnEevQkE
	 +MwzcWalOcWAO7iSkOjzoY1quOuFdx13aLWVEbNpSckj2CSW37zDhBFdGaD9CV7xIKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oG4O+YZW;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE9606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BEE9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oG4O+YZW
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04ad2c46dso9610825ad.2
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795299238; x=1795904038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=raCgLsf7Ok0Lue5mv3EMqpvakpkAfxWTIkfDdbHQiCc=;
        b=oG4O+YZWHTFgqjkiscnyGLiw1BQ6kgJRLQ+rSzifz0IfoP8OpKHscSCGia3Tz1lire
         eff0zBAAzM/CpHGQ/tIATNHOtjrxT7pT7sx2zlnzPetqSPQOmMv+DuyFiJfStx5y7VOk
         gsTShQy7/vAEuZ9ss5J8/z1rtP+pApG18TKXjLSnbptZtooJeZPv4YIYjfoAaMKyyj6J
         LzTBOTfmCTxOX46h0hFZ3aXVrA+yg9VapyLBBzau0do+3RlH6IlpCVYOjGAAx7JOpwSs
         NK9Wd8k9SL19Diy8p1ERFesb7zBX060ye6n7TMGtx1qZNywZ1HMBTspCThwNG/pXHqq+
         7O8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795299238; x=1795904038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=raCgLsf7Ok0Lue5mv3EMqpvakpkAfxWTIkfDdbHQiCc=;
        b=FkxKc5ggO0+GHGkMwbXo1sfq7wuHOMGL/egF2WxRkTiA2zX2rvgL+/E6L7R5+csuuw
         WdKR8ZWFq8caz7wMiVIDuB/iZu4Gj9eoyu1mqb0uVwa8ZR5lRz1t1yOY0yt2lz3WT3Cd
         zgelX5z1uYDXiJ0AeTpbnk3aMCAnejBlJ2NBO+jP7WRbKHXZQOODCy5tMnsr6SS4qlWN
         OhJ5k2y58quAB85Uh1Liod1MJraiHjE/nd+qKwEP9FVVQRRMG2DlzHSB0cxNMRLeRRyP
         m0JO+oh9Tpzt7RRijaiGeJzSgojhyEF/ILWfqMpP2t79b/D3sEwO/2gCGmhic9Rs/pik
         4HTg==
X-Gm-Message-State: APuU4Z9fTltov9BuJnu+NDgKd8Zx7/sAaaeF1GFvx0KYrPJbsP9jlx5Z
	1K6gl6+g/DKgQfqylasaovbsAcz8U5nApUIXDZwMgey2fLrP+6783IszwP3YkQ==
X-Gm-Gg: AZFdTZfTUg9H09PSwbNNwPTxerl5Bf4cHRozhYwlAJ3LluA4ZuGu3ZyLzULfJxDctI0
	4/7VNmmXaCNzFV/JcXQV92AYP3MDxMdcVQWxHbVa2JBIH635k8SiKcV2LUWGXV8TOEBdQN6fEXI
	231zM5/UNV0781eU2okpCz87cSXhRR7YkJg2pEmja1iRwp5z6caGyWU1gKDMjCEgroJrNS7hjat
	CUxdKs2IpGho4kZA9/58eFYCjDWI/mpQ2y3Vmawa/r3MBO8y8Oye/eY4lq+UJWCz4nWwQCX5sJo
	zGrQ/Fh4IbYHPT9zluHEYyp9s8e0ROcNthCK44+w7ERdHD5AayGYQPcDo3IAoYqScMxno63jPha
	iDdf49Elm+78/4+Vos6WMdxZi6UrzjytcjC5dex/l5O74Hg32OJQr0cAzLQ3vAO0ff9vvveXHwT
	Nu2SdbwD5koxFNa2bZrxuNWP8wurIuO254x3Dr/ZQB2sDkQTq0xrcTTjCKY60CSFYYm070EPlcj
	XDP5WGsdCGN8ZDHhomDTQyD0HEbYStBXETMKH8D/Fio6cnYwCo13JcFaXporTmsjankLLw9fLtd
	5aT2vAqFhkByi8OAajJNM8vqZ2h909grkEAIIH7nY1NebO8j7XFpvemvjA/caXlXoo0o2wJFOX2
	WwdjLKotURjrsem3n/wW4sXCHFn5+6MtphORTFHykLH0DOK4wLhiiW0Dj7mi9Ui92NdVXMz6Lsw
	==
X-Received: by 2002:a17:903:2c50:b0:2e6:7c6:8d40 with SMTP id d9443c01a7336-2f03f1a466fmr67946795ad.27.1795299238313;
        Sat, 21 Nov 2026 14:13:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1059adsm30181255ad.49.2026.11.21.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:13:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 2/7] bpf: Do not skip trips if the bound moves
Date: Sat, 21 Nov 2026 22:13:39 +0000
Message-ID: <20261121221344.3958866-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
References: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A valid program can be rejected. No unsafe program is accepted, because
the path-sensitive run accepts nothing.

After a pass with an error, the run looks for one path to the error.
It skips trips of a loop. It gets the number of trips from the step of
the iv and the bound, as if the bound stays:

  i = 0; n = 60;
  do { end = flag ? 60 : --n; } while (++i < end);
  buf[n - 30];

If flag is 0, the loop ends at i = 30, n = 30. At i = 5, n = 55 the run
counts 50 more trips and skips to i = 54, n = 6. No path has this state,
but the access to buf fails with it. The error counts as real, so the
budget of the next passes is cut. If the program needs more than that
budget, it is rejected.

Keep the bound in exit_threshold, which this run does not use, and
compare it with the bound of the saved trip. If it moved, do not skip.
If the bound is a range, the jump moves one end of it. Keep the other
end. If the jump refines that end too, a later saved trip has the new
value, and the run skips then.

Fixes: a46de5d64e18 ("bpf: Reproduce an error on one path, with no joins")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  6 +++++-
 kernel/bpf/equation_join.c   | 14 +++++++++++---
 kernel/bpf/verifier.c        |  5 ++++-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7f9594436e..88b3a5226c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -456,7 +456,11 @@ struct loop_stack_entry {
 	/* an xreg: how many times the program came back to the header */
 	struct scalar trip_index;
 	bool trip_widened;	/* it was moved to a threshold, or it does not grow */
-	u64 exit_threshold;	/* by the jumps that the state passed and that leave the loop */
+	/*
+	 * The trip index at which a jump that the state passed leaves the loop.
+	 * Path-sensitive run: the bound that the jump on the iv saw.
+	 */
+	u64 exit_threshold;
 	/* Path-sensitive run: the jump that tests the iv, the value it saw, the trips left */
 	u32 iv_jump_idx;
 	u64 iv_prev, trips_left;
diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index a01f0fdc74..339562ba17 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -756,11 +756,19 @@ static void note_trips_left(struct bpf_verifier_env *env, struct loop_stack_entr
 	far_end = value + (step < 0 ? 0 : jmp32 ? x->r32.size : x->r64.size);
 	if (e->iv_jump_idx)
 		e->trips_left = step ? compute_trip_count(step, &far_end, op, jmp32, *bound) : 0;
-	if (e->iv_jump_idx && step && is_body_jump && !e->trips_left)
-		e->trips_left = compute_trip_count(step, &far_end, bpf_rev_opcode(op),
-						   jmp32, *bound);
+	if (e->iv_jump_idx && step && is_body_jump && !e->trips_left) {
+		op = bpf_rev_opcode(op);
+		e->trips_left = compute_trip_count(step, &far_end, op, jmp32, *bound);
+	}
 	e->iv_jump_idx = env->insn_idx;
 	e->iv_prev = value;
+	/* the jump moves the other end of the bound */
+	op = bpf_signed_opcode(op);
+	e->exit_threshold = jmp32 ? bound->r32.base : bound->r64.base;
+	if (op != BPF_JSGT && op != BPF_JSGE && (op != BPF_JNE || step > 0))
+		e->exit_threshold += jmp32 ? bound->r32.size : bound->r64.size;
+	if (jmp32)
+		e->exit_threshold = (u32)e->exit_threshold;
 }
 
 static void move_bounds(struct bpf_verifier_env *env, struct scalar *s, bool is_ptr, u64 off)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e24c51a49..35c9ef706c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21046,18 +21046,21 @@ static int check_held_in_leftover(struct bpf_verifier_env *env,
  *	for (i = 0; i < 100000; i++) { if (rnd() && n < 8) n++; }
  * Two trips show a step also for 'sum += i', and more than 2^32 trips also for a ring index.
  * If the steps are not constant, the skip or "infinite" is a guess.
+ * If the bound moved, there is no skip. A later saved trip can have the same bound.
  * Returns 1 if it skipped these trips.
  */
 static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
 {
 	struct bpf_verifier_state *cur = env->cur_state, *old = &entry->header_state->st;
-	u32 period = entry->trip - bpf_top_loop(old->frame[old->curframe])->trip;
+	const struct loop_stack_entry *saved = bpf_top_loop(old->frame[old->curframe]);
+	u32 period = entry->trip - saved->trip;
 	bool infinite = entry->trips_left > BPF_MAX_TRIPS, guess;
 	DECLARE_BITMAP(iv_xregs, MAX_BPF_XREG) = {};
 	int err;
 
 	/* the answer needs a walk over the program */
 	if ((infinite ? entry->loop->infinite : entry->trips_left <= period) ||
+	    (!infinite && saved->exit_threshold != entry->exit_threshold) ||
 	    (u64)entry->trip * entry->loop->nr_insns < env->prog->len)
 		return 0;
 	bpf_fast_forward_xregs(env, old, cur, 0, iv_xregs);
-- 
2.55.0

