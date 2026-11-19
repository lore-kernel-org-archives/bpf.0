Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069247;
	b=rI969/TdFiA/aotYhAQv8Ry2Xx66ehuRFHx+VN5SQwVeip6d2itaUocDWmcWDCgx6CZm
	 uNr8WFTU+GcghNc7fPQjIECDThPK1qPq9JJKLAc3TCLjtZzsaFr9fBaRq4/sxD50nx6Wm
	 TKPryi1ePjptP8w1nMplLlw6H8AePQVAJQsFSBCPENrJj8RQuuM5VWrkBBeAVerB63ie1
	 LTfDYjm6pBGGitB5AddS47qAhH3bawpoy2GHmctgF1QiNUQMOZd1i+WSIKkaLZjCkqdpQ
	 LN/ddPLLcY3huzPhOjLxJCopvBpIyIw5sUvwyERxTUNyWKx3U038BSrdyGVXs4IK0xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=R72tSyuvoCt5/QGm7uguOsGtVeCA2C72cLraw6uBskI=;
	b=iQznB8wpmJ8pbtI1zYr/BwH/yM8X7OGAYBe77wrxMJZmBLMI3yybMA1S5eyz2l1j3Rem
	 AxuPWvGfzByQj6Uemjtk6W4HD/dGQUo1pEwKlYESt4jjUMUSTjglF3mxdgQBmSof+nTSs
	 NH//WigYQx+GXMFvI/ChSauZ3q9DgskkXDYCE4jlVQ1zrmhwTXX7yEpDt80buFPLEZZU1
	 6M0tEkOg9dXzOGES9+CXGgpGQUy5JZbj5lznJJtKKOvgShoHf4kmoKragi94M1cNz6eVb
	 6tcJ0Gx/2d5AAd1dKJ7tm91l07PdRbqkGTqp3rLcUxSKjgWOUrKpv+i5ld5ZZwakpug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3oxpHUL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469A606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A469A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3oxpHUL
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-921276742e3so4308796d6.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:20:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069246; cv=none;
        d=google.com; s=arc-20260327;
        b=EsfMeqPtA4yiFSaniYejLS6XIcXg2wyoKPfMV5J6X+KkvsZZQCqlhB0UZraXzCuDf8
         +parq5dpheEw05bmFxB887J6xV+/F1f84b/BAEkThsx6XqFmhnbrtKOI09s6P8LDYH2e
         WE4mXV8Mg2zoe8Be90L4yKrFz5SUXTlTzCytghloxkYDUTOcRNxcpbB2dzFvv4u6mBkB
         1OjFe9JnrUsXYFJXaHOtGNxSQ2nQztssoZmsMwBNYlKoo1r5QtdcugjcDM5+283Dgp6b
         qGHKbmG104i0JgjLUscX/ZNwjEdlcTqeApImMHFqHulI2YWADKCiTw83ws66nwalU91K
         bhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=R72tSyuvoCt5/QGm7uguOsGtVeCA2C72cLraw6uBskI=;
        fh=D5+yd6vJMUvfAp5gnUcHRvIopiYH+v7Nmcr5kof6lik=;
        b=mVW6kGb8YWuGXs/Fq865VbevXTXZr4wc6zmZphTMEUVguSS33IY0RA3zNrw4fOWiw/
         HIs/PCGGYkvdZpLxW7fTmeuy6dlSxfoB1FhLuigtVGk9Irxw0rCcA7eZOHUq1qWkIi3o
         +Z+oL1x1okoa+DssFagggFiMtvPFgiBiuOymcWqtef6V7n2VNlPyVYU09k2/JAzzCpFj
         R75ts0AIZ7xwRHX3//vE2xrpCUoK7sEgKXWoxdzEJSepG+kAM90IIay7ApWv+rTggaFo
         kP6Pf2ISCZ5J+m0FD25EkiqmVuCY6MkBOdLQykqDuw3eo9jwSrfaN2yZfqoDoYG3AwLJ
         6UMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069246; x=1795674046; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R72tSyuvoCt5/QGm7uguOsGtVeCA2C72cLraw6uBskI=;
        b=K3oxpHULF4L+vV1q+0GdTBv3uOvLHlttlMr7OApOglNWVl+Zu9hnmsfBh8ArpL5nos
         0Cp5+2skbP0ZCKEDEDLtPxweHy1c/1NSt6N68MGuiUtoCU/ddPCHUsx5Pcx+AJ5lx3l/
         4f7UJPrMJgYaPHi3y5ZzjqrX8tNmwRvhBoc5WTpy4NoLLVMEo0FHTyqgMPrqR/R0J9XI
         fJRVS6H1aLtMQwDm4aahimGeHRiCYiipcu0FD0Ll6DtrvUvcqhq9gim+3Y0YzSNYYenN
         Xh0uaI5/fA8UB01kXzaOOTmXD9Bc97UfjMZ5RrjNmn9ReLJHBkhF4ykhtWf4pNu6tD6c
         MtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069246; x=1795674046;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R72tSyuvoCt5/QGm7uguOsGtVeCA2C72cLraw6uBskI=;
        b=N9fDcyWz5US850FkdHC+D9jLZHu4Wt7Eu9c4vp4nQ2vbBgGhKQyj1KwEx3CPwkQ2sG
         vFYWtCrGYSSoJL9+Rik5Nnqletbu46dYAQoY2fqIgX1dxU+73LpW3oj0jhCbOV022P1I
         vmVKc4jybvZa2lfysat762MrlkJCzAQ4H3RZry2w4zyIUW4fhmuR93pyPfFNLSgJ5ch6
         41huJf7kzSx4edg59lrWNRPHcL2gk7tZkvBOCmIz+gQEYo68rkeciRgE2erhQgpXma2Y
         GN3m6Jzr1RQVc1IL7k79eY7OJ/ukA2Wivc+jd1eh+h4KfTRxQqjJDE767Hw53PdCtEk6
         SPfA==
X-Gm-Message-State: APuU4Z+cFMCAt81hjnTz1Tbv4MH5UdLP/zQKUX/8OfqN21wpVqPrJwHc
	imlEIczk3llSC3zrh6e5Z8jyl/eETdg0TdiKSnD7yoOGQo9rYwBkCq+yFoxi3IErn/c8PfXdf5a
	qGl/I1IO1UEPOjjEjwRnjjfm1Zc/WBhHpFZ5wOw2fX/os
X-Gm-Gg: AZFdTZfEtWYfU2KDM48ckNcti0spOwgQbL9+5o3fnQp6hPUUyRBzsV81NzKull/czE7
	2lU72V+3YgGDfVRjCgTaB+WFWCJbkgSemYatTmafxg4VRW1FgOkUNyiuUFQjikkPhcYzd4HTegT
	OORCkm0JPbH+5XT28YhWwrMDsUtduIv6nwm+Vb9yp921luuPiifvDu41zNOi7fxO8ERCgjR3A2g
	Wr428Xklwe75qKFR046PZZG3D8HzN1bbw+Ihp48tyCMKi5wRMtQZX6iLsVwce5omkcBQPK2fE0O
	YciCMXqOnL2nSb8Atzku9eHF5lEtqAcM4Eg50+iDu9gPN04HBqEEwVfVPCm/OTHY0S6qrumJZY8
	vNbLQHobLV1gwXh+uHhwJ0r4tV8tATKf2fh1xtVSheNpH2DywxXr9lIfzdokwkG5lEas38JNxGy
	G1sqnLv28PHT76bDeJUQ==
X-Received: by 2002:a05:6214:8010:b0:921:18e2:4b8 with SMTP id
 6a1803df08f44-92118e205f4mr59170016d6.12.1795069245648; Wed, 18 Nov 2026
 22:20:45 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:20:34 -0500
X-Gm-Features: Aa3M54peGcZ3HW3rbZ6EtpU-sE3Eis0PWV29zDNE9SCTxw0n7cbFv5MbYn1qN6c
Message-ID: <CAMcAce9pi3BwKUAdsfx8GFwMMFx-=-UkkUkqsCDOqbwaL9eSxA@mail.gmail.com>
Subject: [PATCH bpf 2/3] bpf: Fix missing raw_tp_null_args masks for NFS and pNFS
To: bpf@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, linux-nfs@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Audit of NFS/pNFS tracepoint callers against raw_tp_null_args[] reveals
several missing or incomplete argument masks:

  1. pnfs_update_layout (fs/nfs/nfs4trace.h:1990): raw_tp_null_args[]
     currently sets only 0x10000 (arg 4, lo), omitting arg 5 (lseg).
     fs/nfs/pnfs.c passes both literal NULL (:2166, :2177, :2337) and
     ERR_PTR(...) (:2205-2206, :2300-2301) for lseg. Set 0x200000
     (0x2ULL << (5 * 4)) alongside 0x10000 so btf_ctx_access() marks
     ctx[5] as SCALAR_VALUE, preventing both NULL and ERR_PTR
     dereferences even behind a NULL check.

  2. pnfs_mds_fallback_pg_{init_read,init_write,get_mirror_count}:
     raw_tp_null_args[] sets only 0x10000 (arg 4, lo). In
     fs/nfs/flexfilelayout/flexfilelayout.c:1225-1231,
     ff_layout_pg_get_mirror_count_write() returns early whenever
     pgio->pg_lseg != NULL, so trace_pnfs_mds_fallback_pg_get_mirror_count()
     (:1228) unconditionally receives arg 5 (lseg) == NULL.
     pg_init_read (:1128) and pg_init_write (:1201) are likewise
     reached when pgio->pg_lseg == NULL. Update all three to 0x110000.

  3. nfs4_cb_layoutrecall_file (fs/nfs/nfs4trace.h:1520): absent from
     raw_tp_null_args[]. fs/nfs/callback_proc.c:262-267,320 passes
     ino = ERR_PTR(-ENOENT) / ERR_PTR(-EAGAIN) as arg 2 (inode) on the
     out_noput path; TP_fast_assign (:1546) checks !IS_ERR_OR_NULL(inode).
     Add { "nfs4_cb_layoutrecall_file", 0x200 }.

  4. nfs4_test_delegation_stateid and nfs4_test_open_stateid
     (fs/nfs/nfs4trace.h:1119-1120): absent from raw_tp_null_args[]
     while fs/nfs/nfs4proc.c:2910 and :3003 pass literal NULL for arg 1
     (const struct nfs4_lock_state *lsp). Add both with mask 0x10.

Verified in QEMU on x86_64 7.4.0-rc3 (20eef29b7c84) and 6.12.118
when CONFIG_NFS_FS=y and CONFIG_NFS_V4=y (all reproducers flip from
LOADED pre-patch to REJECTED post-patch, including pnfs_update_layout
and nfs4_cb_layoutrecall_file under if (!ptr) scalar enforcement).

Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0044156..ef10af2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7402,13 +7402,16 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "nfsd_file_cons_err", 0x1 },
  /* nfs4 */
  { "nfs4_setup_sequence", 0x1 },
- { "pnfs_update_layout", 0x10000 },
+ { "pnfs_update_layout", 0x10000 | 0x200000 },
  { "nfs4_cb_getattr", 0x200 },
  { "nfs4_cb_recall", 0x200 },
+ { "nfs4_cb_layoutrecall_file", 0x200 },
+ { "nfs4_test_delegation_stateid", 0x10 },
+ { "nfs4_test_open_stateid", 0x10 },
  /* nfs from pnfs_layout_event */
- { "pnfs_mds_fallback_pg_init_read", 0x10000 },
- { "pnfs_mds_fallback_pg_init_write", 0x10000 },
- { "pnfs_mds_fallback_pg_get_mirror_count", 0x10000 },
+ { "pnfs_mds_fallback_pg_init_read", 0x110000 },
+ { "pnfs_mds_fallback_pg_init_write", 0x110000 },
+ { "pnfs_mds_fallback_pg_get_mirror_count", 0x110000 },
  { "pnfs_mds_fallback_read_done", 0x10000 },
  { "pnfs_mds_fallback_write_done", 0x10000 },
  { "pnfs_mds_fallback_read_pagelist", 0x10000 },
