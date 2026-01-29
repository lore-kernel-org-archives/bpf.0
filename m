Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F937C0FD;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=JAK2idPzn32D/6EwW/eiyiu4rIZUyVho3ozNYeqNmg3FG7RVs2HlKa5vqa/kc+K7W+9Bka7AVhmZqr1YaUyO9+y4oQySacga8ZSB2/FLZrQrnopBx+3PCeMplIG0/BHYa4SimgXWleC0358IgWZBqab5gR1hR/h6JN2KjUURp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=MdLnPnAzndL1eoVvG2zTdachsuvtbjqkmlcLwIIe92E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbPJKvECfUROLfgnyu52EHpEKc29UREfrtjBF7icMfXmYXGXecMfJXogiaZiSlMH+C8oaNfV9SiC2gQ03v9+8IAdk52AySJo0Ey+E8sqs4wmu8ZABKg5yCGUetibKPdvt4h1WDRzXChRkWP4cdWSe6XNK0J2ytQ8+4t6qToTJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD+KnSar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD+KnSar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36553C2BCFF;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674111;
	bh=MdLnPnAzndL1eoVvG2zTdachsuvtbjqkmlcLwIIe92E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LD+KnSarsgjUhWoM2nMKrChjT+5gIulUR3mkQ7lI39aVsY4N/pQySzOSxIXQ7TAQ5
	 A9lJpMb+lzu6Obf1eLxQ5sk0mycH2wnJrzMK6UdkiImSHsz2zrPjg9hhoLKGjR27JH
	 Rb8ai7TN2cdj6peYDGZ4hrcrM0bsT1cuynakk/Li4nIzu/aPsisM+9dqKG+BQoLMBD
	 HBozlddnNnUk8/0u8mt2mCAHoOBzM5eBGC1X9uYgzGX1Nx4KZTCbQPL0XUGHDGTeTR
	 fiIyLrCNlonE57axpkc5BenEBcHIb/JV3ZHaaAa4xqL3Zk8bqT3K6lmHBD1BgrZwgE
	 cah5pqypKCMCQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000EROP-1yGx;
	Thu, 29 Jan 2026 09:08:29 +0100
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
Subject: [PATCH v3 29/30] docs: kdoc_re: don't remove the trailing ";" with NestedMatch
Date: Thu, 29 Jan 2026 09:08:20 +0100
Message-ID: <e307c046f3f788021060b5ad0fe996c6c6dfb2e0.1769673038.git.mchehab+huawei@kernel.org>
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

Removing it causes the parse to break some conversions, when
NestedMatch is used on macros like __attribute__().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index a49b42e3d189..294051dbc050 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -358,10 +358,6 @@ class NestedMatch:
 
             out += new_sub
 
-            # Drop end ';' if any
-            if pos < len(line) and line[pos] == ';':
-                pos += 1
-
             cur_pos = pos
             n += 1
 
-- 
2.52.0

