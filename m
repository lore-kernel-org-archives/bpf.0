Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704705;
	b=no/7otsHxQRU1JJSv2In2yymlZRLcd/CJ736put6XznXrTRm8TsAy4l5eChxU/YDRTTA
	 TmWZfK2DQCj7J0JdmvieMcOrMO/BdGtUt5iRpTN8FHR2w1RjHK23nggNi7dXHUN90Et0J
	 bH2RMbFwOK5ZekPIZRCr6ECW/8RIeDis+DBz0HdZ3P1Y0gEjLyd4P8Xorvwyda6Y73jGK
	 2W9K2tucWULtrjAhDje27HLO15fRSLwhIZzRcwgNjqM84IJPCYZ6m/5gH/YeTquuaikph
	 A4MyiKuPhLa9lop35WqJm5QGtQFEnFZj2DE19CxHQk2gt0kGOzBB1WGc8ZtYLUi58Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704705;
	h=DMARC-Filter:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc;
	bh=EKGkWs2BqjTVgLXpUq59xjqWwipTxO9E9PqiEQmi3Zg=;
	b=fr12TMFVo4fI0ouZri4RESKfLijKU84cx84EOvH9T6DvSZtdy1eOzXw5dNb/Il2se1yO
	 xTvi5K8g6oIVWQqZZ4dEm6Dqpe5uGQ8KsBbll5oUVPVAydSRmh/NA/j3MfV11xoXK7y8x
	 dOs5pw3GKJ+DKiEpfMdmh8ig52C2rmRxzRTE+0uq138MxoRichnRbH1vn6xN5TXrwrjtR
	 qeebKmJGXZ00IUtgUbxNexT6LsLbjOxx2sXs54MakVatZM+hnI+XzBUDkal7seu5mlUmz
	 MxCSpR/9qNMWk/E4RZ8k6obxgUuohAFBMS9JQzFnFLt7F3MhbCNciD2cBa/Chv4OcyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=lwpkLcPC;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DC606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 758DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=lwpkLcPC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795704702; bh=Tql6vJLE49/vW0jsmkSW9QxXstcWhIobAspWyufv+1w=;
	h=From:Subject:Date:To:Cc:From;
	b=lwpkLcPC33H4iasupLKAjUp26pORwsx7aMkhExYbXlsCJb1zLDkYqkIvQCmJ2bYj8
	 0fWe8QDJPQVBcjyil/07g1ca7ksl9CCtaeCxDpmcFbxiZZ1AmZqJwJiXIqhu4yquZs
	 ecjTnIMpikCupNSXLa+XkWbfJKX57SfDucc7hD9RqpKJRjNjKXsf7svNLlkPb6CHFG
	 R47CitdwWdtBL4EXFrhz/BjH6cz1zabya+ufwPFFeWDGVwgrDPfZwOvUnwVAVlAXnj
	 LxO3sqZ4eA26wTCCzpudaDcbULwRckEzoCXqvo2DsRuEjXxLPVNDkZnl1bAEDqS1gq
	 FrE5fpL67jKLg==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH bpf-next v3 0/7] Improvements to access module BTF with
 bpf_token
Date: Thu, 26 Nov 2026 15:51:36 +0100
Message-Id: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOQQ6CMBREr0K6tqb9CAVX3sO4gPILVQOkrQ2Gc
 HfbutANy8nMvJmVWDQaLTlnKzHotdXTGER+yIgcmrFHqrugCTAoOWMlbWdFDT6bhfbo6IiLCwl
 adgyKKs8RUZDQnQ0qvSTulcRKDJLb17Gv9o7SRWzMDtq6ybzTBc9TI61xKHbWPKeMnmouCgAhK
 6kubnrgsXukBQ//jL3HHgKD5TXWIAqhavljbNv2AQj3aggYAQAA
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
Changes in v3:
- Update the comment on CAP_BPF in capability.h to match the changes.
- Unset obj->token_fd in bpf_object__gen_loader().
- Remove redundant bpf_object__prepare() in succesful test and update
  comment.
- Link to v2: https://patch.msgid.link/20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk

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
 include/uapi/linux/capability.h                 |  5 ++-
 kernel/bpf/syscall.c                            | 33 +++++++++++----
 tools/include/uapi/linux/bpf.h                  |  5 ++-
 tools/lib/bpf/bpf.c                             | 45 ++++++++++++++++++---
 tools/lib/bpf/bpf.h                             | 16 ++++++++
 tools/lib/bpf/libbpf.c                          | 25 ++++++++++--
 tools/lib/bpf/libbpf.map                        |  4 ++
 tools/testing/selftests/bpf/prog_tests/token.c  | 53 ++++++++++++++++++++-----
 tools/testing/selftests/bpf/progs/priv_module.c | 15 +++++++
 10 files changed, 176 insertions(+), 30 deletions(-)
---
base-commit: 486b5ce7184f7449ef2fe1e951455b0b8a114060
change-id: 20261006-bpf-relax-get-next-id-6d025833eee7

