Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449173;
	b=DQXYtI74NTxCvOD0rTOKDHyUlEXGhc5Y9UENoYQCQBGeZrJXJf6M/QjqYNOXiBETyv2a
	 pOr4Rf2m2MfMRJOHqN3n352N06lhUcHHl5X8XKMOm+TKI4hIYLdXq5frIqRdxQBU4xtXz
	 4sIePaGizY0idNJoyqs9aPuffqHxblCIuphBWqRSr/ouqIKp8+0KezPuB4iBN5k31jorb
	 pVl3MPYz/eDtrjx/yg2y9e/SVmd5FTGRJUe0Pida14qhcDEhPjZ97epT7AuYvRbs6XyVB
	 Di9cTJvXVwFasZ2WveC8xjSEn45SRF1b33SDQMEWJQrZU5lCzvGyNdgUNUq90yYWflQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=guIdQE/iqDvGoyLfjM4Tr3vD0fnxKmiMHHuG0kl8J/c=;
	b=xkw2yzJw+xgiSJpJUlIupLvQkqpqzjiz3TdG8gvVyKAzB0WAZ5SbazXdt+LrpqqTk9PR
	 PMaxRLZsA2lkYoGL4c8VGVs7/JjA1Wjue/XWiVv1fsakJxlrBlXn0uhegE/Eo/twQBtGb
	 K1PFQrI+LUhsWLFdWyLoM1S28je/4Qp75Q9LxwKR4k+l+vNJkzwEntdRwUCf9dDIO82a7
	 T70hRf/tIDHpm5irRPQjpGAwhx/+oG8YcCZYCZ+KpxaqF4ol0/B/lF73dFBeiknM98/mJ
	 Q3uCh8v+GQdJVRyl03KZ9b7AQEVApP4/jwPEmUtSSh5Kz4gvZ1J10/zA6bLwI7KD0GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LOP7+Gnq;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC585606A32A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC585606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LOP7+Gnq
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so2169594a91.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795449172; x=1796053972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=guIdQE/iqDvGoyLfjM4Tr3vD0fnxKmiMHHuG0kl8J/c=;
        b=LOP7+Gnqt6kSwTzsIN005aK/objY89TCZs/rRJHOb26cCZXu6c4Li0tMy/tbzdnF2R
         NnYX9jVQcVPf9FgzEL6Q7yIFoFnum741vL9tAcAVsrEsTiom0OHiuAH5BVtynIeKTLg7
         vSBqKgbqTBENtUXGZZ5NXAjkqXq7QqM8ZMBqyT1Zjf9PGgkFj/42ewbfpQa56kNDBAls
         4DKEecZVq55oIEOUO9/pb9nJjZ1xmOzU4xwU61itjJOuQK3jkGsgEX2ABFeOp4oFXK2Z
         CFagj0MXbRjLBG4NmdbyU6zvJCL5MP49BKIQJLu3lHCb6Box0iEYTcSJG0rA2yp0j3Hj
         N6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795449172; x=1796053972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guIdQE/iqDvGoyLfjM4Tr3vD0fnxKmiMHHuG0kl8J/c=;
        b=cslVKArN5TIjUMKFahO+JHxhynfH31RUdg24UPEe2dPQFQpy2Jkwvy4ZrDZE6TUckK
         GgrZy0bQRoQz4sW4n5wkzvRM6592Zrg9HZaolPXYSXzvlmzfI1q84gf7TJaZ5XcxMs2m
         A7CeLEoV41elUgVY0qRtnza8sk4HIyUiYe17bAcN4IFDjCRO96fX0J28TpgihoM7mU4f
         Ot/HP+UFLX0sxb3bED+OzdO2nPzgScG9SL7gmJDCPajlo3pxozqQtTwEwCwo+yxaqTW+
         aX5dkDINwtM4VH2qKJaMCUJqFyCiYCrMwGh8X+9Gza1irS7dGIP2E1o4PhUnRxB6b9K8
         gVOw==
X-Gm-Message-State: APuU4Z9p+oKKMNAQQ9KK2AT1te+rhHjOOXihNEQ+4g3BwN6T4J3Auvuq
	AYWLjSZ1c4eZ+JGvmqjYmonVPpQTR4kwD9tgK1XHAI9ZL5F8sQqL7BXzZyvOCDR1
X-Gm-Gg: AZFdTZex8z25jb/FxEidpJcYWZzWPcIC3f25ZpeAbmunPMjFXLqhVmQn9175AxXTXrA
	v+AAJqa6NC2cpYOc32CYqLrHfHMCpJOMNV9Gqiq398oX4MvqkRkZ5/Prhluia2EXd1uDU8kwfLX
	1jtJ9ZiGkf+bp9oW9GtbzpyB4gljNdS6HLw3h24S8WIgX2XQXfSqd2jZ0PVD7W4hCDJ+Wd+NJkx
	Z7MJxW/HmCIYpMRx+cZsb8uPsY9UHVFAPeZPOy5A7GfYWu9d+HnOnZAlrA7TGlhf/1V4yP2j7iH
	97UqFdFJoRRp9BKYKiLWpwYEuPqUWp217yajFnGsEmnktGOKo/1ExorFg2jRroKCWqkwf1xuVCs
	R7O4pAo9e2PK+Qd2PMv3rZIPe3Y7GtgjQe6XTHCKFEK/xSnbrG+4UhHCeOtlvmrY8G20U9BtrCS
	UD1sEIKt+vv3PKMAFtSdDJmdQ+queL5g9nqA5RPdKBiWudWubmkx9gPNgr9utoNsx51eFqitbqT
	88cR70ziD2hN3ADu/8S9s7t1Mqz4io7TEQOymedEjJCoa9TJaAm/MKHiMafMVagd244mXDygQaO
	xTfl+Wm6M6rvdZ66CMdR+35NWxwndHSUHZfqKzpIyy8=
X-Received: by 2002:a17:90b:4d10:b0:3ae:533e:7e40 with SMTP id 98e67ed59e1d1-3b41c8d9bedmr10884695a91.23.1795449171734;
        Mon, 23 Nov 2026 07:52:51 -0800 (PST)
Received: from LAPTOP-G6J9COQB.lan ([113.11.180.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm21596601a91.12.2026.11.23.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:52:51 -0800 (PST)
From: Ahmad Wicaksono <supersonix03@gmail.com>
To: bpf@vger.kernel.org
Cc: jakub@cloudflare.com,
	mhal@rbox.co,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Ahmad Wicaksono <supersonix03@gmail.com>
Subject: [PATCH bpf-next v2 0/2] Documentation/bpf: Fix stale references in map docs
Date: Mon, 23 Nov 2026 22:51:58 +0700
Message-ID: <20261123155200.16676-1-supersonix03@gmail.com>
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

Patch 1 records which program types may still mutate a sockmap or
sockhash: tracing programs attached to the sockmap iterator, sock_ops
(delete only), sk_reuseport and sk_lookup. Anything else is rejected
with "cannot update sockmap in this context". The kernel-side sections
of map_sockmap.rst did not mention this. It also drops the reference to
progs/test_sockmap_update.c, removed by
commit 5de7a6eaed89 ("selftests/bpf: Drop
tc/xdp/flow_dissector/socket_filter sockmap mutation tests").

Patch 2 fixes two moved selftests paths: test_lpm_map.c, now
map_tests/lpm_trie_map_basic_ops.c, and test_xdp_noinline.c, now under
progs/.

Documentation only; no functional change.

Changes in v2:
- Patch 1: narrow the note to the sockmap iterator, after
  commit 18f6c47d1097 ("bpf, sockmap: Restrict iter-context sockmap
  updates to iter/sockmap") (Alexei)
- Rebased onto bpf-next, which now has the bpf tree merged in
- Kept Jakub's Reviewed-by tags, as Alexei asked
- Link to v1: https://lore.kernel.org/bpf/20261114170117.196552-1-supersonix03@gmail.com/

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

base-commit: 2bf3351c5f894697e8443eeef5333d4c4ce90cab
-- 
2.43.0

