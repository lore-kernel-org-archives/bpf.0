Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899914C6511
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358776; cv=none; b=IOUadQ0ENNLWXUy1Gxl2ggdRvI0LRh8zVSgny41cMb7w+RGD71IK+8Hw6VLAptV6OH8XSTR8cZM03ckWexw6QMNjLlK946m+FojZHmThlCeQZ/OcRGFQDpFEgpNamC1SR3Gs2VlBgeTjeDKJ9uqdbNDNYLNrCaCAa8mD/5N9PRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358776; c=relaxed/simple;
	bh=CQjlWbFTdykxIjqaJYYdN44/iBmoWtQRqwt0oS63z/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7GVGBMMW9jQwX/axnk+kCnImE5KHWr+a88CZHDGjuWOevq2SKFPseogIacwJUN3CjCQVU0tgU6xoYzcMAB75Bu1E99QvuJpMveXENdrNswVcxNKvLZhvxfmtixOoGeQRBT8APRFKXLdciwRoaQCKMjd4g7R5/zHNameMB6jcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hS0HdO70; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hS0HdO70"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oHjZG6O0d6oI2e0qM8BnSPWQ+SRkj+omvopuDMBDM9k=; b=hS0HdO708qWbF2f7wNv/FtkLKV
	ODzR/RfG8aSsKiCRyFPORe6WI1fwSJALHXzK2tIL6YK8F5pyf9N6wXZCgEleTxGDZmWtpLodLYCla
	SzfgazMqU42ruK7w2pFDhyEUHhUy3JiPWK96lwloBQrLsvK79LlPYcRjNarWBqH8vNWkvz3psT4A6
	DjTVqoux1nO1IbfLa5zHDy56560022cSM3HPugFxysekrW83hwos3fZf2VSdevpAjHjlqnwg3GMCq
	S6/smqjkUUWRc+MCpqfohAFpoCMsJ9LmDL46mub9mWNvEHAekMvin+p2DEU0re2CKoCb5Xcc9haKv
	aXt1CfDw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6J-000JjX-17;
	Fri, 25 Sep 2026 19:52:47 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 03/16] bpf: Rebase the exception callback subprog when dead subprogs are removed
Date: Fri, 25 Sep 2026 19:52:30 +0200
Message-ID: <20260925175244.1136329-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

adjust_subprog_starts_after_remove() compacts subprog_info[] and the
func_info when whole subprograms are removed as dead code, but leaves
env->exception_callback_subprog alone, so an exception callback declared
through the exception_callback decl tag which sits behind a removed
subprogram keeps its old index. jit_subprogs() then takes the exception
callback from func[] at that index, which is past the end when the
callback was the last subprogram, or another subprogram otherwise.

Rebase the index along with the entries it refers to.

Fixes: b9ae0c9dd0ac ("bpf: Add support for custom exception callbacks")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/fixups.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index e9c2d6c06218..d49c50dae20a 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -506,6 +506,9 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 			 * in adjust_btf_func() - no need to adjust
 			 */
 		}
+		/* The exception callback is live, so it cannot sit inside the removed range. */
+		if (env->exception_callback_subprog >= j)
+			env->exception_callback_subprog -= j - i;
 	} else {
 		/* convert i from "first prog to remove" to "first to adjust" */
 		if (env->subprog_info[i].start == off)
-- 
2.43.0

