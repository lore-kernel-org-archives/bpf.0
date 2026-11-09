Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192247;
	b=lGyIoLsBs1Il0vLREpLcnrY5RCbH8eswQj5NQLYw2S8Uij+8mVV9P7HUt/FaJqoSy9We
	 KSjJyAqTGensEsc8Ud38avwAQ+QwXi+skA/Yo6CiR6P1uKnpQ9TVmtO6iQuMr6BJPcGKv
	 BuifkWbkRy2Y9zTNZqIE9eQBVWM/oyfznq4D/VIIzYrTk8r/xJ6F417WpfhUcGn8WquhU
	 cWVb6zt3dck1zTchvQ6+HSEovYGnhNxo3Y6uyfJ8RXcoMYJEDEGvVIrW3+mRxrzrKj1nI
	 EUu0yFCFp28r64ZGTn4B9MpdjTLMb4RKv32ms8R4rkAAvkYvb3RmNVhFlTvRft9L9og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192247;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=H1+zVgqWjnuazHdFGrF5+1OIlBZ3gUEMkAVX6j7BpD0=;
	b=0P4hy3HianAFb8tKOAudFZricmqP1NPmWIVnLOBNJcpsi7slX9+wdqJG0Lk7Tjh7sRXR
	 FZFQz7iG7JHghePKLz9n+uCEKyeD0JmRuBxsGmDbWsN4WVR/n6t8DRRZ5RXh8PCcH1a7w
	 lznOI2vQMye6a3iL+EB/sRdUjvhKuHuqNUZt3Bblh7so66IGz6y56Md5aemkzqeTzaZzX
	 nppznFFjCUMMkWxKWQbJexKeApH3gDtk6g2GWkm9umjBL9ys+K2JudUS+TxlpDT80xDOk
	 nLUL5+vKyk/hByZMKBgfbJJhlt8j5LZ2d4sXRaf0iik0++Q2rDmSeFtK1JtAhzlMMPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b="ia/AwgVd";
	arc=none smtp.remote-ip=203.205.221.202
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287FC606A320;
	Mon,  9 Nov 2026 02:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 287FC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=ia/AwgVd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794192236;
	bh=H1+zVgqWjnuazHdFGrF5+1OIlBZ3gUEMkAVX6j7BpD0=;
	h=From:To:Cc:Subject:Date;
	b=ia/AwgVdgqiZy06teqd8oFkdq1ubVVJ/WtS6xvfqsz8mOz1vJqepwI9/kp5ZGUHAL
	 34wLPlcPJNk5FSbeMV5SKJ9qxxCnmGunjQl7UoFdLbwd66mbk/a8sAj/Lgft9lOdSL
	 kriM//wlfUfnMCZdiOBYbst9HtarMkOSX2WO++y4=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.240])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id AF61963D; Mon, 09 Nov 2026 10:43:54 +0800
X-QQ-mid: xmsmtpt1794192234tl0sucdz5
Message-ID: <tencent_6A1D611E2DA9545DA6E76ABCCA806BC39707@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+gLy60EWnFuf3eCIWV70oVoiExU/THEuLqbBTeP3BjOJIDKJas2
	 BujGZqJvp2cQ7jQGvVmqi3C2Kf3GaKNCFhmALwKDXqsklZOyuJ+6JRW4H14+1Y8STdGKARzFFmG+
	 oyZOGp8zxC4z+5mklp/iVX1bsWLTvm1Wz/KfkUNiRoAIw0H+RJzm2vhZ3VpjKsgrDXQqQZdfr38W
	 6/xHu/Qn2TXedTJqz2NpI1ByqyVxbgTTjQebXkUde9vOuc8dgG6Ttd06oCiICLy5OParJ9wjNuUo
	 CZ7vcb5bejocwqCPixQrwMN195n03RfgGiE5Wqvd32NatNR0/DN8W5wmfLSAXySfXd3iWN6jiIuc
	 2YuXMrctCeMPr2kuDQlOxlz0Ecv7zHxbTQgsnd/XY63Gn8vzyDLa88Oh/8DOlqWZWqpGpjxuB/ar
	 8qobc3wZBJg4m2SF9eHnOKsa+DtveJ9rb7N4nIPs2er+DAFqp8gc6E5F136QzVqDsmJZysiDmlCE
	 BC0djtw20Gde8V7iDhgbsm+Kkymv1JdqqTF4+0TXSXMHbqDBoocgiz6ufeHDOS4fB3FuBkbkSgwE
	 /0a/5G/izGfhMtYMZSsMIrlx36DAhbdgXvZKkxiYoQFHZjfR9nFFzvaUMB8IKNVdmyfwBf2D6wDF
	 FWbouN9EALVGwE6b3r0fMHCARX5DKO3Vvn7FlzoJCZusrQmcXa0nFSox9QzDKssrHJn+eQa8B74/
	 MvZRiQ5JPlnvix3QDISKPbPc1Jt0TpNICbmDxcJ76bEZgDvj6k2MbTVHmO1MP2R/HgAMyyjVTD3b
	 SdShpheLLaQUYY8KWZZZ7GnBnyMPvQFuCaeeD76rOUGoo3zG6n0Z8946Vp5ECmkpMDfToTT1rfcs
	 SC6eTlS4Xqs9QbDbfFxsOCENnBgpLwAkX0ruZz5QeM1IELgI82Z3qqUuOKQvz2W/RRdVNrRXRgJE
	 hOcRihT0BU7NpxUp7WBlPBdzJEqCwDj46yRWjeGPNN7Qw638d5tGd/W83JzOZyzAQ3ydnihX+kr7
	 c3Cdkzap0OXbL3ynp8DG+2DTiO4nSRviAfa+ncqTA/7qb2YdPDfHhODkC2mmKA2xM70LtM9OKBRw
	 enJNelbpFxwHo+qgiqISW4n0PwJu8r2ApTy4+mfovOvYwU6lg=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: bo cao <treebacker@foxmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Bo Cao <treebacker@foxmail.com>
Subject: [PATCH bpf v4] bpf: check cpu_possible() in per-cpu helpers and map callbacks
Date: Mon,  9 Nov 2026 10:43:53 +0800
X-OQ-MSGID: <20261109024353.4260-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Bo Cao <treebacker@foxmail.com>

bpf_map_lookup_percpu_elem() and bpf_per_cpu_ptr() take the target
CPU id as an unconstrained u32 and only reject cpu >= nr_cpu_ids
before using it as a per_cpu_ptr() index.  Per-cpu memory is only
allocated for possible CPUs, so on a system with a sparse possible
mask (e.g. an arm64 guest with possible CPUs 0,2-3) a hole CPU id
passes the checks and per_cpu_ptr() computes the pointer from the
uninitialized __per_cpu_offset[hole].  For per-cpu maps this reads
and writes memory outside any valid per-cpu chunk, and for a percpu
obj allocated with bpf_percpu_obj_new() the result is writable, too.

The cpu_possible() check must go into the three per-cpu map
callbacks as well as the helper wrapper, because the verifier
rewrites bpf_map_lookup_percpu_elem() calls with a known map into
direct calls to the callbacks (kernel/bpf/fixups.c).

Also carry PTR_MAYBE_NULL into the register type on the
returns_cpu_specific_alloc_ptr path of check_helper_call():
bpf_per_cpu_ptr() can return NULL (for cpu >= nr_cpu_ids since
01cc55af9388), but the verifier currently drops the flag on that
path, so a program that skips the NULL test on a percpu obj result
passes verification and oopses on NULL + offset at run time.

Reproduced on an arm64 guest with possible mask 0,2-3, where a
socket filter program passing the hole-CPU lookup result of
bpf_map_lookup_percpu_elem() to bpf_map_update_elem() faults inside
array_map_update_elem().

Fixes: 07343110b293 ("bpf: add bpf_map_lookup_percpu_elem for percpu map")
Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Fixes: 01cc55af9388 ("bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support for allocated percpu obj")
Cc: stable@vger.kernel.org
Signed-off-by: Bo Cao <treebacker@foxmail.com>
---
Changes in v4:
- trim the commit message per review
- no code changes since v3

Link: https://lore.kernel.org/bpf/CAEf4BzYDmzNoN-5Rnfj4RrAU8wKnZe+tDFApng61L0mubXqung@mail.gmail.com/

Changes in v3:
- rename author and Signed-off-by to match the sender (bo cao).
- drop the incorrect "MEM_RDONLY, so reads only" claim for
  bpf_per_cpu_ptr(): it only holds for ksym arguments; percpu kptr
  results are writable.
- keep PTR_MAYBE_NULL on R0 for bpf_per_cpu_ptr() on percpu obj:
  check_helper_call() drops the flag on the
  returns_cpu_specific_alloc_ptr path, so the NULL return (for
  cpu >= nr_cpu_ids since 01cc55af9388, and now also for a hole
  CPU) let a non-checking program oops on NULL + offset.  With the
  flag kept, the verifier requires the NULL test; existing selftests
  already check.

Changes in v2: add the cpu_possible() check to the three per-cpu map
callbacks as well, because the verifier rewrites helper calls with a
known map into direct calls to the callbacks (kernel/bpf/fixups.c)
and thus bypasses the helpers.c wrapper.

Link: https://lore.kernel.org/r/tencent_3A8413B414528B9802AB092A67AE015FFE09@qq.com
---
 kernel/bpf/arraymap.c | 2 +-
 kernel/bpf/hashtab.c  | 4 ++--
 kernel/bpf/helpers.c  | 6 +++++-
 kernel/bpf/verifier.c | 3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 133f189bf6d2..eab03f985280 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -327,7 +327,7 @@ static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 
-	if (cpu >= nr_cpu_ids)
+	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
 		return NULL;
 
 	if (unlikely(index >= array->map.max_entries))
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bf78e09f4d51..007279c16b77 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2670,7 +2670,7 @@ static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 {
 	struct htab_elem *l;
 
-	if (cpu >= nr_cpu_ids)
+	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
 		return NULL;
 
 	l = __htab_map_lookup_elem(map, key);
@@ -2696,7 +2696,7 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 {
 	struct htab_elem *l;
 
-	if (cpu >= nr_cpu_ids)
+	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
 		return NULL;
 
 	l = __htab_map_lookup_elem(map, key);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..f9f2bd665038 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -133,6 +133,10 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
+
+	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
+		return 0;
+
 	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
 }
 
@@ -753,7 +757,7 @@ const struct bpf_func_proto bpf_copy_from_user_task_proto = {
 
 BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 {
-	if (cpu >= nr_cpu_ids)
+	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
 		return (unsigned long)NULL;
 
 	return (unsigned long)per_cpu_ptr((const void __percpu *)(const uintptr_t)ptr, cpu);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d2056218..0cedf39ee226 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12957,7 +12957,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			regs[BPF_REG_0].mem_size = tsize;
 		} else {
 			if (returns_cpu_specific_alloc_ptr) {
-				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU;
+				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU |
+						       (ret_flag & PTR_MAYBE_NULL);
 			} else {
 				/* MEM_RDONLY may be carried from ret_flag, but it
 				 * doesn't apply on PTR_TO_BTF_ID. Fold it, otherwise
-- 
2.39.5 (Apple Git-154)

