Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCA37C10A;
	Mon,  8 Jun 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935900; cv=none; b=OJu/PQ+tcRxjRu2E+BjUsl3nEcxrev8mez5qrqyFUdVEl0nfi/L/llnmG3tK7Ay2QAefMnWBm7J2BZz9asg8FeqoA3mSCIAcH8kyDZE6hj+IwJSHN87z0qhO4a9vCp837/1eKK1M3mTZOs3T+jOKtBauCXrZlfXRFQvnjdfTTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935900; c=relaxed/simple;
	bh=BXM/BFTpXoNCSM4CwFdmj+8+KMuxV3hQSRoT1Izhr7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBTO8CGxctIMxSgWBXLecfXTcKiY4z06NbK9wF7XaXh8j94S/otLC7I0x0nhE7EZ4VWK5a4w5mPJIf1FFggwg273ACljS24mi3aAZUsDLqajIw/JkTfhQBTRfr6R/W/8dEb0YBowbEJddtkyXNfGlMloQzlWd+GInN3rpfGRSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ClX++Bnm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ClX++Bnm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=YgzIlvI5ADPZKpxArpAL5pQC0m+dtwWvGtJdhHuopts=; b=ClX++BnmfKd+m+fqtgk0iV5iqW
	dRxWT/cX4mbtX6KpCYj83rCosGS6BpIMJ+ev3NHTAgzEinQPz5BXNo+NAi35wZvOnzCcQDxetM3dP
	yKtJ6ZTey5LmLHkSljnrKnWz6x8cxdpSs7CMfKHCkxNwADny6uVlMCDiOgTRNKRxrmGb+2RO36NLQ
	HodnGLhXI/Cy2kv1jQmpyNtNYPvZoGtETI/aMSjid/BNfxq5WFZs1b1E+NokDgE/022O7UmIAAuKX
	zFzu2mzU2xecV1oK60skUrUN97/TZG/6I7kzDgTEpMSfy3RMMoT6QbtjSSzMbqx179MGmD/918LWg
	RHP/1Puw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWcmX-007kgR-1Y;
	Mon, 08 Jun 2026 16:24:57 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 08 Jun 2026 09:23:59 -0700
Subject: [PATCH v3 2/6] bootconfig: render descendant keys when
 xbc_snprint_cmdline() root has a value
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-bootconfig_using_tools-v3-2-4ddd079a0696@debian.org>
References: <20260608-bootconfig_using_tools-v3-0-4ddd079a0696@debian.org>
In-Reply-To: <20260608-bootconfig_using_tools-v3-0-4ddd079a0696@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, 
 Nicolas Schier <nsc@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=leitao@debian.org;
 h=from:subject:message-id; bh=BXM/BFTpXoNCSM4CwFdmj+8+KMuxV3hQSRoT1Izhr7c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJuzKa68U1lMRfbsTQE3FbGEfTsLSSLEXIa7Af
 MuZF+fPDzKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaibsygAKCRA1o5Of/Hh3
 bRy8D/9KlQx1Pb4wQOVHicCTNfYPZh8apApG6BcWdpBhIr2L33lGNzjUpQuUHK4Vm9KfD+CXOVA
 RIlv1ipVhWhYC3qu1kB34etCPt/9J8k3/7GrDz/5wIdJu2b+IsQxgJwMoca+0XO9zb0xNx2QdIm
 qLvooFICwjeBACSkotGF0Kc5zXIWr1x8i+to2n1BIFU6QLp3qWC7OHzyo35U/o/whjbFAjeC7+t
 V9OPNFdTF9ahu4K9Sffo3RhM1IJ0SnsOPCaDoRF6rxdOocIy4oqfT9txQeqyKzpEJv/4OGaE8hr
 MFuY8kNb/HROJpXk3b1GCff80GWd/mjvUWbBJjRIieAtqSyrmcyJB+MAYbQZ+0Fnm1EypRmkepq
 SunRsrLdZvXT67JDrGSPCwyi3KdU8jyrGj1S933ZbT8+yQZ9FRpXjiQJcSN4T+5pEeAW34no1vG
 WNp7tWVq98sVzRdat/umIixoyHwwA7gNVuNc+3H6SDdayhC0jeFN0/2uPlwlYW6g8+dUavyXhym
 97aXEGzB60NCtvDchwr99j/rPgUjL/VtX0xRrV991d52ASu55JXdoFjrAP5DxFhLFCNfGtbMkfe
 Yjz+W7kh26HZmvfhUqSqoULC6+hlDstxKea8AJC7cH9/EwhXxIFtD179t/cPI3jdE2oGKFZblVT
 ZxwUfRa4M9ErOCA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

xbc_node_for_each_key_value() walks to the first leaf under @root, and
when @root is itself a leaf it yields @root. That happens not only for
an empty "kernel {}" subtree, but also when @root carries both a value
and subkeys, e.g.

	kernel = x
	kernel.foo = bar

Here @root ("kernel") is a leaf because its first child is the value
node "x", so the iterator returns @root first. Feeding @root back into
xbc_node_compose_key_after(root, root) returns -EINVAL, which the only
in-kernel caller papers over with a "len <= 0" check -- but the
follow-up tools/bootconfig -C user propagates the error and turns such
a bootconfig into a build failure. Worse, short-circuiting the whole
call on a leaf @root would silently drop the valid "kernel.foo = bar"
descendant that the pre-existing code rendered.

Skip @root inside the loop instead of bailing out: the value-only entry
is dropped (it is rendered through the "kernel" cmdline path, not here),
while real descendant keys are still emitted. An entirely empty subtree
now renders nothing and returns 0 rather than -EINVAL, matching the
"nothing to render is not an error" semantics expected by the new
build-time caller.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 lib/bootconfig.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 2ed9ee3dc81c..926094d97397 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -440,6 +440,17 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 	 * itself is well defined and returns the would-be length.
 	 */
 	xbc_node_for_each_key_value(root, knode, val) {
+		/*
+		 * An empty or value-only @root (e.g. "kernel {}" or
+		 * "kernel = x", possibly alongside "kernel.foo = bar")
+		 * yields @root itself here. Skip it: composing a key for it
+		 * would fail with -EINVAL, yet any real descendant keys must
+		 * still be rendered. An entirely empty subtree then renders
+		 * nothing and returns 0 rather than an error.
+		 */
+		if (knode == root)
+			continue;
+
 		ret = xbc_node_compose_key_after(root, knode,
 					xbc_namebuf, XBC_KEYLEN_MAX);
 		if (ret < 0)

-- 
2.53.0-Meta

