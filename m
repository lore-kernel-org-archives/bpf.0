Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C752F85
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532227; cv=none; b=Cls1l5dh98ABSqUT2BmNMIVGhy3gAifKDbh/HIl+oqxKYPBumsU5KVejDKg1eBUlMpA5nsyP+kLy30nwjOLdYih9Pw94faEsBtNgZpdzc1THFoANGnBth7L8UPsETC/P02jSmOCGLu7vRvkRmqAyRrBN+xlsP8NTbdtaZpyd6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532227; c=relaxed/simple;
	bh=w+s1nFzo85vcRMzf5sOGZVHXTDJPWKsuWAofiMC4Zsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHvSzXWl6Xqa330qZ3Z/17O34I9Iuy7nYki7OK5ybkINdLxizBdsXvCS72Q6Q+WuMtw2CY2Clske2Dx53naqePTMCYdXuOkl883IyaFmKS0u+qmfaoerpO3D8pKf52xgHayYMVRBo+GdzX8znHeuCqQvodGGn3g6WncNkSbNoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=BPDAmsui; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRQY1OfS; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BPDAmsui";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRQY1OfS"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 0140E5C01B5;
	Fri, 15 Mar 2024 15:50:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 15 Mar 2024 15:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1710532224; x=1710618624; bh=eKtMfbAqsGoGCRC8sZ8v6
	oRV44YJGANHbKqlkxCPfyQ=; b=BPDAmsuiEPa3AbwnT93MN27awgHPaNww3ydPu
	Q+ugdUo9Vi4SE8/iA0Tnlmt2ygHizghCn4oVYd6T/XvzPwdlIeajUtZfPdK8nsuB
	7AfXKqxf317OCtSBXNr2fme+urP6oGC92hBNlYvLOXGtj7jJQQXkh54YviSs5md4
	uOgR4Nx+VW7jj+CVQaajIGD6aK3b9I4Hg105g0P225DpxEkhcWXwX5rDZipKQTwt
	PIp42SNMVduilmktucOK1v4IKnaG6XweSLtxEmuYLnu8QqdM3Dcwm6hOQ9RN1fAM
	34pSj53jnOZwwnaVa3GNpVBrb9JTwPx/bllzFnw+XHUlOUGng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710532224; x=1710618624; bh=eKtMfbAqsGoGCRC8sZ8v6oRV44YJ
	GANHbKqlkxCPfyQ=; b=RRQY1OfSt5OXpd72xC7CoEIACiA64gVHaOOcPyWwiDuu
	Ij5mSDX2xJ0EYUtZQszpyrkzrOmWUiRA+jKpG2j9Ztdg0sOhQhnzXvaKv48zRbS7
	ZfucT/69cK7q8gM+54gIQC69R+llisRJcigddTR0sqwrfXEw4KU5KnzHMBtyA9mT
	zvn0UeSYC3movnrXghL8TKJrdrZVDcwIKhyeUuC0zcWZgggQ8f+aIDIAAUj6h198
	ZT6k3IDH372ktcq+w/emc2NhMiMJuoZWmCHfRhdu9KdFr4FgoElrdSRk6f42v7e9
	6QduYvDITOqBKlm56zwUZMpRUjGJKeFinG+0Xm5rKQ==
X-ME-Sender: <xms:gKb0ZXVjjtzMSlttaDPDu0nqO3ReFF-u7HpODgFAJ5GnxlvPKMbWMg>
    <xme:gKb0ZfmSzUN3Bs07i_uZjJ6Y15Mi9_gbqUXoygrjN0M0LDKXjJTllGTLWw6oCgivM
    jlzq9R2rdP1kuwoUA>
X-ME-Received: <xmr:gKb0ZTaif_ODQUjM3OXs99Cjz-2-1WD76q2o669qpGw1kOjlXnWKmS1-EiC-qyPHM_zLsyDSQ6J8zCelnlepv7eZSS1SJpzXsPswGH_jZ26kKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:gKb0ZSUBwPtqHV3fG_7aj59JJ-p-8qqWWR8CL0dB-R7-Au639r-lgQ>
    <xmx:gKb0ZRl_JxJhvT3m7aUWsRSt1dgM56a1petoZoq9R34kLK1CcExuaA>
    <xmx:gKb0Zfcv9JD8UoKrdgokC1NMl8puV6et3zDP1e6oSBOz6CrbTgBVfg>
    <xmx:gKb0ZbHnYfeqZrbk7oWe_8VBVMedzILzy-Ynbf152tU4F8MQh7GXbg>
    <xmx:gKb0ZT6E08qQZwjoJ37LHk3l4o_FI5wFRimPfB2JSBxSjYkjnNhbiA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Mar 2024 15:50:23 -0400 (EDT)
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
Subject: [PATCH dwarves v5 0/2] pahole: Inject kfunc decl tags into BTF
Date: Fri, 15 Mar 2024 13:48:50 -0600
Message-ID: <cover.1710532093.git.dxu@dxuuu.xyz>
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

Daniel Xu (2):
  pahole: Add --btf_feature=decl_tag_kfuncs feature
  pahole: Inject kfunc decl tags into BTF

 btf_encoder.c      | 370 +++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h          |   1 +
 man-pages/pahole.1 |   1 +
 pahole.c           |   1 +
 4 files changed, 373 insertions(+)

-- 
2.44.0

