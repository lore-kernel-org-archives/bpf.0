Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620800;
	b=Kn1Ohpu5oThTvd5xqHBp9yCxb1cjrI7X65D183r0rXGJ7MBm+0DSaJKmiSvywNfgV47g
	 7rmSrBStG3O6ck+8qeyE2RGq6B4TZN9h0gW+i2zi/24v4JjhI6+JZnT30wJJeTm9i4+5G
	 On81c4Uk0UKTFBDETIvX0uMwLBZv6BN+iVPBaBrxIEeSfhospPoem3mm1JqW8NKOKEBzw
	 y4YYiqVcieyuOovspUUpmHXdaw3D1qC7jyJhf7wup5lhX8vQCtRir8ugQQfl+hg5ZaWEW
	 oPwIiQmTCXU/tmk85+fS46qigZlUi2yUqvFw3TtT/uV0bp4ziOcodp9oMjURMPVfQmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620800;
	h=DMARC-Filter:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc;
	bh=VIngtmvYAfQx6t8S0CNGMt1Lj6+CSRhnwRNSXj9mwZA=;
	b=qubDh/MWSp928aWHRvxX0M+VbnMoSHA95Ffwo/sFCuy3MHTLuvLLsA5GvoW0eAAJPR1V
	 rjdRUKIJZF+Uhf+JPGC+EcHyzBpPsofC6IVcc4rzDIwf7dWof8CXS7Tda+qGF7K0YRrJM
	 l9AOe8OQjXegByKEpIDQofyThFcvzf8tdEy3XFnfqVNYTfMKHNJ0L/lsZeskNchmOJIcS
	 zgG7wUzUE3t0eBGMtBE1pLg1vxfQ7l+rA7i1e3hntx891x73/ZXUxCE+vBHzN2Kxgwcit
	 ihtOG00/RGBics5oXHK2BICmVRy+MHzCEerAOZ7Zd+dZne+zZ0Z6bxf/HOYG4UYKhnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=dZi6CK11;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87324606A32C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87324606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=dZi6CK11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795620791; bh=i4781u62HvMbS4aaDLFZtNqZEy3BMtxiWvrkjWRJLBg=;
	h=From:Subject:Date:To:Cc:From;
	b=dZi6CK11/S9izIIwhjuws87Aw1IK+zr+wL1b7nZQGMsZtYCDEbfTZNBW95wjs5/Vw
	 7Trv+jL2jNl1/5de0vDJ998Vr2ntFiXvBPSgP/XNrL5h6FL2vHwAOldZmIPbv9McqD
	 ZsK3VFPXyX3G2aEGYRmIns/r4UqvUxOo+VYeO+lK/2eSRtbzJzGSM8AZBrGGFSYuPV
	 LTuOUbk5cqpJoRoXp7Z3/xFocSkfVX0augVY+LGTD1/Y+AjDY20tjYrYSuPguYOH2V
	 joiMycuxVWXvKyIpTFEiEKXKdKzch3GvD7oyZoVsl4+LVh+WapkQzYIi1T9vAtYsk8
	 I9nrV9vtJgHAA==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH bpf-next 0/7] Improvements to access module BTF with
 bpf_token
Date: Wed, 25 Nov 2026 16:31:51 +0100
Message-Id: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2wrCMBQEf6XsswfSFKP4K+JDL9t6RGJJogRK/
 91EH4ed2Q2RQRlxaTYEfjTqyxdoDw3Ge+8Xik6FYY11rTFOhnWWwGefZWESz5yKIW4y9njuOpI
 nlHYNnDX/fq+oSRVx+y/xPTw4pnqLff8CU2rlFYMAAAA=
X-Change-ID: 20261006-bpf-relax-get-next-id-6d025833eee7
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>

This series helps seamlessly run an application inside a user namespace
with a bpf_token delegation. The need for these changes was discussed at
my talk at this yeas's LPC:

https://lpc.events/event/20/contributions/2441/

The problem the series aims to fix is one we discovered while developing
the bpf-rbacd application discussed in the talk: when delegating
permissions with a bpf_token, a libbpf-based tracing application works
seamlessly when it is attaching an fentry program to a function that is
in vmlinux, but fails if it tries to attach the same program to a
function that's defined in a module. There are two reasons for this:

(1) When trying to find the BTF ID to attach to in the module, libbpf
    uses the BPF_BTF_GET_NEXT_ID command for the bpf() syscall, which
    requires global CAP_SYS_ADMIN.

(2) Even with the issue above fixed, libbpf does not have the token
    available at the time it does the BTF iteration.

The first patch relaxes the kernel's permission check to make it
possible to iterate BTF objects with bpf_token permissions, fixing
issue (1) above.

Patches 2-5 changes libbpf's behaviour around accessing tokens so that
token loading is done on object creation instead of on load, and passes
in the token when iterating BTF objects in the kernel, fixing issue (2)
above.

Patch 6 updates the selftests to correspond to the new behaviour, and
patch 7 adds a new test that checks that we can attach fentry programs
to module functions inside a user namespace, which was the original
issue resolved by this series.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
Toke Høiland-Jørgensen (7):
      bpf: Relax BPF_*_GET_NEXT_ID permission checks to CAP_BPF and bpf_token
      libbpf: Add bpf_*_get_next_id_opts() functions
      libbpf: Automatically set BPF_F_TOKEN_FD when getting BTF fd
      libbpf: Move bpf_object_prepare_token() to object creation
      libbpf: Pass in token_fd when iterating kernel BTF objects
      selftests/bpf: Explicitly disable token in token/obj_priv_freplace_prog_fail test
      selftests/bpf: Add test for attaching fentry to a module with bpf_token

 include/uapi/linux/bpf.h                        |  5 ++-
 kernel/bpf/syscall.c                            | 33 ++++++++++++++----
 tools/include/uapi/linux/bpf.h                  |  5 ++-
 tools/lib/bpf/bpf.c                             | 45 +++++++++++++++++++++----
 tools/lib/bpf/bpf.h                             | 16 +++++++++
 tools/lib/bpf/libbpf.c                          | 16 +++++++--
 tools/lib/bpf/libbpf.map                        |  4 +++
 tools/testing/selftests/bpf/prog_tests/token.c  | 45 +++++++++++++++++++++++--
 tools/testing/selftests/bpf/progs/priv_module.c | 15 +++++++++
 9 files changed, 163 insertions(+), 21 deletions(-)
---
base-commit: 8dfce13340aeba06d1b68cc7648f37762244be65
change-id: 20261006-bpf-relax-get-next-id-6d025833eee7

