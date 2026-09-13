Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744792E0914
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311162; cv=none; b=ibJ7+/aeeW8YuPDKO0gn2F7txRMw//FZaZ3f+NjVqlfQ4t6kGSKpTtEX9/3SnEjGmcDfWs+ZNJpCxiVeUQTOFhJLZxAbN9d/QSHhOA6KFsDuVVn05ZH7y8RhnheoP14qY+dr2B45U6E/eYTU071h2PC7dGLPXHbh982DbrhutZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311162; c=relaxed/simple;
	bh=jcT+m1wmZBit6I9WNfXxftAtIefRqCJODOruAev6aDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rw3Oo+L6odpaqMC5tgksYcch2gMO9J0hPLkkX1uEs9pfh6+s3Hmx2+YV9TrLUN+XpqWRPDcv/vDsrecoEjTTjO2wdakQcGG3r/4hbvEVtiBYLouaMAZbsZpNlnQnPryUFd2y+VqPs8W0pRFSM06wmuM6AStOQdX3JcFCa8SlsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS0vor/w; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS0vor/w"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2454387a91.3
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311161; x=1789915961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=42MO4wM08RiX2/6kKwVmn4Ivf44yR2gL/oHDBiAl5Jo=;
        b=gS0vor/wApIeb9AKOB/f9yUVQOkJOlG9MROdA1juqZGWdmid/K60QkXKMolmiFVPGI
         WB1qlZKYbAjyUpugCMb3wGx+zIEoeh4bAPwS6fWe8q5yq9ATAsLrSTLMHzRbq8p0wNfb
         8B4ByzCxwsTdEUSA7tqGmuFoSlWG7YR7OATUDPKFWdWNVdb7Z3FSDPUVvPcw4cYSphSa
         +d3wXa1ZzcNiM7uxu/af228jMNO5c4hZIvvvtsmrYx+qVU2ljVs4O2MBk915jPEJrftU
         PRDqM5D2ZslNIhbpyzz1nTs1PSeaugCCnPwjNXpRG4ZamixY4DFkOEa72VW8rZHuGix4
         h7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311161; x=1789915961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42MO4wM08RiX2/6kKwVmn4Ivf44yR2gL/oHDBiAl5Jo=;
        b=caqmsrq9rR6FnzYYetsJwr6TUWdkWzCn6ui9cUK3x9fokWNXcXUhKIcWRiuRko5dGB
         rHd6+sumBTzQfvBiGFvGVOUjep3lp243ntonBQg5DxH7QEZg0dwOICSYqbeaFU1iUkql
         VyJoY88HIdGM7/hnru6ZoWpKaLQMNnt8Jk2WDWY1mDW4Z8XKvWcQzTIU/ysjPHYtpLcd
         6q0ISuFjDJ80XeyXctR54zwgcYE75Wv9An0DYMJI/sgD8zsTz3vLU7IT3AD1AX2G5uWp
         Dsuj2ARjXGu17Uw+9+3VXhDfTUqlFmudrVSVtCjOkQli3J60jS3RkagyR98os106bUis
         QQKA==
X-Gm-Message-State: AFuF++m59u+VBpYQ3+0vUiYib1qOJjdIOF6QJXfQtsxS/xnxn4ci32qh
	aQzD7Mcb+zRXbyZxrg9d56ftl02HWYhA59Zf+C++nPAAISZ3JBvXLyGE1PGcDLKH
X-Gm-Gg: AYBFou1xfn83gvUDp6FzV7+sHCGGcBs9z9gAwoTCwGLIXx2lRLBvGrtk1VPN6aPivL3
	oLiTVHKdTQ8Q8U2KEx3Zj6+hIMeMp3mNcvregPdIGdegDlmThS1CuViYulBT6sxEyn3t4yIvoLj
	zZlRS+FkNQtiBH2A9qe6jwJSYwa5zSZO81Mrfxkfm+ph6qGrpuIx5kzqKN89OU1kyjybmCe7IQo
	0RLjJcuoDJR76TxwGlBQLTeXmNp3vucyq0XBNX3TLmDceRH4oXK2Sv1WiDveWDN80F3vpneeRHr
	vKRw5loDMuAzNHMusqrU+pq/2V8HQ83BDOoH8YmcyjiVasBON51KVNoZqCUKxtGgfF+hUUhZHqt
	fCBEJNuf6dywUkyGGM1XS9XkHH26tl5bdf1xBuEQLko9gNao2bzo2vPVzKownmuuiJJ2MO2lQf7
	z0LcHl/tLrq70YEYwaMp9mbHSjeZnwWv34MKpoQr4UHfS3sPAqcMyGpo1u5fQMCeolqVy9gzvZP
	6fozE1xvPgrQ6fqPAncguXPkJOUOW9ZDgjVdZ4a0yQSbrOCjclJ2xI=
X-Received: by 2002:a17:90a:fc48:b0:39a:e983:d4bd with SMTP id 98e67ed59e1d1-39d9c3527b5mr22685854a91.24.1789311160711;
        Sun, 13 Sep 2026 07:52:40 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm15543544a91.9.2026.09.13.07.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:52:40 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	qmo@kernel.org,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf v2 0/3] libbpf: Validate struct_ops member offsets
Date: Sun, 13 Sep 2026 14:52:30 +0000
Message-ID: <20260913145233.1446643-1-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A local struct_ops type can contain a bitfield absent from the
corresponding kernel BTF type. libbpf checks whether data for an absent
local member is zero.

For a bitfield, member->offset contains the bit position and field width.
bpf_map__init_kern_struct_ops() used the full value to create a data
pointer before checking the member range. libbpf_is_mem_zeroed() could
then read outside the local struct_ops data.
ASan reported a SEGV. bpf_map__init_kern_struct_ops() also failed to check
offsets for non-bitfield members.

Patch 1 rejects local and kernel bitfields before reading member data.
Patch 1 also checks every local and kernel member range before creating a
data pointer.

Patch 2 represents unsupported bitfield storage as padding in generated
skeletons. The padding preserves the struct_ops map and keeps supported
fields at their declared BTF offsets.

Patch 3 checks the bitfield rejection, the generated C structure, and an
out-of-range non-bitfield member.

AI assistance was used in preparing this series. I independently reviewed
the changes and reproduced the issue and fix.

Changes since v1:
- name the local member and the matching kernel BTF type;
- remove JIT, compiler, and initialization details from the problem summary;
- check every offset used to create a data pointer;
- represent unsupported bitfield storage as padding while preserving the
  struct_ops map and supported field offsets;
- test adjacent bitfield members and an out-of-range non-bitfield member.

Link: https://lore.kernel.org/bpf/20260910172340.1467764-1-caomingpei@gmail.com/

Mingpei CAO (3):
  libbpf: Validate struct_ops member offsets before data access
  bpftool: Keep struct_ops field offsets when skipping bitfields
  selftests/bpf: Cover struct_ops bitfield and offset validation

 tools/bpf/bpftool/gen.c                       | 147 ++++++++++++------
 tools/lib/bpf/libbpf.c                        |  80 ++++++++--
 .../bpf/prog_tests/test_struct_ops_module.c   |  91 ++++++++++-
 .../selftests/bpf/progs/struct_ops_module.c   |  17 ++
 4 files changed, 272 insertions(+), 63 deletions(-)

base-commit: 7d70a0b02d262971201fdd1e221586bdd95c2910
-- 
2.43.0
