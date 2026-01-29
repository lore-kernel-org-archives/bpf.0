Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86337BE80;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=YJkwiLPb6FK9KXHOfpL81KWA+Hnh+N+fgvqpr6trXtkHQJepMJPzPbn9ExwbSAXHXXcz/bkrJ/eq5mtsSNvmBdEBY3CfoQt84WyKgZcuR7Jitlh+nWJnJCP6EYSP/wN5KfMlxi4XEbyIDzhAQQh32vNe88+HHBcdGjL5QTM//vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=kiVn8gJsa15hW54tTb5XhUjmr8gdDA7uMvhSg2gJwFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia8wndbQ9n1vGshpJAWrAaq6G1IyObiIU5bHUBc24ocp24fvdDA2aTzWU0qMLb/bq9DGHPv6gj3UNsgFW1uc5MNSaWlLywpzNC0KsXJMvmvMyn1zNB87dI72/ouJDrfpMUhzvieWGhFfEInEdOqqOxXz5hGaipIZaMdlIZQhK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRYlmWIY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRYlmWIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B56C2BC87;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674110;
	bh=kiVn8gJsa15hW54tTb5XhUjmr8gdDA7uMvhSg2gJwFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRYlmWIYtl28aLBPeHoJLrtt2o7YYwufJtc6iuVkWUG1kcg2h+bx6TSeifimrMMZ3
	 BzFdrpHZGcW/6s6aUTpU0RkDyo8zSxwnHpis+LRZ/mxjt9ealPBK6QJzycW8i2wWDq
	 BT30MVkPtCNpDzaJGD7WSrMaghlK3yjAJhejnKH0pKvkl0nDj79Z3B459sXtxzTlSy
	 addAj/WF4Y9eTx2S0eQjIHvUpXaJro11wnp6U7Dlt00mvx3Bx6TiMR2zasMYB+HT7a
	 Jh9c8Pb/KhBzIQ7+Z76qlHXHkbGDI0Q6HHA+n3/jgQN51dF22SK9plrvInnLeaImDz
	 70bLoCC6p7JCQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4m-0000000ERN7-3mCH;
	Thu, 29 Jan 2026 09:08:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 09/30] docs: kdoc_parser: add some debug for variable parsing
Date: Thu, 29 Jan 2026 09:08:00 +0100
Message-ID: <ea69d87d4de04e3112b893a3a49adda47c6c87fa.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This is a new parser that we're still fine-tuning. Add some
extra debug messages to help addressing issues over there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index cbfdaba39494..ccee4e0bcaab 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1033,11 +1033,19 @@ class KernelDoc:
                 declaration_name = r.group(1)
 
             default_val = r.group(2)
+
+            self.config.log.debug("Variable proto parser: %s from '%s'",
+                                  r.groups(), proto)
+
         else:
             r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
 
             if r.match(proto):
                 default_val = r.group(1)
+
+        if default_val:
+            self.config.log.debug("default: '%s'", default_val)
+
         if not declaration_name:
            self.emit_msg(ln,f"{proto}: can't parse variable")
            return
@@ -1045,6 +1053,9 @@ class KernelDoc:
         if default_val:
             default_val = default_val.lstrip("=").strip()
 
+        self.config.log.debug("'%s' variable prototype: '%s', default: %s",
+                              declaration_name, proto, default_val)
+
         self.output_declaration("var", declaration_name,
                                 full_proto=full_proto,
                                 default_val=default_val,
-- 
2.52.0

