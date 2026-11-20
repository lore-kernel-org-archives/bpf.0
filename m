Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207807;
	b=5TlFX2isyuch9V4FGIjsJMrt0mNIMARqPbFD147MOVBIGKIzB2or28mF2K4/nquSJx3P
	 Zkr/hv45vjLpD0ocGKxraVKfsZOmAEp5o9I438uNekSwVB4exWprgujIMEoXP+3wW1RKF
	 dEc9IhJ7b2u+wO5GuYlvbPLGCkgQoRYm+vPg9lBjw6QpG8QZcgTEtOvTEcqfummrGDwaf
	 MsMkqWpSswXtqURzF6+ZPk2zQ4+NmmopCo3QoBIRExRuau1mTpVzHoJ2W7Tsbj83ZwcM/
	 0EtQsaCjR1ZhB1YN8odZQ2STn+jV4cOUkfhx2kjd6U2LTbuTrm7Pdi/9/lmPQiTuiAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hBMuM6m/L7cOyW7+g9skdS5x4XoSQ3HZN1KyXylLJog=;
	b=DpblE/gB6AoR5W+EPXPX6KXfNPfomB0xfklAirGF4wgOuwkQSzueZWFGfHzpusPpnF2E
	 k4T8XSoK6j3zZAB+FixQvekd1oZDBxO0BSceggr3GBq2zznVLyHoX+xJx9mhqKIJKafMO
	 cDoXiS8BT+zIVPipBH03Zb0wMWyXNeM6sEO+Zsmcp3zmWpM1n7/6qYR3U/spBFgfoFOhY
	 w0IyarrBrPGEw6DK8eUdnQ8yqmMn9nvZm1px0e+xQGfYhsj17xq9yYj5RuTHFXr5vAVfn
	 onGq5z4dsVylS+c34yZ+SoDV4p1Hbh6Rw0QSCltL9/L+1VeghZPuBces+dDnaMsRqkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lagsMC69;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B1606A691
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 881B1606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lagsMC69
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso872317a91.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207804; x=1795812604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hBMuM6m/L7cOyW7+g9skdS5x4XoSQ3HZN1KyXylLJog=;
        b=lagsMC69r6+4pU3vCtyqZr3/VrXWTqG7cjgLtBvNvB8cpLuTPmRY8o5vqWvY6sJCxc
         Qm22r3gjTM0M64IuuY88c2+xA7VBivvt35LUiXkEH25eKtNemIDTrkSdU0JBwFEd8jMv
         3opGwltH1C2CsXWGlUO7DHwo7xhxLfvpmBTIgGkvjyX5iSB5bq0JM8kb9qjJ2AsSZRDo
         sYc6nAzyb+h6ue2rfZ1XQxwxVDNx0mLoN+anFRCZDcuzLTLmK+M3e1oMIQFS+v3ODEXH
         SS9M4DXse8O+MrRR7TWhoat7SRO4F1swDJYJzeObEBlPQTZ51k09+wdMJdmyjf/P8YQN
         d8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207804; x=1795812604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBMuM6m/L7cOyW7+g9skdS5x4XoSQ3HZN1KyXylLJog=;
        b=Mbm42Sebk5DnpPoKrjz/SkVUTfadcYFhZM2OCG65yexq5+tiqv+FRUSXsQRqrvjHWs
         a58C1Cth0WRvPSgFOF4YVjUkcFFrjwBF+7qUE1QNgrTAiRHsv1fbTE7HtFX26Bnl557w
         AJA8rP9IELJq9GN7ebhEBuxreVyRvEBKLWhUozmLIU5bGFGyitjPx34PnGIZaAmJcqRM
         5f+VppY+3kF/yufIw3vp38ImnBk3zhUDk5zyPDUVAQn35nB7hnKmz9z0S/iSmvElAapU
         7fpPUOwhatX8bPZVX90RaFXJuyC4BaUyR7DIYJnAR4fAmeN6yWhmZ+9M+ZHvWgLhrdwy
         ONfA==
X-Gm-Message-State: APuU4Z+8EjohBCSNib4lldHxymwKxloMEBIHJA9lPXIPU68aklgWVGur
	cqCstdTzNsWU+8GvtI5BuORpPE0Cv8PQ86eHWGrTWYzgBhP6IL+SlFHfikDbFg==
X-Gm-Gg: AZFdTZf6APd7S+Qw/rMFcmJQEYbnhRk4fbZRBLRZheKnMBZb0XC/e5tCva6m3qqBbSU
	lAxDJ0TA1CI/+R/13x6FIUJjBuxt+GernMSx2rb2Lq3OvtWpEJZ+IRU+K02aaiV+wHIR/6EMoCR
	AnF+CdcKxn4bqxF7xE0ocEhQlkoKrz6C4T+Wz4jYCwXrxIeScE7U8CKO1bZa4eph11/Epzhb/+A
	FoOUw7ItsstSqIXRH3SeNvdXEbE/3v6f5lcqOEGs+fa6Cdo0EdDwSkc3O1/iHg0qFjrRSzvGrnV
	qONF/lR4htjm913adQ/Zkbmsdw0dBflXDISACLENyT2UQ9TngLIdUnQkT/m9xKJ+XttWqdWQL/e
	Jyru/OwgyNlJPej16z58tRiWOQIpSEkj7VezIOSmElYu1jggoNkx1mtcJuNoRJc6b3K7p9Yn0Cm
	pO+CRmzli9SJJI/wzHXHQxLHVA0xZD6V4DOKnCwgXTVpm/vc/q4XYJUYc87d0HBS9NfU/Dwpmtn
	Ztkn8M+KX3i6P23oTP7YV0NnIvcFWIPZ9oW0h09hAa65VAvrYGZw+O3PGGlVcmC7v8zYeDOXlu0
	mscxyf40PTrkOXzuzrHhy24tIMJ9NZsRwzL8tfx2NF/lzOfSnKn24DhhRv9/ifc+f1mdcdZmnpb
	RyklQL9ub13P+3LrFHtGjOmkVZ2aHRwZmuwy1yz1ycu6rhcKgx8u8h0IOvjbORec7a12lm9sY1G
	FdCrILLQfKTvF9XwbUubA=
X-Received: by 2002:a17:90b:3b49:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3b41c9beaefmr3927260a91.67.1795207802645;
        Fri, 20 Nov 2026 12:50:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b2156c2sm339045a91.0.2026.11.20.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:50:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 00/49] bpf: Verify in passes, with equations in the state
Date: Fri, 20 Nov 2026 20:49:08 +0000
Message-ID: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This series replaces the main analysis of the verifier and scev.c. Against
bpf-next, the base of the series:

  - More valid programs load. The verdict depends less on the code pattern.
  - Numbers keep states apart only if an error, or a bound that the program
    requires, depends on them.
  - The work does not grow with the number of iterations of a loop, unless an
    error needs them one by one.
  - The log shows a path to the bug, if the verifier finds one.
  - The proof is separate from the guesses. There is less code.

This letter compares three verifiers:

  7.4-rc3    follows one path after another. It has scev.c and no flow.c.
  bpf-next   ea80d2afd285, the base of v1. flow.c joins states.
  series     bpf-next with these patches.

A trip is one iteration of a loop. The sections below explain the other words.

                        7.4-rc3               bpf-next              series
  two states meet       prune or keep apart   guess: join or        join; keep apart after
                                              keep apart            an error
  values that matter    backtrack.c, for      8 tables, before      backward slice from
                        each path             the pass              the error
  related numbers       ids of copies         value numbers of      equations in the state
                                              scev.c, rules
  loop, trip count      scev.c, else each     scev.c, else each     trip index, checked
                        trip                  trip up to a limit
  loop, no trip count   each trip; widen at   each trip up to a     join and widen,
                        may_goto, iterator    limit, then widen     may_goto
                                              and may_goto
  static function       at each call          once for the joined   once for each
                                              calls (*)             instance (*)
  limits                1M insns, 8192 jumps  states, trips         cost, memory

  (*) At each call, if the function gets a pointer to the stack.

  331763 builds of 6005 programs of other projects load on all three:
  insns, mean           18110                 2716                  1750
  insns, median         585                   397                   384
  time, mean, ms        23.2                  10.3                  5.2
  time, median, ms      1.8                   2.1                   1.0
  peak states, mean     562                   143                   18
  peak states, median   41                    22                    6

Patches 1 and 2 make the analyses before the main pass faster. They give most of
the gain in time against bpf-next: with them alone the mean is 6.1 ms, and the
median is 1.0 ms.

The problem
===========
Two states meet at a join point of the CFG. The verifier can join them or keep
them apart. An example:

  state A: i = 0..63    err = 0    --+
                                     +--> join, or keep apart ?
  state B: i = 64..max  err = -22  --+

  join         cheap, but it can lose "err == 0 means i < 64"
  keep apart   exact, but n branches can make 2^n states

7.4-rc3 does not join at a branch. It stops ("prunes") a path if an earlier
state has all values of the path in the registers that matter ("precise"). Else
it keeps the states apart. No fact is lost there, but the paths multiply. The
limits are 1M insns and 8192 pending jumps: jumps where one side waits for its
check. In loops it can lose facts. scev.c gives each counter its own range. At
may_goto, an iterator or a callback a number that is not precise becomes
unknown.

bpf-next makes the choice as the states meet. It does not know yet if the join
loses a needed fact. So it guesses: 8 tables that tell which values matter,
one rule for each code pattern, and limits on states. The guess is final, and it
can be wrong in two ways:

  if the states are                   then
  joined, and a needed fact is lost   a valid program is rejected
  kept apart, with no need            the states can grow to the limit

This series decides after the error:

  7.4-rc3:    each path --> error or limit ? --yes--> REJECT

  bpf-next:   guess --> pass --> error ? --yes--> REJECT

  series:     join all --> pass --> error ? --no--> ACCEPT
              numbers       ^          | yes
                            |          v
                            +-yes- partition ? --no--> REJECT

A pass checks all functions. An insn whose check fails in a pass is "unproven".
A partition keeps more states apart in the next pass (trace partitioning). The
first partition makes a backward slice from the unproven insn. It gives two sets
of registers and stack slots, the "deps":

  data_deps      they flow into an operand of the unproven insn
  control_deps   they flow into a jump that can skip that insn

The join rule looks only at the deps that differ between two states. A "gap" is
a value of the join that is in neither state.

  if the deps that differ are      then         example
  not in data_deps                 join         only err differs
  one, in data_deps, no gap        join         i = 0..7 and i = 8..9
  one, in data_deps, with a gap    keep apart   i = 0..1 and i = 100
  two or more, one in data_deps    keep apart   i and err above

If one state has all values of the other in the deps, they are joined. A state
that comes back to a loop header is joined. Later partitions keep more apart.

All other numbers stay joined. Two states with different locks, references, or
types of a live register stay apart from pass 0.

A pass without errors is a "good pass". It is a complete proof. What a pass
keeps apart is its "precision", and it is a guess. A wrong guess costs time,
adds a may_goto or a nospec insn that is not needed, or rejects a valid program.
It cannot accept an unsafe program. A loop "gets may_goto" if the verifier adds
this insn to it. At run time the insn can stop the loop before its end. Then the
function returns 0 or, if that is not possible, the code after the loop runs.

What gets better
================
The examples are C, built with clang 21, -O2, -mcpu=v4. barrier_var() is left
out. The counts are "insns processed". The verdicts are the same for
-mcpu=v2/v3/v4 and -O1/-O2/-O3/-Os, with one exception in example 5. All
examples are valid, except MAX = 64 in example 8. "old" is 7.4-rc3 and bpf-next,
if they give the same verdict. I also tested 16 variants in which the largest
access ends at the last byte. 7.4-rc3 loads 7 of them, bpf-next 1, the series
all. If the access can go one byte further, all three reject them.

1. Only the correlated branches in the slice keep states apart
--------------------------------------------------------------
  i = ktime(); err = 0;                 i is any u64
  if (i > 63) err = -22;                err stores the result of i > 63
  c1 = rnd() ? 1 : -1;  ...  cN = ...   N more stored conditions
  if (c1 > 0) cnt[1]++; ...             buf[i] does not depend on them
  if (err) return 0;                    correlated with 'if (i > 63)'
  return buf[i];                        char buf[64]

  N                   4        8        12       24
  7.4-rc3    insns    498      13765    341011   REJECT
             time     0.5 ms   9 ms     213 ms   656 ms
  bpf-next   insns    396      8090     REJECT   REJECT
             time     0.7 ms   60 ms    688 ms   1.5 s
  series     insns    242      470      698      1683
             time     0.4 ms   0.7 ms   1.1 ms   2.6 ms

7.4-rc3 marks c1 .. cN as precise, because they decide a jump. So the paths
multiply. With N = 16 it gets to the limit of 1M insns.

bpf-next keeps states apart for each stored condition, because a jump tests it.
With N = 12 it gets to its limit on states. It joins all states, and loses the
relation between i and err.

The series joins all numbers in pass 0. The join loses the relation, and buf[i]
is unproven. i is in data_deps, err is in control_deps. Pass 1 keeps two states
apart: both i and err differ. c1 .. cN are not in the deps and stay joined.

2. The verdict does not depend on the code pattern
--------------------------------------------------
  off = 0; len = 64;                     char buf[64]
  if (x) { off = 56; len = 8; }

                                         7.4-rc3   bpf-next          series
  probe_read_kernel(buf + off, len, p)   loads     loads             loads
  buf[off + len - 1]                     loads     REJECT, off=119   loads
  buf[off + len / 2]                     loads     REJECT, off=88    loads
  buf[off * len / 8]                     loads     REJECT, off=448   loads

7.4-rc3 checks the two paths one by one. bpf-next has a table for the first row,
and none for the others.

The series has no table. The join finds off = 56 * s, len = 64 - 56 * s, where s
is 0 or 1. That proves rows 1, 2 and 3 in pass 0. Row 4 is not linear: it is
unproven, and pass 1 keeps the two states apart.

3. The work does not grow with the trip count
---------------------------------------------
  append    for (i = 0; i < N; i++) {
                    n = read_str(big + off, 16);
                    if (n < 0 || n > 16) break;
                    off += n;
            }
  compact   for (i = 0; i < N; i++) if (in[i]) out[n++] = in[i];
  reverse   for (l = 0, r = N - 1; l < r; l++, r--) swap(a[l], a[r]);
  best      for (i = 0; i < N; i++) if (x > max) { max = x; at = i; }  a[at]
  nested    for (j < N) { for (k < N) off += 0..1; off += 0..1; }  a[off]

A trip is one iteration of a loop. Insns processed for each N:

            7.4-rc3                     bpf-next                    series
  N         100      1000     10000     100      1000     10000     each N
  append    1204     12004    REJECT    1104     11004    REJECT    38
  compact   REJECT   REJECT   REJECT    1104     11004    REJECT    37
  reverse   554      5504     55004     554      REJECT   REJECT    38
  best      REJECT   REJECT   REJECT    1108     11008    REJECT    198
  nested    50907    REJECT   REJECT    50907    REJECT   REJECT    55

scev.c has no expression for off, n and at, and no trip count for 'l < r'. So
7.4-rc3 checks the trips one by one, up to 1M insns or 8192 pending jumps. In
compact and best a branch in each trip changes a precise value, and the paths
multiply.
bpf-next checks the trips one by one, if all trips take 100000 insns or less.
With no trip count it stops after 4096 insns. If N is larger, it rejects the
program.

The trip index k is the canonical induction variable, and it is a value in the
state. The join at the loop header finds the values that are linear in k. One
jump bounds all of them:

  append:   i = k,  off = 16 * k + d,  d <= 0      'i < N' bounds k

4. A test of one number bounds the related numbers
--------------------------------------------------
  a and b are 0..65535
  s = a + b;
  if (s > 63) return 0;                      old:      REJECT, off=65535
  buf[a]                                     series:   13 insns

  a is 0..7, b is 8..15                      char big[169]
  for (i = 12 * a; i != 12 * b; i += 12)     old:      REJECT
          big[i]                             series:   34 insns, 15 trips

  n = bpf_get_stack(ctx, buf, 800, 0);       char buf[800]
  if (n < 0) return 0;                       old:      REJECT, off=800 size=800
  bpf_get_stack(ctx, buf + n, 800 - n, 0);   series:   19 insns

  off is 0..63                               char buf[64]
  if (len > 64 - off) return 0;              old:      REJECT, off=63 size=64
  probe_read_kernel(buf + off, len, p);      series:   41 insns

Each state has a table of equations. An insn makes them, a jump uses them, a
join guesses them, and a prune checks them. sym0 is a symbolic value:

  r2 = r1                r1 = sym0, r2 = sym0
  r2 <<= 2               r2 = 4 * sym0
  if r1 > 7 goto out     sym0 is 0..7, so r2 is 0..28

The check of a memory argument uses the equations too: offset n plus size
800 - n is 800. test_get_stack_rawtp.c doubles its buffer to pass this check.
Patch 45 gives the buffer its real size.

A jump can make an equation: 'len > 64 - off' gives d = len + off - 64 and
d <= 0. It does that only if len is in data_deps, so in pass 1.

7.4-rc3 links only copies and 'x + constant', up to 5 at a jump. On bpf-next
scev.c has one expression for all paths. An equation holds in one state, so it
can differ between paths.

5. Loops without a trip count
-----------------------------
  lo = 0; hi = N;                    7.4-rc3:  REJECT, 1M insns, also for N = 8
  while (lo < hi) {                            (N = 8 loads with -Os)
          mid = (lo + hi) / 2;       bpf-next: REJECT, also for N = 8
          if (a[mid] < key)          series:   79 insns,   N = 8
                  lo = mid + 1;                970 insns,  N = 1024
          else                                 1596 insns, N = 1M
                  hi = mid;
  }

  while (can_loop) {                 7.4-rc3:  1654 insns
          if (push) {                bpf-next: REJECT
                  if (d == 63)       series:   313 insns
                          break;
                  d++;
          } else {
                  if (!d) break;
                  d--;
          }
          buf[d]
  }

7.4-rc3 checks the trips one by one. clang makes two jumps for 'a[mid] < key'.
On the path where they disagree, lo and hi do not change, so the paths are long.
In the second loop d has 64 values, and may_goto prunes a state that repeats.

If a[mid] or buf[d] is unproven in pass 0, lo, hi and d get into the deps. Then
they are "widened": a bound that grows moves to the next constant of the loop.
If that is not sufficient, a partition peels only the loop that made one of them
imprecise: its trips are checked one by one. The binary search has no trip
count, so it gets may_goto.

6. Calls are context-sensitive
------------------------------
  static u64 next(u64 x) { return x + 1; }      char buf[64]

  i = next(7);                       7.4-rc3:  18 insns
  sum = next(rnd());                 bpf-next: REJECT, i is any number
  buf[i]                             series:   24 insns

7.4-rc3 checks a static function again at each call, on each path. bpf-next
joins the two calls.

The series checks a static function once for each instance. An instance is an
entry state, its exit states and its calls. Here next(7) is checked first, and
it gets the exit state with 8. If two calls share an instance and this causes an
error, the next pass gives each call its own instance. If the function gets a
pointer to the stack, bpf-next and the series check it at each call too.

  static bool ok(u64 x) { return x < 64; }

  if (!ok(x)) return 0;              7.4-rc3:  22 insns
  buf[x]                             bpf-next: REJECT
                                     series:   118 insns

An instance does not know that its argument is x of the caller. If an error
depends on such an argument, a partition checks this call with the state of the
caller.

7. Arrays of pointers on the stack
----------------------------------
  char *p[2] = { a, b };           old:      REJECT, "invalid mem access"
  return p[i & 1][63];             series:   45 insns

  bpf_for(i, 0, 2)                 old:      REJECT, "invalid mem access"
          sum += p[i][63];         series:   135 insns

A load from one of several stack slots gives a number. If a later insn needs a
pointer, the next pass "forks" the state: it does the load once for each slot.

8. The log shows the bug
------------------------
  for (i = 0; i < 100000; i++)
          if (rnd() && n < MAX) n++;
  buf[n]                             char buf[64], n is in R6

  MAX = 63, valid
    7.4-rc3    BPF program is too large. Processed 1000001 insn
    bpf-next   R6=scalar()
               math between map_value pointer and register with unbounded
               min value is not allowed
    series     loads, 198 insns

  MAX = 64, off by one
    7.4-rc3    R6=64, after 899878 insns
               invalid access to map value, value_size=64 off=64 size=1
    bpf-next   the same message as for MAX = 63
    series     R6=0..64, after 13964 insns
               invalid access to map value, value_size=64 off=64 size=1

7.4-rc3 checks the 100000 trips one by one: the first path takes 900k insns. It
shows the path to the bug, if it gets there before its limit.

bpf-next prints a joined state. The author cannot tell a bug from a limit of the
verifier. The series tries to reproduce the error in a path-sensitive run: one
path after another, with no joins. The path on which the check fails is the
failing path. The log shows it from insn 0. With a failing path the error is
probably real. So the verifier decreases its limit on work, see section 10.
"The price" has the exception. R6 has a range on one path, because clang makes
'n += rnd() & 1' with no branch.

9. The proof is separate from the guesses
-----------------------------------------
There are two kinds of code in the verifier:

  trusted   A bug in it can accept an unsafe program. It is the proof: the
            checks of an insn, the compare and the join of states.
  guess     It selects what to try next, and trusted code checks the result. A
            bug in it can reject a valid program or waste time. It cannot
            accept an unsafe program.

In 7.4-rc3 almost all of this code is trusted. If a bug in backtrack.c misses a
register, a path with an error can be pruned. Its guesses are small: which
states to keep, and which numbers to widen. bpf-next mixes the two kinds in
flow.c ("both"). The series puts the guesses into their own files:

  7.4-rc3      lines  kind      bpf-next   lines  kind      series           lines  kind
  scev.c        2945  trusted   scev.c      5504  trusted   equation.c        2423  trusted
  states.c      1767  trusted   flow.c      3411  both      flow.c            1837  trusted
  backtrack.c   1052  trusted   join.c       627  trusted   join.c             250  trusted
                                states.c     700  trusted   states.c           671  trusted
                                                            precision.c       1784  guess
                                                            equation_join.c   1458  guess
                                                            failing_path.c     269  guess
  total         5764            total      10242            total             8692
                                                            of them trusted   5181
  verifier.c   24331  trusted   verifier.c 25361  trusted   verifier.c       25971  trusted

So the series has less code than bpf-next, and more than 7.4-rc3.

An example: what a bug in the trip count can do. The bug is invented. This loop
makes 34 trips, i is 0, 3, .. 99:

  char a[100];
  i = 0; do { a[i] = 0; i += 3; } while (i < 100);

7.4-rc3 and bpf-next compute the trip count N with a formula of scev.c. The
formula has a case for each form of a loop: <, <=, !=, wrap around, 32-bit
counters. N gives the range of i at the loop header. Nothing checks N. The state
that comes back to the header gets the same range before the compare, so the
compare passes.

  If the formula is correct, it gives N = 34. The body is checked with
  i = 0..99.

  If the formula has a bug, it can give N = 30. Then the body is checked with
  i = 0..87 only. After the body i is 3..90, so 'i < 100' looks always true.
  The verifier removes the exit as dead code, and the program loads. At run
  time the loop does not end, and it writes past the end of 'a'.

So the formula and each case of it are trusted code.

The series has such a formula too, but it checks the result. The trip index k
is 0 in the first trip, and the back edge adds 1. The formula is only a guess
for the largest k. 'i = 3 * k' is a guess too. The verifier checks the body for
k = 0..guess. Then it compares the state that comes back with the header.

  If the formula is correct, the guess is 33. The header has k = 0..33 and
  i = 3 * k = 0..99. After the body i is 3..102. The test 'i < 100' lets only
  3..99 go back, so k = 1..33 comes back. This is inside of 0..33. So all trips
  are checked, and this is the proof.

  If the formula has a bug, the guess can be 29. The header has k = 0..29 and
  i = 0..87. After the body i is 3..90, and all of it goes back: k = 1..30. This
  is not inside of 0..29. The guess fails. If another jump of the loop gives a
  larger guess, the verifier takes it. This loop has none. So k gets no bound,
  and the loop gets may_goto. The program loads, and all stores are checked.

If k has a bound in the state that comes back, the loop ends, because k grows by
1 in each trip. If k has no bound up to 2^32, the loop has no trip count.

So a bug in the formula costs time, adds a may_goto, or rejects a valid program.
It cannot accept an unsafe program. A new case needs tests, not a proof.

10. Two total limits replace the separate limits
------------------------------------------------
  7.4-rc3    1M insns processed, 8192 pending jumps, 256 functions, 64 maps,
             256 kfuncs, 10000 calls in liveness. For a trip count: 1 back
             edge, 4 exit tests, 256 exits
  bpf-next   1024 states at an insn, 4096 live states + 16 for each insn, 65536
             total states + 256 for each insn, 100000 and 4096 insns for the
             trips of a loop, 8 trips of bpf_loop(), 10000 calls in liveness.
             For a trip count: 16 back edges with 4 exit tests each, 256 exits
             of an inner loop
  series     cost 2^33 and memory 2 GB, for the full load
  all three  1M insns in a program, 16 nested loops, 32 frames (7.4-rc3: 16)

bpf-next removed the limits on insns processed, jumps, functions, maps and
kfuncs. The series removes the others. Both have a limit on the ids of a state.

A limit on one kind of work rejects a program that needs much of that kind and
little else. "Cost" counts work, not time: one step of a scan costs 1, the check
of an insn costs 128, a new state costs 512. So the verdict does not depend on
the speed or the load of the machine. The heaviest program of the projects below
takes 11% of the cost. The largest peak of memory of a program that loads is
751 MB on 7.4-rc3, 304 MB on bpf-next and 265 MB with the series. The fixed
tables take 1.2 KB for each insn, as in bpf-next. The passes can add 256 MB,
plus 32 KB for each insn, within the 2 GB. So a small program gets less than
2 GB.

After the first error the limit on cost is 2^33 / 3, or two times the cost so
far if that is more. One more limit on precision: a state keeps 4 equations such
as a + b for each register or slot that has an equation. A loop gets may_goto if
k can be above 2^32.

Results
=======
7.4-rc3, bpf-next ea80d2afd285 and the series have the same config. The tests
ran on x86-64 and arm64. veristat ran as root on x86-64, in VMs with
mitigations=off and 20 loads in parallel. Time is the best of three runs. "peak
states" is the largest number of states that the verifier keeps at a time.
7.4-rc3 does not count the states of pending jumps. In the wide tables rc3 is
7.4-rc3, next is bpf-next, new is the series, and "-" is a program that does not
load.

Selftests
---------
Against bpf-next:

  test_progs      no new failure. default: 770 tests, without some network and
                  perf tests. no_alu32, cpuv4, KASAN: 400 tests of the verifier
  test_verifier   793 of 793

veristat on the selftests of 7.4-rc3, 5683 programs. The sums are for the 3958
programs that load on all three:

                                    7.4-rc3     bpf-next    series
  programs that load                3962        3990        3996
  insns, sum                        5.15M       2.13M       600k
  time, sum                         5.1 s       3.3 s       1.5 s
  peak states, sum                  80k         64k         15k

Top gains and top losses, by time against the faster one of the old verifiers:

                                               insns             time, ms           peak states
                                           rc3  next   new     rc3  next   new     rc3  next   new
  pyperf600                               258k  151k   39k    1023   366   140     17k  6102   607
  test_verif_scale2                       780k  520k   12k     201   174    25     801  4186     4
  core_kern                               556k  540k   13k     165   184    28     693  4186     4
  pyperf600_nounroll                      466k  184k  1324     359   125   3.4    1141   146    12
  pyperf100                                43k   27k   27k     385   171    71    3216  2042     6
  pyperf180                                74k   44k   22k     334   165    70    5515  3702   367
  call_large_imm_test                      66k   66k   66k     192   258   103       2     6     7
  test_verif_scale1                       547k   51k   12k     143    76    16    2146  8193     6
  test_verif_scale3                       837k   58k   18k     210    81    26    2146  8193     6
  gotol_large_imm                          40k   40k   40k     106   150    54       0     2     1

  res_spin_lock_test_held_lock_max        2356  4088   49k     4.7   7.1   183      62   148   640
  test_tcp_custom_syncookie                19k  5629   13k      21    14    28    1029   259   175
  rbtree_search                           7326  4236  9558     7.7   7.8    13     118   232   532
  profiler2 kprobe_ret__do_file_open      3038  1822  6588     4.0   3.9   7.3      87    40    15
  bpf_loop_iter_limit_nested               624   496  1942    0.74  0.91   3.1      41    90    42
  xdp_synproxy_kern syncookie_xdp          12k  4164  7630      19    11    13    1124   105    36

veristat on the selftests of bpf-next. 5165 programs load on bpf-next and with
the series: insns change by -60%, time by -68%. Patches 1 and 2 alone change
the time by -21%. 11 more load with the series. The four new files of
verifier tests have 271 valid programs. bpf-next rejects 72 of them.

BPF CI builds the selftests in four ways: default, no_alu32, cpuv4, gcc.
16306 programs of these builds load on bpf-next and with the series: insns
change by -66%, time by -76%. 60 more load with the series. In these builds
and in the selftests above the series rejects one program that bpf-next loads:
stash_rb_nodes, see "The price". Two tests of 7.4-rc3 load only on 7.4-rc3:
private_stack_two_frames and test_arena_member_cb.

Programs of other projects
--------------------------
The series loads all programs that 7.4-rc3 or bpf-next loads. It loads 8908
more than 7.4-rc3 and 2002 more than bpf-next. 1858 load only with the series.

A build is one choice of release, clang (14 .. 20, 24), -mcpu (v1 .. v4), -O
level and options of the project. A program counts once for each build. Not all
projects have all builds. Some builds are not options of the project:
__always_inline is removed or becomes noinline, or constants of the loader are
unknown. These have 27947 programs, 1983 of the 8908 and 232 of the 2002.
The 2002 are builds of 168 programs. For 164 of them another build loads on
bpf-next. The objects are adapted to load on one kernel, with a patched
veristat.

"progs" is the number of all programs. insns, time and peak states are averages
for one program, over the programs that load on all three. Patches 1 and 2 alone
change the time of bpf-next by -41%, and all patches by -51%.

                               programs that load       insns          time, ms        peak states
  project              progs    rc3   next    new    rc3 next  new    rc3 next  new    rc3 next  new
  all                 385572 331907 338813 340815    18k 2716 1750     23   10  5.2    562  143   18

  alaz                    69     69     69     69   1477  853  846    4.1  4.3  2.1     96   28    9
  bad-bpf                142    122    130    135   8091   77  100    5.6 0.61 0.35     64    6    4
  bcc                   3364   3311   3319   3327    206   98  118   0.53 0.58 0.35     13   10    5
  below                   14     14     14     14   1349  591  591    3.1  2.9  1.4    105   32    4
  bouheki                 53     51     53     53    19k  717  471     39  3.3  1.5   1629   86   12
  bpf-dev-tutorial       772    754    755    766    424   68   69   0.53 0.43 0.23     10    6    3
  bpf-examples           481    470    464    475   8994  928  703    8.2  3.1  2.1     95   92   13
  bpfjailer             1625   1411   1431   1465    16k 3185 5216     38   18   14   1333  104   48
  bpfsnoop                78     75     76     76   2230  488  117    2.6  2.2 0.79     32   23    6
  bpftune                125    113    113    125    475  311  284    1.7  2.0 0.85     31   23    5
  cilium                5496   5490   5490   5490   7914 2023 1714     14   10  6.4    345  160   22
  coolbpf               1178   1107   1156   1156    14k 3184 1752     29  9.9  5.6   1100  114   23
  datadog-agent       234993 190601 192987 193112   2342  732  619    5.3  3.9  1.9    107   40    7
  elastic-ebpf          1079    646    646   1065   3437 1368  561    4.6  3.0  1.2     36   15    7
  falco                38108  37388  37583  37583    17k 1274 1035     18  6.7  2.6    283   53   13
  gala-gopher            215    209    215    215   9241 5172 5114     15   14  7.2    412  196    8
  inspektor-gadget      5422   5165   5402   5419    14k  515  339     19  2.3  1.0    124   22    5
  katran                 238    236    236    236    15k 1630 2426     16  5.3  4.6    279   83   11
  krie                  6930   6922   6908   6924   5080 2010 2007    9.5  7.5  3.1    177   31   15
  kubearmor             1100   1100   1100   1100    57k  12k  12k    117   61   32   2793  554   22
  kubescape node-agent   582    508    517    549   187k 7629 3195    213   20  7.5   1801  187   16
  kubeshark-tracer       264    252    252    264   2239  610  521    3.2  2.7  1.3     88   15    4
  kyanos                 818    818    818    818   8126 1248 1015     13  7.1  3.2    403   80    9
  lightswitch             67     61     63     63    67k 1420  621     51  3.5  3.6    393   63   21
  linux perf             345    335    341    341   8503 1073  286    9.3  1.6 0.62     67   17    6
  linux selftests/net     47     41     41     41   2289 1409  678    4.4  4.5  2.1    122   92    8
  loxilb-ebpf             47     45     45     45   1815 1273  350    1.9  2.1 0.77     66   28    5
  lsmtrace              2375   2337   2359   2359    290  269  270    1.0  1.2 0.50     18    9    4
  netobserv              389    361    373    373   1707  454  319    5.4  4.4  1.9    108   43    7
  opentelemetry obi     3982   3915   3946   3965   5098  846  664    7.4  4.6  2.4    119   40    8
  pulsar                 665    623    616    623   6307 2125 2121     27   12  5.9    423  119   10
  pwru                   302    300    301    302   2600  654  307    5.1  3.9  1.8     69   23    4
  rbperf                  20     20     20     20   4356 3006 3006     25   18  8.9    346  148    5
  retis                   10      9      9     10   2659 2247 2110    8.2  9.6  4.4    210  118   15
  retsnoop               118    118    118    118   3636 1301 1476    7.9  5.6  4.2    157   65   30
  runtime-enforcer        66     66     66     66   1261  732  702    4.6  4.6  2.3    106   52   18
  rust-bpf              1089      8    861    861     25   23   23   0.18 0.22 0.13      2    6    4
  scx                   1272   1163   1165   1165   4681  480  501    8.1  2.7  1.7    215   35   19
  seabee                 511    503    511    511    300  243  250   0.94  1.1 0.61     26   17   10
  skywalking-rover      1310   1310   1310   1310   162k 1870 1241    141  8.4  3.8    547  103   14
  stackrox fact          154     98     98     98   2624  835  633    6.4  6.0  2.5    101   43   11
  systemd                575    541    559    560    12k 4450  790     14  6.4  2.1    312   70   15
  tetragon             40814  37639  39944  40074   101k  15k 7712    117   46   25   3364  854   80
  tracee               22774  20214  20957  22098    24k 3226 2849     34   15  6.4    656  115   24
  tracexec                94     66     66     66   5501 1157 1371     13  5.1  3.7    541   58   27
  wazuh                  183    175    183    183   168k  76k  76k    427  348  183    11k 1729   13
  wprof                  192    192    192    192    11k 3602 5466     15   14   11    288  209   93
  xdp-tools               67     67     67     67    25k 1656  797     19  3.1  2.0     68  143   13
  31 more projects      4958   4868   4868   4868    382  241  244    1.2  1.4 0.68     25   15    5

In the 31 more projects the three verifiers load the same programs, and 7.4-rc3
takes less than 1000 insns on average. The number is "progs":

  bpflock 250, bpfman 60, bpftop 8, calico 10, cilium/ebpf 122,
  cloudflare lsm-bpf 27, dynolog 64, ebpf-exporter 581, ecapture 213,
  ehids-agent 55, facebook dns 15, kubeskoop 184, learning-ebpf 20,
  libbpf-bootstrap 88, libbpf-rs 149, libbpfgo 77, linux bpftool 24,
  linux preload 8, linux samples 204, linux selftests/drv 3,
  linux selftests/scx 621, pamspy 6, parca-agent 11, portmaster 32, psc 17,
  ptcpdump 631, retina 25, rezolus 566, strobelight 6, systing 834, teleport 47

- cilium has one build for each week from February to November 2026. tetragon,
  tracee, falco (libs) and datadog-agent have the main branch and one release of
  each minor version, from v1.0, v0.12, 0.13 and 7.50.
- rust-bpf is github.com/4ast/rust-bpf: tests of Rust crates and of the Rust
  library, and scx schedulers in Rust. LLVM with a pending pull request builds
  them. Most of them need the arena stack, which 7.4-rc3 does not have. So the
  row shows only 8 of them. For the 861 against bpf-next:
  insns -51%, time +2%, peak states +45%.
- Two of the 31 take many more insns than on bpf-next: cloudflare lsm-bpf
  52 -> 113, systing 286 -> 355.
- 44757 programs load on no kernel, 41881 of them in datadog-agent. Most of
  these attach to a function that the kernel config does not have (583 in a
  sample of 600).

Why the old verifiers reject a program that the series loads:

                                               7.4-rc3    bpf-next
  a bound is not proven                        3069       1959
  an offset of 2^29 or more at a pointer add   739        0
  limit of 1M insns                            2054       no limit
  limit of 8192 pending jumps                  157        no limit
  "infinite loop detected"                     3          0
  limit on states                              no limit   30
  a rule or a feature that came later          2886       13
  total                                        8908       2002

The last error in the log gives the group. On bpf-next a limit can show as a
bound that is not proven, see example 1. bpf-next has the same rule for a large
offset as 7.4-rc3, and it loads these 739 programs. The last group is not about
the main analysis. On bpf-next it has the rules that patches 8 and 38 change. On
7.4-rc3 it has:

  tail call in a function that does not return int   1467
  arena stack                                        840
  32-bit add to a pointer                            328
  arguments on the stack                             126
  more than 256 functions                            13
  others                                             112

Examples of programs that only the series loads, in some -O2 builds with the
options of the project:

  tracee             sys_exit_submit, sched_process_exec_signal
  elastic-ebpf       fentry__vfs_rename, fexit__do_file_open
  tetragon           event_execve, generic_retkprobe_event
  datadog-agent      hook_cgroup_procs_write
  obi                obi_packet_extender_find_existing_tp
  bpftune            bpftune_sysctl
  inspektor-gadget   trace_uprobe_mutex_unlock
  systemd            monitor_varlink_socket_sendmsg

144 programs load on 7.4-rc3 and with the series, and not on bpf-next:
datadog-agent 89, krie 16, kubescape node-agent 16, pulsar 7, others 16.

Top gains and top losses
------------------------
The number of programs whose time changes by more than 1 ms or 10 ms:

                                       faster by           slower by
                       load on both      1 ms     10 ms      1 ms     10 ms
  series vs 7.4-rc3          331907    150316     49795       677        89
  series vs bpf-next         338813    175428     31667      4173      1729

Each table has the programs with the largest change of time, one program and one
build for each project. Programs below 1000 insns are left out. A program can be
in two tables with two builds.

                                                               insns              time, ms
  project          program                                 rc3  next   new      rc3  next   new
  gains against 7.4-rc3
  datadog-agent    socket__http2_headers_parser           738k  145k  141k     4866  1349   645
  falco            sendmmsg_x                             950k  2249  2090     1630    15   7.1
  tetragon         generic_lsm_actions                    951k  5183  3499     1306    11   8.9
  tracee           trace_security_file_mprotect           866k   11k  8210     1301    55    20
  inspektor-gadget ig_topfile_rd_e                        611k   14k  7615     1219    42    17
  kubescape        tracepoint__x86_fpu_regs_deactivated   600k   13k  7545     1096    40    17
  scx              flow_select_cpu                        293k  1145  1803     1046   5.8   5.8
  krie             perf_event_syscall_table_ticker        865k   54k   27k     1093   156    58
  coolbpf          trace_mremap_exit                      327k   40k   22k     1005    81    65
  skywalking       go_tls_write_ret                       573k  4147  2585      684    19   8.2
  pulsar           sched_switch                            48k   20k   20k      678   151    62
  lightswitch      dwarf_unwind                           721k   12k  2119      594    22    14

  gains against bpf-next
  datadog-agent    __x64_sys_openat2_exit                    -   57k  2194        -  2310   9.7
  coolbpf          trace_openat_exit                         -  944k   76k        -   949   213
  falco            dump_task                                 -   44k   26k        -   632    90
  rust-bpf         smol_str_ryu                              -  587k   76k        -   854   435
  tetragon         generic_fexit_event                    291k  109k   29k      496   469   104
  wazuh            path_rename_old_walk                   198k   90k   90k      504   425   188
  systemd          userns_restrict_inode_symlink          301k  149k   819      286   139   2.5
  tracee           uprobe_syscall_table_check             517k  127k   12k      518   150    31
  bpfjailer        test_dyn_map                            63k   18k   11k      217   192    81
  krie             perf_event_syscall_table_ticker        865k   54k   27k     1093   156    58
  pulsar           sched_switch                            26k   20k   20k      672   146    57
  kubearmor        enforce_proc                           201k   30k   27k      291   128    68

  losses against 7.4-rc3
  krie             perf_event_syscall_table_ticker        378k     -  455k      664     -   916
  obi              obi_packet_extender_find_existing_tp   157k     -  113k      119     -   237
  wprof            wprof_task_switch                      121k   32k   80k      154   112   202
  datadog-agent    uprobe__http2_tls_filter                84k   33k   44k       87    85   136
  coolbpf          unwind_native                           55k   31k   31k       69    84   113
  bpfjailer        bpfj_remount                           1717  1110   16k      2.5   2.6    32
  tetragon         generic_uprobe_process_event           7153  3856   29k       92   112   109
  retsnoop         retsn_inj_kretprobe                    1378   642  6220      4.4   3.9    15
  scx              layered_runnable                       9827  4457   12k       18    13    27
  bpf-examples     flowmap_cleanup                        1446   423  4032      2.6   2.3    10

  losses against bpf-next
  rust-bpf         vec_sort_stable                           -   85k   95k        -   142   547
  wprof            wprof_task_switch                      121k   32k   80k      154   112   202
  coolbpf          trace_mmap_exit                           -   11k   53k        -    30   114
  tetragon         generic_usdt_actions                   245k  4233   41k      156   7.3    85
  kubearmor        enforce_proc                           254k   41k  112k      342   144   220
  datadog-agent    socket__http2_filter                      -   36k   47k        -   100   160
  krie             perf_event_syscall_table_ticker        504k   25k   97k      761    98   154
  obi              parse_dns_response                        -   11k   33k        -    13    63
  tracee           lkm_seeker_kset_tail                   342k   15k   76k      373    78   125
  falco            dump_task                                 -   21k   71k        -    60    91
  bpfjailer        bpfj_remount                           1717  1110   16k      2.5   2.6    32
  scx              layered_runnable                       9827  4457   12k       18    13    27

The price
=========
(35) means patch 35.

- A program that needs more passes takes more insns: the count is the sum of
  all passes. There is no separate limit on this count, in bpf-next or in the
  series. In the series each insn adds to the cost, see section 10. Most
  losses against bpf-next are such programs. 1032 of the 1729 are
  generic_*_actions of tetragon: 6 -> 38 ms on average (7.4-rc3: 179 ms). The
  gcc build of the selftest strobemeta is one more: 254k -> 383k insns,
  482 -> 1011 ms.

- Time can grow when insns do not. The work on equations and on deps is not in
  this count. See vec_sort_stable and unwind_native above. 43 of the 89
  losses against 7.4-rc3 are of this kind.

- Only a partition peels a loop. So a short loop without a trip count gets
  may_goto, where the old verifiers check all trips. 7.4-rc3 does not add
  may_goto. bpf-next adds it to 745 programs of the projects, the series to 290.
  170 of the 290 do not load on 7.4-rc3, 30 do not load on bpf-next. The series
  against bpf-next:

    more may_goto     44 programs  rust-bpf 16, tracee 14, coolbpf 10,
                                   bpfjailer 4
    fewer may_goto   762 programs  rust-bpf 264, falco 211, tetragon 152,
                                   datadog-agent 36, obi 34, others 65

- After a join the verifier can fail to see that a path is dead. Then it does
  not remove the code of that path. Here "size" is the number of insns in the
  loaded program. The last column is for programs with the same number of
  may_goto. Most of them are in tetragon. The largest growth is in
  generic_lsm_process_event, size 4k -> 17k. The row for 7.4-rc3 also has the
  changes of bpf-next in the fixups.

                         larger   smaller   sum of sizes   larger by 5%
    series vs 7.4-rc3    19209    8650      +0.6%          1853
    series vs bpf-next   7027     7991      +0.5%          346

- If the address of a function is taken and it has a callx, it counts as
  recursive. Then a program can fail if the function returns a pointer or passes
  a pointer to the stack. bpf-next does the same, 7.4-rc3 loads it.

- An unsafe program takes longer to reject. The verifier partitions more and
  looks for a failing path first. These programs fail on each kernel that ran
  them. Of the projects: those that get to the main analysis of bpf-next.

                            programs  7.4-rc3  bpf-next  series  slowest, series
    selftests of bpf-next   1964      not run  2.9 s     6.8 s   3.3 s
    selftests of 7.4-rc3    1684      3.8 s    1.3 s     0.2 s   0.05 s
    projects                3573      92 s     91 s      280 s   8.0 s

  An off-by-one in example 3 takes up to 5 s for the largest N. The log of a
  failing path through 10000 trips can have 170k lines.

- A valid program can get to the limit on cost or memory. No program of the
  projects does. These generated programs do. The first four are very large.
  The last two are small, their states multiply:

                                                     7.4-rc3        bpf-next
    1000 calls with &local, function of 10000 insns  REJECT         35 s
    100k branches with 16 states each                REJECT         19 s, 4 GB
    400k branches with a large stack                 REJECT         39 s, 14 GB
    a loop of 240k insns with a stack of 2 KB        5 s, 2.2 GB    12 s, 2.2 GB
    12 pairs of pointers that can be equal           4 s, 17 MB     REJECT
    12 ring buffer records, each of 8 or 16 bytes    0.4 s          REJECT

- A search with hand-written tests found more valid programs that bpf-next
  loads and the series rejects. No program of the projects has such a shape:

    3 nested loops in 12k insns take two locks in one of the trips
    a function that callx calls stores an index and a flag for its caller
    36 pairs of constants, then 20 branches that add to one of them
    16 live pointers, each has a copy on one path that is never read
    40 blocks with 10 pointers, each points to one of two members
    a word of a table of pointers on the stack is added to such a pointer (43)
    the only exit of a loop is after bpf_throw()
    a path that only a join makes tests or uses a sum of 24 optional numbers
    900 loops call one function that has 32k constants

- A program is rejected if one call needs two different fixups (10):
  bpf_obj_drop() for two types with different special fields, list push with two
  node offsets. A compiler can make such a call. The fix is
  __attribute__((nomerge)). stash_rb_nodes needs it (45).

- The path-sensitive run skips trips of a long loop. If the step is not a
  constant, the skip is a guess, and the failing path can be false (35). Then
  the limit on cost is not decreased. An example of an unsafe program, and the
  time to reject it:

    for (i = 0; i < N; i++) sum += i;   N          1000     1000000
    buf[sum]                            7.4-rc3    1.6 ms   0.4 s
                                        bpf-next   1.4 ms   0.1 ms
                                        series     11 ms    7 s

Other changes of behaviour
==========================
Against bpf-next:

- A loop without a trip count gets may_goto, unless it has may_goto or an
  iterator, or all trips are peeled. If may_goto is not possible (no exit,
  offload), or its new edge is not safe, the program is rejected. Only a
  partition peels a loop. There is no trip count without CAP_PERFMON.
- The form of a loop does not matter for the trip count: two entries, many
  exits, many back edges. The trip index can be up to 2^32. Some loops lose
  the trip count and get may_goto (44, 45).
- Without bypass_spec_v1 a pointer add that ALU sanitation cannot mask gets a
  nospec insn (11).
- A pointer that is 2^29 or more away from the object fails at the access, not
  at the add. An add of a number that can be -2^29 or less still fails. A far
  load from a flexible array of a BTF object gets a fault handler, and a far
  load-acquire fails (8).
- Without allow_ptr_leaks a packet pointer is compared with data_end only from
  -MAX_PACKET_OFF to 2 * MAX_PACKET_OFF (8).
- Without allow_ptr_leaks a store of a pointer at a variable stack offset is
  rejected (21).
- With CAP_PERFMON a load can take a part of a spilled pointer at a constant
  offset (8).
- A function can leave a pointer to the stack in r0. The caller cannot read it
  (38).
- A join can increase a bound that is checked at attach time, such as the size
  of the context. Such an insn is "pessimized", and it gets a partition in a
  small budget. One case is not covered: a join hides that a path is dead, and
  an insn there has constant operands (36).
- Without CAP_BPF there are no equations. Without bypass_spec_v1 a join makes no
  equations from constants, and pointers and speculative states have none.
- Without CAP_BPF the limits on cost and memory are 1/32.

How to read the series
======================
Start with patch 49. It rewrites Documentation/bpf/verifier.rst, and explains
all parts and all words with examples.

Patches 1 and 2 do not need the rest. Patches 3 .. 43 are one change, divided
for review. The kernel builds after each patch. After patches 3 .. 36 it has no
main pass, and each load fails with -EOPNOTSUPP. Programs load again from patch
37 on. Only 3 lines are temporary, each other line changes in one patch only.

Read the patches in this order:

  49         docs
  37         do_check_all(): the loop of passes
  21-25      compare, unproven insn, deps, join rule, join
  28-29      prune or join, the order of the worklist
  16-20      equations: arithmetic, table, jump, insn, clean-up
  26-27, 32  equations at a prune and at a join: check, guess, join rule
  15, 30-31  loops: peel, trip index, trip count or may_goto
  33-36      instances, partition and undo, failing path, pessimized
  38-43      less work: fewer passes, one check of a loop body, fork
  5-14       small changes that the above needs
  3-4        deletions
  44-48      selftests

Patches with trusted code, see section 9: the checks of an insn (8-14, 19, 38,
42), equation.c (16-20, 26, 30, 41), subsumes and join (7, 21, 25, 30), prune or
join and the order (28, 29), peel (15, 28, 31, 35), recovery after an unproven
insn (22), cycles get may_goto (31), exits of instances (33), liveness (2, 6),
limits (5), passes and snapshots (9, 35-37), the fork (43).

  kernel/bpf and include   +11272   -12028   net -756
  selftests                +10130   -1079    net +9051
  docs                     +1499    -519     net +980

Changes in v2
=============
- The kernel builds after each patch. About 500 lines moved to another patch.
- Fix the build of the selftests with GCC (47), and three warnings of clang
  (23, 34, 35).
- A far load from a flexible array of a BTF object gets a fault handler (8).
- Valid programs that v1 rejects load now: a trip index that gets to S64_MAX
  (30), an error in one function of a callx set (33), a recursion with two exit
  insns (28), an AND that splits a number with a step (12).
- Count the scan of a table of functions and the sort of gotox targets (5). An
  error in the collection of thresholds does not leak the charge of memory (25).
- A failed speculative state does not bring back a fastcall rewrite (11).
- The log has no false trip count for a loop with an iterator or may_goto (31).
- More selftests (46 .. 48), better comments (7, 8, 17).
- Rebase on bpf-next 82cc2b4383e3. The tables have the numbers of v1. With v2
  each program of the projects has the same verdict, and 5 have other insns.
- v1: https://lore.kernel.org/r/20261120074430.2704488-1-alexei.starovoitov@gmail.com

Alexei Starovoitov (49):
  bpf: Look for bpf_clone_redirect() once in check_recursion()
  bpf: Make stack liveness faster
  bpf: Delete the old main pass of the verifier
  bpf: Delete scalar evolution
  bpf: Limit the cost and the memory of a load
  bpf: Record what each insn reads and writes
  bpf: Name an id after the xreg that has it
  bpf: Do not fail a check because a state has fewer values
  bpf: Check fixups in the main pass and keep a snapshot of them
  bpf: Reject a program with a call that needs two rewrites
  bpf: Put a barrier where no mask fits
  bpf: Keep more of what is known about a number
  bpf: Remember how many bytes of a packet are checked
  bpf: Mark a state that no run of the program has
  bpf: Peel the first trips of a loop and join the other trips
  bpf: Add equations and their arithmetic
  bpf: Keep a table of equations in each state
  bpf: Refine all related numbers after a jump
  bpf: Make equations from ALU, spill, fill and call insns
  bpf: Delete the equations that say nothing
  bpf: Compare states by join_key, then by value
  bpf: Continue a pass after an unproven insn
  bpf: Find the xregs that an unproven insn depends on
  bpf: Keep two states apart if data and control deps differ
  bpf: Join any two states that have the same join_key
  bpf: Check the equations when a state is pruned or joined
  bpf: Guess the equations of a join
  bpf: Prune or join each state that arrives
  bpf: Order the pending states and free the states that are done
  bpf: Get the trip count from the trip index
  bpf: Give a loop a checked trip count or may_goto
  bpf: Use the equations in the join rule
  bpf: Verify a static function once for each instance
  bpf: Partition the states after an error
  bpf: Reproduce an error on one path, with no joins
  bpf: Do not let a join raise what a program requires
  bpf: Verify in passes
  bpf: Make a returned pointer to the stack unreadable
  bpf: Keep two states apart if a live xreg has two types
  bpf: Check the body of a counted loop once
  bpf: Refine the copies of a number that AND or OR splits
  bpf: Allow a range of offsets for a constant string
  bpf: Keep spilled pointers at a range of stack offsets
  selftests/bpf: Adjust tests to the new log text
  selftests/bpf: Adjust tests that get another verdict or may_goto
  selftests/bpf: Test barriers and far pointers
  selftests/bpf: Test passes, instances, precision and the failing path
  selftests/bpf: Test equations
  bpf, docs: Rewrite verifier.rst

 Documentation/bpf/bpf_design_QA.rst           |    6 +-
 Documentation/bpf/kfuncs.rst                  |    4 +-
 Documentation/bpf/verifier.rst                | 2008 ++++--
 include/linux/bpf.h                           |    8 +-
 include/linux/bpf_verifier.h                  |  952 ++-
 include/linux/cnum.h                          |    3 -
 include/linux/tnum.h                          |    2 -
 kernel/bpf/Makefile                           |    6 +-
 kernel/bpf/btf.c                              |    2 +-
 kernel/bpf/cnum.c                             |   37 -
 kernel/bpf/const_fold.c                       |  285 +-
 kernel/bpf/diagnostics.c                      |   70 +-
 kernel/bpf/diagnostics.h                      |    8 +-
 kernel/bpf/equation.c                         | 2423 ++++++++
 kernel/bpf/equation.h                         |  199 +
 kernel/bpf/equation_join.c                    | 1458 +++++
 kernel/bpf/failing_path.c                     |  269 +
 kernel/bpf/fixups.c                           |  228 +-
 kernel/bpf/flow.c                             | 4108 ++++--------
 kernel/bpf/join.c                             |  753 +--
 kernel/bpf/liveness.c                         |  322 +-
 kernel/bpf/log.c                              |   91 +-
 kernel/bpf/loops.c                            |  416 +-
 kernel/bpf/offload.c                          |    3 +
 kernel/bpf/precision.c                        | 1784 ++++++
 kernel/bpf/precision.h                        |  139 +
 kernel/bpf/scev.c                             | 5504 -----------------
 kernel/bpf/states.c                           |  621 +-
 kernel/bpf/tnum.c                             |   11 -
 kernel/bpf/verifier.c                         | 3598 ++++++-----
 .../selftests/bpf/prog_tests/far_map_value.c  |   38 +
 .../selftests/bpf/prog_tests/log_fixup.c      |    6 +-
 .../selftests/bpf/prog_tests/spin_lock.c      |   12 +-
 .../selftests/bpf/prog_tests/verifier.c       |   12 +-
 .../selftests/bpf/progs/aggregate_ret_func.c  |   10 +-
 .../bpf/progs/compute_live_registers.c        |   10 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |    6 +-
 tools/testing/selftests/bpf/progs/iters.c     |    4 +-
 .../selftests/bpf/progs/iters_state_safety.c  |    6 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |    2 +-
 .../selftests/bpf/progs/local_kptr_stash.c    |    3 +
 .../selftests/bpf/progs/map_kptr_fail.c       |    2 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |    2 +-
 .../bpf/progs/refcounted_kptr_fail.c          |    4 +-
 .../struct_ops_refcounted_fail__ref_leak.c    |    2 +-
 .../bpf/progs/test_get_stack_rawtp.c          |   20 +-
 tools/testing/selftests/bpf/progs/timer.c     |    5 +-
 .../selftests/bpf/progs/timer_failure.c       |    6 +-
 .../selftests/bpf/progs/verifier_align.c      |   12 +-
 .../selftests/bpf/progs/verifier_and.c        |  150 +
 .../selftests/bpf/progs/verifier_arena.c      |    2 +-
 .../bpf/progs/verifier_arena_stack.c          |  105 +
 .../bpf/progs/verifier_array_access.c         |    2 +-
 .../selftests/bpf/progs/verifier_barrier.c    |  849 +++
 .../selftests/bpf/progs/verifier_bounds.c     |   36 +-
 .../bpf/progs/verifier_bounds_deduction.c     |   28 +-
 .../bpf/progs/verifier_bounds_step.c          |   86 +-
 .../bpf/progs/verifier_bpf_fastcall.c         |   33 +
 .../bpf/progs/verifier_btf_array_access.c     |   53 +
 .../selftests/bpf/progs/verifier_budget.c     |   25 +-
 .../bpf/progs/verifier_callx_rodata.c         |  130 +
 .../bpf/progs/verifier_direct_packet_access.c |  185 +-
 .../verifier_direct_stack_access_wraparound.c |   10 +-
 .../bpf/progs/verifier_div_mod_bounds.c       |   28 +
 .../selftests/bpf/progs/verifier_equations.c  | 1583 +++++
 .../bpf/progs/verifier_jumps_ahead.c          |    2 +-
 .../bpf/progs/verifier_linked_scalars.c       |  146 +-
 .../selftests/bpf/progs/verifier_live_stack.c |   10 +-
 .../bpf/progs/verifier_liveness_exp.c         |   52 +-
 .../bpf/progs/verifier_load_acquire.c         |   19 +
 .../selftests/bpf/progs/verifier_loop_as_is.c |   23 +-
 .../bpf/progs/verifier_loop_hierarchy.c       |   13 +-
 .../selftests/bpf/progs/verifier_loop_latch.c |   81 +-
 .../selftests/bpf/progs/verifier_loop_need.c  |   23 +-
 .../selftests/bpf/progs/verifier_loop_walk.c  |   10 +-
 .../selftests/bpf/progs/verifier_map_ptr.c    |   18 +-
 .../bpf/progs/verifier_meta_access.c          |    2 +-
 .../selftests/bpf/progs/verifier_movsx.c      |   20 +
 .../selftests/bpf/progs/verifier_partition.c  | 1555 +++++
 .../selftests/bpf/progs/verifier_passes.c     | 3758 +++++++++++
 .../selftests/bpf/progs/verifier_precision.c  |    2 +-
 .../bpf/progs/verifier_ref_tracking.c         |    7 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |   12 +-
 .../selftests/bpf/progs/verifier_sock.c       |    4 +-
 .../selftests/bpf/progs/verifier_spill_fill.c |   80 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |    2 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c  |   14 +-
 .../bpf/progs/verifier_subprog_callers.c      |    2 +-
 .../bpf/progs/verifier_subprog_insn_stats.c   |   14 +
 .../bpf/progs/verifier_subprog_precision.c    |    8 +-
 ...{verifier_scev.c => verifier_trip_count.c} | 1743 +++---
 .../selftests/bpf/progs/verifier_unpriv.c     |    6 +-
 .../bpf/progs/verifier_value_ptr_arith.c      |   66 +-
 .../selftests/bpf/progs/verifier_var_off.c    |   46 +
 tools/testing/selftests/bpf/verifier/calls.c  |    2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |    2 +-
 96 files changed, 22901 insertions(+), 13626 deletions(-)
 create mode 100644 kernel/bpf/equation.c
 create mode 100644 kernel/bpf/equation.h
 create mode 100644 kernel/bpf/equation_join.c
 create mode 100644 kernel/bpf/failing_path.c
 create mode 100644 kernel/bpf/precision.c
 create mode 100644 kernel/bpf/precision.h
 delete mode 100644 kernel/bpf/scev.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/far_map_value.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_barrier.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_equations.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_partition.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_passes.c
 rename tools/testing/selftests/bpf/progs/{verifier_scev.c => verifier_trip_count.c} (77%)


base-commit: 82cc2b4383e3edfa1026c8612fb4e90a9329ba11
-- 
2.55.0

