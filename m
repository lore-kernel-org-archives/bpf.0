Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B33ACEEF
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058249; cv=none; b=XVCV3jh2eFilUYAmJeSYfvc7fEF96PyYunoepmLdRL6iwUuqPkAEIXzgNL4FqKS1RNK2WNGiV/r1zzGzZS5m2LcoePtwDBtvxNyd+LTwk2I3vjWEoudifByji2gjJ4zRyWz+67vmJGSD7Luhmd3kswk8Cvo6l1VLJ37/uJiFn1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058249; c=relaxed/simple;
	bh=x6lW6t+fBCjX7iC3FaBo6Athw0kYlYqqVeKndYdJiKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=el3IXy89mo1fMy7GrWkFtztY4M+2ZEZNWVjb9k5OCPJ5biEKqrDHWN7KRPd6ppds3Ts3iGIrhp+6eld87nX7DelaQsQg9WGebwv43Pifppd8sTp1C0u8CJFZM1N8FJreYMqcU7bctqT/is5vQxhZvN2qtlMWG/6BM89aZ8aQi6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4drmjKc; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4drmjKc"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-661cd3c9c0eso2868303a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773058245; x=1773663045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LW/dbx4v5bxeu+jkcx8e6sxopnK8VzdjrMPzFiy3zE=;
        b=D4drmjKcTu1p3lkuwXCvG8hDtl6HZAit9dnZ74VwIPH1naAtLYN4ihjBB1OO46cgCo
         ffNUM29MuHkx4PndtUi1DO6TRZH2PuFckT/GeaP7H+VmQexDRLV+tYwrGYau/nniRCkQ
         Ljuaj4TU0gBAdCthHxscZEKjH83OtXM7IfI2V5k5ndiMleumoH2EF9EdNvnWj/Hq/Hlq
         gbOt235VAqb1LWMmE4zEzlHg1dPXioWbmEkNhfpq3a7P13+B0RKujJcPL24S3rykkOax
         5mk7LU/s1EdsTNrtqFM5qLq90ylGHAqXnlJ4vm9BfDUDiGV/TJhdL9tBuVuwJknTRkVA
         5gkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058245; x=1773663045;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0LW/dbx4v5bxeu+jkcx8e6sxopnK8VzdjrMPzFiy3zE=;
        b=l5KnAiWRflAI5wb5zQzlO2aPqMsh6mYaFpdmXJR9JWdwi1su5Ruq/kXU+wRKGQqF+l
         G6Uj/8JrFHpk6FvgeroOX5KFtIGbMMjS0EOhXv/TKby2Yi7toBBmbihIPMmH2URivD41
         jPbnkP00TT3yG+b1J7NgepijL2nximHAgUszldfwG/2QrtId4fxOZOh8d2P1mNgueeH+
         gf2nsXOpgOP2o1wsRs4a8gURpzJoc3GQkbfB37+qscUDVSRPYnoMmYpGJyvtIfN3XT9q
         taVK/fvvqVc0HnpB3xBuGLCJXu7VdLgX7aNBw0KTBRkqYuMShVjIppRKDzENhKsYnzj5
         heJA==
X-Forwarded-Encrypted: i=1; AJvYcCU6QaPR1hG2wJQ7gvGJwKmpbXgShWySEp1ggBUavWNf06Tbyn9N4DOYxJcKmL4TFKfzZEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm31RQC5fInB1jUxSbLrVusihUSrT5r6JI4NrarMHzSACgN7py
	XuZGP5mf+dbRGYd9q05zIOaA5ynjQvCGDKa3UEPSBcAGhKOqqbcbj9fFG2RAxEVqoCiV3A==
X-Received: from ejbco37.prod.google.com ([2002:a17:906:d265:b0:b93:577c:bb91])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9726:b0:b97:464:9570
 with SMTP id a640c23a62f3a-b970464b2f0mr86262866b.22.1773058244180; Mon, 09
 Mar 2026 05:10:44 -0700 (PDT)
Date: Mon,  9 Mar 2026 12:10:16 +0000
In-Reply-To: <20260309121033.2594457-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309121033.2594457-1-bqe@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309121033.2594457-2-bqe@google.com>
Subject: [RFC PATCH 1/1] bpf, docs: structured docs for the verifier
From: Burak Emir <bqe@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Burak Emir <bqe@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Multi-part docseries (verifier-formal-*.rst) for BPF verifier.

Provides some background that helps get a structured overview of
the static analysis that happens in the verifier.

The documentation covers:
* Part 1: Abstract Interpretation
* Part 2: Abstract Domain (Value lattices, tnum, pointer provenance)
* Part 3: Data Flow (Transfer functions, ALU ops, bounds tracking)
* Part 4: Pruning (State equivalence, subsumption, liveness)
* Part 5: Advanced Contexts (BTF, concurrency, reference tracking)

Signed-off-by: Burak Emir <bqe@google.com>
Assisted-by: Gemini:gemini-3.1-pro,gemini-3-flash
---
 Documentation/bpf/index.rst                   |  1 +
 .../bpf/verifier-overview-1-abstr-interp.rst  | 74 +++++++++++++++
 .../bpf/verifier-overview-2-domain.rst        | 91 +++++++++++++++++++
 .../bpf/verifier-overview-3-dataflow.rst      | 83 +++++++++++++++++
 .../bpf/verifier-overview-4-pruning.rst       | 59 ++++++++++++
 .../bpf/verifier-overview-5-advanced.rst      | 70 ++++++++++++++
 Documentation/bpf/verifier-overview-index.rst | 17 ++++
 7 files changed, 395 insertions(+)
 create mode 100644 Documentation/bpf/verifier-overview-1-abstr-interp.rst
 create mode 100644 Documentation/bpf/verifier-overview-2-domain.rst
 create mode 100644 Documentation/bpf/verifier-overview-3-dataflow.rst
 create mode 100644 Documentation/bpf/verifier-overview-4-pruning.rst
 create mode 100644 Documentation/bpf/verifier-overview-5-advanced.rst
 create mode 100644 Documentation/bpf/verifier-overview-index.rst

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 0d5c6f659266..3b34549f60ad 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -13,6 +13,7 @@ that goes into great technical depth about the BPF Archit=
ecture.
    :maxdepth: 1
=20
    verifier
+   verifier-overview-index
    libbpf/index
    standardization/index
    btf
diff --git a/Documentation/bpf/verifier-overview-1-abstr-interp.rst b/Docum=
entation/bpf/verifier-overview-1-abstr-interp.rst
new file mode 100644
index 000000000000..d6ca0ecdfeca
--- /dev/null
+++ b/Documentation/bpf/verifier-overview-1-abstr-interp.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+Abstract Interpretation in BPF
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+The BPF verifier is a security boundary of the Linux kernel's BPF subsyste=
m. Its goal is to ensure that user-provided bytecode is safe to execute in =
kernel space. To achieve this, it must guarantee two properties:
+
+1. **Termination:** The program must halt in a bounded amount of time (no =
infinite loops).
+2. **Safety:** The program must not perform illegal operations, such as ou=
t-of-bounds memory accesses, leaking uninitialized kernel memory, or derefe=
rencing invalid pointers.
+
+BPF relies on **Static Analysis** to enforce these properties before the p=
rogram is ever executed. Specifically, it uses an approach grounded in **Ab=
stract Interpretation**.
+
+1. What is Abstract Interpretation?
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Abstract interpretation is a theory of sound approximation of the semantic=
s of computer programs. Instead of executing the program with concrete valu=
es (e.g., executing `r1 =3D 5`), the verifier "executes" the program using =
*abstract values* that represent sets of possible concrete values (e.g., ex=
ecuting `r1 =3D [1, 10]`, meaning `r1` holds some value between 1 and 10).
+
+This allows the verifier to reason about all possible execution paths simu=
ltaneously. If an operation is proven safe for the entire abstract domain (=
all possible values the abstract state represents), it is guaranteed to be =
safe for any specific concrete execution at runtime.
+
+2. The Abstract State (``struct bpf_verifier_state``)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+In PL theory, a program state at any given instruction is a mapping of mem=
ory locations to their current values. In the BPF verifier, the abstract st=
ate is represented by ``struct bpf_verifier_state`` (defined in ``include/l=
inux/bpf_verifier.h``).
+
+The abstract state consists of:
+
+* **Registers:** The 11 BPF registers (``r0`` - ``r10``), modeled by ``str=
uct bpf_reg_state``.
+* **Stack:** The program's stack memory, modeled as an array of ``struct b=
pf_stack_state``.
+* **Call Frames:** For inter-procedural analysis, the state tracks the cur=
rent function call depth and the state of the caller.
+* **Reference State:** A list of acquired resources (e.g., socket referenc=
es, spinlocks) that must be released before the program terminates.
+
+Whenever the verifier steps through an instruction (executed primarily wit=
hin the main verification loop of ``do_check()`` and the instruction-level =
evaluator ``do_check_insn()`` in ``kernel/bpf/verifier.c``), it takes the c=
urrent ``struct bpf_verifier_state`` and applies a **Transfer Function** (w=
hich we will cover in Part 3) to produce a new abstract state.
+
+3. Control Flow Graph (CFG) Construction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Before analyzing data flow, the verifier must understand the control flow =
of the program. This is handled by ``check_cfg()`` in ``kernel/bpf/verifier=
.c``.
+
+It is important to note that the verifier does not construct an explicit `=
`Graph`` data structure. Instead, the CFG is **implicit** in the instructio=
n set, and the verifier computes metadata over this implicit graph. The res=
ults are maintained within the ``cfg`` member of ``struct bpf_verifier_env`=
`:
+
+* **``insn_stack``**: The stack used for the non-recursive Depth-First Sea=
rch (DFS) traversal.
+* **``insn_state``**: An array tracking the DFS state of each instruction =
(e.g., ``DISCOVERED``, ``EXPLORED``).
+* **``insn_postorder``**: A vector of instruction indexes sorted in post-o=
rder. This is used in the **Liveness Analysis** phase (a backward data-flow=
 analysis) performed later, for iterating through instructions efficiently.
+
+During this traversal, the verifier checks for:
+
+* **Unreachable Instructions:** Code that can never be executed.
+* **Out-of-Bounds Jumps:** Jumps that land outside the program boundaries.
+* **Back-edges (Loops):** A back-edge is a jump to an instruction that is =
currently on the DFS path.
+
+**Termination and Safety:**
+
+The verifier's approach to termination depends on the user's privilege lev=
el:
+
+* **Unprivileged Users**: The verifier still strictly rejects all back-edg=
es during ``check_cfg()``. This ensures that the program is a Directed Acyc=
lic Graph (DAG), trivially guaranteeing termination.
+* **Privileged Users (BPF_CAPABLE)**: Back-edges are permitted during the =
CFG phase. Termination is instead guaranteed during the **Path Exploration*=
* phase (discussed below) by a global **Complexity Limit** (currently 1 mil=
lion instructions processed). If the verifier exceeds this limit without co=
nverging, the program is rejected.
+
+If any fundamental structural error is found during this phase (e.g., an u=
nprivileged back-edge or an out-of-bounds jump), ``check_cfg()`` returns an=
 error, and the verifier **immediately halts analysis and rejects the progr=
am**, skipping the much more expensive data-flow analysis.
+
+4. Path Exploration vs. Data Flow Joins
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+When a program branches (e.g., ``if (r1 > 10) goto A; else goto B;``), the=
 execution path splits.
+
+In classical Abstract Interpretation, the analysis often follows both path=
s and then *joins* the abstract states together where the control flow merg=
es (e.g., taking the union of the abstract values). This is fast but loses =
precision.
+
+The BPF verifier, prioritizing precision over analysis speed, primarily us=
es **Path Exploration**. When it encounters a branch, it pushes one path on=
to a stack and continues executing the other. It analyzes the ``true`` bran=
ch with the abstract knowledge that ``r1 > 10``, and it analyzes the ``fals=
e`` branch with the knowledge that ``r1 <=3D 10``.
+
+This path-sensitive approach ensures that the verifier does not falsely re=
ject safe programs due to loss of precision, though it risks path explosion=
. State Pruning (Part 4) is the mechanism the verifier uses to mitigate thi=
s explosion.
+
+----
+
+Next: In **Part 2: The Abstract Domain - Values and Bounds**, we will expl=
ore how the verifier represents partial knowledge, detailing the ``tnum`` s=
tructure and numeric bounds tracking.
diff --git a/Documentation/bpf/verifier-overview-2-domain.rst b/Documentati=
on/bpf/verifier-overview-2-domain.rst
new file mode 100644
index 000000000000..8a9d36818f24
--- /dev/null
+++ b/Documentation/bpf/verifier-overview-2-domain.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Part 2: The Abstract Domain - Values and Bounds
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+In Abstract Interpretation, the **Abstract Domain** defines the mathematic=
al representation of the values a variable can hold. It determines the leve=
l of precision of the static analysis.
+
+The BPF verifier tracks several dimensions of abstract information for eac=
h register (and stack slot), encapsulated within ``struct bpf_reg_state`` (=
defined in ``include/linux/bpf_verifier.h``).
+
+1. The Value Lattice
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A lattice is a partially ordered set that models the flow of information. =
The lattice for the verifier represents knowledge, ranging from:
+
+* **Top ($\top$)**: The most general state. It represents *any* possible v=
alue. The verifier has zero knowledge. In the code, this is represented by =
the ``tnum_unknown`` bitmask and the widest possible numeric bounds (``umin=
_value =3D 0``, ``umax_value =3D U64_MAX``, ``smin_value =3D S64_MIN``, ``s=
max_value =3D S64_MAX``), applied via functions like ``__mark_reg_unknown()=
`` and ``__mark_reg_unbounded()``.
+* **Intermediate Values**: Partial knowledge (e.g., "the value is between =
5 and 10," or "the lower 3 bits are 0").
+* **Bottom ($\bot$)**: The most specific state. It represents an impossibl=
e or contradictory state (e.g., a value that must be simultaneously > 10 an=
d < 5). The verifier does not have an explicit ``struct`` for Bottom; inste=
ad, it manifests as contradictory bounds (e.g., ``umin_value > umax_value``=
). When the verifier encounters this, it identifies the execution path as d=
ead code and stops exploring it.
+
+The goal of the verifier is to start with maximal assumptions ($\top$ for =
inputs) and use instructions to narrow down the possible values, moving dow=
n the lattice without ever falsely restricting the set of possible concrete=
 executions.
+
+2. Tristate Numbers (``tnum``)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+One of the most powerful abstract domains in the BPF verifier is the **Tri=
state Number**, implemented in ``kernel/bpf/tnum.c``.
+
+Instead of tracking precise bitwise values, a ``tnum`` tracks the state of=
 each bit independently. Each bit can be in one of three states:
+
+1. **0**: Known to be zero.
+2. **1**: Known to be one.
+3. **u**: Unknown.
+
+A ``tnum`` is represented by two 64-bit masks: ``value`` and ``mask``.
+
+* ``value``: The bits that are known to be 1.
+* ``mask``: The bits that are unknown.
+* (Bits that are 0 in both ``value`` and ``mask`` are known to be 0).
+
+**Example:**
+
+* ``tnum_const(5)`` (Binary ``0101``): ``value =3D 0101``, ``mask =3D 0000=
``. All bits are known.
+* ``tnum_unknown()``: ``value =3D 0000``, ``mask =3D 1111...1111``. No bit=
s are known ($\top$).
+* If we know a value is a multiple of 4, the lowest two bits must be zero:=
 ``value =3D 0000``, ``mask =3D 1111...1100``.
+
+The ``tnum`` domain is exceptional for analyzing bitwise operations like A=
ND (``&``), OR (``|``), and shifts. By tracking individual bits, the verifi=
er can calculate the exact state of the resulting bits wherever possible, p=
reserving a high degree of precision across bitwise operations.
+
+3. Numeric Bounds Tracking
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+While ``tnum`` is excellent for bitwise logic, it is imprecise for arithme=
tic bounds. For example, knowing a value is "less than 10" is difficult to =
express cleanly with a bitmask.
+
+To solve this, ``struct bpf_reg_state`` also tracks numeric bounds:
+
+* **Unsigned Bounds**: ``umin_value`` and ``umax_value``.
+* **Signed Bounds**: ``smin_value`` and ``smax_value``.
+* **32-bit Subregister Bounds**: ``u32_min_value``, ``u32_max_value``, ``s=
32_min_value``, ``s32_max_value``.
+
+When the verifier analyzes an instruction, it updates *both* the ``tnum`` =
and the numeric bounds. Furthermore, it synchronizes them. If the ``tnum`` =
dictates the sign bit must be 0, the verifier can update the signed bounds =
to be positive. If the numeric bounds dictate the maximum value is 7, the v=
erifier can update the ``tnum`` mask to clear bits higher than 2.
+
+4. Pointer Types and Provenance
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+Scalars (integers) are only one part of the abstract domain. A critical se=
curity function of the verifier is distinguishing raw scalars from **Pointe=
rs**.
+
+In ``enum bpf_reg_type``, the verifier tracks the *provenance* (the origin=
) of pointers. This defines what the pointer fundamentally points to:
+
+* **``SCALAR_VALUE``**: A raw integer. Safe for math, unsafe for memory ac=
cess.
+* **``PTR_TO_CTX``**: A pointer to the BPF context (e.g., ``struct __sk_bu=
ff``).
+* **``PTR_TO_MAP_VALUE``**: A pointer to an element within a BPF map.
+* **``PTR_TO_STACK``**: A pointer to the program's local stack.
+* **``PTR_TO_PACKET``**: A pointer to the raw network packet data.
+
+**Type Modifiers (Permissions and Safety):**
+
+Beyond the base type, the verifier enriches pointer states using bitwise m=
odifiers defined in ``enum bpf_type_flag``. These flags act as a strict typ=
e system enforcing access permissions and safe usage contexts. Important mo=
difiers include:
+
+* **``PTR_MAYBE_NULL``**: Indicates the pointer might be null. The verifie=
r will aggressively reject any attempt to dereference this pointer until th=
e program explicitly checks it against 0 (which triggers a state split, con=
verting it to a valid pointer on the non-null path).
+* **``MEM_RDONLY``**: Denotes that the memory region the pointer reference=
s is strictly read-only.
+* **``PTR_TRUSTED``**: A vital security flag indicating the pointer was pa=
ssed directly from the kernel in a safe context and is guaranteed to be val=
id. It is safe to pass to BPF helpers. Conversely, **``PTR_UNTRUSTED``** me=
ans the pointer was obtained by walking a chain of structs and might be inv=
alid, restricting its use to direct, fault-handled dereferencing.
+* **``MEM_RCU``**: Indicates the memory access requires an active RCU read=
 lock.
+
+When a register holds a pointer, the verifier conceptually separates its s=
tate into:
+
+1. **The Base Pointer**: The origin (e.g., the start of the map value) com=
bined with its type and modifier flags.
+2. **The Offset**: The distance from the base. This offset is tracked usin=
g the scalar abstract domain (``tnum`` + bounds) described above.
+
+By separating the base and the offset, the verifier can formally prove mem=
ory safety: it ensures that for all possible values of the offset (evaluate=
d against the scalar bounds), the resulting memory address never falls outs=
ide the allocated boundaries of the Base Pointer.
+
+----
+
+Next: In **Part 3: Data Flow and Transfer Functions**, we will explore how=
 instructions mutate this abstract state, detailing ALU operations and cond=
itional jumps.
diff --git a/Documentation/bpf/verifier-overview-3-dataflow.rst b/Documenta=
tion/bpf/verifier-overview-3-dataflow.rst
new file mode 100644
index 000000000000..1c7a05b46693
--- /dev/null
+++ b/Documentation/bpf/verifier-overview-3-dataflow.rst
@@ -0,0 +1,83 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Part 3: Data Flow and Transfer Functions
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+In Programming Language (PL) theory, a **Transfer Function** describes how=
 an abstract state transitions from one state to another when an instructio=
n is processed by the verifier.
+
+For the BPF verifier, the transfer functions map an input ``struct bpf_ver=
ifier_state`` to a new output state. This step-by-step symbolic evaluation =
of bytecode over the abstract domain (Part 2) is the core of the BPF verifi=
er's safety proof.
+
+**Code Organization:**
+In the verifier's implementation, a "transfer function" is rarely a single=
 monolithic C function. Because the abstract state consists of multiple dom=
ains (numeric bounds, bitwise ``tnum``, pointer provenance), the transfer f=
unction for a single instruction is carried out by invoking a specific oper=
ation for *each* domain. For example, when processing an addition instructi=
on, the verifier will call ``scalar_min_max_add()`` to transform the bounds=
 domain, and separately call ``tnum_add()`` to transform the bitwise domain=
, before finally synchronizing them.
+
+1. Transfer Functions for ALU Operations
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Arithmetic and Logic Unit (ALU) operations (e.g., addition, subtraction, b=
itwise shifts) are analyzed using transfer functions that independently upd=
ate the ``tnum`` state and the numeric bounds state for the destination reg=
ister.
+
+The kernel implements these transfer functions in ``adjust_scalar_min_max_=
vals()`` (within ``kernel/bpf/verifier.c``).
+
+* **Bitwise Operations (AND, OR, XOR)**: These are highly precise in the `=
`tnum`` domain. For example, in an AND operation, if a bit is known to be 0=
 in *either* operand, the verifier can conclude the resulting bit is 0. If =
bits are unknown, the resulting bit is unknown.
+* **Arithmetic Operations (ADD, SUB)**: These operations naturally update =
the minimum and maximum boundaries (e.g., if ``r1`` is ``[2, 5]`` and ``r2`=
` is ``[10, 20]``, the transfer function for ``r1 +=3D r2`` evaluates to ``=
[12, 25]``). Crucially, they **also update the ``tnum`` state**. The verifi=
er uses sophisticated bitwise arithmetic in ``tnum_add()`` and ``tnum_sub()=
`` to track potential carry propagation, ensuring that knowledge about spec=
ific bits (like whether a value is even or a multiple of 4) is preserved ev=
en through addition and subtraction.
+
+**Handling Overflow (Loss of Precision):**
+The verifier explicitly checks for potential integer overflow or underflow=
 during arithmetic (using functions like ``check_add_overflow()``). If an o=
peration could result in an overflow, the verifier handles it by **widening=
** the abstract bounds to their maximum range (e.g., resetting ``umin`` to =
0 and ``umax`` to ``U64_MAX``). This represents a "loss of precision" in th=
e abstract domain: the verifier no longer knows the exact range of the resu=
lt and must assume the most conservative state ($\top$) to remain sound. If=
 such an unbounded value is later used as a memory offset, the verifier wil=
l reject the program.
+
+**Synchronizing Domains:**
+Because the verifier uses two parallel abstract domains (``tnum`` for bits=
, min/max for bounds), the ALU transfer function must synthesize them. Afte=
r an ADD operation, the verifier calls ``__update_reg_bounds()``, which for=
ces consistency:
+
+* If the numeric bounds determine a value is exactly `7`, the `tnum` is se=
t to `value=3D7, mask=3D0`.
+* If the `tnum` shows the sign bit is 0, the signed min bound is bumped up=
 to 0 (if it was previously negative).
+
+2. Transfer Functions for Pointers
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+When an ALU operation involves a pointer (e.g., ``r1 +=3D r2``, where ``r1=
`` is a ``PTR_TO_MAP_VALUE`` and ``r2`` is a ``SCALAR_VALUE``), the verifie=
r must handle it differently.
+
+This is processed in ``adjust_ptr_min_max_vals()``. The transfer function =
calculates how the addition of the scalar affects the allowed bounds of the=
 pointer.
+
+* The verifier checks if the resulting abstract offset exceeds the allocat=
ed size of the memory region (e.g., the map value size).
+* To prevent speculative execution attacks (Spectre v1), the verifier may =
also inject runtime mitigations (masking operations) into the bytecode, dep=
ending on the abstract bounds it calculated.
+
+3. Branching and Path Exploration
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The most complex transfer functions occur during control flow operations (=
jumps). Conditional jumps (e.g., ``if (r1 < 10) goto X``) are where the BPF=
 verifier refines its knowledge.
+
+When the verifier evaluates a conditional branch, the abstract state split=
s. It creates two separate execution paths:
+
+1. **The Fall-Through Path (False Branch)**: The instruction following the=
 jump.
+2. **The Target Path (True Branch)**: The destination instruction of the j=
ump.
+
+The transfer function for the jump instruction refines the abstract state =
on *both* paths independently. This logic lives in ``check_cond_jmp_op()`` =
and ``reg_set_min_max()``.
+
+**Example:**
+Assume ``r1`` is an unknown scalar (``[0, U64_MAX]``). The instruction is =
``if (r1 < 10) goto A; else goto B;``.
+
+* **Path A (True Branch)**: The verifier updates the abstract state for ``=
r1``. Since the condition was true, the new upper bound of ``r1`` is 9. The=
 new state for ``r1`` is ``[0, 9]``.
+* **Path B (False Branch)**: The verifier updates the abstract state for `=
`r1``. Since the condition was false, the new lower bound of ``r1`` is 10. =
The new state for ``r1`` is ``[10, U64_MAX]``.
+
+By splitting the state, the verifier gains precision. It "learns" from con=
ditionals, ensuring that subsequent memory accesses bounded by ``r1`` are p=
roven safe on Path A, even if they would be out-of-bounds on Path B.
+
+4. Memory Access Verification
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+Memory access instructions (loads and stores) are validated to ensure they=
 only read or write within permitted boundaries. The transfer function for =
these instructions not only updates the abstract state but also determines =
whether the memory access is safe, rejecting the program if bounds cannot b=
e proven.
+
+When executing ``r2 =3D *(u32 *)(r1 + 0)`` (in ``check_mem_access()``), th=
e verifier performs the following checks:
+
+1. **Provenance Check**: Is ``r1`` a valid pointer type (e.g., ``PTR_TO_MA=
P_VALUE``)? If it's a scalar, the verifier rejects the program.
+2. **Bounds Check**: Does the abstract offset of ``r1`` (which is a range =
of possible values, ``[umin, umax]``) plus the access size (4 bytes for ``u=
32``) fall completely within the boundaries of the memory region?
+
+   * The verifier checks the maximum possible offset. If it exceeds the bo=
undary, the program is rejected.
+   * The verifier checks the minimum possible offset. If it is negative, t=
he program is rejected.
+
+3. **Type Update**: After verifying the access, the transfer function upda=
tes the destination register (``r2``). The new type is determined by the me=
tadata of the memory being accessed:
+    * **Map Values**: Typically results in a ``SCALAR_VALUE`` (unless load=
ing a special kernel pointer/kptr).
+    * **Context (``PTR_TO_CTX``)**: The resulting type (e.g., a scalar or =
a ``PTR_TO_PACKET``) is determined by the specific field being read, as def=
ined in the program type's context definition (e.g., ``struct __sk_buff``).
+    * **BTF-backed memory**: If the memory is described by BTF (see Part 5=
), the load results in the exact type defined in the kernel's C code (e.g.,=
 another ``PTR_TO_BTF_ID`` if reading a struct pointer).
+
+----
+
+Next: In **Part 4: State Pruning and Loop Analysis**, we will see how the =
verifier prevents the explosion of execution paths using state equivalence =
and bounded loops.
diff --git a/Documentation/bpf/verifier-overview-4-pruning.rst b/Documentat=
ion/bpf/verifier-overview-4-pruning.rst
new file mode 100644
index 000000000000..f1515011d721
--- /dev/null
+++ b/Documentation/bpf/verifier-overview-4-pruning.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Part 4: State Pruning and Loop Analysis
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Because the BPF verifier relies on path exploration (splitting states at e=
very branch), a naive implementation would suffer from exponential path exp=
losion. To keep verification times reasonable=E2=80=94and to allow loops=E2=
=80=94the verifier employs **State Pruning**.
+
+In the context of Abstract Interpretation, pruning is conceptually related=
 to identifying fixed points and utilizing partial ordering between abstrac=
t states.
+
+1. State Equivalence (``states_equal``)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Before the verifier evaluates an instruction, it checks if it has been her=
e before. It maintains a history of previously verified states at various j=
ump targets.
+
+When the verifier reaches an instruction with a *current state*, it compar=
es it against a *previously verified state* (an *existing state*) at the sa=
me instruction.
+
+This comparison is performed by ``states_equal()`` (in ``kernel/bpf/verifi=
er.c``). Crucially, ``states_equal`` is *not* a strict equality check. It i=
s a **subsumption** (or partial order) check.
+
+It asks: *Is the current state "more specific" than (or equal to) the exis=
ting state?*
+
+If the *current state* is subsumed by the *existing state*, it means every=
 possible concrete execution represented by the current state is a subset o=
f the executions already proven safe by the existing state. Therefore, the =
verifier can safely **prune** the current path. It stops evaluating the *cu=
rrent state* and marks the branch as safe.
+
+**Examples of Subsumption:**
+
+* If the *existing state* had a register as $\top$ (completely unknown sca=
lar) and the *current state* has that same register bounded between 5 and 1=
0, then the current state is subsumed. The existing state proved safety for=
 *any* value, so a restricted value is naturally safe.
+* If both the *existing state* and the *current state* have a register as =
a ``PTR_TO_MAP_VALUE`` with the same offset, they are equal, so it's safe t=
o prune.
+* If the *existing state* had a register bounded between 5 and 10, but the=
 *current state* has it bounded between 0 and 15, the *current state* is *w=
ider*. It is not subsumed. The verifier must continue evaluating the *curre=
nt state*.
+
+2. Liveness Tracking (Dead State Elimination)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To maximize pruning, the verifier uses **Liveness Analysis** (a classic da=
ta-flow analysis technique). If a register's value is never read before bei=
ng overwritten on a path, it is "dead."
+
+The verifier performs this liveness analysis in a separate pass (``compute=
_live_registers()``) before the main path exploration (``do_check()``) begi=
ns. By analyzing the program's control flow in advance, the verifier pre-de=
termines which registers are dead at any given instruction.
+
+The verifier tracks this using ``REG_LIVE_READ`` and ``REG_LIVE_WRITTEN`` =
flags. During the ``states_equal()`` check, if a register is marked as dead=
 in the *existing state*, the verifier knows that this register will remain=
 dead regardless of how the current path is explored. As a result, it compl=
etely ignores the value of that register in the *current state*.
+
+By ignoring dead registers, the verifier increases the probability that a =
*current state* is subsumed by an *existing state*, leading to higher pruni=
ng rates and faster verification.
+
+3. Loop Verification (Bounded Loops)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Historically, BPF programs had to be Directed Acyclic Graphs (DAGs). Any b=
ack-edge (a jump to an ancestor in the Control Flow Graph) was instantly re=
jected to guarantee termination.
+
+Modern BPF supports **Bounded Loops** (``bpf_loop`` helper or direct `goto=
` back-edges under specific conditions).
+
+To verify a loop without infinite analysis, the verifier relies on a form =
of **Bounded Abstract Interpretation** and **Widening**.
+
+1. **Loop State Generation**: When a back-edge is taken, the verifier eval=
uates the loop body multiple times.
+2. **State Convergence**: On each iteration, the abstract state at the loo=
p header is updated. Variables modified in the loop (e.g., induction variab=
les like ``i =3D i + 1``) will have their bounds grow.
+3. **Termination Proof**: The verifier must prove that the loop induction =
variable eventually reaches the loop exit condition. If ``i`` is bounded by=
 a constant, and the loop exits when ``i >=3D MAX``, the verifier can track=
 the maximum bound of ``i``.
+4. **State Equivalence in Loops**: If the abstract state at the loop heade=
r converges (i.e., iterating the loop no longer widens the abstract bounds,=
 or the new state is subsumed by a previous iteration's state), the verifie=
r has found a safe fixed-point and can prune the loop exploration.
+
+If the verifier cannot prove that a loop terminates (e.g., the upper bound=
 of the induction variable relies on data read from memory rather than a kn=
own scalar), or if it hits the maximum instruction complexity limit (histor=
ically 1 million simulated instructions), it rejects the program.
+
+----
+
+Next: In **Part 5: Advanced Contexts - Concurrency and BTF**, we will expl=
ore how the verifier handles modern extensions like the BPF Type Format, sp=
inlocks, and subprogram analysis.
diff --git a/Documentation/bpf/verifier-overview-5-advanced.rst b/Documenta=
tion/bpf/verifier-overview-5-advanced.rst
new file mode 100644
index 000000000000..f18d13dd8cab
--- /dev/null
+++ b/Documentation/bpf/verifier-overview-5-advanced.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Part 5: Advanced Contexts - Concurrency and BTF
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+As BPF evolved from simple packet filtering into a complex subsystem capab=
le of replacing kernel modules (e.g., tracing, LSMs, XDP), the verifier's a=
bstract interpretation framework had to expand.
+
+1. BPF Type Format (BTF) and Introspection
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The :doc:`btf` is a metadata format that provides full C-language type inf=
ormation for kernel structures. Within the verifier's abstract interpretati=
on framework, BTF acts as a static type system.
+
+**BTF Availability:**
+
+BTF type information is not always available. Its presence depends on:
+
+* **Kernel Configuration**: The kernel must be compiled with ``CONFIG_DEBU=
G_INFO_BTF=3Dy`` to provide introspection for its own internal types.
+* **Program Metadata**: BPF programs themselves can optionally include BTF=
 data to describe their own structures (e.g., map values).
+* **Verifier Context**: When BTF is unavailable, the verifier falls back t=
o more coarse-grained checks based purely on memory region boundaries (as d=
escribed in Part 2).
+
+**Type-Aware Abstract Domains:**
+
+When BTF is enabled and the program traces a kernel function to receive a =
pointer (e.g., ``struct task_struct *task``), the verifier marks the regist=
er with the type ``PTR_TO_BTF_ID``.
+
+* The ``btf_id`` points to the formal type definition in the kernel's BTF =
metadata.
+* When the program executes ``r2 =3D *(u64 *)(r1 + offsetof(task, pid))``,=
 the verifier doesn't just do numeric bounds checking. It performs **Type C=
hecking**.
+* The transfer function looks up the ``btf_id`` for ``struct task_struct``=
, finds the field at the requested offset, checks its size (e.g., a 4-byte =
integer), and checks its type.
+* The destination register (``r2``) is then updated. If the field was an i=
nteger, ``r2`` becomes a ``SCALAR_VALUE``. If the field was a pointer to an=
other struct (e.g., ``task->real_parent``), ``r2`` becomes a new ``PTR_TO_B=
TF_ID`` representing that parent struct.
+
+This allows BPF programs to traverse arbitrary kernel data structures with=
 compile-time safety guarantees, directly mirroring the type checking perfo=
rmed by the C compiler.
+
+2. Concurrency Analysis (Spinlocks and RCU)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+BPF programs can run concurrently on multiple CPUs. The verifier must anal=
yze code for data races and illegal lock usage, effectively enforcing **Loc=
k State Tracking**.
+
+**The Abstract Lock State:**
+
+The ``struct bpf_verifier_state`` includes fields like ``active_spin_lock`=
` and ``active_rcu_lock``.
+
+* **Spinlocks**: When a program calls the helper ``bpf_spin_lock(map_value=
)``, the verifier's transfer function asserts that no lock is currently hel=
d. It then updates ``active_spin_lock`` with the identity of the map value.
+* The verifier ensures that while a spinlock is held, the program cannot s=
leep (e.g., calling certain blocking helpers) and cannot return without rel=
easing it (``bpf_spin_unlock``).
+* **RCU Sections**: For tracing and memory traversal, BPF uses RCU. The ``=
active_rcu_lock`` counter tracks the nesting depth of ``bpf_rcu_read_lock()=
`` calls. The verifier ensures that RCU pointers (tagged with ``MEM_RCU``) =
are only dereferenced when the RCU read lock is actively held.
+
+By making lock status an explicit part of the abstract state, the verifier=
 statically proves the absence of deadlocks and use-after-free bugs related=
 to concurrency.
+
+3. Resource Lifecycle and Reference Tracking
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+For complex programs that allocate kernel resources (e.g., performing a so=
cket lookup via ``bpf_sk_lookup_tcp``), the verifier enforces a strict **Ac=
quire-Release** lifecycle. This ensures that every allocated resource is ei=
ther released or appropriately handled before the program terminates.
+
+In the language of Abstract Interpretation, this is implemented by extendi=
ng the abstract state with a **Reference Tracking** domain.
+
+* **Acquisition (KF_ACQUIRE)**: When the verifier executes a transfer func=
tion for an "acquire" helper or kfunc, it generates a unique ``ref_obj_id``=
. A new entry is added to the ``refs`` array within ``struct bpf_verifier_s=
tate``, and the return register (``r0``) is tagged with this ID.
+* **Reference Propagation**: The ``ref_obj_id`` is part of the register's =
abstract state. If the program copies the pointer to another register or sp=
ills it to the stack, the ID follows it.
+* **Release (KF_RELEASE)**: When a "release" function (e.g., ``bpf_sk_rele=
ase``) is called, the verifier matches the ``ref_obj_id`` of the argument. =
It then removes the reference from the abstract state's ``refs`` array and =
**invalidates** all other registers or stack slots sharing that same ID, pr=
eventing use-after-free errors.
+* **Termination Proof**: At the ``BPF_EXIT`` instruction, the verifier ass=
erts that the ``refs`` array is empty. If any reference remains, the progra=
m is rejected as it has "leaked" a kernel resource.
+
+4. Inter-Procedural Analysis (Subprograms)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+BPF supports subprograms (calling local BPF functions using ``bpf_call``).=
 Unlike simple inlining, the verifier performs true **Inter-Procedural Anal=
ysis (IPA)**.
+
+1. **Call Frame Management**: When a ``bpf_call`` occurs, the verifier pus=
hes a new call frame onto its abstract state. The caller's registers (``r6`=
`-``r9``, which are callee-saved) are preserved in the caller's frame.
+2. **Argument Passing**: The arguments (``r1``-``r5``) are passed from the=
 caller to the callee. The verifier enforces that these arguments match the=
 expected types (which it deduces during an initial pass).
+3. **Stack Depth Validation**: The verifier computes the total stack size =
used by a function and its callees to ensure it never exceeds the strict 51=
2-byte limit.
+4. **Return Value Tracking**: When the callee hits the ``BPF_EXIT`` instru=
ction, the verifier updates the caller's ``r0`` with the abstract state of =
the return value, pops the call frame, and resumes exploration in the calle=
r.
+
+By modeling the full call stack in the abstract state, the verifier ensure=
s that function boundaries do not compromise safety.
diff --git a/Documentation/bpf/verifier-overview-index.rst b/Documentation/=
bpf/verifier-overview-index.rst
new file mode 100644
index 000000000000..3d5bffd98767
--- /dev/null
+++ b/Documentation/bpf/verifier-overview-index.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+Overview of the BPF Verifier
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+This is an index to multi-part documentation that gives an overview of the
+eBPF verifier.
+
+.. toctree::
+   :maxdepth: 2
+
+   verifier-overview-1-abstr-interp
+   verifier-overview-2-domain
+   verifier-overview-3-dataflow
+   verifier-overview-4-pruning
+   verifier-overview-5-advanced
--=20
2.53.0.473.g4a7958ca14-goog

