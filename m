Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074383;
	b=qxLYHnoQ+TIGqJY8wv75P6obUIMGkCrPd4L9tcytFWqE7ab6o0qXcUiJHpR45KwuD0no
	 5Q+0en7Kc9+4ikCa5HeWofZzloiUG9j05TS46Ty+lzAhLGojuHv3lVM36A2DT00dUnvZR
	 K8iGk3f+c2wh5E+UyHRogG6qkvSBPfV7d6pcGqhfuRn4LV6lFnoOVIanek+XCT0c/jNSK
	 pkg/n3WEd47KiFIHt8pDUE2rqzEu2xqd+tvQUl5xSAy40BbI48MIbV4ahTGnv/wf9ugQd
	 dvs5W/Nr14NDkFVJhoMLZCoQWuJo3NwPdg2cKpSA57pAY/Pmw16i6UelK1awcoOg1eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074383;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=8lVLvxc8Qs6BngpHaRFwnA/hdSpn+KLdbrSSp8PidEc=;
	b=1vxedvK3bOm31p9mMZYzp5Si8ROI7DF9DswqVZNGfKZuK1pJ1yyFbR26dfYt79gEBCB7
	 mk08YN4M81MnEX/ZgM+WWHpVC4bfQkYrlt8+gTDkSHKG3NgzJUwcXiQvF8tzcylqkEDrf
	 KJTiM6EOYjQ5Qh0rVu8thE8suhr+/UCkjbR1itzpBCAnjOgehvpcwnT5+U4hUogrqyKEi
	 oK+Tdx7YZkGuFowLDtFKNMKRei78/TS8kBS1WXkfcfPY+1k11ACtz6UkFJkwopVwEC3yt
	 APC1VVo8Y7iEQyQqJOJDFOSlsUhdbXzbPJ/xaYP0Hrq3GW7caSLHybhaFabE7AyXy2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E4606A32E;
	Sat,  7 Nov 2026 17:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A25E4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhN-007j5e-4c; Sat, 07 Nov 2026 18:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=8lVLvxc8Qs6BngpHaRFwnA/hdSpn+KLdbrSSp8PidEc=
	; b=inpLAybUUeGEXVpxpjf2xkIg/S8TV16mUpOyCBS1FjTk0Ae7d+3SYOqHNxhi+qwcnSEhXie8N
	Wm7dOcChwdhYCegGVfc4ML8ZKqz6RbnBcbiAV6766WYadGmRHP2lNRIMvcKnWE6lMoDO44kNav1OI
	BMOjNr/W/Ic2AmYZQLyIC7y8y59GNoi0ER+BkM/FYRsmdP2fjaJRaxtzEvoCVq41R3b/gT8BnMG9I
	nAqMJ+ZpxhT7nENW2OGq+Ks/qzWeZGDZIEaajt8rJY9eDtWNPir4U5vs73VyNLtq2HpE9lEMAeMWn
	j6bayALldb+08aGxMLa859NJWFnpFpSc1ZwBsw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhB-0006ai-A7; Sat, 07 Nov 2026 18:59:17 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkgy-007LnK-Th;
	Sat, 07 Nov 2026 18:59:05 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf-next v3 0/8] bpf, sockmap: Restrict iter-context
 sockmap updates to sockmap iterators
Date: Sat, 07 Nov 2026 18:58:22 +0100
Message-Id: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw6CMBBFf8V07Zg+pFhX/odx0ZZBRoWSthCM4
 d9FXLhzeXPnnjMvljASJnbcvFjEkRKFbglqu2G+sd0VgaolM8mlFpwfIAV/b20PQ1/ZjPCgljJ
 QxggVV2hlUZuyLNiy7yPWNK3sM3N9DR1OmV2+TRrcDX3+oD+3DaUc4nN9YxTr4msU+o9xFMBBq
 tqava5cYfAUXZh2PqyWUf44gst/HLlw0Girld8rp8yPM8/zG0I5NR0kAQAA
X-Change-ID: 20261008-sockmap-update-limit-iter-d03ea25f9775
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

Follow-up to Sashiko's report [1] and the decision to restrict which
iterator may perform sockmap updates [2]. Series started short: remove
about-to-be-stale test, restrict updates, add a negative test. Then it
expanded: mark bpf_iter__sockmap::sk as PTR_TRUSTED, restrict
bpf_sock_destroy() callers to iter/{tcp,udp}, few little tweaks.

[1]: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
[2]: https://msgid.link/87echn2fhd.fsf@cloudflare.com

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- Drop RFC prefix
- Update bpf_iter_reg::feature docs
- Fix tcp_request_sock BTF build error
- Restrict allowed callers of bpf_sock_destroy() to iter/{tcp,udp} (Alexei)
- Link to v2: https://patch.msgid.link/20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co

Changes in v2:
- Commit 7cc639dc45c5 ("bpf: Don't take an extension for an iterator
  program") and commit b83bacf2161d ("bpf: Don't take a program with a
  target program for an iterator") landed. Drop the redundant
  env->prog->type check.
- Mark bpf_iter__sockmap::sk as PTR_TRUSTED (Alexei)
- Link to v1: https://patch.msgid.link/20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Shuah Khan <shuah@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemb@google.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
To: "David S. Miller" <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org

---
Michal Luczaj (8):
      selftests/bpf: Remove sockmap update from bpf_iter_unix
      bpf, sockmap: Restrict iter-context sockmap updates to iter/sockmap
      selftests/bpf: Add negative test for sockmap update from non-sockmap iter
      bpf, docs: Document BPF_ITER_NOSLEEP
      bpf: Restrict bpf_sock_destroy() to iter/{tcp,udp}
      bpf: Mark bpf_iter__sockmap::sk as PTR_TRUSTED
      selftests/bpf: Add iter/sockmap bpf_sock_destroy() negative test
      bpf: Fix "unresolved symbol tcp_request_sock" build error

 Documentation/bpf/bpf_iterators.rst                       | 12 +++++++++---
 kernel/bpf/verifier.c                                     |  4 +++-
 net/core/filter.c                                         | 15 ++++++++++++++-
 net/core/sock_map.c                                       |  2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c         | 10 ----------
 .../testing/selftests/bpf/progs/sock_destroy_prog_fail.c  | 11 +++++++++++
 .../testing/selftests/bpf/progs/verifier_sockmap_mutate.c | 14 ++++++++++++++
 7 files changed, 52 insertions(+), 16 deletions(-)
---
base-commit: 2d0b457611c06304138754a05e0873cc18acfb7e
change-id: 20261008-sockmap-update-limit-iter-d03ea25f9775

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

