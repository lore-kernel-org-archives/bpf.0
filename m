Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675694;
	b=GL0oRUtCl3edrTpkp/UrQ1LVO0jCdNac8ZpbPEJNThrdxQKlyyyZx1wm+ZkJoYjYdV4z
	 kGAgFUBGaRux19D95jgS6gYUnugOTQsei5aVrLgkstYc8HIw1PLw6EIMw8/zDJItOYdV4
	 qcHk67fAc5DhkLolbB6yZ5qBNRKow4ZX4o3x09Cg52lQNOIKIB8j8CziJtlpUzt/6S/mw
	 weH2x0W1zn4EteqJzcRLyCfxUMW9c0DUzFO5l0ExvMq/E5FCWDX/BAPXp6Nn8bRunDdB1
	 u2eXfDwjPj5lZfoChK5nf0fAmEcASfsSzSzYe6EYEv0ZlHdqcsIwFMy0PlrHwBHFMyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ep+n5rIbIBkWijYN/P8smm9x/IxlgV6O3xbPYJDU0As=;
	b=OqrT1l+8sYO++ybbzsogFPXTKMiE6XlO8oAF2lwdhmRxL8tYZvHonOdfsWPvPgPA57gW
	 Kh8o5gmVAmIIiWMrU5FDyIBUWGa9TGxriqNdImQCcI/dJuIiaedo+h+yTT/W0X3aggCF7
	 YgKaiDwQNmYu5H/dbc8MANaRyMJbtkXkp7Y0RQcAGbeDEZu4evLJMRmrK7M+I6Ulih/UK
	 P8vjEAuvishIdQiY/bv9Q21pJ4eZl15XvrmmUswDJN9pmbgTI2LD3fZ2shYK+t3IK/Qi0
	 gPy+qMomDUtQTc5MLqKSavD4vMg4CUAIrVV9Ugdn3kqEjPCfaX0WhnQaesePx2mVscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CpNp+i54;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFF606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 17:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69AFF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CpNp+i54
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2679237eec.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794675694; x=1795280494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ep+n5rIbIBkWijYN/P8smm9x/IxlgV6O3xbPYJDU0As=;
        b=CpNp+i54/v6tOHdyDxVQNdYBsB9xSD8IrZMj5lzcvealEleNlvsVZpKDskPYge19oz
         wyW5fMmtJj4tccpwzgdZjRZJ4rcvlMvb+4XVXNE5hzFxijuoLQwPhKSmq1z1IZsVUajg
         TmdXLTER3QqDCHqjr947KNxpwILpkOtzaWuCpCb6LDB//A6gNtNIDW495JeEibg+xlLp
         Cl9Aij89Py2OCKzmRAmKLyPr+rPwYT6XCsrTbene1IBVP4SrVt4Z3FxHxkdyq6vnuEot
         0uIohD1XJynwnL2Fm6M0jdakxFLhGmL+uhfYGG5RRISmiDXphXHz1JL5PTtUSD46sPex
         WupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794675694; x=1795280494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ep+n5rIbIBkWijYN/P8smm9x/IxlgV6O3xbPYJDU0As=;
        b=VhP+5r+by1MmGUNuILLXsUO1r30gywOajytmtCJEpoFjn6drPVzlv6VUaR8UOVueF5
         lgGkmwAddH6Z+V6SR4Tsq++7Osor4EJdNRv/vmXvBkEQ+1XrfQhqEjiZu/Da+n/lQlyW
         emQZ2w5cG/pJf5BM+78Ji3PoRO4Ccv9UxPhuO0EFQc9T4oOJijN8W03xVdnkQwXfF0B6
         Ic7S24JQOaxAgRe5Yy1/9Aq98phWI1zbvMIJ3zqCUxS2Weim3Whc1Eew99+gvUhlLyiy
         a1aCVPPpmn04wc/1nX7ECJxOD5KX3DLJwBlSqFy9xDRmQsrl9onMneLe11ng78+HcqHZ
         wwrA==
X-Gm-Message-State: APuU4Z9ukWSGvP/CDxbK91v216SznYEWU1WF7TVYPmGjY3fziJ2zfyhn
	zEr+zpQNm4vJ/zolIn4HurT7VYrH4+dX9FbuP489TGud1F6WsrIHEU6O3wxJOdqX
X-Gm-Gg: AYBFou2N+gKxmcjdHWxPsxBaSTZFX16bT1MDSIQZWeb+Te+inwExDw1YqZ7Dvp5hpEl
	/6FJtcOtjpa9YcAMghKg4tqLQo4u95tG4Eywq/kKLYo9/Czmeja1QKCDgQUxOTy/6a72dwYkaHF
	IYIqAxa3CkzGaEf1gDnwHT5lpVbltYhvYKJ7A9rc8IKD9MsLBeiEw7GFD0vKETWvwQNsVSOWs1m
	TpvY05CYoJ8HfWLrVr4guh3xYJPNa8FMVjz2zUwoYOGg438rBP1q+6VL5aAtCBWhf6cm3phjfo7
	a9WN3AdWhRO8kxIGVV1DB0eAnTgImRJepmyL3maqA3herVTk0LiI4CysuJ38zh2a5kSMox88aKS
	1Mo4VfeTCszhUSya5m6Oj33cAC3rLxEmuVge9Q96CJsogk9FLs6EtpGafxZy4zqun2+/VdmiISr
	MQ0bqgGxPK1tuCiCT5D0cCOsn3ZjEP3X6OD0NcrZk8tb23/z8fKKLePg1wJ4B4LgiEbgr8BRJRI
	rTQDtnLNtQerWgUgL7C2rIUmw39nwBZYfGG/yp/y9hGqIz9BOVzHphQN/ZJtI+4O8QntAykVniz
	Er8TRcOukVRytpnoDtsv6eVS30XQvffg5J3Jw7hkvQI=
X-Received: by 2002:a05:693c:808f:b0:351:29c8:643 with SMTP id 5a478bee46e88-379675fc97fmr5683571eec.18.1794675693304;
        Sat, 14 Nov 2026 09:01:33 -0800 (PST)
Received: from LAPTOP-G6J9COQB.lan ([182.253.124.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm31586761eec.21.2026.11.14.09.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 09:01:32 -0800 (PST)
From: Ahmad Wicaksono <supersonix03@gmail.com>
To: bpf@vger.kernel.org
Cc: rhkrqnwk98@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Ahmad Wicaksono <supersonix03@gmail.com>
Subject: [PATCH bpf-next 0/2] Documentation/bpf: Fix stale references in map docs
Date: Sun, 15 Nov 2026 00:01:15 +0700
Message-ID: <20261114170117.196552-1-supersonix03@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Two documentation fixes for the BPF map pages.

Patch 1 records that since commit be39165224d0 ("bpf, sockmap: Disallow
update and delete from tc, xdp, socket_filter and flow_dissector"), only
BPF_TRACE_ITER tracing, sock_ops (delete only), sk_reuseport and
sk_lookup programs may mutate a sockmap or sockhash; anything else is
rejected with "cannot update sockmap in this context". The kernel-side
sections of map_sockmap.rst did not mention this. It also drops the
reference to progs/test_sockmap_update.c, removed by
commit 5de7a6eaed89 ("selftests/bpf: Drop
tc/xdp/flow_dissector/socket_filter sockmap mutation tests").

Patch 2 fixes two moved selftests paths: test_lpm_map.c, now
map_tests/lpm_trie_map_basic_ops.c, and test_xdp_noinline.c, now under
progs/.

Documentation only; no functional change.

Ahmad Wicaksono (2):
  Documentation/bpf: Update sockmap docs for mutation restrictions
  Documentation/bpf: Fix stale selftests file references

 Documentation/bpf/btf.rst          |  2 +-
 Documentation/bpf/map_lpm_trie.rst |  6 +++---
 Documentation/bpf/map_sockmap.rst  | 18 ++++++++++++++++--
 3 files changed, 20 insertions(+), 6 deletions(-)

checkpatch.pl --strict is clean. make SPHINXDIRS=bpf htmldocs gives
identical warnings before and after. Documentation only, so nothing to
run-test.

base-commit: ca4181cacb0c6a5632018f1c94f29d9dbc0e9270
-- 
2.43.0

