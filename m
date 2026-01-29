Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45837B41F;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=c0xGCYy5BTVDbL9DU3YWcognY9qdx6wJkwSNfPeRQAj0joBC5g+lQiT6cyhIMuRDj+Yci650hDURodqrdhRx1GHjDbnAY3ByM+iDTPCCj78Ol6KV7dPS2WzznckMB2Y55l3/EJF+s8uI9iDkHqnuS2UFh7jLe+Rik5cUPwpwgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=aGtXVSLt63dj+krdfmEJciMSaeT6Bvc5GNuMaIsTXoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNH5mLjRNVkbgo5HWOrJOrthPmnHV1Kb3ZGbFYUjRLwGKYeVdzGIKFuagds+SnxXaAARC7mhkke7Hpb2fYyVBNsSzSj8wQeCCxDJZFqirKs7wOeIMitjhiAbZJ9RpYoFqDGt1i/lL3W6uXbDBFSdDahWwXEZNdxWHtSVxxymNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwUPwuKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwUPwuKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68E0C19421;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674110;
	bh=aGtXVSLt63dj+krdfmEJciMSaeT6Bvc5GNuMaIsTXoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwUPwuKchix0ktaGFZ14BD7+iWe+YGEUESq5oT0WaHhHb6rszMj7fIaXDG9dn3yb8
	 DCU+GP/MdvDwctj36xsGMnzkJY6i73EcapVpFjojhXXx1BsgVLOklXUgfbFYsJoVXf
	 iM3KDxbFQw0+ZQ29a/C4aD3ILPURhu8kDrhMyCQmoXktjOOEL6rqm5WFJ6sclD0QHe
	 mmmogdnoD0jtWSKror7JoHDUsWqaY8eEsdmDYq+lOuonMxmWGKPcNjpDp8rYvlQXQn
	 HVMKOrQ+fk5bKLKQ3RpqEcmCfp5buVAk0q+A20BIEwbWxIfpf3vgVaJmC0uE50nbor
	 ad2VfdLhF2itg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4m-0000000ERMf-2vI7;
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
Subject: [PATCH v3 02/30] docs: kdoc_re: don't go past the end of a line
Date: Thu, 29 Jan 2026 09:07:53 +0100
Message-ID: <6c6504dbc4d78555392db94b93dab711eac83f41.1769673038.git.mchehab+huawei@kernel.org>
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

The logic which checks if the line ends with ";" is currently
broken: it may try to read past the buffer.

Fix it by checking before trying to access line[pos].

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 19e777e2c97e..a0402c065d3a 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -265,7 +265,7 @@ class NestedMatch:
             out += new_sub
 
             # Drop end ';' if any
-            if line[pos] == ';':
+            if pos < len(line) and line[pos] == ';':
                 pos += 1
 
             cur_pos = pos
-- 
2.52.0

