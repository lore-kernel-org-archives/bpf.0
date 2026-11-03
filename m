Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698447;
	b=owoB2DAUQPFbr5tQ4+87rYniS3rQwwxQUr9qLAmOY24p4DWdsSbpTb6bAFmWUdqasHVo
	 kq5d33Ep0rOPxCmfh7XPgFY6m6lQiEm19WYyoiTfJ2HLQv0KoLIUFPdt+E7QpYhXKekQQ
	 mT7MyygoVz8AgjsG8Skhd1RmFwJkO9RmqIxJFv+NWwPmoCELnJOnI1bWOrgkwaZld+QlT
	 2DRlFf7HogatpD2ZtgtNbE0TCjtSFZY1hlrtHJAdqjxePwpbBKjiji/AxHaTgN+xENz/+
	 B17CyD5aaLLspsjX2lDVXmlpZdZ2zr23+uMPX/6m02M0bI7JI+Hv++ykklo4mNAeEog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tKeRMaARI266dkZvEtgJ4R9QgctSM3JHKtwlfdDcKcA=;
	b=RGIXXeekR9h0kiFsJYO6c2gKlRVfn11T9PwWQd4iUgsjwamOM0ZN+oN25bt9r0F6asl8
	 eHjYJEb7iuB8fHltiChrRPE2lt6s037ew28VdjMv5cqTUPY+OOqlbUwKbHRtO+bj7okcd
	 yzseTLTsCsCTqlb9y4mO/UuowLeDm1P0y7DTKG6/KmvpGIoCysFenvdv48XnWIVfzlXJY
	 e5vSsNVWtJMzrdQ4oIXHQX5XRMhGGWoIFmkiJeEJEf7CtTR/a/Ya6JbwrgkSUoWukY2oM
	 WWBWzJK4waL+bs9mhvwC8/Ua1pSBK+Z2xgiGrOzqRAGHYAF8HUgZ+qhIyfDWHk0taAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqZzr+5v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C15606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqZzr+5v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7997C1F000C1;
	Tue,  3 Nov 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698447;
	bh=tKeRMaARI266dkZvEtgJ4R9QgctSM3JHKtwlfdDcKcA=;
	h=From:To:Cc:Subject:Date;
	b=kqZzr+5vYqZOx71JMq8yJpHOOL2LFtdL8ERas9uT2a88Bc2WEYDCd0NdyrfBQF5KT
	 tyS57jdmfLGvjkLBvvRYxu164HJ4nydfp1ANgBkD3OwuAIfuP98RZ/2CgTAKISmlIs
	 0wFgH/O2SXQaMz5yedIxK13XUt8vve+blmUzOr3T8ERHifzlWLKLjGhRmj1vugoMe/
	 pA8VsaDHk6nX8SBj3PCesQjxR0NU/A4nnc8F1b7uwRI294neukRCM7c3B/RN1kH0/l
	 qAGGLgTIosYATGHUIxr55ROiXV5OT22gxacc4ol3xYvnxRaq29/GCjBp3pU7IAjDwH
	 jFJQ/eWkal1CA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	HyeongJun An <sammiee5311@gmail.com>,
	Christian Simon <simon@swine.de>
Subject: [PATCH bpf-next 0/4] bpf: Disable private stacks for uprobe programs
Date: Tue,  3 Nov 2026 10:33:56 +0100
Message-ID: <20261103093400.112178-1-jolsa@kernel.org>
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

hi,
uprobe programs can be preempted and re-entered on the same CPU. Since
the private stack is shared per program and CPU, a nested invocation can
overwrite the preempted invocation's stack.

Uprobe multi and session programs have attach types that let the kernel
identify them, so this series disables their private stacks.

As discussed in [1], there seems to be no known compatible fix for
private stack corruption in standard uprobes. This series leaves that
issue unchanged and adds the BPF_TRACE_UPROBE attach type for new
standard uprobe programs, allowing the kernel to identify them and
disable their private stacks.

Other possible fixes for standard uprobes include:

- disable private stacks for all KPROBE programs: protects uprobes,
  but may reject existing kprobe programs that rely on private stacks.

- reject untagged programs on uprobe events: protects uprobes, but
  breaks legacy loaders that attach standard uprobes without the new
  attach type.

- disable preemption while the uprobe program runs: may prevent overlapping
  invocations on the same CPU, but cannot be used for sleepable uprobe
  programs and may increase latency

We can pick the uprobe-multi fix and keep discussing standard uprobes fix,
I'm open to other suggestions.

thanks,
jirka


[1] https://lore.kernel.org/bpf/20260822225444.2774461-1-simon@swine.de/
---
Jiri Olsa (4):
      bpf: Disable private stack for uprobe programs
      bpf: Add BPF_TRACE_UPROBE attach type
      libbpf: Detect BPF_TRACE_UPROBE support
      selftests/bpf: Verify classic uprobe attach types

 Documentation/bpf/libbpf/program_types.rst      |  8 +++++---
 include/uapi/linux/bpf.h                        |  1 +
 kernel/bpf/verifier.c                           |  6 ++++++
 kernel/events/core.c                            |  3 +++
 tools/include/uapi/linux/bpf.h                  |  1 +
 tools/lib/bpf/features.c                        | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf.c                          | 21 +++++++++++++++------
 tools/lib/bpf/libbpf_internal.h                 |  2 ++
 tools/testing/selftests/bpf/prog_tests/uprobe.c |  4 ++++
 9 files changed, 59 insertions(+), 9 deletions(-)
