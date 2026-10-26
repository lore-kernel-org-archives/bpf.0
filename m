Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983994;
	b=DZQ7j6Ewe5ITwtkvvYp6BQrDr14vdvRZK8BPG/PzTH15eLww6RDkwIosKCELcZVergcs
	 a69+mIqRdw90WY5TppnLHY6I19C7UDbIxC7NE+AbuOXjKx1DtKcnmaeiPeFZ/HdU3g4t2
	 X9CEeFQxWrx/kkwNHlYGGnjqC60mS9oeXWahrFiSNX216zA79EWBpJM/s5pAFBuQyBC+q
	 zbLy2SX0q/nCyKxwoOFZMknYtOOcN4j8HEy/lHPBlnn9ZRBEWp3JLU8lTvJcqNFLGA3wF
	 rm5LWd2q/9CcueLA8a5Pa37sjM4RsPiGugLQqFMNgcI0h9tRavnzYc3tZm0ljm4dX9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z/lWuyt/DufABuw0/+SM0nQ9TVTYY7Bk2e21c0YiD8k=;
	b=MqtZ/H3aseEP26L3aREig02NBXPYfuWCeMShvfrhq5jhCQpWMvmay2nvEQ2uV6v8cPAr
	 s58hheWbDGRR1clb4y+b5OK8vjkbYVVwWfflle+MoY8FQu9488A8mvgB0Agg7Zl1Ejs3Z
	 QYyKaki5qsBVdUctkpWb1yrSvqYjyjZwdK5g+QCFuLjz+R5oNBlD1PwD5Wsyof6iWaSC1
	 kGagjUOrlLrvExWRLm/r9Li4dEu62Owy/nUajAQZnYxEdDnxNhETmnXy9vt1MhxL9p5+M
	 RK5eWmAagGpFEWzFHgUALTAKloE9EFTkZoTizxb3hqFdDte8X3aFCLDjnmntDRQtytQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iZk6WJJ8;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA573606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA573606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iZk6WJJ8
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e977109392so14066805ad.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983992; x=1793588792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/lWuyt/DufABuw0/+SM0nQ9TVTYY7Bk2e21c0YiD8k=;
        b=iZk6WJJ8539VDtCBNKzKOImXlw7FSVcRF7cw9A1bDIeofJ5UX7O9JxJacygTwMl3wC
         gshXMLg1gkh0Veddf++41yjtPlSrjTu6aySm2BSkMtY+svqweFz1gWEaTIl8NIgC+sKs
         /416+258VHrVfp1GRoeERQvfE0htT5hfTJ61I5rLtZJitMZEMTOPzxgYkd9PWq4CcpNP
         mm84m/Gidnvr7JeXx5c91uCTJ5mFoKV7VlxTZSNtM2c9YkWjd3u4OQ38SZxdH1HxY9Tz
         H3GbJq1Y+aiOyi9w7f4reKBaxWBX0ORw6uzy3SlYVKk6bFaIVUM5Pxjf3o1RyUqTL0lB
         SO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983992; x=1793588792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z/lWuyt/DufABuw0/+SM0nQ9TVTYY7Bk2e21c0YiD8k=;
        b=vgH6SrkTpbQg1ld9RmOv3krEOZJmbj+bv4GU2PaHbShzl30nt3Ak0jdbL+BpLPVUaY
         N59PAj342OfVqaSQJYvg9RhT+GTiRxSlHnsBpJHuAhhOJLfdKl+bH2jy6UGOp60QUcXE
         NpAuEc0M3meFob/cPcJCWn31Cx4+Ac51/bsdwdo7+BshDbEuQXrfdnpWQLVmdmxM0DSn
         5dvTCAuFSli5H4QbLDw9QrPchKfLfdJx8lojF2e8Rq/j8sA61VSap87T0FVzGJOi5JQ6
         EasOhcd+JFxlX7L0SDzQNzxs6Ii/dpvQ4PGotS0PO2D5SLAi3SkxeqAI9Jo9+E/fEmNf
         OgWA==
X-Gm-Message-State: AFq9FYJXvCMNe+FpSDwYA5jDCdmuAHyTTMJC9+JyESpcN4Vz9fnp5a2l
	ZZqFk7cSTfTj/XSVcA+y6kYT6dVbQ8R2n8SoDhDZSxzA4CngPbBd7jCbwT9ALw==
X-Gm-Gg: AYBFou2wGn4O64hziz8i/Ici+dKy7w2opSeJbUZ9tWl0QbuJU6qM+o/glBGp/v5gws8
	fuP11UUVagT/6MeF0qZ3GjjKMuBd1iIA5y5Slnz9wSsgxueecDYsdWJag7NamdowWkY2L91AMyC
	TZ2jd8JJ541wb6/3dQzvuqyfrHHg+h5vJw5cAFhV6cvd6gMhz8oWfiVpjWzoIXaOOLrIhTPgNLo
	wSH4kYMa6eQeizTXQBjy9w/qSYnGNQ9Hnm77HDXzj/o7JbhxWo0VGMbedUBBt2yb0OziVJBdwRR
	XyuTu6ayZC1UJa0Ke7LG38KUmkr0wFzQvW06paRxnHbTwjAElVnAGhl+x1jU01SBj5G6dbvmggX
	uEUbwzakg69Rr5ngDDA/sm9Qqw9cHRnSKj4Blz/PCDRXaeLmellE8qO9k6rH75IKUuWeuXSCWTF
	DM7HKJZe06LrPzJZSQMDxYCTnc2QvvDhLifGWGSwBE+hjbV6IzUSuz0hYVeKUSycmKwrlSKHX/w
	Yepgk19lbRB23Ew4g4INsjkhjV7Zs+F/CqGzx0eSt0thh30HjP+54HcZBk/7yZMrD1JsNjANKj1
	3MLWE2+cJWWpFo8dc7xq3AsN0YNyug6PWM62lddW043538sTuX6YUQ7V87YBDIHAlnEZE8O9zMX
	0GQNVFxdC754ZWdwjZmconhvD
X-Received: by 2002:a17:903:245:b0:2e6:943:39de with SMTP id d9443c01a7336-2ea9c6c829amr48380125ad.30.1792983990731;
        Sun, 25 Oct 2026 20:06:30 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1def72sm9793025ad.59.2026.10.25.20.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 69/81] bpf, docs: Rewrite verifier.rst
Date: Mon, 26 Oct 2026 02:59:30 +0000
Message-ID: <20261026025943.404450-70-alexei.starovoitov@gmail.com>
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

verifier.rst describes a verifier that follows each path of a prog and
prunes. The main pass of the verifier is now a data-flow analysis. It
verifies one basic block at a time, and it joins the states that meet at a
block. Most of the other text is from 2014-2018 and is also incorrect.

  verifier.rst says                           the verifier
  ------------------------------------------  ---------------------------
  It descends all paths and prunes.           It joins states.
  A DAG check disallows loops.                It permits loops.
  Signed and unsigned bounds are separate.    One range holds the two.
  A pointer has a fixed offset and a          A pointer has one offset.
  variable offset.
  PTR_TO_MAP_VALUE_OR_NULL is a type.         "Can be NULL" is a flag.
  The log shows R0=inv1.                      The log has a new format.

Rewrite the file.

  section                   contents
  ------------------------  -----------------------------------------------
  The stages                from the first checks to the JIT
  What a state contains     registers, ranges, ids, stack, held objects
  The check of one insn     the rule for each insn, with its message
  Direct packet access      the comparison with the end of the packet
  Data-flow analysis        the main part
    Overview, Terms         what a join is, one meaning for each term
    The algorithm           a flow chart: drop, join or add a state
    Examples 1 to 4         what the verifier joins, what a join loses
    Examples 5 to 8         loops, widening, the added may_goto
    Examples 9 to 11        subprogs, tables of functions, recursion
    The limits              why the analysis ends

Each example shows the control flow graph with the states on its edges, or
the insns with the states adjacent to them. Two lines below most examples
compare the algorithm with a verifier that follows each path. The states,
the messages and the numbers in the examples are the output of the kernel.

The text does not use names of verifier functions. It shows a state in its
own notation, { r6=0 r7=1 }, and not in the format of the log. The names
and the format change frequently.

Remove the section "Understanding eBPF verifier messages". The table of the
checks has the messages adjacent to the rules.

bpf_design_QA.rst lists a limit on the insns that the verifier processes
and a limit on pending branches. These limits do not exist. kfuncs.rst
refers to pruning. Update the two files.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/bpf_design_QA.rst |    7 +-
 Documentation/bpf/kfuncs.rst        |    2 +-
 Documentation/bpf/verifier.rst      | 1661 ++++++++++++++++++---------
 3 files changed, 1144 insertions(+), 526 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index 98d70b8a2533..f86b272920ae 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -92,11 +92,8 @@ Q: What are the verifier limits?
 A: The only limit known to the user space is BPF_MAXINSNS (4096).
 It's the maximum number of instructions that the unprivileged bpf
 program can have. The verifier has various internal limits.
-Like the maximum number of instructions that can be explored during
-program analysis. Currently, that limit is set to 1 million.
-Which essentially means that the largest program can consist
-of 1 million NOP instructions. There is a limit to the maximum number
-of subsequent branches, a limit to the number of nested bpf-to-bpf
+The largest program can consist of 1 million instructions.
+There is a limit to the number of nested bpf-to-bpf
 calls, a limit to the number of the verifier states per instruction,
 a limit to the number of maps used by the program.
 All these limits can be hit with a sufficiently complex program.
diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 47d3bed73b83..9fc272345138 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -155,7 +155,7 @@ An example is given below::
 Here, bpf_obj_new uses local_type_id argument to find out the size of that type
 ID in program's BTF and return a sized pointer to it. Each type ID will have a
 distinct size, hence it is crucial to treat each such call as distinct when
-values don't match during verifier state pruning checks.
+values don't match when the verifier compares and joins states.
 
 Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
 size parameter, and the value of the constant matters for program safety, __k
diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index 510d15bc697b..cc1e6eae5471 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -3,558 +3,1179 @@
 eBPF verifier
 =============
 
-The safety of the eBPF program is determined in two steps.
+The verifier checks each program at load time. The kernel runs only a program that the verifier
+accepts. The verifier accepts a program only when it can show that no run breaks these rules:
 
-First step does DAG check to disallow loops and other CFG validation.
-In particular it will detect programs that have unreachable instructions.
-(though classic BPF checker allows them)
+- Each load and each store uses a valid pointer and stays in the object of the pointer.
+- Each helper and each kfunc gets the arguments that its prototype requires.
+- At exit the program holds no reference and no lock, and r0 is valid for the program type.
+- Each loop and each recursion ends: the verifier counts the iterations, or the kernel stops it.
 
-Second step starts from the first insn and descends all possible paths.
-It simulates execution of every insn and observes the state change of
-registers and stack.
+The stages
+==========
 
-At the start of the program the register R1 contains a pointer to context
-and has type PTR_TO_CTX.
-If verifier sees an insn that does R2=R1, then R2 has now type
-PTR_TO_CTX as well and can be used on the right hand side of expression.
-If R1=PTR_TO_CTX and insn is R2=R1+R1, then R2=SCALAR_VALUE,
-since addition of two valid pointers makes invalid pointer.
-(In 'secure' mode verifier will reject any type of pointer arithmetic to make
-sure that kernel addresses don't leak to unprivileged users)
-
-If register was never written to, it's not readable::
+::
 
-  bpf_mov R0 = R2
-  bpf_exit
+  1. checks       Each insn has a valid encoding. Each jump stays in its function. Each insn is
+        v         reachable: unreachable insn 2
+  2. analyses     Constants, call graph, loops, live and tested registers, scalar evolution.
+        v         A jump that constants decide becomes goto. Stage 3 does not see its dead branch.
+  3. main pass    It executes the program on states and checks each insn against them. See
+        v         "Data-flow analysis". It verifies a global subprogram alone, from its prototype.
+  4. rewrites     Add may_goto and recursion checks (examples 8 and 11). Remove dead code. Convert
+        v         context accesses. Guard division by 0. Inline some helpers.
+  5. JIT          It compiles each function to machine code.
 
-will be rejected, since R2 is unreadable at the start of the program.
+What a state contains
+=====================
 
-After kernel function call, R1-R5 are reset to unreadable and
-R0 has a return type of the function.
+::
 
-Since R6-R9 are callee saved, their state is preserved across the call.
+  part          contents
+  ------------  ----------------------------------------------------------------------------------
+  frame         r0-r10 and the stack slots of one function. A state has the frame of the current
+                function. In some cases it also has the frames of the callers. See example 9.
+  register      Not set, a scalar, or a pointer to one kind of object: context, stack, map value,
+                packet, kernel object, arena and others. Some pointers can be NULL.
+  range         The value of a scalar, or the offset of a pointer in its object. See below.
+  known bits    The pair (value; mask) for the same number. A 1 in mask is an unknown bit. A load
+                of a byte gives (0x0; 0xff), |= 0x40 gives (0x40; 0xbf), += 1 gives (0x0; 0x1ff).
+  step          The distance between the possible values: r0=[0,7], then r0 *= 12 gives step 12.
+  id            Registers and stack slots with the same id change together at a jump or a release.
+  stack slot    8 bytes: a spilled register with its full description, or a mark for each byte
+                (not written, zero, unknown), or part of a dynptr or iterator, or saved irq flags.
+  held objects  References, locks, saved irq flags, open rcu and preempt-disable sections.
+
+A range is one arc on the circle of all values. It can wrap around. Thus one range holds signed
+and unsigned bounds. ``[-5,10]`` goes from -5, the unsigned value 2^64 - 5, through 0 to 10. After
+``if r0 > 3`` the branch that is not taken has ``r0=[0,3]``. The other branch needs two arcs,
+``[-5,-1]`` and ``[4,10]``. Thus it keeps ``r0=[-5,10]``. A second range describes the low 32
+bits.
+
+The check of one insn
+=====================
 
 ::
 
-  bpf_mov R6 = 1
-  bpf_call foo
-  bpf_mov R0 = R6
-  bpf_exit
-
-is a correct program. If there was R1 instead of R6, it would have
-been rejected.
-
-load/store instructions are allowed only with registers of valid types, which
-are PTR_TO_CTX, PTR_TO_MAP, PTR_TO_STACK. They are bounds and alignment checked.
-For example::
-
- bpf_mov R1 = 1
- bpf_mov R2 = 2
- bpf_xadd *(u32 *)(R1 + 3) += R2
- bpf_exit
-
-will be rejected, since R1 doesn't have a valid pointer type at the time of
-execution of instruction bpf_xadd.
-
-At the start R1 type is PTR_TO_CTX (a pointer to generic ``struct bpf_context``)
-A callback is used to customize verifier to restrict eBPF program access to only
-certain fields within ctx structure with specified size and alignment.
-
-For example, the following insn::
-
-  bpf_ld R0 = *(u32 *)(R6 + 8)
-
-intends to load a word from address R6 + 8 and store it into R0
-If R6=PTR_TO_CTX, via is_valid_access() callback the verifier will know
-that offset 8 of size 4 bytes can be accessed for reading, otherwise
-the verifier will reject the program.
-If R6=PTR_TO_STACK, then access should be aligned and be within
-stack bounds, which are [-MAX_BPF_STACK, 0). In this example offset is 8,
-so it will fail verification, since it's out of bounds.
-
-The verifier will allow eBPF program to read data from stack only after
-it wrote into it.
-
-Classic BPF verifier does similar check with M[0-15] memory slots.
-For example::
-
-  bpf_ld R0 = *(u32 *)(R10 - 4)
-  bpf_exit
-
-is invalid program.
-Though R10 is correct read-only register and has type PTR_TO_STACK
-and R10 - 4 is within stack bounds, there were no stores into that location.
-
-Pointer register spill/fill is tracked as well, since four (R6-R9)
-callee saved registers may not be enough for some programs.
-
-Allowed function calls are customized with bpf_verifier_ops->get_func_proto()
-The eBPF verifier will check that registers match argument constraints.
-After the call register R0 will be set to return type of the function.
-
-Function calls is a main mechanism to extend functionality of eBPF programs.
-Socket filters may let programs to call one set of functions, whereas tracing
-filters may allow completely different set.
-
-If a function made accessible to eBPF program, it needs to be thought through
-from safety point of view. The verifier will guarantee that the function is
-called with valid arguments.
-
-seccomp vs socket filters have different security restrictions for classic BPF.
-Seccomp solves this by two stage verifier: classic BPF verifier is followed
-by seccomp verifier. In case of eBPF one configurable verifier is shared for
-all use cases.
-
-See details of eBPF verifier in kernel/bpf/verifier.c
-
-Register value tracking
-=======================
-
-In order to determine the safety of an eBPF program, the verifier must track
-the range of possible values in each register and also in each stack slot.
-This is done with ``struct bpf_reg_state``, defined in include/linux/
-bpf_verifier.h, which unifies tracking of scalar and pointer values.  Each
-register state has a type, which is either NOT_INIT (the register has not been
-written to), SCALAR_VALUE (some value which is not usable as a pointer), or a
-pointer type.  The types of pointers describe their base, as follows:
-
-
-    PTR_TO_CTX
-			Pointer to bpf_context.
-    CONST_PTR_TO_MAP
-			Pointer to struct bpf_map.  "Const" because arithmetic
-			on these pointers is forbidden.
-    PTR_TO_MAP_VALUE
-			Pointer to the value stored in a map element.
-    PTR_TO_MAP_VALUE_OR_NULL
-			Either a pointer to a map value, or NULL; map accesses
-			(see maps.rst) return this type, which becomes a
-			PTR_TO_MAP_VALUE when checked != NULL. Arithmetic on
-			these pointers is forbidden.
-    PTR_TO_STACK
-			Frame pointer.
-    PTR_TO_PACKET
-			skb->data.
-    PTR_TO_PACKET_END
-			skb->data + headlen; arithmetic forbidden.
-    PTR_TO_SOCKET
-			Pointer to struct bpf_sock_ops, implicitly refcounted.
-    PTR_TO_SOCKET_OR_NULL
-			Either a pointer to a socket, or NULL; socket lookup
-			returns this type, which becomes a PTR_TO_SOCKET when
-			checked != NULL. PTR_TO_SOCKET is reference-counted,
-			so programs must release the reference through the
-			socket release function before the end of the program.
-			Arithmetic on these pointers is forbidden.
-
-However, a pointer may be offset from this base (as a result of pointer
-arithmetic), and this is tracked in two parts: the 'fixed offset' and 'variable
-offset'.  The former is used when an exactly-known value (e.g. an immediate
-operand) is added to a pointer, while the latter is used for values which are
-not exactly known.  The variable offset is also used in SCALAR_VALUEs, to track
-the range of possible values in the register.
-
-The verifier's knowledge about the variable offset consists of:
-
-* minimum and maximum values as unsigned
-* minimum and maximum values as signed
-
-* knowledge of the values of individual bits, in the form of a 'tnum': a u64
-  'mask' and a u64 'value'.  1s in the mask represent bits whose value is unknown;
-  1s in the value represent bits known to be 1.  Bits known to be 0 have 0 in both
-  mask and value; no bit should ever be 1 in both.  For example, if a byte is read
-  into a register from memory, the register's top 56 bits are known zero, while
-  the low 8 are unknown - which is represented as the tnum (0x0; 0xff).  If we
-  then OR this with 0x40, we get (0x40; 0xbf), then if we add 1 we get (0x0;
-  0x1ff), because of potential carries.
-
-Besides arithmetic, the register state can also be updated by conditional
-branches.  For instance, if a SCALAR_VALUE is compared > 8, in the 'true' branch
-it will have a umin_value (unsigned minimum value) of 9, whereas in the 'false'
-branch it will have a umax_value of 8.  A signed compare (with BPF_JSGT or
-BPF_JSGE) would instead update the signed minimum/maximum values.  Information
-from the signed and unsigned bounds can be combined; for instance if a value is
-first tested < 8 and then tested s> 4, the verifier will conclude that the value
-is also > 4 and s< 8, since the bounds prevent crossing the sign boundary.
-
-PTR_TO_PACKETs with a variable offset part have an 'id', which is common to all
-pointers sharing that same variable offset.  This is important for packet range
-checks: after adding a variable to a packet pointer register A, if you then copy
-it to another register B and then add a constant 4 to A, both registers will
-share the same 'id' but the A will have a fixed offset of +4.  Then if A is
-bounds-checked and found to be less than a PTR_TO_PACKET_END, the register B is
-now known to have a safe range of at least 4 bytes.  See 'Direct packet access',
-below, for more on PTR_TO_PACKET ranges.
-
-The 'id' field is also used on PTR_TO_MAP_VALUE_OR_NULL, common to all copies of
-the pointer returned from a map lookup.  This means that when one copy is
-checked and found to be non-NULL, all copies can become PTR_TO_MAP_VALUEs.
-As well as range-checking, the tracked information is also used for enforcing
-alignment of pointer accesses.  For instance, on most systems the packet pointer
-is 2 bytes after a 4-byte alignment.  If a program adds 14 bytes to that to jump
-over the Ethernet header, then reads IHL and adds (IHL * 4), the resulting
-pointer will have a variable offset known to be 4n+2 for some n, so adding the 2
-bytes (NET_IP_ALIGN) gives a 4-byte alignment and so word-sized accesses through
-that pointer are safe.
-The 'id' field is also used on PTR_TO_SOCKET and PTR_TO_SOCKET_OR_NULL, common
-to all copies of the pointer returned from a socket lookup. This has similar
-behaviour to the handling for PTR_TO_MAP_VALUE_OR_NULL->PTR_TO_MAP_VALUE, but
-it also handles reference tracking for the pointer. PTR_TO_SOCKET implicitly
-represents a reference to the corresponding ``struct sock``. To ensure that the
-reference is not leaked, it is imperative to NULL-check the reference and in
-the non-NULL case, and pass the valid reference to the socket release function.
+  insn               rule, and the message for a program that breaks it
+  -----------------  -----------------------------------------------------------------------------
+  each insn          It reads only registers that are set: R2 !read_ok
+                     It does not write r10: frame pointer is read only
+  call               The program type permits the helper or kfunc. r1-r5 agree with its prototype.
+                     Then r1-r5 are not set, r0 has the result, and r6-r9 do not change.
+  pointer, scalar    64-bit += and -= change the offset. The scalar must have a lower bound. Other
+                     ops (*=, &=, <<=) give a scalar. No op is permitted on a pointer that can be
+                     NULL, a socket, the end of a packet. No -= on a pointer to the stack.
+  pointer, pointer   -= gives a scalar. Other ops: R2 pointer += pointer prohibited
+  pointer to arena   Each op is permitted and gives a pointer to arena.
+  conditional jump   Each branch gets its ranges: if r0 > 8 gives r0=[9,U64_MAX] and r0=[0,8].
+                     Copies of r0 have its id and get the same ranges. A NULL check changes all
+                     copies of the pointer: not NULL in one branch, the scalar 0 in the other.
+  acquire, release   The acquired pointer has the id of a reference. A release makes all pointers
+                     with this id scalars. At exit: Unreleased reference id=2 alloc_insn=12
+  load, store        The address is a pointer that cannot be NULL: R1 invalid mem access 'scalar'
+    context          A callback of the program type checks the offset. It gives the result type.
+    stack            In the frame, and aligned. The load of a spilled register gives it back.
+    map value        Smallest offset >= 0, and largest offset + size <= size of the value.
+    packet           See "Direct packet access".
+    kernel object    BTF gives the type of the member at the offset. A load that faults gives 0.
+                     A callback of the program type must permit a store: only read is supported
+    arena            No check. The JIT keeps each access in the arena. A load that faults gives 0.
 
 Direct packet access
 ====================
 
-In cls_bpf and act_bpf programs the verifier allows direct access to the packet
-data via skb->data and skb->data_end pointers.
-Ex::
-
-    1:  r4 = *(u32 *)(r1 +80)  /* load skb->data_end */
-    2:  r3 = *(u32 *)(r1 +76)  /* load skb->data */
-    3:  r5 = r3
-    4:  r5 += 14
-    5:  if r5 > r4 goto pc+16
-    R1=ctx R3=pkt(id=0,off=0,r=14) R4=pkt_end R5=pkt(id=0,off=14,r=14) R10=fp
-    6:  r0 = *(u16 *)(r3 +12) /* access 12 and 13 bytes of the packet */
-
-this 2byte load from the packet is safe to do, since the program author
-did check ``if (skb->data + 14 > skb->data_end) goto err`` at insn #5 which
-means that in the fall-through case the register R3 (which points to skb->data)
-has at least 14 directly accessible bytes. The verifier marks it
-as R3=pkt(id=0,off=0,r=14).
-id=0 means that no additional variables were added to the register.
-off=0 means that no additional constants were added.
-r=14 is the range of safe access which means that bytes [R3, R3 + 14) are ok.
-Note that R5 is marked as R5=pkt(id=0,off=14,r=14). It also points
-to the packet data, but constant 14 was added to the register, so
-it now points to ``skb->data + 14`` and accessible range is [R5, R5 + 14 - 14)
-which is zero bytes.
-
-More complex packet access may look like::
-
-
-    R0=inv1 R1=ctx R3=pkt(id=0,off=0,r=14) R4=pkt_end R5=pkt(id=0,off=14,r=14) R10=fp
-    6:  r0 = *(u8 *)(r3 +7) /* load 7th byte from the packet */
-    7:  r4 = *(u8 *)(r3 +12)
-    8:  r4 *= 14
-    9:  r3 = *(u32 *)(r1 +76) /* load skb->data */
-    10:  r3 += r4
-    11:  r2 = r1
-    12:  r2 <<= 48
-    13:  r2 >>= 48
-    14:  r3 += r2
-    15:  r2 = r3
-    16:  r2 += 8
-    17:  r1 = *(u32 *)(r1 +80) /* load skb->data_end */
-    18:  if r2 > r1 goto pc+2
-    R0=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) R1=pkt_end R2=pkt(id=2,off=8,r=8) R3=pkt(id=2,off=0,r=8) R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)) R5=pkt(id=0,off=14,r=14) R10=fp
-    19:  r1 = *(u8 *)(r3 +4)
-
-The state of the register R3 is R3=pkt(id=2,off=0,r=8)
-id=2 means that two ``r3 += rX`` instructions were seen, so r3 points to some
-offset within a packet and since the program author did
-``if (r3 + 8 > r1) goto err`` at insn #18, the safe range is [R3, R3 + 8).
-The verifier only allows 'add'/'sub' operations on packet registers. Any other
-operation will set the register state to 'SCALAR_VALUE' and it won't be
-available for direct packet access.
-
-Operation ``r3 += rX`` may overflow and become less than original skb->data,
-therefore the verifier has to prevent that.  So when it sees ``r3 += rX``
-instruction and rX is more than 16-bit value, any subsequent bounds-check of r3
-against skb->data_end will not give us 'range' information, so attempts to read
-through the pointer will give "invalid access to packet" error.
-
-Ex. after insn ``r4 = *(u8 *)(r3 +12)`` (insn #7 above) the state of r4 is
-R4=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) which means that upper 56 bits
-of the register are guaranteed to be zero, and nothing is known about the lower
-8 bits. After insn ``r4 *= 14`` the state becomes
-R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)), since multiplying an 8-bit
-value by constant 14 will keep upper 52 bits as zero, also the least significant
-bit will be zero as 14 is even.  Similarly ``r2 >>= 48`` will make
-R2=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)), since the shift is not sign
-extending.  This logic is implemented in adjust_reg_min_max_vals() function,
-which calls adjust_ptr_min_max_vals() for adding pointer to scalar (or vice
-versa) and adjust_scalar_min_max_vals() for operations on two scalars.
-
-The end result is that bpf program author can access packet directly
-using normal C code as::
+Programs for tc, XDP and other network hooks access packet data through pointers. The verifier does
+not know the length of a packet. Thus the program compares a pointer with the end of the packet::
 
   void *data = (void *)(long)skb->data;
   void *data_end = (void *)(long)skb->data_end;
-  struct eth_hdr *eth = data;
-  struct iphdr *iph = data + sizeof(*eth);
-  struct udphdr *udp = data + sizeof(*eth) + sizeof(*iph);
+  if (data + 14 > data_end)                         { data=packet, 0 bytes are safe }
+          return 0;
+  return *(__u16 *)(data + 12);                     { data=packet, 14 bytes are safe }
+
+- The largest offset of the compared pointer gives the number of safe bytes.
+- All pointers to the packet with the same id get this number: copies, and copies plus a constant.
+- An access has the check of a map value, with this number as the size of the value. A load of 2
+  bytes at ``data + 13``: ``invalid access to packet, off=13 size=2, R1(id=0,off=13,r=14)``
+- ``pointer += variable`` makes a new id. The pointer keeps the number only if the variable is >= 0
+  and the largest offset stays below it. If not, the program must compare the new pointer.
+- After a helper that can change the packet (``bpf_skb_pull_data()``) all pointers to it are
+  scalars.
+
+Data-flow analysis
+==================
+
+Overview
+--------
+
+The verifier must show that no run of a program does an unsafe operation. It executes the program
+on states. A state represents all runs that arrive at an insn with the same types in registers
+and stack.
+The sections above describe the contents of a state and the check of one insn against a state.
+This section describes how states move through a program.
+
+The main pass is a forward data-flow analysis over the control flow graph. Where two paths meet,
+the verifier makes one state from the two states. This operation is a join::
+
+     follow each path                       join
+
+          [if]                              [if]
+         /    \                            /    \
+      r1=1    r1=5                      r1=1    r1=5
+         \    /                            \    /
+         [next]                            [next]
+    verified 2 times:                 verified 1 time:
+    r1=1, then r1=5                   r1=[1,5]
+
+The work depends on the size of the program. It does not depend on the number of paths.
+
+Three properties are different from a textbook analysis:
+
+- A basic block has a set of states, not one state. The verifier joins two states only when the
+  join keeps the facts that programs use. See examples 1 to 4.
+- Scalar evolution describes a loop before the verifier iterates the loop. See examples 5 to 7.
+- The verifier does not prove termination. The kernel stops a loop or a recursion at run time.
+  See examples 8 and 11.
+
+Examples 9 to 11 show subprograms. The limits are at the end.
+
+How to read the examples:
+
+- The kernel loaded each program below, and ran it where the text gives a return value. The
+  states, the messages and the numbers are the output of the kernel.
+- ``r7=[0,7]`` is a scalar in this range. ``{ r6=0 r7=1 }`` is a state. The examples omit the
+  registers that are not important.
+- The lines ``paths:`` and ``joins:`` below an example compare two algorithms.
+
+The two algorithms::
+
+  paths:  processed 9 insns         a verifier that follows each path
+  joins:  processed 7 insns         the algorithm of this section
+
+A verifier that follows each path goes from the entry to exit, depth first. It stops a path when
+a state that it saw before at the same insn covers the current state. Each branch can double the
+number of paths. Thus such a verifier needs a limit on the number of insns that it processes. The
+limit in the examples is 1 million.
+
+Terms
+-----
+
+The text uses each term with one meaning only::
+
+  term              meaning
+  ----------------  ---------------------------------------------------------------------------
+  state             It represents the runs that arrive at one insn with the same types. It
+                    contains the type of each live register and stack slot, the range and the
+                    known bits of each scalar and of each pointer offset, and the references and
+                    locks that the program holds.
+  live, dead        A register is live at an insn if this insn or a later insn can read its
+                    value. If not, it is dead. The same applies to a stack slot.
+  function          The main program or a subprogram.
+  block             A basic block of the control flow graph.
+  set(B)            The set of states of block B.
+  new state         A state in a set that the verifier did not use yet.
+  t covers s        State t describes each run that state s describes. Thus s cannot arrive at
+                    an insn at which t does not arrive.
+  join(s, t)        A state that covers s and covers t.
+  no join           No useful state covers s and t. The verifier keeps the two states.
+  tested register   A register or a stack slot whose value arrives, without a change, at a later
+                    jump that compares it with a constant.
+  gap               The values between two ranges: -1 and 0 are the gap between -2 and 1.
+  head              The first insn of a loop.
+  latch             The jump from the end of a loop to the head.
+  counted loop      A loop for which scalar evolution calculates the number of iterations.
+  unrolled loop     A loop that the verifier verifies iteration by iteration, with the real
+                    values. Each iteration has its own state.
+  widening          A join at a head that removes the bound that grows.
+  added may_goto    A may_goto insn that the verifier adds to a loop.
+  time slice        250 ms. All loops that have may_goto share it in one run of a program.
+  entry state       The state at the first insn of a subprogram. It contains the arguments and
+                    nothing from the frame of the caller.
+  exit state        The state at an exit of a subprogram.
+  landing pad       The target of unwind_goto: the cleanup code of a caller.
+  room              Less than half of each limit on the number of states is in use.
+
+The algorithm
+-------------
+
+Each block has a set of states. At the start all sets are empty, and the entry state is a new
+state at insn 0.
+
+::
+
+  1. Take the first block, in the order of the program, that has a new state.
+  2. Verify the insns of the block with that state.
+  3. Send the result to each successor of the block.
+  4. In the successor:
+
+              state S arrives at block B
+                          |
+                          v
+            +---------------------------+  yes
+            | a state of set(B)         |------>  drop S
+            | covers S ?                |
+            +---------------------------+
+                          | no
+                          v
+            +---------------------------+  yes
+            | S and a state T of set(B) |------>  replace T with join(S, T)
+            | have a join ?             |         the join is a new state
+            +---------------------------+
+                          | no
+                          v
+              add S to set(B)
+              S is a new state
+
+  5. Stop when no block has a new state.
+
+The verifier accepts the program when it stops and no insn failed.
+
+The order of the program is reverse post order, with the insns of a loop kept together:
+
+- The verifier verifies a block after the predecessors of the block. Thus the states from all
+  predecessors meet before the verifier uses them.
+- The verifier completes a loop before it verifies the code after the loop.
+
+A state contains only live registers and live stack slots. Two states that differ only in a dead
+register are equal.
+
+**Live registers and stack slots.** A register is live at an insn if this insn or a later insn can
+read its value. If not, it is dead. The same applies to a stack slot.
+
+::
+
+     insn                        live before the insn     states that arrive
+     0: r0 = random()            -
+     1: r1 = 0                   r0
+     2: if r0 == 0 goto 4        r0 r1
+     3: r0 = 1                   r1                       { r1=0 }
+     4: r0 = r1                  r1                       { r1=0 } from 2,  { r1=0 } from 3
+     5: exit                     r0
+
+A run that arrives at 4 from 2 has 0 in r0. A run that arrives from 3 has 1 in r0. Insn 4 writes r0
+and does not read it, thus r0 is dead at 4. The two states are equal. The verifier drops the second
+state and verifies block 4 one time.
+
+A dead register also cannot prevent a join. See r6 at insn 14 of example 2.
+
+The verifier calculates the live registers and stack slots one time, before the main pass:
+
+- The calculation goes backward through the control flow graph until nothing changes.
+- A call of a static subprogram reads those of r1-r5 that are live at the entry of the subprogram.
+- The calculation follows pointers to the stack through copies, spills and arguments. Thus it knows
+  which stack slots of a caller a subprogram reads and writes.
+
+1. Two paths meet: join
+-----------------------
+
+::
+
+            +--------------------------+
+            | 0: r0 = random()         |
+            | 1: r7 = r0               |
+            | 2: r7 &= 7               |
+            | 3: if r0 > 100 goto 5    |
+            +--------------------------+
+        r7=[0,7] |                | r7=[0,7]
+                 v                |
+       +--------------+           |
+       | 4: r7 += 16  |           |
+       +--------------+           |
+      r7=[16,23] |                |
+                 v                v
+            +--------------------------+
+            | 5: r0 = r7               |     join: r7=[0,23]
+            | 6: exit                  |
+            +--------------------------+
+
+Block 4 is before block 5 in the order. Thus the state from insn 3 waits in set(5).
+
+::
+
+  event                           set(5)
+  ------------------------------  ------------------------------
+  r7=[0,7] arrives from 3         { r7=[0,7] }      new state
+  the verifier verifies block 4   { r7=[0,7] }      new state
+  r7=[16,23] arrives from 4       { r7=[0,23] }     the join, new state
+  the verifier verifies block 5   { r7=[0,23] }
+
+The verifier verifies block 5 one time.
+
+::
+
+  paths:  processed 9 insns         5 and 6 are verified 2 times
+  joins:  processed 7 insns
+
+The next program has 20 such ifs in sequence. Each ``if`` sets a different bit of r7. At the end
+``r7 & 63`` is an index. The program has 75 insns and 2^20 paths. r7 is different in each path,
+and the value of r7 is important.
+
+::
+
+  if (a) r7 |= 1;                  2 paths
+  if (b) r7 |= 2;                  4 paths
+  ...
+  if (t) r7 |= 1 << 19;            2^20 paths
+  x = arr[r7 & 63];
+
+  paths:  BPF program is too large. Processed 1000001 insn
+  joins:  processed 74 insns
+
+2. No join: why a block has a set of states
+-------------------------------------------
+
+::
+
+  p = lookup(&map, &key);
+  found = p != NULL;
+  ...
+  if (found)
+          x = *p;
+
+     6: r0 = lookup(hash map)    pointer or NULL
+     7: r6 = r0
+     8: r7 = 0
+     9: if r6 == 0 goto 11
+    10: r7 = 1
+    11: r0 = 0                   { r6=0 r7=0 }      { r6=map_value r7=1 }
+    12: if r7 == 0 goto 14       taken              not taken
+    13: r0 = *(u8 *)(r6 + 0)                        { r6=map_value }
+    14: exit                     { r0=[0,255] }
+
+Two states arrive at 11. A scalar and a pointer have no join, thus the verifier keeps the two
+states.
+
+::
+
+                    9: if r6 == 0
+                    /            \
+        { r6=0 r7=0 }            { r6=map_value r7=1 }
+                    \            /
+    set(11) = { r6=0 r7=0 }, { r6=map_value r7=1 }         2 states, no join
+                    |            |
+            12: taken            12: not taken
+                    |            |
+                    |            13: the load uses a pointer
+                    \            /
+    set(14) = { r0=[0,255] }                               r6 and r7 are dead: 1 state
+
+One state for each block is not sufficient here. In one state r6 is "a pointer or a scalar". The
+program can do nothing with such a register. The state also loses the fact that r7 shows which of
+the two r6 is.
+
+::
+
+  paths:  processed 17 insns
+  joins:  processed 16 insns
+
+The rule: **the verifier joins scalars. States that differ in other properties have no join.**
+
+::
+
+  in state s                 in state t                  join
+  -------------------------  --------------------------  -------------
+  scalar 1                   scalar 5                    scalar [1,5]
+  scalar                     pointer                     no join
+  pointer to map A           pointer to map B            no join
+  pointer to function f      pointer to function g       no join
+  a reference                no reference                no join
+  a lock                     no lock                     no join
+  iterator is active         iterator is drained         no join
+  called from insn 2         called from insn 7          no join
+
+This rule keeps the facts that programs use: NULL checks, and error paths that release an object.
+
+**A register that only one state sets.**
+
+::
+
+  ret = get(&p);                 inlined: get() writes p when ret is 0
+  if (ret < 0)
+          goto drop;
+  return p->x;
+
+This pattern is frequent in C. On the error path p is not NULL. It has no value at all, because
+the compiler has no reason to write r8 there.
+
+::
+
+     6: r0 = lookup(hash map)
+     7: r6 = -2                  ret = -ENOENT
+     8: if r0 == 0 goto 11
+     9: r8 = r0                  p
+    10: r6 = 0                   ret = 0
+    11: w7 = 0                   { r6=-2 }          { r6=0 r8=map_value }
+    12: if r6 s< 0 goto 15       taken              not taken
+    13: r0 = *(u32 *)(r8 + 0)                       { r8=map_value }
+    14: exit
+    15: r0 = 0                   { }
+    16: exit
+
+These two states have a join. In a textbook "not set" joins with each value, and the result is
+"not set"::
+
+        { r6=-2 }          { r6=0 r8=map_value }
+                 \          /
+          join: { r6=[-2,0] }                  r8 is not set
+                      |
+        12: if r6 s< 0 goto 15                 the two directions are possible
+                      |
+        13: r0 = *(u32 *)(r8 + 0)              no pointer in r8: the verifier rejects the load
+
+This join is not useful:
+
+- r8 is in the second state because r8 is live. A later insn reads it.
+- The first state does not arrive at that insn. A jump sends it in a different direction.
+- The join cannot select the direction. It arrives at the read without r8.
+
+Thus the verifier keeps the two states. The method that the program uses to separate them is not
+important: ``if (ret < 0)``, ``if (flags & 1)``, or a test 300 insns later.
+
+::
+
+  paths:  processed 18 insns
+  joins:  processed 18 insns
+
+3. Scalars that the verifier does not join
+------------------------------------------
+
+Two scalars always have a join. In some programs the join is not correct for the program.
+
+::
+
+  p = NULL;
+  ret = find(key, &p);           -ENOENT, 1: nothing to do, 0: p is the entry
+  if (ret < 0)
+          goto err;
+  if (ret > 0)
+          goto skip;
+  return p->x;
+
+     0: r0 = random()            key
+     1: r8 = 0                   p = NULL
+     2: r6 = 1                   ret = 1
+     3: if r0 == 0 goto 14
+        ...
+     9: r0 = lookup(hash map)
+    10: r6 = -2                  ret = -ENOENT
+    11: if r0 == 0 goto 14
+    12: r8 = r0                  p
+    13: r6 = 0                   ret = 0
+    14: if r6 s< 0 goto 18       { r6=1 r8=0 }   { r6=-2 r8=0 }   { r6=0 r8=map_value }
+    15: if r6 s> 0 goto 18       { r6=1 r8=0 }                    { r6=0 r8=map_value }
+    16: r0 = *(u32 *)(r8 + 0)                                     { r8=map_value }
+    17: exit
+    18: r0 = 0                   { }
+    19: exit
+
+The third state has no join with the other two: r8 is a pointer. The first two states differ only
+in a scalar. This is the result if the verifier joins them::
+
+        { r6=1 r8=0 }          { r6=-2 r8=0 }
+                     \          /
+              join: { r6=[-2,1] r8=0 }         the join contains ret = 0
+                          |
+        14: if r6 s< 0    |  not taken for 0
+        15: if r6 s> 0    |  not taken for 0
+                          v
+        16: r0 = *(u32 *)(r8 + 0)              R8 invalid mem access 'scalar'
+
+The rule: **a join must not contain a value that no input has, if a later jump tests this value.**
+The rule has two parts.
+
+**Part 1: the tested registers.** The verifier calculates them one time, before the analysis. The
+calculation goes backward until nothing changes, like the calculation of live registers.
+
+::
+
+  insn                           effect
+  -----------------------------  ------------------------------------------------------------
+  if rX < constant               rX is tested
+  rX = constant, rX += ...       the insn writes rX: rX is not tested before the insn
+  rX = rY                        if rX is tested after the insn, rY is tested before it
+  *(u64 *)(r10 - 8) = rX         if the slot is tested after the insn, rX is tested before it
+  rX = *(u64 *)(r10 - 8)         if rX is tested after the insn, the slot is tested before it
+  call helper                    the call writes r0-r5
+  call static subprogram         the registers of r1-r5 that the subprogram tests
+
+Only a value without a change counts: a copy, a spill, a fill. Arithmetic stops the calculation.
+The result for the example::
+
+     9: r0 = lookup(hash map)    -
+    10: r6 = -2                  r0
+    11: if r0 == 0 goto 14       r0 r6
+    12: r8 = r0                  -
+    13: r6 = 0                   -
+    14: if r6 s< 0 goto 18       r6
+    15: if r6 s> 0 goto 18       r6
+    16: r0 = *(u32 *)(r8 + 0)    -
+
+The distance to the jump and the number of jumps are not important.
+
+**Part 2: the decision.** States a and b have a join. The verifier examines the tested registers
+of the block.
+
+::
+
+  the tested registers in a and in b                          decision
+  ----------------------------------------------------------  --------------------
+  one register: its two ranges have a gap                     keep the two states
+  two registers: each has two ranges with no common value     keep the two states
+  all other cases                                             join
+
+A gap on the number line::
+
+    -2   -1    0    1
+     a    .    .    b          the join [-2,1] contains -1 and 0. No input has them.
+
+     0    1
+     a    b                    the join [0,1] contains only the inputs.
+
+  a gap:    -2 and 1      0 and -155     [0,7] and [16,23]
+  no gap:   0 and 1       -1 and 0       -134 and -135      [0,7] and [8,15]      [0,7] and [4,9]
+
+**After the decision** no more rules are necessary:
+
+- The two states are new states in the set of the block. The verifier uses each of them.
+- Each jump has one known direction for each state.
+- After the last jump that tests r6, r6 is dead. A dead register is not part of a state.
+- From there the usual steps apply to each state that arrives at a block: drop, join or add.
+
+The result::
+
+      the paths meet            the last test of r6
+            |                          |
+            v                          v
+    --------+==========================+----------------->  insns
+                   2 states                 r6 is dead: the states can join
+
+  paths:  processed 24 insns
+  joins:  processed 22 insns
+
+**Two registers.** This pattern is from a real program::
+
+  ret = 0;
+  state = lookup(&map, &key);
+  if (!state) {
+          err = update(&map, &key, &new);
+          ret = err < 0 ? DROP : 0;
+          ...
+          if (err < 0)
+                  goto out;
+          state = lookup(&map, &key);
+          if (!state)
+                  return 0;
+  }
+  out:
+  if (ret < 0)
+          goto drop;
+  return state->x;
+
+    25: r0 = update(hash map)    r8=0: state is NULL
+    26: w9 = 0                   ret = 0
+    27: if w0 s> -1 goto 29
+    28: w9 = -155                ret = DROP
+    29: w6 = 0                   { w0>=0 w9=0 r8=0 }         { w0<0 w9=-155 r8=0 }
+    30: if w0 s< 0 goto 38       not taken                   taken
+        ...
+    35: r0 = lookup(hash map)
+    36: r8 = r0
+    37: if r8 == 0 goto 41
+    38: if w9 s< 0 goto 41       { w9=0 r8=map_value }       { w9=-155 r8=0 }
+    39: r0 = *(u32 *)(r8 + 0)    { r8=map_value }
+    40: exit
+    41: r0 = 0
+    42: exit
+
+A join at 29 contains err < 0 together with ret = 0. This state goes from 30 to 38 with NULL in
+r8. The jump at 38 is not taken. At 39 the result is ``R8 invalid mem access 'scalar'`` again.
+
+::
+
+  paths:  processed 46 insns
+  joins:  processed 43 insns
+
+0 and -155 have a gap, thus the first line of the table is sufficient here. Now change err and ret
+to flags, 0 or 1. No register has a gap. The second line of the table applies::
+
+               ret=0    ret=1
+    err=0        a        x            a, b: the inputs
+    err=1        x        b            x:    pairs that only the join contains
+
+  paths:  processed 53 insns
+  joins:  processed 46 insns
+
+More cases::
+
+  the states that meet             the later jumps              decision
+  -------------------------------  ---------------------------  ------------------------
+  ret=-2 and ret=1                 ret < 0, then ret > 0        a gap: keep
+  ret=-134 and ret=-135            ret < 0                      no gap: join
+  ret=-134 and ret=-160            ret < 0, then ret == -158    a gap: keep
+  (a>=0 b=0) and (a<0 b=-155)      a < 0, then b < 0            a gap: keep
+  (a=0 b=0) and (a=1 b=1)          a != 0, then b != 0          two registers: keep
+  i=0 and i=1                      i < 64                       no gap: join
+  the 20 ifs of example 1          no jump tests r7             join
+
+The rule only refuses a join. Thus it cannot make the verifier accept an unsafe program. The rule
+does not apply at a head, where the verifier uses widening (example 7). It also does not apply
+when there is no room, see "Why the analysis ends, and the limits".
+
+The programs of this example, and ``ret = get(&p)`` of example 2, also load when a compiler makes
+them from C.
+
+4. What a join loses
+--------------------
+
+A join loses the relation between scalars.
+
+::
+
+  if (c) { i = 3; n = 4; } else { i = 7; n = 8; }
+  arr[n - i]
+
+           c                        !c
+      { i=3 n=4 }              { i=7 n=8 }           n - i is 1 in each input
+                 \              /
+          join: { i=[3,7] n=[4,8] }                  n - i is [-3,5]
+
+  paths:  processed 25 insns
+  joins:  R8 min value is negative, either use unsigned index or do a if (index >=0) check.
+
+No jump tests i or n, thus the verifier joins them.
+
+The second case is a scalar that guards the range of a different scalar, when its own values have
+no gap::
+
+  ret = idx < 64 ? 0 : -1;
+  ...
+  if (ret < 0)
+          goto drop;
+  return val->data[idx];
+
+      { ret=0 idx=[0,63] }          { ret=-1 idx>=64 }
+                          \          /
+               join: { ret=[-1,0] idx=scalar }       -1 and 0 have no gap, no jump tests idx
+
+  paths:  processed 24 insns
+  joins:  math between map_value pointer and register with unbounded min value is not allowed
+
+With -EINVAL as a replacement for -1 there is a gap. Then the program loads: 22 insns.
+
+Recommendation: test a scalar at the place where the program uses it.
+
+**All rules that keep two states.** Each line is a pair of states that has a join. The verifier
+does not use the join, because programs depend on the difference.
+
+::
+
+  the states differ in                      example                         applies
+  ----------------------------------------  ------------------------------  ---------------------
+  a register that only one state sets       example 2                       while there is room
+  a tested register, with a gap             example 3                       while there is room
+  two tested registers                      example 3                       while there is room
+  a scalar that is 0 in one state only      if (h->v4) .. else if (h->v6)   while there is room
+  a constant that a subprogram returns      true or false, an enum          while there is room
+  a constant that becomes a stack offset    a[n++] = p                      while there is room
+  a constant that a helper or a kfunc       the size argument of            always
+  must know                                 bpf_ringbuf_reserve()
+  the iteration of bpf_loop(), for 8        bpf_loop(4, cb, ...)            always
+  iterations or less
+  the iteration of an unrolled loop         example 6                       always
+
+At a head the verifier uses widening. There only the rule for the stack offset and the two rules
+for iterations apply.
+
+About the stack offset: ``if (x) a[n++] = p; else b[m++] = p;`` is one store insn. A store at an
+unknown offset removes the pointers from all slots that it can write.
+
+5. A counted loop
+-----------------
+
+::
+
+     8: r6 = 0
+     9: r1 = r0                  <- head.  r6=[0,63]   r0: map value of 64 bytes
+    10: r1 += r6
+    11: r2 = 0
+    12: *(u8 *)(r1 + 0) = r2
+    13: r6 += 1
+    14: if r6 < 64 goto 9        r6=[1,63] goes to 9: covered
+    15: ...                      r6=64
+
+Scalar evolution finds that r6 is {0,+,1}, and that the latch permits 64 iterations. Thus the loop
+is a counted loop.
+
+::
 
-  if (data + sizeof(*eth) + sizeof(*iph) + sizeof(*udp) > data_end)
-	  return 0;
-  if (eth->h_proto != htons(ETH_P_IP))
-	  return 0;
-  if (iph->protocol != IPPROTO_UDP || iph->ihl != 5)
-	  return 0;
-  if (udp->dest == 53 || udp->source == 9)
-	  ...;
+           r6=0
+             |     the verifier changes the state before it adds the state to set(9):
+             v     each induction variable gets its range for all iterations
+    +--> 9:  head     { r6=[0,63] }
+    |        body     verified 1 time. The store stays in the 64 bytes.
+    |   13:  r6 += 1
+    +-- 14:  if r6 < 64           { r6=[1,63] } returns to the head: { r6=[0,63] } covers it
+             |
+             v
+        15:  { r6=64 }
 
-which makes such programs easier to write comparing to LD_ABS insn
-and significantly faster.
+No block of the loop has a new state after one pass. The loop is complete.
 
-Pruning
-=======
+6. A loop that is not counted
+-----------------------------
 
-The verifier does not actually walk all possible paths through the program.  For
-each new branch to analyse, the verifier looks at all the states it's previously
-been in when at this instruction.  If any of them contain the current state as a
-subset, the branch is 'pruned' - that is, the fact that the previous state was
-accepted implies the current state would be as well.  For instance, if in the
-previous state, r1 held a packet-pointer, and in the current state, r1 holds a
-packet-pointer with a range as long or longer and at least as strict an
-alignment, then r1 is safe.  Similarly, if r2 was NOT_INIT before then it can't
-have been used by any path from that point, so any value in r2 (including
-another NOT_INIT) is safe.  The implementation is in the function regsafe().
-Pruning considers not only the registers but also the stack (and any spilled
-registers it may hold).  They must all be safe for the branch to be pruned.
-This is implemented in states_equal().
+::
+
+     9: r7 = 0
+    10: r7 += 3                  <- head.  r7=scalar
+    11: r1 = *(u64 *)(r6 + 0)    memory that a different cpu can change
+    12: if r1 != 0 goto 10       r7=scalar goes to 10: covered
+    13: r0 = r7
+    14: exit
+
+There are two questions, and they have two answers.
+
+::
+
+  question                       answer
+  -----------------------------  ---------------------------------------------------------------
+  Are all iterations safe?       The fixpoint shows it, see below.
+  Does the loop end?             The verifier does not prove it. See example 8.
+
+The number of iterations is not known. But scalar evolution knows what the loop changes: r7 is
+{0,+,3}. Without a limit on the iterations r7 can have each value. Thus the verifier makes r7 an
+unknown scalar in the state that enters the loop. After one pass the state that returns to the
+head is covered.
+
+::
+
+  paths:  BPF program is too large. Processed 1000001 insn      r7 differs in each iteration
+  joins:  processed 18 insns
+
+**The verifier unrolls first.** It verifies the first iterations one by one, with the real values:
+``r7=0`` in the first iteration. Many loops exit in the first or second iteration. In other loops
+constants decide all exits. The verifier stops the unroll when a jump that exits the loop can go
+in the two directions. In this example that occurs in the first iteration.
+
+::
+
+  loop                                               method
+  -------------------------------------------------  -------------------------------------------
+  counted, scalar evolution describes all registers  ranges at the head, example 5
+  counted, a register has no description             unroll, 100000 insns at most
+  not counted                                        unroll while constants decide the exits,
+                                                     4096 insns at most. Then this example and
+                                                     example 7
+
+Scalar evolution describes these registers and stack slots of a counted loop::
+
+  what the loop does with the register               the register at the head
+  -------------------------------------------------  -------------------------------------------
+  nothing                                            no change
+  computes the same constant in each iteration       no change
+  adds a constant                                    range from the number of iterations
+  sets it to one of some values that do not change   union of the values
+  loads it again in each iteration                   unknown scalar
+  clears bits of [0, maximum]: &, zero extension     no change
+  moves a pointer to arena                           pointer to arena, it has no offset
+
+7. Widening
+-----------
+
+::
+
+     9: r7 = 1
+    10: r7 *= 3                  <- head
+    11: r7 &= 63
+    12: r1 = *(u64 *)(r6 + 0)
+    13: if r1 != 0 goto 10
+    14: r6 += r7                 r7=[0,63]
+    15: r0 = *(u8 *)(r6 + 0)     r6: map value of 64 bytes
+
+r7 is not an add recurrence. Thus scalar evolution has no description of it. The verifier iterates
+the loop::
+
+  pass   r7 at the head     r7 at the latch     step
+  -----  -----------------  ------------------  ------------------------------------------------
+  1      1                  3                   the verifier unrolls this iteration (example 6)
+  2      3                  9                   not covered, the upper bound grows: [3, S32_MAX]
+  3      [3, S32_MAX]       [0,63]              not covered, the lower bound grows: [0, S32_MAX]
+  4      [0, S32_MAX]       [0,63]              covered: the loop is complete
+
+With a usual join a range can grow by a small step in each pass, and 2^64 passes are possible.
+Widening moves the bound that grows directly to one of a small number of stops::
+
+  lower bound:    S64_MIN  <--  S32_MIN  <--  0
+  upper bound:                                0  -->  S32_MAX  -->  U32_MAX  -->  S64_MAX
+
+Thus a range can grow only a small number of times.
+
+The edge from 13 to 14 has ``r7=[0,63]``, the value of r7 after ``&= 63``. Thus the access at 15 is
+correct. Widening at the head does not change a value that the body calculates again.
+
+::
+
+  paths:  infinite loop detected at insn 10
+  joins:  processed 31 insns
+
+8. A loop ends at run time: may_goto
+------------------------------------
+
+It is possible that the loop of example 6 never ends. The verifier adds a may_goto insn before the
+latch.
+
+- may_goto decrements a count.
+- After 65535 iterations it reads the clock.
+- It jumps to its target when the time slice is over.
+
+One run of a program has one time slice and one count. All loops and all subprograms of the run
+share them.
+
+::
+
+                    one run of a program on a cpu
+    +---------------------------------------------------------------+
+    |   start of the time slice (250 ms)        count (65535)       |
+    +---------------------------------------------------------------+
+                             |  entry: the subprogram starts from the count that is left
+                             |  exit:  the subprogram gives back the count that it has left
+                             v
+    +----------------+      +----------------+      +----------------+
+    | main program   | call | subprogram f   | call | subprogram g   |
+    | loop, may_goto | ---> | loop, may_goto | ---> | loop, may_goto |
+    +----------------+      +----------------+      +----------------+
+
+Thus a run reads the clock even if each loop in each subprogram is short. Each frame on the stack
+does at most 65535 iterations between two reads of the clock.
+
+This is the program that runs::
+
+    17: r7 += 3
+    18: r1 = *(u64 *)(r6 + 0)
+    19..25: may_goto 30
+    26: if r1 != 0 goto 17
+    27: r0 = r7
+    28: exit
+    ...
+    30: r0 = 0                   after the last insn of the function, for all its added may_goto
+    31: exit
+
+With 0 in memory it returns 3. With 1 in memory it returns 0 after 250 ms.
+
+The edge of the added may_goto is also an edge for the analysis. The state at the latch goes to
+exit with r0 = 0. The verifier checks it as it checks each exit: the program must hold nothing,
+and 0 must be a valid return value.
+
+The verifier adds may_goto only where it is necessary::
+
+  loop                                                         the verifier
+  -----------------------------------------------------------  ---------------------------------
+  counted                                                      adds nothing
+  unrolled to its end                                          adds nothing
+  each iteration executes may_goto or bpf_iter_*_next()        adds nothing
+  no exit                                                      rejects the program:
+                                                               loop at insn N never exits
+  all other loops                                              adds may_goto
+
+No return value is correct for each program type. Thus the kernel informs user space that it
+stopped a run. It sets ``unwound`` in ``struct bpf_prog_info``. It also writes the cause to the
+stderr stream of the program.
+
+**The target of an added may_goto.** An added may_goto has one target, and the verifier verifies
+only this edge. The verifier selects the target at load time::
+
+          does the frame hold a lock, a reference or an rcu section
+          that it did not hold at its entry ?
+               | no                                | yes
+               v                                   v
+       exit from the function               exit from the loop
+       (insn 30 above)                      (insn 27 above: jump across the latch)
+
+Three programs show that one target for all loops is not possible.
+
+Program 1: exit from the function.
+
+::
+
+  do { p = lookup(hash map); } while (!p);
+  return *p;
+
+  paths:  infinite loop detected at insn 1
+  joins:  processed 14 insns.  With an empty map it returns 0 after 251 ms
+
+The code after the loop uses the fact that the latch found: p is not NULL. A jump across the latch
+sends NULL to that code.
+
+Program 2: exit from the loop.
+
+::
+
+  lock(&v->l);
+  do { v->cnt++; } while (v->flag);
+  unlock(&v->l);
+  return 1;
+
+  paths:  infinite loop detected at insn 13
+  joins:  processed 24 insns.  With flag = 1 it returns its own 1 after 250 ms, the lock is free
+
+The program cannot exit with the lock. The code after the loop releases the lock.
+
+Program 3: no target is possible.
+
+::
+
+  rcu_read_lock();
+  do { p = lookup(hash map); } while (!p);
+  x = *p;
+  rcu_read_unlock();
+
+  paths:  infinite loop detected at insn 2
+  joins:  R0 invalid mem access 'map_value_or_null'
+
+The program cannot exit in the rcu section, and after the loop p can be NULL. There is no third
+target. Code that releases objects and then exits is a landing pad. Landing pads belong to calls,
+not to loops.
 
-Some technical details about state pruning implementation could be found below.
+**Exit from the function.**
 
-Register liveness tracking
---------------------------
+::
+
+  the may_goto is in                                         insns at the target
+  ---------------------------------------------------------  -----------------------------------
+  the main program, the callback of a timer                  r0 = 0; exit
+  a subprogram, and unwind_goto follows each call of it      r0 = 0; unwind_exit
+                                                             the callers continue at their
+                                                             landing pads
+  a different subprogram, a callback of bpf_loop()           not possible: exit from the loop
+
+Some states at the may_goto can hold an object while other states hold nothing. Then the target
+is the exit from the loop for all states.
+
+**Exit from the loop.**
+
+::
+
+  position of the may_goto         target                      is the edge in the program?
+  -------------------------------  --------------------------  ---------------------------------
+  before a jump that exits the     the target of that jump     yes. The facts about the loops
+  loop                                                         stay correct.
+  at the head, when no such jump   an exit of this loop and    no. The edge skips the body.
+  is in each iteration             of all loops around it
+
+The body can contain the insn that stops a loop around it, for example a call of
+``bpf_iter_num_next()``. Thus a may_goto at the head exits from all loops around it.
+
+9. Subprograms
+--------------
+
+::
+
+     1: r1 = random()
+     2: call low3                waits.  r1=scalar goes to 10
+     3: r6 = r0                  r0=[0,7]
+        ...
+     7: call low3                r1=scalar goes to 10: covered.  r0=[0,7] is known
+     8: r0 += r6
+     9: exit
+    10: r0 = r1                  low3(x) { return x & 7; }
+    11: r0 &= 7
+    12: exit                     r0=[0,7] goes to the calls that wait
+
+The verifier verifies a static subprogram for each entry state, not for each chain of calls.
+
+::
+
+     2: call low3  ---- { r1=scalar } ----+
+                                          v
+                                +------------------+
+     7: call low3  -- covered ->| 10: r0 = r1      |      verified 1 time
+                                | 11: r0 &= 7      |
+                                | 12: exit         |
+                                +------------------+
+                                          |
+     3: r6 = r0    <--- { r0=[0,7] } -----+
+     8: r0 += r6   <--- { r0=[0,7] } -----+
+
+- The entry state arrives at the first block of the subprogram like each state at a block. The
+  verifier drops it, joins it or adds it.
+- The call waits. The verifier saves the state of the caller.
+- Each exit state goes to all calls that wait for this entry state.
+
+The result::
+
+  paths:  processed 16 insns
+  joins:  processed 13 insns        each insn 1 time
+
+The next program has 12 subprograms. Each subprogram calls the next one 2 times. It has 103 insns.
+
+::
+
+  paths:   f1 --> f2 f2 --> f3 f3 f3 f3 --> ...         2^11 calls of f12
+  joins:   f1 --> f2    --> f3          --> ...         each subprogram 1 time
+
+  paths:  processed 45052 insns
+  joins:  processed 103 insns
+
+In some cases the verifier verifies a subprogram in the context of the caller. Then the frames of
+the callers are part of the state, and states with different chains of calls have no join. The
+most important cases:
 
-In order to make state pruning effective, liveness state is tracked for each
-register and stack slot. The basic idea is to track which registers and stack
-slots are actually used during subseqeuent execution of the program, until
-program exit is reached. Registers and stack slots that were never used could be
-removed from the cached state thus making more states equivalent to a cached
-state. This could be illustrated by the following program::
+- The subprogram gets a pointer to the stack of the caller, or a dynptr.
+- The subprogram gets a pointer that can be NULL. It does the NULL check for the caller.
+- The call is in an unrolled loop. The iterations must not meet in the subprogram.
+- The subprogram is a callback.
 
-  0: call bpf_get_prandom_u32()
-  1: r1 = 0
-  2: if r0 == 0 goto +1
-  3: r0 = 1
-  --- checkpoint ---
-  4: r0 = r1
-  5: exit
+The verifier verifies a global subprogram alone, after the main program. The entry state has the
+arguments of its BTF prototype. At a call of a global subprogram the verifier checks the arguments
+against the prototype. It does not enter the subprogram. After the call the return value is an
+unknown scalar. The program must not hold a lock at the call.
 
-Suppose that a state cache entry is created at instruction #4 (such entries are
-also called "checkpoints" in the text below). The verifier could reach the
-instruction with one of two possible register states:
+10. A call through a table of functions
+---------------------------------------
+
+::
+
+  static const op_fn ops[16] = { op0, op1, ... op15 };
+  return ops[kind & 15](3);
+
+     3: w1 &= 15
+     4: r1 <<= 3                 r1=[0,120] in steps of 8
+     5: r2 = ops
+     7: r2 += r1
+     8: r2 = *(u64 *)(r2 + 0)    { r2=one of 16 functions }
+     9: w1 = 3
+    10: callx r2                 waits for each of the 16.  r1=3 goes to all of them
+    11: exit                     r0 of each of them arrives here, and the verifier joins them
+
+The load at 8 can give 16 different pointers. The verifier does not make 16 states. It makes one
+state, in which r2 holds one of a set of functions.
+
+::
+
+    +-----+-----+-------+------+
+    | op0 | op1 |  ...  | op15 |    8: load  -->  { r2=one of 16 functions }   1 state
+    +-----+-----+-------+------+
+                                   10: callx r2
+                                          |    the entry state { r1=3 } goes to each function
+             +------------+---------------+------------+
+             v            v                            v
+            op0          op1            ...           op15
+             |            |                            |
+             +------------+---------------+------------+
+                                          v    the exit states arrive at 11: join
+                                   11: exit
+
+16 states are not useful here. They differ only in the function, and they are parallel from the
+load to the call. At the call the verifier verifies each function of the set with the arguments
+of the call, as for a direct call.
+
+::
+
+  paths:  processed 118 insns
+  joins:  processed 73 insns
+
+- Only a load from a table makes a set. Two pointers to different functions that arrive from two
+  branches have no join (example 2).
+- A helper or a kfunc that gets a callback must know the callback. There the verifier makes one
+  state for each function of the set.
+
+11. Recursion
+-------------
+
+::
+
+  depth(n) { return n ? (depth(n - 1) + 1) & 255 : 0; }         called with 5
+
+Recursion uses the mechanisms of examples 7 and 9. The verifier handles the entry of a recursive
+subprogram like a head. A call of a subprogram that the verifier verifies at that time waits like
+each other call.
+
+::
+
+        main program: call depth       entry state { r1=5 }
+                          |
+                          v
+    +-->  entry of depth()             like a head: join and widening
+    |        ...
+    +---  call depth(n - 1)            entry state { r1=4 }. The call waits.
+             ^
+             |
+          exit of depth()              each exit state goes to all calls that wait.
+                                       The call in depth() is one of them.
+
+Two values must become stable::
+
+  n at the entry      step
+  ------------------  ---------------------------------------------------------------------
+  5                   from the main program
+  [0,5]               4 arrives from the call in depth(): join and widening,
+                      the lower bound moves to 0
+  [0,5]               [0,4] arrives from that call: covered. Stable.
+
+  the return value    step
+  ------------------  ---------------------------------------------------------------------
+  0                   n == 0. It goes to the calls that wait.
+  [0,1]               (0 + 1) & 255 arrives at the exit
+  [0,S32_MAX]         the range grows on a cycle: widening
+  [0,S32_MAX]         ([0,S32_MAX] + 1) & 255 = [0,255] arrives at the exit: covered. Stable.
+
+The depth of the recursion is not known, like the number of iterations in example 6. Thus each
+subprogram on a cycle of the call graph gets a check at its entry. The check counts, for each
+program and cpu, the stack that recursive frames use and the calls in this run.
+
+::
+
+  limit for one run of a program              value
+  ------------------------------------------  ---------------------------------------------
+  kernel stack of recursive frames            4096 bytes
+  stack in arena of recursive frames          the part of this stack that is free
+  calls of recursive subprograms              8M
+
+     kernel memory                      arena
+    +----------------------+          +---------------------------+
+    | BPF stack     <- r10 |          | stack in arena     <- r12 |
+    |  frames without      |          |  frames without           |
+    |  recursion           |          |  recursion                |
+    +----------------------+          +---------------------------+
+    |  recursive frames:   |          |  recursive frames:        |
+    |  4096 bytes          |          |  the remaining part       |
+    +----------------------+          +---------------------------+
+
+When a run hits a limit, the subprogram returns 0. If unwind_goto follows each call of the
+subprogram, it uses unwind_exit as a replacement. The kernel marks the program as in example 8.
+
+::
 
-* r0 = 1, r1 = 0
-* r0 = 0, r1 = 0
+  paths:  recursive call from depth() to depth()
+  joins:  processed 19 insns.  It returns 5
 
-However, only the value of register ``r1`` is important to successfully finish
-verification. The goal of the liveness tracking algorithm is to spot this fact
-and figure out that both states are actually equivalent.
+Why the analysis ends, and the limits
+-------------------------------------
 
-Understanding eBPF verifier messages
-====================================
+- A state in a set can only grow. With widening it grows only a small number of times.
+- Two states stay in a set only if they have no join, or if a rule of example 4 keeps them. Real
+  programs have a small number of such states at an insn, because a state contains only live
+  registers.
+- It is possible to write a program that has many such states. Thus the verifier limits the number
+  of states. The limits depend on the size of the program.
 
-The following are few examples of invalid eBPF programs and verifier error
-messages as seen in the log:
+For a program of N insns::
 
-Program with unreachable instructions::
+  states at one insn      1024
+  states at one time      16 * N + 4096
+  states in total         256 * N + 64K
 
-  static struct bpf_insn prog[] = {
-  BPF_EXIT_INSN(),
-  BPF_EXIT_INSN(),
-  };
-
-Error::
+The verifier rejects a program that hits a limit. The messages are
+``more than 1024 states that cannot be joined at insn N`` and ``too many states for N insns``.
 
-  unreachable insn 1
+The rules of example 4 do not cause a program to hit a limit. Most of them apply only while there
+is room::
 
-Program that reads uninitialized register::
+    0                     half of a limit                      limit
+    |--------------------------|-------------------------------|
+      room: the rules keep         no room: the verifier         the verifier
+      two states                   uses each join that exists    rejects the program
 
-  BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-  BPF_EXIT_INSN(),
-
-Error::
-
-  0: (bf) r0 = r2
-  R2 !read_ok
-
-Program that doesn't initialize R0 before exiting::
-
-  BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
-  BPF_EXIT_INSN(),
-
-Error::
-
-  0: (bf) r2 = r1
-  1: (95) exit
-  R0 !read_ok
-
-Program that accesses stack out of bounds::
-
-    BPF_ST_MEM(BPF_DW, BPF_REG_10, 8, 0),
-    BPF_EXIT_INSN(),
-
-Error::
-
-    0: (7a) *(u64 *)(r10 +8) = 0
-    invalid stack off=8 size=8
-
-Program that doesn't initialize stack before passing its address into function::
-
-  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-  BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-  BPF_EXIT_INSN(),
-
-Error::
-
-  0: (bf) r2 = r10
-  1: (07) r2 += -8
-  2: (b7) r1 = 0x0
-  3: (85) call 1
-  invalid indirect read from stack off -8+0 size 8
-
-Program that uses invalid map_fd=0 while calling to map_lookup_elem() function::
-
-  BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-  BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-  BPF_EXIT_INSN(),
-
-Error::
-
-  0: (7a) *(u64 *)(r10 -8) = 0
-  1: (bf) r2 = r10
-  2: (07) r2 += -8
-  3: (b7) r1 = 0x0
-  4: (85) call 1
-  fd 0 is not pointing to valid bpf_map
-
-Program that doesn't check return value of map_lookup_elem() before accessing
-map element::
-
-  BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-  BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-  BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
-  BPF_EXIT_INSN(),
-
-Error::
-
-  0: (7a) *(u64 *)(r10 -8) = 0
-  1: (bf) r2 = r10
-  2: (07) r2 += -8
-  3: (b7) r1 = 0x0
-  4: (85) call 1
-  5: (7a) *(u64 *)(r0 +0) = 0
-  R0 invalid mem access 'map_value_or_null'
-
-Program that correctly checks map_lookup_elem() returned value for NULL, but
-accesses the memory with incorrect alignment::
-
-  BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-  BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-  BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-  BPF_ST_MEM(BPF_DW, BPF_REG_0, 4, 0),
-  BPF_EXIT_INSN(),
-
-Error::
-
-  0: (7a) *(u64 *)(r10 -8) = 0
-  1: (bf) r2 = r10
-  2: (07) r2 += -8
-  3: (b7) r1 = 1
-  4: (85) call 1
-  5: (15) if r0 == 0x0 goto pc+1
-   R0=map_ptr R10=fp
-  6: (7a) *(u64 *)(r0 +4) = 0
-  misaligned access off 4 size 8
-
-Program that correctly checks map_lookup_elem() returned value for NULL and
-accesses memory with correct alignment in one side of 'if' branch, but fails
-to do so in the other side of 'if' branch::
-
-  BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-  BPF_LD_MAP_FD(BPF_REG_1, 0),
-  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-  BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-  BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
-  BPF_EXIT_INSN(),
-  BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 1),
-  BPF_EXIT_INSN(),
-
-Error::
-
-  0: (7a) *(u64 *)(r10 -8) = 0
-  1: (bf) r2 = r10
-  2: (07) r2 += -8
-  3: (b7) r1 = 1
-  4: (85) call 1
-  5: (15) if r0 == 0x0 goto pc+2
-   R0=map_ptr R10=fp
-  6: (7a) *(u64 *)(r0 +0) = 0
-  7: (95) exit
-
-  from 5 to 8: R0=imm0 R10=fp
-  8: (7a) *(u64 *)(r0 +0) = 1
-  R0 invalid mem access 'imm'
-
-Program that performs a socket lookup then sets the pointer to NULL without
-checking it::
-
-  BPF_MOV64_IMM(BPF_REG_2, 0),
-  BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -8),
-  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-  BPF_MOV64_IMM(BPF_REG_3, 4),
-  BPF_MOV64_IMM(BPF_REG_4, 0),
-  BPF_MOV64_IMM(BPF_REG_5, 0),
-  BPF_EMIT_CALL(BPF_FUNC_sk_lookup_tcp),
-  BPF_MOV64_IMM(BPF_REG_0, 0),
-  BPF_EXIT_INSN(),
-
-Error::
-
-  0: (b7) r2 = 0
-  1: (63) *(u32 *)(r10 -8) = r2
-  2: (bf) r2 = r10
-  3: (07) r2 += -8
-  4: (b7) r3 = 4
-  5: (b7) r4 = 0
-  6: (b7) r5 = 0
-  7: (85) call bpf_sk_lookup_tcp#65
-  8: (b7) r0 = 0
-  9: (95) exit
-  Unreleased reference id=1, alloc_insn=7
-
-Program that performs a socket lookup but does not NULL-check the returned
-value::
-
-  BPF_MOV64_IMM(BPF_REG_2, 0),
-  BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -8),
-  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-  BPF_MOV64_IMM(BPF_REG_3, 4),
-  BPF_MOV64_IMM(BPF_REG_4, 0),
-  BPF_MOV64_IMM(BPF_REG_5, 0),
-  BPF_EMIT_CALL(BPF_FUNC_sk_lookup_tcp),
-  BPF_EXIT_INSN(),
-
-Error::
-
-  0: (b7) r2 = 0
-  1: (63) *(u32 *)(r10 -8) = r2
-  2: (bf) r2 = r10
-  3: (07) r2 += -8
-  4: (b7) r3 = 4
-  5: (b7) r4 = 0
-  6: (b7) r5 = 0
-  7: (85) call bpf_sk_lookup_tcp#65
-  8: (95) exit
-  Unreleased reference id=1, alloc_insn=7
+A join without the rules can lose a fact that the program uses. But 20 flags do not make a million
+states.
-- 
2.55.0

