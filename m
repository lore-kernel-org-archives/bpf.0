Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222382;
	b=CmQ3nUG81V6UqkGve/r1+B7AOY10vixRaOyb3LhkIFePUYfDPO89nldococJGdo0EExx
	 Fon1jb3hdUyXzjx7cjcYf6eT5FEZZU/d4nCalerVnzl8KECqFm+SRcpFMKOmBO/8HIOSj
	 VSjhefhPCOTHeWGsn+5patxJxQbDCFA17+AHDV7lBgcw40OiipLZ2BaMFVvw4PuXMG8a8
	 xJBSIyQZNZQKjIOg4kROqAPqTBG1JG6lfMeBotghkM8cygNinhp1rLX15I8XVktm5gDaz
	 pAKTNxPvg3Yx30LpOwbXIfdHSaZj2ATC+er72kIAQFxbl1p9XyccsAUMCPZIaC5efHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222382;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WsUSq2k+2aYiN37qb7aSkQdP06LKemiN8mY/m+NRNe8=;
	b=Tzwkopx+CQ0iBJ1t+ebpqRaJ3ogErCWKs1yHB+J4QNqV0AHyL9TmGrA+ZHL5SM0dZOxv
	 JElay9lDfJZmo6gv4MxKhjtadhr3CpyWTqA9b+s9cJuT3Nhl0m3pfeiDwUwHY3MJnJ5i6
	 8pJiTcyJJoKuF6vMlpT5EmLK9ArzSPkhl0W28MiJSXbDLmM+BU6UiPu7hgb8gDhE1kQfW
	 t+It7yp1bLrirW2bCaOdOTQebJPcIwse8P6pUqaxZ+9FkzVkovAAEa2VYjBArQBRedHZb
	 gCLyFZ6aKRO26KBm+l7I3p74bIRIaa4QQQzsPnSPJKphdXLRbTbaGFehQxrZt8khP1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IUTfhChr;
	arc=none smtp.remote-ip=95.215.58.155
Received: from mta1.migadu.com (out-155.mta1.migadu.com [95.215.58.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77670606A324
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 21:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77670606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IUTfhChr
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NbKq6I63kMRUcieNKpMBmStZcf0/mybvQYK4JY69Rog=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793222373; v=1; x=1793827173;
 b=IUTfhChrGaXdSKAPxL8ULFldU5qp4G0COqGFcI5mxjUvVoJy5CyxRcoohbXmwQUdOH3jHbon
 5qSplCJKXaRrYyvz1COPD7QThQckz80fFPvwvd//mIAAJhKianmRANYa9wiHbnHnnQUaDTho/9Y
 w6K/S3rFbC4+smuztWa480m4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6dc190b38c415713;
	Wed, 28 Oct 2026 21:19:33 +0000
X-Mizu-Trace-ID: 6dc190b38c415713
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next] selftests/bpf: don't count skipped reg_bounds cases as skipped tests
Date: Wed, 28 Oct 2026 14:19:21 -0700
Message-ID: <20261028211921.1055711-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
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

test_progs-bpf_gcc reports an order of magnitude more skipped tests than it
lists.  A recent bpf-next run ends with

  Summary: 720/6383 PASSED, 8392 SKIPPED, 105/368 FAILED

but the log for that same run names only 684 skipped subtests which are
all accounted for; the other ~7700 are just ghosts.

Nothing here is specific to BPF_GCC; reg_bounds builds its programs
from hand-written instructions at run time, so the BPF compiler is not
involved.  That build is just where the inflated total was noticed.

The total is not reproducible either.  Four runs over an identical
tree reported 8240, 8261, 8405 and 8424 SKIPPED; two of those had
byte-identical verdicts for every test.

The extra skips come from reg_bounds.  Counting the increments by
test, every heavy contributor is one of its random tests:

  632 reg_bounds_rand_ranges_s64_u32    576 reg_bounds_rand_consts_s64_u32
  624 reg_bounds_rand_ranges_u64_u32    564 reg_bounds_rand_consts_u64_u32
  600 reg_bounds_rand_consts_u64_s32    552 reg_bounds_rand_ranges_u64_s64

The path, for one of them:

  test_reg_bounds_rand_consts_u64_u32()
  `- validate_rand_ranges()                     100 random cases
     `- verify_case_opt(..., false /* !is_subtest */)
        |    if (is_subtest && !test__start_subtest(sb->buf))
        |            return 0;       <-- no subtest is opened, so
        |                                env.subtest_state stays NULL
        `- for (op = OP_LT .. OP_NE)             x6 -> 1200 cases
           `- verify_case_op()
              `- if (reg_state_needs_two_arcs(...))
                    test__skip()
                    `- else env.test_state->skip_cnt++   <-- once per case

skip_cnt feeds the SKIPPED total, so it grows once per case rather than
once per test.  The variance has the same source: how many cases are
unrepresentable depends on the seed.

Report the skip up to verify_case_opt() instead, the one frame that
knows whether a subtest exists:

  err = verify_case_op(init_t, cond_t, x, y, sub.op, &skipped);
  if (skipped) {
          if (is_subtest)
                  test__skip();
          else
                  ctx->skip_case_cnt++;
  }

with the tally printed once at the end of the test.  The subtest path
keeps its old behaviour: test__skip() only sets a bool there.

After the change, a run of reg_bounds_rand_consts_u64_u32 -- the test
contributing 564 above -- reports 0 SKIPPED and logs

  SKIPPED 480/1200 cases needing two range arcs

The two counts differ because the seeds do.

This also stops the rand_* tests reporting themselves as skipped: with
no subtest open, any non-zero skip_cnt made print_test_result() call
the whole test SKIP, so a test that ran 1200 cases and checked them all
was indistinguishable from one that never ran.  18 of the 32 report OK
instead; the rest were already OK, their type combinations never
producing an unrepresentable case.

Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,64}")
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 7f170a69d1d8..6231258b26cc 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1504,7 +1504,7 @@ struct ctx {
 	struct range *uranges, *sranges;
 	struct range *usubranges, *ssubranges;
 	int max_failure_cnt, cur_failure_cnt;
-	int total_case_cnt, case_cnt;
+	int total_case_cnt, case_cnt, skip_case_cnt;
 	int rand_case_cnt;
 	unsigned rand_seed;
 	__u64 start_ns;
@@ -1541,7 +1541,8 @@ static void subtest_case_str(struct strbuf *sb, struct subtest_case *t, bool use
  * performed)
  */
 static int verify_case_op(enum num_t init_t, enum num_t cond_t,
-			  struct range x, struct range y, enum op op)
+			  struct range x, struct range y, enum op op,
+			  bool *skipped)
 {
 	char log_buf[256 * 1024];
 	size_t log_sz = sizeof(log_buf);
@@ -1581,7 +1582,7 @@ static int verify_case_op(enum num_t init_t, enum num_t cond_t,
 	    !assert_reg_state_eq(&tr2, &te2, "true_reg2")) {
 		if (reg_state_needs_two_arcs(&fe1) || reg_state_needs_two_arcs(&fe2) ||
 		    reg_state_needs_two_arcs(&te1) || reg_state_needs_two_arcs(&te2)) {
-			test__skip();
+			*skipped = true;
 			return 0;
 		}
 		failed = true;
@@ -1629,13 +1630,26 @@ static int verify_case_opt(struct ctx *ctx, enum num_t init_t, enum num_t cond_t
 		return 0;
 
 	for (sub.op = first_op; sub.op <= last_op; sub.op++) {
+		bool skipped = false;
+
 		sb->pos = 0; /* reset position in strbuf */
 		subtest_case_str(sb, &sub, true /* print op */);
 
 		if (env.verbosity >= VERBOSE_NORMAL) /* this speeds up debugging */
 			printf("TEST CASE: %s\n", sb->buf);
 
-		err = verify_case_op(init_t, cond_t, x, y, sub.op);
+		err = verify_case_op(init_t, cond_t, x, y, sub.op, &skipped);
+		if (skipped) {
+			/*
+			 * Outside a subtest test__skip() bumps the test's skip
+			 * counter, which feeds the SKIPPED total; tally these
+			 * locally instead of reporting each as a skipped test.
+			 */
+			if (is_subtest)
+				test__skip();
+			else
+				ctx->skip_case_cnt++;
+		}
 		if (err || env.verbosity >= VERBOSE_NORMAL)
 			ASSERT_OK(err, sb->buf);
 		if (err) {
@@ -2167,6 +2181,9 @@ static void validate_rand_ranges(enum num_t init_t, enum num_t cond_t, bool cons
 	}
 
 cleanup:
+	if (ctx.skip_case_cnt)
+		printf("SKIPPED %d/%d cases needing two range arcs\n",
+		       ctx.skip_case_cnt, ctx.case_cnt);
 	/* make sure we report random seed for reproducing */
 	ASSERT_TRUE(true, ctx.progress_ctx);
 	cleanup_ctx(&ctx);
-- 
2.53.0-Meta

