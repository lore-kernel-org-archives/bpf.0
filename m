Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098495;
	b=u5FewyxgDwem0W8SCGEM2Pw/AHpbinjCRp73grjuY5v8BkAFKrtGEDehxE6cxFrRzcIU
	 rH9xbwtpbz0PSzBkFrNi/JT6h52lkhy/KijDOl87STMzUnlnXKLzvNlZlKNaKw5UJ1pGE
	 cQiQDWHnjt/cNL0ZrKaxZi2iiGGjKuNV40g1v7aU8WlzBRvqPUy5iWfDEzgElDpjxms1o
	 zKSGJt8ERcRTD0G591BfD4POWYAABuJ5Ft3SyM67R33x/VAg/5GDnUl8DwxF3oyTUxzWS
	 zBhruuasNsct0up45UvOY6+SsoHqAaQEre6g6knwE5BVH6A/RK1dMY+FI8HXbcGqkrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=c6AW5dUooA9YS7k8SDY1HAiCAArAxhqay8nJwsjWk38=;
	b=UFq1W1kXUQkv/pi2NnirIsVIa6KlC8dcYv0vBDgHCZxtNGdaA/QrBXopbqrnKGS5y597
	 UB1sbpx5VTamAr2goOVESGA60JkqQxZ8rPYOUsdG3HqTilaFlgTVphF429l1kLSiQGXGk
	 RmSGHxG1EBxq43dVHno/7gjgD0d47lOU14aH+V1ZqEdsT9aXUzHCoQkMo0Jv6nRh5HLLh
	 juaCOrJzRX9g5sfi3YhLK/g5zsLm/gmp6tc58UKLeYX3GxwT19S7/bs5vasa7lEbux4HY
	 GEQhcUb1dc9UDczQcybaDnecKq0wXGEUvBq4UK0g+3bGH13BO3+Yjq2n1XIMSqk60Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=GFMmxmlT;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74C606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA74C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=GFMmxmlT
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso1106657f8f.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795098493; x=1795703293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c6AW5dUooA9YS7k8SDY1HAiCAArAxhqay8nJwsjWk38=;
        b=GFMmxmlTeg4lmcmksN5pGIa7GpSGUnQpOkbAB560NgB1+QEYDTKYYDPrspwGh0ep0d
         idcBoLmPOU2O0VNLWf5RC/NW7wCC39yeZPkbBovI4zq1hdAdPxQM5zFU037V0iSoOUN6
         79eW991Rzxp5piOMdwmjlgbKwbZu4RXrfGaorLiEebi06PKQEpHZNlHnoOewsrpyPJ34
         nopxKSJQJA8VJYHdOXX5oF+xntH4eOC+PQB0ComyisQuGiaCSlsh37SpJpujvcbNEXk4
         aqQiByuLTX6piIdv13KIABAijWJ03DM18mzgnPrJb7CG1zPoHxsWL1/Uj9mcbBKOJ/6u
         aS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098493; x=1795703293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c6AW5dUooA9YS7k8SDY1HAiCAArAxhqay8nJwsjWk38=;
        b=qA7aaJRKZjYs3Xz5ZHfpy5mFI30JZF2Mfy+cU/xnOWmfhi0N3gtci8k5rFPWqQwPhD
         M2iEtCg0hVTCf7uNpYg7I6aWM/ynlWwlgcFRiLnSQ5POWrQQhFb2/Oe7w2zsA2vXBJ9k
         zng0JxG7Fz2kRoJpt15dHpJ1SJ4HPTJbojLgQsarR/JkwcJ6/dlx7LVazoto5Dg/ivjX
         T9KU5wYcrOOEJY1U2eFDoYouXqYT424vVeO+aj5oEb4LrucZQSMKu2dsFutIWziETkvL
         9ksyZws+QCAoq9j0UBrsBYXt0muEBxxQyvNFsXgaOI/6j2J+TiOeZVia3/MZbgoybqee
         R/dQ==
X-Gm-Message-State: APuU4Z9wKl+we6ONdqZe+B9NkSA09YsjfnZCJDHCDJsUjtGRVVcKLPM1
	vwoBbGIbmprmOG5kBrdDX1FMYyYBqOLG7q1jR8El5U0zfQPFGJU3goj2Oy50ps0ofgl8awZiMvk
	uVZw0Auc8MAqD
X-Gm-Gg: AZFdTZeKWoXNLXZS9TEjUvJQlgLc0cDJgX9g/z4HWU3dF2QykE9d2BbBqT4bBp26MSK
	g+KSQtJurF17qoyJq5tsC2NY3v7exY/oXMGY1qivWiyBp/+qPogaNLmGj6F0401/kljphSkJFjV
	DTY5weU6yZ02MCLKiQy9rzPk4zM/1knLZiTFQV53QJ67kIgCnD1dCAqQXhztGz8rgoXSN5BwrNx
	uqLOI6WiDil4UZ9XSVgDlV+W9rb5Cs/LtFakgliv/LN+IlEMzd7AWoEZleK/jB4kBrzFeHfKBT+
	4MOkhDhPfdihyRzWJRYUaaYHcmgdw/uSfhxmSSRKhB7lxL60pLZOr0/Hc1qwrzoh6Sk/YjOOZAv
	Bt2BiC3cOOrIWIe1AqAuCAnISsoU1sO44q69qi0OX85szoEJBHBzRBAZcPbc13YLKC0/y6C/O2D
	9rtWAQqTBS76cdzFmLbBkAs/yKCT1LS5aSXonPnTIk1jBTRn1WuArRFp9C+PMzXBoLBrCx30EIt
	ScGGbIB0hIkyUiqkHwPM8ZEtW4PLjZVQp4wpI4O9Q4yQhY5x6DsP5rEY2qlsKanMvzI3NEjc37/
	DcT3AQikFBr7p3dgqmx6HqKOdlZOSl6br2RA0elwNWD3RTrK1C8=
X-Received: by 2002:a05:6000:2f87:b0:4a3:7954:ac75 with SMTP id ffacd0b85a97d-4a63bea51ffmr13234379f8f.37.1795098492457;
        Thu, 19 Nov 2026 06:28:12 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab55e241f9sm100055f8f.52.2026.11.19.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:28:10 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Joe Stringer <joe@wand.net.nz>,
	Paul Chaignon <paul@isovalent.com>,
	Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 0/8] bpf: add bpf_sk_assign support on egress
Date: Thu, 19 Nov 2026 16:22:22 +0200
Message-ID: <20261119142231.2612515-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
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

Hi,
This patch-set is based on Daniel's [1] original set that adds support for
bpf_sk_assign on egress. It is useful for the TPROXY use case which needs
to assign a listening socket (e.g. Envoy) to an skb on egress, other
potential use cases are to attribute forwarded traffic to a specific
established socket for qdisc flow classification (fq, fq_codel) or cgroup
accounting. In order to support bpf_sk_assign on SOCK_RCU_FREE sockets, a
reference is taken and a specific destructor that unconditionally releases
it is installed (sock_pfree_ref). That destructor is used throughout to
recognize such skb. For more information please see the individual commit
messages.

There are a few limitations, also noted in the commit messages,
more importantly:
 - software GSO splitting after assignment is unsupported
 - decrypted egress skbs are unsupported
 - loopback discards egress assignments

Maybe this can be applied to a feature branch on bpf-next and then pulled to
bpf-next/master and net-next/main so both trees would have the original
commits and not duplicates.

With the kind help of friendly LLMs there're 19 new selftests that exercise
various sk assign (16 egress and 3 ingress) scenarios such as:
 - egress reuseport (4 tests)
 - ingress redirects (2 tests)
 - egress redirects and drops (4 tests)
 - classic tc actions (3 tests)
 - netkit proxy delivery (2 tests)
 - netkit with NFQUEUE (4 tests)

Thank you,
 Nik

[1] https://github.com/cilium/linux/commits/pr/bpf-tproxy/

CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>
CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Emil Tsalapatis <emil@etsalapatis.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>
CC: John Fastabend <john.fastabend@gmail.com>
CC: Stanislav Fomichev <sdf@fomichev.me>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: Joe Stringer <joe@wand.net.nz>
CC: Paul Chaignon <paul@isovalent.com>
CC: Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>
CC: netdev@vger.kernel.org

Daniel Borkmann (3):
  bpf: Orphan prefetched sk on skb_do_redirect()
  bpf: allow bpf_sk_assign on tc egress with refcounted sockets
  bpf: support SOCK_RCU_FREE sockets in bpf_sk_assign on egress

Nikolay Aleksandrov (5):
  net: track references owned by prefetched socket assignments
  selftests/bpf: Delete assign_reuse namespace when opening it fails
  selftests/bpf: Cover egress socket assignment with reuseport
  selftests/bpf: Exercise netkit socket assignment to a host proxy
  selftests/bpf: Check assigned socket lifetime across queues and drops

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |   5 +-
 include/net/inet6_hashtables.h                |  10 +-
 include/net/inet_hashtables.h                 |  10 +-
 include/net/request_sock.h                    |   8 +-
 include/net/sock.h                            |   4 +-
 include/uapi/linux/bpf.h                      |   9 +-
 net/core/filter.c                             |  22 +-
 net/core/sock.c                               |  11 +
 net/netfilter/nf_queue.c                      |  16 +-
 net/sched/act_bpf.c                           |   4 +-
 net/tls/tls_device_fallback.c                 |   5 +-
 tools/include/uapi/linux/bpf.h                |   9 +-
 tools/testing/selftests/bpf/config            |   5 +
 tools/testing/selftests/bpf/netlink_helpers.c |   3 +-
 .../selftests/bpf/prog_tests/assign_reuse.c   | 625 +++++++++++++++++-
 .../bpf/prog_tests/sk_assign_netkit.c         | 586 ++++++++++++++++
 .../selftests/bpf/progs/sk_assign_lifetime.c  | 182 +++++
 .../selftests/bpf/progs/sk_assign_netkit.c    | 153 +++++
 .../selftests/bpf/progs/test_assign_reuse.c   | 174 ++++-
 tools/testing/selftests/bpf/unpriv_helpers.c  |  16 +
 tools/testing/selftests/bpf/unpriv_helpers.h  |   2 +
 21 files changed, 1794 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_assign_lifetime.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_assign_netkit.c

-- 
2.47.3

