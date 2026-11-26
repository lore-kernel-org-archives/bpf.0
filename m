Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699270;
	b=RBZ298MHFf46Ht6+F1POZl31u78+uP7iR8IHwcrq+pi3iGCRrh/0oqYP1qlUuTf+zil8
	 l4uLg9ZnLyqjG1vgsho+k9B7fhtolrVsULYz711mcXdFsfSxgApwVf6WtbWPGRz4Lecok
	 U2zLWmeA3o4QgaZu66EBXZt25vVIH8k5PI/dt6EbZ7bcn0a3G+9yKKDi502G1Jnb/dFkZ
	 ewmcGjYzEiWLzynYIlbG4DlvJgw3UPTYbWTnusk3LIDlkHyAKo46yet/6uqFesqMaWTGq
	 gf+NchwE3WmWnNwdCiZW7JuATvEsrPHULDcPfaic6tZ1PJ9Ifdlg+zP4tkYJmSv4olA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699270;
	h=DMARC-Filter:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc;
	bh=jdHSj1Qi5RBFUrwGfmFP24btKO4hMdFUerUokhrBDm4=;
	b=cMaqyZTGdxKbybLSlhjTAvg5BYQHMU05M1+EIOjWPCcxBwlp0TjAQuNv8wk1nr56tLSk
	 v5q+dyOtELlvYY/62Bbhvi9Qt0TuXGuKbBq/w0sfI7Hr7YsJbd+Ryzp6mnLucig0yQPkU
	 cMycfiuMx9O8aSo8Dx2Mlw8u9RrSush6ljhEM/aa/QwpJgA5blXP3j0UkuytRSC8xbBin
	 8tUGdni5880gFfwXrF9y7CHYv1VUw9hquSv5G7WBBZdHuy/x+WivhsybRZnra2Z4CT4T/
	 4zomGeq4Bwrdv485OWo4t12kketHg2PwrnzUAigGsFsjzP4Ql9pW10F55MbsSQhRZIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=wQMwyZ9K;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A36606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73A36606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=wQMwyZ9K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795699266; bh=fM+pQjRqJBWriYtY0bWtJHKUZkmJwZtbkLlOCypyVI0=;
	h=From:Subject:Date:To:Cc:From;
	b=wQMwyZ9KOMLkP5hckqNz2rKw0p0G8l+Gz6F8nj39WDvnYU67YjXVd2x7YPtVYlpJq
	 pVXqesJ2vu/du5bE1+W1kmCihV++oLE33gw9Gxr1ch022o+FWqnSzeDJAUloUydP0p
	 Umf/vDplJgy/COWU6Ak/28sip0kinINUDCfaoiaoKdUSHlebQkNnoLcv0L5A23zLdg
	 QP6+E7UyFzA1GmMvBB3oFB+7QUHYE8TmDpJ8124+H/A2dHX3PCd/k0JnneDaxJSl2b
	 MvE4X0+Q0d6IVDhqANUeRuLFpAgHqBchGotEov5ID6wWLjgXN+B0yhiFFtcaqUCrSC
	 Iv2zBM9xg+S2Q==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH bpf-next v2 0/7] Improvements to access module BTF with
 bpf_token
Date: Thu, 26 Nov 2026 14:20:58 +0100
Message-Id: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOyw6CMBBFf4XM2jHtIA9d+R+GBZQBKgZIWwmG8
 O+2de3yZs65d3awbDRbuCU7GF611fPkA50SUEM99Yy69RlIUC6FyLFZOjT8qjfs2eHEm/ME5q2
 grExTZi7Au4vhTm+x9wFBCSBUv4t9N09WLtQGdtDWzeYTX1hlNOKapOzP2ipR4OUqi4yoUKXq7
 m4e+dyOUB3H8QXR2b6B1AAAAA==
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
Changes in v2:
- Pass the right struct name to OPTS_VALID in bpf_get_next_id_opts().
- Add the new symbols to the right libbpf version section.
- Reorder permission checks in load_module_btfs() and check for EPERM
  after bpf_btf_get_fd_by_id_opts().
- Assign empty string to the bpf_token_path instead of '\0' to disable
  the token.
- Rebase on newest bpf-next.
- Link to v1: https://patch.msgid.link/20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk

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
 tools/lib/bpf/libbpf.c                          | 20 +++++++++--
 tools/lib/bpf/libbpf.map                        |  4 +++
 tools/testing/selftests/bpf/prog_tests/token.c  | 45 +++++++++++++++++++++++--
 tools/testing/selftests/bpf/progs/priv_module.c | 15 +++++++++
 9 files changed, 167 insertions(+), 21 deletions(-)
---
base-commit: 486b5ce7184f7449ef2fe1e951455b0b8a114060
change-id: 20261006-bpf-relax-get-next-id-6d025833eee7

