Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590874424
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389258; cv=none; b=eKaVaItVNyiGe1l8YpbRXx/2ISO27TejcZlO7tNfRdLXTnjHv8LUY5g6oG2VQCQaGbxys+nfAD2wiJc9wbqnULUwe5HFgpyu800aMrW+aDbz3y6zxnqhFNzuiVIqSljA6hCqb50pJAiF8O11kjbPk1taYj8LavbEWgM3iDdz6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389258; c=relaxed/simple;
	bh=kuBJD6/3mq7T5AY5lXYVNx9HNSsB7ggRwUYUE9TgG+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4lVi84YAQGAb/NVdc+wj0wY1hXexvoGmM4mwBntBm7l3mLP0RGaUQggQhW4xPelV4D17uIiTDnSNoKbi9dNT/87AU0nLMPiwl/QXA7FLw2Ef2IcM+HsLcutgzspCSBWzlx+uC/XWS9GLAuNWd87IA1cw/S6oSjfeMqjR0vAEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=iHNW6gVD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTIhszNX; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="iHNW6gVD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTIhszNX"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 946525C006D;
	Mon, 25 Mar 2024 13:54:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 13:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1711389255; x=
	1711475655; bh=J/JlfyyA9Z9LQpRrMORlAO/4ndkA28VNCpe8u83fFMk=; b=i
	HNW6gVDRIiN3QmwNwKgJecV/Lx3v2KIgXgAolw9UhxzJ2UMElhyXTLOHSpC/OpQU
	Oe9+m0HNOBGNOlMpe0yKM/et8nWt8xHnhvRS7zLbWwnHp9eSVQ3RoFEPTUWcSc5W
	Bu+X0BlQDTVAQj1l0ofBUBcfECtk00ggKqVkoILhiNOZGAF9jsoS89kwRR6cgczw
	3bBMGc/nGLtvDuOjEwANyQXcwKKgVHYARA7FZDeL9p/ZtKZKXUG63WKTYna4+uiZ
	Ba5WetIBQlqpJnUhzpht7YGVT8wiMuBzFJv4LIUcLkmG+jNLWqt2VW0wWhLLyLmR
	SaJrQY8RLOE6+phI5JrTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711389255; x=
	1711475655; bh=J/JlfyyA9Z9LQpRrMORlAO/4ndkA28VNCpe8u83fFMk=; b=D
	TIhszNX4EnBGOqahEYsnYLdZIgrl+8Qkq11JcbNon7oyuXnvt/TXEe7VFrc8xzTf
	Z8nNCP95KirJo0y46sUN0qJ8vffVYul0rixjSnoB0z/upwGcMRenEaztxal81J+L
	dhv+1AnSPeSttgn4QVsGiAqwj/Dmpd4fplZwD3037LMUTXS3qgbvsD9R8CinyDNe
	WMwbqiDpcMLYVWs3c+kHPEC8OUBnTnqmV9iWzOCxoLeCqCDUCJvLnf1R69vB/r+L
	tpP7ENSMU1f98LElAe/q1ZfUXEQmpqZbs7QBfBor3tAXN8prV2YJGodxknQrNHMo
	FCn1k7G9JbBp7P4bualAg==
X-ME-Sender: <xms:R7oBZn7be47y2neURaKkOhSabquvoOqvqf0O7Yrws0VWmyevSoxcpw>
    <xme:R7oBZs7EDdbfCvs797O7aDGrnwFfk8wY6vCoiWacRahuT4v-AsRBzjy6BkBT88oD_
    ecKylVlcF6mHhoEjA>
X-ME-Received: <xmr:R7oBZuc39oujagmGN9p-edqLUA1uH7utc8bqPyH9w4nhMrgeXTdDzcmiTVp94KTDXbpa2IY83Sd1-2U1aoTwpNist4leZKrjUYfBaypDH_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:R7oBZoLD5u3noLYIMyKasWfIxZA2fUFj9FgmssDQqYM1dEZTqgbplA>
    <xmx:R7oBZrLOA9OTZAnLkbjL2gFR_PyeRK58SiiblAnyypz7Rfws1VRCVA>
    <xmx:R7oBZhyKUa3564lCDRHiWMNR0dVsKZmFoK6VH89-UrkmDLPhJLqi2g>
    <xmx:R7oBZnKHOhqcrMk2juIp6CA2OH9p8SUwqH7_amx2I6dxLhGLmjOuig>
    <xmx:R7oBZi_oTqJnM9_kYj7sixdyaAjK3Vb-MObU1X1ttNH0emsvWJm8jw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 13:54:14 -0400 (EDT)
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
Subject: [PATCH dwarves v6 2/3] pahole: Add --btf_feature=decl_tag_kfuncs feature
Date: Mon, 25 Mar 2024 11:53:38 -0600
Message-ID: <8a10fa4a067a382cecba722c91e6a8780ff4159c.1711389163.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711389163.git.dxu@dxuuu.xyz>
References: <cover.1711389163.git.dxu@dxuuu.xyz>
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

