Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9537C104;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=Pw8GpZIdyp5eMkso9cXhgOhPHA0Hk7OaHBpK0eA01gUSvW7a29fG33kXp+a8zn9IMUHq5R5uhTyLdJ/56ozR/d58u1ooiCnTYbXr65pgSzEnrSvojXvRFP/YaY10JgPCp4H15svuYpK+2nKo0U8C5BQb9RAnL+0daJrN1ZREjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=5IMb08zUAZZvfVWXPYkW/4qcvpNOxc4eEZSFARXvZuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frg14hcQBlAebLT0Udj6YitGakgBc+qeX10/fTrcGeRdMFjVGezgVCk017vck4q3l6su1x3gsJDe5Z5bLjnsbcAOt8CRUF6uqJf4JCMfZ6DTyIEDkxF8n6GuPM3CH71EqGUJrIgUGC5U1f7/jvhHGOVIqLvMY4GSkMfZu5b3Sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdQsPwCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdQsPwCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2207DC2BC9E;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674111;
	bh=5IMb08zUAZZvfVWXPYkW/4qcvpNOxc4eEZSFARXvZuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdQsPwCU87ijJQAvR4bFQKGyfKuTiPXIrfP8nlxqb3ywYjSJv61k2ROvpdRebYQsQ
	 ABZtUOiBDZCpHsKzaWLcBfp2ZXefQ+izcFxzYQ99yaj+nffM7X5FXlaGQVnAbK/CLp
	 LmfjgelLDoPuEDMDekhHRjI6cipt3FcG1Wl3xHKoEJ2XI7mRm8ij5ewcMbHurgHpmS
	 0Pj2A7Lb+VIUKweKzqbb13O4Q68pi4Uvwjr+/shCizR50sNjLOybTe6OU+G+8DJejB
	 1dgaqR3yRPxd1r7i2FySvp2R2lxxpzqRa9h+nx8y3b9QCVM/dYVziKX6YVqt6lN/Gq
	 ObnCqicRTDTqA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000ERO9-1VNv;
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
Subject: [PATCH v3 25/30] docs: kdoc_re: add a helper class to declare C function matches
Date: Thu, 29 Jan 2026 09:08:16 +0100
Message-ID: <9d3d27d956b25921cf40410e59a17a86caef32f6.1769673038.git.mchehab+huawei@kernel.org>
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

Add a more convenient class to match C functions and avoiding
issues at the beginning and ending of NestedMatch inits.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 5f455ffff7b2..a49b42e3d189 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -380,3 +380,14 @@ class NestedMatch:
         """
 
         return f'NestedMatch("{self.regex.regex.pattern}")'
+
+
+class CFunction(NestedMatch):
+    r"""
+    Variant of NestedMatch.
+
+    It overrides the init method to ensure that the regular expression will
+    start with a ``\b`` and end with a C function delimiter (open parenthesis).
+    """
+    def __init__(self, regex):
+        self.regex = KernRe(r"\b" + regex + r"\s*\(")
-- 
2.52.0

