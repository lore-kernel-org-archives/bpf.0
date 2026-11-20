Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206817;
	b=MjOYoYoWSHwsiqK9HxJFk6PKhkTBIOrUp4Nzo+DJkrR9CcNZuQAiuJ47fngk42iUfToJ
	 X7D5ii2mLhneo+q20BsvfWRs6hjC9m/QN5r+dZdOIEQ/1vZEvdvHoAFpFV2Cp+CY+mUGG
	 ZErmWU9D0/krOiwOJo+HdMCInYU66xeu2U1LP3bpMcKlw6Kj4h/m9YdQBLp0VFOVX0BsH
	 /k8JI6DYxdQXhpPJPG4PFcoPRl2Z2JOFTOYnyq7+DpXzhlVQ2Vu9KnD/+24P4ZqQ15SIq
	 5JProlMWTO4F+MAelyGCxhaKfGf+pzKHReJmphDec7np0aezXSUzeWepk6nNpsP2IpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206817;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DcgwX7pf0/PAjyuyPUGgUqkja2QDO220o+h3fobkkQI=;
	b=l1IC97z65pGucCXzaHngIqGuwx+j7pGdXXdrn9PkCGkqP2B4CbAxvb3Sxvqvss4ZPdNL
	 504dpIWGEy9a4gGzDlGflIwgz/+EYE3MU07OMz8flW6L5jrOvWzKpLUdE/BjPplKsUnse
	 HJFIdG3xdyceJaHZFuG8dwKC2lI/lrhsH9sXqAf56Pg3tzyTWHVTPttaMMwVtC5oNvORi
	 2Ro8IHM2oA1MGU8kiI65nxtJ1wgwcKp+bqcPBVSEXa6sKCOrjZPPbxrMj4C/detR19JwO
	 nj4nBKjHBiy/rnza26AdKKptjDvx5YzO90kSrVuuGnafpl1voBgQzhjP2lrxMG7qZkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiFuzHzt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19864606A6D6;
	Fri, 20 Nov 2026 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiFuzHzt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70371F000C6;
	Fri, 20 Nov 2026 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206817;
	bh=DcgwX7pf0/PAjyuyPUGgUqkja2QDO220o+h3fobkkQI=;
	h=From:Subject:Date:To:Cc;
	b=KiFuzHztMqofIiZrMZL8fYbB6wSoXNh9lrzLqytt9ShCyoXK17NycQJvKaritlYqJ
	 Byr6sYJXXr1aQAV2f282/CzvQJLdthXfVBi2iGJix3taoXgc22/Lo7NPZ4pmDhLXQ+
	 90U/cnBJ+w+ETIgL0+7vxJkLvv387n4a9zLXeeFHyvbDhOGrnSREqM83SDSXDag5xZ
	 usx7k191FHqo4J1+Q+F9y9CSFyN2mDTi3GHELGDP75y1r9q6SJBDYZ4AZzsXbVj39G
	 8Pbs4822z73V4lU5LVSrfCCwP2mhXCK/R62yvxpDGtF2ZvKHTO9wkcsLtIkWsi/1lZ
	 X9r2APu3NuKzw==
From: Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH bpf-next v3 0/8] bpf: Fix ring buffers and add a libbpf
 iterator
Date: Fri, 20 Nov 2026 15:33:13 -0500
Message-Id: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/32QzQ6CMBCEX8X0bE1/sIIn38NwoO0WqqZgWwiG8
 O4WuGhiPG5m5pvdnVAAbyGg825CHgYbbOvSwPc7pJrK1YCtTjNihAkiKMeyM9hbV8veYGNHCBi
 KKpdcCcqOEqVc52EVUuyKFruDMaJyU0Ivb6Digly8jQ2x9a+1fqBr4k/TQDHBIBjPcqrkiWWXO
 3gHj0Pr67VgYJ+I/BeCJQTnRgPhhdaGfyHmbUkPzz59Im43lPP8BnhAaaEnAQAA
X-Change-ID: 20260613-bpf-ringbuf-fixes-e9a8b3c6125b
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>, 
 Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Tamir Duberstein <tamird@kernel.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5984; i=tamird@kernel.org;
 h=from:subject:message-id; bh=WkH6CszC1iT8xCL8zMXL0SlhHk4AwMQ8A12AjbhYu7A=;
 b=kA0DAAoW0EwOJRfXEpcByyZiAGsArpmiaMsfEVnp58Kvg2eZFWVCW/jRVeo6dbzk/JJ/ziOlV
 4iRBAAWCgA5FiEEYRXCvWdl27wdae7H0EwOJRfXEpcFAmsArpkbFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMCwzAAoJENBMDiUX1xKXXqYA+wQxGvCMN/hZFBBPOk7h3Lqoms0mDNXheBGVDDyLfR6
 6AP0a4FA+X/GOkMvZmVkyaky1UdDN+LxxJnFcXJX/23nXAQ==
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

The ring buffer API exposes records only through callbacks. Callers that
need to stop at an operation-specific condition have no non-error way to
end consumption early.

Andrea Righi proposed using positive callback returns to request early
termination. Andrii Nakryiko noted that positive values are already
ignored and changing that behavior could break users, and suggested a
new API:
https://lore.kernel.org/bpf/20240310154726.734289-1-andrea.righi@canonical.com/

Discussion of overwrite-mode consumption identified an iterator as a
better zero-copy interface than callbacks:
https://lore.kernel.org/bpf/CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=uByFSup31FMA7hw@mail.gmail.com/

Add a caller-owned iterator for consuming one ring buffer map directly.
It returns one borrowed record at a time, allowing ordinary loop
control. Each next call ends the previous borrow and lets the caller
choose whether to publish consumed records or defer publication for
batching. Existing callback-based consumption uses the same internal
iterator core while preserving callback return semantics and per-record
consumer position updates. Callback-based consumption and public
iteration of overwrite maps remain unsupported.

This v3 targets bpf-next/for-next. The following patches from v2 are
omitted after rebasing:

- 1/8, "libbpf: ringbuf: Honor zero consume bounds", was applied as
  40edacd47993.
- 2/8, "libbpf: ringbuf: Prevent NULL callback crash", was applied as
  c0628a0659b6.
- 3/8, "libbpf: ringbuf: Reject overwrite callback use", was applied as
  f756eedb24d4.
- 4/8, "libbpf: ringbuf: Handle position counter wrap", is superseded by
  Israel Téllez García's independently developed fix fdd4fad0bbbd.
- 5/8, "bpf: ringbuf: Handle pending position wrap", is superseded by
  Israel's independently developed fix 6ff5b56a50c5.

Patches 1-3 resubmit v2 patches 6-8: "bpf: user_ringbuf: Handle position
wrap", "libbpf: ringbuf: Use compiler atomics", and "libbpf: ringbuf:
Prevent missed wakeups". They fix native-width wrap in the kernel's
user-ring consumer and a missed-notification race in libbpf. The atomic
conversion provides the portable full barrier needed by the wakeup fix.

Patches 4-5 add the caller-owned iterator and simplify its traversal.
The iterator preserves the wakeup handshake when destroyed before
exhaustion. Patches 6-8 contain the selftest refactoring, wakeup
regression coverage, callback-semantics checks, and iterator tests.
Selftests follow at the end, as requested during review.

Andrew Werner found the counter-wrap and missed-wakeup failures while
implementing Aya's ring buffer reader. Aya's original implementation
contains the equality reasoning and edge-triggered regression test:
https://github.com/aya-rs/aya/commit/e2cf734490bc188bcedb1eac92d23d81123e42cd

Aya later fixed the consumer ordering with an explicit fence:
https://github.com/aya-rs/aya/commit/7277a57ea8cdb74918d3096a4b22b6d814481973

This reroll continues the ring buffer fixes series and brings the
callback-free API into the same submission. The original callback API
proposal is a related submission:
https://lore.kernel.org/bpf/20260611-bpf-ringbuf-callback-v1-1-c32b6cb6ce40@kernel.org/

Review requesting that callback validation and the new API be discussed
together:
https://lore.kernel.org/bpf/CAADnVQLuNSE5AM6Cqzs4yDFrhTyD=j-y5dfya3dLwk3si9v26w@mail.gmail.com/

Earlier versions were developed with Codex (GPT-5.5). Codex (GPT-6)
assisted with combining the series, addressing review, and revising
the iterator, tests, and changelogs.

The libbpf build and BPF selftests have not been run.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
Changes in v3:
- Combine the remaining fixes with a new caller-owned iterator and its
  tests, targeting bpf-next/for-next.
- Drop v2 patches 1-3, which were applied, and v2 patches 4-5, whose
  issues were independently fixed, as listed above.
- Preserve -E2BIG for oversized user-ring samples when validating the
  advertised window.
- Move the fixes' selftests to separate commits at the end.
- Simplify the wakeup fix's bound and error exits while retaining its
  fenced busy retry.
- Keep the compiler atomic stores on single lines and follow the BPF
  multiline comment style.
- Link to v2:
  https://lore.kernel.org/bpf/20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org/

Changes in v2:
- Fix additional native 32-bit wrap paths found by Sashiko review.
- Explain modular position comparisons and leave mixed-bitness ABI work
  separate.
- Preserve the wakeup handshake across bounded and callback returns.
- Follow BPF comment style and simplify wakeup test cleanup.
- Link to v1: https://patch.msgid.link/20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org

---
Tamir Duberstein (8):
      bpf: user_ringbuf: Handle position wrap
      libbpf: ringbuf: Use compiler atomics
      libbpf: ringbuf: Prevent missed wakeups
      libbpf: ringbuf: Add a caller-owned iterator
      libbpf: ringbuf: Simplify iterator implementation
      selftests/bpf: Refactor lifetimes and test wakeups
      selftests/bpf: Verify ringbuf callback semantics
      selftests/bpf: Test caller-owned ring iterators

 kernel/bpf/ringbuf.c                               |  11 +-
 tools/lib/bpf/libbpf.h                             |  90 +++
 tools/lib/bpf/libbpf.map                           |   3 +
 tools/lib/bpf/ringbuf.c                            | 187 ++++--
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   | 660 ++++++++++++++++-----
 tools/testing/selftests/bpf/progs/test_ringbuf_n.c |   9 +-
 6 files changed, 757 insertions(+), 203 deletions(-)
---
base-commit: 82cc2b4383e3edfa1026c8612fb4e90a9329ba11
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
change-id: 20260613-bpf-ringbuf-fixes-e9a8b3c6125b

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>

