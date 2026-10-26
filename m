Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983781;
	b=UwdzkUx3hxQx5zGoJMsw/y+heHKjHKJWyimdA3V/yjo4yahyklSr3KKOjoMUOpjywaKI
	 8Rrh90uSkt1DnBQyMUs+vXlZFxgaQbmmBG1WvImBLJLVQYDL24MDhwUKwCxHGWXYL0JLY
	 dMT7C1gB2vcKD/hvyyEy0thQpOU0ZiM7OCHXK0ynKDsKcA2yQZE159XnEZZT7aP+AAkVb
	 iVFjGA9CmgRRNw5WZ6/HS3TmYbtuzQUr0OTA7pP0++0tmz1Fl0gEFVR8luVawQNRfd4R+
	 n1DR/lOh0DTBilwpCWjnINeVyV+YUAG+Xwp3ZhEsDz7B3UxzCzJcjk4yR98L+09z8Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q92++FQpZeqqVzFIUdwlvvI0lCGZbHOxWbKEK0STXzg=;
	b=sP4vapT9zf3ngebJ1c8hJrE+wycCT+Z3AAez4/N9dDiJGsPe0evPVKW4PW+XDl2wCElH
	 triI2T5omjiYuEitMJnLHPe+mj9EYf7/rqKFF0p2H77iDT4qVlyw+1uyhVZxVOJ457FSz
	 ZktnYx+t5Uh1bcdLwAiY08Q/ZOT5iyPRkmD7aHM3LwltyWK9TRAHy1Gukp/Rkj1iqmmax
	 sCOO1QGdbEm/vfT08sylVONgvaJiyPQyTwSIJIARh+JnLfU3SZ65i917ZlgpcnGYXUj0C
	 AuMZxpqA1NlSN2iR9JreKl1VAChA4e8AqiO85d0hufEDLD0MFn03zzPLIOoXXt2tq8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="pxMELD/K";
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7D606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pxMELD/K
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e831e86ebfso15172005ad.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983780; x=1793588580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q92++FQpZeqqVzFIUdwlvvI0lCGZbHOxWbKEK0STXzg=;
        b=pxMELD/K6jpWQzmdMmnJ8cvXBN8Co3uEHItdXWma9BsrNWCwZ7YKPznqo31aXO4+GT
         38RJc9yJT4+zEN2paaCDi9HK8TAeSB8307tiVMykvqJoOukc5bKGOy6FBNfyKz4foyhc
         4cTrv+D++EpcV75TLRVTLETW6m8Ne9Y+nqJdIfH0L/aKn9hcbXNL3kl7Y4vG/+lwHBWj
         PTHUcjO6fXV/ugMMmNvj36x9VJd7K2wBVQZaCfNJzdkx0qIKRy5G0XXqvK//3JQYswGy
         ZRJ4QZ8b+1QaQSOQmSnqIYuxpgTVPEF+ee1ZDsptPrb4PgNA9gyRk563m0uz9Azc3feV
         wnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983780; x=1793588580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q92++FQpZeqqVzFIUdwlvvI0lCGZbHOxWbKEK0STXzg=;
        b=zMLY8AdSNGVi9sMb4X7rQYV7bdYjiwB8zJbHX1Joc/gZf4oNH6r/S67tlxoGHiMbVc
         +YzxJBgRvNvvtdFOTLYxLxvhlBOaQMZTC6uM3QQ9VSfSJD2oT2mVtAbKHf9KOlyTfjNY
         v4mwwGhQnYevPPLovirTaUMt/pF384gGcF84bm9WNjHJ4vo4PgpY0BGEWupPy93MDh6O
         ylH+u6sNOQA4rq7nYc3n6nUdKUErXs/m/hnsG2MKdjXnvZWfL8n3W0a5zUOzvOAj9Dqc
         ob2nqTmNA3Q+czaIz++zXX7DFSh/H4GhDbeIbJ0M9SoPMZT9uwQPLK/e25hiSzes9KJf
         2XaA==
X-Gm-Message-State: AFq9FYKN2gcZin24eR+QzX9OOZYyV70CNWrJWM7Yv5eek5Qg7Q0L/OZ4
	YNjpFuSkvZHSpli68ZXrn61L8qLkLMne/zI9I1jtUiuQ2CAzrl0HIs0tKSgT3Q==
X-Gm-Gg: AYBFou1uBEDUbYY3Z1hCmiiY3KkRoh5rFLhlYOYeZQBTQA6H/7ggDB5gbqF+8Cos1gq
	87lUua2Kt53X4WWIHo3j8djarGvVfo+B88FZT9robf0iJbl/TAHyzG+RWjS4BOdVfgYSF58sMid
	ojjnSk5R19t3rm4u0WkQXzcMgfCSa1NBr3KVAr3+rOmbI94sU7eJX7hctcOpNv5wQKaPmcvhp+2
	dNmbPO53mcftTAgmOIPqPN3wz7ULRI7xrfz/mEVCLrAV/5qCSF+PUpH8LOHmL7LHsK6yOoOi2JM
	7WwvO8R2rneTjrH3bSUJRQuIuDWsAZuwRgPzC6XdgPWQO9VGpTE317hZsNl4Akdt5AOxtotAxHz
	Bkp3VBtYg3nWH3aZWYguTF8RQZCxnJ4H0edJnIpwWnidCgdr0QmxVSTFhUW3jHs1vWGq2ftlgQX
	Dnj322SXk92dyzG1OZlH/1Ze6mjcvhCS/0I3TlfzCPq8lZ1Ku6JFJJz4hsHNHr7nIGsompeDDqi
	Ikcqt2At9dTneRhk/WzRGYATmRDvZdNeEVU02c4E8+z7IHBytPezSu02oajWEQUVuQW+8UE/pre
	mGAa8h6PFyQc3J68wv26H6pEBHfYTNo11kLMEWdrnyfaR/oLG6lMpOR2l3p48M5g6uO/iG7UHB3
	24Ce48hkSd2U5bMfZMbk5BhNd
X-Received: by 2002:a17:902:eccf:b0:2e2:be61:a882 with SMTP id d9443c01a7336-2ea9c6c8bc8mr47568725ad.11.1792983780133;
        Sun, 25 Oct 2026 20:03:00 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eac205bb63sm2716265ad.48.2026.10.25.20.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 33/81] selftests/bpf: Test static subprogs that don't take what BTF says
Date: Mon, 26 Oct 2026 02:58:54 +0000
Message-ID: <20261026025943.404450-34-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The compiler can pass more or fewer arguments to a static subprog than its
BTF prototype has parameters. See
"bpf: Count stack arguments of a static subprog from its code".

  test                             the static subprog            result
  -------------------------------  ----------------------------  ----------
  more_than_prototype              4 in BTF, loads the 6th       returns 11
  more_than_prototype_not_written  the same, 6th is not stored   reject
  less_than_prototype              7 in BTF, reads r1 only       returns 1
  callback_takes_6                 a callback, loads the 6th     reject
  tgt_prog_takes_more              4 in BTF, loads the 6th,      reject
                                   fexit attaches to it

more_than_prototype also examines the x86 code of the subprog. The subprog
passes no stack arguments to other functions. Thus the JIT must not move
rsp in it.

The verifier now rejects the test
"stack_arg: read with not-initialized caller write" at the call. Update the
message that it expects.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_struct.c |  15 ++-
 .../bpf/progs/tracing_struct_int128_tgt.c     |  26 ++++-
 .../bpf/progs/tracing_struct_int128_tracer.c  |   7 ++
 .../selftests/bpf/progs/verifier_stack_arg.c  | 105 ++++++++++++++++++
 .../bpf/progs/verifier_stack_arg_order.c      |   2 +-
 5 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index de358f335d98..628b63b406ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -253,13 +253,13 @@ static void test_int128_tgt_prog(void)
  * A static function whose BTF is unreliable gets a trampoline that only knows
  * of the register arguments, so one taking stack arguments must be refused.
  */
-static void test_tgt_prog_unreliable(void)
+static void test_tgt_prog_unreliable(bool takes_more)
 {
 #if defined(__x86_64__) || defined(__aarch64__)
 	struct tracing_struct_int128_tracer *tracer = NULL;
 	struct tracing_struct_int128_tgt *tgt;
+	struct bpf_program *prog, *entry;
 	char log_buf[4096] = {};
-	struct bpf_program *prog;
 	int err, fd;
 
 	tgt = tracing_struct_int128_tgt__open_and_load();
@@ -277,9 +277,10 @@ static void test_tgt_prog_unreliable(void)
 
 	bpf_object__for_each_program(prog, tracer->obj)
 		bpf_program__set_autoload(prog, false);
-	bpf_program__set_autoload(tracer->progs.unreliable_entry, true);
-	bpf_program__set_log_buf(tracer->progs.unreliable_entry, log_buf, sizeof(log_buf));
-	err = bpf_program__set_attach_target(tracer->progs.unreliable_entry, fd,
+	entry = takes_more ? tracer->progs.takes_more_exit : tracer->progs.unreliable_entry;
+	bpf_program__set_autoload(entry, true);
+	bpf_program__set_log_buf(entry, log_buf, sizeof(log_buf));
+	err = bpf_program__set_attach_target(entry, fd, takes_more ? "callee_takes_more" :
 					     "callee_unreliable");
 	if (!ASSERT_OK(err, "set_attach_target"))
 		goto out;
@@ -389,7 +390,9 @@ void test_tracing_struct(void)
 	if (test__start_subtest("int128_tgt_prog"))
 		test_int128_tgt_prog();
 	if (test__start_subtest("tgt_prog_unreliable"))
-		test_tgt_prog_unreliable();
+		test_tgt_prog_unreliable(false);
+	if (test__start_subtest("tgt_prog_takes_more"))
+		test_tgt_prog_unreliable(true);
 	if (test__start_subtest("stack_arg_tailcall"))
 		test_stack_arg_tailcall();
 	if (test__start_subtest("union_args"))
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
index 2561422c25dd..35c9a0c9b5cf 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
@@ -8,7 +8,7 @@ struct int128_arg {
 };
 
 __u64 base;
-__u64 ret_odd, ret_stack, ret_split, ret_unreliable;
+__u64 ret_odd, ret_stack, ret_split, ret_unreliable, ret_takes_more;
 
 #if defined(__clang__)
 
@@ -68,6 +68,29 @@ static __noinline __u64 callee_unreliable(__u64 *p, __u64 b, __u64 c, __u64 d,
 	return *p + b * 2 + c * 3 + d * 4 + e * 5 + f * 6;
 }
 
+/* BTF says 4. The code takes 6, the last one on the stack. */
+static __attribute__((naked)) __noinline __attribute__((used))
+__u64 callee_takes_more(__u64 a, __u64 b, __u64 c, __u64 d)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r11 + 8);"
+	"r0 += r5;"
+	"exit;");
+}
+
+static __attribute__((naked)) __noinline __u64 call_takes_more(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 8) = 6;"
+	"call callee_takes_more;"
+	"exit;");
+}
+
 #else
 
 const volatile bool has_stack_arg = false;
@@ -93,6 +116,7 @@ int run(void *ctx)
 		ret_unreliable = callee_unreliable(&x, base + 2, base + 3,
 						   base + 4, base + 5, base + 6);
 	}
+	ret_takes_more = call_takes_more();
 #endif
 #endif
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
index fc81c2eea4a8..a6d57e6b4798 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
@@ -74,4 +74,11 @@ int unreliable_entry(unsigned long long *ctx)
 	return 0;
 }
 
+/* The same, but only the code tells that there is a stack argument. */
+SEC("?fexit/callee_takes_more")
+int takes_more_exit(unsigned long long *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index b9f799f6e405..5062c5bab5f0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -433,6 +433,111 @@ __naked void stack_arg_sequential_calls(void)
 	);
 }
 
+/*
+ * The prototype is what the source says. A compiler may pass a pair in two
+ * registers, add a pointer to the result, drop arguments that are not used.
+ */
+static __naked __noinline __used long takes_6_says_4(long a, long b, long c, long d)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r11 + 8);"
+	"r0 += r5;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack_arg: static subprog takes more than its prototype says")
+__success __retval(11)
+__arch_x86_64
+/* takes_6_says_4() passes no stack arguments: rsp stays where it is */
+__jited("func #1")
+__jited("	endbr64")
+__jited("	nopl	(%rax,%rax)")
+__jited("	nopl	(%rax)")
+__jited("	pushq	%rbp")
+__jited("	movq	%rsp, %rbp")
+__jited("	endbr64")
+__jited("	movq	%r9, %rax")
+__naked void more_than_prototype(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 8) = 6;"
+	"call takes_6_says_4;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __naked __noinline __used long cb_takes_6(long i, void *ctx)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r11 + 8);"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack_arg: helpers pass no stack arguments to a callback")
+__failure __msg("callback cb_takes_6() cannot have stack arguments")
+__naked void callback_takes_6(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = %[cb_takes_6];"
+	"r3 = 0;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_ptr(cb_takes_6),
+	  __imm(bpf_loop)
+	: __clobber_common);
+}
+
+static __naked __noinline __used long takes_1_says_7(long a, long b, long c, long d, long e,
+						     long f, long g)
+{
+	asm volatile (
+	"r0 = r1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack_arg: static subprog takes less than its prototype says")
+__success __retval(1)
+__naked void less_than_prototype(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"call takes_1_says_7;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack_arg: what the static subprog takes is not written")
+__failure __msg("callee expects 6 args, stack arg1 is not initialized")
+__naked void more_than_prototype_not_written(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"call takes_6_says_4;"
+	"exit;"
+	::: __clobber_all);
+}
+
 #else
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
index ab1955852233..42b6d4a4b4d4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
@@ -152,7 +152,7 @@ __naked void stack_arg_read_without_write_1(void)
 SEC("tc")
 __description("stack_arg: read with not-initialized caller write")
 __failure
-__msg("R0 !read_ok")
+__msg("callee expects 7 args, stack arg1 is not initialized")
 __btf_func_path("btf__verifier_stack_arg_order.bpf.o")
 __naked void stack_arg_read_without_write_2(void)
 {
-- 
2.55.0

