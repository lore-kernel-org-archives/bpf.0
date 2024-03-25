Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0A5D8F8
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389257; cv=none; b=PSQwLNOtKF8AnBDMDiSuorRsTmkvXKsdJIfPNTmKmC1B4gQuBd4rj5LtnI8YvPXWsTnkoyHgj7bkaP5yh9nrx9I+d1Kpumpgi9Nfrlq/r8zGnmkIrFHtJ00yQMCtHphLVT36sHQwfHFynUnr2xvDLvXpXiOQr2vusfEcqWOl1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389257; c=relaxed/simple;
	bh=SO/R8KajO9YRpRjoi9S/bz1TVMtn0eWDcykRxFyKDyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLMTUxw7UP8sqT2XyGaojtzCbizN2Apu+Kpw/Ic+TjoL0GdQ9zwnykq0QL7dKEhTPHEl4VFDGSLp9/Z4x5t0drYRdviLXnVOtgBbMOCbxhp5PFUx/GqA4xxPm9OTQFP/d+EFc/qNGnxyyZm5MzBZKIL8vTgqLN75DSzJp0s1e/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=xW5stzsj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xe6/CiHn; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="xW5stzsj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xe6/CiHn"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 8CB035C006E;
	Mon, 25 Mar 2024 13:54:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 25 Mar 2024 13:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1711389254; x=
	1711475654; bh=fzeiH2Hlf+wc9Y8HCph8MoYWAyWmYsDWAiLABgsP08I=; b=x
	W5stzsjHkiQIFKhKDvD1b5qq/SA0991UP3ZM5/My2cSZAHtyPYTJexcnH5cmd28M
	3KNTYD1+nE1yb0d2nnqtEKpXJcr1rDJc4vjuOvRTk4CQ0JXANJixFafnmFRspxst
	V+mrX5vTlmjMV3/Xf/3eozt5JK1rCx+3xol9dMTEE1qWSSoGGGhuxTsKhGnP//2T
	NqTdk3H4uV08Vl2qjlTxz9QUVDDfbmmiReachC6kxKN1KkF6QfP7EBceGQYmfBBu
	s0iNdHmDTGJ/qXgGRTBdx8gUlghTTJjC1Az+f74LRsrlrRoCWcdwo8hLsRiIo7Lb
	pCNw6PR5DWIKMqPiQ3OYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711389254; x=
	1711475654; bh=fzeiH2Hlf+wc9Y8HCph8MoYWAyWmYsDWAiLABgsP08I=; b=X
	e6/CiHnrkoieG3tiTq69M8ylQjGNJV603ltAOwhztMdH6XsArIfatTHgBSYKPPAN
	YnPl8E0AdE+nTdkbwuku8HsX2Pfo7i30EdlyovFqtc+x/B33hJHxuNx8+7eLkjJq
	HWMqu4sWuSAnGmMdY8jpi5lO7KEq/TOmjcsl2WCBzGyn33I7JR36HLdulGH1lQbT
	Wlm02/lCnqEEbw3YqQvOENseVzuA4XJ1tYiARAmOUcwnV3f+ioQtYkovBGSQ4KPC
	H/EzpzzIW710g/j4nha0QkBCnyQ3pBHZAaG82qOPq9XakH/hho+4U6cXp5UXuxBg
	w6YuIq4OPxKLDnX12wJLg==
X-ME-Sender: <xms:RroBZujvJwhaChP2K9xhjKWmAbX3TxkuTz6SFA1dTAFQbK_-JHQZNA>
    <xme:RroBZvCxYfyq_xj3PeLkM8PhOf3EUo482VaDaFzA82Q15NbNnT6kk6ydc9jfgiTAb
    TbWR5q5Efb8xKKqFg>
X-ME-Received: <xmr:RroBZmG7FlyCVVJJvHxxawGM6s-UUNH9SY26RSnE4mza6dIw1jo2OB5puPPTneM8RTdO5o_e0nmfZE0OQz_3QuRB0yaS3cJN7oFcBvmJ63A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:RroBZnRaVsLg-tBOPAH-YXIm9BJkqHhnHRz9UoysTx8rHEIe-BWCbw>
    <xmx:RroBZrx_PIswo0zJmRv1GNasWNYpMjKEevhU5L1i5f9scREa71U81g>
    <xmx:RroBZl7nu-2jO2dCTJ8xF_jcQy0xSzhvHIEKBMpgsJBG5XApTDAGSA>
    <xmx:RroBZoyIJUxTREBxBzE3uzVkiupkY8TFPlXGHXFpp2zDm_QKRHq3-Q>
    <xmx:RroBZik-3w7Cp4W31SIFZA4ARdf7F6xFcHdpoQ6LJGaKZ-z8yQs8GA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 13:54:13 -0400 (EDT)
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
Subject: [PATCH dwarves v6 1/3] gobuffer: Add gobuffer__sort() helper
Date: Mon, 25 Mar 2024 11:53:37 -0600
Message-ID: <ba9ff49e099583ab854d3d3c8c215c3ca1b6f930.1711389163.git.dxu@dxuuu.xyz>
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

Add a helper to sort the gobuffer. Trivial wrapper around qsort().

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 gobuffer.c | 5 +++++
 gobuffer.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/gobuffer.c b/gobuffer.c
index 02b2084..4655339 100644
--- a/gobuffer.c
+++ b/gobuffer.c
@@ -102,6 +102,11 @@ void gobuffer__copy(const struct gobuffer *gb, void *dest)
 	}
 }
 
+void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *))
+{
+	qsort((void *)gb->entries, gb->nr_entries, size, compar);
+}
+
 const void *gobuffer__compress(struct gobuffer *gb, unsigned int *size)
 {
 	z_stream z = {
diff --git a/gobuffer.h b/gobuffer.h
index a12c5c8..cd218b6 100644
--- a/gobuffer.h
+++ b/gobuffer.h
@@ -21,6 +21,8 @@ void __gobuffer__delete(struct gobuffer *gb);
 
 void gobuffer__copy(const struct gobuffer *gb, void *dest);
 
+void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *));
+
 int gobuffer__add(struct gobuffer *gb, const void *s, unsigned int len);
 int gobuffer__allocate(struct gobuffer *gb, unsigned int len);
 
-- 
2.44.0

