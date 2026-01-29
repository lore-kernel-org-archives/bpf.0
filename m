Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4037C0F1;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=u6jgVqeeCvwfGYnHtuHw73Swd1owHmwIBECta1BXvsIh9FeVznQIWep+X+PSBJReoHf28jEaoknVDy3PtRd3E2/1Qg5lKjlQNIc2CNqo5AZ94K9rPo1gNFeKWWh9z/5g/zuWXEK5XdP+rs0o/TzU+Lv/MFb797+AAlH4hv6DrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=jXKyTJKBXMc1s7NB0MjWyQ30waz0m2moRL2HWFXUGcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBrkRFGrqQpg6Gtya8LRDlsBrSDmrIt4Se4p1CWFF3cGhD7tqzU94uw49mKNSNq5PjKpwg2lLtiO/wChJsEN67QGNR8PLA013IGoL0bUqDEa9CX7+KeYMijf0TLAj38ztRzmfSjBvyMm/AVOevJQPOJAcYrF5NhMPryeShxaeA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7PkFnqw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7PkFnqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1810FC4AF0B;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674111;
	bh=jXKyTJKBXMc1s7NB0MjWyQ30waz0m2moRL2HWFXUGcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7PkFnqwl2NyEeDLu1PjLukhjjtiF+Ro2e05fbSOt0bbYe/La5snvMsV/XSZp0/kW
	 7tRFxouHgJdH9LNlXIjiRrXisPkCjbjbWU9X1TqnPD/6OWGeQnW+BE9DSIENFTYMF/
	 4S4+ZvgncMp8Y9a3LrLSBQnR6jUE4VacgREmd58LhtEpvytSPSjgZrw9MvJVRAzHad
	 bdu1aKJI4bLQ8C59UsWBAeaFD3L1LyrHoTj93SSsJE3mrYLitlkoBHoa4XSIJKmrm/
	 6a0A8riOd4DXnNvl8SDpJ06A4ULLZT/BFl63zJyP1oHt86G3GO6DqRXRFLKKrrHh2a
	 QuIqETItOATxQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000ERO5-1O5T;
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
Subject: [PATCH v3 24/30] docs: kdoc_re: fix a parse bug on struct page_pool_params
Date: Thu, 29 Jan 2026 09:08:15 +0100
Message-ID: <053367b7bf66f07444b45790db0e2b1998d3a3fe.1769673038.git.mchehab+huawei@kernel.org>
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

The struct page_pool_params definition has a private
definition on it:

    struct page_pool_params {
	struct_group_tagged(page_pool_params_fast, fast,
		unsigned int	order;
		unsigned int	pool_size;
		int		nid;
		struct device	*dev;
		struct napi_struct *napi;
		enum dma_data_direction dma_dir;
		unsigned int	max_len;
		unsigned int	offset;
	);
	struct_group_tagged(page_pool_params_slow, slow,
		struct net_device *netdev;
		unsigned int queue_idx;
		unsigned int	flags;
    /* private: used by test code only */
		void (*init_callback)(netmem_ref netmem, void *arg);
		void *init_arg;
	);
   };

This makes kernel-doc parser to miss the end parenthesis of
the second struct_group_tagged, causing documentation issues.

Address it by ensuring that, if are there anything at the stack,
it will be placed as the last part of the argument.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 858cc688a58f..5f455ffff7b2 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -201,6 +201,9 @@ class NestedMatch:
         """
 
         stack = []
+        start = 0
+        offset = 0
+        pos = 0
 
         for match_re in self.regex.finditer(line):
             start = match_re.start()
@@ -250,6 +253,11 @@ class NestedMatch:
                         yield start, offset, pos + 1
                         break
 
+        # When /* private */ is used, it may end the end delimiterq
+        if stack:
+            stack.pop()
+            yield start, offset, len(line) + 1
+
     def search(self, line):
         """
         This is similar to re.search:
-- 
2.52.0

