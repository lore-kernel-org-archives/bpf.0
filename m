Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449178;
	b=pAVwhdUdc6vLEN5hRfGl+7MvjKGlWv4p0kqMPByO6jyT0rbURh8393BnlKCbHqWbTAsd
	 FnCBiAs+nl2iSQmxUaDUx++hxBsvc2GqSAZTrzL7iN93DOED2uPax2XnByGpbKtBDfTpp
	 DvXMklGIIJMP1maPSqiL89ebOVMOuBH90WeCV/1ZWzDpKaKV3NPnitGX/Yv1tlbQRt5Du
	 x6iYwaqcxU9LVzfdH+LjbXZhwnkR8bzkFrMlTj6mQ6R/+EPmHO3DtWVAqhQpvo9W4DbIT
	 DL3COQZiTQFEZKCaqVslCXY38zg27z1zDLUi/UWsjItDBTa6UKaYzLWJDFXCebfrqAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qj7AT8ixrLnNnl/GUjA6F+5iIJQ7U/GQFRlgi63njZo=;
	b=Z3uGq4SHk7x/Gibn08ZOlqkNkjMnogL/Q34DrKudo80nSMoMB2SAq9Skued4SH+me/G+
	 73Lfz0ge2EvTzKpHAB1aW6QUHR1dhjSK1HdQ26CEEa0IkuzjD5Qx1j1hXecNQodgDJNxn
	 x5Va1ZMLKDZumBGPwLQj2oDEjZsg0I70gpaIz7p7XdCmxpfBjrjMDlGg3bmd1Pv7frrv+
	 8YCfqUl+a3dC5T1ZWXLyEEivFPcok2jpYQ2Ze+qSfRxg2W1y1fapM4lMao3efEzpV9fjD
	 +5UO6ub4k7I8PUoDEd5Mz694yZDufKFxfaBNYwQNyGRhTyWXrRtnruQ8/LFDQm6ylmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJeSvu0K;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44D606A33A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F44D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJeSvu0K
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso2238387a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795449178; x=1796053978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qj7AT8ixrLnNnl/GUjA6F+5iIJQ7U/GQFRlgi63njZo=;
        b=yJeSvu0KDqGVkGuiZJLMgzwZfeELxwPAADjmAUBiudoTmUPYZcATBngDtQQTVQImDZ
         Dqb4yVswtYn0tTK+iV/BZ2s9uxMRhsrEHBwaahSFFMYSjPwdxsYo/0l1LTJyGXxl2N2Q
         T2kSwBxh8sM+jM1PApNBp+3wxwuG3VeKt5Uwi9gXehSYENd8nMiior4+ruVYo5m4hWlL
         Fg/ZbIbgrxYnQsCuxjLeO09pgl3NldStquz4OnS8tbKVPo2+aGSah4mpVw+H3lKfOXYl
         3tnxEqWGLp2B163Rxs7tSC1jDzneddAemCIFSrdmpUIMgTHJNg31PJVbKaKeFERjtUk0
         7BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795449178; x=1796053978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qj7AT8ixrLnNnl/GUjA6F+5iIJQ7U/GQFRlgi63njZo=;
        b=UKhCMqRRmvCXXghZfrOB2H6mH0A8PXiaApH8yHUdKqEs8zKlOgG/eVwRpJnWBDhtO1
         VCwfyrhmSgys5IM+nOWhxpXZAoqT+tEPpVmVnRm1fzyuh6eHhY1k9e+cvXdfNyq7QvP5
         f+EEDdMs4xjih4f6GGihb0hGlGxOp2PSr2og1vtmdS1fWo6TUbhG0nrNI9d2UOW3n/HT
         ywm/OE67Tb21rS9/c4sIiB/Emc/qXiAcEdhT2UaNxa9Gdq+l6g57mQNsLmoy72YPFket
         Cx20dFmta2/xr/t5pUMasHUza+jfhewdGNoWdw9IEWBSJsLOz5HURMrdPh+BLPkMGkL9
         rqQw==
X-Gm-Message-State: APuU4Z/lGoGc008ztHCjGNco9Hej/yDFGnEccuJ2rAaejpFzSEz4FIRr
	DWCtE+FBDtAHW3BVxfx80C1Gh4nk53V5Jo073xZSanj5jX0P1MslXKj5Ot7TbQ==
X-Gm-Gg: AZFdTZeA9KDqMtjGEtMtmJe4MGempynCAhGr9ezyCUy3H4ejqZ3NTXjZTIzVnr0vXHj
	Koz+KzF2m3hqdRpbH/l9eli8r0ThkUYEFk+1XiQM0ss3veyfZ2l1xVdOFRE4nN+EdNAdA3tTPws
	u55aQNnkHivzOVAMUEEY416G7nF6ppi5UP8mfqbNL4JDjTBkOXR87xazI7Qo9OU1D3QGiAXFD9k
	nM01uODVS7jRbvRDOaWeIZWCK6fAWbRm96bxBr9YRNL4f6WI206r7drgnALDwVl2Id+s0zJLOIa
	rpq9Zg+McWegndGJgIiaAPgdcjzGBk02M6CYzR0tVLfHcXUJ77+lSfeZg7SsQyw1Yk2X5/rDWd/
	ruC8KhuOL9ute6giONrVeP8nz4S8zRohB5xQtM/BfD/zCVpQKm7LOtShgyUEFsb9U4J1tXcxUPA
	hp3lDGY2CsBuejvutVmgUQarYp55d4v1ZIdIq5fTlw4mP6oDijuPUXFH1/rXFrKg5YXu5VC3OAq
	/idPFSVJoeXDRzM4t1JJKRYs6OuQgaZyFH7qldJS2QAC0/x5WijWTJdsLjEl6NqSrFoHqw6Mfct
	p0rxQkJf02C6jSqLIIkaJdwoKGygtnaOW0gIeZ5zEY0=
X-Received: by 2002:a17:90b:2e4b:b0:3b3:886d:621 with SMTP id 98e67ed59e1d1-3b41c9e52bamr10518041a91.34.1795449177600;
        Mon, 23 Nov 2026 07:52:57 -0800 (PST)
Received: from LAPTOP-G6J9COQB.lan ([113.11.180.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm21596601a91.12.2026.11.23.07.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:52:57 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/2] Documentation/bpf: Update sockmap docs for mutation restrictions
Date: Mon, 23 Nov 2026 22:51:59 +0700
Message-ID: <20261123155200.16676-2-supersonix03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123155200.16676-1-supersonix03@gmail.com>
References: <20261123155200.16676-1-supersonix03@gmail.com>
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
bpf_map_delete_elem() on a sockmap or sockhash; the verifier rejects
them at load time with "cannot update sockmap in this context".
Commit 18f6c47d1097 ("bpf, sockmap: Restrict iter-context sockmap
updates to iter/sockmap") then narrowed the tracing case to programs
attached to the sockmap iterator. The kernel-side sections of
map_sockmap.rst mention none of this.

Record which program types may still mutate these maps, and note that
sock_ops programs may delete entries but have to use
bpf_sock_map_update() or bpf_sock_hash_update() to add them.

Also drop the reference to
tools/testing/selftests/bpf/progs/test_sockmap_update.c and its link
target. That file was removed by commit 5de7a6eaed89 ("selftests/bpf:
Drop tc/xdp/flow_dissector/socket_filter sockmap mutation tests").

Signed-off-by: Ahmad Wicaksono <supersonix03@gmail.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
---
v2: Only sockmap iterator programs (iter/sockmap) may update, after
    commit 18f6c47d1097. (Alexei)

 Documentation/bpf/map_sockmap.rst | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index eb466b86d..0b7fdfca3 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -287,6 +287,16 @@ The flags argument can be one of the following:
 
 Returns 0 on success, or a negative error in case of failure.
 
+.. note::
+	The verifier only accepts this helper on a sockmap or sockhash from
+	``BPF_PROG_TYPE_SK_REUSEPORT`` and ``BPF_PROG_TYPE_SK_LOOKUP``
+	programs, and from ``BPF_PROG_TYPE_TRACING`` programs attached to
+	the sockmap iterator (``SEC(iter/sockmap)``). Other program types,
+	such as tc, XDP, socket_filter and flow_dissector, are rejected at
+	load time with "cannot update sockmap in this context".
+	``BPF_PROG_TYPE_SOCK_OPS`` programs must use
+	``bpf_sock_map_update()`` or ``bpf_sock_hash_update()`` instead.
+
 bpf_map_delete_elem()
 ^^^^^^^^^^^^^^^^^^^^^^
 .. code-block:: c
@@ -297,6 +307,12 @@ Delete a socket entry from a sockmap or a sockhash.
 
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
@@ -351,7 +367,6 @@ Several examples of the use of sockmap APIs can be found in:
 - `tools/testing/selftests/bpf/progs/sockmap_parse_prog.c`_
 - `tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c`_
 - `tools/testing/selftests/bpf/progs/test_sockmap_listen.c`_
-- `tools/testing/selftests/bpf/progs/test_sockmap_update.c`_
 
 The following code snippet shows how to declare a sockmap.
 
@@ -497,4 +512,3 @@ References
 .. _`tools/testing/selftests/bpf/test_sockmap.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/test_sockmap.c
 .. _`tools/testing/selftests/bpf/test_maps.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/test_maps.c
 .. _`tools/testing/selftests/bpf/progs/test_sockmap_listen.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
-.. _`tools/testing/selftests/bpf/progs/test_sockmap_update.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/test_sockmap_update.c
-- 
2.43.0

