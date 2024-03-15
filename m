Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F154EB22
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532231; cv=none; b=CmDujRyy2k5zO/uAg/CRtPVvJHwnFRF4Yd62pSICREMNta0ddObesNIcUPyinTUzmm0SD6IdosnYpkdm+HYz3CM+N2hLA84TlakD/RyCO0Y4M7STVaWa5cgP9va9hvI9LXftxtxJIKZieDG5v5txpXQt++Rhn0yo0V5pPNL9Hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532231; c=relaxed/simple;
	bh=kuBJD6/3mq7T5AY5lXYVNx9HNSsB7ggRwUYUE9TgG+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3H7nuC2hDFgMcylqF9hXRxoML+rszW/y5yRUJHzjQA7H9Eiz4DOjJbBlwBi81JXKyN6TCsA4w/0dFtrOFjXnI6W6TizZLw5B1tjxW59T2IFm3o07i5ZfVOt0RVpxMos16LFBvzodm0ZY4063C+TkcOdMaKzyye/91CPNGw6ZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=YRV3reO0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ebmK5oze; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YRV3reO0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebmK5oze"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E6A335C01B7;
	Fri, 15 Mar 2024 15:50:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 15 Mar 2024 15:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1710532226; x=
	1710618626; bh=J/JlfyyA9Z9LQpRrMORlAO/4ndkA28VNCpe8u83fFMk=; b=Y
	RV3reO0w9SFuUjR3nafhtWUmEnThxyJzCQYT3OQfAK7LwZ9jQ3xL9oZECNkRWl0W
	PYVcF3ncctwrogdoIDGBJJD2p84slMGx1a4cShOPlLsL4oAjhyKrwNlc/1VkhUEl
	48l0YN7uiSgIyQNGCa/R8nqZMajb5RZ4TXydDOxo02vMv9US/oJ+VTmrCSO1T5PY
	0CQxx8BQREU2ou2SFjjgZSTjYdmqSs9E/Sz1fSJax7Uu1tpYlTCf7O0QNSDfYS94
	MsRRrzsDx8rG2BoRiEIEkyeuOsXO8KS7BcT42ww9jqQAffshZ0j7IdJFIVY9PQdS
	w5XHM3j7e3k08g6+2b+Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710532226; x=
	1710618626; bh=J/JlfyyA9Z9LQpRrMORlAO/4ndkA28VNCpe8u83fFMk=; b=e
	bmK5ozeHqje/oylUOTbaUQAjkWlLk4z7uXnfIZ4gL8kqtKkJebyFGyLM+5j7yskw
	vdbrP3ptjU5zXRxSRoZTEGhuVP9Ar1TiDV90ff45JpTZar0kLeVhNyx3fwHK2IJq
	/WZHWPPIiipiGDX1gbFAliqn7bC3/CddrlmBJ5/hG7A9glUBs/LMgrYG8xv6H9TW
	TmeX02CMulJf5NdMCmvra4HRR/nXoUsr/lwuCVRUps0lWWd1BJgXB3/QDrsafxLt
	zEIyQ0Lel/tXpV3VP9wFxqBcVB7YkmwZMIY+ti+YeQF3wikSJpON+WX8OURYrNGG
	Ijtm3TCnSJXs8g0iR3APw==
X-ME-Sender: <xms:gab0Zdw6iKuNO1vgtwwSvk75j6t2bAUoGpNpKWeSkdhkw5BrVz1fGQ>
    <xme:gab0ZdTTqMAIC0uZ2Yc1e5NK4BHjgjtA9Rd8ohx1E9S2hD5xNePZRqtk-8cA0U9QO
    FHeX1utA3EPtBH_Mw>
X-ME-Received: <xmr:gab0ZXUBA80jUc6gk7_N-BYOaUZilCa4OlKE97JjSEZGLoABXHRirFD844-ZleGM0UqmNj8VahouI3v3khEWubSComcrpc6Pok1q5OlnXKdKKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:gqb0ZfgoVhAnr0pMcIOFNlz9b4z6om33UAQIJDGutZCjJcer8CuPxQ>
    <xmx:gqb0ZfAFYm5sstipX5tFdCKcHhnlCDKy1L0CcfchjjqYMPrprP7zMA>
    <xmx:gqb0ZYLDOCt6_hfG2VpyxlTVuXNaJ7OymUgrmz-n99HnKRutod8Tzw>
    <xmx:gqb0ZeCbR9GqwPgCrDNFuMn-Yat-QWW_2F2SOmJJ5cy9Pfgxg7GBog>
    <xmx:gqb0ZT0xedQN__Z1um6YBbIbLtpKS5NohqdCXiUZ8llELn0NKUFrsQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Mar 2024 15:50:25 -0400 (EDT)
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
Subject: [PATCH dwarves v5 1/2] pahole: Add --btf_feature=decl_tag_kfuncs feature
Date: Fri, 15 Mar 2024 13:48:51 -0600
Message-ID: <58f0a63700a72eba577ff39e3022dffab04104be.1710532093.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710532093.git.dxu@dxuuu.xyz>
References: <cover.1710532093.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a feature flag to guard tagging of kfuncs. The next commit will
implement the actual tagging.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 btf_encoder.c      | 2 ++
 dwarves.h          | 1 +
 man-pages/pahole.1 | 1 +
 pahole.c           | 1 +
 4 files changed, 5 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index e1e3529..850e36f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -75,6 +75,7 @@ struct btf_encoder {
 			  verbose,
 			  force,
 			  gen_floats,
+			  tag_kfuncs,
 			  is_rel;
 	uint32_t	  array_index_id;
 	struct {
@@ -1659,6 +1660,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
+		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index 2393a6c..2a679bb 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -87,6 +87,7 @@ struct conf_load {
 	bool			skip_encoding_btf_vars;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
+	bool			btf_decl_tag_kfuncs;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 2be165d..5ea41ff 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -308,6 +308,7 @@ Encode BTF using the specified feature list, or specify 'all' for all features s
 	                   in some CUs and not others, or when the same
 	                   function name has inconsistent BTF descriptions
 	                   in different CUs.
+	decl_tag_kfuncs    Inject a BTF_KIND_DECL_TAG for each discovered kfunc.
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
diff --git a/pahole.c b/pahole.c
index 0b9c2de..353a080 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1281,6 +1281,7 @@ struct btf_feature {
 	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
 	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
 	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
+	BTF_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.44.0

