Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7B44C646;
	Wed, 26 Aug 2026 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759769; cv=none; b=RWmlvsE3Tl6W+9MoRO4zAPxUgXDSwVF5c7cK1bMOx9gnF7Ucp218GUYfCWfVHtl2ioxY9e4791VL+sKZjcVo3JfnVj3kIlq922gobu/6i21mKtNU6QRkeUiphkizlzZi4kdFuhIQxWiLazsvmexH3IFVqyfMxrghZEU+Pb5BSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759769; c=relaxed/simple;
	bh=PndQPAXcBeOaQi7lJUgei03fmhGSoQt6dZRbXT9rno4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJhu84GZ9+ONUxGy054z0huWgHlhuIDOiBthzZDwffGl6JrwhyvLC1t24aZy5dGz3q+y9B6G6WbOt01MIZizfaLhpIh7lV1zs7VEbjcLs+B1uWOT929QuWpatpEtPNxzVbNv3GNSyhnMnLsoLKAmnFNchjjhZB28G05bxv7t6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VylVp4aL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VylVp4aL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A821F00A3D;
	Wed, 26 Aug 2026 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787759767;
	bh=NKxxVO9WHJPVfrvijFU6xCamxUW5/MUbTlElGx2vOjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VylVp4aLzoj6h2ekemVf7MQp3OCAp7cDjz3M/q4OACcXKDRYDvy3YTMSXZedvDHdk
	 Vj8aZNPn407fWGqDPrwGM3nrGyZi6UHLYS6F4M9SVn5fU3VuUQARqvk3l7Tu98y8X2
	 lWW4duh0K9e3dGo6vWEf/UN18MnESm/QDHE+CxpinZAh66x7MXKkah1PNv6fYLwyVX
	 Y/ghYYGhs+h/T+iVQoa9kiPdH9Ed97Q/eXh7k0OYFBhNb6CExRCy1aZ+0KTIl9ayZy
	 k69T7XjFVLHsN/vGElXQZgh6a6Rdh5nSSRkzAhimlSvxOG1sLMhdt/kJQ9bxxAZTuV
	 YaVDmFik2x6zg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 26 Aug 2026 17:55:48 +0200
Subject: [PATCH 3/3] binfmt_misc: document the field delimiter
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-work-binfmt_misc-delim-v1-3-43618adf8599@kernel.org>
References: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
In-Reply-To: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PndQPAXcBeOaQi7lJUgei03fmhGSoQt6dZRbXT9rno4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT183RbnOWo0riQGX/MUCv02qU6Zu/ZgWYdP2tn9yraz
 l7hq3ymo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKr0hn+Vz/gnMhrvWk933OR
 GRZCL/TE+6UyHM17XXJm6k86cLs5nuF/cHefEaPzp6/5U3OYF51m/JO+5rPMhDCOOjavLkm+8zu
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Document the field delimiter.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index d26b63a27c25..9e84b877d06d 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -19,6 +19,9 @@ To actually register a new binary type, you have to set up a string looking like
 ``:name:type:offset:magic:mask:interpreter:flags`` (where you can choose the
 ``:`` upon your needs) and echo it to ``/proc/sys/fs/binfmt_misc/register``.
 
+The first character of the string is its field delimiter and can be any
+ASCII punctuation character other than the backslash ``\``.
+
 Here is what the fields mean:
 
 - ``name``

-- 
2.53.0

