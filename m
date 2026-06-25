Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0213AEF35
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385413; cv=none; b=RCN38cHaiLnevzFwlb/SavTap3wG5yeGDapRY8L+1O/n8TGO4kOH8nZVbl+YKjCyFOT3vNWdlRLzHeoyWNEGrQVdEDURuhDzS864aprcRQo37DDV9nboZw+U2fQP1ZDmPSwr211t3bfSUJU8dy4L8BgPPya+OIFSUBRl29pkwR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385413; c=relaxed/simple;
	bh=M6XVmr9mr5hJbI6edN8tmTU2+YZgewGU2AkbPE+1Wxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jP+PL/fFKzox073haKMkOBLDT1yu7WGBH9lsvug06eQqo8tLbLKu10p0/HkLEx+GYnIPyRD/wic/X7vo4QAtZixAXUG089WJMowvEd0gA8/UTPkhSk5fcyCbFwwLRuR+0v6MScPR4ee6JGiO0PJUwAhbTOwRUFjOrLbxgKTsEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s41UH2vV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s41UH2vV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4924f8db066so12079775e9.2
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385409; x=1782990209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6M3A8+RJOXUSQAAq5YZ2iZRz2yh0XwXW9SyNNKOE0I=;
        b=s41UH2vVMAz8aB5JuhtVv5YMRJ602VGXErVNc2xxx/Kahu14vt7FiTGXmC8ps3/nWM
         4rqC6VT2KZcQtvsgee3u8+sQvsO+aYKI81O9wS4HogGcQUvZDyVXz76wf0+5gxb9Bi5k
         YU/avjOBAtNW/NI6Kc2Zo2W+SM0jS6e9v3fHd6gE+P9czlIZQe7Hm/KGAiz1D3IGYTsG
         wFNNnOIi7kFz91rx14Xky/ADiVTW+mS4XC6mPB2Ux9QnPksYZEPfZ6VhaCtw/BnrG74r
         Yx+tYfzzyMssRlTjFeog/zy6RssyqKvRSqNRietdWK6JGCnJPOgrE2Za+k4VIsLvFzlg
         BnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385409; x=1782990209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6M3A8+RJOXUSQAAq5YZ2iZRz2yh0XwXW9SyNNKOE0I=;
        b=Z8EvatE/7X7OkI/dsVeZPSxFXw3FWOvfRlEYRdFzPhFv4uADt2fJEyq5ZMZubSbakd
         byQBtwF9Sj6CKTj2HUJh0AlvGrENdlYyoloVdAdgn8BkIhcxLKAL7+iGhuANnij3v+PQ
         37aLa5O3o8xFwBNjTk6sHpwjbATUcpcpPVjg8FxgRWg25RmvxB71Ff2OL6h2cjMN1dFY
         TuS685T17m6I1CcGu4s6tx0r/YGQrA7WCVUO45znTRDtGQvYW7BTBFP5LA/KnUFzqopA
         onZJLJ5TRvaKmUeCftrNAWIneBLy07hHKtCYZHbzf4Pm1TqvFMF9M3fyt00M60aR4zI6
         E3ug==
X-Gm-Message-State: AOJu0YweS/9pIsVO4ea5KSeHxa42Xhefd2ILgfzPJCFEqWevmUxB7pNd
	B5dqumqz12rt6uiBLP3hTVKmB12iK1iEwwzdy10ye8vv5ZDRKVhmuFeS1NKcBDELqOQ=
X-Gm-Gg: AfdE7cnrNpR63RqwVZRJ0KAZlzFw0uBQiojczlES6PtPudWlCYZzp++oVeeoOOTKHSw
	EOZvccrasBYit2OOyiC5Q1F5pDataWLckeeFQTAVZ7wgCZowp7G6TihSQREyHdHrWeJjGgJpeV/
	ZvJNZSgyyDTtGC+RFSSYjRYi1CzvkTrbWlhtlYlp2Wg1TNyiTYnKqb7yaGa15KNdlAP6mStqYLP
	hiqJgAtqAbuX8qow3nMo55QQPb6jmrGdO/0/1kXYyi/EY2uHYcESHW9ug7H0kE0Ih1tdJ9JvE+n
	oV03s6kITDqDHiEgkMW5ZJYafsR2a+eyzLjrsqUQ4nfbPsWp4KV2U9O3iEp/JQ45Wb4QG/6iKNM
	JgO56g8AFVigexHEvmhsxFZ9AaXr99Gb3UZj3nNOrIcca/IQ8bqQTR57iB0cFVMUdQDXQuV737z
	K7GoyZnaSwiDpqmZL6
X-Received: by 2002:a05:600c:1c05:b0:490:ea8a:32da with SMTP id 5b1f17b1804b1-4926689ee78mr24829615e9.26.1782385408276;
        Thu, 25 Jun 2026 04:03:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46c9ed7491esm11071917f8f.37.2026.06.25.04.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:03:27 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v10 0/5] bpf: add icmp_send kfunc
Date: Thu, 25 Jun 2026 11:03:16 +0000
Message-Id: <20260625110321.28236-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v10 of adding the icmp_send kfunc, as suggested during
LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
actively reject east-west traffic, similarly to what is possible to do
with netfilter reject target. Applications can receive early feedback
that something went wrong during the TCP handshake.

The first step to implement this is using ICMP control messages, with
the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
than a TCP RST reply and will already hint the client TCP stack to abort
the connection and not retry extensively.

Note that this is different than the sock_destroy kfunc, that along
calls tcp_abort and thus sends a reset, destroying the underlying
socket.

Caveats of this kfunc design are that a program can call this function N
times, thus send N ICMP unreach control messages and that the program
can return from the BPF filter with pass leading to a potential
confusing situation where the TCP connection was established while the
client received ICMP_DEST_UNREACH messages.

v2 updates:
- fix a build error from a missing function call rename;
- avoid changing return line in bpf_kfunc_init;
- return SK_DROP from the kfunc (similarly to bpf_redirect);
- check the return value in the selftest.

v3 update:
- fix an undefined reference build error.

v4 updates:
- prevent the kfunc to be called recursively and add a test (thanks to
  Martin).
- do not fetch dst route when unnecessary (thanks to Martin).
- extend the test for IPv6 (thanks to Martin).
- use SK_DROP in examples and use non blocking sockets for testing
  (thanks to Martin).
- test when the kfunc returns -EINVAL (thanks to Jordan).
- add the kfunc to bpf_kfunc_set_skb as suggested by Alexei.
- guard the IPv4 parts with IS_ENABLED(CONFIG_INET).
- fix a wrong initial value for client_fd (thanks to Yonghong).
- add documentation to the kfunc.
- to Jordan: I couldn't include <linux/icmp.h> because of redefines from
  <network_helpers.h>.

v5 updates:
- kfunc name is now icmp_send and takes the control message type as
  parameter for future potential extension (daniel)
- drop the net patches to route packet since now the kfunc is limited to
  cgroup_skb and tc progs (daniel & martin)
- linearize skb headers (sashiko)
- zero SKB control block (sashiko)
- bind to port 0 instead of fixed port (sashiko)
- poll to wait for POLLERR event (sashiko)
- do not use ASSERT_EQ in CMSG_NXTHDR loop (sashiko)
- fix comment about byte order (sashiko)
- fix endianness IP address issue (sashiko)
- add forgotten cleanup_cgroup_environment (sashiko)
- let packets pass in recursion test (sashiko)
- clarify evaluation order for recursion test (sashiko)

v6 updates (all from sashiko):
- bring back the net patches to route packet since tc ingress needs it.
- rename the ip_route_reply helpers from fetch to fill.
- call pskb_network_may_pull on the cloned pkt.
- check explicitly that we received one and only one ICMP err ctrl msg.

v7 updates:
- use consume_skb on success path (stanislav)
- replace recursion protection with CPU_ARRAY by checking the nature of
  the sk (daniel, offline)
- use reverse xmas tree in read_icmp_errqueue (jordan)
- use ASSERT_OK_FD instead of ASSERT_GE whenever possible (jordan)
- add a test for tc (jordan)
- better filtering from host cgroup test progs (sashiko)

v8 updates:
- mostly a resend as it's been sitting as "New" in the queue for almost
  one month, fixed a few nits.
- on new bpf_icmp_send kfunc cgroup_skb test (patch 4/7):
  - guard a close fd with fd >= 0 (jordan)
  - use ASSERT_OK_FD instead of ASSERT_GE (jordan)
  - fixed comment style (sashiko)
- on recursion test (patch 7/7):
  - guard a close fd with fd >= 0 (jordan)
  - fixed comments style (sashiko)
  - filter bpf prog on pid and ICMP message types (sashiko)

v9 updates:
- first, there was a v8.5 that I discussed here[^2] with Emil
  Tsalapatis. I tried once again to make tc work but the ai review found
  something fundamentally wrong. This version removes the tc support for
  now and focuses on cgroup_skb.
- use helper get_socket_local_port instead of getsockname (sashiko)
- use if_nametoindex("lo") instead of value 1 (bpf-ci)
- fix IPV6_RECVERR appearance before IPv6 patch (bpf-ci)
- precise that 0 on success mean icmp_send was called but it was just an
  attempt since this function does not return anything (sashiko)
- explicitly consider ICMP_FRAG_NEEDED as invalid in bpf_icmp_send as
  it would miss the next-hop MTU info. Also test it. (sashiko)
- test for max_code + 1 for invalid (sashiko)
- add review-by tags from Jordan and Emil but remove it on the main
  patch as I have significantly changed it.
- check for rec_count in recursion test (sashiko)
- re-order setup_cgroup_environmment in test (sashiko)
- reset kfunc_ret on every test run (sashiko)
- check for skb route for icmp_send as the function would quietly fail
  and add a test (sashiko)

v10 updates:
- guard against skbs with metadata_dst before calling icmpv6_send
  (sashiko)
- add more review-by tags from Emil and Jordan.

[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lore.kernel.org/bpf/ajvDRCw8cPqXAqQq@gmail.com/

Link to v9: https://lore.kernel.org/bpf/20260624185554.362555-1-mahe.tardy@gmail.com/

Mahe Tardy (5):
  bpf: add bpf_icmp_send kfunc
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
  selftests/bpf: add bpf_icmp_send recursion test
  selftests/bpf: add bpf_icmp_send no route test

 net/core/filter.c                             |  95 +++++++
 .../bpf/prog_tests/icmp_send_kfunc.c          | 269 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 123 ++++++++
 3 files changed, 487 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

--
2.34.1

