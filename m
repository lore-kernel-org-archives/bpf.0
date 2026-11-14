Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675720;
	b=t7vuHUV8WY2jB2TP1sqcD4lE9JkAg8Bp9RhKAjtvKMiWbIusihRttwycsbO0JdEntrqf
	 cmnB36nKOwpQZRhawzl21G7MJYBEuuZYGeNKuYkATPibSTqq2ys/cMHfPMjglD41a/12e
	 woDFKCMr9WNAMDrJWf8sKCbHm8kwhs1xpKtVCNmzByFZKgKSAO6R2v39h9ICN7xoyNxMJ
	 wnJ0f2WpnQ1Qzw8CStDllk1aYliNkhIOwJ84tGISD7r2HGpbCd+6+sOalKQG/XJwtot9j
	 cfO75t9j+K/zM6aeKNWxNShTZbLFwoloTLHnXbvm3JvAvevrxyZU8wNyK7sJD5WN2Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FgLmcSw7DjbpN264BqldKH5klMuyQXGFQrNXp00hHzA=;
	b=oQepU+Q1mnlGPJzVy9dc4lXTMVsR8kAgt1NCWSepmd6SE33smi+QMYG5S6dn3B9tbSMo
	 lPTytZWs+FdXoXSj93JfMykf7YeouxeOTdlLfrUOVXt/4SMybDx8YIRx8d81B2H+L0T7G
	 5Js18fW+cxWfN5aNPFbbOKF21sYjdxW9+iI/iFMYozwfAvYlXFuxfZ5ReDxwXYk8vpwMv
	 kJ7jZ83MxChJBNL+J9QZh4c1FvNCgSYAb0KYQb+aox4Jzqe4IGsICz/EbEvsqDHAm05Rt
	 TJvvaCoUsoubus5L/9K7KdKH2fHAoWFOF3u5IDC4yAtBxFDwDcfarDbIFy0u3EVQVYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyhFkfCj;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B8606A334
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 17:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C60B8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyhFkfCj
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3791619605cso4193633eec.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794675719; x=1795280519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FgLmcSw7DjbpN264BqldKH5klMuyQXGFQrNXp00hHzA=;
        b=uyhFkfCjuPWNaTUSZb+7Pt39iHkDpbSD/kPp0aQyJ8ktHUMZ6h8OMsQQkCiQX2VaK5
         gqAVfl0CYdGk6TzezMRtPpodkH93rRRHnOQOy3/X4WfrQMOiveI2jodhyBAlEGu0wEVn
         yRuIKWJyOxCkzS5POr10C0Uez94UN4VRmqrPbs7GOAQtGsMz0T92HeXrIhjoLwh/wrms
         tXwsZcLvOx1EqO6X8y+Y+ejjyp5GcBFzwHKFkruA7Jtw7keuZNecJqVEc9FbOSkqpBr/
         CiwD4nRtx/q58s1zcA7vrRO/pPz6y9mllfh64NNmwX7gU/t9HUj9WG9AJIQS94FlS4E0
         u7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794675719; x=1795280519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FgLmcSw7DjbpN264BqldKH5klMuyQXGFQrNXp00hHzA=;
        b=Ew7vF93NhDSvEZI6+JLbeq18O7ba/eiXA5EEBopn72089Keb8cvuMRqcpYcB6TI1ph
         I4F3rSuvwb22LNIYTNK0X/BE10LRRGG94DEI9mFnkXLbKtGMhBgNyxtncCkUiyMZMyyh
         naoumeIunAeaXG2D33oKEYGuoDHVIj2YvclFTzncT8Caz+mrWJa4nCsIzTQjP/tlA0wq
         x7jMbNbPDsey1JkjdonL6dk2BpTlYjfhXcNvYfItLQVlK/DzXAENChzxilY/bhFCwLjh
         I+qRzUVhlug7zpT6ejymXN1JjLrHL+hxiDhSFmPlVhZWxIqXeMTv513iNtLheRwJI+Gq
         bM8w==
X-Gm-Message-State: APuU4Z+YhJfPzR1xhC9BTEmARQnY3AWi/pBQHRL7TTR2By4HD8bhSG28
	ZEKNnAsE3pO8HG+YF3g3JjzJY2dAicRkqHzEAQwOt462tYS0jIchZcwkwTdkgW8O
X-Gm-Gg: AYBFou22JYd4GFQDy+wsbOjlwou5mh4HXcGx24fXYeNDLbdL6QjyvWxw9Tp3vpfRDeq
	R7LojugqPiGdv3sx8pWQN8SFDLRHPIAw4xqvz1MebzpqtPxHjcJy6JD5OjcOF60EwJgzEcV7odP
	74Myd8LLc6/2+cvjwE3IguQF4A4TI7iJ3JopZOcoj6ecjOakiw2qmVI17hTG1Rp4RSqNvl3Ngwi
	brhkyOrh90p+vtwTQ1og/v3W9rcnzCk9molJWtOn1O8nD899bDSlb9HTrajJDbnFY0qOGWNQzoI
	x56zR9BBJ4JPTzA+qXqxBOkpEc6c/Rz7khmy8UNBlJp5ONhFxPVglK7MspR874IKpGPXHLCrumK
	QCAT3CYRl5nbxtnZ1P7qlmCP4QgZIbgXt4eVEx1hPKZgHufzxPeLo7CCD3j9ylM26hCWBv5jDGD
	d1uCNWyVtexhSE4Qrp15uOXsgLux6WNhdrTDQnRXLcRDvaN1DAik/RnzCoTePWjvhIer+r7NsfJ
	UVIkmP2GsE+jAropNkG37Ay6CNJEURT9g3NtqymDp99k9J13fZuLeTJfHSSYOR0wmrEzGIonWYw
	Wls567ErwSY46l4aV2gXT7bQdioWppdyLJsvj4t+JX0=
X-Received: by 2002:a05:693c:4152:10b0:36a:4a68:84e5 with SMTP id 5a478bee46e88-379659c6839mr6140556eec.8.1794675718555;
        Sat, 14 Nov 2026 09:01:58 -0800 (PST)
Received: from LAPTOP-G6J9COQB.lan ([182.253.124.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm31586761eec.21.2026.11.14.09.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 09:01:58 -0800 (PST)
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
Subject: [PATCH bpf-next 1/2] Documentation/bpf: Update sockmap docs for mutation restrictions
Date: Sun, 15 Nov 2026 00:01:16 +0700
Message-ID: <20261114170117.196552-2-supersonix03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114170117.196552-1-supersonix03@gmail.com>
References: <20261114170117.196552-1-supersonix03@gmail.com>
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

Commit be39165224d0 ("bpf, sockmap: Disallow update and delete from tc,
xdp, socket_filter and flow_dissector") dropped those program types from
may_update_sockmap(), so tc, tc act, XDP, socket_filter and
flow_dissector programs can no longer call bpf_map_update_elem() or
bpf_map_delete_elem() on a sockmap or sockhash; the verifier now rejects
them at load time with "cannot update sockmap in this context". The
kernel-side sections of map_sockmap.rst did not mention this at all.

Record which program types may still mutate these maps, and note that
sock_ops programs may delete entries but have to use
bpf_sock_map_update() or bpf_sock_hash_update() to add them.

Also drop the reference to
tools/testing/selftests/bpf/progs/test_sockmap_update.c and its link
target. That file was removed by commit 5de7a6eaed89 ("selftests/bpf:
Drop tc/xdp/flow_dissector/socket_filter sockmap mutation tests").

Signed-off-by: Ahmad Wicaksono <supersonix03@gmail.com>
---
 Documentation/bpf/map_sockmap.rst | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index 2d630686a00..8bb6d74cf36 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -285,6 +285,16 @@ The flags argument can be one of the following:
 
 Returns 0 on success, or a negative error in case of failure.
 
+.. note::
+	The verifier only accepts this helper on a sockmap or sockhash from
+	``BPF_PROG_TYPE_SK_REUSEPORT`` and ``BPF_PROG_TYPE_SK_LOOKUP``
+	programs, and from ``BPF_PROG_TYPE_TRACING`` programs attached as
+	``BPF_TRACE_ITER``. Other program types, such as tc, XDP,
+	socket_filter and flow_dissector, are rejected at load time with
+	"cannot update sockmap in this context". ``BPF_PROG_TYPE_SOCK_OPS``
+	programs must use ``bpf_sock_map_update()`` or
+	``bpf_sock_hash_update()`` instead.
+
 bpf_map_delete_elem()
 ^^^^^^^^^^^^^^^^^^^^^^
 .. code-block:: c
@@ -295,6 +305,12 @@ Delete a socket entry from a sockmap or a sockhash.
 
 Returns	0 on success, or a negative error in case of failure.
 
+.. note::
+	The same program type restriction as for ``bpf_map_update_elem()``
+	applies, except that ``BPF_PROG_TYPE_SOCK_OPS`` programs may delete
+	entries. Other program types are rejected at load time with
+	"cannot update sockmap in this context".
+
 User space
 ----------
 bpf_map_update_elem()
@@ -349,7 +365,6 @@ Several examples of the use of sockmap APIs can be found in:
 - `tools/testing/selftests/bpf/progs/sockmap_parse_prog.c`_
 - `tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c`_
 - `tools/testing/selftests/bpf/progs/test_sockmap_listen.c`_
-- `tools/testing/selftests/bpf/progs/test_sockmap_update.c`_
 
 The following code snippet shows how to declare a sockmap.
 
@@ -495,4 +510,3 @@ References
 .. _`tools/testing/selftests/bpf/test_sockmap.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/test_sockmap.c
 .. _`tools/testing/selftests/bpf/test_maps.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/test_maps.c
 .. _`tools/testing/selftests/bpf/progs/test_sockmap_listen.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
-.. _`tools/testing/selftests/bpf/progs/test_sockmap_update.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/test_sockmap_update.c
-- 
2.43.0

