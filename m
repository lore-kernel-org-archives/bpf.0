Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755B392C27;
	Mon,  3 Aug 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759333; cv=none; b=qm/DaRzoZvq3Gj8vFZyKuyPhcwXBYbXz9mo7gt7AXfNeDPd2XO1Tb/XHVY8ZG76BRpVNou3q/BpaB0mf0WmUBf1YVEk9KE+9TXMf7MENCb7Wbvkri2iaM/sbAjPDQJNz57J4vICKrP8+6Piv3qdh/JIDZbwOwooT9E6TGaOZepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759333; c=relaxed/simple;
	bh=2n5y7obkLAnf5oBtFkR2gN8H7OTFfUdPsI44hm+1s90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZMx570N9tKHkfF9YGWrvp/m2xe/TnWPdYOHXP+8vdi2cESH87El9K1P07qLDFLLckeWSJJJzuPUWbFgKIRZEgeXCyuZ0CT2N0VBF6u+sJEicl7vP6tps929GcTFfAVS1/KpGDiLgevcdROeMB3zO8NL+RtmJyyBZ2cLVX/3rdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFKPUPrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFKPUPrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F6E1F000E9;
	Mon,  3 Aug 2026 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785759331;
	bh=poueR7DfB9aIGfWVmCWpCQzsUcIx1p6d9MpQRvHzhFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EFKPUPrPVthfkr8KU/etmkk+cysO6CYYC+ELmo719CZWR5PhxFFMQsC5n0aIoxd6X
	 85mn1cl1SvdTx+AkJVZeTWt2+Bg2pd8W6RS1xY3pDFP/c50ZzBbC2WColtvL3ZWLpD
	 jkyj/mVmPKqUvwUbcsNvgLxtR641CCzOcEhQgUGXtLdwj1EjQgTJt4VDGcor321Gj6
	 u7dvmsh6JxE8X6Qqjlz1cdad2sWuhECnWGjX/K2wnoaGXv2flIAWzJ0dEIRPrqFWIp
	 ZOTyBCM0R7d0LdQMI3R2iRIISbftI+I+ypvr307yqDIeCEn+BW2oH/LnsCsa83wx9t
	 G7rvEsyxxxFrA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Aug 2026 14:15:02 +0200
Subject: [PATCH 3/3] binfmt_misc: document the pre-opened interpreter limit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-work-binfmt_misc-interplimit-v1-3-4a2435500bd9@kernel.org>
References: <20260803-work-binfmt_misc-interplimit-v1-0-4a2435500bd9@kernel.org>
In-Reply-To: <20260803-work-binfmt_misc-interplimit-v1-0-4a2435500bd9@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com, 
 mail@johnericson.me, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-f2f85
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2n5y7obkLAnf5oBtFkR2gN8H7OTFfUdPsI44hm+1s90=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQVtIVlPlu66fpst9a3+8UeB+9cvX8e92uvguBznxwkT
 rIV7ovz6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIMlmGv+I7X++6Irt706Zd
 Ny2iD60T5HoY3uffGXWY9z3zfuFjZ2QZGdZu/MS5LIbtE/cs+ZWTpz8SOjxtm8XTo6sk6yIsmue
 feMYNAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Document how pre-opened interpreters are accounted.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 622b5d8c8995..d26b63a27c25 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -128,6 +128,11 @@ There are some restrictions:
    named by an absolute path. It is opened when the binary is executed, so
    a relative one would be resolved against the working directory of
    whoever runs the binary
+ - the amount of pre-opened interpreters by ``F``, or bound to a ``B`` entry
+   is limited by the ``/proc/sys/user/max_binfmt_misc_interpreters`` sysctl. A
+   registration past the limit is refused with ``-ENOSPC``. This limits an
+   unprivileged namespace pinning files. A nested namespace can raise only its
+   own limit and every ancestor is charged too
 
 
 To use binfmt_misc you have to mount it first. You can mount it with
@@ -215,10 +220,9 @@ with the credentials the entry file was opened with, exactly the way ``F``
 pre-opens a static entry's interpreter; the paths must be absolute. The
 path is everything past the first space, so there is nothing it cannot
 express, and no interpreter has to fit in a register string. An entry
-binds at most 100 interpreters; a write past that is refused with
-``-ENOSPC``. To bind a file that has no path of its own - already
-unlinked, a ``memfd``, or reachable only in another mount namespace -
-open it and write ``/proc/self/fd/N``.
+binds at most 100 interpreters, and each one is charged against
+``max_binfmt_misc_interpreters`` like any other binding. A write past either
+limit is refused with ``-ENOSPC``.
 
 The ``load`` program then selects one per exec by name with the
 ``bpf_binprm_select_interp()`` kfunc, and every exec runs a clone of the

-- 
2.53.0

