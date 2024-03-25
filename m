Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4235C60D
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389256; cv=none; b=C6w9kcOTGR19sv9DXnhTgNQaEczaaB5DLwOUFKnuH2OIKfVQ57PZu2FUP/ZpbN4k2ZvZjPvzPOZmo/hBxnAZ114EgM79w321LHT1OPT0NCT8da+Ets+8A2cpjR39aM7bin93pu5q/uRfBNmsvnDKICkFlBGPZzVMMUE56aTBte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389256; c=relaxed/simple;
	bh=9bI+biAHhN5+vQiYjJTnKKjCqkkxNKMJzHW563x7XGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCJKS6w0JyfWummz+IIBUthnAVDI+CfgBI9Jq/k318hSZLexSysrRT3FnwiClapoP0vUkcN4LQsw4RV49HX/tNdQZUas29l0fEO8795qn8L0tjCR7siVC70QwLDPUyWL6OAzvLDO3EaofPux9VuHj5hHDJKDYC8zZZYZCBihsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=B+gvwhMj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FxHlW2jD; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="B+gvwhMj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FxHlW2jD"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id A258A5C006C;
	Mon, 25 Mar 2024 13:54:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 13:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1711389253; x=1711475653; bh=2i9HzQY/+nClPvnbHCL4p
	H0BWyZOyBTKpSQlHZtzgAk=; b=B+gvwhMjN1Z1Pt8jiARtH8dJt+3lD1uC2DJP5
	K/JC5DRtUkn8qJAf3UdNfxSNJZBVu2n/bhVETzndAux+xEkI6VH6/03BgDbAht6p
	JUhuTxZrOM0OjGgZR8WA90nKCHk+detutp2h5HoNirJIBqGbSkd/Vez2WLX+u6JB
	jjBKorMLv5hp5GTHv/UjJstzhbmOYWFW+/7749Wcwg8uWbUPMX1TSLlSKetb/q7K
	AqqdvVLz2kRgLKPfdG74L9o7RyJXy7yX+b96edZF/m2xqYsx4n9+TdApbd43SKx+
	LDAz+D+YrGXntcwdQXiphTFGFtke3XIfy9w4CuodGslb8RYwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711389253; x=1711475653; bh=2i9HzQY/+nClPvnbHCL4pH0BWyZO
	yBTKpSQlHZtzgAk=; b=FxHlW2jDcJ3ZIZe7ud4LMmpPm5MZzpPnGPqovLzSF1Hq
	BDyXH9/G9SkTGzZmNjSkKw8hesU6vPai+z2olHsgntnWFbJXZvL8/bHMJfakV8k+
	9ywMERpNST3SUSl3hn5SHXs9PH570zkf4R5zyhK3boTq30LJ47tvNAZGmJM8AgJu
	8XfQe33gGv21HNUcI77vkCbrxispXzDhjOou5WXmCPHrM1O+dA7uq8TI3oZzJhof
	04i80cMN183Q8WABCC5zIwjjgEg3xxCOawhwyAvB+StCh/KPdcvYXA/RX2zREKUp
	3t7UQRbtDJWaPiAMoMlcS6gaicRTV31OIN/mECoQ5g==
X-ME-Sender: <xms:RboBZqDO_4Uz2sOGj3n4mLUaCYW8GVZPXxS46hG8wsZ-sZWsVjC5DQ>
    <xme:RboBZkjWBGUiF_MXKOHDCnNFDLQXySOpVdf2gBqOBxavrou_SLjdpWE-wIccJ8cuA
    biHdsZBVAUZsmKJ8A>
X-ME-Received: <xmr:RboBZtlEVE03PAWNQ6YWjLqOvpR0NzBy6Lk0gi_yB8L8ebquuDZ1CVJ3GywL0HsWJX6hiylhdXcf3XubAjaIZOVwX1fvoMcS23v2G75FdLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:RboBZoyyq42xb4eEJetWBl0H2rhMh8U1V-fHZwjTZMgcvZrOHEeZXQ>
    <xmx:RboBZvSR2NH5USaCjOfFGxLoAgRUm9_rK257RmgbF5bS72yKZ6l8gg>
    <xmx:RboBZjb5LZKvDvyRJML_zNTuNNnkTvSCGzncUZSrI2LFTxqkfIvGYg>
    <xmx:RboBZoQx348vtWIM-q2JTCZH_GzsTq0hgAo1hIJpIttiXJ_ngzw0HA>
    <xmx:RboBZqEV8hTvweJwfMcG4Mu0RwAx3ZB96SbnJfWHXw1MpV9iubkEXg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 13:54:12 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v6 0/3] pahole: Inject kfunc decl tags into BTF
Date: Mon, 25 Mar 2024 11:53:36 -0600
Message-ID: <cover.1711389163.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset teaches pahole to parse symbols in .BTF_ids section in
vmlinux and discover exported kfuncs. Pahole then takes the list of
kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.

Example of encoding:

        $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
        121

        $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
        [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
        [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1

This enables downstream users and tools to dynamically discover which
kfuncs are available on a system by parsing vmlinux or module BTF, both
available in /sys/kernel/btf.

This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.

=== Changelog ===

Changes from v5:
* Add gobuffer__sort() helper
* Use strstarts() instead of strncmp()
* Use uint64_t instead of size_t
* Add clarifying comments for get_func_name()

Changes from v4:
* Update man page with decl_tag_kfuncs feature
* Fix release mode build warnings
* Add elf_getshrstrndx() error checking
* Disable tagging if decl_tag feature is off
* Fix malformed func name handling

Changes from v3:
* Guard kfunc tagging behind feature flag
* Use struct btf_id_set8 definition
* Remove unnecessary member from btf_encoder
* Fix code styling

Changes from v2:
* More reliably detect kfunc membership in set8 by tracking set addr ranges
* Rename some variables/functions to be more clear about kfunc vs func

Changes from v1:
* Fix resource leaks
* Fix callee -> caller typo
* Rename btf_decl_tag from kfunc -> bpf_kfunc
* Only grab btf_id_set funcs tagged kfunc
* Presort btf func list

Daniel Xu (3):
  gobuffer: Add gobuffer__sort() helper
  pahole: Add --btf_feature=decl_tag_kfuncs feature
  pahole: Inject kfunc decl tags into BTF

 btf_encoder.c      | 374 +++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h          |   1 +
 gobuffer.c         |   5 +
 gobuffer.h         |   2 +
 man-pages/pahole.1 |   1 +
 pahole.c           |   1 +
 6 files changed, 384 insertions(+)

-- 
2.44.0

