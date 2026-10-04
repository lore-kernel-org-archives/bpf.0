Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAFF45198E
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123898; cv=none; b=G5/AwqJApHGbxev2/lX76ajxuRGTC01M+tLmjhcMjW1d5ous4dvo+u4G5qdKCpxrCvrjJKJFvGWcQljYHrThagshQcmhZeJ0xDCFpFCc/h7s8R6rR9qqMnxfdrNLj4nqjt6LuyZULNQC9uGMKt/W99/8D2fkpxhEJeSjY3DzkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123898; c=relaxed/simple;
	bh=dhD3quXgoCtI8ha/xzSA19n22KDz8pqqZqLFPeF7Vk0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TeaW6xNGl283rAtaxm+PM6Y8+kKKkXnPJvozQABh+VNwX3dfcheIwTrgSAMeaeGewpErEwiOh+QOgCiEZAbuDePYSIgdwK02EvfrQWs4oiGegn7b4kS2I0K4g89yBkEFeM1XwlHBCQ8GoM2XMXjrXT8ZqZovdmqIjgmZ1KBrekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVUaUhro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVUaUhro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7261F000FF;
	Sun,  4 Oct 2026 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123897;
	bh=Bk+6yW7KcvgUQ45ZZtfnKk1luZSE3k41f8UgpjvZOLc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OVUaUhrockvdNRG6agDnbSsinTkVqKWPX2AUWfEHGl2aKJGqAn/Je5cztqM5kmutY
	 juu23rUifI1KKMQlH09Ed2sqq3f40XR2hxPhGmlMC242BndzflQ0sd06BO2uqHJhCr
	 /yXaAChKZGpulDarR5odWXwfDPM4eUxdwfkYMDpiOqLUazUxH6iWFz2kndZ+8xy9dL
	 iYliTnLGGJ5A9h/8wbMlsnbdPHARB4mlqsUqLTSvGvOYz7iKi90q9Ja4B4glK/QjoV
	 aZ4PQVZytq05VZkH+R2lClbNEEa3Y1VMwRqqijFAWQoXXJpR/09glNC1uBrMBLR7HR
	 IksMUqcWX0w6Q==
Content-Type: multipart/mixed; boundary="===============4792223084089160855=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a859e0cfc289db49f1f8d4e3daa2f7083cd0f38b6380736580cb18ebd5ad359c@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-28-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-28-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 28/43] bpf: compute scalar evolution expressions for loops
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:55 +0000 (UTC)

--===============4792223084089160855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: compute scalar evolution expressions for loops

TL;DR: Commit message only: the worked example says r7 stays (any r7 10) at
the latch, but the code may produce a nested (any (any r7 10) 10) since
simplify() doesn't flatten it.

> bpf: compute scalar evolution expressions for loops
>
> Assign algebraic expressions to loop variables (registers and stack
> spills), describing how their values evolve across iterations. These
> summaries provide symbolic input for the subsequent widening patch.
>
> The algorithm draws on ideas from the following papers:
>
> - "Symbolic Evaluation of Chains of Recurrences for Loop Optimization"
>   Robert A. van Engelen, 2000
> - "The CR# Algebra and its Application in Loop Analysis and Optimization"
>   Robert A. van Engelen, 2004
>
> The analysis proceeds in two phases:
>
> - Compute expressions for one symbolic iteration: start each variable
>   with a reference to its input value, apply instruction effects and
>   join expressions where control-flow paths merge.
> - Convert the resulting backedge updates to recurrences at the header,
>   then substitute these recurrences into expressions at the latch.
>
> Analyze loops innermost first. Within each loop, visit blocks in
> topological order (reverse postorder, with backedges ignored and nested
> loops collapsed). Treat each nested loop as an opaque operation:
> preserve its invariant values, forget the others and continue at its
> exits, without expanding its iterations.
>
> For example, using 64-bit arithmetic:
>
>     0: r7 = 5;
>     1: r6 = 0;
>     2: do {                // header
>     3:     if (r6 == 1)
>     4:         r7 = 10;
>     5:     r6 += 1;
>     6: } while (r6 < 3);   // latch
>
> Expressions use symbolic inputs r6 and r7; the concrete values from
> lines 0-1 are supplied later by the main verifier.
>
> First phase:
> ------------
>
> At each instruction, an environment maps register numbers to their
> current expressions. Transfer functions update this mapping, while
> joins merge the environments arriving along different paths.
>
> For illustration, follow each branch separately to the backedge:
>
> - At 3, take the path skipping 4: r6 = r6, r7 = r7.
> - At 5, transfer(r6 += 1): r6 = r6 -> r6 = (+ r6 1).
> - At 2, the first path contributes r6 = (+ r6 1), r7 = r7.
> - At 4, on the other path from 3, transfer(r7 = 10):
>   r7 = r7 -> r7 = 10.
> - At 5, transfer(r6 += 1): r6 = r6 -> r6 = (+ r6 1).
> - At 2, join the two paths' contributions:
>   join((+ r6 1), (+ r6 1)) = (+ r6 1) for r6;
>   join(r7, 10) = (any r7 10) for r7.
>
> Equal expressions stay unchanged; different expressions become ANY
> alternatives. These summarize one iteration, without unrolling the loop.
>
> Second phase:
> -------------
>
> The update r6 = (+ r6 1) says that each iteration adds 1 to r6.
> Repeating this update n times gives r6_entry + n, a linear recurrence.
>
> - At header 2, r6 = (+ r6 1) becomes (linear r6 1), meaning
>   r6_entry + n, where n counts iterations from zero.
> - At latch 6, substitute this recurrence into (+ r6 1):
>   (+ (linear r6 1) 1) simplifies to (linear (+ r6 1) 1),
>   meaning r6_entry + 1 + n.
> - At both points, r7 retains (any r7 10): either its entry value
>   or 10. ANY records alternatives, not numeric ranges or the path
>   conditions selecting them. Unchanged variables retain their inputs.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Is the last bullet of the second phase accurate for latch 6?  It says that
at both points r7 retains (any r7 10).

In the worked example the header expression for r7 is (any r7 10), and
compute_header_scevs() keeps it as the header SCEV for r7.  At the latch,
compute_insn_scevs() substitutes that SCEV for (reg r7) and then runs
simplify():

    id = einsn->reg2expr[reg];
    id = transform_expr_once(scev, 0, id, eheader->reg2scev,
                             instantiate_header_scevs);
    ...
    id = transform_expr(scev, id, NULL, simplify);

simplify() has no rule that flattens a nested (any ...), so the expression
for r7 at latch 6 would come out as (any (any r7 10) 10) rather than
(any r7 10).  The set of values is the same, but the text doesn't match the
expression shape the code builds and logs.

Could the commit message describe the latch expression for r7 as it is
actually produced?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============4792223084089160855==--
